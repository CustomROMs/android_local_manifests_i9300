import os
import argparse
import subprocess

def create_remote(repository_path, remote_url, branch):
    subprocess.run(['git', '-C', repository_path, 'remote', 'add', 'remote', remote_url])
    subprocess.run(['git', '-C', repository_path, 'fetch', 'remote', f'{branch}:refs/remotes/remote/{branch}'], check=True)

def is_shallow_clone(repository_path):
    shallow = os.path.join(repository_path, ".git/shallow")
    return os.path.exists(shallow)

def unshallow(repository_path, remote_url, branch):
    subprocess.run(['git', '-C', repository_path, 'fetch', '--unshallow', 'remote', f'{branch}:refs/remotes/remote/{branch}'], check=True)
    subprocess.run(['git', '-C', repository_path, 'fetch', '--unshallow', 'losul', f'{branch}:refs/remotes/losul/{branch}'])

def prepare_patches(repository_path, remote_url, branch):
    create_remote(repository_path, remote_url, branch)
    if is_shallow_clone(repository_path):
        print("Repository is a shallow clone. Unshallowing...")
        output = unshallow(repository_path, remote_url, branch)

    subprocess.run(['git', '-C', repository_path, 'fetch', 'remote', f'{branch}:refs/remotes/remote/{branch}'], check=True)

    merge_base_output = subprocess.run(['git', '-C', repository_path, 'merge-base', 'HEAD', f'remote/{branch}'], capture_output=True, text=True, check=True)
    merge_base = merge_base_output.stdout.strip()

    commits_output = subprocess.run(['git', '-C', repository_path, 'log', f'{merge_base}..remote/{branch}', '--format=%H', '--reverse'], capture_output=True, text=True, check=True)
    commits = commits_output.stdout.strip().split('\n')

    output = f'{repository_path} cherry-pick {" ".join(commits)}'

    return output

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('repository_path', help='Path to the repository')
    parser.add_argument('remote_url', help='URL of the remote repository')
    parser.add_argument('branch', help='Branch to fetch from the remote repository')
    args = parser.parse_args()

    output = prepare_patches(args.repository_path, args.remote_url, args.branch)

    print(output)

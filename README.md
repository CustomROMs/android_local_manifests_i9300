LineageOS
===========

Getting started
---------------

```
1. mkdir -p LOS15 && cd LOS15

2. Initialize your local repository using the LineageOS trees with a command
  repo init -u git://github.com/LineageOS/android.git -b lineage-15.1
  
3. Clone this repo:
  git clone https://github.com/CustomROMs/android_local_manifests_i9300 -b lineage-15.1 

4. Copy local manifest (local_manifest.xml)
  mkdir -p .repo/local_manifests
  cp android_local_manifests_i9300/local_manifest.xml .repo/local_manifests/

5. Sync LineageOS trees:
  repo sync --no-tags --no-clone-bundle --force-sync -c -j8

6. Apply patches to the newly synced sources:
  . build/envsetup.sh
  bash android_local_manifests_i9300/fetch.sh
  bash android_local_manifests_i9300/apply.sh

7. Generate the keys used for ROM signing:

From the root of your Android tree, run these commands, altering the subject line to reflect your information:

subject='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'
mkdir ~/.android-certs
for x in releasekey platform shared media testkey; do \
    ./development/tools/make_key ~/.android-certs/$x "$subject"; \
done

8. To build:
  . build/envsetup.sh
  lunch lineage_i9300-userdebug
  make -j8 bacon
```

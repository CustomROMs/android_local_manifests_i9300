LineageOS
===========

Getting started
---------------

```
1. mkdir -p LOS17 && cd LOS17

2. Initialize your local repository using the LineageOS trees with a command
  repo init -u git://github.com/LineageOS/android.git -b lineage-17.1
 
3. Clone this repo:
  git clone https://github.com/CustomROMs/android_local_manifests_i9300 .repo/local_manifests -b lineage-17.1

4. Sync LineageOS trees:
  repo sync --no-tags --no-clone-bundle --force-sync -c -j8

5. To build:
  . build/envsetup.sh
  lunch lineage_i9300-userdebug
  make -j8 bacon
```

nycmeshfeed
===========

Quick start docs are here. Detailed docs are [here](docs)

Quick Environment Setup
-----------------------

In case you don't have these tools already type (if you're in debian):  
'''
apt-get install git make gcc g++ zlib1g-dev libssl-dev wget subversion file python apt-utils binfmt-support \
vim apt-file xz-utils sudo subversion zlib1g-dev gawk flex unzip bzip2 gettext build-essential libncurses5-dev \
libncursesw5-dev libssl-dev binutils cpp psmisc docbook-to-man gcc-multilib g++-multilib 
'''

If you are on Mac use brew. 

This is the start of the nycmesh openwrt / qmp feed, to make building easier
```
git clone git://qmp.cat/qmpfw.git qmp-3.2-rc3
cd qmp-3.2-rc3
git fetch --tags
git checkout tags/v3.2-rc3
QMP_GIT_BRANCH=v3.2-rc3 make checkout
cd build/qmp && git checkout -b v3.2-rc3 && cd ../..

echo "src-git nycmeshfeed https://github.com/nycmeshnet/nycmeshfeed.git" >> ./build/openwrt/feeds.conf
./build/openwrt/scripts/feeds update -a
./build/openwrt/scripts/feeds install -a
```

A step by step explanation of the above is [here](docs/quickstart_explained.md)

Quick Start Build
-----------------

NYCMesh Feed is build using the [qMp](http://www.qmp.cat/) build system.
For details, see: [docs/architecture.md](docs/architecture.md)

Build example:
```
make T=nsm5 build
make T=nsm5 post_build

# image will be in images/
```
This will take a while, but the build system has a parallelization feature,
which is detailed in [docs/building.md](docs/building.md)

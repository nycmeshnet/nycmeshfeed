## Old Instructions to be cleaned up

Quick start docs are here. Detailed docs are [here](docs)

### Quick Environment Setup

In case you don't have these tools already type (if you're in debian):  
```
apt-get install git make gcc g++ zlib1g-dev libssl-dev wget subversion file python apt-utils binfmt-support \
vim apt-file xz-utils sudo subversion zlib1g-dev gawk flex unzip bzip2 gettext build-essential libncurses5-dev \
libncursesw5-dev libssl-dev binutils cpp psmisc docbook-to-man gcc-multilib g++-multilib 
```

If you are on Mac, use brew. 

This is the start of the nycmesh openwrt / qmp feed, to make building easier
```
export VERSION=3.2.1

git clone git://qmp.cat/qmpfw.git qmp-$VERSION
cd qmp-$VERSION
git fetch --tags
git checkout tags/v$VERSION
QMP_GIT_BRANCH=v$VERSION make checkout
cd build/qmp 
git checkout -b v$VERSION
cd ../..
echo "src-git nycmeshfeed https://github.com/nycmeshnet/nycmeshfeed.git" >> ./build/openwrt/feeds.conf
./build/openwrt/scripts/feeds update -a
./build/openwrt/scripts/feeds install -a

```

A step by step explanation of the above is [here](docs/quickstart_explained.md)

### Quick Start Build

NYCMesh Feed is build using the [qMp](http://www.qmp.cat/) build system.
For details, see: [docs/architecture.md](docs/architecture.md)

Build example:
```
export TARGET=nsm5-xw

# select qmp-nycmesh from qmp submenu of this command:
make T=$TARGET menuconfig

make T=$TARGET build

# image will be in images/
```
This will take a while, but the build system has a parallelization feature,
which is detailed in [docs/building.md](docs/building.md)
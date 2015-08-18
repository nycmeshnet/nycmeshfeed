# nycmeshfeed
This is the start of the nycmesh openwrt / qmp feed, to make building easier

git clone git://qmp.cat/qmpfw.git qmp-3.2-rc3
cd qmp-3.2-rc3
git fetch --tags
git checkout tags/v3.2-rc3
QMP_GIT_BRANCH=v3.2-rc3 make checkout
cd build/qmp && git checkout -b v3.2-rc3 && cd ../..

echo "src-git nycmeshfeed https://github.com/nycmeshnet/nycmeshfeed.git" >> ./build/openwrt/feeds.conf
./build/openwrt/scripts/feeds update -a
./build/openwrt/scripts/feeds install -a

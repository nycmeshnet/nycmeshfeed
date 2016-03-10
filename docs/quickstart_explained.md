Quick Start Explained
---------------------

This document will walk through the quick start instructions,
explaining each step along the way. Explantions will be brief,
with references to further documentation.

Recommended background reading: [architecture](architecture.md)

Environment Setup Explained
---------------------------

```
git clone git://qmp.cat/qmpfw.git qmp-3.2-rc3
cd qmp-3.2-rc3
```
Clone the qMp repository and move there. NYCMesh is an extension to qMp,
using the qMp build system.

_todo: add explantion about qMp and configuration/extension_


```
git fetch --tags
git checkout tags/v3.2-rc3
```
This ensures that we're working on the released tag.


```
QMP_GIT_BRANCH=v3.2-rc3 make checkout
```
_todo: add ref to qmp build system docs, explain branch checkout via qmpfw_
Explanation forthcoming. Relevant upstream doc is here: http://qmp.cat/Development


```
cd build/qmp && git checkout -b v3.2-rc3 && cd ../..
```
_todo: explain branch alignment here_


```
echo "src-git nycmeshfeed https://github.com/nycmeshnet/nycmeshfeed.git" >> ./build/openwrt/feeds.conf
```
_todo: explain feeds here_
Explanation forthcoming. Relevant upstream doc is here: https://wiki.openwrt.org/doc/devel/feeds


```
./build/openwrt/scripts/feeds update -a
./build/openwrt/scripts/feeds install -a
```
_todo: quick explanation_

Explanation forthcoming. Relevant upstream doc is here: https://wiki.openwrt.org/doc/devel/feeds#install and here: https://wiki.openwrt.org/doc/devel/feeds#update


Build Explained
---------------

```
make -T=nsm5 build
make -T=nsm5 post_build
```
_todo: explain build targets, qmpfw system commands_


Next Steps
----------

For more information about building, check out [building](building.md)

For more information about NYCMesh Feed source code, check out (files)(files.md)

For more information about general concepts, check out (resources)[resources.md]

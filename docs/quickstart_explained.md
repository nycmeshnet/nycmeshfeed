Quick Start Explained
---------------------

This document will walk through the quick start instructions,
explaining each step along the way. Explanations will be brief,
with references to further documentation.

Recommended background reading: [architecture](architecture.md)

Environment Setup Explained
---------------------------

```
git clone git://qmp.cat/qmpfw.git qmp-3.2-rc3
cd qmp-3.2-rc3
```
Clone the [qmpfw](http://dev.qmp.cat/projects/qmp/wiki/Qmpfw)
repository and move there.

qmpfw is the official build tool for qmp, on which nycmeshfeed is based.
The above command names the repository qmp-3.2-rc3 for simplicity, since
that's what we'll be building (with modifications) using qmpfw.


```
git fetch --tags
git checkout tags/v3.2-rc3
```
This ensures that we're working on the relevant released tag...
avoiding surprises.


```
QMP_GIT_BRANCH=v3.2-rc3 make checkout
```
The qmpfw system uses `make` as its front end. This command clones and checks
out the relevant branch of qmp proper. It also does some other bookkeeping
to sets up the build environment.

A general explanation of qmpfw commands is here:
http://dev.qmp.cat/projects/qmp/wiki/Qmpfw


```
cd build/qmp && git checkout -b v3.2-rc3 && cd ../..
```
After running the qmpfw checkout, the qmp repository is in a detached state.
This makes a local branch for the qmp checkout and then backs out to the top
level.

A detailed explanation of this is here:
http://dev.qmp.cat/projects/qmp/wiki/Environment


```
echo "src-git nycmeshfeed https://github.com/nycmeshnet/nycmeshfeed.git" >> ./build/openwrt/feeds.conf
```
This is where the NYC Mesh feed is injected into the project, so that
the build will have our customizations. (This adds the feed to the list of
feeds for the openwrt build.)

Very short explanation:
- qmp is built on openwrt
- nycmeshfeed is built on qmp

This is explained more thoroughly in [architecture](architecture.md)

An explanation of openwrt feeds is here:
https://wiki.openwrt.org/doc/devel/feeds


```
./build/openwrt/scripts/feeds update -a
./build/openwrt/scripts/feeds install -a
```
This updates and installs the feeds, including nycmeshfeed now.
See the step above for a quick discussion of feeds in openwrt with
some references.

The specific commands used here are documented at:
- https://wiki.openwrt.org/doc/devel/feeds#update
- https://wiki.openwrt.org/doc/devel/feeds#install


Build Explained
---------------

```
make T=nsm5 build
make T=nsm5 post_build
```

qmp (and openwrt) support a number of hardware targets, which are specified
for qmpfw via the `-T=target` flag. You can see all the targets by issuing
`make list_targets`.

More information about the targets is in `targets.mk` at the top level.

NYC Mesh is concerned with a smaller set of targets, however. The above
example command builds the `nsm5` target, which is for the
Nanostation M5.

The `build` step does the building. The `post_build` step moves the resulting
images into `images/`. The build is fairly resource hungry -- more info
about parallel builds and such is available in [building](building.md).


Next Steps
----------

For more information about building,
check out [building](building.md)

For more information about nycmeshfeed source code,
check out [files](files.md)

For more information about general concepts,
check out [resources](resources.md)




Building
--------

In order to build the image, you need to choose a hardware target.
All of the available targets can be printed by issuing `make list_targets`.

There is a fair amount more information in `targets.mk` at the top level,
however, including human-readable names.

_todo: list main targets for NYC Mesh_

Parallel Builds
---------------

The qmpfw build system accepts the `J` config to parallelize the
build process. If you have 4 cpus, for instance, you might issue something
like `make T=nsm5 J=4 build` to fully use your resources.

This may make it difficult to use your machine for other tasks, however,
especially with regard to io. See the next section for some options there.

Relevant docs from qmp are here:
http://dev.qmp.cat/projects/qmp/wiki/Qmpfw

Nice Builds
-----------

_n.b. This is GNU-Linux specific for now.
Contributions for other osen most welcome._

To keep your system responsive, at the cost of longer build times,
you can use `ionice` and `nice` to restrict the build process to
idle resources.

The following suggestion is from the [openwrt dev site](https://wiki.openwrt.org/doc/howto/build):
```
ionice -c 3 nice -n19 make .....
```

In brief:
- `ionice -c 3` gives the process only idle io resources.
- `nice -n19` gives the process the last priority for scheduling.



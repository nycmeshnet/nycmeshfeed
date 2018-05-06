# NYC Mesh Firmware

## Project Overview

[nycmeshfeed](https://github.com/nycmeshnet/lime-sdk) (this repo) - We currently use this LEDE package feed to force an updated version of tinc (tinc-1.1pre15) into our firmware images. We are also keeping firmware documentation here for the time being.

[lime-sdk](https://github.com/nycmeshnet/lime-sdk) - Repo cloned from the libremesh build system.  It builds the base image. Currently the nycmesh branch contains the following mods
* .drone.yml - current steps to build and publish images
* feeds.conf.default.local - contains the link to this repo to add tinc to the liremesh build
* options.conf.local - points the communities customization to you fork of the repo
* libremesh.sdk.config.local - contains the CONFIG_PACKAGE for tinc from this repo

[network-profiles](https://github.com/nycmeshnet/network-profiles) - Repo clone from libremesh. Part of the build step specifies what network profile to add on top of the image.
There's a nycmesh branch that contains nycmesh.net folder which containers common-qmp-compat which is our current libremesh 
profile that works with legacy qmp images

## Building

Our build process is intended to run on Linux. Make sure that you have the following installed:

* [Docker](https://www.docker.com/)
* [Drone Cli](http://docs.drone.io/cli-installation/)

Building occurs in the lime-sdk repository's root directory. Prepare your build environment by cloning lime-sdk.

```bash
git clone git@github.com:nycmeshnet/lime-sdk.git
cd lime-sdk
git checkout nycmesh
```

We use Drone for continuous integration. It is a build system which uses Docker and is also the simplest way to start building firmware images in your environment.

To build all platforms we currently release (listed in .drone.yml):

```bash
drone exec
```

### Building for a new device

Warning: This territory is for developers. If you are uncomfortable with the possibility of bricking your router, it is always best to obtain a device we officially support.

#### 1. Learn about your device

Discover which chipset your device uses and if it is supported by our underlying operating system, OpenWRT/LEDE. Look up your device on OpenWRT/LEDE's WIKI. If you cannot find it there, search for it on Google to learn what chipset. WikiDevi is a good resource. 

We will use the GL.inet GL-MT300A as an example in this guide.

It looks like LEDE has [a WIKI page for our example device](https://wiki.openwrt.org/toh/gl-inet/gl-mt300a), listing it as supported. Great.

#### 2. Determine your device's build target and profile

Our builds use a shell script called cooker. List possible targets in our current LEDE release by executing:

```bash
./cooker --targets
```

Our device's WIKI page has a Hardware section which lists "ramips" as a target. (our chip is a Ralink MIPS target branded as Mediatek, since Mediatek aquired Ralink)

To list the profiles (devices, chipsets) available for your target, execute ```./cooker --profiles=(YOUR TARGET)```. In our example, this is:


```bash
./cooker --profiles=ramips/mt7620
```

There is a profile is named ```gl-mt300n```, and according to its details it also supports the GL-MT300A variant of the device.

#### 3. Build your firmware

To build, replace TARGET and PROFILE in the following command:

```bash
./cooker -c TARGET --profile=PROFILE --flavor=lime_default --community=nycmesh.net/common-qmp-compat
```

The simplest way to build is to use Drone.

Edit ```.drone.yml``` and comment out the cook_ sections of firmwares you are not interested in building.

Add a section to drone's config for your new build. Determine the build command

```yml
  cook_custom:
    image: josmo/nyc-mesh-cooker
    environment:
      - J=6
    commands:
      - ./cooker -c ramips/mt7620 --profile=gl-mt300n --flavor=lime_default --community=nycmesh.net/common-qmp-compat

```

Once ```.drone.yml``` has the above configuration, start your build by executing ```drone exec```.

If you have OpenWRT/LEDE's SDK installed in your development environment, you can build without relying on Drone by simply executing the cooker command.

#### 4. Flash your device

If your build succeeded, you will find your custom firmware in the "output" directory. For our example, the resulting firmware file which can be flashed to the device is:

```output/ramips/mt7620/gl-mt300n/lime_nopp/lede-17.01.4-nycmesh.net-common-qmp-compat-ramips-mt7620-gl-mt300n-squashfs-sysupgrade.bin```


### Experimental: Building on macOS

Building our firmware requieres a case sensitive file system. We recommend building inside a Linux VM if on a default macOS case-insensitive installation.

This following is not confirmed to work, however if you don't want to build inside a VM on macOS you can try building within a mounted case sensitive disk image.

```bash
hdiutil create -size 20g -type SPARSE -fs "Case-sensitive HFS+" -volname OpenWrt OpenWrt.sparseimage
hdiutil attach OpenWrt.sparseimage
cd /Volumes/OpenWrt
```
and then try the above commands - ymmv

### TODO

We're going to track issues in this repo for the time being.


* [Legacy docs](LEGACYDOCS.md)

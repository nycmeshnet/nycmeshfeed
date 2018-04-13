# nycmeshfeed

This repo is currently used to force the updated version of tinc-1.1pre15 into the image.  We are also keeping the directions here for the time being

## Getting started

Make sure you have the following

* [Docker](https://www.docker.com/)
* [Drone Cli](http://docs.drone.io/cli-installation/)

Once you have those two dependencies
```bash
clone git@github.com:nycmeshnet/lime-sdk.git
git checkout nycmesh
drone exec
```

* Note - You need a case sensitive files system.  This will work on linux machines or VMs but not OSX with default install

This following is not confirmed to work, however if you don't want to create a virtual box in OSX you can try
```bash
hdiutil create -size 20g -type SPARSE -fs "Case-sensitive HFS+" -volname OpenWrt OpenWrt.sparseimage
hdiutil attach OpenWrt.sparseimage
cd /Volumes/OpenWrt
```
and then try the above commands - ymmv

## Overview

-> [lime-sdk](https://github.com/nycmeshnet/lime-sdk) - Repo cloned from the libremesh build system.  It builds the base image. Currently the nycmesh branch contains the following mods
* .drone.yml - current steps to build and publish images
* feeds.conf.default.local - contains the link to this repo to add tinc to the liremesh build
* options.conf.local - points the communities customization to you fork of the repo
* libremesh.sdk.config.local - contains the CONFIG_PACKAGE for tinc from this repo

-> [network-profiles](https://github.com/nycmeshnet/network-profiles) - Repo clone from libremesh. Part of the build step specifies what network profile to add on top of the image.
There's a nycmesh branch that contains nycmesh.net folder which containers common-qmp-compat which is our current libremesh 
profile that works with legacy qmp images


### TODO

We're going to track issues in this repo for the time being.


* [Legacy docs](LEGACYDOCS.md)

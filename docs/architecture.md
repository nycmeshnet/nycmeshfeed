
Architectural Overview
----------------------

NYC Mesh is built on top of several non-trivial systems. The very very
short version is: nycmeshfeed is an OpenWRT feed which customizes qMp.

If that made any sense to you, then you've probably worked with OpenWRT before,
and might not need this document. Otherwise, read on for an explanation...


Background: qMp, OpenWRT, feeds
-------------------------------
NYC Mesh is built on qMp (Quick Mesh Project) which is, in turn, built
on OpenWRT. This section provides a (very) brief overview of the components,
explaining how OpenWRT is customized by qMp and NYC Mesh.

#### OpenWRT

OpenWRT is a project which provides open source firmware for a wide variety of
router hardware. The OpenWRT firmware is a Linux-based operating system with
using the opkg package manager. OpenWRT is highly customizable, and can be
built with a variety of third-party software.

Resources:
- OpenWRT Wiki: http://wiki.openwrt.org/about/start
- OpenWRT toolchain documentation: http://wiki.openwrt.org/about/toolchain

#### OpenWRT: Feeds

In OpenWRT, a feed is a collection of packages which share a common location.
Adding feeds to OpenWRT allows one to add a new repository of software, which
can then be built along with the firmware. qMp adds its own feeds into the
OpenWRT configuration to customize it, as does NYC Mesh. That is why this repo
is called nycmeshfeed -- this is the OpenWRT feed for NYC Mesh.

Resources:
- OpenWRT feeds documentation: http://wiki.openwrt.org/doc/devel/feeds
- OpenWRT opkg documentation: http://wiki.openwrt.org/doc/techref/opkg

#### qMp: additional additions

qMp adds its own build and configuration system (qmpfw) to simplify building
a qMp firmware. To learn more about qMp, see the docs below. The very short
summary is that qMp adds mesh routing facilities (bmx6) to OpenWRT.

NYC Mesh further customizes qMp, using the qMp build system (qmpfw).

Resources:
- qMp main site: http://qmp.cat/
- qmpfw documentation: http://dev.qmp.cat/projects/qmp/wiki/Qmpfw
- (internal) [Quick Start Explained](quickstart_explained.md)
- (internal) [Building](building.md)
- bmx6 main site: http://bmx6.net/


Customizations
--------------

The nycmeshfeed customizations over qMp live in `/packages`.
Primarily, NYC Mesh adds the specific configuration for the project,
and VPN via tinc.

Structure and file details are here: [Files](files.md)

_todo: perhaps there should be a document explaining how vpn is used
in NYC Mesh and such. the rationale behind the things etc?_


Next Steps
----------

Find out more about building the project:
- [quickstart\_explained](quickstart_explained.md)
- [building](building.md)

Find out more about the project structure:
- [files](files.md)

Find out more about mesh networking and related topics:
- [resources](resources.md)



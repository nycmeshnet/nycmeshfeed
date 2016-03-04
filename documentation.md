This package modifies the standard qMp firmware with setting specific to NYC Mesh. It also adds-
* tinc (VPN tunneling)
* nodogsplash (captive portal splash page)
* a public ssh key
 

## Files-  
nycmeshfeed/packages/**qmp-nycmesh/**  
* The **qmp-nycmesh** package  

**Makefile**  
* directives used to build the firmware image

**qmp-nycmesh/files/etc/...**  
* folder with the following files-  

**dropbear/authorized_keys**  
* contains the NYC Mesh public ssh key

**hotplug.d/iface/95-nodog**  
* starts or restarts nodog after LAN interface is up

**init.d/znycmesh_autoconf**  
* init script on boot, waits for qMp to configure then runs initial_conf

**nodogsplash/htdocs/splash.html**  
* nodog splash screen

**nycmesh/check_tunnel.sh**
* Checks to see if tinc is running  
* makes sure bmx is running on tinc tunnel and wired interfaces  
* set MTU on tunnel  
* sets tunnel speed to low speed (lowers priority)  

**nycmesh/nycmesh.banner**
**nycmesh/nycmesh.release**  
* files for login banner  

**nycmesh/nycmesh_configure.sh**
* script for naming nodes from the terminal
		
**nycmesh/nycmesh_initial_conf.sh** 
* Changes the default password
* sets initial IP address and node name
* set wireless channels to 6 (from 1) and 165 (same as qMp)
* updates configuration for nodogsplash
* fixes NanoStation NSM5 vlan issue
* sets up mdns (adding .mesh and .mesh6)
* sets up libremap, calls the tinc config script
* adds crontab for checktunnel script
* adds crontab to upload tinc key, adds firewall rules- blocks access to private address space and allows shh and tinc on the WAN. 
* Configures OpenWrt to save files on upgrade.  
**nycmesh_startup.sh**
* adds wired meshing interfaces  
**tinc_conf.sh**
* generates initial tinc configuration file and key

**tinc_putkey.sh**
* run from crontab, if internet gateway present it uploads key and removes crontab

**/files/etc/rc.d/**
* calls ../init.d/znycmesh_autoconf

**/files/etc/tinc/**
* sets MTU, firewall rule limits MTU size, reloads mdns (possibly redundant)

**tinc/nycmesh/hosts/tunnelnycmesh**
* NYC Mesh public key

**uci-defaults/znycmesh_banner**
* adds NYC Mesh ssh banner

**uci-defaults/znycmesh_nodogtimeout**
* sets client timeouts 60 minutes idle, 24 hours connect

**uci-defaults/znycmesh_tinc**
* calls tinc configuration to generate newer key format (1.1 format)



---
layout: default
title: Setting ATI Radeon HD 2600 XT to work with Debian
lang: en
category: linux
---

> This post is primary a note to self

I was experiencing several rendering issues on Chromium (**black squares/lines**, **scrolling issues**, **CSS3 animation issues**, etc) with my iMac's ATI Radeon HD 2600 XT video card; this was probably caused by the [AMD Catalyst driver](http://support.amd.com/it/gpudownload/linux/Pages/radeon_linux.aspx).

After some researches I found the solution:

First uninstall **fglrx**:

	sudo /usr/share/ati/fglrx-uninstall.sh

Reboot (not tested if actually needed), then:

	sudo apt-get remove --purge fglrx* # no problem if this command fails
	sudo apt-get remove --purge xserver-xorg-video-ati xserver-xorg-video-radeon 
	sudo apt-get install xserver-xorg-video-ati
	sudo apt-get install --reinstall libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-core
	sudo dpkg-reconfigure xserver-xorg

Reboot again and everything should be fine.

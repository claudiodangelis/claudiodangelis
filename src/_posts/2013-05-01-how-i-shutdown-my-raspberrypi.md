---
layout: default
title: How I shutdown my Raspberry Pi
lang: en
category: linux
tags: [linux, raspberry pi, rpi, raspberrypi]
---

I have a Raspberry Pi board and some days ago I decided to use it as a sort of print server at home, excited about the idea of being able to plug the RasPi's power supply then turn the printer on and wirelessly send it documents from my laptop(s).  
While getting ready to put my hands on it and set up the server, a problem showed up:
once the print is done, I'd probably want to turn off the printer, turn off the RasPi and possibly unplug power supply; it's a _headless_ system, so I would connect over SSH and run the proper command to shutdown the RasPi, but what about my mother?  

I mean, she's clearly not a UNIX geek.
Without a power button or a point-and-click graphical interface she wouldn't be able to properly shutdown the RasPi, so she would probably **unplug the power supply**, and we all know how bad is this practice.

<!--more-->

I had to find a way to communicate with the Raspberry Pi from the _real, physycal, tangible,_ world.

I know that for 15&#36; one can have a USB power button, but that  just didn't  sound like the kind of solution I was looking for.


After some thinking I figured it out: [udev](http://linux.die.net/man/8/udev).  
From Wikipedia:

> **udev** is a device manager for the Linux kernel. Primarily, it manages device nodes in /dev.

Basically, among other features, you can use _udev_ to **get informations** about a device when an action is performed (_add, remove, change, online, offline_).

That said, here comes the idea: I choose a specific USB device and when a "remove" action is performed on that device RasPi shuts itself down. It fits pretty well as a solution for that _real world interaction_ problem.



So, I wrote this simple python tool (very cool name: **unplug2shutdown**) that basically:

- **Asks** you to plug in the device you want to use as a shutdown handler
- **Waits** for that device to be removed and then **run** `shutdown -h now`

Pretty simple. And it works with any kind of USB device as well: a flash/external drive, a SD/MMC adapter (even with no card in it), a WiFi adapter, a **printer**, and so on.

Coming back to my print server scenario, I have set the printer itself as a shutdown handler, so when I physycally turn it off, I have just to wait until RasPi's green lights go out and then I can safely unplug power supply.  
If I chose a WiFi adapter, I would just unplug it then plug it in back to send the shutdown signal.


Needless to say, it's a super quick and dirt tool by now, there may be a zillion edge cases for which it does not work.



You can download it at github: [zip archive](https://github.com/claudiodangelis/unplug2shutdown/archive/master.zip), or clone the git repository: `git clone git://github.com/claudiodangelis/unplug2shutdown.git`



Dependencies:



 - GObject python bindings;
 - GUdev python bindings;

**Debian and derivatives**

sudo apt-get install python-gobject python-gudev

About the installation, since the tool is at a **very early stage**, there's no installer yet so here's the deal:

1. run **as root**:

        /path/to/unplug2shutdown.py --configure
2.  follow the instructions, you'll need to plug the device that you want to use as a shutdown handler;
3.  run the tool as root somehow at startup:

        /path/to/unplug2shutdown.py &

4. unplug the device and look at the magic;


If you want to reconfigure it, you have to run `./unplug2shutdown.py --configure` again.

Here's the repository on GitHub, [unplug2shutdown](https://github.com/claudiodangelis/unplug2shutdown), I'd really like to read your feedback about it, thanks.

**EDIT**: Discuss it on [Raspberry Pi Google+  Community](https://plus.google.com/115859961800127275872/posts/FBq9Vx8y2hq)

---
layout: default
title: Installing irssi on OSX
lang: en
category: osx
tags: [osx, mac os x]
---

![Screenshot](/assets/img/posts/screenshot_irssi.png)

_WARNING: tested on OSX 10.8.2 only_

## Dependencies (_assuming last stable releases_):

1. m4
2. libtool
3. autconf
4. automake
5. gettext
6. glib

Build and install packages with `./configure`, `make && sudo make install`, no particular flags required.


<!--more-->


## Possible errors

1. **gettext**

		stpncpy.c:34: error: expected declaration specifiers or ‘...’ before numeric constant
		stpncpy.c:34: error: expected ‘)’ before ‘!=’ token
		stpncpy.c:34: error: expected ‘)’ before ‘?’ token
		make[4]: *** [stpncpy.lo] Error 1
		make[4]: *** Waiting for unfinished jobs....
		make[3]: *** [all] Error 2
		make[2]: *** [all-recursive] Error 1
		make[1]: *** [all] Error 2
		make: *** [all-recursive] Error 1

 	To fix this issue, edit `/gettext-tools/gnulib-lib/stpncpy.c`, go to line **34** column 1 and replace `__stpncpy` with `__stpcpy`.



2. **irssi**  

		llvm-gcc-4.2: -E, -S, -save-temps and -M options are not allowed with multiple -arch flags

	Fix this issue by removing every occurrences of `--arch i386` in files:

		- ./Makefile
		- ./src/perl/textui/Makefile
		- ./src/perl/ui/Makefile

3. **switch windows with alt + number**

	<kbd>&#x2325; + number</kbd> to switch windows won't work, fix this by checking "Use option as meta key" flag in Terminal.app's **Preferences -> Settings -> Keyboard**.

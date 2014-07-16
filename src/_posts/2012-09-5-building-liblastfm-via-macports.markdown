---
layout: default
title: Building liblastfm via macports
lang: en
category: osx
tags: [mac os x, osx]
---

First run this:
{% highlight sh %}
port -dv extract liblastfm
cd /opt/local/var/macports/build/_opt_local_var_macports_sources_rsync.macports.org_release_tarballs_ports_audio_liblastfm/liblastfm/work/mxcl-liblastfm-1c739eb
nano .qmake.env
{% endhighlight %}

then replace:

{% highlight make %}
QMAKE_CC = /usr/bin/clang
QMAKE_CXX = /usr/bin/clang++
QMAKE_LFLAGS_RELEASE = -L/opt/local/lib -arch x86_64
QMAKE_CFLAGS_RELEASE = -pipe -O2 -arch x86_64 -I/opt/local/include
QMAKE_CXXFLAGS_RELEASE = -pipe -O2 -arch x86_64 -I/opt/local/include
{% endhighlight %}

with:

{% highlight make %}
QMAKE_CC = /usr/bin/gcc-4.2
QMAKE_CXX = /opt/local/bin/g++-apple-4.2
QMAKE_LFLAGS_RELEASE = -L/opt/local/lib -arch x86_64  -Xarch_x86_64
QMAKE_CFLAGS_RELEASE = -pipe -O2 -arch x86_64  -Xarch_x86_64 -I/opt/local/include
QMAKE_CXXFLAGS_RELEASE = -pipe -O2 -arch x86_64 -Xarch_x86_64 -I/opt/local/include
{% endhighlight %}

Save and go!

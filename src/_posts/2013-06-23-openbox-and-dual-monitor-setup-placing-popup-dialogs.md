---
layout: default
title: Openbox and dual-monitor setup&#58; placing popup dialogs
lang: en
category: linux
tags: [linux, openbox]
---

> This post is primarly a note to self

Apparently, accordingly to the Openbox' default configuration, in a dual-monitor
setup, the **primary** monitor is the one on the left, and this leads to
an annoying issue when you use as primary monitor the one on the right, as in my
case: in fact, if the monitor on the left is off, you won't be able to see
dialogs popups, for instance the application switcher popup or the virtual desktop
switcher.

<!--more-->
My problem was not being able to **show** those dialogs on the **proper monitor**.

I googled a little bit...  nothing.  
I posted a thread on a forum... nothing.  
I **RTFM**'d... still nothing.


In the end, I found these lines in the OB's configuration file, around the 20th line
(`~/.config/openbox/rc.xml`):
{% highlight xml %}
<placement>
  <policy>Smart</policy>
  <!-- 'Smart' or 'UnderMouse' -->
  <center>yes</center>
  <!-- whether to place windows in the center of the free area found or
     the top left corner -->
  <monitor>Primary</monitor>
  <!-- with Smart placement on a multi-monitor system, try to place new windows
     on: 'Any' - any monitor, 'Mouse' - where the mouse is, 'Active' - where
     the active window is, 'Primary' - only on the primary monitor -->
  <primaryMonitor>1</primaryMonitor>
  <!-- The monitor where Openbox should place popup dialogs such as the
     focus cycling popup, or the desktop switch popup.  It can be an index
     from 1, specifying a particular monitor.  Or it can be one of the
     following: 'Mouse' - where the mouse is, or
                'Active' - where the active window is -->
</placement>
{% endhighlight %}

Bingo. Intuitively, to have dialogs showed on the monitor on the right you have
to replace **1** with **2** in the `<primaryMonitor>` tag. Choose **Mouse** if you want
dialogs following your mouse or (my ultimate choice) **Active**, that shows dialogs
on the monitor where the active window is.  
Brilliant.

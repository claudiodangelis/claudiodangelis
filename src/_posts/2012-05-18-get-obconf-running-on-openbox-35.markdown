---
layout: default
title: Get obconf running on openbox 3.5
lang: en
category: linux
tags: [linux, openbox]
---



<p>Current stable release of <a href="http://openbox.org/dist/obconf/">obconf</a>, 2.0.3, doesn't work with the last <a href="http://openbox.org/">openbox-3.5.</a></p>

<p>Let's see how to get it working:</p>



<ol>
<li>Download from the current git repository:
<pre><kbd>git clone git://git.openbox.org/dana/obconf obconf</kbd></pre>



<li>Apply this patch to obconf/src/preview.c :
<pre><a href="https://github.com/claudiodangelis/scripts/blob/master/openbox/obconf-openbox-3.5.patch">https://github.com/claudiodangelis/scripts/blob/master/openbox/obconf-openbox-3.5.patch</a></pre>
<pre class="prettyprint linenums">diff --git a/obconf/src/preview.c b/obconf2/src/preview.c
index 320e7ac..a82cf15 100644
--- a/obconf/src/preview.c
+++ b/obconf2/src/preview.c
@@ -327,28 +327,28 @@ static GdkPixbuf* preview_window(RrTheme *theme, const gchar *titlelayout,
             switch (*layout) {
             case 'D':
                 a = focus ?
-                    theme->btn_desk->a_focused_unpressed :
-                    theme->btn_desk->a_unfocused_unpressed;
+                    theme->a_focused_unpressed_desk :
+                    theme->a_unfocused_unpressed_desk;
                 break;
             case 'S':
                 a = focus ?
-                    theme->btn_shade->a_focused_unpressed :
-                    theme->btn_shade->a_unfocused_unpressed;
+                    theme->a_focused_unpressed_shade :
+                    theme->a_unfocused_unpressed_shade;
                 break;
             case 'I':
                 a = focus ?
-                    theme->btn_iconify->a_focused_unpressed :
-                    theme->btn_iconify->a_unfocused_unpressed;
+                    theme->a_focused_unpressed_iconify :
+                    theme->a_unfocused_unpressed_iconify;
                 break;
             case 'M':
                 a = focus ?
-                    theme->btn_max->a_focused_unpressed :
-                    theme->btn_max->a_unfocused_unpressed;
+                    theme->a_focused_unpressed_max :
+                    theme->a_unfocused_unpressed_max;
                 break;
             case 'C':
                 a = focus ?
-                    theme->btn_close->a_focused_unpressed :
-                    theme->btn_close->a_unfocused_unpressed;
+                    theme->a_focused_unpressed_close :
+                    theme->a_unfocused_unpressed_close;
                 break;
             default:
                 continue;</pre>



<p>alternatively, download already <a href="https://github.com/claudiodangelis/scripts/blob/master/openbox/preview.c.patched">preview.c.patched</a>.<br/><em>(remember to rename it "preview.c" and put it into "src" directory!)</em></p>

<li>Run:
<pre><kbd>./bootstrap</kbd></pre>

<p>If you get an aclocal error, edit <kbd>./bootstrap</kbd> and replace</p>

<pre><code>export WANT_AUTOMAKE=1.9</code></pre>

<p>with your current <b>aclocal</b> version. <em>(It should work with aclocal>1.9, 1.11 tested)</em></p>

<li>Run:
<pre><kbd>./configure
make
sudo make install
</kbd></pre>
<li>Enjoy your working obconf
</ol>

---
layout: default
title: gcurlftpfs
descr: Graphical interface and tools for curlftpfs program
github: http://github.com/claudiodangelis/gcurlftpfs
path: gcurlftpfs
---

<p>Graphical interface and tools for curlftpfs program</p>

<h3 id="overview">Overview</h3>
<p><strong>gcurlftpfs</strong> provides a lightweight graphical user interface and tools for curlftpfs program.</p>
<p>It performs and manage of curlftpfs connections, even those established via command line</p>

<h3 id="requirements">Requirements</h3>
<p><a href="http://python.org/download/">python 2.7</a></p>
<p><a href="http://www.tcl.tk/software/tcltk/download.html">Tcl/Tk libs</a></p>
<p><a href="https://sourceforge.net/projects/curlftpfs/">curlftpfs</a></p>
<p><a href="https://sourceforge.net/projects/fuse/">fuse</a></p>
<p>Mac OS X users need curlftpfs from <a href="http://www.macports.org/">MacPorts</a>.</p>

<h3 id="download">Download and version notes</h3>
<p>Latest version: gcurlftpfs 0.2</p>
<p><a href="https://github.com/claudiodangelis/gcurlftpfs/tags">Download</a></p>
<p><a href="https://github.com/claudiodangelis/gcurlftpfs">Browse code</a></p>


<h3 id="platforms">Platforms</h3>
<p><strong>Linux</strong> and <strong>Mac OS X</strong></p>

<h3 id="installation">Installation and usage</h3>
<p>You have several ways to run it:</p>


<pre class="prettyprint"><code>python gcurlftpfs.py</code></pre>

<pre class="prettyprint"><code>chmod +x gcurlftpfs.py
./gcurlftpfs.py</code></pre>

<pre class="prettyprint"><code>chmod +x gcurlftpfs.py
sudo cp ./gcurlftpfs.py /usr/local/bin/gcurlftpfs
gcurlftpfs
</code></pre>

<h3>Screenshots</h3>
<div id="myCarousel" class="carousel slide">
<div class="carousel-inner">
<div class="item active">
<img class="carousel-img" src="/img/posts/gcurlftpfs1.png" alt="">
<div class="carousel-caption">
<p>Opening</p>
</div>
</div>
<div class="item">
<img class="carousel-img" src="/img/posts/gcurlftpfs2.png" alt="">
<div class="carousel-caption">
<p>Managing multiple connections</p>
</div>
</div>
<div class="item">
<img class="carousel-img" src="/img/posts/gcurlftpfs6.png" alt="">
<div class="carousel-caption">
<p>Running on Mac OS X</p>
</div>
</div>




</div>
<a class="left carousel-control skip-navbar-fix" href="#myCarousel" data-slide="prev">&lsaquo;</a>
<a class="right carousel-control skip-navbar-fix" href="#myCarousel" data-slide="next">&rsaquo;</a>
</div>



<h3 id="knownissues">Known issues</h3>
<ul>
<li>There is no stable error handler implemented yet, behavior in case of error is unpredictable</li>
<li>When a connection is established, <u><strong>Console echoes plain-text username's password</strong></u></li>
<li>on Mac OS X, <strong>unmount</strong> return errors, but it works fine actually</li>
</ul>

<h3 id="nextreleases">Next releases resolutions</h3>
<ul>
<li>better looking GUI, lol
<li>Mac OS X application bundle
<li>sshfs support
<li>wizard configurator, high customizability
<li>bookmarks and automounting
<li>import bookmarks from FileZilla, gftp, etc
<li>recent servers
</ul>
---
layout: default
title: How to setup mamp server on Mac OS X
lang: en
category: osx
---



<p>This post will guide you through a quick setup of a MAMP server on Mac OS X (do not confuse with <strong>MAMP.app</strong> application). Definition of MAMP from wikipedia:</p>
<p><em>Acronym MAMP refers to a set of free software programs commonly used together to run dynamic web sites on servers running the Apple Macintosh operating system, Mac OS X</em></p>

<!--more-->

<ul>
<li>Mac OS X, the operating system;</li>
<li>Apache, the Web server;</li>
<li>MySQL, the database management system (or database server);</li>
<li>P for PHP, Perl, or Python, all programming languages used for web development.</li>
</ul>


<div id="apache">
<h2>Apache</h2>
<p>Mac OS X is shipped with a built-in Apache Server, you can easly enable it by checking "Web Sharing" in <strong>System Preferences &gt; Sharing</strong> pane.</p>
<img  src="/img/posts/preferences_webserver.png" alt="Web Sharing"/>
<p>It shows you also the web address of your local files, both for the current user and computer, clicking the computer's website address (or browsing to <a href="http://localhost">http://localhost</a>) you will see the <code>It Works!</code> message.</p>

<p>Ok, it works, now let's see how to customize webserver, first of all, we need to know which files have to be edited and where we can find them:</p>
<ul>
<li><strong>/etc/apache2/</strong>, apache configuration files are stored here
<li><strong>httpd.conf</strong>, the main apache configuration file, stored in <code>/etc/apache2</code>
</ul>

<p>This is important:</p>
<p>1) since <strong>httpd.conf</strong> is in <code>/etc/</code> you will need <strong>administrator privileges</strong> to edit it.</p>
<p>2) every time you make some change on httpd.conf you have to <strong>restart webserver</strong> to see changes.</p>
<p>3) <strong>save a copy of original and working configuration files before you edit them</strong></p>
<br/>
<p>Let's edit <strong>httpd.conf</strong> with <code>nano</code> text editor</p>
<pre  class="prettyprint">
sudo nano /etc/apache2/httpd.conf
</pre>
<p>First of all, we want to change the home folder of our files, assuming we want to set it to <code>/Users/myusername/www</code>. In text editor search for the string: <pre class="prettyprint"><code>DocumentRoot "/Library/WebServer/Documents"</code></pre> and replace it with:<pre class="prettyprint"><code>DocumentRoot "/Users/myusername/www"</code></pre>You have also to replace, some line below:<pre class="prettyprint"><code>&lt;Directory &quot;/Library/WebServer/Documents&quot;&gt;</code></pre> with:<pre class="prettyprint"><code>&lt;Directory &quot;/Users/myusername/www&quot;&gt;</code></pre> (<em>&lt;Directory&gt; section contains apache instructions for the given directory</em>: <a href="http://httpd.apache.org/docs/2.0/mod/core.html#directory">Official Apache reference</a>)</p>

<br/>
<p>Now we want to enable php, that is installed by default but not loaded (yes, this is one of the classical Apple jokes!): search for line: <pre class="prettyprint"><code>#LoadModule php5_module libexec/apache2/libphp5.so</code></pre> and uncomment it simply deleting leading hash key</p>
<p><em>(built-in php version is 5.3, but 5.4 has been released and in next section we'll see how to upgrade)</em></p><br/>
<p>Let's tell Apache to look also for index.php indexes, look for:<pre class="prettyprint"><code>&lt;IfModule dir_module&gt;
    DirectoryIndex index.html
&lt;/IfModule&gt;</code></pre> and add <em>index.php</em>:<pre class="prettyprint"><code>&lt;IfModule dir_module&gt;
    DirectoryIndex index.html index.php
&lt;/IfModule&gt;</code></pre></p>

<p>Save <strong>httpd.conf</strong> (<code>nano</code>'s saving command is <code>CTRL+O</code>), put your files in <code>/Users/myusername/www</code>, restart webserver and see you new local website in action. To restart server go to System Preferences &gt; Sharing, un-check "Web Sharing", wait some seconds, and check it again.</p>

<p>Now, if you need to manage multiple websites you don't need multiple webservers: what you need is <strong>virtual hosts</strong> (if not interested jump to <a href="#php">next section, hop!</a>)</p>

<p>Setting up virtual hosts is very simple, but is <strong>strongly recommended</strong> to read first official documentation: <a href="http://httpd.apache.org/docs/2.0/vhosts/">http://httpd.apache.org/docs/2.0/vhosts/</a></p>
<p>First of all, un-comment this line:<pre class="prettyprint"><code>#Include /private/etc/apache2/extra/httpd-vhosts.conf</code></pre> save (<code>CTRL+O</code>) and close (<code>CTRL+X</code>) <strong>httpd.conf</strong> and edit the virtual host specific configuration file:</p>
<pre class="prettyprint">
<code>sudo nano /etc/apache2/extra/httpd-vhosts.conf</code>
</pre>
<p>Now assume that you want two hosts: <strong>localhost</strong>, that is the main host, and <strong>myvirtualhost</strong>, and assume you want to store <em>myvirtualhost</em> files in <code>/Users/myusername/myvirtualhostwww</code></p>
<p>Delete all lines in <code>httpd-vhosts.conf</code> and paste this:</p>
<pre class="prettyprint"><code>NameVirtualHost *:80

&lt;VirtualHost *:80&gt;
    DocumentRoot &quot;/Users/myusername/www&quot;
    ServerName localhost
&lt;/VirtualHost&gt;

&lt;VirtualHost *:80&gt;
    DocumentRoot &quot;/Users/dawson/www/myvirtualhostwww&quot;
    ServerName myvirtualhost
&lt;/VirtualHost&gt;

&lt;Directory &quot;/Users/myusername/myvirtualhostwww&quot;&gt;
    Order Deny,Allow
    Allow from 127.0.0.1
    Deny from all
&lt;/Directory&gt;</code></pre>

<p>Note that this file overrides some httpd.conf directives, that's why you see again the declaration of <code>DocumentRoot</code> for localhost. Read the documentation to understand what we have done: <a href="http://httpd.apache.org/docs/2.0/vhosts/">http://httpd.apache.org/docs/2.0/vhosts/</a></p>
<p>You can save and close the file, and open <code>/etc/hosts</code>:<pre class="prettyprint"><code>sudo nano /etc/hosts</code></pre> and add this line at the end of file:<pre class="prettyprint"><code>127.0.0.1  myvirtualhost</code></pre> save and close, and give this command in order to flush directory service cache:<pre class="prettyprint"><code>dscacheutil -flushcache</code></pre></p>
<p>All done, restart your webserver, and see your virtual host(s) in action.</p>
</div>

<div id="php">
<h2>php 5.4</h2>
<p>As anticipated in first section, there is a new stable release of php (check out <a href="http://php.net/releases/5_4_0.php">php.net</a>), let's see how to replace it with the old built-in one:</p>
<ol>
<li>Download source code</li><p>You can select the nearest mirror at <a href="http://www.php.net/get/php-5.4.0.tar.gz/from/a/mirror">http://www.php.net/get/php-5.4.0.tar.gz/from/a/mirror</a>, once the download is completed, double click to unpack it or, alternatively, from command line:<pre class="prettyprint"><code>cd Downloads;
tar xvf php-5.4.0.tar.gz</code></pre></p>
<li>Download and install some useful libraries</li>
<p>You'll need for <code>jpeg</code> and <code>libpng</code>, download them respectively from:</p><p><a href="http://www.ijg.org/files/jpegsrc.v8d.tar.gz">http://www.ijg.org/files/jpegsrc.v8d.tar.gz</a></p><p><a href="http://sourceforge.net/projects/libpng/files/libpng15/1.5.9/libpng-1.5.9.tar.gz/download">http://sourceforge.net/projects/libpng/files/libpng15/1.5.9/libpng-1.5.9.tar.gz/download</a></p><p>Now build them and install them via command line (if your current working directory is your home folder and download directory is "Downloads" you can copypaste this code into terminal and type your password when prompted):<pre class="prettyprint"><code>cd Downloads
tar xf jpegsrc.v8d.tar.gz
cd jpeg-8d
./configure
make
sudo make install
cd ..
tar xf libpng-1.5.9.tar.gz
cd libpng-1.5.9
./configure
make
sudo make install
cd ..
</code></pre></p>
<li>Build and install php 5.4</li><p>We're on. Now we have to build php in order to work with our webserver. (if your current working directory is your home folder and download directory is "Downloads" you can copypaste this code into terminal and type your password when prompted):<pre class="prettyprint"><code>cd Downloads
tar xf php-5.4.0.tar.bz2
cd php-5.4.0
./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/private/etc --with-apxs2=/usr/sbin/apxs --enable-cli --with-config-file-path=/etc --with-libxml-dir=/usr --with-openssl=/usr --with-kerberos=/usr --with-zlib=/usr --enable-bcmath --with-bz2=/usr --enable-calendar --with-curl=/usr --enable-dba --enable-exif --enable-ftp --with-gd --with-freetype-dir=/usr/X11R6 --with-jpeg-dir=/BinaryCache/apache_mod_php/apache_mod_php-66.3~5/Root/usr/local --with-png-dir=/BinaryCache/apache_mod_php/apache_mod_php-66.3~5/Root/usr/local --enable-gd-native-ttf --with-icu-dir=/usr --with-iodbc=/usr --with-ldap=/usr --with-ldap-sasl=/usr --with-libedit=/usr --enable-mbstring --enable-mbregex --with-mysql=mysqlnd --with-mysqli=mysqlnd --without-pear --with-pdo-mysql=mysqlnd --with-mysql-sock=/tmp/mysql.sock --with-readline=/usr --enable-shmop --with-snmp=/usr --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-tidy --enable-wddx --with-xmlrpc --with-iconv-dir=/usr --with-xsl=/usr --enable-zip --with-pcre-regex --with-pgsql=/usr --with-pdo-pgsql=/usr
make
sudo make install
cd ..</code></pre></p>
</ol>
<p>Now php 5.4 is successfully installed. To check out, create <code>test.php</code> in your webserver home folder and put this contents:<pre class="prettyprint"><code>&lt;?php phpinfo(); ?&gt;</code></pre> and in <code>http://localhost/test.php</code> you will see the configuration summary of php.</p>
<p>To remove sources and build folders:</p>
<pre class="prettyprint"><code>cd Downloads
rm -rf php-5.4.0
rm -rf php-5.4.0.tar.bz2
rm -rf jpeg-8d
rm -rf jpegsrc.v8d.tar.gz
rm -rf libpng-1.5.9
rm -rf libpng-1.5.9.tar.gz</code></pre>
</div>


<div id="mysql">
<h2>mysql</h2>
<p>The last (and simplest) step is set up mysql server for your databases.</p>
<ol>
<li>goto <a href="http://www.mysql.it/downloads/mysql/">http://www.mysql.it/downloads/mysql/</a> and choose a DMG archive according to your OS (10.6 version works great in Lion, too)</li><br/>
<li>Install all packages <ul><li>mysql-5.5.21-osx10.6-x86_64.pkg</li>
<li>MySQLStartupItem.pkg</li>
<li>MySQL.prefPane</li></ul></li>
</ol>
<p>Now you need an administration tool for mysql, more user-friendly than command line client and different from the <em>good ol' boy</em> <a href="http://www.phpmyadmin.net/home_page/index.php">phpMyAdmin</a>: I recommend <strong>Sequel Pro</strong>. It's a desktop Cocoa App, intuitive, good looking, free, open source, lovable.</p><p>Download it from <a href="http://www.sequelpro.com/">Sequel Pro website</a></p>
</div>

<div id="test">
<h2>Test the environment!</h2>
<p>Ensure mysql server is running (if you installed MySQL.prefPane you can start mysql server from System Preferences &gt; MySQL)</p>
<p>Launch Sequel Pro and connect to localhost:</p>
<img  src="/img/posts/screenshot_sequelpro.png" alt="Sequel Pro"/>
<ul>
<li>host = localhost
<li>username = root
<li>password = root
</ul>
<p>Click the "Query" icon, paste this query:</p>
<pre class="prettyprint linenums">CREATE DATABASE env_test;
USE env_test;
CREATE TABLE `table_test` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `table_test` WRITE;

INSERT INTO `table_test` (`id`, `value`)
VALUES
  (1,'mysql is working');</pre>
  <p>then click "Run All".</p>
  <p>You created the <code>env_test</code> database, the <code>test_table</code> table and you populated it with one record.</p>
  
  <p>Now go to website's home folder <code>/Users/myusername/www</code> and create this file:</p>
  <pre class="prettyprint linenums">&lt;p&gt;apache is working&lt;/p&gt
&lt;?php
echo &quot;&lt;p&gt;php is working&lt;/p&gt;&quot;;
$connection_data=mysql_connect(&quot;localhost&quot;,&quot;root&quot;,&quot;root&quot;) or die (mysql_error());
mysql_select_db(&quot;env_test&quot;) or die (mysql_error());
$query_result=mysql_query(&quot;select `value` from `table_test` where `id`=1&quot;) or die (mysql_error());
$row=mysql_fetch_row($query_result);
echo &quot;&lt;p&gt;$row[0]&lt;/p&gt;&quot;;
echo &quot;&lt;p&gt;&lt;a href='http://myvirtualhost'&gt;Does virtualhost work?&lt;/a&gt;&lt;/p&gt;&quot;;

phpinfo();
?&gt;</pre>
<p>Name it test_environment.php, browse <a href="http://localhost/test_environment.php">http://localhost/test_environment.php</a>, and check if everything is doing its job.</p>
</div>
---
layout: default
title: Mac OS X&#58; Launch Terminal from keyboard shortcut
lang: en
category: osx
tags: [terminal, osx, mac os x]
---


<p>OSX as is doesn't allow users to set keyboard shortcuts to <b>launch</b> applications, but there are a bunch of 3rd-party softwares and workarounds to achieve that.</p>


<p>If you don't want to use a 3d-party app then the best way to do that is creating a <em>service</em> that just launches an application, and then bind it to a given keyboard shortcut. Let's start:</p>
<ol>
<li><p>Open <b>Automator.app</b> and choose new &quot;Service&quot; document</p><p><img class="screenshot" src="/assets/img/posts/automator_service.png" alt="Automator screenshot"/></p></li>
<li><p>In the right tab, set &quot;Service receives&quot; to &quot;no input&quot;, then drag and drop &quot;Run AppleScript&quot; action to the workflow:</p><p><small>&quot;Run AppleScript&quot; is located under &quot;Utility&quot; section.</small></p> <p><img class="screenshot" src="/assets/img/posts/automator_runapplescript.png" alt="Automator screenshot"/></p>  </li>
<li><p>Set the content of the script to:</p>
{% highlight applescript %}
on run {input, parameters}

  tell application "Terminal"
    reopen
    activate
  end tell

end run
{% endhighlight %}
</li>
<li>Save the document as &quot;Open Terminal&quot; (or whatever) and close <b>Automator.app</b> </li>
<li><p>Go to <b>System Preferences</b>-&gt;<b>Keyboard</b>-&gt;<b>Keyboard Shortcuts</b>-&gt;<b>Services</b>, then scroll until you find your new service under <b>General</b> section and assign it a shortcut.</p>
<p><img class="screenshot" src="/assets/img/posts/preferences_keyboard.png" alt="Prefpane screenshot"/></p>
</li>
</ol>

<h2>Note</h2>
<p>This works with all of the applications, you just have to replace <code>Terminal</code> with what you want.</p>

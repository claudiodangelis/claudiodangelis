---
layout: default
title: Google Developers Live Italia&#58; la libreria Dart Web UI
lang: it
category: dart
tags: [dart, dartlang, dartlang italia, web ui]
---

È online un nuovo episodio per Google Developers Live Italia, argomenti trattati: `web_ui.dart`, libreria che ci consente di utilizzare Model-driven Views (MDV) e Web Components in Dart. Il codice
proposto è disponibile sull'account [gdl-italia su github](https://github.com/gdl-italia/dart-mdv-webcomponents-gdl).

Un esempio di **MDV**:

<div class="row">
    <div class="col-md-6">
    <p><b>Input</b></p>
{% highlight html %}
{% raw %}
<html>
<body>
    <h1>{{ titolo }}</h1>
    <p>Hello {{ soggetto }}!</p>
    <p>L: {{ soggetto.length }}</p>
</body>
</html>
{% endraw %}
{% endhighlight %}

{% highlight dart %}
// codice Dart
String titolo = 'Esempio';
String soggetto = 'world';
{% endhighlight %}
    </div>
    <div class="col-md-6">
    <p><b>Output</b></p>
{% highlight html %}
<html>
<body>
    <h1>Esempio</h1>
    <p>Hello world!</p>
    <p>L: 5</p>
</body>
</html>
{% endhighlight %}
    </div>
</div>



Un esempio di **Web Components**:

**Input**

{% highlight html %}
{% raw %}
<html>
  <social-button network="facebook" username="myusername"></social-button>
  <social-button
    displayedname="Developers Italia"
    network="google+"
    username="117196874771284793338"></social-button>
</html>
{% endraw %}
{% endhighlight %}

**Output**

![Screenshot](/assets/img/posts/socialbuttons.png)

Questo episodio fa parte del programma **GDL Italia** che potete seguire sul blog ufficiale [Developers Italia](http://developersitalia.blogspot.it/) curato da [+Alfredo Morresi](https://plus.google.com/+AlfredoMorresi/posts).

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube.com/embed/gwZIyugTHf4" frameborder="0" allowfullscreen></iframe>
</div>

---
layout: default
title: Home Page
---
<div id="desktopHome" class="hidden-phone">
<div class="span6">

<div class="centered">
{% for post in site.posts limit:5%}


<h4>{{ post.title }} <br/><small>{{ post.date | date: "%d %B %Y" }} <span style="color:black">in</span> <b>{{ post.category }}</b></small></h4>


<p><a href='{{post.url}}' class='btn btn-info btn-small'>
{% if post.lang == 'en' %}
	Read post
{% endif %}

{% if post.lang == 'it' %}

Leggi il post

{% endif %}

</a></p>

<hr/>
{% endfor %}

<div class="lead"><a href="/blog">Full blog archive</a></div>
</div>

</div>

<div class="span6 centered">

{% for project in site.pages %}

{% if project.url contains '/projects/' %}


{% if project.title != 'Projects' %}

<h3>{{ project.title }}</h3>


{{ project.descr }}

<p><br/>
	<a href="{{ project.github }}" class="btn btn-small"><img class="btn-img" src="/img/github.png"/> View on GitHub</a>

<a href="/projects/{{ project.path }}" class="btn btn-info btn-small"> Go to this project</a>
</p>
<hr/>

{% endif %}
{% endif %}
{% endfor %}

		<h3>Dartlang Italia</h3>
		<p>Community italiana di supporto dedicata a Dart, il linguaggio di programmazione made in Google</p>
		<p> <a href="http://www.dartlang-italia.it" class="btn btn-success">Vai al sito</a> </p>
		<hr/>
</div>
</div>

<div id="mobileHome" class="hidden-desktop">

	<div class="lead">
		<div class="row"><a href="/blog" class="btn btn-large btn-block">Blog</a>
			<hr/>
		</div>
		<div class="row">
		<a href="/projects" class="btn btn-large btn-block">Projects</a>
		<hr/>
		</div>
		<div class="row">
		<a href="/about" class="btn btn-large btn-block">About me</a>
		</div>
	</div>

</div>
---
layout: default
title: Home Page
---


<div id="desktopHome" class="hidden-phone">


<div class="span6">

<p><em>Latest blog post:</em></p>
<!-- begin preview -->
	{% for post in site.posts limit:1 %}
	<h3>{{ post.title }}</h3>
		{{ post.content | more: "excerpt" }}
    <div class="lead"><a href="{{ post.url }}">Continue reading...</a></div>

    {% endfor %}

<hr/>
<!-- end preview-->

<div class='centered'>
<script type="text/javascript"><!--
google_ad_client = "ca-pub-2659172953949717";
/* homepage2 */
google_ad_slot = "4924749282";
google_ad_width = 234;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</div>

<div>


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

<div class="span4" id="projects">
	<h1 style="font-family:monospace">&tilde;/projects</h1>

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

{% include sidebar.html %}

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

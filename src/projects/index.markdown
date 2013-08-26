---
layout: default
title: Projects
---

<div>
{% for project in site.pages %}
{% if project.url contains '/projects/' %}
{% if project.title != 'Projects' %}
	<div>
		<h3>{{ project.title }}</h3>
		{{ project.descr }}
		<p><br/>
			<a href="{{ project.github }}" class="btn "><img class="btn-img" src="/img/github.png"/> View on GitHub</a>
			<a href="/projects/{{ project.path }}" class="btn btn-info "> Go to this project</a>
		</p>
		<hr/>
	</div>
	{% endif %}
	{% endif %}
	{% endfor %}
	<div>
		<h3>Dartlang Italia</h3>
		<p>Community italiana di supporto dedicata a Dart, il linguaggio di programmazione made in Google</p>
		<p> <a href="http://www.dartlang-italia.it" class="btn btn-success">Vai al sito</a> </p>
		<hr/>
	</div>
</div>

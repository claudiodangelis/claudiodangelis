---
layout: default
title: blog
---



{% for post in site.posts%}


<h4>{{ post.title }} <small>{{ post.date | date: "%d %B %Y" }}</small></h4>



<p><a href='{{post.url}}' class='btn btn-info'>Read post</a></p>

<hr/>
{% endfor %}
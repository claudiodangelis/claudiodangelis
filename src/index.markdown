---
layout: default
title: Home Page
---
<div>
	<div class="">
		<!-- begin preview -->
            {% for post in site.posts limit:1 %}
        <div id="article_content">
			<p><em>Latest blog post:</em></p>
			<h3>{{ post.title }}<br/><small>{{ post.date | date: "%B %d, %Y" }} under <a href="/blog/{{post.category}}">{{post.category}}</a></small></h3>

				{{ post.excerpt }}
	    	<div class="lead"><a href="{{ post.url }}">Continue reading...</a></div>
	    	{% endfor %}
	    	<hr/>
		</div>
	    <!-- end preview-->
        {%  include recent.html %}
	</div>


</div>

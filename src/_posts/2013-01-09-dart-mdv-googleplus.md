---
layout: default
title: Dart, Web UI + js libraries, Google+ API
lang: en
category: dart
tags: [dart, dartlang, google api, web ui]
---

Today's blog post is about a sample application that uses Web UI and js libraries and shows some information about you on Google+. To retrieve these informations, application uses the [Google APIs Client Library for JavaScript](http://code.google.com/p/google-api-javascript-client/).

Funny story:  I chose to use Google API **javascript** client (handled with dart js-interop library) instead of **dart** client since the latter was outdated and while I was editing the code an interesting project appeared on GitHub: [dart-google-oauth2-library](https://github.com/Scarygami/dart-google-oauth2-library) by [+Gerwin Sturm](https://plus.google.com/112336147904981294875/posts). *dart-google-oauth2-library*  simplifies the whole authentication process in a significant way, so please consider the following just as an example of how js-interop works.

<!--more-->
## The application

The applicaton is very simple: once you have authenticated and the application is allowed to access your Google+ profile data, some information will be displayed: name, profile picture, tagline, "about me" and links.

<div class="row-fluid">
  <img src="/assets/img/posts/dart-mdv-googleplus-1.png">
  <img src="/assets/img/posts/dart-mdv-googleplus-2.png">

</div>
<br/>


We need the [web_ui](https://github.com/dart-lang/web-ui) library because application uses **Model-driven Views (MDV)** to bind data and HTML interface, and [js-interop](https://github.com/dart-lang/js-interop) library to handle the Google APIs client, so the **pubspec.yaml** file will be:

{% highlight yaml %}
name:  dart_mdv_googleplus
description:  A sample application
dependencies:
  js: any
  web_ui: any
{% endhighlight %}


We also need a compiler to build our MDV template, let's call it **build.dart**:

{% highlight dart %}
import 'package:web_ui/component_build.dart';
import 'dart:io';

void main() {
  build(new Options().arguments, ['web/google_plus.html']);
}
{% endhighlight %}

## The DART code



### Code highlights

First of all, we have to import some libraries:

{% highlight dart %}
import 'dart:json';
import 'package:js/js.dart' as js;
import 'package:web_ui/watcher.dart' as watchers;
import 'package:web_ui/safe_html.dart';
{% endhighlight %}

**watchers** library contains declaration of `dispatch()` method, we need it to update HTML interface values with the current Dart values.
We'll soon see why we are importing **safe_html**.

Let's go on:

{% highlight dart%}
final String CLIENT_ID = '688X10452XXX.apps.googleusercontent.com';
final String SCOPE = 'https://www.googleapis.com/auth/plus.me';
{% endhighlight %}

**CLIENT_ID** and **SCOPE** are required to gain application access, here's more on how [Using OAuth 2.0 to Access Google APIs](https://developers.google.com/accounts/docs/OAuth2).

Now see how Javascript functions are handled by Dart `js` library:

{% highlight dart %}
js.scoped((){
js.context.init = new js.Callback.once((){
  js.context.window.setTimeout(js.context.auth, 1);
  });

js.context.auth = new js.Callback.many((){
  js.context.gapi.client.setApiKey('AIzaSyDOtMNdtbw17o9bs-kW7G6O3S05p0H8wYM');
  js.context.window.setTimeout(
    js.context.gapi.auth.authorize(js.map({
    'client_id':CLIENT_ID,
    'scope':SCOPE,
    'immediate':immediate
    }),
    js.context.onAuthResponse), 1
  );
});

js.context.onAuthResponse = new js.Callback.many((js.Proxy token){
  if(token!=null){
    authBtn.style.display='none';
    js.context.MakeRequest();
    immediate = true;
  }
  else{
    authBtn.style.display='block';
    immediate = false;
  }
});
{% endhighlight %}

You see that:

1. all the code is wrapped into the `js.scoped()` method
2. there are two kinds of `Callback`, **once** and **many**

This aims to prevent memory leaks. When you run code inside a local _scope_, all contents created whithin that scope are released and garbage collected after code exits that scope; likewise, you can use Callback's `once` or `many` method according to how many times your callback function has to be executed: if you're using `once`, after the first execution the callback will be disposed. More about [Using JavaScript from Dart](http://www.dartlang.org/articles/js-dart-interop/).

{% highlight dart %}
js.context.RequestCallback = new js.Callback.once((js.Proxy jsonResp, var rawResp){
  var data = JSON.parse(rawResp);

  for( var url in data[0]['result']['urls']){
    urls.add(url['value']);
  }
  displayName = data[0]['result']['displayName'];
  tagline = data[0]['result']['tagline'];
  pic = data[0]['result']['image']['url'];
  aboutMe = new SafeHtml.unsafe('<div>''${data[0]['result']['aboutMe']}</div>');

  watchers.dispatch();

});
{% endhighlight %}

`RequestCallback` is the function that is invoked when application receives `MakeRequest` response. Recieved data, `rawResp`, are parsed and converted to JSON, this will ease the process of assigning values to variables. There's nothing special here but this line:

{% highlight dart %}
aboutMe = new SafeHtml.unsafe('<div>''${data[0]['result']['aboutMe']}</div>');
{% endhighlight %}

Returned value of 'aboutMe' is actually a piece of HTML code; allowing an unknown piece of HTML that comes from the outside to be included in your app would represent a **security flaw**, so HTML is passed as regular text by default, e.g. "&lt;span&gt;hello &lt;a href='/world'&gt;world&lt;a&gt;&lt;/span&gt;".
If we're 100% sure about safety of HTML code, this behaviour can be overridden by the `unsafe` method of `SafeHtml` class; since only one top-level element is allowed to be passed as argument of `unsafe()` we can just wrap the code inside a `div` element.  


### Full code

{% highlight dart %}
import 'dart:html';
import 'dart:json';
import 'package:js/js.dart' as js;
import 'package:web_ui/watcher.dart' as watchers;
import 'package:web_ui/safe_html.dart';

final String CLIENT_ID = '688110452481.apps.googleusercontent.com';
final String SCOPE = 'https://www.googleapis.com/auth/plus.me';

ButtonElement authBtn = query('#authorize');

bool immediate = true;

String displayName = 'Me';
String tagline;
SafeHtml aboutMe;
String pic;

List<String> urls = [];

main(){

  js.scoped((){
    js.context.init = new js.Callback.once((){
      js.context.window.setTimeout(js.context.auth, 1);
      });

    js.context.auth = new js.Callback.many((){
      js.context.gapi.client.setApiKey('AIzaSyDOtMNdtbw17o9bs-kW7G6O3S05p0H8wYM');
      js.context.window.setTimeout(
        js.context.gapi.auth.authorize(js.map({
        'client_id':CLIENT_ID,
        'scope':SCOPE,
        'immediate':immediate
        }),
        js.context.onAuthResponse), 1
      );
    });


    js.context.onAuthResponse = new js.Callback.many((js.Proxy token){
      if(token!=null){
        authBtn.style.display='none';
        js.context.MakeRequest();
        immediate = true;
      }
      else{
        authBtn.style.display='block';
        immediate = false;
      }
    });

    js.context.MakeRequest = new js.Callback.once((){
      js.scoped((){
        js.context.gapi.client.load('plus', 'v1', new js.Callback.once((){
          var request = js.context.gapi.client.plus.people.get(
              js.map({
                'userId':'me',
                'fields':'aboutMe,circledByCount,displayName,image,tagline,urls/value'
              }));
          request.execute(js.context.RequestCallback);
        }));
      });
    });
    js.context.RequestCallback = new js.Callback.once((js.Proxy jsonResp, var rawResp){
      var data = JSON.parse(rawResp);

      for( var url in data[0]['result']['urls']){
        urls.add(url['value']);
      }
      displayName = data[0]['result']['displayName'];
      tagline = data[0]['result']['tagline'];
      pic = data[0]['result']['image']['url'];
      aboutMe = new SafeHtml.unsafe('<div>''${data[0]['result']['aboutMe']}</div>');

      watchers.dispatch();

    });
  });

  authBtn.on.click.add((Event e){
      js.scoped((){
        js.context.auth();
        });
      });

  ScriptElement script = new ScriptElement();
  script.src = "http://apis.google.com/js/client.js?onload=init";
  script.type = "text/javascript";
  document.body.children.add(script);
}
{% endhighlight %}

## The HTML interface

The app interface is really simple:

{% highlight html %}
{% raw %}
<p><b>{{ displayName }} on Google+</b></p>

<template instantiate="if tagline != null">
  <p><em>{{ tagline }}</em></p>
</template>

<button id="authorize">Authorize</button>

<template instantiate="if pic != null">
    <img id="pic" src="{{ pic }}"/>
  </template>

  <template instantiate="if aboutMe != null">
    <div id="about">{{ aboutMe }}</div>
  </template>


<template instantiate="if urls.length != 0 ">
  <ul>
    <template iterate="url in urls">
      <li><a href="{{ url }}">{{ url }}</a></li>
    </template>
  </ul>
</template>
{% endraw %}
{% endhighlight %}


Elements wrapped in curly brackets, e.g. <strong>{{ displayName }}</strong>, are MDV placeholders for data.



If a user had not set, on his Google+ profile, one of the fields, API returns _null_ data; to avoid showing "null", we can decide to instatiate the element only if value of field is not equal to "null":
{% highlight html %}
<template instantiate="if aboutMe != null">
{% endhighlight %}

Last interesting thing to show is how web_ui handles Dart lists:

{% highlight html %}
{% raw %}
<template iterate="url in urls">
  <li><a href="{{ url }}">{{ url }}</a></li>
</template>
{% endraw %}
{% endhighlight %}

You can intuitively read it as: "<em>for each <strong>url</strong> in <strong>urls</strong> do something with <strong>url</strong></em>".

## Demo and source code

You can play with it  following this link (javascript version): [dart-mdv-googleplus](/demo/dart-mdv-googleplus/web/out/google_plus.html)

or get the [code at github](https://github.com/claudiodangelis/dart-mdv-googleplus)

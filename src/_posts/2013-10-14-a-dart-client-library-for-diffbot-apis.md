---
layout: default
title: A Dart client library for Diffbot APIs
lang: en
category: dart
tags: [dart, dartlang, diffbot, libraries]
---

I wrote a Dart client library for [Diffbot](http://diffbot.com), which is _a visual learning robot that identifies and extracts the important parts of any web page_. In the case of an article, Diffbot returns title, author, images, tags, etc.



This library can be used both in the browser that in the console, and can talk to three of the [main APIs](http://diffbot.com/products/automatic/):

- **Article API**, used to extract clean article text from news article web pages

- **Frontpage API**, it takes in a multifaceted “homepage” and returns individual page elements.

- **Product API**, it analyzes a shopping or e-commerce product page and returns information on the product.

<!--more-->

## Installing

Add `diffbot: any` to your app's [pubspec file](http://pub.dartlang.org/doc/pubspec.html), then run `pub install`.

To use it in a web app:

{%highlight dart%}
import 'package:diffbot/diffbot_browser.dart';
{% endhighlight %}

To use it in a command-line app:

{%highlight dart%}
import 'package:diffbot/diffbot_console.dart';
{% endhighlight %}


## Usage

First of all, you have to create a new **Client** instance, which takes a diffbot token as an argument, you can grab a token at [diffbot.com/pricing](http://diffbot.com/pricing/), they also offer a free developer token for non-commercial use.

{%highlight dart%}
var client = new Client('YOUR_TOKEN');
{%endhighlight%}

Now you're ready to use on of client's methods, such as `getArticle()`, `getFrontpage()` or `getProduct()`.

Those methods return a [Future](https://www.dartlang.org/articles/using-future-based-apis/), let's say you want to get important parts of an article, your code will be like this:

{% highlight dart %}
client.getArticle('ARTICLE_URL', options).then((Article article) {
  print(article.title); // prints the title
  print(article.author); //prints the author
  // and so on
});
{%endhighlight%}

## Live demo

Here are three live examples, one for each API:

- [Article API demo](/demo/diffbot/article.html)

    This will show **Title**, **Author**, **Date** and of course **Content** for three articles; you can also submit your own article.

- [Frontpage API demo](/demo/diffbot/frontpage.html)

    Shows the Hacker News frontpage.

- [Product API demo](/demo/diffbot/product.html)

    Shows **Title**, **Price** and images for three products; you can also submit your own product.


You can find more examples in the `example` directory of the [github repository](/~/diffbot).

## Source code, documentation and bug reporting

Source code: [github.com/claudiodangelis/diffbot](/~/diffbot).  
Official Diffbot APIs documentation: [diffbot.com/products](http://diffbot.com/products/automatic/).  
Library documentation: [claudiodangelis.com/docs/diffbot](/docs/diffbot).  
To file a bug please open a new [issue on github](/~/diffbot/issues).

Needless to say that contributions and feedbacks are always welcome :)

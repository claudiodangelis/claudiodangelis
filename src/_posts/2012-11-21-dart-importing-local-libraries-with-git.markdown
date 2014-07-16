---
layout: default
title: Dart&#58; importing local libraries with git
lang: en
category: dart
tags: [dart, dartlang, libraries, git]
---

We have a couple of ways to manage application's dependencies with **pub**, we can

- import a **hosted** package
- clone a git repository

Just to be clear, **hosted** packages are not hosted on a _general_ server, they are hosted on a **pub** server; since setting up our own _local_ **pub** server or taking advantage of **pub-cache** could be really tricky, a safe and fast way to import local packages is doing it via the **git** system.

<!--more-->

Let's see how to create an application, **my_app**, that imports a local library, **my_lib**.



Assume that **my_lib** and **my_app** folders are in user's home directory, e.g.

	Linux:	/home/bob/my_lib
	OS X:	/Users/bob/my_lib
	Win7	C:\Users\bob\my_lib


### my_lib

1. Create **my_lib** folder
2. Create **lib** folder within **my_lib**
3. Create **my_lib.dart** within **lib** folder and **pubspec.yaml** at top of **my_lib** folder

Here's the directory tree of ***my_lib**:

	./my_lib/
	./my_lib/lib/my_lib.dart
	./my_lib/pubspec.yaml

Content of **my_lib.dart**:

{% highlight dart %}
library my_lib;

String hello(String name){
  return 'Hello $name !';
}
{% endhighlight %}


Content of **pubspec.yaml**:

{% highlight yaml %}
name: my_lib
{% endhighlight %}


Now we have to "convert" **my_lib** into a git repository; change to **my_lib** and type:

{% highlight sh%}
git init
git add lib/my_lib.dart
git add pubspec.yaml
git commit -m "Random message"
{% endhighlight %}

We're done with _my_lib_, let's switch to _my_app_


---

### my_app

1. Create **my_app** folder
2. Create **bin** folder within **my_app**
3. Create **my_app.dart** within **bin**
4. Create **pubspec.yaml** at the top of **my_app** folder

Content of **my_app.dart**:
{% highlight dart %}
import 'package:my_lib/my_lib.dart';

main(){
  print(hello('darling'));
}
{% endhighlight %}
And now set content of **pubspec.yaml** to:

{% highlight yaml %}
name: My Application
dependencies:
  my_lib:
    git: file:///home/bob/my_lib
{% endhighlight %}

> Remember to change **git:** argument accordingly to current operating system

We're almost done. Last step is running `pub install` in **my_app** folder.
Output should return:

{% highlight sh %}
$ pub install
Resolving dependencies...
Dependencies installed!
{% endhighlight %}

> Some symlinks, **packages**, have been created in _my_app_ folder

Now we're ready to run our awesome application:
{% highlight sh %}
$ dart bin/my_app.dart
Hello darling !
{% endhighlight %}


Easy!

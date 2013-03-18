---
layout: default
title: id3
descr: Dart library to handle ID3 tags in MP3 files.
github: http://github.com/claudiodangelis/id3
path: id3
---

A Dart library to handle ID3 tags in MP3 files, currently **under active development**.

## Source code

Get the source code at [GitHub](http://github.com/claudiodangelis/id3).

## Usage

	dependencies:
	  id3:
	    git: git://github.com/claudiodangelis/id3.git


### Example:

You can run:

	dart example/tags.dart /path/to/song.mp3

or:

	import 'dart:io';
	import 'package:id3/id3.dart';

	main(){
	  var mp3file = new File(new Options().arguments[0]);
	  Id3 mySong = new Id3(mp3file);
	  print("Id3 version: ${mySong.versions[mySong.id3v]}");
	  print("Artist: ${mySong.artist}");
	  print("Title: ${mySong.title}");
	}
	
		

## Bugs

[GitHub issues](https://github.com/claudiodangelis/id3/issues)

## Credits

Songs in examples are composed and performed by the [Stereo Nose Noise](https://soundcloud.com/stereonosenoise) band.

**References**

- [id3.org](http://id3.org/)

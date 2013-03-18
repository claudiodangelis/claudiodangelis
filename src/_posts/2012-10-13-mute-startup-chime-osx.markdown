---
layout: default
title: Mute the Mac OS X startup sound, the fastest way
lang: en
category: osx
---



 Copy/paste lines below and put in your password when prompted to disable OS X startup chime.


	sudo sh -c "echo '#'"'!'"'/bin/sh\nosascript -e \"set volume without output muted\"'>/usr/local/bin/unmute"
	sudo sh -c "echo '#'"'!'"'/bin/sh\nosascript -e \"set volume with output muted\"'>/usr/local/bin/mute"
	sudo chmod a+x /usr/local/bin/mute /usr/local/bin/unmute
	sudo defaults write com.apple.loginwindow LoginHook /usr/local/bin/unmute
	sudo defaults write com.apple.loginwindow LogoutHook /usr/local/bin/mute


This code will create two shell scripts, `/usr/local/bin/unmute`, `/usr/local/bin/mute` that will execute these _AppleScripts_:

	set volume without output muted

and

	set volume with output muted

After this, the code will bind those scripts to the _LoginHook_ and _LogoutHook_ handlers: when you will log out, sound will be muted, after you logged in, sound will be un-muted. 

 If you want to restore startup chime, type:
   
	sudo defaults delete com.apple.loginwindow LoginHook
	sudo defaults delete com.apple.loginwindow LogoutHook
	sudo rm /usr/local/bin/mute /usr/local/bin/unmute

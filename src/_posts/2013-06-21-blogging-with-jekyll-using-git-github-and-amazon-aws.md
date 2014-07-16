---
layout: default
title: Blogging with Jekyll using Git, Github and Amazon AWS
lang: en
category: web
tags: [web development, blogging, aws, amazon aws, git, github]
---

I've been using **Jekyll** a lot lately, I'm totally in love with it, it's a simple,
fast and brilliant Ruby tool to generate static websites and blogs. Well,
this post is not really about Jekyll _per se_, it's more likely about the way I use it inside my
_ecosystem_.  
If you want to learn more about Jekyll, I think the [official website](http://jekyllrb.com)
is a good place to start from.

Ok, let's talk about the way I use Jekyll: I build my website locally, then I push
changes with **git** to my Amazon **AWS** instance and at the same time I keep a copy
of the blog sources on **Github** available [for consultation or forking](http://claudiodangelis.com/~/claudiodangelis).
That's it.

Just for completeness, Github itself has a great free hosting service for your site,
[Github Pages](http://pages.github.com/), that supports static sites and Jekyll blogs as well, but I'm already a (happy) AWS user
so I decided to host my site there instead of Github Pages.

So this is the scenario, now let's take a look at the workflow: I push changes
both to AWS and Github, then a _post-receive_
[hook script](http://git-scm.com/book/en/Customizing-Git-Git-Hooks) on the server
builds and publishes the Jekyll blog.

![Screenshot](/assets/img/posts/jekyll-aws.png)


In order to obtain such workflow, we have to:

1. Create a bare repository on the server
2. Add a hook script to the bare repository
3. Clone the repository locally
4. Create a github repository
5. Add github origin to the local repository
6. Configure local repository in order to push changes to both AWS and github repositories



<!--more-->

**Assumptions and conventions used for this tutorial:**

You need to [have git](http://git-scm.com/book/en/Getting-Started-Installing-Githttp://git-scm.com/book/en/Getting-Started-Installing-Git)
and [have jekyll](http://jekyllrb.com/) installed on your AWS instance.

We will use the following values, please change them accordingly to your actual/desired configuration:



| _AWS instance's user_ | **ec2-user** |
| _AWS's key pair's path_ | **~/Documents/ec2-user.pem** |
| _Website domain_ | **http://mysite.com** |
| _Blog repository's name_ | **mysite** |
| _Remote git bare repository_ | **/home/ec2-user/mysite.git** |
| _Remote git non-bare repository_ | **/home/ec2-user/mysite** |
| _Both remote and local document root_ &nbsp;&nbsp;&nbsp; | **/var/www/html** |
| _Local repository_ |  **~/workspace/mysite** |

Source files of jekyll blog are in a `src` directory of the repository
(you may want to keep a README, LICENSE or something outside the sources of your blog)

        mysite/
          .git/
          README
          LICENSE
          src/_config.yml
          src/_layouts
          src/...


Now we're ready to get started , yay!

---

1. Connect to the AWS instance and create a bare repository, then clone it to
have a working directory.

        # you're on your local machine
        ssh-add ~/Documents/ec2-user.pem
        ssh ec2-user@mysite.com

        # you're now on your home directory of your remote AWS instance
        mkdir ~/mysite.git
        cd mysite.git
        git init --bare
        cd ..
        git clone mysite.git

    Now in your home directory you have both the bare and non-bare repository,
    respectively **mysite.git** and **mysite**.

2. Add a **post-receive** hook script to remote bare repository.  

    This script will pull changes from the bare repository to the non-bare repository and
    finally will build your website. You can edit the **post-receive** hook with **nano** editor.


        # you're on your remote AWS instance
        cd ~/mysite.git/hooks/
        touch post-receive
        nano post-receive

    Now set the content of **post-receive** script:


        unset $(git rev-parse --local-env-vars)
        cd /home/ec2-user/mysite
        git pull
        cd src
        jekyll build





3. We're done with the remote instance, let's go back to the local machine and
clone the remote repository.

        # you're on your local machine
        cd ~/workspace
        ssh-add ~/Documents/ec2-user.pem
        git clone ec2-user@mysite.com:~/mysite.git

    If everything goes fine you should see this message:

        Warning: You appear to have cloned an empty repository.



4. Create a new repository on github, and be sure to **leave unchecked** the
"Initialize this repository with a README" flag.

    ![Screenshot](/assets/img/posts/github-create-new-repository.png)


5. Now we need to add the github repository as remote origin of our local repository:

        # you're on your local machine
        cd ~/workspace/mysite
        git remote add github git@github.com:your_github_username/mysite.git


    This will create a new origin named "github" for your local repository.


6. Last step. We will add an extra origin to our local repository, let's say "all",
in order to **push** changes to both AWS and github repositories at the same time.  
    To do this, edit the **.git/config** file with `nano` editor and append these
    lines at the end of file:


        [remote "all"]
                url = ec2-user@mysite.com:~/mysite.git
                url = git@github.com:your_github_username/mysite.git



We're done! Create your blog, test it, and when you're ready you can easily push
changes to AWS and github with this command:

    git push -u all master


If everything's gone fine, you should see an output like this:

    Counting objects: 27, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (19/19), done.
    Writing objects: 100% (19/19), 92.56 KiB | 0 bytes/s, done.
    Total 19 (delta 13), reused 0 (delta 0)
    . . .
    remote:  15 files changed, 151 insertions(+), 0 deletions(-)
    remote:  create mode 100644 src/assets/img/posts/github-create-new-repository.png
    remote:  create mode 100644 src/assets/img/posts/jekyll-aws.png
    remote: Configuration file: /home/ec2-user/mysite/src/_config.yml
    remote:             Source: .
    remote:        Destination: /var/www/html
    remote:       Generating... done.
    To ec2-user@emysite.com:~mysite.git
       af7c742..df6bcfc  master -> master
    Branch master set up to track remote branch master from all.
    Counting objects: 27, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (19/19), done.
    Writing objects: 100% (19/19), 92.56 KiB | 0 bytes/s, done.
    Total 19 (delta 13), reused 0 (delta 0)
    To https://github.com/your_github_username/mysite.git
       af7c742..df6bcfc  master -> master
    Branch master set up to track remote branch master from all.


---

As usual, feedback and suggestions are always welcome. Happy blogging everybody!

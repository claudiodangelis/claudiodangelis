---
layout: default
title: Blogging with Jekyll using Git, Github and Amazon AWS
lang: en
category: web
---

5 minutes. 

When you'll push your changes both to AWS and Github, then a **post-receive** [hook
script](http://git-scm.com/book/en/Customizing-Git-Git-Hooks) on the server will
build the jekyll post for you. Here's the workflow:

![Screenshot](/img/posts/jekyll-aws.png)


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
and [have jekyll](http://jekyllrb.com/) installed on you AWS instance.

We will use the following values, change them accordingly to your actual/desired configuration:

- AWS instance's user: **ec2-user**
- AWS's key pair's path: **~/Documents/ec2-user.pem**
- Website domain: **http://mysite.com**
- Blog repository's name: **mysite**
- Remote git **bare** repository: **/home/ec2-user/mysite.git** 
- Remote git **non-bare** repository: **/home/ec2-user/mysite**
- Both remote and local document root (alias `destination` value of Jekyll's `_config.yml`): **/var/www/html**
- Local repository is at **~/workspace/mysite**
- Source files of your jekyll blog are in the `src` directory of the repository
(you may want to keep a README, or LICENSE or something outside the sources of your blog)

        mysite/
          .git/
          README
          LICENSE
          src/_config.yml
          src/_layouts
          src/...


We're ready to start now, yay!

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

    ![Screenshot](/img/posts/github-create-new-repository.png)



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

---

As usual, feedback and suggestions are always welcome. Happy blogging everybody!


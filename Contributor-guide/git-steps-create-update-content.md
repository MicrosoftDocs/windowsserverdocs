<properties pageTitle="Git commands for creating a new article or updating an existing article" description="Steps to create and update an article in WindowsServerDocs-pr." metaKeywords="" services="" solutions="" documentationCenter="" authors="Kathy Davies" videoId="" scriptId="" manager="dongill" />

<tags ms.service="contributor-guide" ms.devlang="" ms.topic="article" ms.tgt_pltfrm="" ms.workload="" ms.date="08/24/16" ms.author="kathydav" />

# Git commands for creating or updating an article

If you're new to Git, learning how to work effectively can be frustrating. Here are some tips:

-  Base your local branches on a branch in the shared repo, not on your remote fork. Then, you'll push your local branches to your remote fork. From your remote fork, you'll request to have the updates in your fork merged into the shared repo. The commands in this article show you how to do this.

-  Work in branches, not in your local copy of Master. This makes it easier to recover from problems in your branches and go back to a good, known point.

-  When you create a local branch, your command tells Git what branch you want to base your new branch on. This is when and how you specify master, or a milestone or feature branch.

>!NOTE: These commands assume you've configured Github to specify the default repo where you pull files from. In Github terminology, where you pull files from is your 'upstream'. Your 'origin' is where you push files.

>To check your settings, type ```git config -l```

## 
Here's how to create a branch, save your changes, and submit them for integration into the shared repo.

1. Start Git Bash (or the command-line tool you use for Git).

2. Change to WindowsServerDocs-pr:

        cd WindowsServerDocs-pr

3. Check out the master branch:

        git checkout master

 The best way to create a local working branch from a release branch is to use to run:

    git checkout upstream/<upstream branch name> -b <local working branch name>

This creates the local branch directly from the upstream branch and avoids inadvertently merging files from the remote repo to the wrong local branch. For example, to create a working branch based on the ga-threshold branch, you could run a command like this:
      
      git checkout upstream/ga-threshold -b working-8-31  

4. Add the local working branch to your fork:

        git push origin <working branch>

5. Create your new article or make changes to an existing article. Use Windows Explorer to open markdown files, and your markdown editor to create and edit files. After you've done this, go to the next step.

6. Check status, then add and commit the changes you made:

        git status

  Review the results to make sure the files listed are the ones you changed. If ALL the files look accurate, run this command to add all of the files:

        git add .
        git commit –m "<comment>"

   To add only the specific files (for example, if `git status` lists files that you don't want to submit), run:

        git add <file path>
        git commit –m "<comment>"

   If you deleted files, you have to use this:

        git add --all
        git commit -m "<comment>"

7. Update your local working branch with changes from upstream:

        git pull upstream master

8. Push the changes to your fork on GitHub:

        git push origin <working branch>

9. When you're ready to submit your content for staging, validation, and/or publishing, use the GitHub UI to create a pull request from your fork.

>[!IMPORTANT]
> When you open a PR, triggers quality checks and publication to our internal staging site. It's your responsibility to review both, from links in comments \(from the Conversation tab of the PR\). After you've done this, indicate it by adding the "ready-to-merge" label to the PR. \(Click **Labels** or the gear icon to the right of the comment stream in the PR.)

10. The pull request acceptor reviews your pull request, provides feedback, and/or accepts your pull request.


## Publishing

- Articles are published at approximately 10:00 AM and 3:00 PM Pacific Time, Monday-Friday. It can take up to 30 minutes for articles to appear online after publishing. Remember your pull request has to be merged by a pull request reviewer before the changes can be included in the next scheduled publishing cycle. If you need an article published for a specific publication cycle, let a pull request reviewer know ahead of time.

- Before the pull request can be merged, you need to:
  - Review build details to make sure it passed quality checks
  - Review your updates on the staging site
  - Indicate you've done this by adding the **ready-to-merge** label to the pull request.

 See [Quality criteria for pull request review](contributor-guide-pr-criteria.md) for details.
 
## Another way to with release/milestone branches

1.      Create a new local working branch based off the appropriate remote branch:

        git pull upstream <remote-branch>:<working-branch>

2.      Move into the new working branch:

        git checkout <working branch>

3.      Push the new branch to your remote         
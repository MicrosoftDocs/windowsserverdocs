<properties pageTitle="Git commands for creating a new article or updating an existing article" description="Steps to create and update an article in WindowsServerDocs-pr." metaKeywords="" services="" solutions="" documentationCenter="" authors="Kathy Davies" videoId="" scriptId="" manager="dongill" />

<tags ms.service="contributor-guide" ms.devlang="" ms.topic="article" ms.tgt_pltfrm="" ms.workload="" ms.date="08/24/16" ms.author="kathydav" />

# Git commands for creating or updating an article

If you're new to Git, learning how to work effectively can be frustrating. Here are some tips:

-  Your local branches should be based on branches in the shared repo, not on your remote fork. You'll push your local branches to your remote fork. The commands in this article use this approach.

-  Work in branches, not in your local copy of Master. This makes it easier to recover from problems in your branches and go back to a good, known point.

-  When you create a local branch, your command tells Git what branch you want to base your new branch on. This is when and how you specify master, or a milestone or feature branch.

>!NOTE: These commands assume you've configured Github to specify the default repo where you pull files from. In Github terminology, where you pull files from is your 'upstream'. Your 'origin' is where you push files.

>To check your settings, type ```git config -l```

## 
These steps give you the commands to create a branch, save your changes, and submit them for integration into the shared repo.

1. Start Git Bash (or the command-line tool you use for Git).

2. Change to WindowsServerDocs-pr:

        cd WindowsServerDocs-pr

3. Check out the master branch:

        git checkout master

 The best way to create a local working branch from a release branch is to use to run:

    git checkout upstream/<upstream branch name> -b <local working branch name>

This creates the local branch directly from the upstream branch and avoids inadvertently merging files from the remote repo to the wrong local branch.       

4. Add the local working branch to your fork:

        git push origin <working branch>

5. Create your new article or make changes to an existing article. Use Windows Explorer to open markdown files, and your markdown editor to create and edit files. After you've done this, go to the next step.

6. Check status, then add and commit the changes you made:

        git status

  Review the results to make sure the files listed are the ones you changed. If all the files look accurate, run:

        git add .
        git commit –m "<comment>"

   To add only the specific files you changed (for example, if git status reports changed files that you don't want to submit), run:

        git add <file path>
        git commit –m "<comment>"

   If you deleted files, you have to use this:

        git add --all
        git commit -m "<comment>"

7. Update your local working branch with changes from upstream:

        git pull upstream master

8. Push the changes to your fork on GitHub:

        git push origin <working branch>

9. When you are ready to submit your content to the upstream master branch for staging, validation, and/or publishing, in the GitHub UI, create a pull request from your fork to the master branch.

10. If you are an employee working in the private repository, the changes you submit are automatically staged and a staging link is written to the pull request. Review your staged content and sign off in the pull request comments by adding the **#sign-off** comment.  This indicates the changes are ready to be pushed live.  If you don't want the pull request to be accepted - if you are just staging the changes - add the **#hold-off** note to the pull request.

11. The pull request acceptor reviews your pull request, provides feedback, and/or accepts your pull request.

12. Optionally verify your published article or changes at

 http://technet.microsoft.com/system-center-docs///*name-of-your-article-without-the-MD-extension*

## Publishing

- Articles are published at approximately 10:00 AM and 3:00 PM Pacific Time, Monday-Friday. It can take up to 30 minutes for articles to appear online after publishing. Remember your pull request has to be merged by a pull request reviewer before the changes can be included in the next scheduled publishing run. You need to work with your pull request reviewer ahead of time to ensure a pull request is merged for a specific publishing run. Otherwise, PRs are reviewed in the order they were submitted.

- All pull requests are subject to validation rules that need to be addressed before the pull request can be merged.

## Another way to with release/milestone branches

1.      Create a new local working branch based off the appropriate remote branch:

        git pull upstream <remote-branch>:<working-branch>

2.      Move into the new working branch:

        git checkout <working branch>

3.      Push the new branch to your remote         
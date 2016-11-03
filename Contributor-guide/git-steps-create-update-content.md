<properties pageTitle="Git commands for creating a new article or updating an existing article" description="Steps to create and update an article in WindowsServerDocs-pr." metaKeywords="" services="" solutions="" documentationCenter="" authors="Kathy Davies" videoId="" scriptId="" manager="dongill" />

<tags ms.service="contributor-guide" ms.devlang="" ms.topic="article" ms.tgt_pltfrm="" ms.workload="" ms.date="08/24/16" ms.author="kathydav" />

# Git commands to create or update an article

>!NOTE: These commands assume you've configured Github to specify the default repo where you pull files from. In Github terminology, where you pull files from is your *upstream*. Where you push files to is your *origin*. Based on how our repo and workflow are designed, your upstream should be set to our repo, which is under the Microsoft organization - https://github.com/Microsoft/WindowsServerDocs-pr and your origin should be your fork of this repo, under your own Github account. For example, Kathy's is https://github.com/KBDAzure/WindowsServerDocs-pr 

>To check your settings, type ```git config -l```. Look at the URLs to make sure they refer to location you intended.

## Add or update an article

Here's how to create a local branch, save your changes, and then push them to your remote fork.

1. Start Git Bash (or the command-line tool you use for Git).

2. Change to WindowsServerDocs-pr:

        cd WindowsServerDocs-pr

3. It's best to keep your local Master branch and the remote Master branch in your fork in sync with the repo's Master branch. This can help save you a lot of frustration and lost time -- you're more likely to catch issues early and keep things in a good, known working state. Run:

        git checkout master
        git pull upstream master
        git push origin master

4. Now you're ready to create a branch to do your daily or deliverable-based work in. The best way to create a local working branch from a release branch is to use to run:

        git checkout upstream/upstream-branch-name -b your-local-branch-name

  This creates the local branch directly from the upstream branch and helps you avoid merging the wrong files into your new local branch. For example, to create a working branch based on the ga-threshold branch, you could run a command like this:
      
        git checkout upstream/ga-threshold -b working-8-31  

5. Add the local working branch to your fork:

        git push origin <working branch>

6. Create your new article or make changes to an existing article. Use Windows Explorer to open markdown files, and your markdown editor to create and edit files. For basic formatting help, see this [article](https://help.github.com/articles/getting-started-with-writing-and-formatting-on-github/) in Github.

7. Add required metadata and version info, according to [Metadata and product versioning](metadata-and-subject-versioning.md).

8. Check status, then add and commit your changes:

        git status

  Review the results to make sure the files listed are the ones you changed. If ALL the files look accurate, run this command to add all of the files:

        git add .
        git commit –m "<comment>"

  To add only the specific files (for example, if ```git status``` lists files that you don't want to submit), instead you MUST run:

        git add <file path>
        git commit –m "<comment>"

>[!IMPORTANT]
>The command ```git add .``` adds ALL pending changes reported by ```git status```. This means that if ```git status``` shows untracked updates that you don't want to add, use ```git add <file path>``` instead.  

9. Update your local working branch with changes from upstream:

        git pull upstream master

10. Push the changes to your fork on GitHub:

        git push origin <working branch>

## Submit your changes

When you're ready to submit your content for staging, validation, and/or publishing, use the GitHub UI to create a pull request. 

When you open a pull request (PR), this triggers a test pass, builds the project and publishes to our internal staging site. It's okay to open a pull request that you're not ready to have merged because this is how you get a test pass and check your updates on the staging site. Build details and staging links are posted as comments to the PR. 

It's your responsibility to do the following **before you ask to have your changes merged**:
  - Review build details to make sure it contains no errors. 
  - Review your updates on the staging site.

After you've done this, indicate it by either:
- Adding the "ready-to-merge" label to the PR. \(Click **Labels** or the gear icon to the right of the comment stream in the PR.)
- Adding ready-to-merge as a comment and send email to the WSSC Pull Reviewers alias: wssc-pra

The PR reviewer checks your changes and accepts the PR unless there are issues or questions. Feedback or requests to fix issues are added as comments. Review [Quality criteria for pull request review](contributor-guide-pr-criteria.md) to learn what's expected.

## Publishing

- Articles are published at around 10:00 AM and 3:00 PM Pacific Time, Monday-Friday. Keep in mind that a pull request reviewer needs time to review and accept your changes before they can merged. Changes must be merged to be picked up in the next scheduled publishing cycle. If you need an article published for a specific publication cycle, let a pull request reviewer know ahead of time. When your PR is accepted, your changes are merged into the repo and will be included in the next time publication run. It can take up to 30 minutes for articles to appear online after publishing. 
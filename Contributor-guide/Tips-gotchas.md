# Tips and gotcha's

If you're new to Git, learning to work effectively can be frustrating. Info is collected here so it's easier to find than if it's included within the other info in this guide.

## Basics:

Commands in this Contributor's Guide assume you've configured Github to specify the default repo where you pull files from. In Github terminology, where you pull files from is your *upstream*. Where you push files to is your *origin*. 

Because of on how our repo and workflow are designed, your upstream should be set to our repo, which is under the Microsoft organization - https://github.com/Microsoft/WindowsServerDocs-pr and your origin should be your fork of this repo, which is under your own Github account. For example, https://github.com/MY-GITHUB-ALIAS/WindowsServerDocs-pr 

>To check your settings, type ```git config -l```. Look at the URLs to make sure they refer to location you intended.

Some basic branch tips:

-  Work in branches, not in your local copy of Master. This makes it easier to recover from problems in your branches and go back to a good, known point.

-  Base your local branches on a branch in the shared repo, not on your remote fork. Then, you'll push your local branches to your remote fork. From your remote fork, you'll request to have the updates in your fork merged into the shared repo. The commands in this article show you how to do this.

-  When you create a local branch, your command tells Git what branch you want to base your new branch on. This is when and how you specify master, or a milestone or feature branch. For example, this command creates a new branch from an upstream branch and then checks out the new branch so you're ready to work in it:

        git checkout upstream/upstream-branch-name -b your-local-branch-name

## Gotcha's

### Deleting files
It doesn't work to just delete a file from your file system. Use Git commands to let the system know you intended to do this, otherwise your deleted files will probably become zombie files that reappear. And never at a good time. After all, this is a source control system and if you don't tell it you really want to get rid of these files, it will helpfully add them back for you. Thanks, Git! For instructions, see [Rename or retire an article](rename-r-retire.md).

### Merge conflicts

If you get a merge conflict while working locally, you either need to fix it or back out of it. The vast majority of the time it's best to just fix them, unless they're not your files. Keep in mind if you do nothing, you might be blocked from pushing your changes to your origin, so you will have to do to something.

**How to fix** -- Azure guidance has more info about this and instructions for resolving the conflict. **A PR with merge conflicts should never be accepted**. Be sure to substitute the name of our repo and branches in all examples when you review the [instructions](https://microsoft.sharepoint.com/teams/azurecontentguidance/wiki/Pages/Resolve%20a%20local%20merge%20conflict%20yourself.aspx). 

**How to back out** --  If the conflicts are in files you don't own or there's a reason you can't fix them at the time, here's how to back out. This resets your local set of files back to how they were before the merge conflict happened. Run this command:

```git merge --abort```

If you haven't staged and committed your local work, you can do so now. But, if you push those changes and open a PR, the conflict will probably reappear if it was in the files with changes. You'll have to fix it or get help from someone else to fix it, before the request can be accepted. Because of this, it's best to only use the method to unblock yourself if you have urgent work, such as a critical update.


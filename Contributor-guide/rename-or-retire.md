# Rename or delete an article

Before you rename or delete an article, you need to follow this process to avoid or reduce the number of broken links. Customers hate broken links and aren't shy about sounding off when they hit one. Note that renaming or deleting an article is the last step in this process, not the first.


## Step 1: Manage inbound links

Determine if there are any non-Microsoft inbound links to your content, such as blogs, forums, and other content on the web. Contact blog owners to change these links, and remove or update links from forum posts. Web analytics tools can help identify high traffic inbound links you might need to manage in this way.

## Step 2: Remove all crosslinks to the article from the WindowsServerDocs-pr repository

1. Refresh your local branch – run `git pull upstream <branch>`, ie to refresh from master, run `git pull upstream master`

2.	Scan the WindowsServerDocs-pr folder to find articles that have a link to the article you want to rename or retire, then update the articles to remove the links or replace them with links to another article. You can use a search and replace utility to find the crosslinks if you have one installed. If you don't, you can use Windows PowerShell:

 a. Start Windows PowerShell.

 b. At the PowerShell prompt, change into the WindowsServerDocs-pr folder:

 `cd WindowsServerDocs-pr\WindowsServerDocs-pr`

 c. Run a command to list all files that contain a link to the article to rename or delete:

 `Get-ChildItem -Recurse -Include *.md* | Select-String "<the name of the topic you are deleting>" | group path | select name`

  To send the list of file names to a text file (in this case, named psoutput.txt), run:

  `Get-ChildItem -Recurse -Include *.md* | Select-String "<the name of the topic you are deleting>" | group path | select name | Out-File C:\Users\<your account>\psoutput.txt`

3. Add and commit all your changes, push them to your fork, and open a pull request. For instructions, see [Git commands to create or update an article](git-steps-create-update-content.md).

## Step 3: Update FWLinks

Check the FWLink tool for any FWLinks that point to the article. Point any FWLinks at replacement content; if you are not on the alias that owns the link, join it. If the owners won't update the link, file a ticket with MSCOM to have the link changed. More info - [internal wiki](http://sharepoint/sites/azurecontentguidance/wiki/Pages/Manage%20inbound%20links%20to%20retired%20topics.aspx).

## Step 4: Remove crosslinks to the article from table of contents

Work with the person who maintains the ToC.md file. This file populates the left-hand table of contents in the technical library. If you don't know who to contact, send email to wssc-pra@microsoft.com.

## Step 5: Add redirects
If you're renaming ore deleting a file, add a redirect so that existing links don't break:

1. Leave the old file in the existing location with the existing file name.
2. Replace the content in the file with this piece of metadata:
   ```
   ---
   redirect_url: <redirection-URL-or-file>
   ---
   ```
   \<redirection-URL-or-file> is the full URL to a different location or is the path+filename to a different topic in the same OPS repo.

   For example - this would be the whole file:

   ```
   ---
   redirect_url: ../../failover-clustering/whats-new-in-failover-clustering
   ---
   ```

3. After creating a PR for the redirect, click the links in the comments for the PR - if the redirect works you should get to the target topic.

## Step 6: Rename or delete the article

If you're not using a redirect, do this step after you've completed the previous steps and all affected articles are published. If you are using a redirect, renaming or deleting the article would undo this and cause a broken link. 
To rename a file, simply rename it in the file system, then add, commit and push the change, and then open a pull request.
To delete a file, first you need to know that it doesn't work to just delete a file from your file system because this is a source control system and it needs to know you intended to do this. Otherwise your deleted files will probably reappear.
There are two ways to do this:

- File system and git:
    Delete the file from the file system. Then from your git tool, run one of the following  ```Git add -A``` | ```Git add --all``` | ```Git add -u```
- Just git:
    Run ```git rm foo.md```

    More info [http://stackoverflow.com/questions/2047465/how-can-i-delete-a-file-from-git-repo](http://stackoverflow.com/questions/2047465/how-can-i-delete-a-file-from-git-repo) and [https://git-scm.com/docs/git-rm](https://git-scm.com/docs/git-rm) 

## Step 7: Find and fix straggler broken links

Use the content QA tool to find broken links that the previous steps didn't catch, then remove or fix the links.

## Step 8: Remove cached pages from search engines

Go to these web pages to remove cached web pages from search engines:
[Bing](https://www.bing.com/webmaster/tools/content-removal?rflid=1)
[Google](https://www.google.com/webmasters/tools/removals?pli=1)


### Contributors' guide links

- [Index of guidance articles](./contributor-guide-index.md)


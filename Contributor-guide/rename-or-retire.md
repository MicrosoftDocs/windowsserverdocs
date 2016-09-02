# Change the name of an article or delete it

Before you change the name of an article or delete, you need to follow this process to avoid or reduce the number of broken links. Customers hate broken links and aren't shy about sounding off when they hit one. Note that renaming or deleting an article is the last step in this process, not the first.

## Step 1: Manage inbound links

Determine if there are any non-Microsoft inbound links to your content, such as blogs, forums, and other content on the web. Contact blog owners to change these links, and remove or update links from forum posts. Web analytics tools can help identify high traffic inbound links you might need to manage in this way.

## Step 2: Remove all crosslinks to the article from the WindowsServerDocs-pr repository

1. Refresh your local branch – run `git pull upstream <branch>`, ie to refresh from master, run `git pull upstream master`

2.	Scan the WindowsServerDocs-pr folder to find articles that have a link to the article you want to retire, then update the articles to remove the links or replace them with links to another article. You can use a search and replace utility to find the crosslinks if you have one installed. If you don't, you can use Windows PowerShell:

 a. Start Windows PowerShell.

 b. At the PowerShell prompt, change into the WindowsServerDocs-pr folder:

 `cd WindowsServerDocs-pr\WindowsServerDocs-pr`

 c. Run a command to list all files that contain a link to the article to rename or delete:

 `Get-ChildItem -Recurse -Include *.md* | Select-String "<the name of the topic you are deleting>" | group path | select name`

  To send the list of file names to a text file (in this case, named psoutput.txt), run:

  `Get-ChildItem -Recurse -Include *.md* | Select-String "<the name of the topic you are deleting>" | group path | select name | Out-File C:\Users\<your account>\psoutput.txt`

3. Add and commit all your changes, push them to your fork, and open a pull request. For instructions, see [Git commands for creating or updating an article](git-steps-create-update-content.md).

## Step 3: Update FWLinks

Check the FWLink tool for any FWLinks that point to the article. Point any FWLinks at replacement content; if you are not on the alias that owns the link, join it. If the owners won't update the link, file a ticket with MSCOM to have the link changed. More info - [internal wiki](http://sharepoint/sites/azurecontentguidance/wiki/Pages/Manage%20inbound%20links%20to%20retired%20topics.aspx).

## Step 4: Remove crosslinks to the article from table of contents and create a redirect for the retired page, if appropriate

Work with the person who maintains the ToC.md file. This file populates the left-hand table of contents in the technical library. If you don't know who to contact, send email to wssc-pra@microsoft.com.

## Step 5: Rename or retire the article

After you've completed the previous steps and all affected articles are published, then you can rename or remove the file in your local clone, then push the change and open a pull request.

## Step 6: Find and fix straggler broken links

Use the content QA tool to find broken links that the previous steps didn't catch, then remove or fix the links.

## Step 7: Remove cached pages from search engines

Go to these web pages to remove cached web pages from search engines:
[Bing](https://www.bing.com/webmaster/tools/content-removal?rflid=1)
[Google](https://www.google.com/webmasters/tools/removals?pli=1)


### Contributors' guide links

- [Overview article](./../README.md)
- [Index of guidance articles](./contributor-guide-index.md)


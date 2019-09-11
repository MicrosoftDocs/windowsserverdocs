---
title: Edit an existing Windows Server article using GitHub and Visual Studio Code
description: How to edit an existing Windows Server-related articles, using GitHub and Visual Studio Code, as a Microsoft employee.
author: eross-msft
ms.author: lizross
ms.date: 05/06/2019
---

# Edit an existing Windows Server article using GitHub and Visual Studio Code

There are two separate locations where we keep Windows Server technical content. One of the locations is public (windowsserverdocs) while the other is private (windowsserverdocs-pr). Who you are determines which location you contribute to:

- **I'm a Microsoft employee.** As a Microsoft employee, you have options, based on what you're trying to do:

    - **Create a brand-new article.** To create a brand-new article, you must create and set up your GitHub account and tools, fork and clone the windowsserverdocs-pr repo, set up your remote branch, create the article, and finally create a new pull request for approval and publishing. For these instructions, you can follow the instructions in the [Create new Windows Server articles using GitHub and Visual Studio Code](create-new-using-github.md) article.

    - **Make large changes to an existing article.** To make substantial changes to an existing article, you can follow the instructions in this article.

    - **Make minor changes to an existing article.** To make minor changes to an existing article, you can follow the instructions in the [Update existing Windows Server articles using a web browser and GitHub](github-browser-updates.md) article.

- **I'm not a Microsoft employee.** As a non-Microsoft employee, you must contribute to the public location. For information about how to do that, see the [Contributing to Windows Server technical documentation](https://github.com/MicrosoftDocs/windowsserverdocs/blob/master/CONTRIBUTING.md) article.

## Switch your repo and create a new branch

Follow these steps to edit an existing article.

### Create a new branch and locate the file you want to update

Before you can start to work on your content, you must first change to the windowsserverdocs-pr repo and then locate the article you want to update.

#### To create a new branch in Git Bash

- Open Git Bash and type the commands (one at a time):

    ```markdown
    cd windowsserverdocs-pr

    git checkout –B <name_of_your_new_branch>

    git push origin <name_of_your_new_branch>
    ```

    >[!Note]
    >We highly recommend naming your branch something obvious and unique so you can find it again later.

    After the commands finish, you'll be in your new branch and ready to edit your file.

#### To locate your article and make your edits

1. Open Visual Studio Code and go to **File**, select **Open folder**, and then go to the GitHub location of the folder that has the article you want to edit.

2. From the **Explorer** pane, select the file.

3. Update the information on the page, and then select **File** > **Save**.

### Preview your text

After you update the text, you must preview your changes to make sure they appear correctly.

#### To preview your text

1. In Visual Studio Code, select either of the **Preview** buttons from the upper right-hand corner.

    ![preview button icon](media/create-new-using-github/preview-button-full-page.png): Switches to a full-page preview of your content.

    ![preview button icon](media/create-new-using-github/preview-button-side-by-side.png): Opens the preview page next to your working page, side-by-side.

2. Make sure your article looks how you expect it to look.

    After you're sure it looks right, you can commit your changes and create a pull request for publication.

### Commit your changes

After you make sure your text looks right, you can commit your changes to your local version of your repo.

#### To commit your changes

- Open Git Bash and type the commands (one at a time, removing the OPTIONAL tags):

    ```markdown
    OPTIONAL: git status

    git add .

    git commit -m “public comment about what change is”

    OPTIONAL: git pull upstream master

    git push origin <name_of_your_new_branch>

    ```

    The optional git status command shows you which files have been modified as part of this commit. The optional git pull upstream master pulls down the latest content changes from the MicrosoftDocs master branch, syncing your local content with the primary master content. This helps to show you any potential merge conflicts ahead of time so you can fix them before you get to the PR stage.

### Submit a pull request for review and publication

After you've completed your updates, you must get approval from your writer (allow some time for this) for publication.

#### To submit your pull request

1. Go to https://github.com/MicrosoftDocs/windowsserverdocs-pr and select the **Pull requests** tab.

2. In the **Reviewers** area of the right pane, select the gear icon, and then enter the _windowsservercontent_ alias for review.

    A member of the _windowsservercontent_ alias will review your changes or add comments about things that must be changed before merging can happen.

3. Type **#sign-off** into the comments so that the reviewers know you're handing off for both review and publishing. The **#sign-off** comment:

    - Updates the label for your pull request from **do-not-merge** to **ready-to merge**.

    - Lets the alias and writers know that you're ready to have your content reviewed.

    - Lets the admins know that after approval, your content is ready go live.

    >[!Important]
    >After you add the #sign-off comment, a member of the windowsservercontent team will review the text and push it to master so it will go out with the next scheduled publish to live (10:30am and 3:30pm weekdays).
    >
    >If you don't add #sign-off as a final comment to your PR, your content will remain in the queue without being pushed to Master and ultimately to Live.

## Related information

For more information about GitHub and the markdown language, see:

### Git concepts

- [GitHub Guides-Git Handbook Intro](https://guides.github.com/introduction/git-handbook/)

- [GitHub Guides-Forking projects](https://guides.github.com/activities/forking/)

- [GitHub Guides-Understanding the GitHub flow](https://guides.github.com/introduction/flow/)

- [Learn Git Branching](https://learngitbranching.js.org/ (Great for visual learners!))

### Markdown

- [Our internal markdown guidance](https://review.docs.microsoft.com/help/contribute/markdown-reference?branch=master)

- [External, GitHub tutorial](https://www.markdowntutorial.com/)
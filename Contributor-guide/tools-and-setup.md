<properties
pageTitle="Install and set up tools for authoring in GitHub"
description="Tools and steps to set up to write Windows Server content in GitHub."
services="contributor-guide"
documentationCenter=""
authors="Kathydav"  
manager="dongill" />

<tags
ms.service=""
 ms.devlang=""
 ms.topic="article"
  ms.tgt_pltfrm=""
  ms.workload=""
  ms.date="08/23/2016"
  ms.author="jimpark;tysonn" />

# Install and set up tools for authoring in GitHub

If you don't know Git, you might want to review some Git terminology before you get set up: [https://help.github.com/articles/github-glossary](https://help.github.com/articles/github-glossary). In addition, this StackOverflow thread contains a glossary of Git terms you'll encounter in this set of steps: [http://stackoverflow.com/questions/7076164/terminology-used-by-git](http://stackoverflow.com/questions/7076164/terminology-used-by-git)

- [Create a GitHub account and set up your profile](#create-a-github-account-and-set-up-your-profile)
- [Enable multifactor authentication for your Github Account](#enable-multifactor-authentication-for-your-github-account)
- [Link your GitHub account to your Microsoft identity](#link-your-github-account-to-your-microsoft-identity)
- [Authorize the OPS build system to access your GitHub account](#authorize-the-ops-build-system-to-access-your-github-account)
- [Install and configure git tools](#install-and-configure-git-tools)
- [Install a markdown editor](#install-a-markdown-editor)
- [Configure Atom](#configure-atom)
- [Fork the repository and copy it to your computer](#fork-the-repository-and-copy-it-to-your-computer)
- [Configure your user name and email locally](#configure-your-user-name-and-email-locally)
- [Next steps](#next-steps)

## Create a GitHub account and set up your profile

The sign up page is at [https://github.com/join](https://github.com/join). If you already have a personal Github account, you’ll need to set up a Microsoft-specific account.

Your GitHub account must clearly identify you as a Microsoft employee. Set up your profile as follows:

- **Profile picture**: a picture of you (required)
- **Name**: your first and last name (required)
- **Email**: your Microsoft email address (optional)
- **Company**: Microsoft Corporation (required)
- **Location**: list your location (optional)

## Enable multifactor authentication for your Github Account
Two factor authentication (2FA) is required because you're working in a private content repository.

To do this, follow the instructions in both the following GitHub help topics:

- [About Two-Factor Authentication](https://help.github.com/articles/about-two-factor-authentication/)
- [Creating an access token for command-line use](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)

When you create the token, select all available scopes. See [details on each scope](https://developer.github.com/v3/oauth/#scopes) for details.

After you enable 2FA, you have to enter the access token instead of your GitHub password at the command prompt when you try to access a GitHub repository from the command line. The access token is NOT the authentication code that you get in a text message when you set up 2FA. It's a long string that looks something like this: fdd3b7d3d4f0d2bb2cd3d58dba54bd6bafcd8dee.

A few notes about this:

- When you create your access token, save it in a text file. You'll need it later when you copy the repo to your computer.
- Later, when you need to paste the token, do one of the following to paste in the command line:
    - Click the icon in the upper left corner of the command line window>Edit>Paste.
    - Right-click the icon in the upper left corner of the window and click Properties>Options>QuickEdit Mode. This configures the command line so you can paste by right-clicking in the command line window.

## Link your GitHub account to your Microsoft identity

Go to [https://opensourcehub.microsoft.com/](https://opensourcehub.microsoft.com/)

If you see a page like this, it means your GitHub account and Microsoft alias are not yet linked.

![profile not linked](./media/tools-and-setup/image1.png)

### Link your account

1. Click either the red link icon next to your picture at the top of the page or **Link account**.

    ![link account](./media/tools-and-setup/image2.png)

2. Click **Link a GitHub account**.

    ![link a GitHub account](./media/tools-and-setup/image3.png)

3. Verify the steps on the next page.

4. Click **Authorize application** to authorize the Open Source Hub application in your GitHub account. After a short time, you should see the Congratulations page that looks like this.

    ![authorize application](./media/tools-and-setup/image4.png)

5. Accept the invitation to join the Microsoft GitHub Organization at [https://github.com/Microsoft](https://github.com/Microsoft). If you see a red "!" mark, just click the green link beside it to complete that task.

Now your alias is linked with your GitHub account and you have successfully joined the Microsoft GitHub organization. You will receive a notification email that your GitHub account has been linked with your Microsoft account.

Note that developers and teams have a responsibility to make sure any open source contribution fully complies with [Microsoft's open source policies](https://microsoft.sharepoint.com/sites/lcaweb/Home/Product-Development/Using-Open-Source-Software) and that you have worked with your LCA contact to make sure any contributions you are making are approved.

## Authorize the OPS build system to access your GitHub account

Do this by going to [https://op-portal-prod.azurewebsites.net/#/login](https://op-portal-prod.azurewebsites.net/#/login) and signing in with your GitHub credentials.

## Install and configure git tools

Install Git for Windows from [http://git-scm.com/download/win](http://git-scm.com/download/win). This download installs the Git version control system, and it installs Git Bash, the command-line app that you will use to interact with your local Git repository.

You can accept the default settings; if you want the commands to be available within the Windows command line, select the option that enables it.

 ![GitHub profile example](./media/tools-and-setup/gitbashinstall.png)

(Note: This is not the same as "Github for Windows". "Github for Windows" is a different GUI-based tool that also work. More info here -- [https://windows.github.com/](https://windows.github.com/))

## Install a markdown editor

We author content using simple "markdown" notation in the files, rather than complex "markup" (HTML, XML, etc.). So, you'll need to install a markdown editor.

- **Atom**: Many use GitHub's Atom markdown editor: [http://atom.io](http://atom.io). It doesn't require a license for business use and has spell check.

- **Notepad**: You can use Notepad for a very lightweight option.

- **Prose**: This is a lightweight, elegant, on-line, and open source markdown editor that offers a preview. Visit [http://prose.io](http://prose.io) and authorize Prose in your repository.

- **[Visual Studio Code](https://www.visualstudio.com/products/code-vs.aspx)** - Microsoft's entry in this space.

## Configure Atom

If you use Atom, you'll need to set a few things up.

- Atom defaults to using 2 spaces for tabs, but Markdown expects 4 spaces. If you leave it at the default of two, your article will look great in local preview, but not when it’s imported into OPS. So, configure Atom to use 4 spaces - you can find this setting under File>Settings>Editor Settings>Tab Length.
- You will probably also want to turn on Soft Wrap in this section too, which does the same as "word wrap" in Notepad.
- To turn on preview, click Packages > Markdown Preview > Toggle Preview. Use Ctrl-Shift-M to toggle the preview HTML view.

## Fork the repository and copy it to your computer

1. Create a fork of the repository in GitHub - go to the top-right of the page and click the Fork button. If prompted, select your account as the location where the fork should be created. This creates a copy of the repository within your Git Hub account. Generally speaking, technical writers and program managers need to fork windowsserverdocs-pr. You only need to fork one time; after your first setup, if you want to copy your fork to another computer, you only have to run the commands that follow in this section to copy the repo to your computer.  If you choose to create forks of both repositories, you will need to create a fork for each repository.

2. Copy the Personal Access Token that you got from [https://github.com/settings/tokens](https://github.com/settings/tokens). You can accept the default permissions for the token.  Save the Personal Access Token in a text file for later reuse.

3. Copy the repository to your computer with your credentials embedded in the command string.  To do this, open Git Bash and run it as an administrator. At the command prompt, enter the following command.  This command creates a windowsserverdocs-pr directory on your computer.  If you're using the default location, it will be at c:\users<your Windows user name>\windowsserverdocs-pr.

        git clone https://[your GitHub user name]:[token]@github.com/<your GitHub user name>/windowsserverdocs-pr.git

For example, this clone command could look something like this:

        git clone https://smithj:b428654321d613773d423ef2f173ddf4a312345@github.com/smithj/windowsserverdocs-pr.git  

## Set remote repository connection and configure credentials

Create a reference to the root repository by entering these commands. This sets up connections to the repository in GitHub so that you can get the latest changes onto your local machine and push your changes back to GitHub. This command also configures your token locally so that you don't have to enter your name and password each time you try to access the upstream repo and your fork on GitHub.

        cd windowsserverdocs-pr
        git remote add upstream https://[your GitHub user name]:[token]@github.com/Microsoft/windowsserverdocs-pr.git
        git fetch upstream

This usually takes a while. After you do this, you won't have to fork again or enter your credentials again unless you set the tools up on another computer.

## Configure your user name and email locally

To ensure you are listed correctly as a contributor, you need to configure your user name and email locally in Git.

1. Start Git Bash, and switch into windowsserverdocs-pr:

   ````
   cd windowsserverdocs-pr
   ````

2. Set your user name to match your name in your GitHub profile:

    ````
    git config --global user.name "John Doe"
    ````
3. Configure your email to match the primary email in your GitHub profile; if you're a MSFT employee, it should be your MSFT email address:

    ````
    git config --global user.email "alias@example.com"
    ````
4. Type `git config -l` and review the user name and email settings.

##Next steps

- Understand the type of content that belongs in the technical content repo, and what doesn't. See the [content channel guidance](https://github.com/Azure/azure-content-pr/blob/master/contributor-guide/content-channel-guidance.md)!
- Follow [these steps to create or update an article and submit it for publishing](./git-commands-for-master.md).
- Use [this checklist to verify your pull request meets the quality criteria](./contributor-guide-pr-criteria.md) for merging.


###Contributors' guide navigation

- [Overview article](./../README.md)
- [Index of guidance articles](./contributor-guide-index.md)



<!--Anchors-->
[Use a customer-friendly voice]: #use-a-customer-friendly-voice
[Consider localization and machine translation]: #consider-localization-and-machine-translation
[other style and voice issues to watch for]: #other-style-and-voice-issues-to-watch-for


[Create a GitHub account and set up your profile]: #create-a-github-account-and-set-up-your-profile
[Determine whether you really need to follow the rest of these steps]: #determine-whether-you-really-need-to-follow-the-rest-of-these-steps
[Permissions in GitHub]: #permissions-in-github
[Install Git for Windows]: #install-git-for-windows
[Enable two-factor authentication]: #enable-two-factor-authentication
[Install a markdown editor]: #install-a-markdown-editor
[Fork the repository and copy it to your computer]: #fork-the-repository-and-copy-it-to-your-computer
[Install git-credential-winstore]: #install-git-credential-winstore
[Sign up for Disqus]: #sign-up-for-disqus
[Configure your user name and email locally]: #configure-your-user-name-and-email-locally
[Next steps]: #next-steps
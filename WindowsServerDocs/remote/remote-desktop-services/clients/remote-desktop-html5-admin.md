---
title: Getting started with the Remote Desktop web client for admins
description: Describes how an admin can set up the Remote Desktop web client.
ms.prod: remote-desktop-modern-infrastructure
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 3/1/2018
ms.topic: article
author: Heidilohr
---
# Getting started with the Remote Desktop web client for admins

## Requirements

Before getting started, keep the following things in mind:

* You'll need a Remote Desktop deployment with Gateway, Broker and RDWA roles all running Server 2016 Operating System. The endpoints (RDSH or Windows Client SKUs) can run any Windows OS with Windows 7 SP1 or Windows Server 2008 R2 or later. Client performance will be at its best when connecting to Windows Server 2016 or Windows 10 Anniversary Edition or later.
* The Remote Desktop deployment should not be configured to use per-device license.
* The Server 2016 machine hosting the RD Gateway role must have the [Windows 10 KB4025334 update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) installed.
* The Gateway and RDWA roles of your deployment should use public trusted certificates.

## Get the web client and start using it

To install the web client for the first time, follow these steps:

1. On the RD Broker machine, obtain the certificate used for RD connections and export it as a .cer file. Copy the .cer file from the RD Broker to the machine running the RDWeb role.
1. On the RDWeb server machine:
1. Copy the content of **rd-html5-manage.zip** into **%ProgramFiles%\rd-html5-manage**.
1. Copy the content of **rd-html5-packages.zip** into **%ProgramFiles%\rd-html5-packages**.
1. Open an Administrator PowerShell prompt.
1. First, run this command:
    ```PowerShell
    Import-Module ($Env:ProgramFiles + '\rd-html5-manage\RDWebClientManagement')
    ```
    
1. Then run this command:
    ```PowerShell
    Install-RDWebClientPackage
    ```
    
1. After that, run this command with the bracketed value replaced with the .cer file path you copied from the RD Broker:
    ```PowerShell
    Import-RDWebClientBrokerCert <.cer file path>
    ```
    
1. Finally, run this command:
    ```PowerShell
    Publish-RDWebClientPackage -Production -Latest
    ```
    
1. Make sure the web client can be accessed at the web client URL with your server name, formatted as <https://server_FQDN/RDWeb/Pages/webclient>. It's important to use the server name that matches the RDWeb public cert in the URL (typically the machine FQDN).

### Updating the web client

To update the web client whenever an update is available, follow these steps:

* Copy the content of **rd-html5-packages.zip** into **%ProgramFiles%\rd-html5-packages**.
* Open an Administrator PowerShell prompt and run the following two commands:
    ```PowerShell
    Import-Module ($Env:ProgramFiles + '\rd-html5-manage\RDWebClientManagement')
    ```

    ```PowerShell
    Install-RDWebClientPackage
    ```
* Optionally, you can publish the client for testing before official release by running this command:
    ```PowerShell
    Run Publish-RDWebClientPackage -Test -Latest
    ```

    The client should appear on the test URL that corresponds to your web client URL (for example, <https://server_FQDN/RDWeb/Pages/webclient-test>).
* Publish the client for users by running the following command:
    ```PowerShell
    Publish-RDWebClientPackage -Production -Latest
    ```

    This will replace the client for all users when they relaunch the web page.

To see a list of all supported commands for the RDWebClientManagement module, run **Get-Commands** in PowerShell.


### Why does my browser show a security warning when I try to access the web client?

The RDWA role might not be using a trusted certificate. If it isn't, export the certificate and install it manually on the client machine to the trusted root store, then relaunch the browser.

If that doesn't work, that means your server name in the web client URL doesn't exactly match the name provided by the RDWeb certificate. Make sure you're using the FQDN of the machine hosting the RDWeb role.

### Why am I getting an "unsupported browser" error when launching the web client in IE 11?

This is an issue with your browser's settings. To fix this, open up "Compatibility View settings" in your browser, then uncheck the "Display intranet sites in Compatibility view" option's checkbox.

### Why can't I connect to the web client even though I can see the feed?

There are two things that might cause this:

- The RD Gateway role isn't using a trusted public certificate.
- The RD Gateway machine isn't up to date.

If your connection issue is caused by the certificate, close the browser, export the certificate and install it manually on the client machine's trusted root store, then relaunch the browser.

If installing the certificate doesn't solve the connectivity problem, then the issue might be that your RD Gateway machine isn't up to date. Make sure that you have installed [this update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) to the machine.

If you're getting a "mismatched certificate" error when you can't connect, then you'll need to check the RD Broker machine's certificate. The error message will show the thumbprint of the expected certificate. Search the RD Broker machine's certmgr using that thumbprint to find the right certificate. After making sure the certificate hasn'te xpired, copy the certificate in .cer file format to the RDWeb machine and run the following command on the RDWeb machine with the bracketed value replaced by the certificate's file path:

```PowerShell
Import-RDWebClientBrokerCert <cert file path>
```
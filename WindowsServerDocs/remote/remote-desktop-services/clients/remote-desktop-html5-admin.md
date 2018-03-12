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

## What is the Remote Desktop web client?

The Remote Desktop client lets users access your organization's remote desktop workstation through a compatible internet browser. They'll be able to interact with apps on the remote machine like they would with a local computer no matter where they are, without having to switch to a different desktop machine. Once you set up your Remote Desktop client, all your users will need to get started is the RD Host Client URL, their credentials, and a supported web browser.

## What you'll need to set up the web client

Before getting started, keep the following things in mind:

* Make sure your [Remote Desktop deployment](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/rds-deploy-infrastructure) has an RD Gateway, an RD Connection Broker, and RD Web Access running on Windows Server 2016.
* Install the [Windows 10 KB4025334 update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) on the RD Gateway.
* Use public trusted certificates on the gateway and RD Web Access servers.
* Configure your deployment to use [per-user client access licenses](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/rds-client-access-license) (CALs), not per device.
* Make sure that any computers your users will connect to are running one of the following versions:
    * Windows 7 SP1 or later
    * Windows Server 2008R2 or later
    Your users will see better performance connecting to Windows Server 2016 or Windows 10, version 1611 or later.

## Configure your Remote Desktop deployment to support the web client

To install the web client for the first time, follow these steps:

1. On the RD Broker machine, obtain the certificate used for Remote Desktop connections and export it as a .cer file. Copy the .cer file from the RD Broker to the machine running the RD Web role.
1. On the RD Web server machine:
    1. Copy the content of **rd-html5-manage.zip** into **%ProgramFiles%\rd-html5-manage**.
    1. Copy the content of **rd-html5-packages.zip** into **%ProgramFiles%\rd-html5-packages**.
1. Open an Administrator PowerShell prompt.
1. First, run this cmdlet:
    ```PowerShell
    Import-Module ($Env:ProgramFiles + '\rd-html5-manage\RDWebClientManagement')
    ```
    
1. Then run this cmdlet:
    ```PowerShell
    Install-RDWebClientPackage
    ```
    
1. After that, run this cmdlet with the bracketed value replaced with the .cer file path you copied from the RD Broker:
    ```PowerShell
    Import-RDWebClientBrokerCert <.cer file path>
    ```
    
1. Finally, run this cmdlet:
    ```PowerShell
    Publish-RDWebClientPackage -Production -Latest
    ```
    
1. Make sure you can access the web client at the RD Session Host URL with your server name, formatted as <https://server_FQDN/RDWeb/Pages/webclient>. It's important to use the server name that matches the RDWeb public certificate in the URL (typically the machine FQDN).
1. Send the RD Session Host URL that you set up to the assigned users to allow them to access the client.

## Update the web client

To update the web client, follow these steps:

* Copy the content of **rd-html5-packages.zip** into **%ProgramFiles%\rd-html5-packages**.
* Open an Administrator PowerShell prompt and run the following two cmdlets:
    ```PowerShell
    Import-Module ($Env:ProgramFiles + '\rd-html5-manage\RDWebClientManagement')
    ```

    ```PowerShell
    Install-RDWebClientPackage
    ```
* Optionally, you can publish the client for testing before official release by running this cmdlet:
    ```PowerShell
    Run Publish-RDWebClientPackage -Test -Latest
    ```

    The client should appear on the test URL that corresponds to your web client URL (for example, <https://server_FQDN/RDWeb/Pages/webclient-test>).
* Publish the client for users by running the following cmdlet:
    ```PowerShell
    Publish-RDWebClientPackage -Production -Latest
    ```

    This will replace the client for all users when they relaunch the web page.

To see a list of all supported cmdlets for the RDWebClientManagement module, run **Get-Commands** in PowerShell.

## Troubleshooting

If a user reports any of the following issues when opening the web client for the first time, the following sections will tell you what to do to fix them.

### What to do if your browser shows a security warning when you try to access the web client

The RDWA role might not be using a trusted certificate. If it isn't, export the certificate and install it manually on the client machine to the trusted root store, then relaunch the browser.

If that doesn't work, that means your server name in the web client URL doesn't exactly match the name provided by the RD Web certificate. Make sure your URL uses the FQDN of the machine hosting the RD Web role.

### What to do if you get an "unsupported browser" error when launching the web client in IE 11

This is caused by a conflict with your browser settings. To fix this, open up "Compatibility View settings" in your browser, then uncheck the "Display intranet sites in Compatibility view" option's checkbox.

### What to do if you can't connect to the web client even though you can see the feed

If you can't connect to the web client even though you can see the feed, check the following things:

* Is the RD Gateway role using a trusted public certificate?
* Is the RD Gateway machine up to date?

To fix the certificate, close the browser, export the certificate and install it manually on the client machine's trusted root store, then relaunch the browser.

If manually installing the certificate doesn't solve the connectivity problem, then the issue might be that your RD Gateway machine isn't up to date. Make sure that your machine has [this update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) installed.

If you get a "mismatched certificate" error when you try to connect, then you'll need to check the RD Broker machine's certificate. The error message will show the thumbprint of the expected certificate. Search the RD Broker machine's certmgr using that thumbprint to find the right certificate. After making sure the certificate hasn't expired, copy the certificate in .cer file format to the RD Web machine and run the following cmdlet on the RD Web machine with the bracketed value replaced by the certificate's file path:

```PowerShell
Import-RDWebClientBrokerCert <certificate file path>
```
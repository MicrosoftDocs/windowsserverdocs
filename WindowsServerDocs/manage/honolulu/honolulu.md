---
title: Microsoft Project Honolulu
description: "Honolulu Overview"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: Honolulu
ms.tgt_pltfrm: na
ms.topic:
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 09/21/2017
---
# Microsoft Project Honolulu #

>Applies To: Windows Server, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012 and Windows 10

## What is Honolulu? ##

Honolulu is a locally deployed, browser-based, management tool set that enables on-premises administration of Windows Servers with no Azure or cloud dependency. Honolulu gives IT Admins full control over all aspects of their Server infrastructure, and is particularly useful for management on private networks that are not connected to the Internet.

Honolulu is the modern evolution of “in-box” management tools, like Server Manager and MMC. It is complementary to System Center and Operations Management Suite, and is not intended to replace these products and services.

![](../media/honolulu/honolulu-deploy-graphic.png)

## How does Honolulu work? ##

The Honolulu app runs in a web browser. The app manages Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012 nodes through the Honolulu gateway that you can install on Windows Server 2016 or Windows 10. The gateway manages servers via Remote PowerShell and WMI over WinRM. The app and gateway both install from a single lightweight .msi package that you can download from this link: [https://aka.ms/HonoluluDownload](https://aka.ms/HonoluluDownload)

Publishing the web server to DNS and setting up the corporate firewall can allow you to access Honolulu from the public internet, enabling you to connect to, and manage, your servers from anywhere with Microsoft Edge or Google Chrome (other browsers' compatibility has not been tested).

![](../media/honolulu/spacer1.png)![](../media/honolulu/architecture.png)

## What does Honolulu do? ##

![](../media/honolulu/spacer1.png)![](../media/honolulu/what-does-it-do.png)

## Download the Honolulu Ignite poster ##

![](../media/honolulu/spacer1.png)<a href="https://github.com/MicrosoftDocs/windowsserverdocs/blob/master/WindowsServerDocs//manage/media/honolulu/SME_Ignite2017_Poster.pdf"><img src="../media/honolulu/poster2.png"></a>


## Supported operating systems ##

You can install Honolulu on the following Windows operating systems:

| **Version**             | **Gateway Service**   | **Managed Node** |
|-------------------------|-----------------------|------------------|
| Windows 10              | Yes (Local user only) | No               |
| Windows Server          | Yes                   | Yes              |
| Windows Server 2016     | Yes                   | Yes              |
| Windows Server 2012R2   | No                    | Yes              |
| Windows Server 2012     | No                    | Yes              |

> [!NOTE]
> Honolulu requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you will manage Windows Server 2012 or 2012 R2 with Honolulu, you will need to install Windows Management Framework (WMF) version 5.0 or higher on those servers.

>Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.0 or higher. 

>If it is not installed, you can [download WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

## Deployment options ##

![](../media/honolulu/spacer1.png)![](../media/honolulu/deployment.png)

## How permissions work ##

When you install Honolulu on Windows 10, you'll be able to open the app from the **Start Menu** or the **System Tray**. The user interface will open in a browser and you'll be authenticated with your logged-in user account, and those credentials will pass through to connect to managed Windows Server nodes.

On Windows Server, Honolulu starts a network service that listens on the port you specify during installation. Any user who has access to the port with a web browser, and rights to log on to the gateway machine, can open the app. But since the app is running with the permissions of a network service, you will need to configure some form of Kerberos delegation on the server to get a single sign-on experience. The Honolulu Gateway machine will need to be trusted to delegate to the target node.


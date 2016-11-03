---
title: Packaged Apps and Packaged App Installer Rules in AppLocker
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-access-control
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ae953dc-115a-4cae-a1e3-e09789f1f3c2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Packaged Apps and Packaged App Installer Rules in AppLocker

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic explains the AppLocker rule collection for packaged app installers and packaged apps introduced in Windows Server 2012 and Windows 8.

Commonly known as Windows apps, packaged apps can be installed through the Microsoft AppStore or can be side loaded using the Windows PowerShell cmdlets if you have an Enterprise license. Packaged apps can be installed by a standard user unlike some desktop applications that sometimes require administrative privileges for installation. In this topic, desktop applications refer to Win32 apps that run on the classic user desktop.

Typically, an app consists of multiple components ??? the installer used to install the app and one or more Exes, Dlls or Scripts. With desktop applications, not all those components always share common attributes such as the publisher name, product name and product version. Therefore, AppLocker has to control each of these components separately through different rule collections ??? Exe, Dll, Script and Windows Installers. In contrast, all the components of a packaged app share the same attributes: Publisher name, Package name and Package version. It is therefore possible to control an entire app with a single rule.

AppLocker enforces rules for packaged apps separately from desktop applications. A single AppLocker rule for a packaged app can control both the installation and the running of an app. Because all packaged apps are signed, AppLocker supports only publisher rules for packaged apps. A publisher rule for a packaged app is based on the following attributes of the app:

-   Publisher name

-   Package name

-   Package version

In summary, including AppLocker rules for packaged apps in your policy design provides:

-   The ability to control the installation and the running the packaged app

-   The ability to control all the components of the app with a single rule rather than controlling individual binaries within the app

-   The ability to create application control policies that survive application updates

-   Management of packaged apps through Group Policy.

## See also

|Resource|Windows Server 2008 R2 and Windows 7|Windows Server 2012 and Windows 8|
|------|--------------------|------------------------------------------------------------|
|Product evaluation|[Frequently Asked Questions](http://technet.microsoft.com/library/ee619725(WS.10).aspx)<br /><br />[AppLocker Step\-by\-Step Guide](http://technet.microsoft.com/library/dd723686(WS.10).aspx)|
|Procedures|[AppLocker Operations Guide](http://technet.microsoft.com/library/ee791916(WS.10).aspx)|[Administer AppLocker](../AppLocker/manage/administer-applocker.md)<br /><br />[Manage Packaged Apps with AppLocker](../AppLocker/manage/manage-packaged-apps-with-applocker.md)|
|Scripting|[Using the AppLocker Windows PowerShell Cmdlets](http://technet.microsoft.com/library/ee791828(WS.10).aspx)|[Using the AppLocker Windows PowerShell Cmdlets](http://technet.microsoft.com/library/ee791828(WS.10).aspx)|
|Technical content|[AppLocker Technical Reference](http://technet.microsoft.com/library/ee844115(v=WS.10).aspx)|[AppLocker Technical Reference](http://technet.microsoft.com/library/ee844115(v=WS.10).aspx)|
|Design, planning and deployment|[AppLocker Policies Design Guide](http://technet.microsoft.com/library/ee449480(WS.10).aspx)<br /><br />[AppLocker Policies Deployment Guide](http://technet.microsoft.com/library/ee791890(WS.10).aspx)|[AppLocker Policies Design Guide](http://technet.microsoft.com/library/ee449480(WS.10).aspx)<br /><br />[AppLocker Policies Deployment Guide](http://technet.microsoft.com/library/ee791890(WS.10).aspx)|
|General information and additional resources|[AppLocker Documentation for Windows 7 and Windows Server 2008 R2](http://technet.microsoft.com/library/dd723678(v=WS.10).aspx)|



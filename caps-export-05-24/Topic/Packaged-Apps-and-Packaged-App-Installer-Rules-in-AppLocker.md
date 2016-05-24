---
title: Packaged Apps and Packaged App Installer Rules in AppLocker
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ae953dc-115a-4cae-a1e3-e09789f1f3c2
---
# Packaged Apps and Packaged App Installer Rules in AppLocker
This topic explains the AppLocker rule collection for packaged app installers and packaged apps introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
Commonly known as Windows apps, packaged apps can be installed through the Microsoft AppStore or can be side loaded using the Windows PowerShell cmdlets if you have an Enterprise license. Packaged apps can be installed by a standard user unlike some desktop applications that sometimes require administrative privileges for installation. In this topic, desktop applications refer to Win32 apps that run on the classic user desktop.  
  
Typically, an app consists of multiple components – the installer used to install the app and one or more Exes, Dlls or Scripts. With desktop applications, not all those components always share common attributes such as the publisher name, product name and product version. Therefore, AppLocker has to control each of these components separately through different rule collections – Exe, Dll, Script and Windows Installers. In contrast, all the components of a packaged app share the same attributes: Publisher name, Package name and Package version. It is therefore possible to control an entire app with a single rule.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], AppLocker enforces rules for packaged apps separately from desktop applications. A single AppLocker rule for a packaged app can control both the installation and the running of an app. Because all packaged apps are signed, AppLocker supports only publisher rules for packaged apps. A publisher rule for a packaged app is based on the following attributes of the app:  
  
-   Publisher name  
  
-   Package name  
  
-   Package version  
  
In summary, including AppLocker rules for packaged apps in your policy design provides:  
  
-   The ability to control the installation and the running the packaged app  
  
-   The ability to control all the components of the app with a single rule rather than controlling individual binaries within the app  
  
-   The ability to create application control policies that survive application updates  
  
-   Management of packaged apps through Group Policy.  
  
## See also  
  
|Resource|Windows Server 2008 R2 and Windows 7|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]|  
|------------|----------------------------------------|-----------------------------------------------------------------------------------------------------------------------|  
|Product evaluation|[Frequently Asked Questions](http://technet.microsoft.com/library/ee619725(WS.10).aspx)<br /><br />[AppLocker Step\-by\-Step Guide](http://technet.microsoft.com/library/dd723686(WS.10).aspx)|[AppLocker Technical Overview](assetId:///358610e4-88b2-40d0-b34d-dfd7ddee0ed9)|  
|Procedures|[AppLocker Operations Guide](http://technet.microsoft.com/library/ee791916(WS.10).aspx)|[Administer AppLocker](../Topic/Administer-AppLocker.md)<br /><br />[Manage Packaged Apps with AppLocker](../Topic/Manage-Packaged-Apps-with-AppLocker.md)|  
|Scripting|[Using the AppLocker Windows PowerShell Cmdlets](http://technet.microsoft.com/library/ee791828(WS.10).aspx)|[Using the AppLocker Windows PowerShell Cmdlets](http://technet.microsoft.com/library/ee791828(WS.10).aspx)|  
|Technical content|[AppLocker Technical Reference](http://technet.microsoft.com/library/ee844115(v=WS.10).aspx)|[AppLocker Technical Reference](http://technet.microsoft.com/library/ee844115(v=WS.10).aspx)|  
|Design, planning and deployment|[AppLocker Policies Design Guide](http://technet.microsoft.com/library/ee449480(WS.10).aspx)<br /><br />[AppLocker Policies Deployment Guide](http://technet.microsoft.com/library/ee791890(WS.10).aspx)|[AppLocker Policies Design Guide](http://technet.microsoft.com/library/ee449480(WS.10).aspx)<br /><br />[AppLocker Policies Deployment Guide](http://technet.microsoft.com/library/ee791890(WS.10).aspx)|  
|General information and additional resources|[AppLocker Documentation for Windows 7 and Windows Server 2008 R2](http://technet.microsoft.com/library/dd723678(v=WS.10).aspx)|[AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)|  
  

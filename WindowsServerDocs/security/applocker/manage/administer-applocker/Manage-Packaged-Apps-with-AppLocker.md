---
title: Manage Packaged Apps with AppLocker
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 30ca862f-74ae-45e2-9918-46e9f9ee05c7
---
# Manage Packaged Apps with AppLocker
This topic for the IT professional describes concepts and lists procedures to help you manage Packaged apps with AppLocker as part of your overall application control strategy in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)].

## Understanding Packaged apps and Packaged app installers for AppLocker
Packaged apps \(also known as Windows apps\) in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] are based on a model that ensures all the files within an app package share the same identity. With classic Win32 applications, each file within the application could have a unique identity. With Packaged apps, it is possible to control the entire application by using a single AppLocker rule.

> [!NOTE]
> AppLocker supports only publisher rules for Packaged apps. All Packaged apps must be signed by the software publisher because Windows does not support unsigned Packaged apps.

Typically, an app consists of multiple components: the installer that is used to install the app, and one or more Exes, Dlls or Scripts. With classic Win32 applications, not all these components always share common attributes such as the software’s publisher name, product name, and product version. Therefore, AppLocker controls each of these components separately through different rule collections, such as Exe, Dll, Script, and Windows Installer rules. In contrast, all the components of a Packaged app share the same publisher name, package name, and package version attributes. Therefore, you can control an entire app with a single rule.

AppLocker enforces rules for Packaged apps separately from classic applications. A single AppLocker rule for a packaged app can control installing and running the app.

### <a name="BKMK_CompareClassicMetro"></a>Comparing classic apps and Packaged apps
AppLocker policies for Packaged apps can only be applied to applications installed on computers running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], but classic apps can be controlled on [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], Windows Server 2008 R2, [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], and Windows 7. The rules for classic apps and Packaged apps can be enforced in tandem. The differences between Packaged apps and classic apps that you should consider include:

-   **Installing the apps** All Packaged apps can be installed by a standard user, whereas a number of classic apps require administrative privileges to install. In an environment where most of the users are standard users, you might not have numerous Exe rules \(because classic apps require administrative privileges to install\), but you might want to have more explicit policies for Packaged apps.

-   **Changing the system state** Classic apps can be written to change the system state if they are run with administrative privileges. Most Packaged apps cannot change the system state because they run with limited privileges. When you design your AppLocker policies, it is important to understand whether an app that you are allowing can make system\-wide changes.

-   **Acquiring the apps** Windows apps can be acquired through the Microsoft AppStore or by loading using Windows PowerShell cmdlets \(which requires a special Enterprise license\). Classic apps can be acquired through traditional means.

AppLocker uses different rule collections to control Packaged apps and classic apps. You have the choice to control one type, the other type, or both.

For information about controlling classic apps, see [Administer AppLocker](Administer-AppLocker.md).

For more information about Packaged apps, see [Packaged Apps and Packaged App Installer Rules in AppLocker](Packaged-Apps-and-Packaged-App-Installer-Rules-in-AppLocker.md).

## Design and deployment decisions
You can use two methods to create an inventory of Packaged apps on a computer: the AppLocker UI or the **Get\-AppxPackage** Windows PowerShell cmdlet.

> [!NOTE]
> Not all Packaged apps are listed in AppLocker’s application inventory wizard. Certain application packages are framework packages that are leveraged by other apps. By themselves, these packages cannot do anything, but blocking such packages can inadvertently cause failure for apps that you want to allow. Instead, you can create Allow or Deny rules for the Packaged apps that use these framework packages. The AppLocker user interface deliberately filters out all the packages that are registered as framework packages.For information about how to create an inventory list, see [Creating the List of Applications Deployed to Each Business Group](http://technet.microsoft.com/library/ee449494(WS.10).aspx).

For information about how to use the **Get\-AppxPackage** Windows PowerShell cmdlet, see the [AppLocker PowerShell Command Reference](http://technet.microsoft.com/library/ee424349(WS.10).aspx).

For information about creating rules for Packaged apps, see [Create a Rule for Packaged Apps](Create-a-Rule-for-Packaged-Apps.md).

Consider the following information when you are designing and deploying apps:

-   Because AppLocker supports only publisher rules for Packaged apps, collecting the installation path information for Packaged apps is not necessary.

-   You cannot create hash\- or path\-based rules for Packaged apps because all Packaged apps and Packaged app installers are signed by the software publisher of the package. Classic apps were not always consistently signed; therefore, AppLocker has to support hash\- or path\-based rules.

-   By default, if there are no rules in a particular rule collection, AppLocker allows every file that is included in that rule collection. For example, if there are no Windows Installer rules, AppLocker allows all .msi, .msp, and .mst files to run. An existing AppLocker policy that was targeted at computers running Windows Server 2008 R2 and Windows 7 would not have rules for Packaged apps. Therefore, when a computer running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] joins a domain where an AppLocker policy is already configured, users would be allowed to run any Packaged app. This might be contrary to your design.

    To prevent all Packaged apps from running on a newly domain\-joined computer, by default AppLocker blocks all Packaged apps on a computer running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] if the existing domain policy has rules configured in the Exe rule collection. You must take explicit action to allow Packaged apps in your enterprise. You can allow only a select set of Packaged apps. Or if you want to allow all Packaged apps, you can create a default rule for the Packaged apps collection.

## Using AppLocker to manage Packaged apps
Just as there are differences in managing each rule collection, you need to manage the Packaged apps with the following strategy:

1.  Gather information about which Packaged apps are running in your environment. For information about how to do this, see [Creating the List of Applications Deployed to Each Business Group](http://technet.microsoft.com/library/ee449494(WS.10).aspx).

2.  Create AppLocker rules for specific Packaged apps based on your policy strategies. For more information, see [Create a Rule for Packaged Apps](Create-a-Rule-for-Packaged-Apps.md) and [Packaged Apps Default Rules in AppLocker](http://technet.microsoft.com/library/ee460941(WS.10).aspx).

3.  Continue to update the AppLocker policies as new Package apps are introduced into your environment. To do this, see [Add Rules for Packaged Apps to Existing AppLocker Rule-set](Add-Rules-for-Packaged-Apps-to-Existing-AppLocker-Rule-set.md).

4.  Continue to monitor your environment to verify the effectiveness of the rules that are deployed in AppLocker policies. To do this, see [Monitor Application Usage with AppLocker](Monitor-Application-Usage-with-AppLocker.md).

## See Also
[Administer AppLocker](Administer-AppLocker.md)



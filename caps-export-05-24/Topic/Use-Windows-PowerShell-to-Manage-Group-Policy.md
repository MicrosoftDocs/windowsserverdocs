---
title: Use Windows PowerShell to Manage Group Policy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57044e91-04ee-46c4-8412-fe711b158692
author: coreyp
---
# Use Windows PowerShell to Manage Group Policy
Group Policy in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] provides support for [!INCLUDE[wps](../Token/wps_md.md)], a Windows command\-line shell and scripting language. You can use the [!INCLUDE[wps](../Token/wps_md.md)] Group Policy cmdlets to automate many of the same tasks for domain\-based Group Policy objects \(GPOs\) that you perform in the user interface by using the [!INCLUDE[gpmc](../Token/gpmc_md.md)].  
  
## Tasks that you can perform  
  
-   Maintaining GPOs: GPO creation, removal, backup, and import  
  
-   Associating [!INCLUDE[gpos](../Token/gpos_md.md)] with Active Directory® directory service containers: Group Policy link creation, update, and removal  
  
-   Setting permissions on GPOs  
  
-   Modifying inheritance flags on Active Directory organizational units \(OUs\) and domains  
  
-   Configuring registry\-based policy settings and Group Policy Preferences Registry settings: Update, retrieval, and removal  
  
-   Creating Starter GPOs  
  
To help you complete these tasks, more than 20 Group Policy cmdlets are provided in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Each cmdlet is a simple, single\-function command\-line tool. By using combinations of cmdlets, you can automate more complex tasks. You can also combine actions with scheduled tasks to ensure that specific Group Policy management tasks occur when you want them to. For example, you can back up a GPO, output the result to a file, and then append the file every time that you perform a backup. This creates a report for every scheduled backup.  
  
## Using the cmdlets for Group Policy  
  
> [!IMPORTANT]  
> To use the [!INCLUDE[wps](../Token/wps_md.md)] Group Policy cmdlets, you must be running either [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] on a domain controller or on a member server that has the GPMC installed, or [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)] or [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] with Remote Server Administration Tools \(RSAT\) installed. RSAT includes the GPMC.  
>   
> You must also import the Group Policy module before you use the cmdlets, at the beginning of every script that uses them and at the beginning of every [!INCLUDE[wps](../Token/wps_md.md)] session.  
  
#### To import the Group Policy Module  
  
1.  Open [!INCLUDE[wps](../Token/wps_md.md)]. To open [!INCLUDE[wps](../Token/wps_md.md)], point to **All Programs**, point to **Accessories**, point to **Windows PowerShell**, and then click **Windows PowerShell V2**.  
  
2.  At the [!INCLUDE[wps](../Token/wps_md.md)] prompt, type **Import\-Module GroupPolicy –verbose**  
  
    > [!IMPORTANT]  
    > You must perform these steps when you open a [!INCLUDE[wps](../Token/wps_md.md)] session and you want to use the Group Policy cmdlets.  
  
#### To view a list of Group Policy cmdlets  
  
-   At the [!INCLUDE[wps](../Token/wps_md.md)] prompt, type **Get\-Command \*GP\* \-commandtype cmdlet**  
  
#### To view Help for the Group Policy cmdlets  
  
-   At the [!INCLUDE[wps](../Token/wps_md.md)] prompt, do the following:  
  
    -   To display basic Help, type **Get\-Help***<cmdlet\_name>*  
  
    -   To display detailed Help, type **Get\-Help***<cmdlet\_name>***\-detailed**  
  
    -   To display technical Help, type **Get\-Help** *<cmdlet\_name>***\-full**  
  
## Additional considerations  
You can use the **GPRegistryValue** cmdlets to change registry\-based policy settings and the **GPPrefRegistryValue** cmdlets to change Registry preference items. For information about the registry keys that are associated with registry\-based policy settings, see the Group Policy Settings Reference [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=131389](http://go.microsoft.com/fwlink/?LinkId=131389). This reference is a downloadable spreadsheet.  
  
## Additional references  
  
-   For the Windows PowerShell Technology Center see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=102372](http://go.microsoft.com/fwlink/?LinkID=102372), This Web site is an entry point for PowerShell documentation, such as information about deployment, operations, training, support, and communities.  
  
-   For the Windows PowerShell blog see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128557](http://go.microsoft.com/fwlink/?LinkID=128557): This Web site is an entry point for Windows PowerShell blogs that includes information about current Windows PowerShell developments, best practices, training, and other resources.  
  
-   For the Group Policy Technology Center see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=116313](http://go.microsoft.com/fwlink/?LinkID=116313). This Web site is an entry point for Group Policy documentation, such as information about deployment, operations, training, support, and communities.  
  
-   For the Group Policy Settings Reference see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=131389](http://go.microsoft.com/fwlink/?LinkId=131389). This document lists Group Policy settings described in administrative template \(ADMX\) files and security settings. This spreadsheet includes all administrative template policy settings for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)].  
  

---
ms.assetid: c54b544f-cc32-4837-bb2d-a8656b22f3de
title: Introduction to Active Directory Replication and Topology Management Using Windows PowerShell (Level 100)
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Introduction to Active Directory Replication and Topology Management Using Windows PowerShell (Level 100)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Windows PowerShell for Active Directory includes the ability to manage replication, sites, domains and forests, domain controllers, and partitions. Users of prior management tools such as the Active Directory Sites and Services snap-in and repadmin.exe will notice that similar functionality is now available from within the Windows PowerShell for Active Directory context. In addition, the cmdlets are compatible with the existing Windows PowerShell for Active Directory cmdlets, thus creating a streamlined experience and allowing customers to easily create automation scripts.

> [!NOTE]
> The Windows PowerShell for Active Directory replication and topology cmdlets are available in the following environments:
> 
> -    Windows Server 2012  domain controller
> -    Windows Server 2012  with the Remote Server Administration Tools for AD DS and AD LDS installed.
> -   Windows&reg; 8 with the Remote Server Administration Tools for AD DS and AD LDS installed.

## Installing the Active Directory Module for Windows PowerShell
The Active Directory Module for Windows PowerShell is installed by default when the AD DS server role is installed on a server that runs  Windows Server 2012 . No additional steps are required other than adding the server role. You can also install the Active Directory Module on a server that runs  Windows Server 2012  by installing the Remote Server Administration Tools, and you can install the Active Directory Module on a computer running Windows 8 by downloading and installing the [Remote Server Administrative Tools (RSAT)](https://www.microsoft.com/download/details.aspx?id=28972). See [Instructions](https://www.microsoft.com/download/details.aspx?id=28972)for installation steps.

## Scenarios for testing Windows PowerShell for Active Directory replication and topology management cmdlets
The following scenarios are designed for administrators to familiarize themselves with the new management cmdlets:

-   Get a list of all domain controllers and their corresponding sites

-   Manage replication topology

-   View replication status and information

## Lab Requirements

-   Two  Windows Server 2012  domain controllers: **DC1** and **DC2** that are part of the contoso.com domain and reside in the CORPORATE site within that domain.

## View domain controllers and their sites
In this step, you will use the Active Directory Module for Windows PowerShell to view the existing domain controllers and the replication topology for the domain.

To complete the steps in the following procedures, you must be a member of the Domain Admins group or have equivalent permissions.

#### To view all Active Directory sites

1.  On **DC1**, click **Windows PowerShell** on the taskbar.

2.  Type the following command:

    `Get-ADReplicationSite -Filter *`

    This returns detailed information about each site. The `Filter` parameter is used throughout Active Directory PowerShell cmdlets to limit the list of objects returned. In this case, the asterisk (*) indicates all site objects.

    > [!TIP]
    > You can use the Tab key to auto-complete commands in Windows PowerShell.
    > 
    > Example: Type `Get-ADRep` and press Tab multiple times to skip through the matching commands until you reach `Get-ADReplicationSite`. Auto-complete also works for parameter names such as `Filter`.

    To format the output from the `Get-ADReplicationSite` command as a table and limit the display to specific fields, you can pipe the output to the `Format-Table` command (or "`ft`" for short):

    `Get-ADReplicationSite -Filter * | ft Name`

    This returns a shorter version of the site list, including only the Name field.

#### To produce a table of all domain controllers

-   Type the following command at the **Active Directory module for Windows PowerShell** prompt:

    `Get-ADDomainController -Filter * | ft Hostname,Site`

    This command returns the domain controllers host name as well as their site associations.

## Manage replication topology
In the previous step, after running the command, `Get-ADDomainController -Filter * | ft Hostname,Site`, **DC2** was listed as part of the **CORPORATE** site. In the procedures below, you will create a new branch office site, **BRANCH1**, create a new site link, set the site link cost and replication frequency and then move **DC2** to **BRANCH1**.

To complete the steps in the following procedures, you must be a member of the Domain Admins group or have equivalent permissions.

#### To create a new site

-   Type the following command at the **Active Directory module for Windows PowerShell** prompt:

    `New-ADReplicationSite BRANCH1`

    This command creates the new branch office site, branch1.

#### To create a new site link

-   Type the following command at the **Active Directory module for Windows PowerShell** prompt:

    `New-ADReplicationSiteLink 'CORPORATE-BRANCH1'  -SitesIncluded CORPORATE,BRANCH1 -OtherAttributes @{'options'=1}`

    This command created the site link to **BRANCH1** and turned on the change notification process.

    > [!TIP]
    > Use Tab to auto-complete parameter names such as `-SitesIncluded` and `-OtherAttributes` rather than typing them out manually.

#### To set the site link cost and replication frequency

-   Type the following command at the **Active Directory module for Windows PowerShell** prompt:

    `Set-ADReplicationSiteLink CORPORATE-BRANCH1 -Cost 100 -ReplicationFrequencyInMinutes 15`

    This command sets the site link cost to **BRANCH1** at **100** and set the replication frequency with the site to **15 minutes**.

#### To move a domain controller to a different site

-   Type the following command at the **Active Directory module for Windows PowerShell** prompt:

    `Get-ADDomainController DC2 | Move-ADDirectoryServer -Site BRANCH1`

    This command moves the domain controller, **DC2** to the **BRANCH1** site.

### Verification

##### To verify site creation, new site link, and cost and replication frequency

-   Click **Server Manager**, click **Tools** and then click **Active Directory Sites and Services** and verify the following:

    Verify that the **BRANCH1** site contains all of the correct values from the Windows PowerShell commands.

    Verify the **CORPORATE-BRANCH1** site link is created and connects the **BRANCH1** and **CORPORATE** sites.

    Verify **DC2** is now in the **BRANCH1** site. Alternatively, you can open the **Active Directory Module for Windows PowerShell** and type the following command to verify **DC2** is now in the **BRANCH1** site: `Get-ADDomainController -Filter * | ft Hostname,Site`.

## View replication status information
In the following procedures, you will use one of the Windows PowerShell for Active Directory replication and management cmdlets, `Get-ADReplicationUpToDatenessVectorTable DC1`, to produce a simple replication report using the up-to-dateness vector table maintained by each domain controller. This up-to-dateness vector table keeps track of the highest originating write USN seen from each domain controller in the forest.

To complete the steps in the following procedures, you must be a member of the Domain Admins group or have equivalent permissions.

#### To view the up-to-dateness vector table for a single domain controller

1.  Type the following command at the **Active Directory module for Windows PowerShell** prompt:

    `Get-ADReplicationUpToDatenessVectorTable DC1`

    This shows a list of the highest USNs seen by **DC1** for every domain controller in the forest. The **Server** value refers to the server maintaining the table, in this case **DC1**. The **Partner** value refers to the replication partner (direct or indirect) on which changes were made. The UsnFilter value is the highest USN seen by **DC1** from Partner. If a new domain controller is added to the forest, it will not appear in **DC1**'s table until **DC1** receives a change that originated from the new domain.

#### To view the up-to-dateness vector table for all domain controllers in a domain

1.  Type the following command at the Active Directory module for Windows PowerShell prompt:

    `Get-ADReplicationUpToDatenessVectorTable * | sort Partner,Server | ft Partner,Server,UsnFilter`

    This command replaces **DC1** with `*`, thus collecting the up-to-dateness vector table data from all domain controllers. The data is sorted by **Partner** and **Server** and then displayed in a table.

    The sorting allows you to easily compare the last USN seen by each domain controller for a given replication partner. This is a quick way to check that replication is occurring across your environment. If replication is working correctly, the UsnFilter values reported for a given replication partner should be fairly similar across all domain controllers.

## See Also
[Advanced Active Directory Replication and Topology Management Using Windows PowerShell &#40;Level 200&#41;](Advanced-Active-Directory-Replication-and-Topology-Management-Using-Windows-PowerShell--Level-200-.md)



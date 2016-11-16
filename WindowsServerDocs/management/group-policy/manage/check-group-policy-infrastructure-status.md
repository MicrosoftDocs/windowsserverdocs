---
title: Check Group Policy Infrastructure Status
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 444bc4b0-be08-407b-8aac-8a183b1c9d02
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Check Group Policy Infrastructure Status

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Group Policy is a complicated infrastructure that allows you to apply policy settings to remotely configure computer and user experiences within a domain. Most of the troubleshooting advice comes to IT administrators when Group Policy fails to perform in the expected manner. But this advice does not scale well when you have thousands of Group Policy Objects (GPOs) that apply to thousands of computers and users.

In some cases, when you have a large enterprise spread over multiple countries and time zones, there could be a significant replication delay between domain controllers. GPO mismatches in version numbers between the Group Policy container and the Group Policy template, or GPO mismatches between different domain controllers, can be expected due to a delay in replication. They can also indicate an issue with Group Policy. In previous versions of Windows, there were tools (such as **GPOTool.exe**) to provide a view of the GPO replication, but they provided inconsistent information.

In  Windows Server 2012 , the Group Policy Management Console (GPMC) was enhanced to provide a report for the overall health state of the Group Policy infrastructure for a domain, or to scope the health view to a single GPO.

The GPMC domain status tab (added in  Windows Server 2012 ) displays individual pieces of information that indicate the health of the Group Policy infrastructure with regards to domain controllers, GPO replication, and GPO versioning. This Group Policy infrastructure health status can help you find inconsistencies and anticipate issues.

**In this document**

We will look at what makes up a GPO and where the parts of the GPO are stored in a domain-based environment. Then we will look at how to use the Group Policy infrastructure health status information to monitor for issues with GPO replication and what to do for further investigation of replication issues.

-   [Prerequisites](check-group-policy-infrastructure-status.md#BKMK_Prereqs)

-   [Step 1: Check Group Policy infrastructure health](check-group-policy-infrastructure-status.md#BKMK_Step1)

-   [Step 2: Check the results of the Group Policy infrastructure status report](check-group-policy-infrastructure-status.md#BKMK_Step2)

-   [Step 3: Check active directory replication issues](check-group-policy-infrastructure-status.md#BKMK_Step3)

-   [Step 4: Check file services replication issues](check-group-policy-infrastructure-status.md#BKMK_Step4)

## <a name="BKMK_Prereqs"></a>Prerequisites
You can run Group Policy infrastructure health checks only by using the GPMC from domain-joined computers running:

-    Windows Server 2012  or  Windows Server 2012 R2 

-   Windows 8 or Windows 8.1 with Remote Server Administration Tools for Windows 8

An understanding of how GPOs are stored in a domain will help you make full use of the data that is displayed on the infrastructure status page.

In a domain that contains more than one domain controller, Group Policy information takes time to propagate or replicate from one domain controller to another. Low-bandwidth network connections between domain controllers slow replication. The Group Policy infrastructure has mechanisms to manage these issues.

Each GPO is stored partly in active directory and partly in SYSvol on the domain controller. The portion of the GPO that is stored in active directory is called the Group Policy container, and the portion of the GPO that is stored in SYSvol is called the Group Policy template. The GPMC and Group Policy Management editor manage the GPO as a single unit. For example, when you set permissions on a GPO in the GPMC, the GPMC is actually setting permissions for objects in active directory and in SYSvol. It is not recommended that you manipulate these separate objects independently outside of the GPMC and the Group Policy Management editor. It is IMPORTANT to understand that these two separate features of a GPO rely on different replication mechanisms. The file system portion, Group Policy template, is replicated through Distributed File Service Replication (DFS-R) or File Replication Service (FRS), independently of the replication that is handled by active directory in the Group Policy container.

Temporary lack of synchronization can occur between the GPO data that is stored in active directory (Group Policy container) and the GPO data that is stored on SYSvol (Group Policy template). This is due to the differences in the replication schemes used by active directory and DFS-R or FRS.

Group Policy provides a framework that extends Group Policy management to more features. These components are referred to as Group Policy snap-ins or extensions. For those Group Policy extensions that store data in only one data store (active directory or SYSvol), this is not an issue, and Group Policy is applied as it is read. Such extensions include administrative templates, scripts, folder redirection, and most of the security settings.

for any Group Policy extension that stores data in active directory and SYSvol, the extension must properly handle the possibility that the data is unsynchronized. This is also true for extensions that need multiple objects in a single store to be atomic in nature, because neither storage location handles transactions.

An example of an extension that stores data in active directory and SYSvol is Software Installation. The script files are stored in SYSvol, and the Windows Installer package definition is stored in active directory. If a script exists, but the corresponding active directory features are not present, nothing happens. If a script file is missing, but the package is known in active directory, application installation fails gracefully and retries on the next processing of Group Policy.

The tools used to manage active directory and Group Policy (such as GPMC, the Group Policy Object editor, and active directory Users and computers) communicate through domain controllers. If there are several domain controllers available, changes to objects (including users, computers, organizational units, and GPOs) may take time to appear on other domain controllers. The administrator may see different data depending on the last domain controller on which the changes were made and on which domain controller they are currently viewing the data.

Ideally, you would like to proactively check to make sure that all your GPOs within a domain are consistent. In the past, **GPOTool.exe** was used for this check. However, **GPOTool.exe** is limited to checking the values in the gpt.ini file, which only indicates if the versions in the Group Policy container and the Group Policy template on each domain controller are in sync.

In  Windows Server 2012  and  Windows Server 2012 R2 , the GPMC contains a more comprehensive replication check than what was previously done with **GPOTool.exe**.

## <a name="BKMK_Step1"></a>Step 1: Check Group Policy infrastructure health
 Windows Server 2012  includes a graphical reporting feature in the GPMC that enables you to choose a baseline domain controller for comparison. You can see the current Group Policy replication status with synchronization details when a comparison finds a differential from the baseline domain controller.

> [!IMPORTANT]
> You can only run the Group Policy infrastructure status report from the GPMC. You cannot schedule this report, and there is no Windows PowerShell or other command-line equivalent.
> 
> The report does not persist between GPMC sessions. Do not close the GPMC until the report gathering process has completed to avoid losing the report information.

#### To create and analyze an infrastructure status report

1.  Run an infrastructure status report for a domain or for a GPO:

    1.  **for an entire domain** In the GPMC console tree, click the name of the domain for which you want to check the replication status of all the GPOs.

    2.  **for a single GPO** In the GPMC console tree, navigate to the Group Policy Objects container. expand the Group Policy Objects container and click the GPO for which you want to check the replication status.

2.  Click the **Status** tab in the results pane.

3.  Click the **Detect Now** button to gather infrastructure status from all of the domain controllers in this domain.

## <a name="BKMK_Step2"></a>Step 2: Check the results of the Group Policy infrastructure status report
To validate consistency between the baseline and each domain controller, the GPMC compares the Group Policy information that is stored in active directory (Group Policy container), and it separately compares the Group Policy information that is stored in SYSvol (Group Policy template) on all the domain controllers in the selected domain.

Here is a list of comparisons that are performed:

-   ACL for each Group Policy container

-   version number attribute on each Group Policy template

-   Count of Group Policy container objects

-   ACL on each Group Policy template

-   version number stored in the gpt.ini file in each Group Policy container

-   Count of Group Policy template folders and files

-   File hash for each file in Group Policy template folders

During the Group Policy infrastructure status report gathering process, if the GPMC cannot contact a domain controller, or if a domain controller is found to not be consistent with the baseline domain controller, the domain controller in question is added to the **Domain controller(s) with replication in progress** list.

#### To verify GPO replication consistency for all domain controllers

1.  When the infrastructure status report gathering process is complete, click the **Status** tab, and in the **Status details** section, verify that there are no domain controllers listed in the **Domain controller(s) with replication in progress** list.

2.  Group Policy application requires clients to access specified servers, including domain controllers and other servers, such as those used for sharing documents and as installation points. Group Policy management also requires access to domain controllers.

    if a domain controller is listed as **Inaccessible** in the **Domain controller(s) with replication in progress** section of the **Status details**, check the following:

    1.  The domain controller is working and accessible on the network.

    2.  The event logs and operation logs of the domain controller do not report any errors that would cause the server to not respond to network requests.

    3.  SYSvol and active directory are available from the domain controller that is listed as inaccessible.

3.  if a domain controller is listed in **Domain controller(s) with replication in progress**due to inconsistencies in the Group Policy container portion of the GPO, see [Step 3: Check active directory replication issues](check-group-policy-infrastructure-status.md#BKMK_Step3)

4.  if a domain controller is listed in **Domain controller(s) with replication in progress** due to inconsistencies in the Group Policy template portion of the GPO, see [Step 4: Check file services replication issues](check-group-policy-infrastructure-status.md#BKMK_Step4)

## <a name="BKMK_Step3"></a>Step 3: Check active directory replication issues
Inbound or outbound replication failure can cause active directory objects that represent the replication topology, replication schedule, domain controllers, users, computers, passwords, security groups, group memberships, and Group Policy to be inconsistent between domain controllers.

if you suspect that you have an issue with active directory replication, see the following resources to understand how these mechanisms work and how you can troubleshoot issues:

-   [Troubleshooting replication with repadmin](http://go.microsoft.com/fwlink/?LinkID=129020)

-   [Troubleshooting active directory Replication Problems](http://technet.microsoft.com/library/cc949120.aspx)

-   [active directory Replication and Topology Management Using Windows PowerShell](http://technet.microsoft.com/library/hh831757.aspx)

## <a name="BKMK_Step4"></a>Step 4: Check file services replication issues
The Group Policy template portion of Group Policy resides in SYSvol. Group Policy depends on SYSvol replication working correctly for the Group Policy template to remain consistent between domain controllers within a domain. SYSvol replication depends on the Distributed File System Replication (DFS-R) or the File Replication Service (FSR), depending on how you have configured your domain controllers.

if you suspect that you have an issue with SYSvol replication, see the following resources to understand how these mechanisms work and how you can troubleshoot issues:

-   [Administering DFS-Replicated SYSvol](http://technet.microsoft.com/library/cc816919.aspx)

-   [DFS Replication: Frequently Asked Questions (FAQ)](http://technet.microsoft.com/library/cc773238.aspx)

-   [What's New in Distributed File System](http://technet.microsoft.com/library/ee307957.aspx)

-   [DFS Management help](http://technet.microsoft.com/library/cc732006.aspx)

-   [How To Troubleshoot the File Replication Service in Windows Server 2003](http://support.microsoft.com/kb/327341)

-   [Troubleshooting File Replication Service](http://technet.microsoft.com/library/bb727056.aspx)

-   [Using the BurFlags registry key to reinitialize File Replication Service replica sets](http://support.microsoft.com/kb/290762)

-   [Ask the directory Services Team blog contains extensive troubleshooting information for active directory replication, DFSR and Group Policy](http://blogs.technet.com/b/askds/)





---
title: Check Group Policy Infrastructure Status
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 444bc4b0-be08-407b-8aac-8a183b1c9d02
author: coreyp
---
# Check Group Policy Infrastructure Status
Group Policy is a complicated infrastructure that allows you to apply policy settings to remotely configure computer and user experiences within a domain. Most of the troubleshooting advice comes to IT administrators when Group Policy fails to perform in the expected manner. But this advice does not scale well when you have thousands of Group Policy Objects \(GPOs\) that apply to thousands of computers and users.  
  
In some cases, when you have a large enterprise spread over multiple countries and time zones, there could be a significant replication delay between domain controllers. GPO mismatches in version numbers between the Group Policy container and the Group Policy template, or GPO mismatches between different domain controllers, can be expected due to a delay in replication. They can also indicate an issue with Group Policy. In previous versions of Windows, there were tools \(such as **GPOTool.exe**\) to provide a view of the GPO replication, but they provided inconsistent information.  
  
In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], the Group Policy Management Console \(GPMC\) was enhanced to provide a report for the overall health state of the Group Policy infrastructure for a domain, or to scope the health view to a single GPO.  
  
The GPMC domain status tab \(added in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]\) displays individual pieces of information that indicate the health of the Group Policy infrastructure with regards to domain controllers, GPO replication, and GPO versioning. This Group Policy infrastructure health status can help you find inconsistencies and anticipate issues.  
  
**In this document**  
  
We will look at what makes up a GPO and where the parts of the GPO are stored in a domain\-based environment. Then we will look at how to use the Group Policy infrastructure health status information to monitor for issues with GPO replication and what to do for further investigation of replication issues.  
  
-   [Prerequisites](Check-Group-Policy-Infrastructure-Status.md#BKMK_Prereqs)  
  
-   [Step 1: Check Group Policy infrastructure health](Check-Group-Policy-Infrastructure-Status.md#BKMK_Step1)  
  
-   [Step 2: Check the results of the Group Policy infrastructure status report](Check-Group-Policy-Infrastructure-Status.md#BKMK_Step2)  
  
-   [Step 3: Check Active Directory replication issues](Check-Group-Policy-Infrastructure-Status.md#BKMK_Step3)  
  
-   [Step 4: Check file services replication issues](Check-Group-Policy-Infrastructure-Status.md#BKMK_Step4)  
  
## <a name="BKMK_Prereqs"></a>Prerequisites  
You can run Group Policy infrastructure health checks only by using the GPMC from domain\-joined computers running:  
  
-   [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]  
  
-   [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)] with Remote Server Administration Tools for [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)]  
  
An understanding of how GPOs are stored in a domain will help you make full use of the data that is displayed on the infrastructure status page.  
  
In a domain that contains more than one domain controller, Group Policy information takes time to propagate or replicate from one domain controller to another. Low\-bandwidth network connections between domain controllers slow replication. The Group Policy infrastructure has mechanisms to manage these issues.  
  
Each GPO is stored partly in Active Directory and partly in SYSVOL on the domain controller. The portion of the GPO that is stored in Active Directory is called the Group Policy container, and the portion of the GPO that is stored in SYSVOL is called the Group Policy template. The GPMC and Group Policy Management Editor manage the GPO as a single unit. For example, when you set permissions on a GPO in the GPMC, the GPMC is actually setting permissions for objects in Active Directory and in SYSVOL. It is not recommended that you manipulate these separate objects independently outside of the GPMC and the Group Policy Management Editor. It is important to understand that these two separate features of a GPO rely on different replication mechanisms. The file system portion, Group Policy template, is replicated through Distributed File Service Replication \(DFS\-R\) or File Replication Service \(FRS\), independently of the replication that is handled by Active Directory in the Group Policy container.  
  
Temporary lack of synchronization can occur between the GPO data that is stored in Active Directory \(Group Policy container\) and the GPO data that is stored on SYSVOL \(Group Policy template\). This is due to the differences in the replication schemes used by Active Directory and DFS\-R or FRS.  
  
Group Policy provides a framework that extends Group Policy management to more features. These components are referred to as Group Policy snap\-ins or extensions. For those Group Policy extensions that store data in only one data store \(Active Directory or SYSVOL\), this is not an issue, and Group Policy is applied as it is read. Such extensions include administrative templates, scripts, folder redirection, and most of the security settings.  
  
For any Group Policy extension that stores data in Active Directory and SYSVOL, the extension must properly handle the possibility that the data is unsynchronized. This is also true for extensions that need multiple objects in a single store to be atomic in nature, because neither storage location handles transactions.  
  
An example of an extension that stores data in Active Directory and SYSVOL is Software Installation. The script files are stored in SYSVOL, and the Windows Installer package definition is stored in Active Directory. If a script exists, but the corresponding Active Directory features are not present, nothing happens. If a script file is missing, but the package is known in Active Directory, application installation fails gracefully and retries on the next processing of Group Policy.  
  
The tools used to manage Active Directory and Group Policy \(such as GPMC, the Group Policy Object Editor, and Active Directory Users and Computers\) communicate through domain controllers. If there are several domain controllers available, changes to objects \(including users, computers, organizational units, and GPOs\) may take time to appear on other domain controllers. The administrator may see different data depending on the last domain controller on which the changes were made and on which domain controller they are currently viewing the data.  
  
Ideally, you would like to proactively check to make sure that all your GPOs within a domain are consistent. In the past, **GPOTool.exe** was used for this check. However, **GPOTool.exe** is limited to checking the values in the GPT.ini file, which only indicates if the versions in the Group Policy container and the Group Policy template on each domain controller are in sync.  
  
In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], the GPMC contains a more comprehensive replication check than what was previously done with **GPOTool.exe**.  
  
## <a name="BKMK_Step1"></a>Step 1: Check Group Policy infrastructure health  
[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] includes a graphical reporting feature in the GPMC that enables you to choose a baseline domain controller for comparison. You can see the current Group Policy replication status with synchronization details when a comparison finds a differential from the baseline domain controller.  
  
> [!IMPORTANT]  
> You can only run the Group Policy infrastructure status report from the GPMC. You cannot schedule this report, and there is no [!INCLUDE[wps_2](includes/wps_2_md.md)] or other command\-line equivalent.  
>   
> The report does not persist between GPMC sessions. Do not close the GPMC until the report gathering process has completed to avoid losing the report information.  
  
#### To create and analyze an infrastructure status report  
  
1.  Run an infrastructure status report for a domain or for a GPO:  
  
    1.  **For an entire domain** In the GPMC console tree, click the name of the domain for which you want to check the replication status of all the GPOs.  
  
    2.  **For a single GPO** In the GPMC console tree, navigate to the Group Policy Objects container. Expand the Group Policy Objects container and click the GPO for which you want to check the replication status.  
  
2.  Click the **Status** tab in the results pane.  
  
3.  Click the **Detect Now** button to gather infrastructure status from all of the domain controllers in this domain.  
  
## <a name="BKMK_Step2"></a>Step 2: Check the results of the Group Policy infrastructure status report  
To validate consistency between the baseline and each domain controller, the GPMC compares the Group Policy information that is stored in Active Directory \(Group Policy container\), and it separately compares the Group Policy information that is stored in SYSVOL \(Group Policy template\) on all the domain controllers in the selected domain.  
  
Here is a list of comparisons that are performed:  
  
-   ACL for each Group Policy container  
  
-   Version number attribute on each Group Policy template  
  
-   Count of Group Policy container objects  
  
-   ACL on each Group Policy template  
  
-   Version number stored in the gpt.ini file in each Group Policy container  
  
-   Count of Group Policy template folders and files  
  
-   File hash for each file in Group Policy template folders  
  
During the Group Policy infrastructure status report gathering process, if the GPMC cannot contact a domain controller, or if a domain controller is found to not be consistent with the baseline domain controller, the domain controller in question is added to the **Domain controller\(s\) with replication in progress** list.  
  
#### To verify GPO replication consistency for all domain controllers  
  
1.  When the infrastructure status report gathering process is complete, click the **Status** tab, and in the **Status Details** section, verify that there are no domain controllers listed in the **Domain controller\(s\) with replication in progress** list.  
  
2.  Group Policy application requires clients to access specified servers, including domain controllers and other servers, such as those used for sharing documents and as installation points. Group Policy management also requires access to domain controllers.  
  
    If a domain controller is listed as **Inaccessible** in the **Domain controller\(s\) with replication in progress** section of the **Status Details**, check the following:  
  
    1.  The domain controller is working and accessible on the network.  
  
    2.  The event logs and operation logs of the domain controller do not report any errors that would cause the server to not respond to network requests.  
  
    3.  SYSVOL and Active Directory are available from the domain controller that is listed as inaccessible.  
  
3.  If a domain controller is listed in **Domain controller\(s\) with replication in progress**due to inconsistencies in the Group Policy container portion of the GPO, see [Step 3: Check Active Directory replication issues](Check-Group-Policy-Infrastructure-Status.md#BKMK_Step3)  
  
4.  If a domain controller is listed in **Domain controller\(s\) with replication in progress** due to inconsistencies in the Group Policy template portion of the GPO, see [Step 4: Check file services replication issues](Check-Group-Policy-Infrastructure-Status.md#BKMK_Step4)  
  
## <a name="BKMK_Step3"></a>Step 3: Check Active Directory replication issues  
Inbound or outbound replication failure can cause Active Directory objects that represent the replication topology, replication schedule, domain controllers, users, computers, passwords, security groups, group memberships, and Group Policy to be inconsistent between domain controllers.  
  
If you suspect that you have an issue with Active Directory replication, see the following resources to understand how these mechanisms work and how you can troubleshoot issues:  
  
-   [Troubleshooting replication with repadmin](http://go.microsoft.com/fwlink/?LinkID=129020)  
  
-   [Troubleshooting Active Directory Replication Problems](http://technet.microsoft.com/library/cc949120.aspx)  
  
-   [Active Directory Replication and Topology Management Using Windows PowerShell](http://technet.microsoft.com/library/hh831757.aspx)  
  
## <a name="BKMK_Step4"></a>Step 4: Check file services replication issues  
The Group Policy template portion of Group Policy resides in SYSVOL. Group Policy depends on SYSVOL replication working correctly for the Group Policy template to remain consistent between domain controllers within a domain. SYSVOL replication depends on the Distributed File System Replication \(DFS\-R\) or the File Replication Service \(FSR\), depending on how you have configured your domain controllers.  
  
If you suspect that you have an issue with SYSVOL replication, see the following resources to understand how these mechanisms work and how you can troubleshoot issues:  
  
-   [Administering DFS\-Replicated SYSVOL](http://technet.microsoft.com/library/cc816919.aspx)  
  
-   [DFS Replication: Frequently Asked Questions \(FAQ\)](http://technet.microsoft.com/library/cc773238.aspx)  
  
-   [What's New in Distributed File System](http://technet.microsoft.com/library/ee307957.aspx)  
  
-   [DFS Management Help](http://technet.microsoft.com/library/cc732006.aspx)  
  
-   [How To Troubleshoot the File Replication Service in Windows Server 2003](http://support.microsoft.com/kb/327341)  
  
-   [Troubleshooting File Replication Service](http://technet.microsoft.com/library/bb727056.aspx)  
  
-   [Using the BurFlags registry key to reinitialize File Replication Service replica sets](http://support.microsoft.com/kb/290762)  
  
-   [Ask the Directory Services Team blog contains extensive troubleshooting information for Active Directory replication, DFSR and Group Policy](http://blogs.technet.com/b/askds/)  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Group Policy Overview](Group-Policy-Overview.md)  
  
-   [Group Policy Analysis and Troubleshooting Overview](Group-Policy-Analysis-and-Troubleshooting-Overview.md)  
  


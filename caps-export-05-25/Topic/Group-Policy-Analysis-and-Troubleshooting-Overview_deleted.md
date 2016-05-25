---
title: Group Policy Analysis and Troubleshooting Overview_deleted
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a9281380-06a1-462a-9450-ba64f3872820
author: coreyp
---
# Group Policy Analysis and Troubleshooting Overview_deleted
This topic provides high\-level information about concepts and techniques that are used to troubleshoot Group Policy settings, in addition to links to detailed reference topics, procedures, and troubleshooting scenario guides.  
  
**Did you mean…**  
  
-   [Troubleshooting Group Policy by Using Event Logs for Vista and Windows Server 2008](http://technet.microsoft.com/library/cc749336.aspx)  
  
-   [Group Policy Infrastructure Events and Errors for Windows Server 2008](http://technet.microsoft.com/library/cc772100.aspx)  
  
## <a name="BKMK_OVER"></a>Group Policy troubleshooting description  
Understanding how to troubleshoot Group Policy is important for maintaining corporate standards. IT professionals depend on the reliability of Group Policy to keep networks secure and managed, and to lower operating costs. When an IT pro is trying to understand why a Group Policy setting did not apply to a computer or user in an expected manner, understanding where to locate and how to read and analyze information can make the difference between a small network issue and hours of downtime.  
  
Troubleshooting Group Policy becomes complicated because Group Policy is not just a single component or application that resides locally on a single computer. Group Policy is a processing infrastructure that is used to deliver and apply one or more desired configurations or policy settings to a set of targeted users and computers within an Active Directory environment. This processing infrastructure consists of a Group Policy engine and multiple client\-side extensions \(CSEs\) that are responsible for reading specific policy settings on target client computers. During Group Policy processing, Group Policy must access domain\-based information about Group Policy Objects \(GPOs\) that is stored in Active Directory, the Group Policy container, and SYSVOL \(which provides a standard location to store the Group Policy template\).  
  
## <a name="BKMK_APP"></a>Practical considerations  
The Group Policy Management Console \(GPMC\) provides a starting point to approach troubleshooting Group Policy. Functionality from number of separate tools, such as GPUpdate.exe and GPOTool.exe, were rolled into the GPMC in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
A methodology for using the GPMC to troubleshoot Group Policy considers the following factors:  
  
-   Ensure Group Policy has processed the most current set of computer and user settings.  
  
    -   [Force a Remote Group Policy Refresh &#40;GPUpdate&#41;](../Topic/Force-a-Remote-Group-Policy-Refresh--GPUpdate-.md).  
  
    -   Check that Group Policy Object information has replicated to all domain controllers. See [Check Group Policy Infrastructure Status](../Topic/Check-Group-Policy-Infrastructure-Status.md).  
  
    -   Check for Group Policy errors and events.  
  
-   Investigate configurations that affect the Resultant Set of Policy.  
  
    -   Slow link  
  
    -   Loopback  
  
    -   Security filtering  
  
    -   Block inheritance  
  
    -   Enforced GPO  
  
    -   Disable the entire GPO, or the computer or user portion of the GPO.  
  
-   Understand core Group Policy processing.  
  
    -   Understand how changes to the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] startup process impact Group Policy processing.  
  
    -   Understand how migrating Group Policy to a separate service affects core Group Policy processing.  
  
    -   Check for Group Policy errors and events by using the GPMC reports.  
  
-   Understand Group Policy client\-side extension processing.  
  
    -   Understand the expected behavior of the Group Policy preference extensions.  
  
    -   Determine which GPO contains a setting that has been applied to a computer or user.  
  
## <a name="BKMK_LINKS"></a>See also  
The following references provide troubleshooting information for components that affect Group Policy functionality.  
  
|Troubleshooting considerations|References|  
|----------------------------------|--------------|  
|**Active Directory replication information**|-   [Introduction to Active Directory Replication and Topology Management Using Windows PowerShell &#40;Level 100&#41;](../Topic/Introduction-to-Active-Directory-Replication-and-Topology-Management-Using-Windows-PowerShell--Level-100-.md)<br />-   [Troubleshooting replication with repadmin](http://go.microsoft.com/fwlink/?LinkID=129020)|  
|**DFRS and FRS replication information**|1.  [DFS Replication: Frequently Asked Questions \(FAQ\)](http://technet.microsoft.com/library/cc773238.aspx)<br />2.  [What's New in Distributed File System](http://technet.microsoft.com/library/ee307957.aspx)<br />3.  [DFS Replication](http://technet.microsoft.com/library/cc770278.aspx)|  
  

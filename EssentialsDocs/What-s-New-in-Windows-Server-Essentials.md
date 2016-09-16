---
title: "What&#39;s New in Windows Server Essentials"
ms.custom: na
ms.date: 07/02/2014
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2016 Essentials
ms.assetid: affff774-5fa6-4944-887a-9bfde05f6a3f
caps.latest.revision: 25
author: coreyp-at-msft
ms.author: coreyp

---
# What&#39;s New in Windows Server Essentials
The content in this section describes what's new and changed in  Windows Server 2012 R2 Essentials. This content focuses on changes that will potentially have the greatest impact when you use this release.  
  
 Windows Server Essentials is now available in two forms:  
  
-   **As a server role**:  Windows Server Essentials Experience is provided as a server role in the Standard and Datacenter editions of  Windows Server 2012 R2. Installing Windows Server Essentials Experience in  Windows Server 2012 R2 provides you with all the features and functionalities (such as the Dashboard, client computer backups, and Remote Web Access) of  Windows Server 2012 R2 Essentials without the locks and limits that are imposed on it. For more information about this new server role, see [Windows Server Essentials Experience Overview &#91;fwlink_blue&#93;](assetId:///958ecbde-ba6f-4789-88da-58542b8b1faf).  
  
-   **As a core Windows Server edition**:  Windows Server 2012 R2 Essentials. As a part of your installation process, you can opt to install  Windows Server 2012 R2 Essentials as a virtual machine by following instructions in a wizard.  
  
## What's New in Windows Server 2012 R2 Essentials  
 The following table describes the new and enhanced features in  Windows Server 2012 R2 Essentials.  
  
|Feature Name|What’s New|Description|  
|------------------|----------------|-----------------|  
|Server Deployment|Server deployment options in  Windows Server Essentials include:<br /><br /> -    Windows Server Essentials Experience as a server role in the Standard and Datacenter editions of  Windows Server 2012 R2 can be installed as a member server in a domain.<br />-    Windows Server 2012 R2 Essentials can be installed on a physical server or as a virtual machine.|-    Windows Server 2012 R2 Essentials must be the domain controller at the root of the forest and domain, and must hold all the FSMO roles.<br />-    Windows Server Essentials Experience as a server role in the Standard and Datacenter editions of  Windows Server 2012 R2 can be installed as a member server in a domain. If an Active Directory domain does not exist, installing the role will create an Active Directory domain, and the server will become the domain controller at the root of the forest and domain, holding all the FSMO roles. You can have more than one server with the Windows Server Essentials Experience role installed in your network.<br />-   As part of your installation process, you can opt to install  Windows Server 2012 R2 Essentials as a virtual machine by following instructions in a wizard.|  
|Client Deployment| Windows Server 2012 R2 Essentials provides improved client deployment options.|The following improvements and changes are made in the client deployment process for   Windows Server 2012 R2 Essentials:<br /><br /> -   The Connector can be used to connect to a server running  Windows Server 2012 R2 Essentials from a remote location.<br />-   The Connector can trigger automatic VPN dialing in domain-joined clients, so that customers can always be connected to  Windows Server 2012 R2 Essentials when they are working off-premises.<br />-   The Connector can be configured to connect to other servers running  Windows Server 2012 R2 Essentials without reinstallation.<br />-   The Connector performance has been improved by reducing its memory and CPU usage.|  
|Users and Groups|The following functionalities are added for managing users and groups :<br /><br /> -   User groups management<br />-   Office 365 distribution groups management|-   You can create user groups and add user accounts to them. User account permissions can be managed through their user group memberships.<br />-   If your server is integrated with Office 365, you can manage your Office 365 distribution groups from the Dashboard.|  
|Server Storage|The following functionalities are added in Server Storage:<br /><br /> -   Folder management on a second server in a  Windows Server 2012 R2 Essentials network<br />-   Server folder quota|-   You can create shared folders on a secondary server while keeping the same Universal Naming Convention (UNC) path prefix.<br />-   You can specify a space quota for a server folder. You receive an alert when a server folder size grows beyond its defined quota.|  
|Data Protection| Windows Server 2012 R2 Essentials includes improved File History.|File History backups are configured per user instead of per device. Also, you can automatically restore your data through File History backups on a new computer if your old computer is no longer functional or is unavailable.The first time you log on to your new computer in the network, you are prompted to restore your files from your File History backups.|  
|Health Reports|Health Reports is integrated with  Windows Server 2012 R2 Essentials, and it no longer needs to be installed as an add-in.|The Home page includes the Alerts and Reports tabs. Depending on your business needs, you can customize the system health reports to display items that you want to monitor.|  
|BranchCache|BranchCache is integrated with  Windows Server 2012 R2 Essentials.|You can turn on BranchCache to improve data access if the server running  Windows Server 2012 R2 Essentials is located offsite. For more information, see [Manage BranchCache](manage/Manage-BranchCache-in-Windows-Server-Essentials.md).|  
|Office 365 Integration|The following functionalities are available when Office 365 is integrated with  Windows Server 2012 R2 Essentials:<br /><br /> -   SharePoint Libraries management<br />-   Office 365 distribution groups management|If your server is integrated with Office 365, you can:<br /><br /> -   Manage your Office 365 SharePoint Libraries from the Dashboard.<br />-   Manage your Office 365 distribution groups from the Dashboard.<br /><br /> **Important:** The integration of  Windows Server 2012 R2 Essentials with Office 365 is only supported in a single domain controller environment. The Integrate with Office 365 Wizard must be run on a domain controller.|  
|Mobile Devices|You can manage Mobile Devices through the Dashboard.|If your server is integrated with Office 365, you can manage your mobile devices by using the Exchange Active Sync functionalities; for example, you can define email access from a mobile device, set up password policies, and perform a remote wipe of the mobile device.|  
|Client Full System Restore|Client Full System Restore is supported by Windows Deployment Services.|You can create a client restore service by using the Set Up Client Restore Service task, and you can perform client full system restore over the network instead of using an image that is saved on a DVD.|  
|Remote Web Access|Remote Web Access experience is updated.|Remote Web Access is optimized for touch devices and enhanced with rich HTML5 support.|  
|Microsoft online services integration|The integration of  Windows Server 2012 R2 Essentials with Microsoft online services is updated.|The integration of  Windows Server 2012 R2 Essentials with Microsoft online services, including  Microsoft Azure Active Directory (Azure AD), Office 365, Windows Intune, and on-premises Exchange, is only supported in a single domain controller environment. The integration wizard for these Microsoft online services must be run on a domain controller.|  
  
## See also  

-   [Windows Server 2012 R2 Essentials and Windows Server 2012 Essentials](Windows-Server-2012-R2-Essentials-and-Windows-Server-2012-Essentials.md)
-   [Windows Server 2012 R2 Essentials and Windows Server 2012 Essentials](Windows-Server-2012-R2-Essentials-and-Windows-Server-2012-Essentials.md)


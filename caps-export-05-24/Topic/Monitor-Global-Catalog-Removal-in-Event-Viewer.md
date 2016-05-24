---
title: Monitor Global Catalog Removal in Event Viewer
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 57e14952-4cf4-4949-aa80-643371f0d08e
author: Femila
---
# Monitor Global Catalog Removal in Event Viewer
  To verify that the global catalog has been removed from a domain controller, monitor Event Viewer. When the global catalog has been removed successfully, the Knowledge Consistency Checker \(KCC\) logs Event ID 1268 in the Directory Service event log. You can use this procedure to monitor global catalog removal in Event Viewer.  
  
 Membership in **Server Operators** and the right to log on locally to a domain controller, or equivalent, is the minimum required to complete this procedure. By default, members of **Account Operators**, **Administrators**, **Enterprise Admins**, **Domain Admins**, **Backup Operators**, **Print Operators**, and **Server Operators** have the right to log on locally to a domain controller. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To monitor global catalog removal in Event Viewer  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Event Viewer**.  
  
2.  Right\-click **Event Viewer \(Local\)**, and then click **Connect to Another Computer**.  
  
3.  In the **Select Computer** dialog box, click **Another computer**, and then type the name of the server from which you removed the global catalog.  
  
4.  Click **Connect as another user**, and then click **Set User**.  
  
5.  Type the user name and password for a user that has access to the global catalog server and permission to open Event Viewer, and then click **OK** twice.  
  
6.  Under **Applications and Services Logs**, click **Directory Service**.  
  
7.  Look for ActiveDirectory\_DomainService event ID 1268, which indicates that the global catalog is removed from the local computer.  
  
  
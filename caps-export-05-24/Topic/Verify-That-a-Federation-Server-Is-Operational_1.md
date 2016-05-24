---
title: Verify That a Federation Server Is Operational_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 829b12aa-78b2-405f-b31d-1ef5b9d7c46c
author: billmath
---
# Verify That a Federation Server Is Operational_1
You can use the following procedures to verify that a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] is operational; that is, that any client on the same network can reach a new [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].  
  
Membership in **Users**, **Backup Operators**, **Power Users**, **Administrators** or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### Procedure 1: To verify that a federation server is operational  
  
1.  To verify that Internet Information Services \(IIS\) is configured correctly on the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)], log on to a client computer that is located in the same forest as the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].  
  
2.  Open a browser window, in the address bar type the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]’s DNS host name, and then append \/adfs\/fs\/federationserverservice.asmx to it for the new [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)], for example:  
  
    **https:\/\/fs1.fabrikam.com\/adfs\/fs\/federationserverservice.asmx**  
  
3.  Press ENTER, and then complete the next procedure on the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] computer. If you see the message **There is a problem with this website’s security certificate**, click **Continue to this website**.  
  
    The expected output is a display of XML with the service description document. If this page appears, IIS on the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] is operational and serving pages successfully.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### Procedure 2: To verify that a federation server is operational  
  
1.  Log on to the new [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] as an administrator.  
  
2.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**Event Viewer**, and then press ENTER.  
  
3.  In the details pane, double\-click **Applications and Services Logs**, double\-click **AD FS Eventing**, and then click **Admin**.  
  
4.  In the **Event ID** column, look for event ID 100. If the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] is configured properly, you see a new event—in the Application log of Event Viewer—with the event ID 100. This event verifies that the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] was able to successfully communicate with the Federation Service.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  

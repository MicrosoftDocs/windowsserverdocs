---
title: Verify That a Federation Server Proxy Is Operational
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5fe58615-81b8-41af-99f3-ca61b85b9a0d
author: billmath
---
# Verify That a Federation Server Proxy Is Operational
You can use the following procedure to verify that the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] can communicate with the Federation Service in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)]. You run this procedure after you run the **AD FS Federation Server Proxy Configuration Wizard** to configure the computer to run in the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] role. For more information about how to run this wizard, see [Configure a Computer for the Federation Server Proxy Role](../Topic/Configure-a-Computer-for-the-Federation-Server-Proxy-Role.md).  
  
> [!IMPORTANT]  
> The result of this test is the successful generation of a specific event in Event Viewer on the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] computer.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify that a federation server proxy is operational  
  
1.  Log on to the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] as an administrator.  
  
2.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**Event Viewer**, and then press ENTER.  
  
3.  In the details pane, double\-click **Applications and Services Logs**, double\-click **AD FS Eventing**, and then click **Admin**.  
  
4.  In the **Event ID** column, look for event ID 198.  
  
    If the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] is configured properly, you see a new event in the Application log of Event Viewer, with the event ID 198. This event verifies that the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] service was started successfully and now is online.  
  
## Additional references  
[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  

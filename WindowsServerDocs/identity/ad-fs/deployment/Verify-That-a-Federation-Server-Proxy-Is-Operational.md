---
ms.assetid: d555041a-709e-42c7-920a-8dfd2c7e0488
title: Verify That a Federation Server Proxy Is Operational
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---


# Verify That a Federation Server Proxy Is Operational


You can use the following procedure to verify that the federation server proxy can communicate with the Federation Service in Active Directory Federation Services \(AD FS\). You run this procedure after you run the **AD FS Federation Server Proxy Configuration Wizard** to configure the computer to run in the federation server proxy role. For more information about how to run this wizard, see [Configure a Computer for the Federation Server Proxy Role](Configure-a-Computer-for-the-Federation-Server-Proxy-Role.md).  
  
> [!IMPORTANT]  
> The result of this test is the successful generation of a specific event in Event Viewer on the federation server proxy computer.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### To verify that a federation server proxy is operational  
  
1.  Log on to the federation server proxy as an administrator.  
  
2.  On the **Start** screen, type**Event Viewer**, and then press ENTER.  
  
3.  In the details pane, double\-click **Applications and Services Logs**, double\-click **AD FS Eventing**, and then click **Admin**.  
  
4.  In the **Event ID** column, look for event ID 198.  
  
    If the federation server proxy is configured properly, you see a new event in the Application log of Event Viewer, with the event ID 198. This event verifies that the federation server proxy service was started successfully and now is online.  
  
## Additional references  
[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  


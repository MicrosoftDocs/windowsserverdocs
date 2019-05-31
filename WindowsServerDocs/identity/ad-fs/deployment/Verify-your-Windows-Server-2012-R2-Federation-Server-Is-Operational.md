---
ms.assetid: 1115d276-00f6-4c23-9278-eedcc31295d8
title: Verify your Windows Server 2012 R2 Federation Server is Operational
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Verify your Windows Server 2012 R2 Federation Server is Operational



You can use the following procedures to verify that a federation server is operational; that is, that any client on the same network can reach a new federation server.  
  
Membership in **Users**, **Backup Operators**, **Power Users**, **Administrators** or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### Procedure 1: To verify that a federation server is operational  
  
1.  To verify that Internet Information Services \(IIS\) is configured correctly on the federation server, log on to a client computer that is located in the same forest as the federation server.  
  
2.  Open a browser window, in the address bar type the federation server’s DNS host name, and then append \/adfs\/fs\/federationserverservice.asmx to it for the new federation server, for example:  
  
    **https:\/\/fs1.fabrikam.com\/adfs\/fs\/federationserverservice.asmx**  
  
3.  Press ENTER, and then complete the next procedure on the federation server computer. If you see the message **There is a problem with this website’s security certificate**, click **Continue to this website**.  
  
    The expected output is a display of XML with the service description document. If this page appears, IIS on the federation server is operational and serving pages successfully.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### Procedure 2: To verify that a federation server is operational  
  
1.  Log on to the new federation server as an administrator.  
  
2.  On the **Start** screen, type**Event Viewer**, and then press ENTER.  
  
3.  In the details pane, double\-click **Applications and Services Logs**, double\-click **AD FS Eventing**, and then click **Admin**.  
  
4.  In the **Event ID** column, look for event ID 100. If the federation server is configured properly, you see a new event—in the Application log of Event Viewer—with the event ID 100. This event verifies that the federation server was able to successfully communicate with the Federation Service.  
  
## See Also 

[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)  

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
 
[Deploying a Federation Server Farm](../../ad-fs/deployment/Deploying-a-Federation-Server-Farm.md)  
   
  


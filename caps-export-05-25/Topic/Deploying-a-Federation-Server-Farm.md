---
title: Deploying a Federation Server Farm
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 140dc3d5-b7eb-4a68-a30a-ac89c4e1bd83
author: billmath
---
# Deploying a Federation Server Farm
In order to deploy a federation server farm, complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic, return to this checklist after you review the conceptual topic so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Deploying a Federation Server Farm**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review important concepts and considerations as you prepare to deploy [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)]. **Note:**|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[AD FS Design Guide in Windows Server 2012 R2](../Topic/AD-FS-Design-Guide-in-Windows-Server-2012-R2.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Understanding Key AD FS Concepts](../Topic/Understanding-Key-AD-FS-Concepts.md)|  
||If you decide to use Microsoft SQL Server for your AD FS configuration store, ensure to deploy a functional instance of SQL Server.|[SQL Server](http://technet.microsoft.com/sqlserver) **Warning:** In Windows Server 2012 R2, if you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012.|  
|![](../Image/icon_checkboxo.gif)|Join your computer to an Active Directory domain.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Join a Computer to a Domain_1](../Topic/Join-a-Computer-to-a-Domain_1.md)|  
|![](../Image/icon_checkboxo.gif)|Enroll a Secure Socket Layer \(SSL\) certificate for AD FS.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Enroll an SSL Certificate for AD FS](../Topic/Enroll-an-SSL-Certificate-for-AD-FS.md)|  
|![](../Image/icon_checkboxo.gif)|Install the AD FS role service.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Install the AD FS Role Service](../Topic/Install-the-AD-FS-Role-Service.md)|  
|![](../Image/icon_checkboxo.gif)|Configure a federation server.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Configure a Federation Server](../Topic/Configure-a-Federation-Server.md)|  
|![](../Image/icon_checkboxo.gif)|Optional step: Configure a federation server with Device Registration Service \(DRS\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configure a federation server with Device Registration Service](../Topic/Configure-a-federation-server-with-Device-Registration-Service.md)|  
|![](../Image/icon_checkboxo.gif)|Add a host \(A\) and alias \(CNAME\) resource record to corporate Domain Name System \(DNS\) for the federation service and DRS.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configure Corporate DNS for the Federation Service and DRS](../Topic/Configure-Corporate-DNS-for-the-Federation-Service-and-DRS.md)|  
|![](../Image/icon_checkboxo.gif)|Verify that a federation server is operational.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Verify That a Federation Server Is Operational](../Topic/Verify-That-a-Federation-Server-Is-Operational.md)|  
  
## See Also  
[Windows Server 2012 R2 AD FS Deployment Guide](../Topic/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
  

---
title: Windows Server 2012 R2 AD FS Deployment Guide
description:
author: billmath
ms.author:  billmath
manager: femila
ms.date: 09/22/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: identity-adfs
---

# Deploying a Federation Server Farm

>Applies To: Windows Server 2016, Windows Server 2012 R2

In order to deploy a federation server farm, complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic, return to this checklist after you review the conceptual topic so that you can proceed with the remaining tasks in this checklist.  
  
![](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Deploying a Federation Server Farm**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](media/icon_checkboxo.gif)|Review important concepts and considerations as you prepare to deploy Active Directory Federation Services \(AD FS\). **Note:**|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[AD FS Design Guide in Windows Server 2012 R2](../../ad-fs/design/AD-FS-Design-Guide-in-Windows-Server-2012-R2.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Understanding Key AD FS Concepts](../../ad-fs/technical-reference/Understanding-Key-AD-FS-Concepts.md)|  
||If you decide to use Microsoft SQL Server for your AD FS configuration store, ensure to deploy a functional instance of SQL Server.|[SQL Server](http://technet.microsoft.com/sqlserver) **Warning:** In Windows Server 2012 R2, if you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012.|  
|![](media/icon_checkboxo.gif)|Join your computer to an Active Directory domain.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Join a Computer to a Domain](Join-a-Computer-to-a-Domain.md)|  
|![](media/icon_checkboxo.gif)|Enroll a Secure Socket Layer \(SSL\) certificate for AD FS.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Enroll an SSL Certificate for AD FS](Enroll-an-SSL-Certificate-for-AD-FS.md)|  
|![](media/icon_checkboxo.gif)|Install the AD FS role service.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Install the AD FS Role Service](Install-the-AD-FS-Role-Service.md)|  
|![](media/icon_checkboxo.gif)|Configure a federation server.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Configure a Federation Server](Configure-a-Federation-Server.md)|  
|![](media/icon_checkboxo.gif)|Optional step: Configure a federation server with Device Registration Service \(DRS\).|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configure a federation server with Device Registration Service](Configure-a-federation-server-with-Device-Registration-Service.md)|  
|![](media/icon_checkboxo.gif)|Add a host \(A\) and alias \(CNAME\) resource record to corporate Domain Name System \(DNS\) for the federation service and DRS.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configure Corporate DNS for the Federation Service and DRS](Configure-Corporate-DNS-for-the-Federation-Service-and-DRS.md)|  
|![](media/icon_checkboxo.gif)|Verify that a federation server is operational.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Verify That a Federation Server Is Operational](Verify-That-a-Federation-Server-Is-Operational.md)|  
  

## See Also  
[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)  

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
  


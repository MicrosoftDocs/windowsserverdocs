---
ms.assetid: bbb5b68f-00ad-4715-8176-0c2769b706c4
title: Deploying a Federation Server Farm for Windows Server 2012 R2 AD FS
description: "Learn more about: Deploying a Federation Server Farm"
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---

# Deploying a Federation Server Farm

In order to deploy a federation server farm, complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic, return to this checklist after you review the conceptual topic so that you can proceed with the remaining tasks in this checklist.

![Icon for the Deploying a Federation Server Farm check list.](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Deploying a Federation Server Farm**

|Task|Reference|
|--------|-------------|
|Review important concepts and considerations as you prepare to deploy Active Directory Federation Services \(AD FS\).|![Icon for the AD FS Design Guide in Windows Server 2012 R2 link you can use in reference to deploying a federation server farm.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[AD FS Design Guide in Windows Server 2012 R2](../../ad-fs/design/AD-FS-Design-Guide-in-Windows-Server-2012-R2.md)<p>![Icon for the Understanding Key AD FS Concepts link you can use in reference to deploying a federation server farm.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Understanding Key AD FS Concepts](../../ad-fs/technical-reference/Understanding-Key-AD-FS-Concepts.md)|
|| **Note:** If you decide to use Microsoft SQL Server for your AD FS configuration store, ensure to deploy a functional instance of [SQL Server](/sql/sql-server/)<p>**Warning:** In Windows Server 2012 R2, if you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012.|
|Join your computer to an Active Directory domain.|![Icon for the Join a Computer to a Domain link you can use in reference to deploying a federation server farm.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Join a Computer to a Domain](Join-a-Computer-to-a-Domain.md)|
|Enroll a Secure Socket Layer \(SSL\) certificate for AD FS.|![Icon for the Enroll an SSL Certificate for AD FS link you can use in reference to deploying a federation server farm.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Enroll an SSL Certificate for AD FS](Enroll-an-SSL-Certificate-for-AD-FS.md)|
|Install the AD FS role service.|![Icon for the Install the AD FS Role Service link you can use in reference to deploying a federation server farm.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Install the AD FS Role Service](Install-the-AD-FS-Role-Service.md)|
|Configure a federation server.|![Icon for the Configure a Federation Server link you can use in reference to deploying a federation server farm.](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Configure a Federation Server](Configure-a-Federation-Server.md)|
|Optional step: Configure a federation server with Device Registration Service \(DRS\).|![Icon for the Configure a federation server with Device Registration Service link you can use in reference to deploying a federation server farm.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configure a federation server with Device Registration Service](Configure-a-federation-server-with-Device-Registration-Service.md)|
|Add a host \(A\) and alias \(CNAME\) resource record to corporate Domain Name System \(DNS\) for the federation service and DRS.|![Icon for the Configure Corporate DNS for the Federation Service and DRS link you can use in reference to deploying a federation server farm.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configure Corporate DNS for the Federation Service and DRS](Configure-Corporate-DNS-for-the-Federation-Service-and-DRS.md)|
|Verify that a federation server is operational.|![deploying federated server farm](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Verify That a Federation Server Is Operational](Verify-That-a-Federation-Server-Is-Operational.md)|


## See Also
[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)

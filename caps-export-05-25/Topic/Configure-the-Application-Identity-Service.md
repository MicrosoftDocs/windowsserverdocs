---
title: Configure the Application Identity Service
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb0a6a83-56e7-46e5-a57d-7d64c5d5f945
---
# Configure the Application Identity Service
This topic shows how to configure the Application Identity service to start automatically or manually in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
The Application Identity service determines and verifies the identity of an application. Stopping this service will prevent AppLocker policies from being enforced.  
  
> [!IMPORTANT]  
> When using Group Policy, you must configure it to start automatically in at least one Group Policy Object \(GPO\) that applies AppLocker rules. This is because AppLocker uses this service to verify the attributes of a file.  
  
#### To start the Application Identity service automatically using Group Policy  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**gpmc.msc** to open the Group Policy Management Console \(GPMC\).  
  
2.  Locate the GPO to edit, right\-click the GPO, and click **Edit**.  
  
3.  In the console tree under **Computer Configuration\\Windows Settings\\Security Settings**, click **System Services**.  
  
4.  In the details pane, double\-click **Application Identity**.  
  
5.  In **Application Identity Properties**, configure the service to start automatically.  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
#### To start the Application Identity service manually  
  
1.  Right\-click the taskbar, and click **Start Task Manager**.  
  
2.  Click the **Services** tab, right\-click **AppIDSvc**, and then click **Start Service**.  
  
3.  Verify that the status for the Application Identity service is **Running**.  
  

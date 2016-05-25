---
title: Step 3: Verify the Deployment_6
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75353982-9e14-4487-b17e-310a374fd138
author: vhorne
---
# Step 3: Verify the Deployment_6
[!INCLUDE[remote_access_combo](../Token/remote_access_combo_md.md)]  
  
This topic describes how to verify that you have correctly configured your deployment for remote management of DirectAccess clients .  
  
### To verify proper deployment  
  
1.  Connect a DirectAccess client computer to the corporate network and obtain the Group Policy Object.  
  
2.  On the client computer, click the **Network connections** icon in the notification area to access the DirectAccess Media Manager.  
  
3.  Click **DirectAccess Connection**, and you will see that the status is **Locally Connected**.  
  
4.  Remove the computer from the corporate network and connect it to a public network.  
  
5.  At a command prompt, type **nltest \/dsgetdc: \[fully qualified domain name\]**. This command will verify that the corporate network is accessible to the client. If the domain controller is not accessible, the following error message will display reporting that the domain does not exist: ERROR\_NO\_SUCH\_DOMAIN.  
  

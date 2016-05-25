---
title: Import an AppLocker Policy from Another Computer
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a34d2c2-8c90-4821-92ba-06fdb0eb608b
---
# Import an AppLocker Policy from Another Computer
This topic describes how to import an AppLocker policy in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
Before completing this procedure, you should have exported an AppLocker policy. For more information, see [Export an AppLocker Policy to an XML File](../Topic/Export-an-AppLocker-Policy-to-an-XML-File.md).  
  
[!INCLUDE[mingrp_admins](../Token/mingrp_admins_md.md)]  
  
> [!CAUTION]  
> Importing a policy will overwrite the existing policy on that computer.  
  
#### To import an AppLocker policy  
  
1.  On the computer where you want to edit or apply the policy, [!INCLUDE[clickstart_2](../Token/clickstart_2_md.md)]**secpol.msc** to open the Local Security Policy snap\-in.  
  
2.  In the console tree, expand **Application Control Policies**, right\-click **AppLocker**, and then click **Import Policy**.  
  
3.  In the **Import Policy** dialog box, locate the file that you exported, and then click **Open**.  
  
4.  The **Import Policy** dialog box will warn you that importing a policy will overwrite the existing rules and enforcement settings. If acceptable, click **OK** to import and overwrite the policy.  
  
5.  The **AppLocker** dialog box will notify you of how many rules were overwritten and imported. Click **OK**.  
  

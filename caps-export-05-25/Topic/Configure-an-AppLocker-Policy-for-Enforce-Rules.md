---
title: Configure an AppLocker Policy for Enforce Rules
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 01a3773d-68c6-45ea-8b0e-fd5792659acd
---
# Configure an AppLocker Policy for Enforce Rules
This topic describes the steps to enable the AppLocker policy enforcement setting in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
> [!NOTE]  
> When AppLocker policy enforcement is set to **Enforce rules**, rules are enforced for the rule collection and all events are audited.  
  
For information about how AppLocker policies are applied within a GPO structure, see [Understanding AppLocker Rules and Enforcement Setting Inheritance in Group Policy](http://technet.microsoft.com/library/ee449492(WS.10).aspx).  
  
You can perform this task by using the Group Policy Management Console for an AppLocker policy in a Group Policy Object \(GPO\) or by using the Local Security Policy snap\-in for an AppLocker policy on a local computer or in a security template. For information how to use these MMC snap\-ins to administer AppLocker, see [Using the MMC snap\-ins to administer AppLocker](../Topic/Administer-AppLocker.md#BKMK_Using_Snapins).  
  
#### To enable the Enforce rules enforcement setting  
  
1.  In the console tree of the snap\-in under **Computer Configuration\\Windows Settings\\Security Settings\\Application Control Policies**, right\-click **AppLocker**, and then click **Properties**.  
  
2.  On the **Enforcement** tab of the **AppLocker Properties** dialog box, select the **Configured** check box for the rule collection that you are editing, and then verify that **Enforce rules** is selected.  
  
3.  Click **OK**.  
  
For information about viewing the events generated from rules enforcement, see [View the AppLocker Log in Event Viewer](../Topic/Monitor-Application-Usage-with-AppLocker.md#BKMK_AppLkr_View_Log).  
  

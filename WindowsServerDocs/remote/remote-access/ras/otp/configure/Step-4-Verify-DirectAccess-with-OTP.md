---
title: Step 4 Verify DirectAccess with OTP
description: This topic is part of the guide Deploy Remote Access with OTP Authentication in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ed49a0a3-1c45-42e5-8f13-cad20c1c1d68
ms.author: pashort
author: shortpatti
---
# Step 4 Verify DirectAccess with OTP

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to verify that you have correctly configured your DirectAccess with OTP deployment.
  
### To verify OTP health on the Remote Access server

1. On the Remote Access server open the **Remote Access Management** console.  

2. Under **Remote Access Servers** click the Remote Access server that has been configured for OTP support.  

3. Click **Operations Status**.  

4. Verify that the status of OTP displays the green icon and is Working.  
  
    > [!NOTE]  
    > The health status update interval will be a maximum of the sum of the values from the registry key HKLM\SYSTEM\CCS\Services\Ramgmtsvc\parameters\HealthRefreshTimeout and the **Time interval for server activity** that was set in the Remote Access configuration.  
  
### To verify access to internal resources using OTP authentication  
  
1.  Connect a DirectAccess client computer to the corporate network and run **gpupdate /force** from the command prompt to obtain the group policy.  
  
2.  Disconnect the client computer from the corporate network, connect to the external network, and attempt to access internal resources. You should not have access to the internal resources.  
  
3.  In the case of a software token, access the OTP client token using the vendor instructions, and note the current token code. When a hardware token is used, follow the vendor instructions for authentication.  
  
4.  Click the **Network connections** icon in the notification area to access the DA Media Manager.  
  
5.  Click the **DirectAccess Connection**, and click **Continue**.  
  
6.  Enter the token code noted previously, and click **OK**. Wait for authentication to complete. The DirectAccess Workplace Connection status will now be **Connected**.  
  
7.  Attempt to access internal resources. You should be able to access all corporate resources.  
  



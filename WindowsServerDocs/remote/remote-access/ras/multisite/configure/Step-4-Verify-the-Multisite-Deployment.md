---
title: Step 4 Verify the Multisite Deployment
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 345b676a-a397-4d51-9973-8b25bc05fa55
ms.author: pashort
author: shortpatti
---
# Step 4 Verify the Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to verify that you have correctly configured your Remote Access multisite deployment.  
  
### To verify access to internal resources through the multisite deployment  
  
1.  Connect a DirectAccess client computer to the corporate network and obtain the group policy.  
  
2.  Connect the client computer to the external network and attempt to access internal resources.  
  
    You should be able to access all corporate resources.  
  
3.  Test connectivity through each server in the multisite deployment by turning off, or disconnecting from the external network, all but one of the Remote Access servers. On the client computer, attempt to access corporate resources. Repeat the test on a different multisite server. It may take up to 10 minutes for the client computer to connect to the new entry point. This is because probing is turned off for 10 minutes for an entry point after it is deemed unreachable, in order to optimize bandwidth and battery life. Alternatively, you can switch between the various entry-points manually by choosing the desired entry-point from the combo-box shown when executing **daprop.exe**.  
  
    You should be able to access all corporate resources through each multisite server.  
  
4.  Connect a  Windows 7&reg;  client computer to the corporate network and obtain the group policy.  
  
5.  Connect the  Windows 7  client computer to the external network and attempt to access internal resources.  
  
    You should be able to access all corporate resources.  
  
6.  Test connectivity for  Windows 7  clients through each server in the multisite deployment by accessing the Active Directory Users and Computers console, and moving the client computer to the security group that corresponds to each server. After the changes have replicated throughout the domain, restart the client computer while connected to the corporate network to obtain the new group policy. Attempt to access corporate resources. Repeat the test on a different multisite server.  
  
    You should be able to access all corporate resources through each multisite server.  
  
    In a production environment this method may not be feasible due to the amount of time required for changes to replicate throughout the domain. You may want to force replication where possible. Testing can also be done from multiple different  Windows 7  client computers that are already members of the different  Windows 7  security groups in the multisite deployment.  
  



---
title: Step 4 Verify the Cluster
description: This topic is part of the guide Deploy Remote Access in a Cluster in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f22dcf10-b453-4664-a9ef-e40e95c72f63
ms.author: lizross
author: eross-msft
---
# Step 4 Verify the Cluster

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to verify that you have correctly configured your DirectAccess cluster deployment.  
  
### To verify access to internal resources through the cluster  
  
1.  Connect a DirectAccess client computer to the corporate network and obtain the group policy.  
  
2.  Connect the client computer to the external network and attempt to access internal resources.  
  
    You should be able to access all corporate resources.  
  
3.  Test connectivity through each server in the cluster by turning off, or disconnecting from the external network, all but one of the cluster servers. On the client computer, attempt to access corporate resources. Repeat the test on a different cluster server.  
  
    You should be able to access all corporate resources through each cluster server.  
  



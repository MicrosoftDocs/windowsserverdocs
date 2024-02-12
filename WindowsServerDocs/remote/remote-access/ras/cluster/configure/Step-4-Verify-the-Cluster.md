---
title: Step 4 Verify the Cluster
description: Learn how to verify that you have correctly configured your DirectAccess cluster deployment.
manager: brianlic
ms.topic: article
ms.assetid: f22dcf10-b453-4664-a9ef-e40e95c72f63
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Step 4 Verify the Cluster

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This topic describes how to verify that you have correctly configured your DirectAccess cluster deployment.

### To verify access to internal resources through the cluster

1.  Connect a DirectAccess client computer to the corporate network and obtain the group policy.

2.  Connect the client computer to the external network and attempt to access internal resources.

    You should be able to access all corporate resources.

3.  Test connectivity through each server in the cluster by turning off, or disconnecting from the external network, all but one of the cluster servers. On the client computer, attempt to access corporate resources. Repeat the test on a different cluster server.

    You should be able to access all corporate resources through each cluster server.




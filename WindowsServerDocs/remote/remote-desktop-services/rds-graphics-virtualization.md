---
title: Remote Desktop Services - GPU acceleration
description: Planning information to help you choose the right graphics virtualization option for your RDS deployment.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/21/2019
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d6ff5b22-7695-4fee-b1bd-6c9dce5bd0e8
author: lizap
manager: scottman
---
# Remote Desktop Services - GPU acceleration

Remote Desktop Services works with native graphics acceleration as well as the graphics virtualization technologies supported by Windows Server. For information on those technologies, their differences, and how to deploy them, see [Plan for GPU acceleration in Windows Server](../../virtualization/hyper-v/plan/plan-for-gpu-acceleration-in-windows-server.md).

When planning for graphics acceleration in your RDS environment, your choice of user scale and user workloads will drive your choice of graphics rendering technology:

![Graphics rendering considerations - compares user scale and GPU requirements to determine the best GPU technology for your environment](media/rds-gpu.png)

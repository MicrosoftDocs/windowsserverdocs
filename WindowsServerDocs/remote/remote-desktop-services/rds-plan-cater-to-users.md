---
title: Remote Desktop Services - Cater to different kinds of users
description: Describes the different kinds of users for RDS.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: da522a18-c33f-468e-b9d6-3ad7d3cfba26
author: spatnaik
ms.author: spatnaik
ms.date: 09/23/2016
manager: scottman
---
# Remote Desktop Services - Cater to different kinds of users

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Remote Desktop Services supports different types of workloads. Scale your deployment depending on the expected need of each type of user.

## Types of users

### Knowledge user

Knowledge users use lightweight productivity applications like Microsoft Word, Excel, Outlook, and the Microsoft Edge browser.

### Professional user

Professional users use internet browsers and productivity applications in addition to supporting more intensive workloads like developing software and creating multimedia content.

### Power user

Power users use engineering and graphics applications like computer-aided design (CAD) and Adobe Photoshop. GPUs are often a good choice for users who regularly use graphics-intensive programs for video rendering, 3D design, and simulations.

To learn more about graphics acceleration, check out [Choose your graphics rendering technology](rds-graphics-virtualization.md).

Azure has other graphics acceleration deployment options and multiple available GPU VM sizes. Learn about these at [GPU optimized virtual machines sizes](https://docs.microsoft.com/azure/virtual-machines/windows/sizes-gpu).

## Test workload

We recommend you load test deployments with both stress tests and real-life usage simulations. You can use simulation tools like LoginVSI to load test your deployment. Make sure the system is responsive and resilient enough to meet user needs, and remember to vary the load size to avoid surprises.

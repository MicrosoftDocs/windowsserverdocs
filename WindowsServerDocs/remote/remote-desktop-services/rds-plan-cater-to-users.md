---
title: Remote Desktop Services - Cater to different kinds of users
description: Describes the different kinds of users for RDS.
ms.custom: na
ms.prod: windows-server-threshold
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

## Types of Users

### Knowledge User

Knowledge user uses lightweight productivity applications that include tasks such as data entry and dataset management. These applications include Word, Excel and Outlook and Edge.

### Professional User

Professional user uses browser and productivity applications that can support more intensive workloads. These tasks include software development and multimedia content.

### Power User

Power user uses engineering and graphics application such as CAD and Adobe Photoshop. GPUs are often a good choice for users that require graphics intensive support such as video rendering, 3D design, and simulations.

For more information on graphics acceleration usage, check out [Choose your graphics rendering technology](rds-graphics-virtualization.md).

For deployments on Azure, there are also graphics acceleration options on Azure. For more information on the available GPU VM sizes, check out [GPU optimized virtual machines sizes](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-gpu).

## Test Workload

It is recommended to load test the deployment with both stress tests and simulation of real-life usage. Vary the load size to avoid surprises! Ensure that responsiveness meets user requirements, and that the entire system is resilient. Create load tests with simulation tools, like LoginVSI, that check your deployment’s ability to meet the users’ needs.

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

## Knowledge User

Knowledge users use lightweight applications that may include task such as managing large datasets with productivity apps. These applications can include Word, Excel and Outlook and Internet Explorer.

## Knowledge User Plus

Knowledge user plus uses lightweight browser and productivity applications as well as tasks with multimedia content and software development.

## Power User

Power Users use engineering specific and/or graphics application such as CAD and Adobe Photoshop. There are GPU options for these users who require graphic intensive workloads including video rendering, 3D design, and simulations.

## Test Workload

It is recommended to load test the deployment with both stress tests and simulation of real-life usage. Vary the load size to avoid surprises! Ensure that responsiveness meets user requirements, and that the entire system is resilient. Create load tests with simulation tools, like LoginVSI, that check your deployment’s ability to meet the users’ needs.

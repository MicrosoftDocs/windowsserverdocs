---
title: Remote Desktop Services - Build anywhere
description: Planning information to help you determine where to host your RDS deployment.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c803a383-0eea-4e11-bca5-d204ab758048
author: lizap
ms.author: elizapo
ms.date: 09/07/2016
manager: dongill

---
# Remote Desktop Services - Build anywhere

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Deploy on-premises, in the cloud, or a hybrid of the two. Modify your deployment as your business needs change.

Regardless of where you are, the underlying [architecture](desktop-hosting-logical-architecture.md) of the Remote Desktop Services environment remains the same:
- You still must have an internet-facing server to utilize RD Web Access and RD Gateway for external users
- You still must have an Active Directory and--for highly available environments--a SQL database to house user and Remote Desktop properties
- You still must have communication access between the RD infrastructure roles (RD Connection Broker, RD Gateway, RD Licensing, and RD Web Access) and the end RDSH or RDVH hosts to be able to connect end-users to their desktops or applications.

This flexibility allows you to get the best of both worlds:
- The simplicity and pay-as-you-go methods associated with the cloud and the online world.
- The familiarity and hassle-free way of leveraging heavy resources that already exist on-premises.

For additional information, look at how to [build and deploy your Remote Desktop Services deployment](rds-build-and-deploy.md).
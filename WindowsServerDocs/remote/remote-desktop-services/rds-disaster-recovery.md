---
title: Protect your RDS deployment - Disaster recovery
description: Learn about your disaster recovery options for Remote Desktop Services
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9ff6a3b0-ea14-424e-9524-209252e9f1a8
author: lizap
ms.author: elizapo
ms.date: 06/12/2017
---
# Configure disaster recovery for Remote Desktop Services

When you deploy Remote Desktop Services into your environment, it becomes a critical part of your infrastructure, particularly the apps and resources that you share with users. If any part of the RDS deployment goes down, from a network failure to a natural disaster, users can't access those apps and resources, and your business is negatively impacted. To avoid this, you can configure a disaster recovery solution that builds redundancy into your deployment - if any one RDS component is unavailable, for whatever reason, there is a backup available to automatically take over.

You have a number of options available to set up disaster recovery - you can set up an [RDSH farm](rds-scale-rdsh-farm.md), ensure your [Connection Brokers are clustered for high availability](rds-connection-broker-cluster.md), or more specifically, configure specific disaster recovery technologies and solutions. 

Use the following information to deploy disaster recovery solutions in RDS:

- [Leverage multiple Azure data centers to ensure users can access your RDS deployment, even if one Azure data center goes down (geo-redundancy)](rds-multi-datacenter-deployment.md)
- [Deploy Azure Site Recovery to provide failover for RDS components in site-to-site or site-to-Azure failovers](rds-disaster-recovery-with-azure.md)



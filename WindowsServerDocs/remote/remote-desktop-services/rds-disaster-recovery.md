---
title: Protect your RDS deployment - Disaster recovery
description: Learn about your disaster recovery options for Remote Desktop Services
ms.custom: na
ms.prod: windows-server
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

When you deploy Remote Desktop Services into your environment, it becomes a critical part of your infrastructure, particularly the apps and resources that you share with users. If the RDS deployment goes down due to anything from a network failure to a natural disaster, users can't access those apps and resources, and your business is negatively impacted. To avoid this, you can configure a disaster recovery solution that allows you to failover your deployment - if your RDS deployment is unavailable, for whatever reason, there is a backup available to automatically take over.

To keep your RDS deployment running in the case of a single component or machine going down, we recommend configuring your RDS deployment for high availability. You can do this by setting up an [RDSH farm](rds-scale-rdsh-farm.md) and ensuring your [Connection Brokers are clustered for high availability](rds-connection-broker-cluster.md). 

The disaster recovery solutions we recommend here are to protect your deployment from catastrophic disaster - something that takes down your entire RDS deployment (including redundant roles configured for high availability). If such a disaster hits, having a disaster recovery solution built into your deployment will allow you to failover the entire deployment and quickly get apps and resources up and running for your users.

Use the following information to deploy disaster recovery solutions in RDS:

- [Leverage multiple Azure data centers to ensure users can access your RDS deployment, even if one Azure data center goes down (geo-redundancy)](rds-multi-datacenter-deployment.md)
- [Deploy Azure Site Recovery to provide failover for RDS components in site-to-site or site-to-Azure failovers](rds-disaster-recovery-with-azure.md)



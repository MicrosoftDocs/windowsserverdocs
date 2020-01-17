---
title: Set up disaster recovery for RDS using Azure Disaster Recovery
description: Learn how to use Azure Disaster Recovery for disaster recovery for an RDS deployment
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 06/12/2017
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
---
# Set up disaster recovery for RDS using Azure Site Recovery

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

You can use Azure Site Recovery to create a disaster recovery solution for your Remote Desktop Services deployment. 

[Azure Site Recovery](/azure/site-recovery/site-recovery-overview) is an Azure-based service that provides disaster recovery capabilities by orchestrating replication, failover, and recovery of virtual machines. Azure Site Recovery supports a number of replication technologies to consistently replicate, protect, and seamlessly failover virtual machines and applications to private/public or hoster's clouds. 

Use the following information to create and validate the disaster recovery solution.

## Disaster recovery deployment options

You can deploy RDS on either physical servers or virtual machines running Hyper-V or VMWare. Azure Site Recovery can protect both on-premises and virtual deployments to either a secondary site or to Azure. The following table shows the different supported RDS deployments in site-to-site and site-to-Azure disaster recvoery scenarios.

| Deployment type                          | Hyper-V site-to-site | Hyper-V site-to-Azure | VMWare site-to-Azure | Physical site-to-Azure |
|------------------------------------------|----------------------|-----------------------|---------------------|----------------------|-----------------------|------------------------|
| Pooled virtual desktop (unmanaged)       |Yes|No|No|No |
| Pooled virtual desktop (managed, no UPD) | Yes|No|No|No|
| RemoteApps and desktop sessions (no UPD) | Yes|Yes|Yes|Yes  |

## Prerequisites

Before you can configure Azure Site Recovery for your deployment, make sure you meet the following requirements:

- Create an [on-premises RDS deployment](rds-deploy-infrastructure.md).
- Add [Azure Site Recovery Services vault](/azure/site-recovery/site-recovery-vmm-to-azure#create-a-recovery-services-vault) to your Microsoft Azure subscription.
- If you are going to use Azure as your recovery site, run the [Azure Virtual Machine Readiness Assessment tool](https://azure.microsoft.com/downloads/vm-readiness-assessment/) on your VMs to ensure they are compatible with Azure VMs and Azure Site Recovery Services.
 
## Implementation checklist

We'll cover the various steps to enable Azure Site Recovery Services for your RDS deployment in more detail, but here are the high-level implementation steps.

| **Step 1 - Configure VMs for disaster recovery**                                                                                                                                                                                               |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Hyper-V - Download the Microsoft Azure Site Recovery Provider. Install it on your VMM server or Hyper-V host. See [Prerequisites for replication to Azure by using Azure Site Recovery](/azure/site-recovery/site-recovery-prereq) for information.                                                                                                                             |
| VMWare - Configure protection server, configuration server, and master target servers                                                                                                                                                      |
| **Step 2 - Prepare your resources**                                                                                                                                                                                                           |
| Add an [Azure Storage account](/azure/storage/storage-create-storage-account).                                                                                                                                                                                                              |
| Hyper-V - Download the Microsoft Azure Recovery Services agent and install it on Hyper-V host servers.                                                                                                                                     |
| VMWare - Make sure the mobility service is installed on all VMs.                                                                                                                                                                           |
| [Enable protection for VMs in VMM cloud, Hyper-V sites, or VMWare sites](rds-enable-dr-with-asr.md).                                                                                                                                                                    |
| **Step 3 - Design your recovery plan.**                                                                                                                                                                                                        |
| Map your resources - map on-premises networks to Azure VNETs.                                                                                                                                                                              |
| [Create the recovery plan](rds-disaster-recovery-plan.md). |
| Test the recovery plan by creating a test failover. Ensure all VMs can access required resources, like Active Directory. Ensure network redirections are configured and working for RDS. For detailed steps on testing your recovery plan, see [Run a test failover](/azure/site-recovery/site-recovery-test-failover-to-azure)|
| **Step 4 - Run a disaster recovery drill.**                                                                                                                                                                                                     |
| Run a disaster recovery drill using planned and unplanned failovers. Ensure that all VMs have access to required resources, such as Active Directory. Ensure that all VMs have access to required resources, such as Active Directory. For detailed steps on failovers and how to run drills, see [Failover in Site Recovery](/azure/site-recovery/site-recovery-failover).|



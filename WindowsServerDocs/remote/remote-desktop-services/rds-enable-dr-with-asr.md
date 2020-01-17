---
title: Enable disaster recovery of RDS using Azure Site Recovery
description: Learn how to enable disaster recovery of RDS using Azure Site Recovery.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 05/05/2017
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
---
# Enable disaster recovery of RDS using Azure Site Recovery

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

To ensure that your RDS deployment is adequately configured for disaster recovery, you need to protect all of the components that make up your RDS deployment:

- Active Directory
- SQL Server tier
- RDS components
- Network components

## Configure Active Directory and DNS replication

You need Active Directory on the disaster recovery site for your RDS deployment to work. You have two choices based on how complex your RDS deployment is:

- Option 1 - If you have a small number of applications and a single domain controller for your entire on-premises site, and you will be failing over the entire site together, use ASR-Replication to replicate the domain controller to the secondary site (true for both site-to-site and site-to-Azure scenarios).
- Option 2 - If you have a large number of applications and you're running an Active Directory forest, and you'll failover a few applications at a time, set up an additional domain controller on the disaster recovery site (either a secondary site or in Azure).

See [Protect Active Directory and DNS with Azure Site Recovery](/azure/site-recovery/site-recovery-active-directory) for details on making a domain controller available on the disaster recovery site. For the rest of this guidance, we assume that you've followed those steps and have the domain controller available.

## Set up SQL Server replication

See [Protect SQL Server using SQL Server disaster recovery and Azure Site Recovery](/azure/site-recovery/site-recovery-sql) for the steps to set up SQL Server replication.

## Enable protection for the RDS application components

Depending on your RDS deployment type you can enable protection for different component VMs (as listed in the table below) in Azure Site Recovery. Configure the relevant Azure Site Recovery elements based on whether your VMs are deployed on Hyper-V or VMWare.


|               Deployment type                |                                                                                                     Protection steps                                                                                                     |
|----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     Personal virtual desktop (unmanaged)     | 1. Make sure all virtualization hosts are ready with the RDVH role installed.    </br>2. Connection Broker.  </br>3. Personal desktops. </br>4. Gold template VM. </br>5. Web Access, License server, and Gateway server |
| Pooled virtual desktop (managed with no UPD) |                    1. All virtualization hosts are ready with the RDVH role installed.  </br>2. Connection Broker.  </br>3. Gold template VM. </br>4. Web Access, License server, and Gateway server.                    |
|   RemoteApps and Desktop Sessions (no UPD)   |                                                          1. Session Hosts.  </br>2. Connection Broker. </br>3. Web Access, License server, and Gateway server.                                                           |


---
title: "What's New in Windows Server 2016 Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: affff774-5fa6-4944-887a-9bfde05f6a3f
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# What's New in Windows Server 2016 Essentials

> Applies To: Windows Server 2016 Essentials

Following are new and enhanced features in Windows Server 2016 Essentials.

## [Integration with Azure Site Recovery Services](azure-site-recovery-services-integration.md)

**What it does** -- When a virtual machine that is protected  fails, or the host server that the protected virtual machine runs on fails, failing-over with Azure Site Recovery Services  maintains business continuity until the on premises virtual machine or host server is repaired and available. 

**How it works** -- Azure Site Recovery Services, offered in Microsoft Azure, enables real-time replication of your virtual machines (VM) to a backup vault in Azure. In the event that your server or site goes down due to a hardware or other failure, you can fail-over with Azure Site Recovery Services so  that the VM image stored in your backup vault will be provisioned as a running VM in Azure. Combined with an Azure Virtual network, client PCs that previously connected to the on-premises server will transparently connect to the server running in Azure.     
                                                                                                                                                                                                                                                                                                               

## [Integration with Azure Virtual network](azure-virtual-network-integration.md)

**What it does**-- As organizations make their way to cloud computing, they rarely  move all of their resources at one time. Rather, they move some resources to the cloud and keep some on premises. That way, it's easy to move an organization to the cloud in stages over time. Azure virtual Network integration provides the network infrastructure that makes that process seamless and manageable.

**How it works** -- Azure Virtual networking is a service offered in Microsoft Azure that enables organizations to create a point-to-point (P2P) or site-to-site (S2S) virtual private network that makes the resources that are running in Azure (such as virtual machines and storage) look as though they are on the local network for seamless application and resource access.



## [Support for Larger Deployments](support-for-larger-deployments.md) 

Some larger small businesses need more functionality and capacity to implement Windows Server Essentials effectively. Windows Server 2016 Essentials provides increased manageability of domains, users and devices by adding support for larger deployments with:                                                                                                                                                                                                 

 - multiple domains
 - multiple domain controllers                                                                                                                                                                                                                                        
 - ability to specify a designated domain controller                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       

See also
--------

[Get started with Windows Server Essentials](get-started.md)

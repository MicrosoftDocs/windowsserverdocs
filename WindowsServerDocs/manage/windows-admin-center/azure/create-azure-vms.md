---
title: Deploy Azure Virtual Machines using Windows Admin Center
description: Deploying Azure virtual machines with Windows Admin Center. Configuring Azure virtual machines as part of Windows Admin Center-managed scenarios.
ms.technology: manage
ms.topic: article
author: nedpyle
ms.author: nedpyle
manager: jgerend
ms.date: 01/28/2020
ms.localizationpriority: medium
ms.prod: windows-server
---

# Deploy Azure virtual machines from within Windows Admin Center

>Applies to: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center version 1910 allows you to deploy Azure virtual machines. This integrates VM deployment into Windows Admin Center-managed workloads like [Storage Migration Service](../../../storage/storage-migration-service/overview.md) and [Storage Replica](../../../storage/storage-replica/storage-replica-overview.md). Instead of building new servers and VMs in the Azure Portal by hand prior to deploying your workload - and possibly missing required steps and configuration - Windows Admin Center can deploy the Azure VM, configure its storage, join it to your domain, install roles, and then set up your distributed system. You can also deploy new Azure VMs without a workload from the Windows Admin Center Connections page.

Windows Admin Center also manages a variety of Azure services. [Learn more about the Azure integration options available with Windows Admin Center](../plan/azure-integration-options.md).

## Scenarios

Windows Admin Center version 1910 Azure VM deployment supports the following scenarios:

- [Storage Migration Service](../../../storage/storage-migration-service/overview.md)
- [Storage Replica](../../../storage/storage-replica/storage-replica-overview.md)
- [New standalone server (without roles)](index.md#extend-on-premises-capacity-with-azure)

## Requirements

Creating a new Azure VM from within Windows Admin Center requires that you have:

- An [Azure subscription](https://azure.microsoft.com).
- A [Windows Admin Center gateway registered with Azure](azure-integration.md)
- An existing [Azure resource group](https://docs.microsoft.com/azure/azure-resource-manager/management/overview) where you have Create permissions.
- An existing [Azure Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview) and subnet.
- An [Azure Express Route](https://azure.microsoft.com/services/expressroute/) or [Azure VPN solution](https://azure.microsoft.com/services/vpn-gateway/) tied to the virtual network and subnet that allows connectivity from Azure VMs to your on-premises clients, domain controllers, the Windows Admin Center computer, and any servers requiring communication with this VM as part of a workload deployment. For instance, to use the Storage Migration Service to migrate storage to an Azure VM, the orchestrator computer and the source computer must both be able to contact the destination Azure VM you are migrating to.

## Usage

Azure VM deployment steps and wizards vary by scenario. Review the workload's documentation for detailed information about the overall scenario.

### Deploying Azure VMs as part of Storage Migration Service

1. From the *Storage Migration Service* tool within Windows Admin Center, perform an inventory of one or more source servers.
2. Once you're in the *Transfer Data* phase, select **Create a new Azure VM** on the *Specify a destination* page then click **Create VM**.<br><br>
This begins a step-by-step creation tool that selects a Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 Azure VM as a destination for the migration. Storage Migration Service provides recommended VM sizes to match your source, but you can override them by clicking **See all sizes**.
<br><br>Source server data is also used to automatically configure your managed disks and their file systems as well as join your new Azure VM to your Active Directory domain. If the VM is Windows Server 2019 (which we recommend), Windows Admin Center installs the Storage Migration Service proxy feature. Once it has created the Azure VM, Windows Admin Center returns to the normal Storage Migration Service transfer workflow.  

Here's a video showing how to use Storage Migration Service to migrate to Azure VMs.

> [!VIDEO https://www.youtube-nocookie.com/embed/k8Z9LuVL0xQ] 

### Deploying Azure VMs as part of Storage Replica

1. From the *Storage Replica* tool within Windows Admin Center, under the *Partnerships* tab, select **New** and then under *Replicate with another server* select **Use a New Azure VM** then select **Next**.
2. Specify your source server information and replication group name, and then select **Next**.<br><br>
This begins a process that automatically selects a Windows Server 2016 or Windows Server 2019 Azure VM as a destination for the migration source. Storage Migration Service recommends VM sizes to match your source, but you can override this by selecting **See all sizes**. Inventory data is used to automatically configure your managed disks and their file systems, as well as join your new Azure VM to your Active Directory domain. 
3. After Windows Admin Center creates the Azure VM, provide a replication group name and then select **Create**. Windows Admin Center then begins the normal Storage Replica initial synchronization process to start protecting your data.

Here's a video showing how to use Storage Replica to replicate to Azure VMs.

> [!VIDEO https://www.youtube-nocookie.com/embed/_VqD7HjTewQ] 

### Deploying a new standalone Azure VM

1. From the *All Connections* page within Windows Admin Center, select **Add**.
2. In the *Azure VM* section, select **Create new**.<br><br> This begins a step-by-step creation tool that will let you select a Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 Azure VM, pick a size, add managed disks, and optionally join your Active Directory domain.

Here's a video showing how to use Windows Admin Center to create Azure VMs.

> [!VIDEO https://www.youtube-nocookie.com/embed/__A8J9aC_Jk] 

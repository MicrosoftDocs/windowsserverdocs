---
title: Deploying Azure Virtual Machines Using Windows Admin Center
description: Deploying Azure virtual machines with Windows Admin Center. Configuring Azure virtual machines as part of Windows Admin Center-managed scenarios.
ms.technology: manage
ms.topic: article
author: ned-pyle
ms.author: nedpyle
manager: jgerend
ms.date: 01/16/2020
ms.localizationpriority: medium
ms.prod: windows-server
---

# Azure virtual machine deployment overview

>Applies to: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center version 1910 allows you to deploy Azure virtual machines. This integrates VM deployment into Windows Admin Center-managed workloads like [Storage Migration Service (SMS)](https://docs.microsoft.com/windows-server/storage/storage-migration-service/overview) and [Storage Replica (SR)](https://docs.microsoft.com/windows-server/storage/storage-replica/storage-replica-overview). Instead of building new servers and VMs in the Azure Portal by hand prior to deploying your workload - and possibly missing required steps and configuration - Windows Admin Center can deploy the Azure VM, configure its storage, join it to your domain, install roles, then setup your distributed system. You can also deploy new Azure VMs without a workload from the Windows Admin Center Connections page.

Windows Admin Center also manages a variety of Azure services. [Learn more about the Azure integration options available with Windows Admin Center.](../plan/azure-integration-options.md).

## Scenarios

Windows Admin Center version 1910 Azure VM deployment supports the following scenarios:

- [Storage Migration Service (SMS)](https://docs.microsoft.com/windows-server/storage/storage-migration-service/overview)
- [Storage Replica (SR)](https://docs.microsoft.com/windows-server/storage/storage-replica/storage-replica-overview)
- [New standalone server (without roles)](https://docs.microsoft.com/windows-server/manage/windows-admin-center/azure/#extend-on-premises-capacity-with-azure)

*------ A screenshot of Conan goes here-------*

## Requirements

Using "Create a new Azure VM" requires that you have:

- An [Azure subscription](https://azure.microsoft.com).
- A [Windows Admin Center gateway registered with Azure](https://docs.microsoft.com/windows-server/manage/windows-admin-center/azure/azure-integration)
- An existing [Azure resource group](https://docs.microsoft.com/azure/azure-resource-manager/management/overview) where you have Create permissions.
- An existing [Azure Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview) and subnet.
- An [Azure Express Route](https://azure.microsoft.com/services/expressroute/) or [Azure VPN solution](https://azure.microsoft.com/services/vpn-gateway/) tied to the Virtual Network and subnet that allows connectivity from Azure VMs to your on-premises clients, domain controllers, the Windows Admin Center computer, and any servers requiring communication with this VM as part of a workload deployment. For instance, with the Storage Migration Service, the orchestrator computer and the source computer must be able to contact the destination Azure VM you are migrating to in order to perform the migration.

## Usage

Azure VM deployment steps and wizards vary by scenario. Review the workload's documentation for detailed information about the overall scenario.

### Deploying Azure VMs as part of Storage Migration Service

From the *Storage Migration Service* tool within Windows Admin Center, perform an inventory of one or more source servers. Once you're in the *Transfer Data* phase, select **Create a new Azure VM** on the *Specify a destination* page then click **Create VM**. This begins a step-by-step creation tool that selects a Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 Azure VM as a destination for the migration. Storage Migration Service Inventory data will provide several recommended VM sizes to match your source, but you can override this by clicking **See all sizes**. Source server data will also be used to automatically configure your managed disks and their file systems as well as join your new Azure VM to your Active Directory domain. If the VM is Windows Server 2019 (recommended), Windows Admin center installs the Storage migration Service proxy feature. Once it has created the Azure VM, Windows Admin Center will return to the normal Storage Migration Service transfer workflow.  

Here's a demo of using Windows Admin Center to deploy a new destination server in Azure for the Storage Migration Service.

*------A youtube video demo of SMS and Conan goes here------*

### Deploying Azure VMs as part of Storage Replica

From the *Storage Replica* tool within Windows Admin Center, under the *Partnerships* tab, click **New** and then under *Replicate with another server* click **Use a New Azure VM** then click **Next**. Specify your source server information and replication group name, then click **Next**. This begins a step-by-step creation tool that will automatically select a Windows Server 2016 or Windows Server 2019 Azure VM as a destination for the migration source. Source server data will provide several recommended VM sizes to match your source, but you can override this by clicking **See all sizes**. Inventory data will also be used to automatically configure your managed disks and their file systems, as well as join your new Azure VM to your Active Directory domain. Once Windows Admin Center has created the Azure VM, provide a replicaiton group name and click **Create**. Windows Admin Center will return to the normal Storage Replica initial synchronization and start protecting your data.

Here's a demo of using Windows Admin Center to deploy a new partner server in Azure for Storage Replica.

*------A youtube video demo of SR and Conan goes here------*

### Deploying a new standalone Azure VM

From the *All Connections* page within Windows Admin Center, go to **Add** and select **Create new** under **Azure VM**. This begins a step-by-step creation tool that will let you select a Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019 Azure VM, pick a size, add managed disks, and optionally join your Active Directory domain.

Here's a demo of using Windows Admin Center to deploy a new standalone server in Azure.

*------A youtube video demo of SR and Conan goes here------*

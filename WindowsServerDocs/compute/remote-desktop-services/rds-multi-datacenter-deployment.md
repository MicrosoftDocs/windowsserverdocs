---
title: Remote Desktop Services - Access from anywhere
description: Learn how to create an RDS deployment that uses multiple datacenters to provide high availability across geographic locations.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 61c36528-cf47-4af0-83c1-a883f79a73a5
author: lizap
ms.author: elizapo
ms.date: 02/21/2017
manager: dongill
---
# Create a geo-redundant, multi-datacenter RDS deployment

>Applies To: Windows Server 2016

You can increase the availability of your Remote Desktop Services deployment by leveraging multiple datacenters in Azure. Unlike a standard highly available RDS deployment (as outlined in the [Desktop Hosting logical architecture](desktop-hosting-logical-architecture.md)), which uses datacenters in a single Azure region (for example, Western Europe), a multi-datacenter deployment uses datacenters in mulitple geographic locations, increasing the availabilty of your deployment - one Azure datacenter might be unavailable, but it is unlikely that multiple regions would go down at the same time.

You can use the instructions below to leverage Microsoft Azure infrastructure services and RDS to delver geo-redundant desktop hosting services and Subscriber Access Licenses (SALs) to multiple tenants through the [Microsoft Service Provider License Agreement (SPLA) program](http://www.microsoft.com/hosting/licensing/splabenefits.aspx). You can also use the steps below to create a geo-redundant hosting service for your own employees using [RDS User CALs extended rights through Software Assurance](http://download.microsoft.com/download/6/B/A/6BA3215A-C8B5-4AD1-AA8E-6C93606A4CFB/Windows_Server_2012_R2_Remote_Desktop_Services_Licensing_Datasheet.pdf).

## Logical architecture for high availability - single and multiple regions
The following image shows the architecture for a highly available deployment in a single Azure region:

![A highly available deployment in a single Azure region](media/rds-ha-single-region.png)

The deployment consists of three layers:

- Azure services - the Azure Management interfaces, including the Azure portal and APIs, and public networking services, such as DNS and public IP addressing.
- Desktop hosting service - Virtual machines, networks, storage, Azure services, and Windows Server role services
- Azure Fabric - Windows Server operating systems running the Hyper-V role, usded to virtualize physical servers, storage units, network switches, and routers. Using Azure Fabric lets you create VMs, networks, storage, and applications independent from underlying hardware.


In comparison, here is the architecture for a deployment using multiple Azure datacenters:

![An RDS deployment that uses multiple Azure regions](media/rds-ha-multi-region.png)

The entire RDS deployment is replicated in a second Azure region to create a geo-redundant deployment. This architecture uses an active-passive model, where only one RDS deployment is running at a time. The RDS deployments are based on a single Active Directory forest/domain. The VNets for both deployments are connected through a VNet-to-VNet VPN connection so that the AD servers can replicate across the two deployments, meaning users can log into either deployment using the same credentials.

You *could* create a non-highly available RDS deployment in each region, but that solution has the following challenges:

- Azure availability sets cannot span Azure regions, so there is guarantee that a VM in both deployments would not b restarted simultaneously. With non-highly available deployments, this would cause both regions to fail, resulting in a loss of service.
- Even if only a single VM is restarted in one region, a fail-over would occur, increasing the likelihood of failovers occuring with associated performance impacts.

## Deployment steps
Create the following resources in Azure to create a geo-redundant multi-datacenter RDS deployment:

1. Two resource groups in two separate Azure regions.
2. A VNet in each resource group with non-overlapping IP address space.
3. A VNet-to-VNet VPN connection, as described in [Configure a VNet-to-VNet connection for Resource Manager using PowerShell](https://azure.microsoft.com/documentation/articles/vpn-gateway-vnet-vnet-rm-ps/).
4. Two Active Directory server VMs in the 1st resource group. If you care creating a hybrid deployment with AD on-premises, the the AD VMs are replicas of the on-premises servers. If you are creating a cloud-only deployment, create a new [forest and domain](https://azure.microsoft.com/documentation/templates/active-directory-new-domain-ha-2-dc/).
5. Two Active Directory VMs in the 2nd resource group as replicas of the forest/domain in the 1st resource group.
6. A highly available RDS deployment in each resource group using the [existing domain](https://azure.microsoft.com/documentation/templates/rds-deployment-existing-ad/). (Use the associated ARM templates to create highly available RDWeb+Gateway VMs and highly available Connection Broker VMs.)
7. A [Traffic Manager instance](https://azure.microsoft.com/documentation/articles/traffic-manager-overview/) that probes the RD Web site at the public IP address for each of the deployments and fails over to the other on probe failure. You can further customize Traffic Manager depending on your deployment. For example, you could optimize connections from a given client to the Azure region with the lowest latency from that client. 

## Azure resources
You can create the RDS deployments in a single Azure subscription or in two subscriptions.

Use a minimum of two storage accounts in each resource group.

## RD License server
You need a per-user RD CAL for each named user that is authorized to access the geo-redundant deployment. Distribute the per-user CALs evenly across all four of the License servers (two in each deployment) to ensure that RD CALs are available regardless of individual license server failures or the catastrophic failure of one of the RDS deployments.

## Active-Active versus Active-Passive
You can run the system in Active-Active mode, where all VMs in both deployment keep running. This gives you the fastest recovery time and best user experience in the case of a catastrophic failure of one of the deployments. Note, however, that this will lead to the highest cost.

Alternatively, you can run the system in Active-Passive mode, where only one RDS deployment runs at a time. The AD servers in both deployments must be kept running simulataneously to ensure that user accounts are in sync. This option costs less but will be slower in the case of fail-over. If a catastrophic failure occurs in the active deployment, either an administrator will have to manually start the passive deployment or you'll need to have put in place an automation script to detect the failure and then start the passive deployment. Either way, it might take several minutes for the passive deployment to get up and running, which can result in downtime for your service.

## Image Management
Because RD Session Host images are updated to pvoide software updates or new applications, you'll need to update your RD Session Host collections separately in each deployment to maintain the common user experience across the deployments.
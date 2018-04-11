---
title: What Azure integration options are there
description: What Azure integration options are there Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# What Azure integration options are there with Windows Admin Center?

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Windows Admin center was built with the cloud in mind, and Azure integration is built-in to help you leverage the power of Azure resources from your servers, whether they're on-premises or in the cloud. Though Windows Admin Center has no Azure dependencies or requirements and does not require internet connectivity for deployment, you can optionally add integration with selected Azure services described below. 

## Azure Active Directory authentication
By choosing [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory/) as your identity provider for Windows Admin Center gateway access, you restrict access to the gateway service based on Azure ID identities. Azure AD integration also allows you to benefit from Azure AD’s powerful security features like conditional access and multi-factor authentication. 

[Learn about configuring AAD authentication for Windows Admin Center.](../configure/user-access-control.md#gateway-access-management)  

## Manage Azure IaaS virtual machines
You can use Windows Admin Center to manage your Azure VMs as well as on-premises machines. By configuring your Windows Admin Center gateway to have connectivity to your Azure VNet, you can manage virtual machines in Azure using the consistent, simplified toolset Windows Admin Center provides.

[Learn how to configure Windows Admin Center to manage VMs in Azure.](../configure/azure-integration.md#manage-azure-iaas-virtual-machines-with-windows-admin-center)


## Protect your Hyper-V virtual machines with Azure Site Recovery
[Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview) is an Azure service that replicates workloads running on VMs so that your business-critical infrastructure is protected in case of a disaster. Windows Admin Center streamlines the setup and process of replicating your virtual machines on your Hyper-V servers or clusters, making it easy to bolster the resiliency of your environment with Azure Site Recovery’s disaster recovery service.

[Learn how to protect your virtual machines with Azure Site Recovery with Windows Admin Center.](../use/azure-services.md)
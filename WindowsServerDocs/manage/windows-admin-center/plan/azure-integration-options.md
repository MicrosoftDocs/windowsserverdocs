---
title: What Azure integration options are there
description: What Azure integration options are there Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 06/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# What Azure integration options are there with Windows Admin Center?

>Applies To: Windows Admin Center, Windows Admin Center Preview

Windows Admin center was built with the cloud in mind - that means Azure integration is built in to help you leverage Azure resources from your servers, whether they're on-premises or in the cloud. Although Windows Admin Center has no Azure dependencies or requirements and doesn't require internet connectivity for deployment, you can optionally add integration with the Azure services described below.

## Azure Active Directory authentication
You can add an additional layer of security to Windows Admin Center by requiring users to authenticate using [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory/) identities to access the gateway. Azure AD authentication also lets you take advantage of Azure AD’s security features like conditional access and multi-factor authentication.

[Learn how to configure Azure AD authentication for Windows Admin Center.](../configure/user-access-control.md#azure-active-directory)  

## Manage Azure IaaS virtual machines
You can use Windows Admin Center to manage your Azure VMs as well as on-premises machines. By configuring your Windows Admin Center gateway to have connectivity to your Azure VNet, you can manage virtual machines in Azure using the consistent, simplified tools Windows Admin Center provides.

[Learn how to configure Windows Admin Center to manage VMs in Azure.](../configure/manage-azure-vms.md)

## Protect your Hyper-V virtual machines with Azure Site Recovery
[Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview) is an Azure service that replicates workloads running on VMs so that your business-critical infrastructure is protected in case of a disaster. Windows Admin Center streamlines setup and the process of replicating your virtual machines on your Hyper-V servers or clusters, making it easy to bolster the resiliency of your environment with Azure Site Recovery’s disaster recovery service.

[Learn how to protect your virtual machines with Azure Site Recovery from Windows Admin Center.](../use/azure-site-recovery.md)

##  Backup your Windows Servers from Windows Admin Center with Azure Backup 
[Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview) enables you to back up your Windows Servers to Azure, protecting you from accidental or malicious deletions, corruption and even ransomware.

[Learn how to backup your servers with Azure Backup from Windows Admin Center.](../use/azure-backup.md)

## Monitor and get email alerts for all the servers in your environment with Azure Monitor for Virtual Machines
[Azure Monitor for Virtual Machines](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-overview), also known as Virtual Machines insights, is a solution in Azure Monitor that allows you to monitor server health and events, create email alerts, get a consolidated view of server performance across your environment, and visualize apps, systems, and services connected to a given server.

[Learn how to connect your servers to Azure Monitor and configure email notifications using Windows Admin Center.](../use/azure-monitor.md)


## Centrally manage operating system updates for all your Windows Servers with Azure Update Management
[Azure Update Management](https://docs.microsoft.com/azure/automation/automation-update-management) is a solution in Azure Automation that allows you to manage updates and patches for multiple machines from a single place, rather than on a per-server basis. With Azure Update Management, you can quickly assess the status of available updates, schedule installation of required updates, and review deployment results to verify updates that apply successfully. This is possible whether your machines are Azure VMs, hosted by other cloud providers, or on premise. 

[Learn how to configure servers for Azure Update Management with Windows Admin Center.](../use/azure-update-management.md)

## Easily connect your on-premises servers to an Azure Virtual Network with Azure Network Adapter

In the network tool, you’ll find the option to add an Azure Network Adapter. This is a virtual NIC that will help you securely connect your local computer to an Azure Virtual Network.

[Learn how to configure a point-to-site VPN connection between an on-premises Windows Server and an Azure Virtual Network in one click.](https://aka.ms/WACNetworkAdapter)
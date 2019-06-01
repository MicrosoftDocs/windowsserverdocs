---
title: Connecting Windows Server to Azure hybrid services
description: You can extend on-premises deployments of Windows Server to the cloud by using Azure hybrid services.
ms.technology: manage
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.localizationpriority: medium
ms.prod: windows-server-threshold
ms.date: 05/31/2019
---
# Connecting Windows Server to Azure hybrid services

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

You can extend on-premises deployments of Windows Server to the cloud by using Azure hybrid services. These cloud services provide an array of useful functions, including the following:

- Protect virtual machines and use cloud-based backup and disaster recovery (HA/DR) with Azure Site Recovery. 
- Track what’s happening across your applications, network and infrastructure with the help of advanced analytics and machine learning in Azure Monitor. 
- Simplify network connectivity to Azure with Azure Network Adapter.
- Keep virtual machines up to date with Azure Update Management.

Azure hybrid services work with Windows Servers in the following configurations:

- Stand-alone physical servers and virtual machines (VMs)
- Clusters, including hyper-converged clusters certified by the [Azure Stack HCI](https://docs.microsoft.com/azure-stack/operator/azure-stack-hci-overview), and [Windows Server Software-Defined (WSSD)](https://www.microsoft.com/en-us/cloud-platform/software-defined-datacenter) programs

While you can set up most Azure hybrid services using the Azure portal and a download or two, many are integrated directly into Windows Admin Center to provide a simplified setup experience and a server-centric view of the services.

## Azure hybrid services tool

The Azure hybrid services tool in [Windows Admin Center](../understand/windows-admin-center.md) consolidates all the integrated Azure services into a centralized hub where you can easily discover all the available Azure services that bring value to your on-premises or hybrid environment. 

![Screenshot of Windows Admin Center showing the Azure Hybrid Services tool](../media/azure-services/ahs-discover.png)

If you connect to a server with Azure services already enabled, the Azure hybrid services tool serves as a single pane of glass to see all enabled services on that server. You can easily get to the relevant tool within Windows Admin Center, launch out to the Azure portal for deeper management of those Azure services, or read more with documentation at your fingertips. 

![Screenshot of Windows Admin Center showing Azure services that are already installed on the server](../media/azure-services/ahs-dayN.png)

From the Azure hybrid services tool, you can:
- Backup your Windows Server from Windows Admin Center with [Azure Backup](azure-backup.md)
- Protect your Hyper-V Virtual Machines from Windows Admin Center with [Azure Site Recovery](azure-site-recovery.md)
- Sync your file server with the cloud, using [Azure File Sync](azure-file-sync.md)
- Manage operating system updates for all your Windows servers, both on-premises or in the cloud, with [Azure Update Management](azure-update-management.md)
- Monitor servers, both on-premises or in the cloud, and configure alerts with [Azure Monitor](azure-monitor.md)
- Connect your on-premises servers to an Azure Virtual Network with [Azure Network Adapter](https://aka.ms/WACNetworkAdapter)

## Services for stand-alone servers and VMs

This is the complete list of Azure services that provide functionality to stand-alone servers and VMs:

- **(New) Sync your file server with the cloud by using [Azure File Sync](https://aka.ms/afs)**  
Sync files on this server with Azure file shares. Keep all your files local or use cloud tiering and cache only the most frequently used files on the server, tiering cold data to the cloud. Data in the cloud can be backed up, eliminating the need to worry about on-premises server backup. Additionally, multi-site-sync can keep a set of files in sync across multiple servers.

- **Add an layer of security to Windows Admin Center by adding [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory/) authentication**  
You can add an additional layer of security to Windows Admin Center by requiring users to authenticate using Azure Active Directory (Azure AD) identities to access the gateway. Azure AD authentication also lets you take advantage of Azure AD’s security features like conditional access and multi-factor authentication.  
For more info, see [Configure Azure AD authentication for Windows Admin Center.](../configure/user-access-control.md#azure-active-directory)  

- **Protect your Hyper-V virtual machines with [Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview)**  
You can replicate workloads running on VMs so that your business-critical infrastructure is protected in case of a disaster. Windows Admin Center streamlines setup and the process of replicating your virtual machines on your Hyper-V servers or clusters, making it easier to bolster the resiliency of your environment with Azure Site Recovery’s disaster recovery service.  
For more info, see [Protect your VMs with Azure Site Recovery and Windows Admin Center](azure-site-recovery.md).

- **Back up your Windows servers with [Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview)**  
You can back up your Windows servers to Azure, helping to protect you from accidental or malicious deletions, corruption, and ransomware.  
For more info, see [Back up your servers with Azure Backup](azure-backup.md).

- **Monitor and get email alerts for all the servers in your environment with [Azure Monitor for Virtual Machines](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-overview)**  
You can use Azure Monitor, also known as Virtual Machines Insights, to monitor server health and events, create email alerts, get a consolidated view of server performance across your environment, and visualize apps, systems, and services connected to a given server.  
For more info, see [Connect your servers to Azure Monitor and configure email notifications](azure-monitor.md).

- **Centrally manage operating system updates for all your Windows Servers with [Azure Update Management](https://docs.microsoft.com/azure/automation/automation-update-management)**  
You can manage updates and patches for multiple servers and VMs from a single place, rather than on a per-server basis. With Azure Update Management, you can quickly assess the status of available updates, schedule installation of required updates, and review deployment results to verify updates that apply successfully. This is possible whether your servers are Azure VMs, hosted by other cloud providers, or on-premises.  
For more info, see [Configure servers for Azure Update Management](azure-update-management.md).

- **Connect your on-premises servers to an Azure Virtual Network with an [Azure Network Adapter](https://aka.ms/WACNetworkAdapter)**  
You can add an Azure Network Adapter to your on-premises servers to help you securely connect the server to an Azure Virtual Network.  
For more info, see [Configure a point-to-site VPN connection between an on-premises Windows Server and an Azure Virtual Network](https://aka.ms/WACNetworkAdapter).

- **Manage Azure IaaS virtual machines with [Windows Admin Center](manage-azure-vms.md)**  
You can use Windows Admin Center to manage your Azure VMs as well as on-premises machines. By configuring your Windows Admin Center gateway to connect to your Azure VNet, you can manage virtual machines in Azure using the consistent, simplified tools that Windows Admin Center provides. For more info, see [Configure Windows Admin Center to manage VMs in Azure](manage-azure-vms.md).

## Services for clusters

These are the Azure services that provide functionality to clusters as a whole (these aren't all integrated into Windows Admin Center yet):

- [Monitor a hyper-converged cluster with Azure Monitor](../../../storage/storage-spaces/configure-azure-monitor.md)
- [Protect your VMs with Azure Site Recovery](azure-site-recovery.md)
- [Deploy a cluster cloud witness](../../../failover-clustering/deploy-cloud-witness.md)

## See also

- [Connect Windows Admin Center to Azure](azure-integration.md)
- [Deploy Windows Admin Center in Azure](deploy-wac-in-azure.md)
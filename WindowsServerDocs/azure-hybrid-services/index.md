---
title: Connecting Windows Server to Azure hybrid services
description: 
ms.technology: manage
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.localizationpriority: medium
ms.prod: windows-server-threshold
ms.date: 03/26/2019
---

# Connecting Windows Server to Azure hybrid services

>Applies to: Windows Server 2019, Windows Server 2016

You can extend on-premises deployments of Windows Server to the cloud by using Azure hybrid services. These cloud services provide an array of useful functions, including the following:

- Protect virtual machines and use cloud-based backup and disaster recovery (HA/DR) with Azure Site Recovery. 
- Track what’s happening across your applications, network and infrastructure with the help of advanced analytics and machine learning in Azure Monitor. 
- Simplify network connectivity to Azure with Azure Network Adapter.
- Keep virtual machines up to date with Azure Update Management.

Azure hybrid services work with Windows Servers in the following configurations:

- Stand-alone physical servers and virtual machines (VMs)
- Clusters, including hyper-converged clusters, [Azure Stack HCI](../azure-stack-hci), and [Windows Server Software-Defined (WSSD)](https://www.microsoft.com/en-us/cloud-platform/software-defined-datacenter)

While you can set up most Azure hybrid services using the Azure portal and a download or two, many are integrated directly into Windows Admin Center to provide a simplified setup experience and a server-centric view of the services.

## Services for stand-alone servers and VMs

These are the Azure services that provide functionality to stand-alone servers and VMs:

- Add an layer of security to Windows Admin Center by adding [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory/) authentication  
You can add an additional layer of security to Windows Admin Center by requiring users to authenticate using Azure Active Directory (Azure AD) identities to access the gateway. Azure AD authentication also lets you take advantage of Azure AD’s security features like conditional access and multi-factor authentication.  
For more info, see [Configure Azure AD authentication for Windows Admin Center.](../configure/user-access-control.md#azure-active-directory)  

- Protect your Hyper-V virtual machines with [Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview)  
You can replicate workloads running on VMs so that your business-critical infrastructure is protected in case of a disaster. Windows Admin Center streamlines setup and the process of replicating your virtual machines on your Hyper-V servers or clusters, making it easy to bolster the resiliency of your environment with Azure Site Recovery’s disaster recovery service.  
For more info, see [Protect your VMs with Azure Site Recovery and Windows Admin Center](../use/azure-site-recovery.md).

- Back up your Windows servers with [Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview)  
You can back up your Windows servers to Azure, protecting you from accidental or malicious deletions, corruption and even ransomware.  
For more info, see [Back up your servers with Azure Backup](../use/azure-backup.md).

- Monitor and get email alerts for all the servers in your environment with [Azure Monitor for Virtual Machines](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-overview)  
You can use Azure Monitor, also known as Virtual Machines insights, to monitor server health and events, create email alerts, get a consolidated view of server performance across your environment, and visualize apps, systems, and services connected to a given server.  
For more info, see [Connect your servers to Azure Monitor and configure email notifications](../use/azure-monitor.md).

- Centrally manage operating system updates for all your Windows Servers with [Azure Update Management](https://docs.microsoft.com/azure/automation/automation-update-management)  
You can manage updates and patches for multiple servers and VMs from a single place, rather than on a per-server basis. With Azure Update Management, you can quickly assess the status of available updates, schedule installation of required updates, and review deployment results to verify updates that apply successfully. This is possible whether your servers are Azure VMs, hosted by other cloud providers, or on premises.  
For more info, see [Configure servers for Azure Update Management](../use/azure-update-management.md).

- Connect your on-premises servers to an Azure Virtual Network with an [Azure Network Adapter](https://aka.ms/WACNetworkAdapter)  
You can add an Azure Network Adapter to your on-premises servers to help you securely connect the server to an Azure Virtual Network.  
For more info, see [Configure a point-to-site VPN connection between an on-premises Windows Server and an Azure Virtual Network](https://aka.ms/WACNetworkAdapter).

- [Manage Azure IaaS virtual machines in Windows Admin Center](../configure/manage-azure-vms.md)  
You can use Windows Admin Center to manage your Azure VMs as well as on-premises machines. By configuring your Windows Admin Center gateway to connect to your Azure VNet, you can manage virtual machines in Azure using the consistent, simplified tools that Windows Admin Center provides. For more info, see [Configure Windows Admin Center to manage VMs in Azure.](../configure/manage-azure-vms.md).

## Services for clusters

These are the Azure services that provide functionality to clusters as a whole:

- [Monitor a hyper-converged cluster with Azure Monitor](../storage/storage-spaces/configure-azure-monitor.md)
- [Protect your VMs with Azure Site Recovery](../manage/windows-admin-center/use/azure-site-recovery.md)
- [Deploy a cluster cloud witness](../failover-clustering/deploy-cloud-witness.md)


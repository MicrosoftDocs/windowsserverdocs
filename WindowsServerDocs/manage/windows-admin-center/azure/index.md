---
title: Connecting Windows Server to Azure hybrid services
description: You can extend on-premises deployments of Windows Server to the cloud by using Azure hybrid services.
ms.technology: manage
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.localizationpriority: medium
ms.prod: windows-server
ms.date: 05/31/2019
---
# Connecting Windows Server to Azure hybrid services

You can extend on-premises deployments of Windows Server to the cloud by using Azure hybrid services. These cloud services provide an array of useful functions, both for extending on-premises into Azure, and for centrally managing from Azure.

![Diagram showing arrow from on-premises to cloud for extending on-premises into Azure, and arrow from cloud to on-premises for managing centrally with Azure](../media/azure-services/hybrid-framing.png)

Using Azure hybrid services within Windows Admin Center, you can:

- [Protect virtual machines and use cloud-based backup and disaster recovery (HA/DR)](#back-up-and-protect-your-on-premises-servers-and-vms).  
- [Extend on-premises capacity with storage and compute in Azure, and simplify network connectivity to Azure](#extend-on-premises-capacity-with-azure).
- [Centralize monitoring, governance, configuration, and security across your applications, network, and infrastructure with the help of cloud-intelligent Azure management services](#centrally-manage-your-hybrid-environment-from-azure).  

While you can set up most Azure hybrid services by downloading an app and doing some manual configuration, many are integrated directly into Windows Admin Center to provide a simplified setup experience and a server-centric view of the services. Windows Admin Center also provides convenient intelligent hyperlinks to the Azure portal to see connected Azure resources as well as a centralized view of your hybrid environment.

## Discover integrated services in the Azure hybrid services tool

The Azure hybrid services tool in [Windows Admin Center](../overview.md) consolidates all the integrated Azure services into a centralized hub where you can easily discover all the available Azure services that bring value to your on-premises or hybrid environment.  

![Screenshot of Windows Admin Center showing the Azure Hybrid Services tool](../media/azure-services/ahs-discover.png)

If you connect to a server with Azure services already enabled, the Azure hybrid services tool serves as a single pane of glass to see all enabled services on that server. You can easily get to the relevant tool within Windows Admin Center, launch out to the Azure portal for deeper management of those Azure services, or read more with documentation at your fingertips.  

![Screenshot of Windows Admin Center showing Azure services that are already installed on the server](../media/azure-services/ahs-dayN.png)

From the Azure hybrid services tool, you can:

- Backup your Windows Server from Windows Admin Center with [Azure Backup](azure-backup.md)
- Protect your Hyper-V Virtual Machines from Windows Admin Center with [Azure Site Recovery](azure-site-recovery.md)
- Sync your file server with the cloud, using [Azure File Sync](azure-file-sync.md)
- Manage operating system updates for all your Windows servers, both on-premises or in the cloud, with [Azure Update Management](azure-update-management.md)
- Monitor servers, both on-premises or in the cloud, and configure alerts with [Azure Monitor](azure-monitor.md)
- Apply governance policies to your on-premises servers through Azure Policy using [Azure Arc for servers](https://docs.microsoft.com/azure/azure-arc/servers/overview)
- Secure your servers and get advanced threat protection with [Azure Security Center](https://docs.microsoft.com/azure/security-center/windows-admin-center-integration)
- Connect your on-premises servers to an Azure Virtual Network with [Azure Network Adapter](https://aka.ms/WACNetworkAdapter)
- Make Azure VMs look like your on-premises network with [Azure Extended Network](https://go.microsoft.com/fwlink/?linkid=2109517&clcid=0x409)

## Back up and protect your on-premises servers and VMs

- **Back up your Windows servers with [Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview)**  
You can back up your Windows servers to Azure, helping to protect you from accidental or malicious deletions, corruption, and ransomware.  
For more info, see [Back up your servers with Azure Backup](azure-backup.md).

- **Protect your Hyper-V virtual machines with [Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview)**  
You can replicate workloads running on VMs so that your business-critical infrastructure is protected in case of a disaster. Windows Admin Center streamlines setup and the process of replicating your virtual machines on your Hyper-V servers or clusters, making it easier to bolster the resiliency of your environment with Azure Site Recovery's disaster recovery service.  
For more info, see [Protect your VMs with Azure Site Recovery and Windows Admin Center](azure-site-recovery.md).

- **Use synchronous or asynchronous block-based replication to a VM in Azure using [Storage Replica](https://docs.microsoft.com/windows-server/storage/storage-replica/storage-replica-overview)**  
You can configure block-based or volume-based replication on a server-to-server level using Storage Replica to a secondary server or VM. Windows Admin Center allows you to create an Azure VM specifically for your replication target, helping you to right-size and correctly configure storage on a new Azure VM.  
For more info, see [Server-to-server replication with Storage Replica](https://docs.microsoft.com/windows-server/storage/storage-replica/storage-replica-ui).  

## Extend on-premises capacity with Azure

### Extend storage capacity

- **Sync your file server with the cloud by using [Azure File Sync](https://aka.ms/afs)**  
Sync files on this server with Azure file shares. Keep all your files local or use cloud tiering to free up space and cache only the most frequently used files on the server, tiering cold data to the cloud. Data in the cloud can be backed up, eliminating the need to worry about on-premises server backup. Additionally, multi-site-sync can keep a set of files in sync across multiple servers.
For more info, see [Sync your file server with the cloud by using Azure File Sync](azure-file-sync.md).

- **Migrate storage to a VM in Azure using [Storage Migration Service](https://docs.microsoft.com/windows-server/storage/storage-migration-service/overview)**  
Use the step-by-step tool to inventory data on Windows and Linux servers and then transfer the data to a new Azure VM. Windows Admin Center can create a new Azure VM for the job that is right-sized and correctly configured to receive the data from your source server.  
For more info, see [Use Storage Migration Service to migrate a server](https://docs.microsoft.com/windows-server/storage/storage-migration-service/migrate-data).

### Extend compute capacity

- **Create a new Azure virtual machine without leaving Windows Admin Center**  
From the *All Connections* page within Windows Admin Center, go to **Add** and select **Create new** under **Azure VM**. You can even domain-join your Azure VM and configure storage from within this step-by-step creation tool.

- **Leverage Azure to achieve quorum on your failover cluster with [Cloud Witness](https://docs.microsoft.com/windows-server/failover-clustering/deploy-cloud-witness)**  
Instead of investing in additional hardware to achieve quorum on a 2-node cluster, you can use an Azure storage account to serve as the cluster witness for your Azure Stack HCI cluster or other failover cluster.  
For more info, see [Deploy a Cloud Witness for a Failover Cluster](https://docs.microsoft.com/windows-server/failover-clustering/deploy-cloud-witness).  

### Simplify network connectivity between your on-premises and Azure networks

- **Connect your on-premises servers to an Azure Virtual Network with [Azure Network Adapter](https://aka.ms/WACNetworkAdapter)**  
Let Windows Admin Center simplify setting up a point-to-site VPN from an on-premises server into an Azure virtual network.  

- **Make Azure VMs look like your on-premises network with [Azure Extended Network](https://go.microsoft.com/fwlink/?linkid=2109517&clcid=0x409)**  
Windows Admin Center can set up a site-to-site VPN and extend your on-premises IP addresses into your Azure vNet to let you more easily migrate workloads into Azure without breaking dependencies on IP addresses.

## Centrally manage your hybrid environment from Azure

- **Monitor and get email alerts for all the servers in your environment with [Azure Monitor for Virtual Machines](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-overview)**  
You can use Azure Monitor, also known as Virtual Machines Insights, to monitor server health and events, create email alerts, get a consolidated view of server performance across your environment, and visualize apps, systems, and services connected to a given server. Windows Admin Center can also set up default email alerts for server health performance and cluster health events.  
For more info, see [Connect your servers to Azure Monitor and configure email notifications](azure-monitor.md).

- **Centrally manage operating system updates for all your Windows Servers with [Azure Update Management](https://docs.microsoft.com/azure/automation/automation-update-management)**  
You can manage updates and patches for multiple servers and VMs from a single place, rather than on a per-server basis. With Azure Update Management, you can quickly assess the status of available updates, schedule installation of required updates, and review deployment results to verify updates that apply successfully. This is possible whether your servers are Azure VMs, hosted by other cloud providers, or on-premises.  
For more info, see [Configure servers for Azure Update Management](azure-update-management.md).

- **Improve your security posture and get advanced threat protection with [Azure Security Center](https://docs.microsoft.com/azure/security-center/security-center-intro)**  
Azure Security Center is a unified infrastructure security management system that strengthens the security posture of your data centers, and provides advanced threat protection across your hybrid workloads in the cloud - whether they're in Azure or not - as well as on premises. With Windows Admin Center, you can easily set up and connect your servers to Azure Security Center.  
For more info, see [Integrate Azure Security Center with Windows Admin Center (Preview)](https://docs.microsoft.com/azure/security-center/windows-admin-center-integration).  

- **Apply policies and ensure compliance across your hybrid environment with [Azure Arc for servers](https://docs.microsoft.com/azure/azure-arc/servers/overview) and [Azure Policy](https://docs.microsoft.com/azure/governance/policy/overview)**  
Inventory, organize, and manage on-premises servers from Azure. You can govern servers using Azure policy, control access using RBAC, and enable additional management services from Azure.  

## Clusters versus stand-alone servers and VMs

Azure hybrid services work with Windows Servers in the following configurations:

- Stand-alone physical servers and virtual machines (VMs)
- Clusters, including hyper-converged clusters certified by the [Azure Stack HCI](../../../azure-stack-hci/index.md), and [Windows Server Software-Defined (WSSD)](https://www.microsoft.com/cloud-platform/software-defined-datacenter) programs

### Services for stand-alone servers and VMs

This is the complete list of Azure services that provide functionality to stand-alone servers and VMs:

- Backup your Windows Server from Windows Admin Center with [Azure Backup](azure-backup.md)
- Protect your Hyper-V Virtual Machines from Windows Admin Center with [Azure Site Recovery](azure-site-recovery.md)
- Sync your file server with the cloud, using [Azure File Sync](azure-file-sync.md)
- Manage operating system updates for all your Windows servers, both on-premises or in the cloud, with [Azure Update Management](azure-update-management.md)
- Monitor servers, both on-premises or in the cloud, and configure alerts with [Azure Monitor](azure-monitor.md)
- Apply governance policies to your on-premises servers through Azure Policy using [Azure Arc for servers](https://docs.microsoft.com/azure/azure-arc/servers/overview)
- Secure your servers and get advanced threat protection with [Azure Security Center](https://docs.microsoft.com/azure/security-center/windows-admin-center-integration)
- Connect your on-premises servers to an Azure Virtual Network with [Azure Network Adapter](https://aka.ms/WACNetworkAdapter)
- Make Azure VMs look like your on-premises network with [Azure Extended Network](https://go.microsoft.com/fwlink/?linkid=2109517&clcid=0x409)

### Services for clusters

These are the Azure services that provide functionality to clusters as a whole:

- [Monitor a hyper-converged cluster with Azure Monitor](../../../storage/storage-spaces/configure-azure-monitor.md)
- [Protect your VMs with Azure Site Recovery](azure-site-recovery.md)
- [Deploy a cluster cloud witness](../../../failover-clustering/deploy-cloud-witness.md)  

## Other Azure-integrated abilities of Windows Admin Center

- **[Add Azure VM connections](manage-azure-vms.md) in Windows Admin Center**  
You can use Windows Admin Center to manage your Azure VMs as well as on-premises machines. By configuring your Windows Admin Center gateway to connect to your Azure VNet, you can manage virtual machines in Azure using the consistent, simplified tools that Windows Admin Center provides.  
For more info, see [Configure Windows Admin Center to manage VMs in Azure](manage-azure-vms.md).

- **Add an layer of security to Windows Admin Center by adding [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory/) authentication**  
You can add an additional layer of security to Windows Admin Center by requiring users to authenticate using Azure Active Directory (Azure AD) identities to access the gateway. Azure AD authentication also lets you take advantage of Azure AD’s security features like conditional access and multi-factor authentication.  
For more info, see [Configure Azure AD authentication for Windows Admin Center](../configure/user-access-control.md#azure-active-directory).  

- **Manage Azure resources directly through [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview) embedded in Windows Admin Center**  
Leverage Azure Cloud Shell to get a Bash or PowerShell experience within Windows Admin Center to give you easy access to Azure management tasks.  
For more info, see [Overview of Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview).


## See also

- [Connect Windows Admin Center to Azure](azure-integration.md)
- [Deploy Windows Admin Center in Azure](deploy-wac-in-azure.md)

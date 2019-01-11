---
title: Cross Domain Cluster Migration in Windows Server 2019
ms.prod: windows-server-threshold
ms.manager: eldenc
ms.technology: failover-clustering
ms.topic: article
author: johnmarlin-msft
ms.date: 01/11/2019
description: This article describes moving a Windows Server 2019 Cluster from one domain to another
ms.localizationpriority: medium
---

# Failover Cluster Domain Migration

> Applies To: Windows Server 2019

This topic provides an overview for moving Windows Server 2019 failover clusters from one domain to another.

## Overview

In previous versions of Failover Clustering, the Cluster Service did not have the capability of moving from one domain to another.  This was due to the increased dependence on Active Directory Domain Services and the virtual names created.   

## Options

In order to do such a move, there are two options.

The first option is destructive as it involves destroying the cluster and rebuilding it in the new domain.

![Destroy and Rebuild](media\Cross-Domain-Cluster-Migration\Cross-Cluster-Domain-Migration-1.gif)

The second option is less destructive but requires additional hardware as a new cluster would need to be built in the new domain.

![Build and Migrate](media\Cross-Domain-Cluster-Migration\Cross-Cluster-Domain-Migration-2.gif)

In both options, the new cluster would need to have all [cluster-aware applications](https://technet.microsoft.com/aa369082(v=vs.90)) installed, drivers all up-to-date, and possibly testing to ensure all will run properly.  This was also a very time consuming process if data also needed to be moved.

With this being the case, there are several scenarios where the above is necessary.

- CompanyA merges with CompanyB and must move all clusters into CompanyA domain
- Clusters are built in the main datacenter and shipped out to remote locations
- Cluster was built as a workgroup cluster and now needs to be part of a domain
- Cluster was built as a domain cluster and now needs to be part of a workgroup
- Cluster is being moved to one area of the company to another and is a different subdomain

Microsoft does not provide support to administrators who try to move resources from one domain to another if the underlying application operation is unsupported. For example, Microsoft does not provide support to administrators who try to move a Microsoft Exchange server from one domain to another.

Warning:  We recommend that you perform a full backup of all data on all shared hard disks on each node in the cluster before you move the cluster.


## New Feature

In Windows Server 2019, we introduced cross cluster domain migration capabilities.  So now, the scenarios listed above can easily be done and the need of rebuilding is no longer needed.  

Moving a cluster from one domain is a straight-forward process. To accomplish this, there are two new PowerShell commandlets.

    **New-ClusterNameAccount** – creates a Cluster Name Account in Active Directory
    **Remove-ClusterNameAccount** – removes the Cluster Name Accounts from Active Directory

The process to accomplish this is to change the cluster from one domain to a workgroup and back to the new domain.  The need to destroy a cluster, rebuild a cluster, install applications, etc is not a requirement. For example, it would look like this:

![Migrate](media\Cross-Domain-Cluster-Migration\Cross-Cluster-Domain-Migration-3.gif)

## Steps for Migrating

In the following steps, a cluster is being moved from the Contoso.com domain to the new Fabrikam.com domain.  The Cluster Name is CLUSCLUS and with a file server role called FS-CLUSCLUS.

Step 1:
Create a local Administrator account with the same name and password on all nodes.  This will be needed to log in while the nodes are in a workgroup.

Step 2:
Log on to the first node with a domain user or administrator account that has Active Directory permissions to the Cluster Name Object (CNO), Virtual Computer Objects (VCO), has access to the Cluster, and open PowerShell.

Step 3:
Ensure all Cluster Network Name resources are in an Offline state and run the below command to change the type of the Cluster to a workgroup.

    Remove-ClusterNameAccount -Cluster CLUSCLUS -DeleteComputerObjects

Step 4:
Use Active Directory Users and Computers to ensure the CNO and VCO computer objects associated with all cluster names have been removed.

Step 5:
If so, it is a good idea to go ahead and stop the Cluster Service on both nodes and set the service to MANUAL so that it does not start during this next process.

    Stop-Service -Name ClusSvc

    Set-Service -Name ClusSvc -StartupType Manual

Step 6:
Change the nodes domain membership to a workgroup, reboot, join the nodes to the new domain, and reboot again.

Step 7:
Once the nodes are in the new domain, log on to a node with a domain user or administrator account that has Active Directory permissions to create objects, has access to the Cluster, and open PowerShell. start the Cluster Service, and set it back to Automatic.

    Start-Service -Name ClusSvc

    Set-Service -Name ClusSvc -StartupType Automatic

Step 8:
Bring the Cluster Name and all other cluster Network Name resources to an Online state.

    Start-ClusterResource -Name "Cluster Name"

    Start-ClusterResource -Name FS-CLUSCLUS

Step 9:
Change the cluster to be a part of the new domain with associated active directory objects. To do this, the command is below. The network name resources must be in an online state.

    New-ClusterNameAccount -Name CLUSTERNAME -Domain NEWDOMAINNAME.com -UpgradeVCOs

    NOTE: If you do not have any additional groups with network names (i.e. a Hyper-V Cluster with only virtual machines), the -UpgradeVCOs parameter switch is not needed.

Use Active Directory Users and Computers to check the new domain and ensure the associated computer objects were created. If they have, then bring the remaining resources in the groups online.

    Start-ClusterGroup -Name "Cluster Group"

    Start-ClusterGroup -Name FS-CLUSCLUS

## Known Error

If you are using the new USB Witness feature, you will be unable to add the cluster to the new domain.  The reasoning is that the file share witness type must utilize Kerberos for authentication.  Change the witness to none before adding the cluster to the domain.  Once it is completed, recreate the USB witness.  The error you will see is:

    New-ClusternameAccount : Cluster name account cannot be created.  This cluster contains a file share witness with invalid permissions for a cluster of type AdministrativeAccesssPoint ActiveDirectoryAndDns. To proceed, delete the file share witness.  After this you can create the cluster name account and recreate the file share witness.  The new file share witness will be automatically created with valid permissions.

---
title: Cross Domain Cluster Migration in Windows Server 2016/2019
description: This article describes moving a Windows Server 2019 cluster from one domain to another
ms.topic: article
ms.author: wscontent
author: robinharwood
ms.date: 11/02/2023
---
# Failover Cluster domain migration

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This article provides an overview for moving Windows Server failover clusters from one domain to another.

## Why migrate between domains

There are several scenarios where migrating a cluster from one domain to another is necessary.

- Company A merges with Company B and must move all clusters into Company A domain
- Clusters are built in the main datacenter and shipped out to remote locations
- Cluster was built as a workgroup cluster and now needs to be part of a domain
- Cluster was built as a domain cluster and now needs to be part of a workgroup
- Cluster is being moved to one area of the company to another and is a different subdomain

Microsoft doesn't provide support to administrators who try to move resources from one domain to another if the underlying application operation is unsupported. For example, Microsoft doesn't provide support to administrators who try to move a Microsoft Exchange server from one domain to another.

   > [!WARNING]
   > We recommend that you perform a full backup of all shared storage in the cluster before you move the cluster.

## Windows Server 2016 and earlier

In Windows Server 2016 and earlier, the Cluster service didn't have the capability of moving from one domain to another. This was due to the increased dependence on Active Directory Domain Services and the virtual names created.

## Options

In order to do such a move, there are two options.

The first option involves destroying the cluster and rebuilding it in the new domain.

![An animation of the steps to destroy a cluster, move nodes to a new domain, and recreate the cluster in a new domain.](media/Cross-Domain-Cluster-Migration/Cross-Cluster-Domain-Migration-1.gif)

As the animation shows, this option is destructive with the steps being:

1. Destroy the Cluster.
2. Change the domain membership of the nodes into the new domain.
3. Recreate the Cluster as new in the updated domain. This would entail having to recreate all the resources.

The second option is less destructive but requires additional hardware as a new cluster would need to be built in the new domain. Once the cluster is in the new domain, run the **Cluster Migration Wizard** to migrate the resources. The Cluster Migration Wizard doesn't migrate data, another tool is required, such as [Storage Migration Service](../storage/storage-migration-service/overview.md) once cluster support is added.

![An animation of the steps to create a new cluster in a new domain using the Cluster Migration Wizard, including decommissioning the old cluster.](media/Cross-Domain-Cluster-Migration/Cross-Cluster-Domain-Migration-2.gif)

As the animation shows, this option isn't destructive but does require either different hardware or a node from the existing cluster that has been removed.

1. Create a new cluster in the new domain while still having the old cluster available.
2. Use the [Cluster Migration Wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754481(v=ws.10)) to migrate all the resources to the new cluster. Reminder, the Cluster Migration Wizard doesn't copy data, which needs to be done separately.
3. Decommission or destroy the old cluster.

In both options, the new cluster would need to have all [cluster-aware applications](/previous-versions/windows/desktop/mscs/cluster-aware-applications) installed, drivers updated, and testing to ensure functionality. If data also needs to be moved, this increases the time it takes to complete this process.

## Windows Server 2019

In Windows Server 2019, we introduced cross cluster domain migration capabilities. The scenarios, as previously mentioned, can easily be performed as the need of rebuilding is no longer needed.

Moving a cluster from one domain is a straight-forward process that can be accomplished using two PowerShell cmdlets:

- `New-ClusterNameAccount` – creates a Cluster Name Account in Active Directory
- `Remove-ClusterNameAccount` – removes the Cluster Name Accounts from Active Directory

   > [!NOTE]
   > The cmdlet `Remove-ClusterNameAccount` might not run successfully. If you encounter an issue, follow the steps for [Windows Server 2016 and earlier](#windows-server-2016-and-earlier). Microsoft is aware of the problem.

The process is to change the cluster from one domain to a workgroup and back to the new domain. The need to destroy a cluster, rebuild a cluster, or install applications isn't a requirement. For example:

![An animation demonstrating how a cluster is migrated from the previous domain to a new domain.](media/Cross-Domain-Cluster-Migration/Cross-Cluster-Domain-Migration-3.gif)

## Migrating a cluster to a new domain

In the following steps, a cluster is being moved from the Contoso.com domain to the new Fabrikam.com domain. The cluster name is *CLUSCLUS* and with a file server role called *FS-CLUSCLUS*.

1. Create a local Administrator account with the same name and password on all servers in the cluster. This might be needed to log in while the servers are moving between domains.
2. Sign in to the first server with a domain user or administrator account that has Active Directory permissions to the Cluster Name Object (CNO), Virtual Computer Objects (VCO), has access to the Cluster, and open PowerShell.
3. Ensure all Cluster Network Name resources are in an offline state and run the following command to remove the Active Directory objects that the cluster might have.

   ```powershell
   Remove-ClusterNameAccount -Cluster CLUSCLUS -DeleteComputerObjects
   ```

4. Use **Active Directory Users and Computers** to ensure the CNO and VCO computer objects associated with all clustered names have been removed.

   > [!NOTE]
   > Stop the Cluster service on all servers in the cluster and set the service startup type to Manual so that the Cluster service doesn't start when the servers are restarting while changing domains.

   ```powershell
   Stop-Service -Name ClusSvc

   Set-Service -Name ClusSvc -StartupType Manual
   ```

5. Change the servers' domain membership to a workgroup, restart the servers, join the servers to the new domain, and restart again.
6. Once the servers are in the new domain, sign in to a server with a domain user or administrator account that has Active Directory permissions to create objects, has access to the cluster, and open PowerShell. Start the Cluster Service, and set it back to Automatic.

   ```powershell
   Start-Service -Name ClusSvc

   Set-Service -Name ClusSvc -StartupType Automatic
   ```

7. Bring the Cluster Name and all other cluster Network Name resources to an online state.

   ```powershell
   Start-ClusterResource -Name "Cluster Name"

   Start-ClusterResource -Name FS-CLUSCLUS
   ```

8. Change the cluster to be a part of the new domain with associated active directory objects. The following command recreates the name objects in Active Directory and the network name resources must be in an online state:

   ```powershell
   New-ClusterNameAccount -Name ClusterName -Domain NewDomainName.com -UpgradeVCOs
   ```

    >[!NOTE]
    >If you don't have any additional groups with network names, such as a Hyper-V Cluster with only virtual machines, the `-UpgradeVCOs` parameter isn't needed.

9. Use **Active Directory Users and Computers** to check the new domain and ensure the associated computer objects were created. If they have, then bring the remaining resources in the groups online.

   ```powershell
   Start-ClusterGroup -Name "Cluster Group"

   Start-ClusterGroup -Name FS-CLUSCLUS
   ```

## Known issues

If you're using the new USB witness feature, you'll be unable to add the cluster to the new domain due to the file share witness type that must utilize Kerberos for authentication. Change the witness to **none** before adding the cluster to the domain. Once this step is complete, recreate the USB witness. The error you'll see is:

```
New-ClusternameAccount : Cluster name account cannot be created. This cluster contains a file share witness with invalid permissions for a cluster of type AdministrativeAccesssPoint ActiveDirectoryAndDns. To proceed, delete the file share witness. After this you can create the cluster name account and recreate the file share witness. The new file share witness will be automatically created with valid permissions.
```

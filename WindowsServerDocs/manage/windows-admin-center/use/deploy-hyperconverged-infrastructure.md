---
title: Deploy Hyperconverged Infrastructure with Windows Admin Center
description: Learn how to deploy a hyperconverged infrastructure by using Windows Admin Center.
ms.topic: install-set-up-deploy
author: davannaw-msft
ms.author: dawhite
ms.date: 11/04/2019
---

# Deploy a hyperconverged infrastructure by using Windows Admin Center

You can use Windows Admin Center [version 1910](../overview.md) or later to deploy a hyperconverged infrastructure by using two or more suitable Windows servers. This feature takes the form of a multistage workflow that guides you through installing features, configuring networking, creating the cluster, and deploying Storage Spaces Direct and/or software-defined networking (SDN).

As of Windows Admin Center version 2007, Windows Admin Center supports the Azure Stack HCI operating system. To read about how to deploy a cluster in Windows Admin Center, see the [Azure Local documentation](/azure/azure-local/deploy/create-cluster). Although that documentation is focused on Azure Local, most of the instructions are applicable to Windows Server deployments.

## Undo and start over

Use the following Windows PowerShell cmdlets to undo changes that the workflow made and start over.

### Remove virtual machines or other clustered resources

If you created any virtual machines or other clustered resources, such as the network controllers for SDN, remove them first.

For example, to remove resources by name, use this cmdlet:

```PowerShell
Get-ClusterResource -Name "<NAME>" | Remove-ClusterResource
```

### Undo the storage steps

If you enabled Storage Spaces Direct, disable it by using the following script.

> [!WARNING]
> These cmdlets permanently delete any data in Storage Spaces Direct volumes. You can't undo this action.

```PowerShell
Get-VirtualDisk | Remove-VirtualDisk
Get-StoragePool -IsPrimordial $False | Remove-StoragePool
Disable-ClusterS2D
```

### Undo the clustering steps

If you created a cluster, remove it by using this cmdlet:

```PowerShell
Remove-Cluster -CleanUpAD
```

To also remove cluster validation reports, run this cmdlet on every server that was part of the cluster:

```PowerShell
Get-ChildItem C:\Windows\cluster\Reports\ | Remove-Item
```

### Undo the networking steps

Run the following cmdlets on every server that was part of the cluster.

If you created a Hyper-V virtual switch, use this cmdlet:

```PowerShell
Get-VMSwitch | Remove-VMSwitch
```

The `Remove-VMSwitch` cmdlet automatically removes any virtual adapters and undoes switch-embedded teaming of physical adapters.

If you modified network adapter properties such as name, IPv4 address, and VLAN ID, use the following cmdlets.

> [!WARNING]
> These cmdlets remove network adapter names and IP addresses. Make sure that you have the information that you need to connect afterward, such as an adapter for management that's excluded from the script. Also make sure that you know how the servers are connected in terms of physical properties like MAC address, not just the adapter's name in Windows.

```PowerShell
Get-NetAdapter | Where Name -Ne "Management" | Rename-NetAdapter -NewName $(Get-Random)
Get-NetAdapter | Where Name -Ne "Management" | Get-NetIPAddress -ErrorAction SilentlyContinue | Where AddressFamily -Eq IPv4 | Remove-NetIPAddress
Get-NetAdapter | Where Name -Ne "Management" | Set-NetAdapter -VlanID 0
```

You're now ready to start the workflow.

## Related content

- [Windows Admin Center overview](../overview.md)
- [Deploy Storage Spaces Direct on Windows Server](../../../storage/storage-spaces/deploy-storage-spaces-direct.md)

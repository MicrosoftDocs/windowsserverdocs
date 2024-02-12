---
title: Deploy hyperconverged infrastructure with Windows Admin Center
description: Deploy hyperconverged infrastructure with Windows Admin Center.
ms.topic: article
author: cosmosdarwin
ms.author: cosdar
ms.date: 11/04/2019
---

# Deploy hyperconverged infrastructure with Windows Admin Center

>Applies to: Windows Admin Center, Windows Admin Center Preview

You can use Windows Admin Center [version 1910](../overview.md) or later to deploy hyperconverged infrastructure using two or more suitable Windows Servers. This new feature takes the form of a multi-stage workflow that guides you through installing features, configuring networking, creating the cluster, and deploying Storage Spaces Direct and/or software-defined networking (SDN) if selected.

As of Windows Admin Center version 2007, Windows Admin Center supports the Azure Stack HCI OS. Read about [how to deploy a cluster in Windows Admin Center in the Azure Stack HCI docs](/azure-stack/hci/get-started). Although this documentation is focused on Azure Stack HCI, the instructions are also mostly applicable to Windows Server deployments.

## Undo and start over

Use these Windows PowerShell cmdlets to undo changes made by the workflow and start over.

### Remove virtual machines or other clustered resources

If you created any virtual machines or other clustered resources, such as the network controllers for software-defined networking, remove them first.

For example, to remove resources by name, use:

```PowerShell
Get-ClusterResource -Name "<NAME>" | Remove-ClusterResource
```

### Undo the Storage steps

If you enabled Storage Spaces Direct, disable it with this script:

> [!Warning]
> These cmdlets permanently delete any data in Storage Spaces Direct volumes. This can't be undone.

```PowerShell
Get-VirtualDisk | Remove-VirtualDisk
Get-StoragePool -IsPrimordial $False | Remove-StoragePool
Disable-ClusterS2D
```

### Undo the Clustering steps

If you created a cluster, remove it with this cmdlet:

```PowerShell
Remove-Cluster -CleanUpAD
```

To also remove cluster validation reports, run this cmdlet on every server that was part of the cluster:

```PowerShell
Get-ChildItem C:\Windows\cluster\Reports\ | Remove-Item
```

### Undo the Networking steps

Run these cmdlets on every server that was part of the cluster.

If you created a Hyper-V virtual switch:

```PowerShell
Get-VMSwitch | Remove-VMSwitch
```

> [!Note]
> The `Remove-VMSwitch` cmdlet automatically removes any virtual adapters and undoes switch-embedded teaming of physical adapters.

If you modified network adapter properties such as name, IPv4 address, and VLAN ID:

> [!Warning]
> These cmdlets remove network adapter names and IP addresses. Make sure you have the information you need to connect afterward, such as an adapter for management that is excluded from the script below. Also make sure that you know how the servers are connected in terms of physical properties like MAC Address, not just the adapter's name in Windows.

```PowerShell
Get-NetAdapter | Where Name -Ne "Management" | Rename-NetAdapter -NewName $(Get-Random)
Get-NetAdapter | Where Name -Ne "Management" | Get-NetIPAddress -ErrorAction SilentlyContinue | Where AddressFamily -Eq IPv4 | Remove-NetIPAddress
Get-NetAdapter | Where Name -Ne "Management" | Set-NetAdapter -VlanID 0
```

You're now ready to start the workflow.

## Additional References

- [Hello, Windows Admin Center](../overview.md)
- [Deploy Storage Spaces Direct](../../../storage/storage-spaces/deploy-storage-spaces-direct.md)

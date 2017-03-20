---
ms.assetid: 87e94b70-3a85-4071-a6f5-3df0b12ae261
title: Managing Storage Spaces Direct
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: dongill
ms.technology: storage-spaces
ms.topic: article
author: jasongerend
ms.date: 2/6/2017
description: Resources to help you manage a Storage Spaces Direct deployment consisting of multiple servers clustered to provide software-defined storage using Windows Server.
---
# Managing Storage Spaces Direct

>Applies To: Windows Server 2016

<img src="media/Storage-Spaces-Direct-in-Windows-Server-2016/manage.png" style='float:left; padding:.3em;' width= 75; alt="Managing Storage Spaces Direct">

This topic provides resources that help you manage a [Storage Spaces Direct](storage-spaces-direct-overview.md) cluster. Storage Spaces Direct is a Windows Server-based storage solution that uses industry-standard servers with local-attached drives to create highly available, highly scalable software-defined storage.

When managing Storage Spaces Direct, you can use Windows PowerShell, System Center Virtual Machine Manager (VMM) and Operations Manager, and/or Failover Cluster Manager.

## Resources for managing Storage Spaces Direct

- [Adding servers or drives to Storage Spaces Direct](add-nodes.md)
- [Taking a Storage Spaces Direct server offline for maintenance](maintain-servers.md)
- [Removing servers](remove-servers.md)
- [Updating drive firmware in Windows Server 2016](..\update-firmware.md)
- [Extending volumes](resize-volumes.md)

## Tools for managing Storage Spaces Direct
After you've deployed your storage, some of the management tasks you'll perform include monitoring for failed physical disks or other issues, replacing disks that fail, and updating firmware and drivers.
See the following table for common management options.

|Tool|Advantages|Disadvantages|
|---|---|---|
|Windows PowerShell|- Complete control over all aspects of storage<br>- Can automate by writing scripts<br>- Powerful example scripts available|- Better for management than visually monitoring overall storage health.<br>- Scripts require development and testing|
|System Center Virtual Machine Manager (VMM) & Operations Manager|- Easy to use<br>- Graphical displays for monitoring multiple systems<br>- Alerting for common problems<br>- Common tool for managing VMs and storage<br>|- Some tasks require Windows PowerShell<br>- Requires System Center licenses<br>- Might require additional infrastructure if you don't already have System Center or are deploying at a scale that's greater than your existing deployment can handle|
|Failover Cluster Manager & Server Manager|- Easy to use<br>- Graphical displays for monitoring<br>|- Some tasks require Windows PowerShell<br>- Slow automatic refreshes in Server Manager when working with storage<br>- Performance and usability decreases with large numbers of objects|

For more info about using VMM with Storage Spaces Direct, see [Manage Storage Spaces Direct in VMM](https://technet.microsoft.com/system-center-docs/vmm/manage/manage-storage-spaces-direct-vmm), and [Manage storage in Storage Spaces Direct in the VMM fabric](https://technet.microsoft.com/system-center-docs/vmm/scenario/storage-spaces-manage).

## See also

- [Understanding Storage Spaces Direct](understand-storage-spaces-direct.md)
- [Planning Storage Spaces Direct](plan-storage-spaces-direct.md)
- [Deploying Storage Spaces Direct](deploy-storage-spaces-direct.md)

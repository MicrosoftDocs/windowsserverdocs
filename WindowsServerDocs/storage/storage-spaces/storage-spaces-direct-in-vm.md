---
title: Using Storage Spaces Direct in a virtual machine
description: How to deploy Storage Spaces Direct in a virtual machine guest cluster - for example, in Microsoft Azure.
ms.author: eldenc
manager: eldenc
ms.topic: article
author: eldenchristensen
ms.date: 10/20/2021
---

# Using Storage Spaces Direct in guest virtual machine clusters

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, versions 21H2 and 20H2

You can deploy Storage Spaces Direct on a cluster of physical servers or on virtual machine (VM) guest clusters as discussed in this topic. This type of deployment delivers virtual shared storage across a set of VMs on top of a private or public cloud. This allows you to use application high availability solutions.

To instead use Azure Shared Disks for guest virtual machines, see [Azure Shared Disks](/azure/virtual-machines/windows/disks-shared).

![Storage Spaces Direct diagram](media/storage-spaces-direct-in-vm/storage-spaces-direct-in-vm.png)

## Deploying in Azure Iaas VM guest clusters

[Azure templates](https://github.com/robotechredmond/301-storage-spaces-direct-md) have been published to decrease complexity, configure best practices, and speed your Storage Spaces Direct deployments in an Azure Iaas VM. This is the recommended solution for deploying in Azure.

## Requirements for guest clusters

The following considerations apply when deploying Storage Spaces Direct in a virtualized environment.

> [!TIP]
> Azure templates will automatically configure the following considerations for you and they are the recommended solution when deploying in Azure IaaS VMs.

- Minimum of two nodes and maximum of three nodes

- Two-node deployments must configure a witness (Cloud Witness or File Share Witness)

- Three-node deployments can tolerate one node down and the loss of one or more disks on another node.  If two nodes shut down, then the virtual disks will be offline until one of the nodes returns.

- Configure the VMs to be deployed across fault domains

    - Azure – Configure the Availability Set

    - Hyper-V – Configure AntiAffinityClassNames on the VMs to separate the VMs across nodes

    - VMware – Configure the VM-VM Anti-Affinity rule by creating a DRS Rule of type "Separate Virtual Machines" to separate the VMs across ESX hosts. Disks presented for use with Storage Spaces Direct should use the Paravirtual SCSI (PVSCSI) adapter. For PVSCSI support with Windows Server, consult https://kb.vmware.com/s/article/1010398.

- Use low latency / high performance storage such as [Azure Premium SSD managed disks or faster](/azure/virtual-machines/disks-types)

- Deploy a flat storage design with no caching devices configured

- Use a minimum of two virtual data disks presented to each VM (VHD / VHDX / VMDK)

    This number is different than bare-metal deployments because the virtual disks can be implemented as files that aren't susceptible to physical failures.

- Disable the automatic drive replacement capabilities in the Health Service by running the following PowerShell cmdlet:

    ```powershell
    Get-storagesubsystem clus* | set-storagehealthsetting -name "System.Storage.PhysicalDisk.AutoReplace.Enabled" -value "False"
    ```

- To give greater resiliency to possible VHD / VHDX / VMDK storage latency in guest clusters, increase the Storage Spaces I/O timeout value:

    `HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\spaceport\\Parameters\\HwTimeout`

    `dword: 00007530`

    The decimal equivalent of Hexadecimal 7530 is 30000, which is 30 seconds. The default value is 1770 Hexadecimal, or 6000 Decimal, which is 6 seconds.

## Not supported

- Host level virtual disk snapshot/restore

    Instead use traditional guest level backup solutions to back up and restore the data on the Storage Spaces Direct volumes.

- Host level virtual disk size change

    The virtual disks exposed through the VM must retain the same size and characteristics. Adding more capacity to the storage pool can be accomplished by adding more virtual disks to each of the VMs, and then adding them to the pool. It's highly recommended to use virtual disks of the same size and characteristics as the current virtual disks.

## More references

- [Additional Azure Iaas VM templates for deploying Storage Spaces Direct, videos, and step-by-step guides](https://techcommunity.microsoft.com/t5/Failover-Clustering/Deploying-IaaS-VM-Guest-Clusters-in-Microsoft-Azure/ba-p/372126).

- [Additional Storage Spaces Direct Overview](/azure-stack/hci/concepts/storage-spaces-direct-overview)

---
title: Safely virtualizing Active Directory Domain Services (AD DS)
description: USN Rollback and safe virtualization of Active Directory
ms.topic: article
ms.prod: windows-server-threshold
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 03/22/2019
ms.technology: identity-adds
ms.assetid: 7a3114c8-bda8-49bb-83a8-4e04340ab221
---
# Safely virtualizing Active Directory Domain Services (AD DS)

>Applies To: Windows Server

Virtualization of Active Directory Domain Services (AD DS) environments has been ongoing for a number of years. Beginning with Windows Server 2012, AD DS provides greater support for virtualizing domain controllers by introducing virtualization-safe capabilities.

## Safe virtualization of domain controllers

Virtual environments present unique challenges to distributed workloads that depend upon a logical clock-based replication scheme. AD DS replication, for example, uses a monotonically increasing value (known as a USN or Update Sequence Number) assigned to transactions on each domain controller. Each domain controller's database instance is also given an identity, known as an InvocationID. The InvocationID of a domain controller and its USN together serve as a unique identifier associated with every write-transaction performed on each domain controller and must be unique within the forest.

AD DS replication uses InvocationID and USNs on each domain controller to determine what changes need to be replicated to other domain controllers. If a domain controller is rolled back in time outside of the domain controller's awareness and a USN is reused for an entirely different transaction, replication will not converge because other domain controllers will believe they have already received the updates associated with the re-used USN under the context of that InvocationID.

For example, the following illustration shows the sequence of events that occurs in Windows Server 2008 R2 and earlier operating systems when USN rollback is detected on VDC2, the destination domain controller that is running on a virtual machine. In this illustration, the detection of USN rollback occurs on VDC2 when a replication partner detects that VDC2 has sent an up-to-dateness USN value that was seen previously by the replication partner, which indicates that VDC2's database has rolled back in time improperly.

![The sequence of events when USN rollback is detected](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/ADDS_Exampleofhowreplicationcanbecomeinconsistent.png)

A virtual machine (VM) makes it easy for hypervisor administrators to roll back a domain controller's USNs (its logical clock) by, for example, applying a snapshot outside of the domain controller's awareness. For more information about USN and USN rollback, including another illustration to demonstrate undetected instances of USN rollback, see [USN and USN Rollback](https://technet.microsoft.com/library/virtual_active_directory_domain_controller_virtualization_hyperv(WS.10).aspx#usn_and_usn_rollback).

Beginning with  Windows Server 2012 , AD DS virtual domain controllers hosted on hypervisor platforms that expose an identifier called VM-Generation ID can detect and employ necessary safety measures to protect the AD DS environment if the virtual machine is rolled back in time by the application of a VM snapshot. The VM-GenerationID design uses a hypervisor-vendor independent mechanism to expose this identifier in the address space of the guest virtual machine, so the safe virtualization experience is consistently available of any hypervisor that supports VM-GenerationID. This identifier can be sampled by services and applications running inside the virtual machine to detect if a virtual machine has been rolled back in time.

## How do virtualization safeguards work?

During domain controller installation, AD DS initially stores the VM GenerationID identifier as part of the msDS-GenerationID attribute on the domain controller's computer object in its database (often referred to as the directory information tree, or DIT). The VM GenerationID is independently tracked by a Windows driver inside the virtual machine.

When an administrator restores the virtual machine from a previous snapshot, the current value of the VM GenerationID from the virtual machine driver is compared against a value in the DIT.

If the two values are different, the invocationID is reset and the RID pool discarded thereby preventing USN re-use. If the values are the same, the transaction is committed as normal.

AD DS also compares the current value of the VM GenerationID from the virtual machine against the value in the DIT each time the domain controller is rebooted and, if different, it resets the invocationID, discards the RID pool and updates the DIT with the new value. It also non-authoritatively synchronizes the SYSVOL folder in order to complete safe restoration. This enables the safeguards to extend to the application of snapshots on VMs that were shutdown. These safeguards introduced in  Windows Server 2012  enable AD DS administrators to benefit from the unique advantages of deploying and managing domain controllers in a virtualized environment.

The following illustration shows how virtualization safeguards are applied when the same USN rollback is detected on a virtualized domain controller that runs  Windows Server 2012  on a hypervisor that supports VM-GenerationID.

![Safeguards applied when the same USN rollback is detected](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/ADDS_VDC_Exampleofhowsafeguardswork.gif)

In this case, when the hypervisor detects a change to VM-GenerationID value, virtualization safeguards are triggered, including the reset of the InvocationID for the virtualized DC (from A to B in the preceding example) and updating the VM-GenerationID value saved on the VM to match the new value (G2) stored by the hypervisor. The safeguards ensure that replication converges for both domain controllers.

With  Windows Server 2012 , AD DS employs safeguards on virtual domain controllers hosted on VM-GenerationID aware hypervisors and ensures that the accidental application of snapshots or other such hypervisor-enabled mechanisms that could rollback a virtual machine's state does not disrupt the AD DS environment (by preventing replication problems such as a USN bubble or lingering objects).

Restoring a domain controller by applying a virtual machine snapshot is not recommended as an alternative mechanism to backing up a domain controller. It is recommended that you continue to use Windows Server Backup or other VSS-writer based backup solutions.

> [!CAUTION]
> If a domain controller in a production environment is accidentally reverted to a snapshot, it's advised that you consult the vendors for the applications, and services hosted on that virtual machine, for guidance on verifying the state of these programs after snapshot restore.

For more information, see [Virtualized domain controller safe restore architecture](../ad-ds/get-started/virtual-dc/Virtualized-Domain-Controller-Architecture.md#BKMK_SafeRestoreArch).

## Next steps

* For more troubleshooting information about virtualized domain controllers, see [Virtualized Domain Controller Troubleshooting](../ad-ds/manage/virtual-dc/Virtualized-Domain-Controller-Troubleshooting.md).
* [Detailed information about Windows Time Service (W32Time)](../../networking/windows-time-service/windows-time-service-top.md)
* To configure the Windows Time service on a domain controller that is running in a virtual machine, it is recommended that you partially disable time synchronization between the host system and guest operating system acting as a domain controller. This enables your guest domain controller to synchronize time for the domain hierarchy, but protects it from having a time skew if it is restored from a Saved state. For more information, see Microsoft Knowledge Base article 976924, [You receive Windows Time Service event IDs 24, 29, and 38 on a virtualized domain controller that is running on a Windows Server 2008-based host server with Hyper-V](https://go.microsoft.com/fwlink/?LinkID=192236) and [Deployment Considerations for Virtualized Domain Controllers](https://go.microsoft.com/fwlink/?LinkID=192235).
* To configure the Windows Time service on a domain controller acting as the forest root PDC emulator that is also running in a virtual computer, follow the same instructions for a physical computer as described in [Configure the Windows Time service on the PDC emulator in the Forest Root Domain](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731191%28v=ws.10%29).

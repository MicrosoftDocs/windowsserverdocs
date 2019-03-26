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

Beginning with Windows Server 2012, AD DS provides greater support for virtualizing domain controllers by introducing virtualization-safe capabilities. This article explains the role of USNs and InvocationIDs in Domain Controller replication and discusses some potential issues that can occur.

## Update sequence number and InvocationID

Virtual environments present unique challenges to distributed workloads that depend upon a logical clock-based replication scheme. AD DS replication, for example, uses a monotonically increasing value (known as a USN or Update Sequence Number) assigned to transactions on each domain controller. Each domain controller's database instance is also given an identity, known as an InvocationID. The InvocationID of a domain controller and its USN together serve as a unique identifier associated with every write-transaction performed on each domain controller and must be unique within the forest.

AD DS replication uses InvocationID and USNs on each domain controller to determine what changes need to be replicated to other domain controllers. If a domain controller is rolled back in time outside of the domain controller's awareness and a USN is reused for an entirely different transaction, replication will not converge because other domain controllers will believe they have already received the updates associated with the re-used USN under the context of that InvocationID.

For example, the following illustration shows the sequence of events that occurs in Windows Server 2008 R2 and earlier operating systems when USN rollback is detected on VDC2, the destination domain controller that is running on a virtual machine. In this illustration, the detection of USN rollback occurs on VDC2 when a replication partner detects that VDC2 has sent an up-to-dateness USN value that was seen previously by the replication partner, which indicates that VDC2's database has rolled back in time improperly.

![The sequence of events when USN rollback is detected](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/ADDS_Exampleofhowreplicationcanbecomeinconsistent.png)

A virtual machine (VM) makes it easy for hypervisor administrators to roll back a domain controller's USNs (its logical clock) by, for example, applying a snapshot outside of the domain controller's awareness. For more information about USN and USN rollback, including another illustration to demonstrate undetected instances of USN rollback, see [USN and USN Rollback](https://technet.microsoft.com/library/virtual_active_directory_domain_controller_virtualization_hyperv(WS.10).aspx#usn_and_usn_rollback).

Beginning with  Windows Server 2012 , AD DS virtual domain controllers hosted on hypervisor platforms that expose an identifier called VM-Generation ID can detect and employ necessary safety measures to protect the AD DS environment if the virtual machine is rolled back in time by the application of a VM snapshot. The VM-GenerationID design uses a hypervisor-vendor independent mechanism to expose this identifier in the address space of the guest virtual machine, so the safe virtualization experience is consistently available of any hypervisor that supports VM-GenerationID. This identifier can be sampled by services and applications running inside the virtual machine to detect if a virtual machine has been rolled back in time.

## Effects of USN rollback

When USN rollbacks occur, modifications to objects and attributes are not inbound replicated by destination domain controllers that have previously seen the USN.

Because these destination domain controllers believe they are up to date, no replication errors are reported in Directory Service event logs or by monitoring and diagnostic tools.

USN rollback may affect the replication of any object or attribute in any partition. The most frequently observed side effect is that user accounts and computer accounts that are created on the rollback domain controller do not exist on one or more replication partners. Or, the password updates that originated on the rollback domain controller do not exist on replication partners.

A USN rollback can prevent any object type in any Active Directory partition from replicating. These object types include the following:

* The Active Directory replication topology and schedule
* The existence of domain controllers in the forest and the roles that these domain controllers hold
* The existence of domain and application partitions in the forest
* The existence of security groups and their current group memberships
* DNS record registration in Active Directory-integrated DNS zones

The size of the USN hole may represent hundreds, thousands, or even tens of thousands of changes to users, computers, trusts, passwords, and security groups. The USN hole is defined by the difference between the highest USN number that existed when the restored system state backup was made and the number of originating changes that were created on the rolled-back domain controller before it was taken offline.

## Detecting a USN rollback

Because a USN rollback is difficult to detect, a domain controller logs event 2095 when a source domain controller sends a previously acknowledged USN number to a destination domain controller without a corresponding change in the invocation ID.

To prevent unique originating updates to Active Directory from being created on the incorrectly restored domain controller, the Net Logon service is paused. When the Net Logon service is paused, user and computer accounts cannot change the password on a domain controller that will not outbound-replicate such changes. Similarly, Active Directory administration tools will favor a healthy domain controller when they make updates to objects in Active Directory.

On a domain controller, event messages that resemble the following are recorded if the following conditions are true:

* A source domain controller sends a previously acknowledged USN number to a destination domain controller.
* There is no corresponding change in the invocation ID.

These events may be captured in the Directory Service event log. However, they may be overwritten before they are observed by an administrator.

If you suspect a USN rollback has ocurred but do not see a corresponding event in the event logs, check for the DSA Not Writable entry in the registry. This entry provides forensic evidence that a USN rollback has occurred.

```
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters
Registry entry: Dsa Not Writable
Value: 0x4
```

> [!WARNING]
> Deleting or manually changing the Dsa Not Writable registry entry value puts the rollback domain controller in a permanently unsupported state. Therefore, such changes are not supported. Specifically, modifying the value removes the quarantine behavior added by the USN rollback detection code. The Active Directory partitions on the rollback domain controller will be permanently inconsistent with direct and transitive replication partners in the same Active Directory forest.

More information on this registry key and resolution steps can be found in the support article [Active Directory Replication Error 8456 or 8457: "The source | destination server is currently rejecting replication requests"](https://support.microsoft.com/help/2023007/active-directory-replication-error-8456-or-8457-the-source-destination).

## Virtualization based safeguards

During domain controller installation, AD DS initially stores the VM GenerationID identifier as part of the msDS-GenerationID attribute on the domain controller's computer object in its database (often referred to as the directory information tree, or DIT). The VM GenerationID is independently tracked by a Windows driver inside the virtual machine.

When an administrator restores the virtual machine from a previous snapshot, the current value of the VM GenerationID from the virtual machine driver is compared against a value in the DIT.

If the two values are different, the invocationID is reset and the RID pool discarded thereby preventing USN re-use. If the values are the same, the transaction is committed as normal.

AD DS also compares the current value of the VM GenerationID from the virtual machine against the value in the DIT each time the domain controller is rebooted and, if different, it resets the invocationID, discards the RID pool and updates the DIT with the new value. It also non-authoritatively synchronizes the SYSVOL folder in order to complete safe restoration. This enables the safeguards to extend to the application of snapshots on VMs that were shutdown. These safeguards introduced in  Windows Server 2012  enable AD DS administrators to benefit from the unique advantages of deploying and managing domain controllers in a virtualized environment.

The following illustration shows how virtualization safeguards are applied when the same USN rollback is detected on a virtualized domain controller that runs Windows Server 2012 on a hypervisor that supports VM-GenerationID.

![Safeguards applied when the same USN rollback is detected](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/ADDS_VDC_Exampleofhowsafeguardswork.gif)

In this case, when the hypervisor detects a change to VM-GenerationID value, virtualization safeguards are triggered, including the reset of the InvocationID for the virtualized DC (from A to B in the preceding example) and updating the VM-GenerationID value saved on the VM to match the new value (G2) stored by the hypervisor. The safeguards ensure that replication converges for both domain controllers.

With Windows Server 2012, AD DS employs safeguards on virtual domain controllers hosted on VM-GenerationID aware hypervisors and ensures that the accidental application of snapshots or other such hypervisor-enabled mechanisms that could rollback a virtual machine's state does not disrupt the AD DS environment (by preventing replication problems such as a USN bubble or lingering objects).

Restoring a domain controller by applying a virtual machine snapshot is not recommended as an alternative mechanism to backing up a domain controller. It is recommended that you continue to use Windows Server Backup or other VSS-writer based backup solutions.

> [!CAUTION]
> If a domain controller in a production environment is accidentally reverted to a snapshot, it's advised that you consult the vendors for the applications, and services hosted on that virtual machine, for guidance on verifying the state of these programs after snapshot restore.

For more information, see [Virtualized domain controller safe restore architecture](../ad-ds/get-started/virtual-dc/Virtualized-Domain-Controller-Architecture.md#BKMK_SafeRestoreArch).

## Recovering from a USN rollback

There are two approaches to recover from a USN rollback:

* Remove the Domain Controller from the domain
* Restore the system state of a good backup

### Remove the Domain Controller from the domain

1. Remove Active Directory from the domain controller to force it to be a stand-alone server.
2. Shut down the demoted server.
3. On a healthy domain controller, clean up the metadata of the demoted domain controller.
4. If the incorrectly restored domain controller hosts operations master roles, transfer these roles to a healthy domain controller.
5. Restart the demoted server.
6. If you are required to, install Active Directory on the stand-alone server again.
7. If the domain controller was previously a global catalog, configure the domain controller to be a global catalog.
8. If the domain controller previously hosted operations master roles, transfer the operations master roles back to the domain controller.

### Restore the system state of a good backup

Evaluate whether valid system state backups exist for this domain controller. If a valid system state backup was made before the rolled-back domain controller was incorrectly restored, and the backup contains recent changes that were made on the domain controller, restore the system state from the most recent backup.

You can also use the snapshot as a source of a backup. Or you can set the database to give itself a new invocation ID using the procedure in the section [Restoring a virtual domain controller when an appropriate system state data backup is not available](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd363553%28v%3dws.10%29#restoring-a-virtual-domain-controller-when-an-appropriate-system-state-data-backup-is-not-available)

## Next steps

* For more troubleshooting information about virtualized domain controllers, see [Virtualized Domain Controller Troubleshooting](../ad-ds/manage/virtual-dc/Virtualized-Domain-Controller-Troubleshooting.md).
* [Detailed information about Windows Time Service (W32Time)](../../networking/windows-time-service/windows-time-service-top.md)

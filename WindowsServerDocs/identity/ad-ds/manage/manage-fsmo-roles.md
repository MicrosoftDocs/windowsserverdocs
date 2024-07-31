---
title: Transfer Flexible Single Master Operations roles in Windows Server
description: Learn how to transfer FSMO roles in Active Directory Domain Services (AD DS) to optimize performance and simplify administration.
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
contributor: orthomas
ms.date: 07/01/2024
#customer intent: As an Active Directory Domain Services administrator, I need to manage the Flexible Single Master Operations (FSMO) roles so that I can optimize performance and perform administration tasks.
---

# Transfer Flexible Single Master Operations roles

When you create a new domain, the Active Directory Domain Services Installation Wizard automatically assigns all the domain-level Flexible Single Master Operations (FSMO) to the first domain controller that is created in that domain. When you create a new forest, the wizard also assigns the two forest-level operations master roles to the first domain controller. After the domain is created and functioning, you might want to transfer various operations master roles to different domain controllers to optimize performance and simplify administration.

Consider moving the operations master role or roles when any of the following conditions exist:

- Inadequate service performance

- Failure of a domain controller that hosts an operations master role

- Decommissioning of a domain controller that hosts an operations master role

- Administrative configuration changes that affect operations master role placement

If an operations master role holder has failed or been decommissioned before you can transfer the role, you must seize and transfer the role to a healthy domain controller. If you can't fix the previous role holder, or if you seized the roles, remove the previous role holder from the domain and clean up its metadata. To learn more about metadata cleanup, see [Clean up Active Directory Domain Controller server metadata](../deploy/ad-ds-metadata-cleanup.md). If you plan to reuse the repaired computer as a domain control, we recommend you format and rebuild the computer instead of restoring the domain controller from a backup. Restored domain controllers would as be role holders again and cause a conflict.

## Prerequisites

Before you transfer an operations master role, you need to complete the following prerequisites.

- Review the article [Flexible Single Master Operations roles](understand-fsmo-roles.md) for other considerations before transferring an FSMO role.

- To transfer the Schema Master role, your account must be a member of the Schema Admins group and should also be a member of the Enterprise Admins group.

- To transfer the Domain Naming Master role, your account must be a member of the Enterprise Admins group.

- To transfer the PDC Emulator role, your account must be a member of the Domain Admins group.

- To transfer the RID Master role, your account must be a member of the Domain Admins group.

- To transfer the Infrastructure Master role, your account must be a member of the Domain Admins group.

- Your Active Directory domain is operational and free from replication errors. To learn more about replication errors, see [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures).

## Find the current role holders

To determine which domain controller holds a specific operations master role, you can use the Active Directory Users and Computers snap-in or the PowerShell cmdlet `Get-ADDomainController`. To find the current role holders, run the following steps.

1. Sign on to a computer with the AD DS Remote Server Administration Tools (RSAT) installed.

1. Open a PowerShell window.

1. Run the following PowerShell commands to list the domain controllers and their operations master roles. The script lists the domain controllers in the domain and the operations master roles that they hold.

   ```powershell
   $domainControllers = Get-ADDomainController -Filter *
   foreach ($dc in $domainControllers) {
       Write-Output "Name: $($dc.Name)"
       Write-Output "OperationMasterRoles:"
       foreach ($role in $dc.OperationMasterRoles) {
           Write-Output "- $role"
       }
   }
   ```

## Transfer Schema master role

To transfer the Schema master role, follow these steps.

1. Run the following PowerShell command to transfer the Schema Master role to another domain controller. Replace `<TargetServer>` with the name of the domain controller that you want to transfer the role to.

   ```powershell
   Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole SchemaMaster
   ```

1. When prompted, type **Yes** or <kbd>Y</kbd> to confirm the transfer.

1. To confirm that the Schema Master role has been transferred, run the following PowerShell command:

   ```powershell
   Get-ADDomainController -Identity <TargetServer> | Select-Object OperationMasterRoles
   ```

If the domain controller that currently holds the Schema Master role has failed, you can use the `Move-ADDirectoryServerOperationMasterRole` with the **Force** parameter to seize the role and move it to a functional domain controller.

## Transfer Domain Naming Master role

To transfer the Domain Naming Master role, run the following PowerShell command:

1. Run the following PowerShell command to transfer the Domain Naming Master role to another domain controller. Replace `<TargetServer>` with the name of the domain controller that you want to transfer the role to.

   ```powershell
   Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole DomainNamingMaster
   ```

1. When prompted, type **Yes** or <kbd>Y</kbd> to confirm the transfer.

1. To confirm that the Domain Naming Master role has been transferred, run the following PowerShell command:

   ```powershell
   Get-ADDomainController -Identity <TargetServer> | Select-Object OperationMasterRoles
   ```

If the domain controller that currently holds the Domain Naming Master role has failed, you can use the `Move-ADDirectoryServerOperationMasterRole` with the **Force** parameter to seize the role and move it to a functional domain controller.

## Transfer PDC Emulator role

To transfer the PDC Emulator role, run the following PowerShell command:

1. Run the following PowerShell command to transfer the PDC Emulator role to another domain controller. Replace `<TargetServer>` with the name of the domain controller that you want to transfer the role to.

   ```powershell
   Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole PDCEmulator
   ```

1. When prompted, type **Yes** or <kbd>Y</kbd> to confirm the transfer.

1. To confirm that the PDC Emulator role has been transferred, run the following PowerShell command:

   ```powershell
   Get-ADDomainController -Identity <TargetServer> | Select-Object OperationMasterRoles
   ```

If the domain controller that currently holds the PDC Emulator role has failed, you can use the `Move-ADDirectoryServerOperationMasterRole` with the **Force** parameter to seize the role and move it to a functional domain controller.

## Transfer RID Master role

To transfer the RID Master role, follow these steps.

1. Run the following PowerShell command to transfer the RID Master role to another domain controller. Replace `<TargetServer>` with the name of the domain controller that you want to transfer the role to.

   ```powershell
   Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole RIDMaster
   ```

1. When prompted, type **Yes** or <kbd>Y</kbd> to confirm the transfer.

1. To confirm that the RID Master role has been transferred, run the following PowerShell command:

   ```powershell
   Get-ADDomainController -Identity <TargetServer> | Select-Object OperationMasterRoles
   ```

If the domain controller that currently holds the RID Master role has failed, you can use the `Move-ADDirectoryServerOperationMasterRole` with the **Force** parameter to seize the role and move it to a functional domain controller.

## Transfer Infrastructure Master role

To transfer the Infrastructure Master role, follow these steps.

1. Run the following PowerShell command to transfer the Infrastructure Master role to another domain controller. Replace `<TargetServer>` with the name of the domain controller that you want to transfer the role to.

   ```powershell
   Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole InfrastructureMaster
   ```

1. When prompted, type **Yes** or <kbd>Y</kbd> to confirm the transfer.

1. To confirm that the Infrastructure Master role has been transferred, run the following PowerShell command:

   ```powershell
   Get-ADDomainController -Identity <TargetServer> | Select-Object OperationMasterRoles
   ```

If the domain controller that currently holds the Infrastructure Master role has failed, you can use the `Move-ADDirectoryServerOperationMasterRole` with the **Force** parameter to seize the role and move it to a functional domain controller.

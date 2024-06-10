---
title: Manage Flexible Single Master Operations (FSMO) roles
description: Learn how to manage FSMO roles.
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
contributor: orthomas
ms.date: 06/05/2024
---

# Manage Flexible Single Operations Master roles

When you create a new domain, the Active Directory Domain Services Installation Wizard automatically assigns all the domain-level operations master roles to the first domain controller that is created in that domain. When you create a new forest, the wizard also assigns the two forest-level operations master roles to the first domain controller. After the domain is created and functioning, you might transfer various operations master roles to different domain controllers to optimize performance and simplify administration.

Consider moving the operations master role or roles when any of the following conditions exist:

- Inadequate service performance
- Failure of a domain controller that hosts an operations master role
- Decommissioning of a domain controller that hosts an operations master role
- Administrative configuration changes that affect operations master role placement

Before you transfer an operations master role, if possible ensure that replication has occurred between the current role holder and the domain controller that will assume the role.
 
## Transfer Schema master role

To transfer the Schema Master role, you need to use a user account that is a member of the Schema Admins group and should also be a member of the Enterprise Admins group. To determine which AD DS domain controller currently holds the Schema master role, run the following PowerShell command:

```powershell
Get-ADForest | Select-Object SchemaMaster
```

Once you determine which AD DS domain controller holds the Schema Master role, you can use the following command to transfer the role to another domain controller.

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole SchemaMaster
```

In the event that the domain controller that currently holds the Schema Master role has failed, you can use the Move-ADDirectoryServerOperationMasterRole with the Force parameter to sieze the role and move it to a functional domain controller.

## Transfer Domain Naming Master role

To transfer the Domain Naming Master role, you need to use a user account that is a member of the Enterprise Admins group. To determine which AD DS domain controller currently holds the Domain Naming role, run the following PowerShell command:

```powershell
Get-ADForest | Select-Object DomainNamingMaster
```

Once you determine which AD DS domain controller holds the Domain Naming Master role, you can use the following command to transfer the role to another domain controller.

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole DomainNamingMaster
```

In the event that the domain controller that currently holds the Domain Naming Master role has failed, you can use the Move-ADDirectoryServerOperationMasterRole with the Force parameter to sieze the role and move it to a functional domain controller.

## Transfer PDC Emulator role

To transfer the PDC Emulator role, you need to use a user account that is a member of the Domain Admins group. To determine which AD DS domain controller currently holds the Domain Naming role, run the following PowerShell command:

```powershell
Get-ADDomain | Select-Object PDCEmulator
```

Once you determine which AD DS domain controller holds the PDC Emulator role, you can use the following command to transfer the role to another domain controller.


```powershell
Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole PDCEmulator
```

In the event that the domain controller that currently holds the PDC Emulator role has failed, you can use the Move-ADDirectoryServerOperationMasterRole with the Force parameter to sieze the role and move it to a functional domain controller.

## Transfer RID Master role

To transfer the RID Master role, you need to use a user account that is a member of the Domain Admins group. To determine which AD DS domain controller currently holds the RID Master role, run the following PowerShell command:

```powershell
Get-ADDomain | Select-Object RIDMaster
```

Once you determine which AD DS domain controller holds the RID Master role, you can use the following command to transfer the role to another domain controller.

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole RIDMaster
```

In the event that the domain controller that currently holds the RID Master role has failed, you can use the Move-ADDirectoryServerOperationMasterRole with the Force parameter to sieze the role and move it to a functional domain controller.

## Transfer Infrastructure Master role

To transfer the Infrastructure Master role, you need to use a user account that is a member of the Domain Admins group. To determine which AD DS domain controller currently holds the Domain Naming role, run the following PowerShell command:

```powershell
Get-ADDomain | Select-Object InfrastructureMaster
```

Once you determine which AD DS domain controller holds the Infrastructure Master role, you can use the following command to transfer the role to another domain controller.

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity <TargetServer> -OperationMasterRole InfrastructureMaster
```

In the event that the domain controller that currently holds the Infrastructure Master role has failed, you can use the Move-ADDirectoryServerOperationMasterRole with the Force parameter to sieze the role and move it to a functional domain controller.

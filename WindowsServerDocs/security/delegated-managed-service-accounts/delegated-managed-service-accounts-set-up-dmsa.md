---
title: Setting up delegated Managed Service Accounts (dMSA) in Windows Server Preview
description: Learn how to set up delegated Managed Service Accounts (dMSA) in Windows Server Insiders Preview to ensure device credentials isolation in Active Directory.
ms.topic: how-to
ms.author: alalve
author: mariamgewida
ms.date: 02/16/2024
---

# Setting up delegated Managed Service Accounts

A delegated Managed Service Account (dMSA) is an Active Directory (AD) account that enables secure management of credentials. Unlike traditional service accounts, dMSAs don't require manual management of passwords as AD automatically manages the password, ensuring that it remains secure. Additionally, dMSAs can be delegated specific permissions to access resources in the domain, providing an efficient way to manage access control. Setting up a dMSA is currently only available in Windows Server Preview.

## Prerequisites

- The **Active Directory Domain Services** role must be installed on your device or on any device if using remote management tools. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).
- Once the role is installed, your device must be promoted to a Domain Controller (DC). In **Server Manager**, the flag icon displays a new notification, select **Promote this server to a domain controller**, then complete the necessary steps.
- In Group Policy Object for client devices, **Kerberos** must be _enabled_ in the path **Computer Configuration\Administrative Templates\System\Kerberos**.

## Migrate to a dMSA

If the service account being migrated to a dMSA has access to multiple servers, a registry policy must first be applied to ensure it defaults to the DC. Once you sign in using the dMSA, run:

```powershell
New-ItemProperty
 -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" 
 -Name "DelegatedMSAEnabled"
 -Value "1"
 -PropertyType DWORD
 -Force
```

After modifying the registry, you can link a service account to a dMSA by running:

```powershell
Start-ADServiceAccountMigration –Identity <DMSAName> –SupersededAccount <DN of service account>
```

Once the account is linked, the current running services for the account need to be restarted by running:

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Restart-Service
```

Then, verify that the **PrincipalsAllowedToRetrieveManagedPassword** property for the dMSA object is set:

```powershell
Get-ADServiceAccount -Identity <DMSAName> -Properties PrincipalsAllowedToRetrieveManagedPassword
```

> [!NOTE]
> In the case that the service account is connected to multiple devices and migration has ended, the [PrincipalsAllowedToRetrieveManagedPassword](/powershell/module/activedirectory/set-adserviceaccount?view=windowsserver2022-ps#example-3-set-the-principals-allowed-to-retrieve-the-password-for-an-msa&preserve-view=true) needs to be updated manually.

### Complete account migration

> [!WARNING]
> When finalizing the migration, **never** delete the original service account in case you need to revert back to it post migration as this causes several issues.

To complete the account migration, traditional service accounts must be disabled to ensure that all services use the dMSA by running:

```powershell
Complete-ADServiceAccountMigration –Identity <DMSAName> –SupersededAccount <DN of service account>
```

If the wrong account is being migrated, run the following to undo all steps during migration:

```powershell
Undo-ADServiceAccountMigration –Identity <DMSAName> –SupersededAccount <DN of service account>
```

To revert a service account back to an inactive or unlinked state, run:

```powershell
Reset-ADServiceAccountMigration –Identity <DMSAName> –SupersededAccount <DN of service account>
```

## Create a dMSA

To create a new dMSA, open PowerShell as admin and run:

```powershell
New-ADServiceAccount -Name <DMSAName> -DNSHostName <host> -CreateDelegatedServiceAccount -KerberosEncryptionType AES256
```

To learn more about `New-ADServiceAccount` and related cmdlets, see [New-ADServiceAccount](/powershell/module/activedirectory/new-adserviceaccount?view=windowsserver2025-ps&preserve-view=true).

## View dMSA event logs

Events can be viewed using the Event Viewer (eventvwr.exe) by performing the following actions:

1. Right-click on **Start** and select **Event Viewer**.
1. In the left pane, expand **Applications and Services** and navigate to **Microsoft\Windows\Security-Kerberos\Operational**.
1. Logging for this provider is disabled by default, to enable logging, right-click on **Operational** and select **Enable Log**.

The following table describes the captured events.

|Event ID|Description|
|-|-|
|307| **dMSA Migration** - This event is written for both dMSAs under migration and for ones that migrated. It contains information about the old service account and the new dMSA.|
|308| **dMSA Permission Add** - This event is logged when a machine attempts to add itself to the principals allowed to retrieve managed password field of a dMSA during migration.|
|309| **dMSA Key Fetch** - This event is logged when the Kerberos client attempts to fetch keys for a dMSA from the domain controller.|

## See also

- [Complete-ADServiceAccountMigration](/powershell/module/activedirectory/complete-adserviceaccountmigration?view=windowsserver2025-ps&preserve-view=true)
- [Reset-ADServiceAccountMigration](/powershell/module/activedirectory/reset-adserviceaccountmigration?view=windowsserver2025-ps&preserve-view=true)
- [Start-ADServiceAccountMigration](/powershell/module/activedirectory/start-adserviceaccountmigration?view=windowsserver2025-ps&preserve-view=true)
- [Undo-ADServiceAccountMigration](/powershell/module/activedirectory/undo-adserviceaccountmigration?view=windowsserver2025-ps&preserve-view=true)

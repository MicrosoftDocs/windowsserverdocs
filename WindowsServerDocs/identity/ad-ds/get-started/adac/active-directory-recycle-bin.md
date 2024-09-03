---
description: Learn how to enable Active Directory Recycle Bin and restore deleted objects in Active Directory Domain Services on Windows Server.
title: Enable Active Directory Recycle Bin in Windows Server
ms.author: orthomas
author: orin-thomas
ms.date: 07/15/2024
ms.topic: how-to
#customer intent: As an Active Directory administrator, I want to enable Active Directory Recycle Bin so that I can recover deleted objects in Active Directory Domain Services.
---

# Enable and use Active Directory Recycle Bin in Windows Server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Active Directory Recycle Bin allows you to preserve and recover accidentally deleted Active Directory objects. When you enable Active Directory Recycle Bin, all link-valued and non-link-valued attributes of the deleted Active Directory objects are preserved. Meaning objects can be restored in their entirety to the same consistent logical state that they were in immediately before deletion. For example, restored user accounts automatically regain all group memberships and corresponding access rights that they had immediately before deletion, within and across domains.

Active Directory Recycle Bin isn't enabled by default. The process of enabling Active Directory Recycle Bin is irreversible. After you enable Active Directory Recycle Bin in your environment, you can't disable it.

## Prerequisites

Before you can enable Active Directory Recycle Bin, you'll need to complete the following prerequisites.

- The forest and domain functional level must be Windows Server 2008 R2 or higher.

- You must be a member of the Domain Admins group in the domain you want to enable Active Directory Recycle Bin.

- On the computer where you'll enable and use the Active Directory Recycle Bin, you must have either of the following Remote Server Administration Tools (RSAT) installed:

  - Active Directory Administrative Center (ADAC)

    OR

  - Active Directory module for Windows PowerShell.

## Enable Active Directory Recycle Bin

To enable Active Directory Recycle Bin, perform the following steps:

#### [Active Directory Administrative Center](#tab/adac)

Here's how to enable Active Directory Recycle Bin using Active Directory Administrative Center (ADAC):

1. Sign into a computer that has the Active Directory module for Windows PowerShell installed.

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain is not selected, choose **Manage**, choose **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. In the **Tasks** pane, choose **Enable Recycle Bin ...** in the **Tasks** pane, choose **OK** on the warning message box, and then choose **OK** to the refresh ADAC message.

1. Press F5 to refresh ADAC.

#### [PowerShell](#tab/powershell)

Here's how to enable Active Directory Recycle Bin using the [Enable-ADOptionalFeature](/powershell/module/activedirectory/enable-adoptionalfeature) cmdlet. For example, to enable the Active Directory Recycle Bin in the `contoso.com` domain, run the following command:

```powershell
Enable-ADOptionalFeature -Identity 'CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com' -Scope ForestOrConfigurationSet -Target 'contoso.com'
```

---

If you encounter an error, you can try moving both the schema master and the domain naming master roles to the same domain controller in the root domain. Then run the cmdlet from that domain controller.

## Use Active Directory Recycle Bin to restore deleted objects

> [!TIP]
> You can only restore AD DS items that were deleted after Active Directory Recycle Bin is enabled. You can't use Active Directory Recycle Bin to recover items that were deleted before enabling this functionality.

You can use Active Directory Administrative Center to restore deleted objects. To do this, perform the following steps:

#### [Active Directory Administrative Center](#tab/adac)

Here's how to restore deleted objects using Active Directory Administrative Center:

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. choose **Manage**, choose **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. Navigate to the **Deleted Objects** container, select the users you wish to restore and then choose **Restore** in the **Tasks** pane.

1. To confirm the objects were restored to their original location, navigate to the target domain and verify the user accounts are listed.

#### [PowerShell](#tab/powershell)

Here's how to restore deleted objects using the [Restore-ADObject](/powershell/module/activedirectory/Restore-ADObject) cmdlet.  For example, to restore all deleted objects that include the name "test", use the following command:

```powershell
Get-ADObject -Filter 'Name -Like "*test*"' -IncludeDeletedObjects | Restore-ADObject
```

To restore deleted objects to a different location, choose**Restore To** in the **Tasks** pane and specify the location to which you wish to restore the deleted objects. You can accomplish the same goal with the Restore-ADObject cmdlet by using the TargetPath parameter. for example, to restore all objects that include the name "test" to the OU1 OU in the contoso.com domain, run the command:

```powershell
Get-ADObject -Filter 'Name -Like "*test*"' -IncludeDeletedObjects | Restore-ADObject -TargetPath "OU=OU1,DC=contoso,DC=com"
```

---

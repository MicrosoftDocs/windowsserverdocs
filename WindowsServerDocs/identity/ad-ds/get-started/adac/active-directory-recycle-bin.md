---
description: "Learn more about Active Directory Recycle Bin"
title: Introduction to Active Directory Recycle Bin
ms.author: orthomas
author: orin-thomas
ms.date: 07/15/2024
ms.topic: article
---
Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Accidental deletion of Active Directory objects is a common occurrence for users of Active Directory Domain Services (AD DS). Active Directory Recycle Bin allows you to preserve and recover accidentally deleted Active Directory objects.

When you enable Active Directory Recycle Bin, all link-valued and non-link-valued attributes of the deleted Active Directory objects are preserved and the objects are restored in their entirety to the same consistent logical state that they were in immediately before deletion. For example, restored user accounts automatically regain all group memberships and corresponding access rights that they had immediately before deletion, within and across domains. 

Active Directory Recycle Bin is not enabled by default. If you plan to enable Active Directory Recycle Bin in Windows Server, consider the following:

- The process of enabling Active Directory Recycle Bin is irreversible. After you enable Active Directory Recycle Bin in your environment, you cannot disable it.
- To manage the Recycle Bin feature through a user interface, you must install Active Directory Administrative Center.
- You can only restore AD DS items that were deleted after Active Directory Recycle Bin is enabled. You cannot use Active Directory Recycle Bin to recover items that were deleted prior to enabling this functionality.

### Enable Active Directory Recycle Bin

To enable Active Directory Recycle Bin, perform the following steps: 

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

2. If the appropriate target domain is not selected, choose **Manage**, choose **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then click **OK**.

3. In the **Tasks** pane, click **Enable Recycle Bin ...** in the **Tasks** pane, click **OK** on the warning message box, and then click **OK** to the refresh ADAC message.

4. Press F5 to refresh ADAC.

You can also enable Active Directory Recycle Bin with the Enable-ADOptionalFeature cmdlet. For example, to enable the Active Directory Recycle Bin in the contoso.com domain, run the following command:

```powershell
Enable-ADOptionalFeature -Identity 'CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com' -Scope ForestOrConfigurationSet -Target 'contoso.com'
```

If you encounter an error, you can try moving both the schema master and the domain naming master roles to the same domain controller in the root domain. Then run the cmdlet from that domain controller.

### Use Active Directory Recycle Bin to restore deleted objects

You can use Active Directory Administrative Center to restore deleted objects. To do this, perform the following steps:

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

2. Click **Manage**, click **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then click **OK**.

3. Navigate to the **Deleted Objects** container, select the users you wish to restore and then click **Restore** in the **Tasks** pane.

4. To confirm the objects were restored to their original location, navigate to the target domain and verify the user accounts are listed.

You can use the Restore-ADObject PowerShell cmdlet to restore objects. For example, to restore all deleted objects that include the name "test", use the following command:

```powershell
Get-ADObject -Filter 'Name -Like "*test*"' -IncludeDeletedObjects | Restore-ADObject
```

To restore deleted objects to a different location, choose**Restore To** in the **Tasks** pane and specify the location to which you wish to restore the deleted objects. You can accomplish the same goal with the Restore-ADObject cmdlet by using the TargetPath parameter. for example, to restore all objects that include the name "test" to the OU1 OU in the contoso.com domain, run the command:

```powershell
Get-ADObject -Filter 'Name -Like "*test*"' -IncludeDeletedObjects | Restore-ADObject -TargetPath "OU=OU1,DC=contoso,DC=com"
```

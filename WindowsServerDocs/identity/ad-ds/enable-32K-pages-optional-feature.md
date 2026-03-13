---
title: Enable Database 32k pages optional feature in Active Directory Domain Services on Windows Server
description: Learn how-to enable the Database 32k pages optional feature in Active Directory Domain Services and how to enable the optional feature using PowerShell.
author: robinharwood
ms.author: roharwoo
ms.date: 10/25/2024
ms.topic: how-to
#customer intent: As an Active Directory administrator, I want to enable the Database 32k pages optional feature in Active Directory Domain Services, so that I can improve scalability.
---

# Enable Database 32k pages optional feature in Active Directory Domain Services



The _Database 32k pages optional feature_ offers a huge improvement in scalability. Beginning with Windows Server 2025, new Active Directory forest and domains are installed with a 32k page database format. By default these new forests and domains use an 8k page simulation mode to support previous versions. An upgraded DC continues to use an 8K database format and pages. Moving to a 32k database page-size is a forest-wide operation and requires that all domain controllers in the forest have a 32k page capable database. For more information about the considerations when using the 32k page database format, see [Database 32k pages optional feature](32k-pages-optional-feature.md).

> [!WARNING]
> Once you have enabled the Database 32k pages optional feature, you can't revert back to the previous 8k page simulation mode. As a result, any 8k-page backup media created prior to enabling the feature will be unusable unless a complete authoritative forest recovery is performed.

In this article, you learn how to enable the Database 32k pages optional feature in Active Directory Domain Services using PowerShell.
 
## Prerequisites

Before you can enable the Database 32k pages optional feature in Active Directory Domain Services, you need to complete the following prerequisites.

- Review the article [32k pages in Active Directory Domain Services and Active Directory Lightweight Domain Services](32k-pages-optional-feature.md) for other considerations before enabling the 32k page feature.
- Your Active Directory domain is operational and free from replication errors. To learn more about replication errors, see [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures).
- All domain controllers are running Windows Server 2025 or later, and have a 32k page capable database.
- Domain and forest functional levels must be upgraded to Windows Server 2025 or later. To learn more about raising the functional levels, see the article [Raise Active Directory domain and forest functional levels](/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels).
- Identify all your domain controllers hosting the Global Catalog (GC) and FSMO roles. Create and verify backups of these Active Directory Domain Services domain controllers before making changes.
- Validate your backup software is compatible with the 32k page database format by backing up and restoring a 32k page capable database in a test environment.
- Your account must be a member of the Enterprise Admins group or have equivalent permissions.

## Optional: Verify you have a 32k page capable database

If you want to manually verify the page database size on each domain controller before enabling the Database 32k pages optional feature, you can use the following steps.

> [!NOTE]
> When you enable the feature using the `Enable-ADOptionalFeature` cmdlet in the [Enable the Database 32k pages optional feature](#enable-the-database-32k-pages-optional-feature) section, the command checks all domain controllers have a 32k page capable database.

### [Desktop](#tab/desktop)

To verify the page database size of a domain controller using ADSI Edit, follow these steps.

1. Sign on to a computer with the AD DS Remote Server Administration Tools (RSAT) installed.

1. Select the **Start** button, type **ADSI Edit**, and then select **ADSI Edit** from the search results.

1. Right-click **ADSI Edit** from the console tree, then select **Connect to**.

1. In the **Connection Settings** dialog box, select the **Select a well known Naming Context** radio button, and then select **Configuration** from the drop-down list.

1. Expand the domain and server you want to check. For example, a server called FABRIKAMDC01, in the Corp Datacenter AD site in the `fabrikam.com` domain, would have the path **Configuration > CN=Configuration,DC=Fabrikam,DC=com > CN=Sites > CN=Corp Datacenter > CN=Servers > CN=FABRIKAMDC01**.

1. Right-click the **CN=NTDS Settings** object for the server you want to check, and then select **Properties**.

1. Find the **msDS-JetDBPageSize** attribute in the attributes list. The value is the page database size capability. A value of `32768` means it's a 32k page database capable domain controller. A value of `8192` means an 8k page database size. No value means the domain controller is running Windows Server 2022 or earlier.

> [!IMPORTANT]
> When you see 8192 for a Windows Server 2025 Domain Dontroller, the reason may be that it was in-place upgraded from an older Version of Windows. In this case, the database is taken from the earlier version of Windows and is not prepared to run with 32KB database pages.


### [PowerShell](#tab/PowerShell)

To verify the page database size of a domain controller using PowerShell, follow these steps.

1. Sign on to a computer with the AD DS Remote Server Administration Tools (RSAT) installed.

1. Run the following PowerShell command to verify the page database size on a domain controller. Replace the values for the `SearchBase` parameter with your own values.

   ```powershell
   Get-ADObject -LDAPFilter "(ObjectClass=nTDSDSA)" -SearchBase "CN=Configuration,DC=fabrikam,DC=com" -properties msDS-JetDBPageSize | FL distinguishedName,msDs-JetDBPageSize
   ```

The output shows the distinguished name of the NTDS Settings object and the `msDS-JetDBPageSize` attribute. A value of `32768` means it's a 32k page database capable DC. `8192` means an 8k page database size. No value means the domain controller is running Windows Server 2022 or earlier. The following out is an example of a 32k page capable domain controller.

```Output
distinguishedName  : CN=NTDS Settings,CN=FABRIKAMDC01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,D
                     C=fabrikam,DC=com
msDs-JetDBPageSize : 32768
```

---

## Enable the Database 32k pages optional feature

The 32k page database size is an optional feature in AD and isn't enabled by default. To enable the Database 32k pages optional feature in your forest or domain, follow the steps.

1. Sign in to a domain controller.

1. Open an elevated PowerShell prompt.

1. Run the following command to enable the Database 32k pages optional feature. In this example, the command enables this feature for the device named `FABRIKAMDC01` in the `fabrikam.com` domain. Make sure to replace the values for the `Server` and `Target` parameters with your own values.

   ```powershell
   $params = @{
       Identity = 'Database 32k pages feature'
       Scope = 'ForestOrConfigurationSet'
       Server = 'FABRIKAMDC01'
       Target = 'fabrikam.com'
   }
   Enable-ADOptionalFeature @params
   ```

1. When you run the command, you're prompted to confirm the action. Enter **Yes** or **Yes to All** to proceed. An example of the output is shown in the following image.

   :::image type="content" source="media/enable-32k-pages-optional-feature/powershell-output.png" alt-text="A screenshot showing the output of the command Enable-ADOptionalFeature." lightbox="media/enable-32k-pages-optional-feature/powershell-output.png":::

1. After the Database 32k pages optional feature is enabled, monitor the replication traffic after the change.

The Database 32k pages optional feature in Active Directory Domain Services is now enabled.

---
title: Configure OSConfig security for Windows Server 2025 (preview)
description: Learn how to deploy OSConfig security baselines to enforce granular security settings to better protect and harden your Windows Server 2025 environment.
ms.topic: how-to
ms.product: windows-server
ms.author: roharwoo
author: xelu86
ms.contributor: Dona Mukherjee, Carlos Mayol Berral
ms.date: 10/09/2024
---

# Deploy OSConfig security baselines locally

OSConfig is a security configuration stack that uses a scenario-based approach to deliver and apply desired security measures for your environment. It provides co-management support for both on-premises and Azure Arc-connected devices. You can use Windows PowerShell or Windows Admin Center to apply the security baselines throughout the device life cycle, starting from the initial deployment process.

## Prerequisites

Make sure that your device is running Windows Server 2025. OSConfig doesn't support earlier versions of Windows Server.

## Install the OSConfig PowerShell module

Before you can apply a security baseline for the first time, you need to install the OSConfig module via an elevated PowerShell window:

1. Select **Start**, type **PowerShell**, hover over **Windows PowerShell**, and select **Run as administrator**.

1. Run the following command to install the OSConfig module:

   ```powershell
   Install-Module -Name Microsoft.OSConfig -Scope AllUsers -Repository PSGallery -Force
   ```

   If you're prompted to install or update the NuGet provider, select **Yes**.

1. To verify that the OSConfig module is installed, run the following command:

   ```powershell
   Get-Module -ListAvailable -Name Microsoft.OSConfig
   ```

## Manage OSConfig security baselines

Apply the appropriate security baselines, based on the Windows Server role of your device:

- Domain controller (DC)
- Member server
- Workgroup member

> [!NOTE]
> For Azure Arc-connected devices, you can apply the security baselines before or after connecting.

To apply a baseline, verify that the baseline is applied, remove a baseline, or view detailed compliance information for OSConfig in PowerShell, use the commands on the following tabs.

# [Configure](#tab/configure)

To apply the baseline for a domain-joined device, run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer -Default
```

To apply the baseline for a device that's in a workgroup, run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember -Default
```

To apply the baseline for a device that's configured as the DC, run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController -Default
```

To apply the secured-core baseline for a device, run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario SecuredCore -Default
```

To apply the Microsoft Defender Antivirus baseline for a device, run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario Defender/Antivirus -Default
```

# [Verify](#tab/verify)

To verify that the baseline for a domain-joined device is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer
```

To verify that the baseline for a device that's in a workgroup is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember
```

To verify that the baseline for a device that's configured as the DC is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController
```

To verify that the secured-core baseline for a device is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecuredCore
```

To verify that the Microsoft Defender Antivirus baseline for a device is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario Defender/Antivirus
```

# [Remove](#tab/remove)

To remove the baseline for a domain-joined device, run the following command:

```powershell
Remove-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer
```

To remove the baseline for a device that's in a workgroup, run the following command:

```powershell
Remove-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember
```

To remove the baseline for a device that's configured as the DC, run the following command:

```powershell
Remove-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController
```

To remove the secured-core baseline for a device, run the following command:

```powershell
Remove-OSConfigDesiredConfiguration -Scenario SecuredCore
```

To remove the Microsoft Defender Antivirus baseline for a device, run the following command:

```powershell
Remove-OSConfigDesiredConfiguration -Scenario Defender/Antivirus
```

# [Check compliance](#tab/compliance-check)

To obtain the desired configuration details for the specified scenario, use the following commands. The output appears in a table format that includes the name of the configuration item, its compliance status, and the reason for noncompliance.

To check the compliance details for a domain-joined device, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap
```

To check the compliance details for a workgroup device, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap
```

To check the compliance details for the DC baseline, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap
```

To check the compliance details for the secured-core baseline, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecuredCore | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap
```

To check the compliance details for the Microsoft Defender Antivirus baseline, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario Defender/Antivirus | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap 
```

---

> [!NOTE]
>
> - When you *apply* or *remove* a security baseline, a restart is required for changes to take effect.
>
> - When you *customize* a security baseline, a restart is required for changes to take effect, depending on which security features you modified.
>
> - During the *removal* process, when security settings are reverted, changing these settings back to their premanaged configuration isn't guaranteed. It depends on the specific settings within the security baseline. This behavior aligns with the capabilities that the Microsoft Intune policies provide. To learn more, see [Manage security baseline profiles in Microsoft Intune](/mem/intune/protect/security-baselines-configure).

## Customize OSConfig security baselines

After you complete the security baseline configuration, you can modify the security settings while maintaining drift control. Customizing the security values allows for more control of your organization's security policies, depending on your environment's specific needs. OSConfig accepts only numerical values.

To edit the default value of `AuditDetailedFileShare` from `2` to `3` for your member server, run the following command:

```powershell
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer -Setting AuditDetailedFileShare -Value 3 
```

To verify that the new value is applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer -Setting AuditDetailedFileShare 
```

> [!NOTE]
> Depending on which security settings are customized, certain user input is expected. These inputs are:
>
> - `MessageTextUserLogon`
> - `MessageTextUserLogonTitle`
> - `RenameAdministratorAccount`
> - `RenameGuestAccount`
>
> After you provide the necessary input, select the Enter key to proceed.

## Related content

- [Configure App Control for Business with OSConfig](osconfig-how-to-configure-app-control-for-business.md)

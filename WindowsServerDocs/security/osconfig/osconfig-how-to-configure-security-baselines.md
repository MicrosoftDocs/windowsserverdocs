---
title: How to configure OSConfig security for Windows Server 2025 (preview)
description: Learn how to deploy OSConfig security baselines to enforce granular security settings to better protect and harden your Windows Server 2025 environment.
ms.topic: how-to
ms.product: windows-server
ms.author: roharwoo
author: xelu86
ms.contributor: Dona Mukherjee, Carlos Mayol Berral
ms.date: 10/09/2024
---

# How to deploy OSConfig security baselines locally

OSConfig is a security configuration stack that utilizes a scenario-based approach to deliver and apply desired security measures for your environment. It provides co-management support for both on-premises and Arc-connected devices. Users can use PowerShell or Windows Admin Center (WAC) to apply the security baseline throughout the device lifecycle starting from the initial deployment process.

## Prerequisites

- Your device must be running Windows Server 2025. Earlier versions of Windows Server aren't supported.
- The appropriate security baselines must be applied based on the Windows Server Role of your device:
  - Domain Controller (DC)
  - Member Server
  - Workgroup Member
- The OSConfig PowerShell module must be installed.

> [!NOTE]
> For Arc-connected devices, the security baselines can be applied before or after connecting.

## Install the OSConfig PowerShell module

Before you can apply the security baseline for the first time, the OSConfig module needs to be installed via an elevated PowerShell window by performing the following steps:

1. Select **Start**, type **PowerShell**, hover over **Windows PowerShell** and select **Run as administrator**.

1. Run the following command to install the OSConfig module:

   ```powershell
   Install-Module -Name Microsoft.OSConfig -Scope AllUsers -Repository PSGallery -Force
   ```

   You might be prompted to install or update the **NuGet** provider. Select **Yes** to proceed.

1. To verify if the OSConfig module is installed, run the following command:

   ```powershell
   Get-Module -ListAvailable -Name Microsoft.OSConfig
   ```

## Manage OSConfig security baselines

To configure, verify if the baseline is applied, remove a baseline, and view detailed compliance information for OSConfig in PowerShell, follow these steps.

# [Configure](#tab/configure)

To apply the baseline for a device that's domain-joined, run the following command:

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

To verify if the baseline for a device that's domain-joined is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer
```

To verify if the baseline for a device that's in a workgroup is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember
```

To verify if the baseline for a device that's configured as the DC is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController
```

To verify if the secured-core baseline for a device is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecuredCore
```

To verify if the Microsoft Defender Antivirus baseline for a device is properly applied, run the following command:

```powershell
Get-OSConfigDesiredConfiguration -Scenario Defender/Antivirus
```

# [Remove](#tab/remove)

To remove the baseline for a device that's domain-joined, run the following command:

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

# [Compliance Check](#tab/compliance-check)

To obtain the desired configuration details for the specified scenario, use the following commands. The output is presented in a table format that includes the name of the configuration item, its compliance status, and the reason for non-compliance.

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
> - When users **configure** or **remove** a security baseline, a reboot is required for changes to take effect.
>
> - When users **customize** a security baseline, a reboot is required for changes to take effect depending on which security features were modified.
>
> - During the **removal** process where security settings are reverted, changing these settings back to their pre-managed configuration isn't guaranteed as this depends on the specific settings within the security baseline. This aligns with the capabilities provided by the Microsoft Intune policies. To learn more, see [Manage security baseline profiles in Microsoft Intune](/mem/intune/protect/security-baselines-configure).

## Customize OSConfig security baselines

After completing the security baseline configuration, you can modify the security settings while maintaining drift control. Customizing the security values allow for more control of your organization's security policies depending on your environment's specific needs. Only numerical values are accepted.

To edit the default value of **AuditDetailedFileShare** from **2** to **3** for your Member Server, run the following command:

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
> - MessageTextUserLogon
> - MessageTextUserLogonTitle
> - RenameAdministratorAccount
> - RenameGuestAccount
>
> After providing the necessary input, press **Enter** to proceed.

## See also

- [How to configure App Control for Business with OSConfig](osconfig-how-to-configure-app-control-for-business.md)

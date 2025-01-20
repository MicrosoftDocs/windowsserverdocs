---
title: Configure security baselines for Windows Server 2025
description: Learn how to deploy security baselines using OSConfig to enforce granular security settings to better protect and harden your Windows Server 2025 environment.
ms.topic: how-to
ms.product: windows-server
ms.author: alalve
author: xelu86
ms.contributor: Dona Mukherjee, Carlos Mayol Berral
ms.date: 12/12/2024
---

# Deploy Windows Server 2025 security baselines locally with OSConfig

Deploying the Windows Server 2025 security baseline to your environment ensures that desired security measures are in place, providing a comprehensive and standardized security framework. The Windows Server 2025 baseline includes over 300 security settings to ensure that it meets industry-standard security requirements. It also provides co-management support for both on-premises and Azure Arc-connected devices. The security baselines can be configured through PowerShell, Windows Admin Center, and Azure Policy. The OSConfig tool is a security configuration stack that uses a scenario-based approach to deliver and apply the desired security measures for your environment. The security baselines throughout the device life cycle can be applied using OSConfig starting from the initial deployment process.

Some of the highlights of the security baselines provide the following enforcements:

- Secured-Core: UEFI MAT, Secure Boot, Signed Boot Chain​
- Protocols: TLS Enforced 1.2+, SMB 3.0+, Kerberos AES
- Credential protection: LSASS/PPL
- Account and password policies​
- Security policies and security options ​

You can get the full list of the settings for the security baselines on [GitHub](https://github.com/microsoft/osconfig/tree/main/security).

## Evaluation guidance

For at-scale operations, use Azure Policy and Azure Automanage Machine Configuration to monitor and see your compliance score.

> [!IMPORTANT]
> After applying the security baseline, your system's security setting will change along with default behaviors. Test carefully before applying these changes in production environments.
>
> You'll be asked to change your local administrator password after applying the security baseline for Member server and Workgroup member scenarios.

Below you can find a list of more noticeable changes after the baselines are applied:

- The local administrator password must be changed. The new password policy must meet the complexity requirements and minimum length of 14-characters. This rule only applies to local user accounts; when signing in with a domain account, domain requirements prevail for domain accounts.
- TLS connections are subject to a minimum of TLS/DTLS 1.2 or higher, which may prevent connections to older systems.
- The ability to copy and paste files from RDP sessions is disabled. If you need to use this function, run the following command and then reboot your device:

  ```powershell
  Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/<ServerRoleBeingApplied> -Name RemoteDesktopServicesDoNotAllowDriveRedirection -Value 0
  ```

- Connections are subject to SMB 3.0 minimum or higher as connecting to non-windows systems, such as Linux SAMBA, must support SMB 3.0, or adjustments to the baseline are needed.
- If you're currently configuring the same settings with two different methods, one being OSConfig, conflicts are expected. Especially with drift control involved as you must remove one of the sources if the parameters are different to prevent the settings from constantly changing between sources.
- You might run into SID translation errors in specific domain configurations. It doesn't impact the rest of the security baseline definition and can be ignored.

## Prerequisites

Your device must be running Windows Server 2025. OSConfig doesn't support earlier versions of Windows Server.

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

## Manage Windows Server 2025 security baselines

Apply the appropriate security baselines based on the Windows Server role of your device:

- Domain controller (DC)
- Member server (domain-joined)
- Workgroup member server (non domain-joined)

The baseline experience is powered by OSConfig. Once applied, your security baseline settings are protected from any drift automatically, which is one of the key features of its security platform.

> [!NOTE]
> For Azure Arc-connected devices, you can apply the security baselines before or after connecting. But if the role of your server changes after the connection, you must delete and reapply the assignment to make sure that the machine configuration platform can detect the role change. For more information about deleting an assignment, see [Deletion of guest assignments from Azure Policy](/azure/governance/machine-configuration/concepts/assignments#deletion-of-guest-assignments-from-azure-policy).

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
> - During the *removal* process, when security settings are reverted, changing these settings back to their premanaged configuration isn't guaranteed. It depends on the specific settings within the security baseline. This behavior aligns with the capabilities that the Microsoft Intune policies provide. To learn more, see [Remove a security baseline assignment](/mem/intune/protect/security-baselines-configure#remove-a-security-baseline-assignment).

## Customize Windows Server 2025 security baselines

After you complete the security baseline configuration, you can modify the security settings while maintaining drift control. Customizing the security values allows for more control of your organization's security policies, depending on your environment's specific needs.

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
> After you provide the necessary input, select the **Enter** key to proceed.

## Provide feedback for OSConfig

If you're blocked or experiencing a work disruption after applying the security baseline, file a bug using the [Feedback Hub](https://aka.ms/feedbackhub). To learn more about submitting feedback, see [Deeper look at feedback](/windows-insider/feedback).

Provide us **OSConfig security baseline** as the feedback title. Under **Choose a category**, select **Windows Server** from the drop-down list, then select **Management** from the secondary drop-down list and proceed with submitting your feedback.

## Related content

- [Configure App Control for Business with OSConfig](osconfig-how-to-configure-app-control-for-business.md)

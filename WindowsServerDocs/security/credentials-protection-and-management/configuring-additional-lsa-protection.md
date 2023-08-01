---
title: Configuring Additional LSA Protection
description: Learn how to configure additional protection for the Local Security Authority (LSA) process to prevent code injection that could compromise credentials.
ms.topic: article
ms.assetid: 038e7c2b-c032-491f-8727-6f3f01116ef9
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 9/29/2022
---
# Configuring Additional LSA Protection

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This article for the IT professional explains how to configure additional protection for the Local Security Authority (LSA) process to prevent code injection that could compromise credentials.

The LSA, which includes the Local Security Authority Server Service (LSASS) process, validates users for local and remote sign-ins and enforces local security policies. The Windows 8.1 operating system and later provides additional protection for the LSA to prevent reading memory and code injection by non-protected processes. This feature provides added security for the credentials that LSA stores and manages. The protected process setting for LSA can be configured in Windows 8.1 and later. When this setting is used with UEFI lock and Secure Boot, additional protection is achieved because disabling the HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa registry key has no effect.

## Protected process requirements for plug-ins or drivers

For an LSA plug-in or driver to successfully load as a protected process, it must meet the following criteria:

1. Signature verification

    Protected mode requires that any plug-in that is loaded into the LSA is digitally signed with a Microsoft signature. Therefore, any plug-ins that are unsigned or aren't signed with a Microsoft signature will fail to load in LSA. Examples of these plug-ins are smart card drivers, cryptographic plug-ins, and password filters.

    LSA plug-ins that are drivers, such as smart card drivers, need to be signed by using the WHQL Certification. For more information, see [WHQL Release Signature](/windows-hardware/drivers/install/whql-release-signature).

    LSA plug-ins that don't have a WHQL Certification process, must be signed by using the [file signing service for LSA](/windows-hardware/drivers/dashboard/).
    
    It is not sufficient for the module to be signed by a private certification authority. It needs to be signed by Microsoft via the above partner program.

2. Adherence to the Microsoft Security Development Lifecycle (SDL) process guidance

    All of the plug-ins must conform to the applicable SDL process guidance. For more information, see the [Microsoft Security Development Lifecycle (SDL) Appendix](/previous-versions/windows/desktop/cc307891(v=msdn.10)).

    Even if the plug-ins are properly signed with a Microsoft signature, non-compliance with the SDL process can result in failure to load a plug-in.

### Recommended practices

Use the following list to thoroughly test that LSA protection is enabled before you broadly deploy the feature:

- Identify all of the LSA plug-ins and drivers that are in use within your organization. Include non-Microsoft drivers or plug-ins such as smart card drivers and cryptographic plug-ins, and any internally developed software that is used to enforce password filters or password change notifications.
- Ensure that all of the LSA plug-ins are digitally signed with a Microsoft certificate so that the plug-in won't fail to load.
- Ensure that all of the correctly signed plug-ins can successfully load into LSA and that they perform as expected.
- Use the audit logs to identify LSA plug-ins and drivers that fail to run as a protected process.

### Limitations introduced with enabled LSA protection

If additional LSA protection is enabled, you can't debug a custom LSA plugin. You can't attach a debugger to LSASS when it's a protected process. In general, there's no supported way to debug a running protected process.

## Auditing to identify LSA plug-ins and drivers that fail to run as a protected process

You can use the audit mode to identify LSA plug-ins and drivers that will fail to load in LSA Protection mode. While in the audit mode, the system will generate event logs, identifying all of the plug-ins and drivers that will fail to load under LSA if LSA Protection is enabled. The messages are logged without blocking the plug-ins or drivers.

The events described in this section are located in the Operational log under Applications and Services Logs\Microsoft\Windows\CodeIntegrity. They can help you identify LSA plug-ins and drivers that are failing to load due to signing reasons. To manage these events, you can use the **wevtutil** command-line tool. For information about this tool, see [Wevtutil](../../administration/windows-commands/Wevtutil.md).

> [!IMPORTANT]
>Audit events will not be generated if [Smart App Control](https://support.microsoft.com/topic/what-is-smart-app-control-285ea03d-fa88-4d56-882e-6698afdb7003) is enabled on a device. To check or change the enablement state of Smart App Control, open the Windows Security Application and go to the App & browser control page. Select the Smart App Control settings link to check the enablement state and change the configuration to Off if you are trying to audit additional LSA protection.

### Automatic enablement of Audit mode

Audit mode for additional LSA protection is enabled by default on devices running **Windows 11, 22H2**. If your device is running this build, no additional actions are needed to audit additional LSA protection.

### Enable the audit mode for Lsass.exe on a single computer by editing the Registry

1. Open the Registry Editor (RegEdit.exe), and navigate to the registry key that is located at: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LSASS.exe.

2. Set the value of the registry key to **AuditLevel=dword:00000008**.

3. Restart the computer.

Analyze the results of event 3065 and event 3066.

After these steps, you may see these events in Event Viewer in Applications and Services Logs/Microsoft/Windows/CodeIntegrity:

- **Event 3065**: This event records that a code integrity check determined that a process (usually lsass.exe) attempted to load a particular driver that did not meet the security requirements for Shared Sections. However, due to the system policy that is set, the image was allowed to load.

- **Event 3066**: This event records that a code integrity check determined that a process (usually lsass.exe) attempted to load a particular driver that did not meet the Microsoft signing level requirements. However, due to the system policy that is set, the image was allowed to load.

> [!IMPORTANT]
> These operational events are not generated when a kernel debugger is attached and enabled on a system.
>
> If a plug-in or driver contains Shared Sections, Event 3066 is logged with Event 3065. Removing the Shared Sections should prevent both the events from occurring unless the plug-in does not meet the Microsoft signing level requirements.

To enable audit mode for multiple computers in a domain, you can use the Registry Client-Side Extension for Group Policy to deploy the Lsass.exe audit-level registry value. You need to modify HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LSASS.exe registry key.

#### How to create the AuditLevel value setting in a GPO

1. Open the Group Policy Management Console (GPMC).

2. Create a new Group Policy Object (GPO) that is linked at the domain level or that is linked to the organizational unit that contains your computer accounts. Or you can select a GPO that is already deployed.

3. Right-click the GPO, and then select **Edit** to open the Group Policy Management Editor.

4. Expand **Computer Configuration**, expand **Preferences**, and then expand **Windows Settings**.

5. Right-click **Registry**, point to **New**, and then select **Registry Item**. The **New Registry Properties** dialog box appears.

6. In the **Hive** list, select **HKEY_LOCAL_MACHINE.**

7. In the **Key Path** list, browse to **SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LSASS.exe**.

8. In the **Value name** box, type **AuditLevel**.

9. In the **Value type** box, select **REG_DWORD**.

10. In the **Value data** box, type **00000008**.

11. Select **OK**.

> [!NOTE]
> For the GPO take effect, the GPO change must be replicated to all domain controllers in the domain.

To opt in for additional LSA protection on multiple computers, you can use the Registry Client-Side Extension for Group Policy by modifying HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa. For instructions, see [How to configure additional LSA protection of credentials](#BKMK_HowToConfigure) in this article.

### After opting in: How to identify plug-ins and drivers loaded by the lsass.exe

You can use the event log to identify LSA plug-ins and drivers that failed to load in LSA protection mode. When the LSA protected process is enabled, the system generates event logs that identify all of the plug-ins and drivers that failed to load under LSA.

You may see these events in Event Viewer: Microsoft-Windows-Codeintegrity/Operational:

- **Event 3033**: This event records that a code integrity check determined that a process (usually lsass.exe) attempted to load a driver that did not meet the Microsoft signing level requirements.

- **Event 3063**: This event records that a code integrity check determined that a process (usually lsass.exe) attempted to load a driver that did not meet the security requirements for Shared Sections.

Shared Sections are typically the result of programming techniques that allow instance data to interact with other processes that use the same security context. This can create security vulnerabilities.

## <a name="BKMK_HowToConfigure"></a>How to configure additional LSA protection of credentials

On devices running Windows 8.1 or later, configuration is possible by performing the procedures described in this section.

### On x86-based or x64-based devices using Secure Boot and UEFI or not

On x86-based or x64-based devices that use Secure Boot or UEFI, a UEFI variable can be set in the UEFI firmware when LSA protection is enabled by using registry key or policy. When the setting is stored in the firmware, the UEFI variable can't be deleted or changed by modifying the registry or by policy used to enable additional LSA protection. The UEFI variable must be reset using the instructions below on how to [disable LSA protection](#how-to-disable-lsa-protection).

x86-based or x64-based devices that don't support UEFI or where Secure Boot are disabled can't store the configuration for LSA protection in the firmware. These devices rely solely on the presence of the registry key. In this scenario, it's possible to disable LSA protection by using remote access to the device. Disablement of LSA protection won't take effect until the device reboots.

### Automatic Enablement

For devices running Windows RT 8.1, additional LSA protection is always enabled, and it can't be turned off.

For client devices running Windows 11, 22H2, additional LSA protection will be enabled by default if the following criteria are met:

- The device is a new install of Windows 11, 22H2 (not upgraded from previous release).
- The device is enterprise joined (Active Directory domain joined, Azure AD domain joined, or hybrid Azure AD domain joined).
- The device is capable of [Hypervisor-protected code integrity (HVCI)](/windows/security/threat-protection/device-guard/enable-virtualization-based-protection-of-code-integrity)

Automatic enablement of additional LSA protection on Windows 11, 22H2 doesn't set a UEFI variable for the feature. If you want to set a UEFI variable, you can use a registry configuration or policy.

### How to enable LSA protection on a single computer

#### Using the Registry

1. Open the Registry Editor (RegEdit.exe), and navigate to the registry key that is located at: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa.

1. Set the value of the registry key to:
    1. "RunAsPPL"=dword:00000001 to configure the feature with a UEFI variable.
    1. "RunAsPPL"=dword:00000002 to configure the feature without a UEFI variable (only on Windows 11, 22H2).

1. Restart the computer.

#### Using Local Group Policy on Windows 11, 22H2

1. Open Local Group Policy Editor (gpedit.msc)

1. Expand **Computer Configuration**, expand **Administrative Templates**, expand **System**, and then expand **Local Security Authority**.

1. Open the **Configure LSASS to run as a protected process** policy.

1. Set the policy to **Enabled**.

1. Under **Options**, set Configure LSA to run as a protected process to:
    1. "Enabled with UEFI Lock" to configure the feature with a UEFI variable.
    1. "Enabled without UEFI Lock" to configure the feature without a UEFI variable.

1. Restart the computer.

### How to enable LSA protection using Group Policy

1. Open the Group Policy Management Console (GPMC).

2. Create a new GPO that is linked at the domain level or that is linked to the organizational unit that contains your computer accounts. Or you can select a GPO that is already deployed.

3. Right-click the GPO, and then select **Edit** to open the Group Policy Management Editor.

4. Expand **Computer Configuration**, expand **Preferences**, and then expand **Windows Settings**.

5. Right-click **Registry**, point to **New**, and then select **Registry Item**. The **New Registry Properties** dialog box appears.

6. In the **Hive** list, select **HKEY_LOCAL_MACHINE**.

7. In the **Key Path** list, browse to **SYSTEM\CurrentControlSet\Control\Lsa**.

8. In the **Value name** box, type **RunAsPPL**.

9. In the **Value type** box, select **REG_DWORD**.

10. In the **Value data** box, type:
    1. **00000001** to enable LSA protection with a UEFI variable.
    1. **00000002** to enable LSA protection without a UEFI variable (only enforced on Windows 11, 22H2).

11. Select **OK**.

### How to disable LSA protection

#### How to disable using the Registry

1. Open the Registry Editor (RegEdit.exe), and navigate to the registry key that is located at: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa.

2. Set "RunAsPPL"=dword:00000000 or delete the DWORD.

3. If PPL was enabled with a UEFI variable, use the [Local Security Authority Protected Process Opt-out tool](#how-to-remove-the-lsa-protection-uefi-variable) to remove the UEFI variable.

4. Restart the computer.

#### How to disable using local policy on Windows 11, 22H2

Open Local Group Policy Editor (gpedit.msc)

1. Expand **Computer Configuration**, expand **Administrative Templates**, expand **System**, and then expand **Local Security Authority**.

1. Open the **Configure LSASS to run as a protected process** policy.

1. Set the policy to **Enabled**.

1. Under **Options**, set Configure LSA to "Disabled"

1. Restart the computer.

If you set this policy to **Not Configured** and the policy was previously enabled, the previous setting doesn't get cleaned up and will continue to be enforced. You must set the policy to **Disabled** under the **Configure LSA to run as a protected process** drop-down to disable the feature.

#### How to remove the LSA protection UEFI variable

Use the Local Security Authority (LSA) Protected Process Opt-out tool to delete the UEFI variable if the device is using Secure Boot.

For more information about the opt-out tool, see [Download Local Security Authority (LSA) Protected Process Opt-out from Official Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=40897).

For more information about managing Secure Boot, see [UEFI Firmware](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824898(v=win.10)).

> [!WARNING]
> When Secure Boot is turned off, all the Secure Boot and UEFI-related configurations are reset. You should turn off Secure Boot only when all other means to disable LSA protection have failed.

## Verifying LSA protection

To discover if LSA was started in protected mode when Windows started, search for the following WinInit event in the **System** log under **Windows Logs**:

- 12: LSASS.exe was started as a protected process with level: 4

## Additional resources

[Credentials Protection and Management](credentials-protection-and-management.md)

[File signing service for LSA](/windows-hardware/drivers/dashboard/)

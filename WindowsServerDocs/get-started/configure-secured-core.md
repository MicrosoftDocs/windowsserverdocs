---
title: Configure Secured-core server for Windows Server
description: Learn how to configure Secured-core server in Windows Server using the Windows Security app, Group Policy and Windows Admin Center.
author: robinharwood
ms.author: wscontent
ms.topic: how-to
ms.date: 05/26/2023
ms.custom: template-how-to-pattern
---

# Configure Secured-core server

Secured-core is a collection of capabilities that offers built-in hardware, firmware, driver and
operating system security features. This article shows you how to configure Secured-core server by
using Windows Admin Center and Windows PowerShell.

Secured-core server is designed to deliver a secure platform for critical data and applications. For
more information, see [What is Secured-core server?](../security/secured-core-server.md)

## Prerequisites

Before you can configure Secured-core server, you must have the following security components
installed and enabled in the BIOS:

- Secure Boot.
- Trusted Platform Module (TPM) 2.0.
- System fireware must enable Input/Output Memory Management Unit (IOMMU), known as Kernel DMA
  Protection . For example, Intel VT-D or AMD-Vi. To learn more about Kernel DMA Protection, see
  [Kernel DMA Protection (Memory Access Protection) for OEMs](/windows-hardware/design/device-experiences/oem-kernel-dma-protection).
- A processor with support enabled in the BIOS for:
  - Virtualization extensions.
  - Input/Output Memory Management Unit (IOMMU).
  - Dynamic Root of Trust for Measurement (DRTM).
  - Transparent Secure Memory Encryption is also required for AMD based systems.

> [!IMPORTANT]
> Enabling each of the security features in the BIOS can vary based on your hardware vendor. Make
> sure to check your hardware manufacturer's Secured-core server enablement guide.

You can find hardware certified for Secured-core server from the
[Windows Server Catalog](https://www.windowsservercatalog.com/), and Azure Stack HCI servers in the
[Azure Stack HCI Catalog](https://hcicatalog.azurewebsites.net/#/catalog?FeatureSupported=securedCoreServer).

## Enable security features

To configure Secured-core server you need to enable specific Windows Server security features,
select the relevant method and follow the steps.

#### [GUI](#tab/gui)

Here's how to enable Secured-core server using the user interface.

1. From the Windows desktop, open the **Start** menu, select **Windows Administrative Tools**, open
   **Computer Management**.
1. In Computer management, select **Device Manager**, resolve any device error if necessary.
   1. For AMD based systems, confirm the DRTM Boot Driver device is present before continuing
1. From Windows desktop, open the **Start** menu, select **Windows Security**.
1. Select **Device security > Core isolation details**, then enable **Memory Integrity** and
   **Firmware Protection**.
1. Restart your server when prompted.

Once your server has restarted, your server is enabled for Secured-core server.

#### [Windows Admin Center](#tab/WAC)

Here's how to enable Secured-core server using Windows Admin Center.

1. Sign into your Windows Admin Center portal.
1. Select the server you want to connect to.
1. Select **Security** using the left-hand panel, then select the **Secured-core** tab.
1. Check the Security Features with a status of _Not configured_, then select **Enable**.
1. When notified, select **Schedule system reboot** to persist the changes.
1. Select either the **Restart immediately** or **Schedule restart** at a time suitable for your
   workload.

Once your server has restarted, your server is enabled for Secured-core server.

#### [Group Policy](#tab/powershell)

Here's how to enable Secured-core server for domain members using Group Policy.

1. Open the **Group Policy Management Console**, create or edit a policy applied to your server.

1. In the console tree, select **Computer Configuration > Administrative Templates > System >
    Device Guard**.

1. For the setting, right-click **Turn On Virtualization Based Security** and select **Edit**.

1. Select **Enabled**, from the drop down menus select the following:

   1. Select **Secure Boot and DMA Protection** for the Platform Security Level.

   1. Select either **Enabled without lock** or  **Enabled with UEFI lock** for Virtualization Based Protect of Code Integrity.

   1. Select **Enabled** for the Secure Launch Configuration.

   > [!CAUTION]
   > If you use **Enabled with UEFI lock** for Virtualization Based Protect of Code Integrity, it
   > cannot be disabled remotely. To disable the feature, you must set the Group Policy to **Disabled**
   > as well as remove the security functionality from each computer, with a physically present user,
   > in order to clear configuration persisted in UEFI.

1. Select **OK** to complete the configuration.

1. Restart your server to apply the Group Policy.

Once your server has restarted, your server is enabled for Secured-core server.

---

## Verify Secured-core server configuration

Now you've configured Secured-core server, select the relevant method to verify your configuration.

#### [GUI](#tab/gui)

Here's how to verify your Secured-core server is configured using the user interface.

1. From the Windows desktop, open the **Start** menu, type `msinfo32.exe` to open System
   Information. From the System Summary page, confirm:
    1. **Secure Boot State** and **Kernel DMA Protection** is On.
    1. **Virtualization-based security** is Running.
    1. **Virtualization-based security Services** Running shows **Hypervisor enforced Code
       Integrity** and **Secure Launch**.

#### [Windows Admin Center](#tab/WAC)

Here's how to verify your Secured-core server is configured using Windows Admin Center.

1. Sign into your Windows Admin Center portal.
1. Select the server you want to connect to.
1. Select **Security** using the left-hand panel, then select the **Secured-core** tab.
1. Check the all Security Features have a status of _Configured_.

   :::image type="content" source="../security/media/Secured-core/windows-admin-center-server.png" alt-text="Screenshot showing the Windows Admin Center security extension in a browser window with Secured-core enabled." lightbox="media/Secured-core/windows-admin-center-server.png":::

#### [PowerShell](#tab/powershell)

Here's how to verify your Secured-core server is configured using the
[Confirm-SecureBootUEFI](/powershell/module/secureboot/confirm-securebootuefi) and
[Get-ComputerInfo](/powershell/module/microsoft.powershell.management/get-computerinfo) Windows
PowerShell commands.

1. Open an elevated PowerShell prompt.

1. To confirm SecureBoot is supported and enabled, run the following command from an elevated
   PowerShell prompt:

   ```powershell
   Confirm-SecureBootUEFI
   ```

1. Verify the output shows `True` to validate SecureBoot is supported and enabled.

1. To confirm Hypervisor enforced Code Integrity and DMA protection is configured and enabled, run
   the following command from an elevated PowerShell prompt:

   ```powershell
   Get-ComputerInfo | Select DeviceGuard* | Format-List
   ```

1. Verify the output shows `DMAProtection` in the available and required services. Also the values
   `HypervisorEnforcedCodeIntegrity` and `3` should be shown in the running services. Here's an example output.

   ```powershell
   DeviceGuardSmartStatus                                  : Off
   DeviceGuardRequiredSecurityProperties                   : {BaseVirtualizationSupport, SecureBoot, DMAProtection}
   DeviceGuardAvailableSecurityProperties                  : {BaseVirtualizationSupport, SecureBoot, DMAProtection, 5...}
   DeviceGuardSecurityServicesConfigured                   : {HypervisorEnforcedCodeIntegrity, 3}
   DeviceGuardSecurityServicesRunning                      : {HypervisorEnforcedCodeIntegrity, 3}
   DeviceGuardCodeIntegrityPolicyEnforcementStatus         : EnforcementMode
   DeviceGuardUserModeCodeIntegrityPolicyEnforcementStatus : Off
   ```

To learn more about the output values, see the [SecurityServicesRunning](/windows/security/threat-protection/device-guard/enable-virtualization-based-protection-of-code-integrity) article.

---

## Next steps

Now you've configured Secured-core server, here are some resources to learn more about:

- [Virtualization-based Security (VBS)](/windows-hardware/design/device-experiences/oem-vbs)
- [Memory integrity and VBS enablement](/windows-hardware/design/device-experiences/oem-hvci-enablement)
- [System Guard Secure Launch](/windows/security/threat-protection/windows-defender-system-guard/system-guard-secure-launch-and-smm-protection)

---
title: Kernel Mode Hardware-enforced Stack Protection
description: Learn how to enable stack protection, in order to prevent stacks from return-oriented programming-based attacks (ROP).
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 10/29/2024
---

# Kernel Mode Hardware-enforced Stack Protection

> Applies To: Windows Server 2025

The security feature **Hardware-enforced Stack Protection** was introduced to protect user mode processes and help prevent hijacking on the stack in Windows 10. Hardware-enforced Stack Protection now extends to **Kernel Mode**, which protects stacks in the kernel from return-oriented programming-based attacks (ROP). ROP is a common way for attackers to hijack the flow of a program's execution, and continue their attack chain to execute attacker desired code.

Now that user mode stacks are protected, and prevent return address modification from kernel mode code, attackers can't exploit memory safety vulnerabilities. Customers are already seeing how Kernel Mode Hardware-enforced Stack Protection prevents drivers associated with viruses and malware from executing their malicious payload.

**Kernel-mode Hardware-enforced Stack Protection** is off by default, but customers can turn it on if the prerequisites are met. This article provides more information about Kernel-mode Hardware-enforced Stack Protection, and shows how to enable the feature in the Windows Security App and via Group Policy.

## Prerequisites

- Windows 11 2022 update or newer
- Windows Security app version 1000.25330.0.9000 or newer
- Hardware that supports Intel Control-flow Enforcement Technology (CET) or AMD Shadow Stacks.
  - For Intel, 11th Gen Intel Core Mobile processors and AMD Zen 3 Core (and newer).
- Virtualization-based security (VBS) and Hypervisor-enforced code integrity (HVCI) are enabled.

## Use shadow stacks to enforce integrity of control flow

With Kernel-mode Hardware-enforced Stack Protection, all kernel stacks have a corresponding shadow stack to enforce the integrity of its control flow. If attackers exploit a memory safety vulnerability, their next step is to redirect control flow of a program to an attacker's desired location.

Shadow stacks prevent control-flow hijacking. Windows uses Control Flow Guard to enforce integrity on indirect calls, and Hardware-enforced Stack Protection to enforce integrity on returns in order to protect against exploits which aim to redirect the flow of a program's execution. Control Flow Guard utilizes a bitmap to annotate valid jump targets, to prevent a compromised indirect call from redirecting control flow to arbitrary locations.

Shadow stack maintains a (hardware protected) secondary stack for all call stacks, and whenever a CALL or RET instruction pushes or pops a value onto the stack, a corresponding entry lives in the shadow stack. When a return address mismatch occurs, the system triggers a blue screen to prevent unintended program control behavior.

For more information, see the blog post on [Understanding Hardware-enforced Stack Protection](https://techcommunity.microsoft.com/t5/windows-os-platform-blog/understanding-hardware-enforced-stack-protection/ba-p/1247815).

## Enable Kernel-mode Hardware-enforced Stack Protection in Windows Security

Virtualization-Based Security (VBS) and Hypervisor-enforced Code Integrity (HVCI) are prerequisites for Kernel-mode Hardware-enforced Stack Protection, you must first ensure that these features are enabled before continuing. They are autoenabled on Windows systems that [meet minimum hardware requirements](/windows-hardware/design/device-experiences/oem-hvci-enablement).

Enable VBS and HVCI with the following steps:

1. Open the **Windows Security** app.

1. Navigate to **Device Security > Core isolation details > Memory integrity**.

1. Toggle the feature **On**.

1. After making this change, you need to restart your device.

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/memory-integrity-toggle.png" border="true" alt-text="Screenshot of the toggle to turn memory integrity on or off.":::

### Turn on Kernel-mode Hardware-enforced Stack Protection

1. Open the **Windows Security** app.

1. Navigate to **Device Security > Core isolation details > Kernel-mode Hardware-enforced Stack Protection**.

1. Toggle the feature **On**.

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/kernel-mode-hardware-enforced-stack-protection-toggle.png" border="true" alt-text="Screenshot of the toggle to turn Kernel-mode Hardware-enforced Stack Protection on or off.":::

## Enable Kernel-mode Hardware-enforced Stack Protection in the Local Group Policy Editor

For enterprise customers, Kernel-mode Hardware-enforced Stack Protection can be enabled using Group Policy.

1. Open the Local Group Policy Editor.

1. Navigate to **Computer Configuration > Administrative Templates > System > Device Guard > Turn on Virtualization Based Security**.

1. Confirm that Virtualization Based Security is **Enabled**.

1. Under **Options** find **Kernel-mode Hardware-enforced Stack Protection**. Select **Enabled in enforcement mode**.

1. Select **Apply**. Then **OK**.

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/enable-kernel-mode-hardware-enforced-stack-protection.png" border="true" alt-text="Screenshot of where to enable Kernel-mode Hardware-enforced Stack Protection using Group Policy.":::

## Incompatible drivers

There's a small set of drivers that aren't yet compatible. Drivers that exhibit potentially malicious behavior like hijacking return addresses to get around control flow policies aren't compatible, and are added to the vulnerable driver blocklist for kernel-mode hardware-enforced stack protection. After working with driver vendors to perform code obfuscation in a shadow stack compliant way, those drivers are allowed.

To provide good user experience and avoid machine blue screens, Windows maintains a known-incompatible driver blocklist for kernel-mode hardware-enforced stack protection. These are drivers that are known to hijack return addresses in the kernel. When this feature is turned on, the driver isn’t allowed to load (as opposed to a blue screen when a return address hijack is attempted). Additionally, if the system already has a driver installed on the blocklist, this feature fails to enable. You can enable this feature by uninstalling the associated driver.

### Review incompatible drivers

The feature can't be enabled until the incompatibilities are resolved, either with an updated version from the driver vendor or by removing the application that installed the driver. To see the list of incompatible drivers, select "Review incompatible drivers".  

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/incompatible-drivers-list.png" border="true" alt-text="Screenshot of where to find any possible incompatible drivers.":::

Certain apps use drivers that are incompatible with Kernel-mode Hardware-enforced Stack Protection. For example, apps that use obfuscation engines to protect IP and obfuscate control flow, which are incompatible with shadow stacks. When the insecure driver attempts to load with this security feature enabled, you see a prompt saying "A driver cannot load on this device".

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/driver-can-not-load.png" border="true" alt-text="Screenshot of driver can't load alert dialog.":::

 You can optionally disable the security feature, although doing so downgrades the security of your device. You can always re-enable this feature in the Windows Security application.

## Related content

- [Understanding Hardware-enforced Stack Protection](https://techcommunity.microsoft.com/t5/windows-os-platform-blog/understanding-hardware-enforced-stack-protection/ba-p/1247815)
- [Developer Guidance for Hardware-enforced Stack Protection](https://techcommunity.microsoft.com/t5/windows-os-platform-blog/developer-guidance-for-hardware-enforced-stack-protection/ba-p/2163340)
- [Enable virtualization-based protection of code integrity](/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity)
- [Memory integrity and VBS enablement](/windows-hardware/design/device-experiences/oem-hvci-enablement)

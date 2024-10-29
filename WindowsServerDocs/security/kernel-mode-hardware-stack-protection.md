---
title: Kernel Mode Hardware-enforced Stack Protection
description: Learn how to enable stack protection, in order to prevent stacks from return-oriented programming-based attacks (ROP).
ms.topic: how-to
author: meaghanlewis
ms.author: wscontent
ms.date: 10/28/2024
---

# Kernel Mode Hardware-enforced Stack Protection

> Applies To: Windows Server 2025

In Windows 10, the security feature **Hardware-enforced Stack Protection** was introduced to protect user mode processes and help prevent hijacking on the stack. Hardware-enforced Stack Protection now extends to Kernel Mode, which protects stacks in the kernel from return-oriented programming-based attacks (ROP). ROP is a common way for attackers to hijack the flow of a program's execution, and continue their attack chain to execute attacker desired code. ROP based attacks have become a common form of attack.

Now that user mode stacks are protected, and prevent return address modification from kernel mode code, attackers can no longer weaponize memory safety vulnerabilities. We've already seen cases on customer devices where this security feature prevents drivers associated witrh viruses and malware from executing their malicious payload.

## Prerequisites

- Windows 11 2022 update or newer
- Windows Security App version 1000.25330.0.9000 or newer
- Hardware that supports Intel Control-flow Enforcement Technology (CET) or AMD Shadow Stacks.
  - For Intel, 11th Gen Intel Core Mobile processors and AMD Zen 3 Core (and newer).
- Virtualization-based security (VBS) and Hypervisor-enforced code integrity are auto-enabled (HVCI), which are auto-enabled on windows systems that [meet minimum hardware requirements](/windows-hardware/design/device-experiences/oem-hvci-enablement).

## Use shadow stacks to enforce integrity of control flow

With Kernel-mode Hardware-enforced Stack Protection, all kernel stacks have a corresponding shadow stack to enforce the integrity of its control flow. If attackers exploit a memory safety vulnerability, their next step is to redirect control flow of a program to an attacker's desired location.

Shadow stacks prevent control-flow hijacking. Windows uses Control FLow Guard to enforce integirty on indirect calls and Hardware-enforced Stack Protection to enforce integrity on returns, to protect against exploits which aim to redirect the flow of a program's execution. Control Flow Guard utilizes a bitmap to annotate valid jump targets, to prevent a compromised indirect call from redirecting control flow to arbitrary locations.

Shadow stack maintains a (hardware protected) secondary stack for all call stacks, and whenever a CALL or RET instruction pushes or pops a value onto the stack, a corresponding entry will live in the shadow stack. When a return address mismatch occurs, the system triggers a blue screen to prevent unintended program control behavior.

For more information, see the blog post on [Understanding Hardware-enforced Stack Protection](https://techcommunity.microsoft.com/t5/windows-os-platform-blog/understanding-hardware-enforced-stack-protection/ba-p/1247815).

Kernel-mode Hardware-enforced Stack Protection is off by default, but customers can turn it on in the Windows Security App, and via Group Policy if their system meets the prerequisites.

## Incompatible drivers

There are a small set of drivers that aren't yet compatible. Drivers that exhibit potentially malicious behavior like hijacking return addresses to get around control flow policies are not compatible with this new feature and will be added to the vulnerable driver blocklist for kernel-mode hardware-enforced stack protection. After working with driver vendors to perform code obfuscation in a shadow stack compliant way, those drivers will be allowed.

To provide good user experience and avoid machine blue screens, Windows maintains a known-incompatible driver blocklist for kernel-mode hardware-enforced stack protection. These are drivers that are known to hijack return addresses in the kernel. When this feature is turned on, the driver isn’t allowed to load (as opposed to a blue screen when a return address hijack is attempted). Additionally, if the system already has a driver installed on the block list, this feature fails to enable. You can enable this feature by uninstalling the associated driver.

## Enable Kernel-mode Hardware-enforced Stack Protection in the Windows Security App

Virtualization-Based Security (VBS) and Hypervisor-enforced Code Integrity (HVCI) are pre-requisites for Kernel-mode Hardware-enforced Stack Protection, you must first ensure that these features are enabled before continuing.

Enable VBS and HVCI by going to: **Windows Security > Device Security > Core isolation > Memory integrity**. Make sure Memory integrity is set to **On**. After making this change, you need to restart your device.

1. Open **Windows Security** app.

1. Navigate to **Device Security > Core isolation > Memory integrity**.

1. Toggle the feature **On**.

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/memory-integrity-toggle.png" border="true" alt-text="Screenshot of the toggle to turn memory integrity on or off.":::

### Turn on Kernel-mode Hardware-enforced Stack Protection

1. Open **Windows Security** app.

1. Navigate to **Device Security > Core isolation > Kernel-mode Hardware-enforced Stack Protection**.

1. Toggle the feature **On**.

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/kernel-mode-hardware-enforced-stack-protection-toggle.png" border="true" alt-text="Screenshot of the toggle to turn Kernel-mode Hardware-enforced Stack Protection on or off.":::

### Review incompatible drivers

If incompatible drivers are found on your system, the feature cannot be enabled until the incompatibilities are resolved, for instance by asking the driver vendor for an updated version or by removing the application that installed the driver. Select the "Review incompatible drivers" text to see the list of incompatible drivers:  

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/incompatible-drivers-list.png" border="true" alt-text="Screenshot of where to find any possible incompatible drivers.":::

If an incompatible driver attempts to load when this security feature is enabled, a prompt will be displayed. For example, certainly apps utilize obfuscation engines in order to protect IP and obfuscate control flow – which could be incompatible with shadow stacks.   When the associated driver is loaded, you will see the below prompt. You can optionally disable the security feature to continue using your scenario (i.e., play the game). Note that doing so will downgrade the security of your device.  You can always re-enable this feature in the Windows Security application.

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/driver-cannot-load.png" border="true" alt-text="Screenshot of driver cannot load alert dialog.":::

## Enable Kernel-mode Hardware-enforced Stack Protection via Group Policy

For enterprise customers, Kernel-mode Hardware-enforced Stack Protection can be enabled using Group Policy.

1. Open the Group Policy Editor.

1. Navigate to **Computer Configuration > Administrative Templates > System > Device Guard > Turn on Virtualization Based Security**.
1. Confirm that Virtualization Based Security is **Enabled**.
1. Under **Options** find **Kernel-mode Hardware-enforced Stack Protection**. Select **Enabled in enforcement mode**.

:::image type="content" source="./media/kernel-mode-hardware-stack-protection/enable-kernel-mode-hardware-enforced-stack-protection.png" border="true" alt-text="Screenshot of where to enable Kernel-mode Hardware-enforced Stack Protection using Group Policy.":::

## Next step or Related content

- [Understanding Hardware-enforced Stack Protection](https://techcommunity.microsoft.com/t5/windows-os-platform-blog/understanding-hardware-enforced-stack-protection/ba-p/1247815)
- [Developer Guidance for Hardware-enforced Stack Protection](windows-os-platform-blog/developer-guidance-for-hardware-enforced-stack-protection/ba-p/2163340)
- [Memory integrity and VBS enablement](/windows-hardware/design/device-experiences/oem-hvci-enablement)
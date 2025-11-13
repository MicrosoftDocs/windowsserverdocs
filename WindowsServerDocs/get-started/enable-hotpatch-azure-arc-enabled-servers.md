---
title: Enable Hotpatch for Azure Arc-enabled servers
description: Learn how to enable Hotpatch for Windows Server 2025 installations on Azure Arc-enabled servers.
ms.author: daknappe
ms.topic: how-to
author: dknappettmsft
ms.date: 10/30/2025
---

# Enable Hotpatch for Azure Arc-enabled servers

> [!IMPORTANT]
> Azure Arc-enabled Hotpatch for Windows Server 2025 is now available for a monthly subscription fee. To learn more about pricing, see [Tired of all the restarts? Get hotpatching for Windows Server](https://www.microsoft.com/en-us/windows-server/blog/2025/04/24/tired-of-all-the-restarts-get-hotpatching-for-windows-server/).

Hotpatch allows you to update your Windows Server installation without requiring your users to restart after installation. This feature minimizes downtime spent on updates and keeps your users running their workloads uninterrupted. For more information about how Hotpatch works, see [Hotpatch for Windows Server](hotpatch.md).

Windows Server 2025 features the ability to enable Hotpatch for Azure Arc-enabled servers. In order to use Hotpatch on Azure Arc-enabled servers, all you have to do is deploy the Connected Machine agent and enable Windows Server Hotpatch. This article describes how to enable Hotpatch.

## Prerequisites

Before you can enable Hotpatch on Arc-enabled servers for Windows Server 2025, you need to satisfy the following requirements.

- A server must be running Windows Server 2025 (build 26100.1742 or later). Preview versions or [Windows Server Insiders](/windows-server/get-started/get-started-with-windows-server-insiders-preview) builds aren't supported because hotpatches aren't created for prerelease operating systems.

- The machine should be running one of the following editions of Windows Server.

  - Windows Server 2025 Standard
  - Windows Server 2025 Datacenter
  - Windows Server 2025 Datacenter: Azure Edition. This edition does **not** need to be Azure Arc-enabled, Hotpatch is already enabled by default. The remaining technical prerequisites still apply.

- Both **Server with Desktop Experience** and **Server Core** installation options are supported.

- The physical or virtual machine you intend to enable Hotpatch on needs to satisfy the requirements for [Virtualization-based security](/windows-hardware/design/device-experiences/oem-vbs) (VBS), also known as [Virtual Secure Mode](/virtualization/hyper-v-on-windows/tlfs/vsm) (VSM). At bare minimum, the machine has to use Unified extensible firmware interface (UEFI) with Secure boot enabled. Therefore, for a virtual machine (VM) on Hyper-V, it needs to be a [Generation 2 virtual machine](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn282285(v=ws.11)).

- An Azure subscription. If you don't already have one, create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) before you begin.

- Your server and infrastructure should satisfy the [Connected Machine agent prerequisites](/azure/azure-arc/servers/prerequisites) for enabling Azure Arc on a server.

- The machine should be connected to Azure Arc (Arc-enabled). To learn more about onboarding your machine to Azure Arc, see [Azure Connected Machine agent deployment options](/azure/azure-arc/servers/deployment-options?toc=/windows-server/get-started/toc.json&bc=/windows-server/breadcrumbs/toc.json).

## Check and enable Virtual Secure Mode if necessary

When you [enable Hotpatch using the Azure portal](#enable-hotpatch-on-windows-server-2025), it checks whether [Virtual Secure Mode](/virtualization/hyper-v-on-windows/tlfs/vsm) (VSM) is running on the machine. If VSM isn't running, enabling hotpatch fails, and you'll have to enable VSM.

Alternatively, you can check the VSM status manually before enabling Hotpatch. VSM might be already enabled if you previously configured other features that (like Hotpatch) depend on VSM. Common examples of such features include [Credential guard](/windows/security/identity-protection/credential-guard) or [Virtualization-based protection of code integrity](/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity), also known as Hypervisor-protected code integrity (HVCI).

> [!TIP]
> You can use Group policy or another centralized management tool to enable one or more of the following features.
>
> - [Credential guard](/windows/security/identity-protection/credential-guard)
> - [Credential Guard protected machine accounts](/windows-server/identity/ad-ds/manage/delegated-managed-service-accounts/credential-guard-protected-machine-accounts)
> - [Virtualization-based protection of code integrity](/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity)
> - [System Guard Secure Launch and SMM protection](/windows/security/hardware-security/system-guard-secure-launch-and-smm-protection)
> - [Kernel Mode Hardware-enforced Stack Protection](/windows-server/security/kernel-mode-hardware-stack-protection)
> - [Secured-core server](/windows-server/security/configure-secured-core-server)
>
> Configuring any of these features also enables VSM.

To verify VSM is configured and running, select your preferred method and examine the output.

### [PowerShell](#tab/powershell)

```powershell
Get-CimInstance -Namespace 'root/Microsoft/Windows/DeviceGuard' -ClassName 'win32_deviceGuard' | Select-Object -ExpandProperty 'VirtualizationBasedSecurityStatus'
```

### [Command Prompt](#tab/cmd)

```cmd
for /f "tokens=2 delims==" %a in ('wmic.exe /namespace:\\root\Microsoft\Windows\DeviceGuard path win32_deviceGuard GET VirtualizationBasedSecurityStatus /value ^| find "="') do @echo %a
```

---

If the command output is `2`, VSM is configured and running. In this case, proceed directly to [Enable Hotpatch on Windows Server 2025](#enable-hotpatch-on-windows-server-2025).

If the output isn't `2`, you need to enable VSM.<br /><br />

<details>
  <summary>To enable VSM, expand this section.</summary>

  Enable VSM using one of the following commands.

  ### [PowerShell](#tab/powershell)

  ```powershell
  New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'EnableVirtualizationBasedSecurity' -PropertyType 'Dword' -Value 1 -Force
  ```

  ### [Command Prompt](#tab/cmd)

  ```cmd
  reg.exe add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 1 /f
  ```

  ---

  > [!TIP]
  > After you enable VSM, you need to restart your server.

  After you reboot, run one the following commands again verify that the output is now `2` to make sure VSM is now running.

  ### [PowerShell](#tab/powershell)

  ```powershell
  Get-CimInstance -Namespace 'root/Microsoft/Windows/DeviceGuard' -ClassName 'win32_deviceGuard' | Select-Object -ExpandProperty 'VirtualizationBasedSecurityStatus'
  ```

  ### [Command Prompt](#tab/cmd)

  ```cmd
  for /f "tokens=2 delims==" %a in ('wmic.exe /namespace:\\root\Microsoft\Windows\DeviceGuard path win32_deviceGuard GET VirtualizationBasedSecurityStatus /value ^| find "="') do @echo %a
  ```

  ---

  If the output still isn't `2`, VSM on your machine needs troubleshooting. The most likely reason is that the physical or virtual [hardware requirements](#prerequisites) aren't met. Refer to documentation from the vendor of your hardware or   virtualization platform. For example, here's documentation for VMware vSphere, [Activate Virtualization-based Security on an Existing Virtual Machine](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere/7-0/vsphere-security-7-0/securing-windows-guest-operating-systems-with-virtual-based-security/enable-virtualization-based-security-on-an-existing-virtual-machine.html).

  Once you successfully enabled VSM and made sure it's running, proceed to the next section.

</details>

## Enable Hotpatch on Windows Server 2025

1. Connect the machine to Azure Arc, if it wasn't Arc-enabled previously.

1. After you connected the machine to Azure Arc, sign in to the Azure Arc portal and go to **Azure Arc** → **Machines**.

1. Select the name of your machine.

1. Select **Hotpatch**, then select **Confirm**.

1. Wait about 10 minutes for the changes to apply. If the update stays stuck on the _Pending_ status, proceed to [troubleshooting Azure Arc agent](/azure/azure-arc/servers/troubleshoot-agent-onboard).

## Using Hotpatch on Windows Server 2025

Whenever a Hotpatch is available from Windows Update, you should receive a prompt to install it. Since these updates aren't released every month, you might need to wait until the next Hotpatch is published.

You can optionally automate hotpatch installation using update management tools such as [Azure Update Manager](/azure/automation/update-management/overview) (AUM).

## Known issues

### Multiple updates released in October 2025

In October 2025, Microsoft released several updates that were offered to some Windows Server customers. If you enrolled in hotpatch or plan to enroll, and plan to install hotpatch updates in November and December 2025, ensure your Windows Server machines are running on **exactly** one of the following update levels.
- [October 14, 2025 - **KB5066835** (OS Build 26100.6899)](https://support.microsoft.com/topic/6cdcc1c3-cfbf-41a3-8f0d-0c4a9d2b7d1e)
- [October 24, 2025 - **KB5070893** (OS Build 26100.6905) Security Update for Windows Server Update Services](https://support.microsoft.com/topic/78f3720c-9511-4deb-b0d7-7bed2016fefd)

If you have one of the other October updates installed, this will result in regular non-hotpatch updates until, and including, the next baseline month that is currently scheduled for January 2026. These updates require a reboot each month. In particular, the following update, if installed, makes the machine incompatible with upcoming hotpatches: [October 23, 2025 - **KB5070881** (OS Build 26100.6905) Out-of-band](https://support.microsoft.com/topic/8e7ac742-6785-4677-87e4-b73dd8ac0122), and so does any other update not explicitly listed in this section.

### Feature licensing issue in October 2025 updates

An issue was identified with the October 2025 security updates for Windows Server 2025. This may impact customers running [October 14, 2025 - KB5066835 (OS Build 26100.6899)](https://support.microsoft.com/topic/6cdcc1c3-cfbf-41a3-8f0d-0c4a9d2b7d1e) update or later. Due to this issue, the following unexpected behavior can be observed.

- Enabling Windows Server hotpatching via Azure Arc on new machines may fail or not complete as expected. Instead, feature enablement remains in the "In Progress" state until the issue is resolved.
- On machines previously enabled for Windows Server hotpatching, the feature license may expire, and this will prevent the next Hotpatch from being installed. Instead, the next update will cause a reboot if no action is taken.

Hotpatching on [Windows Server 2025 Datacenter: Azure Edition](/windows-server/get-started/azure-edition) isn't affected by this issue.

To resolve this issue, a series of manual steps is recommended. Failure to apply either workaround will result in regular non-hotpatch updates until, and including, the next baseline month that is currently scheduled for January 2026. These updates require a reboot each month.

There are two ways to apply the manual workaround on affected machines. Each of the provided options offers a complete solution. You'll need to apply the workaround on each of the affected machines **before** the next update is offered, which is anticipated in the next "patch Tuesday" date of **November 11, 2025**. Applying the workaround requires a reboot, so plan accordingly.

After you apply either workaround, hotpatch updates released in November and December 2025 will install without requiring a reboot.

#### Option 1: Use Local or Group Policy to enable the remediation

1. Download and install the [Windows 11 24H2, Windows 11 25H2, and Windows Server 2025 KB5062660 251028_18301 Feature Preview](https://download.microsoft.com/download/2d85085c-4890-4c4d-930c-744d6f090cfa/Windows%2011%2024H2%2c%20Windows%2011%2025H2%20and%20Windows%20Server%202025%20KB5062660%20251028_18301%20Feature%20Preview.msi) package. This installs the Local or Group Policy template (`ADMX` file) for this specific remediation.

1. Select **Start**, type **gpedit**, then select **Edit group policy**. Navigate to **Computer Configuration\Administrative Templates\KB5062660 251028_18301 Feature Preview\Windows 11, version 24H2, 25H2\KB5062660 251028_18301 Feature Preview**.

   For more information on deploying and configuring this special Group Policy, see [Use Group Policy to enable an update that is disabled by default](/troubleshoot/windows-client/group-policy/use-group-policy-enable-update-disabled-by-default).

1. In the right window pane, open **KB5062660 251028_18301 Feature Preview**, select **Enabled**, then select **OK**.

1. Reboot the affected machine.

1. Run the following command to remove the **DeviceLicensingServiceCommandMutex** entry from the registry. If this entry isn't present on the affected device, removal is ignored.

   ```powershell
   try {
   Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Subscriptions' -Name 'DeviceLicensingServiceCommandMutex' -ErrorAction Stop
   } catch {
   Write-Host "DeviceLicensingServiceCommandMutex entry not present, skipping removal."
   }
   ```

   Alternatively, use your preferred registry editing tool or automation solution to delete the same value. Don't delete the whole registry key.

#### Option 2: Use a script to enable the remediation

Open an elevated PowerShell window on each of the affected machines and run the following commands. The last command prompts you to restart your device. The mitigation isn't complete until the machine is rebooted, and it's recommended that you restart immediately after running this script.

```powershell
Stop-Service -Name 'HIMDS'
New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides' -Force
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides' -PropertyType 'dword' -Name '4264695439' -Value 1 -Force
try {
  Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Subscriptions' -Name 'DeviceLicensingServiceCommandMutex' -ErrorAction Stop
} catch {
  Write-Host "DeviceLicensingServiceCommandMutex entry not present, skipping removal."
}
Restart-Computer -Confirm
```

## Next steps

Now that Hotpatch is enabled, here are some articles that might help you with updating your computer.

- [Hotpatch for Windows Server](hotpatch.md)
- [Patch a Server Core installation](../administration/server-core/server-core-servicing.md)
- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)
- [Azure Update Manager](/azure/automation/update-management/overview)

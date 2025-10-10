---
title: Enable Hotpatch for Azure Arc-enabled servers
description: Learn how to enable Hotpatch for Windows Server 2025 installations on Azure Arc-enabled servers.
ms.author: daknappe
ms.topic: how-to
author: dknappettmsft
ms.date: 07/14/2025
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

## Next steps

Now that Hotpatch is enabled, here are some articles that might help you with updating your computer:

- [Hotpatch for Windows Server](hotpatch.md)
- [Patch a Server Core installation](../administration/server-core/server-core-servicing.md)
- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)
- [Azure Update Manager](/azure/automation/update-management/overview)


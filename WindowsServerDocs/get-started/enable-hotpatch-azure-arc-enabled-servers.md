---
title: Enable Hotpatch for Azure Arc-enabled servers (preview)
description: Learn how to enable Hotpatch for Windows Server 2025 installations on Azure Arc-enabled servers.
ms.author: alalve
ms.topic: how-to
author: xelu86
ms.date: 03/07/2025
---

# Enable Hotpatch for Azure Arc-enabled servers (preview)

> [!IMPORTANT]
> Azure Arc-enabled Hotpatch is currently in **preview**. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Hotpatch allows you to update your Windows Server installation without requiring your users to restart after installation. This feature minimizes downtime spent on updates and keeps your users running their workloads uninterrupted. For more information about how Hotpatch works, see [Hotpatch for Windows Server](hotpatch.md).

Windows Server 2025 features the ability to enable Hotpatch for Azure Arc-enabled servers. In order to use Hotpatch on Azure Arc-enabled servers, all you have to do is deploy the Connected Machine agent and enable Windows Server Hotpatch. This article describes how to enable Hotpatching.

## Prerequisites

Before you can enable Hotpatch on Arc-enabled servers for Windows Server 2025, you need to satisfy the following requirements.

- A server must be running a _released_ version of Windows Server 2025 (build 26100.1742 or later). Preview versions or [Windows Server Insiders](/windows-server/get-started/get-started-with-windows-server-insiders-preview) builds aren't supported because hotpatches aren't created for pre-release operating systems.

- The machine should be running one of the following editions of Windows Server.

  - Windows Server 2025 Standard
  - Windows Server 2025 Datacenter
  - Windows Server 2025 Datacenter: Azure Edition. This edition does **not** need to be Azure Arc-enabled, as it already includes Hotpatching feature by default. The remaining technical prerequisites still apply.

- Both **Server with Desktop Experience** and **Server Core** installation options are supported.

- The physical or virtual machine you intend to enable Hotpatch on needs to satisfy the requirements for [Virtualization-based security](/windows-hardware/design/device-experiences/oem-vbs) (VBS), also known as [Virtual secure mode](/virtualization/hyper-v-on-windows/tlfs/vsm) (VSM). At bare minimum, the machine has to use Unified extensible firmware interface (UEFI) with Secure boot enabled. Therefore, for a virtual machine (VM) on Hyper-V, it needs to be a [Generation 2 virtual machine](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn282285(v=ws.11)).

- An Azure subscription. If you don't already have one, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

- Your server and infrastructure should satisfy the [Connected Machine agent prerequisites](/azure/azure-arc/servers/prerequisites) for enabling Azure Arc on a server.

- The machine should be connected to Azure Arc (Arc-enabled). To learn more about onboarding your machine to Azure Arc, see [Connect Windows Server machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server?toc=/windows-server/get-started/toc.json&bc=/windows-server/breadcrumbs/toc.json).

## Enable VSM

1. Check whether VSM is already running. It might be enabled if you previously configured other features that (like Hotpatching) depend on VSM. Common examples of such features include [Credential guard](/windows/security/identity-protection/credential-guard) or [Virtualization-based protection of code integrity](/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity), also known as Hypervisor-protected code integrity (HVCI).

   Run one of the following commands.

   # [PowerShell](#tab/powershell)
   ```powershell
   Get-CimInstance -Namespace 'root/Microsoft/Windows/DeviceGuard' -ClassName 'win32_deviceGuard' | Select-Object -ExpandProperty 'VirtualizationBasedSecurityStatus'
   ```
   Expected output: `2`.      
   # [Command Prompt](#tab/cmd)
   ```cmd
   wmic.exe /namespace:\\root\Microsoft\Windows\DeviceGuard path win32_deviceGuard GET VirtualizationBasedSecurityStatus /value
   ```
   Expected output: `VirtualizationBasedSecurityStatus=2`.
   
   ---

   If the result matches the expected output, VSM is configured and running. In this case, proceed directly to [Enable Hotpatch preview on Windows Server 2025](#enable-hotpatch-preview-on-windows-server-2025).

   If the result does not match the expected output, continue with the next steps.

1. Run one of the following commands in elevated PowerShell or command prompt to enable VSM.

   # [PowerShell](#tab/powershell)
   ```powershell
   New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'EnableVirtualizationBasedSecurity' -PropertyType 'Dword' -Value 1 -Force
   ```
   # [Command Prompt](#tab/cmd)
   ```cmd
   reg.exe add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 1 /f
   ```
   ---

1. Restart your server.

1. After reboot, run the following command again and verify that the output is `2` to make sure VSM is now running.

   # [PowerShell](#tab/powershell)
   ```powershell
   Get-CimInstance -Namespace 'root/Microsoft/Windows/DeviceGuard' -ClassName 'win32_deviceGuard' | Select-Object -ExpandProperty 'VirtualizationBasedSecurityStatus'
   ```
   Expected output: `2`.      
   # [Command Prompt](#tab/cmd)
   ```cmd
   wmic.exe /namespace:\\root\Microsoft\Windows\DeviceGuard path win32_deviceGuard GET VirtualizationBasedSecurityStatus /value
   ```
   Expected output: `VirtualizationBasedSecurityStatus=2`.
   
   ---
      
   If the result matches the expected output, the VSM on your machine needs troubleshooting. The most likely reason is that the physical or virtual [hardware requirements](#prerequisites) aren't met. Refer to documentation from the vendor of your hardware or virtualization platform. For example, here's documentation for VMware vSphere: [Activate Virtualization-based Security on an Existing Virtual Machine](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere/7-0/vsphere-security-7-0/securing-windows-guest-operating-systems-with-virtual-based-security/enable-virtualization-based-security-on-an-existing-virtual-machine.html).

1. Once you successfully enabled VSM and made sure it's running, proceed to the next section.

## Enable Hotpatch preview on Windows Server 2025

1. Connect the machine to Azure Arc, if it wasn't Arc-enabled previously.

1. After you connected the machine to Azure Arc, sign in to the Azure Arc portal and go to **Azure Arc** → **Machines**.

1. Select the name of your machine.

1. Select **Hotpatch (preview)**, then select **Confirm**.

1. Wait about 10 minutes for the changes to apply. If the update stays stuck on the _Pending_ status, proceed to [troubleshooting Azure Arc agent](/azure/azure-arc/servers/troubleshoot-agent-onboard).

## Using Hotpatch preview on Windows Server 2025

Whenever a Hotpatch is available from Windows Update, you should receive a prompt to install it. Since these updates aren't released every month, you may need to wait until the next Hotpatch is published.

You can optionally automate hotpatch installation using update management tools such as [Azure Update Manager](/azure/automation/update-management/overview) (AUM).

## Next steps

Now that Hotpatch is enabled, here are some articles that might help you with updating your computer:

- [Hotpatch for Windows Server](hotpatch.md)
- [Patch a Server Core installation](../administration/server-core/server-core-servicing.md)
- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)
- [Azure Update Manager](/azure/automation/update-management/overview)VirtualizationBasedSecurityStatus=2

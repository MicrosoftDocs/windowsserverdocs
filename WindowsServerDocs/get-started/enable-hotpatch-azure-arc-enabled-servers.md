---
title: Enable Hotpatch for Azure Arc-enabled servers
description: Learn how to enable Hotpatch for Windows Server 2025 installations on Azure Arc-enabled servers.
ms.author: alalve
ms.topic: how-to
author: xelu86
ms.date: 03/04/2025
---

# Enable Hotpatch for Azure Arc-enabled servers

> [!IMPORTANT]
> Azure Arc-enabled Hotpatch isn't currently charged and is in a free trial period. To learn more about pricing and when Hotpatch will become charged service, see [Azure Arc pricing](/azure/azure-arc/servers/pricing).

Hotpatch allows you to update your Windows Server installation without requiring your users to restart after installation. This feature minimizes downtime spent on updates and keeps your users running their workloads uninterrupted. For more information about how Hotpatch works, see [Hotpatch for virtual machines](hotpatch.md).

Windows Server 2025 features the ability to enable Hotpatch for Azure Arc-enabled servers. In order to use Hotpatch on Azure Arc-enabled servers, all you have to do is deploy the Connected Machine agent and enable Windows Server Hotpatch. This article describes how to enable Hotpatching.

## Prerequisites

Before you can enable Hotpatch on Arc-enabled servers for Windows Server 2025, you need to satisfy the following requirements.

- A server must be running a _released_ version of Windows Server 2025 (build 26100.1742 or later). Preview versions or [Windows Server Insiders](/windows-server/get-started/get-started-with-windows-server-insiders-preview) builds aren't supported because hotpatches aren't created for pre-release operating systems.

- The machine should be running one of the following editions of Windows Server.

  - Windows Server 2025 Standard
  - Windows Server 2025 Datacenter
  - Windows Server 2025 Datacenter: Azure Edition. This edition does **not** need to be Azure Arc-enabled, as it already includes Hotpatching feature by default. The remaining technical prerequisites still apply.

- Both **Server with Desktop Experience** and **Server Core** installation options are supported.

- The physical or virtual machine you intend to enable Hotpatch on needs to satisfy the requirements for [Virtualization-Based Security](/windows-hardware/design/device-experiences/oem-vbs) (VBS), also known as [Virtual Secure Mode](/virtualization/hyper-v-on-windows/tlfs/vsm) (VSM). At bare minimum, the machine has to use Unified Extensible Firmware Interface (UEFI) with Secure Boot enabled. Therefore, for a virtual machine (VM) on Hyper-V, it needs to be a [Generation 2 virtual machine](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn282285(v=ws.11)).

- An Azure subscription. If you don't already have one, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

- Your server and infrastructure should satisfy the [Connected Machine agent prerequisites](/azure/azure-arc/servers/prerequisites) for enabling Azure Arc on a server.

- The machine should be connected to Azure Arc (Arc-enabled). To learn more about onboarding your machine to Azure Arc, see [Connect Windows Server machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server?toc=/windows-server/get-started/toc.json&bc=/windows-server/breadcrumbs/toc.json).


## Install Hotpatch for Windows Server 2025

1. Run the following command in an elevated PowerShell or command prompt.

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

1. _(Optional)_ After reboot, run the following command in PowerShell and verify that the output is `2` to make sure Virtual Secure Mode (VSM) is running.

   ```powershell
   Get-CimInstance -Namespace 'root/Microsoft/Windows/DeviceGuard' -ClassName 'win32_deviceGuard' | Select-Object -ExpandProperty 'VirtualizationBasedSecurityStatus'
   ```

   If the output isn't `2`, you have to troubleshoot Virtual Secure Mode (VSM) enablement.

1. Connect (Arc-enable) the machine to Microsoft Azure.

1. After you connected the machine to Azure Arc, sign in to the Azure Arc portal and go to **Azure Arc** → **Machines**.

1. Select the name of your machine.

1. Select **Hotpatch**, then select **Confirm**.

1. Wait about 10 minutes for the changes to apply. If the update stays stuck on the Pending status, run the following commands in PowerShell:

   ```powershell
   [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072
   Invoke-WebRequest -UseBasicParsing -Uri "https://aka.ms/azcmagent-windows" -TimeoutSec 30 -OutFile "$env:TEMP\install_windows_azcmagent.ps1"
   & "$env:TEMP\install_windows_azcmagent.ps1"
   ```

1. Whenever a Hotpatch is available from Windows Update, you should receive a prompt to install it. Since these updates aren't released every month, you might need to wait until the next Hotpatch is published.

## Next steps

Now that you have Hotpatch enabled, here are some articles that might help you with updating your computer:

- [Patch a Server Core installation](../administration/server-core/server-core-servicing.md)

- Learn more about [Windows Server Update Services (WSUS)](../administration/windows-server-update-services/get-started/windows-server-update-services-wsus.md)

- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)

- [Azure Update Management](/azure/automation/update-management/overview)

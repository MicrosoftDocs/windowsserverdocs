---
title: Enable Hotpatch for Azure Arc-enabled servers (preview)
description: Learn how to enable Hotpatch for Windows Server 2025 deployments on Azure Arc-enabled servers.
author: Heidilohr
ms.author: helohr
ms.topic: how-to
ms.date: 10/25/2024
---

# Enable Hotpatch for Azure Arc-enabled servers (preview)

> [!IMPORTANT]
> Azure Arc-enabled Hotpatch is currently in PREVIEW.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Hotpatch allows you to update your Windows Server deployment without requiring your users to restart their virtual machines (VMs) after installation. This feature minimizes downtime spent on updates and keeps your users running their VM sessions uninterrupted. For more information about how Hotpatch works, see [Hotpatch for virtual machines](hotpatch.md).

Windows Server 2025 (preview) features the ability to enable Hotpatch for Azure Arc-enabled servers. In order to use Hotpatch on Azure Arc-enabled servers, all you have to do is deploy the Connected Machine agent and enable Windows Server Hotpatch. This article describes how to enable Hotpatching.

>[!IMPORTANT]
>Azure Arc-enabled Hotpatching is in public preview, but will be a billed as an Azure service at GA. For more information, see the pricing page. <!--Get pricing information once page URLs are available.--->

## Prerequisites

Before you can enable Hotpatch on Arc-enabled servers for Windows Server 2025, you need the following things:

- A Windows Server deployment that runs one of the following versions of Windows Server 2025:

  - Windows Server 2025 Standard Edition

  - Windows Server 2025 Datacenter: Azure Edition

- An Azure subscription. If you don't already have one, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

- A server that meets [the requirements for enabling Azure Arc on a server](/azure/azure-arc/servers/prerequisites).

- You have Windows Server machine connected to Azure Arc. To learn more about onboarding your machine to Azure Arc, see [Connect Windows Server machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server?toc=/windows-server/get-started/toc.json&bc=/windows-server/breadcrumbs/toc.json).

- The VM you create to use Hotpach must be a gen 2 VM using [the Windows Server 2025 (preview) ISO](https://www.microsoft.com/evalcenter/download-windows-server-2025?msockid=110e69cfccac69d1320d7d42cd16685d).

- Update your VM to [KB5040435](https://www.catalog.update.microsoft.com/Search.aspx?q=5040435) or later.

## Install Hotpatch preview version for Windows Server 2025

To install the preview version of the Hotpatch for Windows Server 2025 Standard and Azure Editions:

1. Run the following command in an elevated command prompt:

   ```cmd
   Reg add "HKLM\SYSTEM\ControlSet001\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 1 /f
   ```

1. Restart your computer.

1. After you enable Azure Arc, sign in to the Azure Arc portal and go to **Azure Arc** > **Machines**.

1. Select the name of your VM.

1. Select **Hotpatch (preview)**, then select **Confirm**.

1. Wait about 10 minutes for the changes to apply. If the update stays stuck on the Pending status, run the following cmdlet in PowerShell:

  ```powershell
  [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072;
  Invoke-WebRequest -UseBasicParsing -Uri "https://aka.ms/azcmagent-windows" -TimeoutSec 30 -OutFile "$env:TEMP\install_windows_azcmagent.ps1";
  & "$env:TEMP\install_windows_azcmagent.ps1";
  ```

1. You should now be prompted to install a Hotpatch update when a Hotpatch is available from Windows Update.

## Next steps

Now that you have Hotpatch enabled, here are some articles that might help you with updating your computer:

- [Patch a Server Core installation](../administration/server-core/server-core-servicing.md)

- Learn more about [Windows Server Update Services (WSUS)](../administration/windows-server-update-services/get-started/windows-server-update-services-wsus.md)

- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)

- [Azure Update Management](/azure/automation/update-management/overview)
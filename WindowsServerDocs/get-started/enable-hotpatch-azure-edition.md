---
title: Enable Hotpatch for Azure Edition virtual machines
description:  'Learn how to enable Hotpatch for Windows Server Datacenter: Azure Edition when built using ISO installation media.'
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 10/31/2023
---

# Enable Hotpatch for Azure Edition virtual machines built from ISO

Hotpatch for Windows Server 2022 Datacenter: Azure Edition allows you to install security updates on without requiring a reboot after installation. You can use Hotpatch with both Desktop Experience and Server Core. This article will teach you how to configure Hotpatch after installing or upgrading the operating system using an ISO.

> [!NOTE]
> If you're using the Azure marketplace, don't follow the steps in this article. Instead, use the following images from Azure Marketplace that are ready for Hotpatching:
>
> - Windows Server 2022 Datacenter: Azure Edition Hotpatch - Gen2
> - Windows Server 2022 Datacenter: Azure Edition Core - Gen2

When using Hotpatch for your ISO deployed machine on Azure Stack HCI, there are a few important
differences with the Hotpatch experience compared with using Hotpatch as part of Azure Automanage
for Azure VMs.

 The differences include:

- Hotpatch configuration isn't available via Azure Update Manager.
- Hotpatch can't be disabled.
- Automatic Patching orchestration isn't available.
- Orchestration must be performed manually (for example, using Windows Update via SConfig).

## Prerequisites

To enable Hotpatch, you must have the following prerequisites ready before you start:

- Windows Server 2022 Datacenter: Azure Edition hosted on a supported platform, such as
  Azure or Azure Stack HCI with Azure benefits enabled.
  - Azure Stack HCI must be version 21H2 or later.
- Review the [How hotpatch works](/azure/automanage/automanage-hotpatch#how-hotpatch-works) section
  of the Hotpatch for new virtual machines article.
- Outbound network access or an outbound port rule allowing HTTPS (TCP/443) traffic to the following
  endpoints:
  - `go.microsoft.com`
  - `software-static.download.prss.microsoft.com`

## Prepare your computer

Before you can enable Hotpatch for your VM, you must prepare your computer using the following
steps:

1. Sign-in to your machine. If you're on Server core, from the SConfig menu, enter option **15**, then press <kbd>Enter</kbd>
   to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.
1. Enable virtualization-based security by running the following PowerShell command to configure the
   correct registry settings:

   ```powershell
   $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"
   $parameters = $parameters = @{
       Path = $registryPath
       Name = "EnableVirtualizationBasedSecurity"
       Value = "0x1"
       Force = $True
       PropertyType = "DWORD" 
   }
   New-ItemProperty @parameters
   ```

1. Restart your computer.
1. Configure the Hotpatch table size in the registry by running the following PowerShell command:

   ```powershell
   $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
   $parameters = $parameters = @{
       Path = $registryPath
       Name = "HotPatchTableSize"
       Value = "0x1000"
       Force = $True
       PropertyType = "DWORD"
   }
   New-ItemProperty @parameters
   ```

1. Configure the Windows Update endpoint for Hotpatch in the registry by running the following
   PowerShell command:

   ```powershell
   $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Update\TargetingInfo\DynamicInstalled\Hotpatch.amd64"
   $nameParameters = $parameters = @{
       Path = $registryPath
       Name = "Name"
       Value = "Hotpatch Enrollment Package"
       Force = $True
   }
   $versionParameters = $parameters = @{
       Path = $registryPath
       Name = "Version"
       Value = "10.0.20348.1129"
       Force = $True
   }
   New-Item $registryPath -Force
   New-ItemProperty @nameParameters
   New-ItemProperty @versionParameters
   ```

Now you've prepared your computer, you can install the Hotpatch servicing package.

## Install Hotpatch servicing package

> [!NOTE]
> The Hotpatch Prerequisite KB is currently not published in the Microsoft Update catalog.

To be able to receive Hotpatch updates, you'll need to download and install the Hotpatch servicing
package. In your PowerShell session, complete the following steps:

1. Download the (KB5003508) Microsoft Update Standalone Package from the Microsoft Update Catalog
   and copy it to your computer using the following PowerShell command:

   ```powershell
   $parameters = @{
       Uri = "https://go.microsoft.com/fwlink/?linkid=2211714"
       OutFile = ".\KB5003508.msu"
   }
   Invoke-WebRequest @parameters
   ```

1. To install the Standalone Package, run the following command:

   ```powershell
   wusa.exe .\KB5003508.msu
   ```

1. Follow the prompts. Once it's completed, select Finish.
1. To verify the installation, run the following command:

   ```powershell
   Get-HotFix | Where-Object {$_.HotFixID -eq "KB5003508"}
   ```

> [!NOTE]
> When using Server Core, updates are set to be manually installed by default. You can change this
> setting using the SConfig utility.

## Next steps

Now you've set up your computer for Hotpatch, here are some articles that might help you with
updating your computer:

- [Patch a Server Core installation](../administration/server-core/server-core-servicing.md).
- Learn more about
  [Windows Server Update Services (WSUS)](../administration/windows-server-update-services/get-started/windows-server-update-services-wsus.md).

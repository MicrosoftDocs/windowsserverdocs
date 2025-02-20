---
title: Hyper-V Virtual Machine Management service must be running
description: Learn what to do when the service required to manage virtual machines isn't running, and how to resolve the problem.
ms.author: mosagie
author: meaghanlewis
ms.topic: article
ms.assetid: f44d6887-6458-4438-9d93-574587e3f7d1
ms.date: 02/18/2025
---
# Hyper-V Virtual Machine Management service must be running

For more information about best practices and scans, see [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Prerequisites|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*The service required to manage virtual machines isn't running.*

## Impact

*No virtual machine management operations can be performed.*

Virtual machines that are running continue to run. However, you can't manage virtual machines, or create or delete them until the service is running.

## Resolution

*Use the Services snap-in or Sc config command-line tool to reconfigure the service to start automatically.*

> [!TIP]
> If you can't find the service in the desktop app or the command-line tool reports that the service doesn't exist, the Hyper-V Management tools probably aren't installed.
And if you aren't able to see the Hyper-V MMC console from the Start menu, you should install the Hyper-V Management Tools.

To install the Hyper-V Management tools:
>
> - On Windows Server, open Server Manager and use the Add Roles and Features wizard. For more information, see [Install the Hyper-V role on Windows Server](../get-started/Install-the-Hyper-V-role-on-Windows-Server.md).  You can also use PowerShell to install the tools (`Install-WindowsFeature -Name Hyper-V-Tools, Hyper-V-PowerShell`)
> - On Windows, from the Desktop, begin typing **programs**, select **Programs and Features** (Control panel) > **Turn Windows features on or off** > **Hyper-V** > **Hyper-V Management Tools**. Then, select **OK**.

### To reconfigure the service to start automatically using the Services desktop app

1. Open the Services desktop app. (Select **Start**, select in the **Start Search** box, type **services.msc**, and then press ENTER.)

1. In the details pane, right-click **Hyper-V Virtual Machine Management**, and then select **Properties**.

1. On the **General** tab, in **Startup** type, select **Automatic**.

1. To start the service, select **Start**.

### To reconfigure the service to start automatically using SC Config

1. Open Windows PowerShell. (From the desktop, select **Start** and start typing **Windows PowerShell**.)

1. Right-click **Windows PowerShell** and select **Run as administrator**.

1. To reconfigure the service, type:

    ```powershell
    sc.exe config vmms start=auto
    ```

1. To start the service, type:

    ```powershell
    sc.exe start vmms
    ```

If the service is already configured to start automatically and you just need to restart the service, you can do that from Hyper-V Manager, or from the sc start vmms command.

#### To restart the service from Hyper-V Manager

1. Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then select **Hyper-V Manager**.

1. In the navigation pane, select the name of the server if it's not already selected.

1. In the **Actions** pane, select **Start Service**.

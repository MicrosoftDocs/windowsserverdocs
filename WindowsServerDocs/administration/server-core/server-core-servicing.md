---
title: Configure Windows Server Core Windows Update
description: Learn how to configure Windows Server Core in updating the operating system automatically and manually through the command line.
ms.mktglfcycl: manage
ms.sitesec: library
author: robinharwood
ms.author: roharwoo
ms.date: 03/10/2025
ms.topic: how-to
---

# Configure Windows Server Core Windows Update

Configuring Windows Update settings on a Windows Server Core installation can be performed using the SConfig menu or via the command line. This article describes the steps and commands needed to configure the Windows Update settings. Server Core allows for Windows updates to be installed in the following ways:

- **Using automatic Windows Update** or with **Windows Server Update Services** (WSUS). By using Windows Update, either automatically or with the WSUS command-line tool, you can service servers running a Server Core installation.

- **Manually**. Even in organizations that don't use Windows update or WSUS, you can apply updates manually.

## Prerequisites

- Your device must have an active internet connection.
- The user account performing Windows updates should be a member of the **Administrators**, **Domain Admins**, or **Enterprise Admins** group.
- If the server is a member of a domain, the Windows Update Agent must be configured properly through Group Policy. Server Core devices only support option 4, **Auto download and schedule the install**, as mentioned in [Configuring Automatic Updates by using Group Policy](/windows/deployment/update/waas-wu-settings#configuring-automatic-updates-by-using-group-policy). See also the [Group Policy Settings Reference for Windows and Windows Server](https://www.microsoft.com/download/details.aspx?id=25250).

## View the installed updates

Before you add a new update to Server Core, check that the latest Windows updates are installed by running one of the following commands:

```powershell
Get-Hotfix | Sort-Object InstalledOn
```

```powershell
Get-ComputerInfo -Property OsHotFixes
```

```cmd
systeminfo
```

```cmd
wmic qfe list
```

## Configure Windows updates via SConfig

Beginning with Windows Server 2002, the SConfig menu loads once you sign in. If the SConfig menu doesn't appear, run `sconfig` and select **Enter**. Once the menu loads, perform the following steps to configure your settings:

1. Type **5**, select **Enter**. Select one of these options, then select **Enter**.

   1. **1**\) Automatic
   1. **2**\) Download only
   1. **3**\) Manual

1. Type **6**, select **Enter**. Select one of these options, then select **Enter**.

   1. **1**\) All quality updates
   1. **2**\) Recommended quality updates only
   1. **3**\) Feature updates

## Configure Windows updates via command line

# [Command Prompt](#tab/cmd)

> [!TIP]
> VBScript is deprecated. VBScript remains available as a feature on demand (FoD) and is preinstalled in Windows Server 2025, however consider using PowerShell or the SConfig menu to configure Windows Update settings. To learn more about the deprecation of VBScript, see [https://techcommunity.microsoft.com/blog/windows-itpro-blog/vbscript-deprecation-timelines-and-next-steps/4148301](https://techcommunity.microsoft.com/blog/windows-itpro-blog/vbscript-deprecation-timelines-and-next-steps/4148301).

To verify the current Windows Update setting, run the following command:

   ```powershell
   %systemroot%\system32\cscript %systemroot%\system32\scregedit.wsf /AU /v
   ```

To enable automatic updates, run the following command:

   ```powershell
   Net stop wuauserv
   %systemroot%\system32\cscript %systemroot%\system32\scregedit.wsf /AU /v 4
   Net start wuauserv
   ```

To disable automatic updates, run the following command:

   ```powershell
   Net stop wuauserv
   %systemroot%\system32\cscript %systemroot%\system32\scregedit.wsf /AU /v 1
   Net start wuauserv
   ```

# [PowerShell](#tab/powershell)

To verify the current Windows Update setting, run the following command:

   ```powershell
   & $env:SystemRoot\system32\cscript $env:SystemRoot\system32\scregedit.wsf /AU /v
   ```

To enable automatic updates, run the following command:

   ```powershell
   Net stop wuauserv
   & $env:SystemRoot\system32\cscript $env:SystemRoot\system32\scregedit.wsf /AU 4
   Net start wuauserv
   ```

To disable automatic updates, run the following command:

   ```powershell
   Net stop wuauserv
   & $env:SystemRoot\system32\cscript $env:SystemRoot\system32\scregedit.wsf /AU 1
   Net start wuauserv
   ```

---

To force Windows Update to immediately detect and install any available updates, run the following command:

```
wuauclt /detectnow
```

Depending on the updates that are installed, you might need to restart the computer. The system doesn't notify which updates require a reboot. To determine if the installation process completed, open **Task Manager** by running `taskmgr` and verify that either the **wuauclt**, or **Trusted Installer** processes aren't actively running.

## Manually apply a Windows Server update

To remove the Latest Cumulative Update (LCU) after installing the combined Servicing Stack Updates (SSU) and LCU package, use the `Remove-WindowsPackage` cmdlet or the `Dism /Remove-Package` command line option with the LCU package name as the argument. You can find the package name by using this command: DISM /online /get-packages.

Download the `.msu` update file and pick your preferred method to install the update.

### [PowerShell](#tab/update-powershell)

From an elevated PowerShell prompt, run the following command:

```powershell
Add-WindowsPackage -Online -Path "<folder_path>" -PackagePath "\<update_file>.msu" -PreventPending
```

The `-PreventPending` parameter skips the installation of the package if the package or Windows image has pending online actions.

To manually uninstall an update, first determine the update name by running the following command:

```powershell
Get-WindowsPackage -online -PackageName "*KB<NUM>*"
```

Then, run the following command to uninstall the update:

```powershell
Remove-WindowsPackage -Online -PackageName "<package_name>"
```

### [Dism](#tab/update-dism)

From an elevated prompt, run the following command:

```cmd
Dism /Online /Add-Package /PackagePath:"<update_file>.msu" /PreventPending
```

The `/PreventPending` option skips the installation of the package if the package or Windows image has pending online actions.

To manually uninstall an update, first determine the update name by running the following command:

```cmd
Dism /Online /Get-Packages
```

Then, run the following command to uninstall the update:

```cmd
Dism /Online /Remove-Package /PackageName:<package_name>
```


---

## Update with Azure Update Manager

You can also update your Windows Server Core installation using [Azure Update Manager](/azure/update-manager/overview?tabs=azure-arc-vms) from the Azure portal.


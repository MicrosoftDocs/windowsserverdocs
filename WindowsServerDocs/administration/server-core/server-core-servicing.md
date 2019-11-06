---
title: Patching Server Core
description: Learn how to update a Server Core installation of Windows Server
ms.prod: windows-server
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 10/17/2017
---
# Patch a Server Core installation

> Applies to: Windows Server 2019, Windows Server 2016, and Windows Server (Semi-Annual Channel)

You can patch a server running Server Core installation in the following ways:

- **Using Windows Update automatically or with Windows Server Update Services (WSUS)**. By using Windows Update, either automatically or with command-line tools, or Windows Server Update Services (WSUS), you can service servers running a Server Core installation.

- **Manually**. Even in organizations that do not use Windows update or WSUS, you can apply updates manually.

## View the updates installed on your Server Core server
Before you add a new update to Server Core, it's a good idea to see what updates have already been installed.

To view updates by using Windows PowerShell, run **Get-Hotfix**.

To view updates by running a command, run **systeminfo.exe**. There might be a short delay while the tool inspects your system.

You can also run **wmic qfe list** from the command line. 

## Patch Server Core automatically with Windows Update

Use the following steps to patch the server automatically with Windows Update:

1. Verify the current Windows Update setting:
   ```
   %systemroot%\system32\Cscript %systemroot%\system32\scregedit.wsf /AU /v 
   ```

2. To enable automatic updates:

   ```
   Net stop wuauserv 
   %systemroot%\system32\Cscript %systemroot%\system32\scregedit.wsf /AU 4 
   Net start wuauserv
   ```  

3. To disable automatic updates, run:

   ```
   Net stop wuauserv 
   %systemroot%\system32\Cscript %systemroot%\system32\scregedit.wsf /AU 1 
   Net start wuauserv 
   ```

If the server is a member of a domain, you can also configure Windows Update using Group Policy. For more information, see https://go.microsoft.com/fwlink/?LinkId=192470. However, when you use this method, only option 4 ("Auto download and schedule the install") is relevant to Server Core installations because of the lack of a graphical interface. For more control over which updates are installed and when, you can use a script which provides a command-line equivalent of most of the Windows Update graphical interface. For information about the script, see https://go.microsoft.com/fwlink/?LinkId=192471.

To force Windows Update to immediately detect and install any available updates, run the following command:

```
Wuauclt /detectnow 
```

Depending on the updates that are installed, you may need to restart the computer, although the system will not notify you of this. To determine if the installation process has completed, use Task Manager to verify that the **Wuauclt** or **Trusted Installer** processes are not actively running. You can also use the methods in [View the updates installed on your Server Core server](#view-the-updates-installed-on-your-server-core-server) to check the list of installed updates.

## Patch the server with WSUS 

If the Server Core server is a member of a domain, you can configure it to use a WSUS server with Group Policy. For more information, download the [Group Policy reference information](https://www.microsoft.com/download/details.aspx?id=25250). You can also review [Configure Group Policy Settings for Automatic Updates](../windows-server-update-services/deploy/4-configure-group-policy-settings-for-automatic-updates.md)

## Patch the server manually

Download the update and make it available to the Server Core installation.
At a command prompt, run the following command:

```
Wusa <update>.msu /quiet 
```

Depending on the updates that are installed, you may need to restart the computer, although the system will not notify you of this.

To uninstall an update manually, run the following command:

```
Wusa /uninstall <update>.msu /quiet 
```


---
title: Install and Manage Extensions
description: Install and Manage Extensions in Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: daniellee-msft
ms.author: jol
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---
# Install and Manage Extensions

>Applies To: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center is built as an extensible platform where each connection type and tool is an extension that you can install, uninstall and update individually. You can search for new extensions published by Microsoft and other developers, and install and update them individually without having to update the entire Windows Admin Center installation. You can also configure a separate NuGet feed or file share and distribute extensions to use internally within your organization.

## Installing an extension

Windows Admin Center will show extensions available from the specified NuGet feed. By default, Windows Admin Center points to the Microsoft official NuGet feed which hosts extensions published by Microsoft and other developers.

1. Click the **Settings** button in the top-right > In the left pane, click **Extensions**. 
2. The **Available Extensions** tab will list the extensions on the feed that are available for installation.
3. Click on an extension to view the extension description, version, publisher and other information in the **Details** pane.
4. Click **Install** to install an extension. If the gateway must run in elevated mode to make this change, you will be presented with a UAC elevation prompt. After installation is complete, your browser will automatically be refreshed and Windows Admin Center will be reloaded with the new extension installed. If the extension you are trying to install is an update to a previously installed extension, you can click the **Update to latest** button to install the update. You can also go to the **Installed Extensions** tab to view installed extensions and see if an update is available in the **Status** column.

## Installing extensions from a different feed

Windows Admin Center supports multiple feeds and you can view and manage packages from more than one feed at a time. Any NuGet feed that supports the NuGet V2 APIs or a file share can be added to Windows Admin Center for installing extensions from.

1. Click the **Settings** button in the top-right > In the left pane, click **Extensions**.
2. On the right pane, click the **Feeds** tab.
3. Click the **Add** button to add another feed. For a NuGet feed, enter the NuGet V2 feed URL. The NuGet feed provider or administrator should be able to provide the URL information. For a file share, enter the full path of the file share in which the extension package files (.nupkg) are stored.
4. Click **Add**. If the gateway must run in elevated mode to make this change, you will be presented with a UAC elevation prompt.

The **Available Extensions** list will show extensions from all registered feeds. You can check which feed each extension is from using the **Package Feed** column.

## Uninstalling an extension

You can uninstall any extensions you have previously installed, or even uninstall any tools that were pre-installed as part of the Windows Admin Center installation.

1. Click the **Settings** button in the top-right > In the left pane, click **Extensions**. 
2. Click the **Installed Extensions** tab to view all installed extensions.
3. Choose an extension to uninstall, then click **Uninstall**.

After uninstall is complete, your browser will automatically be refreshed and Windows Admin Center will be reloaded with the extension removed. If you uninstalled a tool that was pre-installed as part of Windows Admin Center, the tool will be available for reinstallation in the **Available Extensions** tab.

## Installing extensions on a computer without internet connectivity

If Windows Admin Center is installed on a computer that isn't connected to the internet or is behind a proxy, it may not be able to access and install the extensions from the Windows Admin Center feed. You can download extension packages manually or with a PowerShell script, and configure Windows Admin Center to retrieve packages from a file share or local drive.

### Manually downloading extension packages

1. On another computer that has internet connectivity, open a web browser and navigate to the following URL: [https://msft-sme.myget.org/gallery/windows-admin-center-feed](https://msft-sme.myget.org/gallery/windows-admin-center-feed) 

   * You may need to create an account on msft-sme.myget.org and login to view the extension packages.

2. Click on the name of the package you want to install to view the package details page.
3. Click on the **Download** link in the right-side pane of the package details page and download the .nupkg file for the extension.
4. Repeat steps 2 and 3 for all the packages you want to download.
5. Copy the package files to a file share that can be accessed from the computer Windows Admin Center is installed on, or to the local disk of the computer.
6. [Follow the instructions to install extensions from a different feed](#installing-extensions-from-a-different-feed).

### Downloading packages with a PowerShell script

There are many scripts available on the Internet for downloading NuGet packages from a NuGet feed. We'll use the [script provided by Jon Galloway](https://weblogs.asp.net/jongalloway/downloading-a-local-nuget-repository-with-powershell), Senior Program Manager at Microsoft.

1. As described in the [blog post](https://weblogs.asp.net/jongalloway/downloading-a-local-nuget-repository-with-powershell), install the script as a NuGet package, or copy and paste the script into the PowerShell ISE.
2. Edit the first line of the script to your NuGet feed's v2 URL. If you are downloading packages from the Windows Admin Center official feed, use the URL below.

```powershell
$feedUrlBase = "https://aka.ms/sme-extension-feed"
```

3. Run the script and it will download all the NuGet packages from the feed to the following local folder: %USERPROFILE%\Documents\NuGetLocal
4. [Follow the instructions to install extensions from a different feed](#installing-extensions-from-a-different-feed).

## Manage extensions with PowerShell

>Applies To: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center Preview includes a PowerShell module to manage your gateway extensions.

```powershell
# Add the module to the current session
Import-Module "$env:ProgramFiles\windows admin center\PowerShell\Modules\ExtensionTools"
# Available cmdlets: Get-Feed, Add-Feed, Remove-Feed, Get-Extension, Install-Extension, Uninstall-Extension, Update-Extension

# List feeds
Get-Feed "https://wac.contoso.com"

# Add a new extension feed
Add-Feed -GatewayEndpoint "https://wac.contoso.com" -Feed "\\WAC\our-private-extensions"

# Remove an extension feed
Remove-Feed -GatewayEndpoint "https://wac.contoso.com" -Feed "\\WAC\our-private-extensions"

# List all extensions
Get-Extension "https://wac.contoso.com"

# Install an extension (locate the latest version from all feeds and install it)
Install-Extension -GatewayEndpoint "https://wac.contoso.com" "msft.sme.containers"

# Install an extension (latest version from a specific feed, if the feed is not present, it will be added)
Install-Extension -GatewayEndpoint "https://wac.contoso.com" "msft.sme.containers" -Feed "https://aka.ms/sme-extension-feed"

# Install an extension (install a specific version)
Install-Extension "https://wac.contoso.com" "msft.sme.certificate-manager" "0.133.0"

# Uninstall-Extension
Uninstall-Extension "https://wac.contoso.com" "msft.sme.containers"

# Update-Extension
Update-Extension "https://wac.contoso.com" "msft.sme.containers"
```

### [Learn more about building an extension with the Windows Admin Center SDK](../extend/extensibility-overview.md).
---
title: Install and Manage Extensions
description: Install and Manage Extensions in Windows Admin Center (Project Honolulu)
ms.topic: install-set-up-deploy
author: dknappettmsft
ms.author: daknappe
ms.date: 01/14/2021
---
# Install and manage extensions

Windows Admin Center is built as an extensible platform where each connection type and tool is an extension that you can install, uninstall, and update individually. You can search for new extensions published by Microsoft and other developers, and install and update them individually without having to update the entire Windows Admin Center installation. You can also configure a separate NuGet feed or file share and distribute extensions to use internally within your organization.

## Installing an extension

Windows Admin Center shows extensions available from the specified NuGet feed. By default, Windows Admin Center points to the Microsoft official NuGet feed which hosts extensions published by Microsoft and other developers.

1. Select the **Settings** button in the top-right > In the left pane, select **Extensions**.
1. The **Available Extensions** tab lists the extensions on the feed that are available for installation.
1. Select on an extension to view the extension description, version, publisher, and other information in the **Details** pane.
1. Select **Install** to install an extension. If the gateway must run in elevated mode to make this change, you're presented with a User Account Control (UAC) elevation prompt. After installation is complete, your browser automatically refreshes and Windows Admin Center reloads with the new extension installed. If the extension you're trying to install is an update to a previously installed extension, you can select the **Update to latest** button to install the update. You can also go to the **Installed Extensions** tab to view installed extensions and see if an update is available in the **Status** column.

## Installing extensions from a different feed

Windows Admin Center supports multiple feeds and you can view and manage packages from more than one feed at a time. Any NuGet feed that supports the NuGet V2 APIs or a file share can be added to Windows Admin Center for installing extensions from.

1. Select the **Settings** button in the top-right > In the left pane, select **Extensions**.
1. On the right pane, select the **Feeds** tab.
1. Select the **Add** button to add another feed. For a NuGet feed, enter the NuGet V2 feed URL. The NuGet feed provider or administrator should be able to provide the URL information. For a file share, enter the full path of the file share in which the extension package files (.nupkg) are stored. If adding a file share as a feed, it must meet the following criteria:
   - Access to the file must be granted to NTAuthority\Network Service
   - The file path can't include the C:\Users folder
   - The packages on the file share must be signed, unless [your operation mode is set to "Development"](/windows-server/manage/windows-admin-center/extend/prepare-development-environment#install-prerequisites)
1. Select **Add**. If the gateway must run in elevated mode to make this change, you're presented with a UAC elevation prompt. This prompt will only be presented if you're running Windows Admin Center in desktop mode.

The **Available Extensions** list shows extensions from all registered feeds. You can check which feed each extension is from using the **Package Feed** column.

## Uninstalling an extension

You can uninstall any extensions you have previously installed, or even uninstall any tools that were preinstalled as part of the Windows Admin Center installation.

1. Select the **Settings** button in the top-right > In the left pane, select **Extensions**.
1. Select the **Installed Extensions** tab to view all installed extensions.
1. Choose an extension to uninstall, then select **Uninstall**.

After uninstall is complete, your browser automatically refreshes and Windows Admin Center reloads with the extension removed. If you uninstalled a tool that was preinstalled as part of Windows Admin Center, the tool is available for reinstallation in the **Available Extensions** tab.

## Installing extensions on a computer without internet connectivity

If Windows Admin Center is installed on a computer that isn't connected to the internet or is behind a proxy, it may not be able to access and install the extensions from the Windows Admin Center feed. You can download extension packages manually or with a PowerShell script, and configure Windows Admin Center to retrieve packages from a file share or local drive.

### Manually downloading extension packages

1. On another computer that has internet connectivity, open a web browser and navigate to the following URL: [https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions](https://dev.azure.com/WindowsAdminCenter/Windows%20Admin%20Center%20Feed/_artifacts/feed/wac-public-extensions)

   You may need to create a Microsoft account and sign-in to view the extension packages.

1. Select the name of the package you want to install to view the package details page.
1. Select the **Download** link in the top navigation bar of the package details page and download the `.nupkg` file for the extension.
1. Repeat steps 2 and 3 for all the packages you want to download.
1. Copy the package files to a file share that can be accessed from the computer Windows Admin Center is installed on, or to the local disk of the computer on which Windows Admin Center is installed.
1. [Follow the instructions to install extensions from a different feed](#installing-extensions-from-a-different-feed).

### Downloading packages with a PowerShell script

There are scripts available on the Internet for downloading NuGet packages from a NuGet feed. We use the [script provided by Jon Galloway](https://weblogs.asp.net/jongalloway/downloading-a-local-nuget-repository-with-powershell), Senior Program Manager at Microsoft.

1. As described in the [blog post](https://weblogs.asp.net/jongalloway/downloading-a-local-nuget-repository-with-powershell), install the script as a NuGet package, or copy and paste the script into the PowerShell ISE.
1. Edit the first line of the script to your NuGet feed's v2 URL. If you're downloading packages from the Windows Admin Center official feed, use the following URL:

    ```powershell
    $feedUrlBase = "https://aka.ms/sme-extension-feed"
    ```

1. Run the script and it downloads all the NuGet packages from the feed to the following local folder: %USERPROFILE%\Documents\NuGetLocal
1. [Follow the instructions to install extensions from a different feed](#installing-extensions-from-a-different-feed).

## Manage extensions with PowerShell

Windows Admin Center Preview includes a PowerShell module to manage your gateway extensions.

[!INCLUDE [ps-extensions](../includes/ps-extensions.md)]

[Learn more about building an extension with the Windows Admin Center SDK](../extend/extensibility-overview.md).

## Gateway plug-in extensions

Windows Admin Center gateway plug-in extensions are most impacted by the changes to our modernized gateway. Windows Admin Center gateway plug-ins enable API communication from the UI of your tool or solution to a target node. Windows Admin Center hosts a gateway service that relays commands and scripts from gateway plug-ins to be executed on target nodes. The gateway service can be extended to include custom gateway plug-ins that support protocols other than the default ones (PowerShell and WMI).

Because gateway plug-ins communicate with Windows Admin Center’s backend to enable API communication, gateway plug-in code can include components written with the .NET framework version 4.6.2, which won't function with .NET 8.

Additionally, we've modified the way plug-ins work with version 2410. Instead of developing a C# class that implements the `IPlugIn` interface from the `Microsoft.ManagementExperience.FeatureInterfaces` namespace to extend the gateway plug-in, extensions will now be written in the form of [ASP.NET MVC controllers](/aspnet/mvc/overview/older-versions-1/controllers-and-routing/aspnet-mvc-controllers-overview-cs). These controllers have increased flexibility compared to the simple C# class and extensive documentation.

[View our developer documentation](../extend/develop-gateway-plugin.md) to learn more about gateway plug-in development in Windows Admin Center.

## Gateway extensions not supported

The extension feed for the Windows Admin Center gateway isn't configured. Extensions not included in the Windows Admin Center installer, including external partner extensions, aren't available unless you add an extension feed.

The following extensions are available upon install of the modernized gateway build:

- Apps & features
- Azure Backup
- Azure File Sync
- Azure hybrid center
- Azure Kubernetes Service
- Certificates
- Cluster Creation
- Cluster Manager
- Developer Guide
- Devices
- Events
- Failover cluster tools
- Files & file sharing
- Firewall
- Local users & groups
- Network Controller tools and SDN Virtual networks
- Networks
- Packet monitoring
- Performance Monitor
- PowerShell
- Processes
- Registry
- Remote Desktop
- Roles & features
- Scheduled tasks
- SDN Gateway connections
- SDN Infrastructure
- SDN Logical networks
- SDN Network security groups
- Security
- Server Manager and Computer Management
- Services
- Storage
- Storage Migration Service
- Storage Replica
- System Insights
- Updates
- Virtual machines and switches

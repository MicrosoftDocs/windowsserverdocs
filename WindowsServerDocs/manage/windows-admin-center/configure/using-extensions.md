---
title: Install and Manage Extensions
description: Install and Manage Extensions in Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: daniellee-msft
ms.author: jol
ms.date: 06/18/2018
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
4. Click **Install** to install an extension. You may encounter an error that the gateway must run in elevated mode to make this change and then will be presented with a UAC elevation prompt. If you provide consent, Windows Admin Center will be opened in a new browser tab in elevated mode. Repeat these steps in the elevated session to change the feed.

After installation is complete, your browser will automatically be refreshed and Windows Admin Center will be reloaded with the new extension installed.

> [!NOTE]
> The Extension manager has the following limitations. We are planning to improve this in future updates.
> - Installed extensions are currently not persisted when you upgrade to a newer version of Windows Admin Center. You will need to manually reinstall extensions after upgrade for now.

## Installing extensions from a different feed

Windows Admin Center supports multiple feeds and you can view and manage packages from more than one feed at a time. Any NuGet feed that supports the NuGet V2 APIs or a file share can be added to Windows Admin Center for installing extensions from.

1. Click the **Settings** button in the top-right > In the left pane, click **Extensions**.
2. On the right pane, click the **Feeds** tab.
3. Click the **Add** button to add another feed. For a NuGet feed, enter the NuGet V2 feed URL. The NuGet feed provider or administrator should be able to provide the URL information. For a file share, enter the full path of the file share in which the extension package files (.nupkg) are stored.
4. Click **Add**. You may encounter an error that the gateway must run in elevated mode to make this change and then will be presented with a UAC elevation prompt. If you provide consent, Windows Admin Center will be opened in a new browser tab in elevated mode. Repeat these steps in the elevated session to change the feed.

The **Available Extensions** list will show extensions from all registered feeds. You can check which feed each extension is from using the **Package Feed** column.

## Uninstalling an extension

You can uninstall any extensions you have previously installed, or even uninstall any tools that were pre-installed as part of the Windows Admin Center installation.

1. Click the **Settings** button in the top-right > In the left pane, click **Extensions**. 
2. Click the **Installed Extensions** tab to view all installed extensions.
3. Choose an extension to uninstall, then click **Uninstall**.

After uninstall is complete, your browser will automatically be refreshed and Windows Admin Center will be reloaded with the extension removed. If you uninstalled a tool that was pre-installed as part of Windows Admin Center, the tool will be available for reinstallation in the **Available Extensions** tab.

## Installing extensions on a computer without internet connectivity

If Windows Admin Center is installed on a computer that isn't connected to the internet or is behind a proxy, it may not be able to access and install the extensions from the Windows Admin Center feed. You can download extension packages manually and configure Windows Admin Center to retrieve packages from a file share or local drive.

1. On another computer that has internet connectivity, open a web browser and navigate to the following URL: [https://msft-sme.myget.org/feed/Packages/windows-admin-center-feed](https://msft-sme.myget.org/feed/Packages/windows-admin-center-feed) 

  * You may need to create an account on msft-sme.myget.org and login to view the extension packages.

2. Click on the name of the package you want to install to view the package details page.
3. Click on the **Download** link in the right-side pane of the package details page and download the .nupkg file for the extension.
4. Repeat steps 2 and 3 for all the packages you want to download.
5. Copy the package files to a file share that can be accessed from the computer Windows Admin Center is installed on, or to the local disk of the computer.
6. [Follow the instructions above](#installing-extensions-from-a-different-feed) to add the file share or local folder location as an additional feed. 

### [Learn more about building an extension with the Windows Admin Center SDK](../extend/extensibility-overview.md).
---
author: daniellee-msft
---

<a href="../overview.md">Windows Admin Center</a> > <a href="../overview.md">Configure</a> > Install and Manage Extensions

# Install and Manage Extensions

[Content goes here]

[TODO:legacy-content-begin]

Windows Admin Center is built as an extensible platform where each connection type and tool is an extension that you can install, uninstall and update individually. You can search for new extensions published by Microsoft and other developers, and install and update them individually without having to update the entire Windows Admin Center installation. You can also use the Extension Manager to configure a separate NuGet feed and distribute extensions for internal usage within your organization.

## Installing an extension ##

The Extension Manager will show extensions available from the specified NuGet feed. By default, the Extension Manager points to the Microsoft official NuGet feed which hosts extensions published by Microsoft and other developers.

1. Click the **Settings** button in the top-right. > In the **General** tab, click **Manage Extensions**.
2. The **Available Extensions** tab will list the extensions on the feed that are available for installation.
3. Click on an extension to view the extension description, version, publisher and other information in the **Details** pane.
4. Click **Install** to install an extension.

After installation is complete, your browser will automatically be refreshed and Windows Admin Center will be reloaded with the new extension installed.

**NOTE:** Installed extensions are currently not persisted when you upgrade to a newer version of Windows Admin Center. You will need to manually reinstall extensions after upgrade for now.

**NOTE:** Windows Admin Center does not currently notify you when an update is available for a previously installed extension.

**NOTE:** Windows Admin Center does not currently support upgrade of extensions. You will need to uninstall the previous version and install the newer version yourself.

## Installing extensions from a different feed ##

You can configure Windows Admin Center to show extensions from any NuGet feed that supports the NuGet V2 APIs or a file share.

1. Click the **Settings** button in the top-right. > In the **General** tab, click **Manage Extensions**.
2. In the **Available Extensions** tab, click **Settings**.
3. For a NuGet feed, enter the NuGet V2 feed URL. The NuGet feed provider or administrator should be able to provide the URL information. For a file share, enter the full path of the file share in which the extension package files (.nupkg) are stored.
4. Click **Save**. You may encounter an error that the gateway must run in elevated mode to make this change and then will be presented with a UAC elevation prompt. If you provide consent, WAC will be opened in a new browser tab in elevated mode. Repeat these steps in the elevated session to change the feed.
5. Click **Close**.

The **Available Extensions** list will show extensions from the new feed or file share.

## Uninstalling an extension ##

You can uninstall any extensions you have previously installed, or even uninstall any tools that were pre-installed as part of the WAC installation.

1. Click the **Settings** button in the top-right. > In the **General** tab, click **Manage Extensions**.
2. Click the **Installed Extensions** tab to view all installed extensions.
3. Choose an extension to uninstall, then click **Uninstall**.

After uninstall is complete, your browser will automatically be refreshed and WAC will be reloaded with the extension removed. If you uninstalled a tool that was pre-installed as part of WAC, the tool will be available for reinstallation in the **Available Extensions** tab.

[Learn more about building an extension with the WAC SDK.](../extend/use-sdk.md)
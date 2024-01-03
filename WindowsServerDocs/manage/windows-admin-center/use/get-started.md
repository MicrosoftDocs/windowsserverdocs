---
title: Get started with Windows Admin Center
description: Get started with Windows Admin Center
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.date: 09/21/2022
---

# Get Started with Windows Admin Center

> Applies to: Windows Admin Center, Windows Admin Center Preview

This article describes how to get started with Windows Admin Center after you've downloaded it and installed it on a Windows PC. [Download Windows Admin Center](https://www.microsoft.com/evalcenter/download-windows-admin-center). To read about installing, see [Install Windows Admin Center on a PC or server](../../windows-admin-center/deploy/install.md). To learn more about Windows Admin Center, see [Windows Admin Center overview](../overview.md).

## Open Windows Admin Center on a Windows PC

Windows Admin Center enables you to manage servers, clusters, Windows PCs, and Azure virtual machines (VMs) directly from your Windows 10 computer using a web browser.

> [!IMPORTANT]
> You must be a member of the local administrator's group to use Windows Admin Center on Windows 10.

Follow these steps to open Windows Admin Center on a Windows PC:

1. From the **Start** menu, select Windows Admin Center. Or type **Windows Admin Center** in the search bar and then select it from the search results. Windows Admin Center opens in your default browser with the URL: `https://localhost:6516/`. Alternatively, you can also start it from your desired browser by entering `https://localhost:6516/`.

   A prompt for selecting a certificate for authentication is displayed.

   > [!NOTE]
   > In the [modernized gateway build of Windows Admin Center](../understand/modernized-gateway.md), instead of being prompted for a certificate, you will be asked to log into the Windows Admin Center gateway. Step two does not apply.
1. Select the certificate labeled **Windows Admin Center Client**, then select **OK**. You can also select the **Certificate information** link to see more details about the certificate.

   :::image type="content" source="../media/launch/select-certificate.png" alt-text="Screenshot of the prompt showing options to select a certificate.":::

   > [!IMPORTANT]
   > Make sure to select the **Windows Admin Center Client** certificate when prompted, and not any other certificate. If you select any other certificate, the following error message appears:
   >
   > *You are not authorized to view this page. If you recently updated Windows Admin Center, you may need to restart your browser, and then refresh the page.*
   >
   > If you continue to get the same error even after restarting your browser and refreshing the page, try clearing the browser cache or switching to another browser. If none of these troubleshooting steps resolve the issue, you may need to uninstall and reinstall Windows Admin Center, and then restart it.

1. (First time only) A pop-up window appears confirming that your Windows Admin Center version is successfully installed. It also provides information on what's new in this release. Close the window to proceed.

   :::image type="content" source="../media/successful-install-message.png" alt-text="Screenshot of the message showing that Windows Admin Center is successfully installed.":::

   The **All connections** page is displayed with your Windows 10 computer name listed under the list of connections. You're now ready to add connections to Windows Admin Center.

## Add connections to Windows Admin Center

You can add connections as managed nodes to Windows Admin Center from the **All connections** page. This is the default page that appears when you launch Windows Admin Center. From this page, you can either add existing resources as connections or create new resources. The resources that you add appear under the list of connections on the **All connections** page.

The type of resources that you can add from the **All connections** page are servers, Windows PCs, clusters, and Azure VMs and the resources that you can create are clusters and Azure VMs.

> [!NOTE]
> To add or create an Azure VM, you must first register Windows Admin Center with Azure.

To add connections to Windows Admin Center:

1. Click **+ Add** under **All connections**.

   :::image type="content" source="../media/launch/use-get-started-4.png" alt-text="Screenshot of All Connections page.":::

2. The type of resource that you can add are displayed. Select **Add** for the resource type that you want to add.

   :::image type="content" source="../media/launch/use-get-started-5.png" alt-text="Screenshot of Add resources page displaying resource types to add.":::
   
3. Windows Admin Center supports various methods to add resources depending on the resource type:

   - Add one resource at a time
   - Add multiple resources by bulk importing
   - Add resources by searching the Active Directory

   Select the tab based on how you want to add resources. The label for each tab can differ based on the resource type you're adding.

   ### [Add one](#tab/add-one)
   This is the default method. The label for this tab appears as **Add cluster** when adding a cluster.
    
   1. Select the **Add one** or **Add cluster** tab. This tab is selected by default.
    
   1. Enter the name of the resource in the resource name box.
      
      :::image type="content" source="../media/launch/use-get-started-6.png" alt-text="Screenshot of Add resources page when the Add one tab is selected." lightbox="../media/launch/use-get-started-6.png":::
      
      As you begin entering text, Windows Admin Center starts searching for a resource based on your input text string. If a match is found, you can add the name exactly as you entered or use the default resource name. If no match is found, you can still add this resource to appear in your list of connections.

   ### [Import a list](#tab/import-a-list)

   You can add multiple resources at once by bulk importing from a .txt or .csv file. The label for this tab appears as **Import clusters** when bulk importing multiple clusters. See [CSV file format for importing connections](#csv-file-format-for-importing-connections).

   1. Select the **Import a list** tab. Or **Import clusters** for bulk importing clusters.
   
      :::image type="content" source="../media/launch/use-get-started-7.png" alt-text="Screenshot of Add resources page when the Import a list tab is selected." lightbox="../media/launch/use-get-started-7.png":::

   1. Select the **Select a file** button to browse and select the file to import. Or drag and drop the file under the **Import Source** panel. The file can be a .txt or .csv file that contains a comma, or new line separated, list of resources you want to add.

   > [!Note]
   > The .csv file created by [exporting your connections with PowerShell](#use-powershell-to-import-or-export-your-connections-with-tags) contains additional information beyond the server names and is not compatible with this import method.

   ### [Search Active Directory](#tab/search-active-directory)

   To use this search option, your Windows Admin Center computer must be joined to an Active Directory (AD) domain and your account must have permission to read from AD.

   1. Select the **Search Active Directory** tab.

      :::image type="content" source="../media/launch/use-get-started-8.png" alt-text="Screenshot of Add resources page when the Search Active Directory tab is selected." lightbox="../media/launch/use-get-started-8.png":::

   1. Enter your search criteria and select **Search**. Wildcards (*) are supported.

---

4. (Optional) Select **Add tags** to add connection tags. You can use tags to identify and filter related resources in your connection list. For more information about using tags, see [Use tags to organize your connections](#use-tags-to-organize-your-connections).

5. When you're done adding resources, select **Add**.

   The selected resources are displayed under the connections list on the **All connections** page.

## Authenticate with the managed nodes

After you've added connections as managed nodes, you must authenticate with them to connect. 
Windows Admin Center supports several mechanisms for authenticating with a managed node. Single sign-on is the default.

> [!NOTE] 
> To perform remote management, Windows Admin Center impersonates the provided user's security context and uses that security context to access the machine. The provided user is listed under the "Managing As" column on the All Connections page.

### Authenticate by single sign-on

You can use your current Windows credentials to authenticate with the managed node. This is the default, and Windows Admin Center attempts the single sign-on when you add a resource.

### Authenticate by single sign-on when deployed as a service on Windows Server

If you've installed Windows Admin Center on Windows Server, additional configuration is required for single sign-on. For more information, see [Configure your environment for delegation](../configure/user-access-control.md).

### Authenticate by specifying credentials

Under **All connections**, select a resource from the list and choose **Manage as** to specify the credentials that you'll use to authenticate to the managed node:

:::image type="content" source="../media/launch/use-get-started-9.png" alt-text="Screenshot of the All connections page with the Manage As option.":::

If Windows Admin Center is running in service mode on Windows Server, but you don't have Kerberos delegation configured, you must re-enter your Windows credentials:

:::image type="content" source="../media/launch/use-get-started-10.png" alt-text="Screenshot of the Specify your credentials page.":::

You may apply the credentials to all connections, which will cache them for that specific browser session. If you reload your browser, you must re-enter your **Manage as** credentials.

### Authenticate by Local Administrator Password Solution

If your environment uses [Local Administrator Password Solution (LAPS)](/previous-versions/mt227395(v=msdn.10)), and you have Windows Admin Center installed on your Windows 10 PC, you can use LAPS credentials to authenticate with the managed node. If you use this scenario, [provide feedback here](https://aka.ms/WACFeedback).

## Use tags to organize your connections

You can use tags to identify and filter related resources in your connection list. This allows you to see a subset of your resources in the connection list. This is especially useful if you have many connections.

### Edit tags

You can add tags to a connection while you're adding a new connection. Or you can add or edit them later for one or more connections from the **All connections** page.

To add or edit a tag:

1. Select one or more connections from the list of connections.

1. Select **Edit Tags**.

   :::image type="content" source="../media/launch/use-get-started-11.png" alt-text="Screenshot of the Edit tags option.":::

   The **Available tags** pane opens on the right.

1. Add, edit, or remove tags from the selected connections.

   - To add a new tag to your selected connections, select **Add tag** and enter a desired tag name.

   - To tag the selected connections with an existing tag name, select the checkbox next to the tag name you wish to apply.

   - To remove a tag from all selected connections, clear the checkbox next to the tag you wish to remove.

   - If a tag is applied to a subset of the selected connections, the checkbox is shown in an intermediate state. You can select the checkbox to select it and apply the tag to all selected connections, or select again to clear it and remove the tag from all selected connections.
   
      :::image type="content" source="../media/launch/use-get-started-12.png" alt-text="Screenshot of the available tags.":::

1. When finished, select **Save** to save your changes.

### Filter connections by tag

After tags are added to one or more connections, you can view the tags on the connection list, and filter the connection list by tags.

- To filter by a tag, select the filter icon next to the search box.

   :::image type="content" source="../media/launch/use-get-started-13.png" alt-text="Screenshot of the filter using the search box." lightbox="../media/launch/use-get-started-13.png":::
   
- You can select "Or", "And", or "Not" to modify the filter behavior of the selected tags.

   :::image type="content" source="../media/launch/use-get-started-14.png" alt-text="Screenshot of the Filter Connections page.":::

## Use PowerShell to import or export your connections with tags

[!INCLUDE [ps-connections](../includes/ps-connections.md)]

## View PowerShell scripts used in Windows Admin Center

Once you've connected to a server, cluster, or PC, you can look at the PowerShell scripts that power the UI actions available in Windows Admin Center. From within a tool, click the PowerShell icon in the top application bar. Select a command of interest from the dropdown to navigate to the corresponding PowerShell script.

:::image type="content" source="../media/launch/showscript.png" alt-text="Screenshot of the View PowerShell scripts for Overview page.":::

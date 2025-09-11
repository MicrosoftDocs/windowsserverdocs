---
title: Get Started with Windows Admin Center
description: Get started with Windows Admin Center after you download and install it on a Windows PC.
ms.topic: get-started
author: robinharwood
ms.author: roharwoo
ms.date: 07/24/2025
ms.custom: sfi-image-nochange
---

# Get started with Windows Admin Center

Windows Admin Center is a browser-based management tool that simplifies the administration of servers, clusters, Windows PCs, and Azure virtual machines.

This article describes how to get started with Windows Admin Center after you [download](https://www.microsoft.com/evalcenter/download-windows-admin-center) and [install](../../windows-admin-center/deploy/install.md) it on a Windows PC. To learn more about Windows Admin Center, see [Windows Admin Center overview](../overview.md).

## Open Windows Admin Center on a Windows PC

> [!IMPORTANT]
> You must be a member of the local administrators group to use Windows Admin Center.

Follow these steps to open Windows Admin Center on a Windows PC:

1. On the **Start** menu, select **Windows Admin Center (v2)**. Or enter **Windows Admin Center (v2)** on the search bar and then select it from the search results.

   Your default browser opens with the sign in screen for Windows Admin Center.

   - Windows client operating systems are configured for local access using port 6600.

   - Windows Server operating systems are configured for remote access using port 443.

1. Sign in to Windows Admin Center using your administrator credentials.

1. A prompt for selecting a certificate for authentication appears.

1. (First time only:) A pop-up window confirms that your Windows Admin Center version is successfully installed. It also provides information on what's new in this release. Close the window to proceed.

   :::image type="content" source="../media/get-started/successfully-installed.png" alt-text="Screenshot of the message that shows successful installation of Windows Admin Center.":::

   The **All connections** page shows your Windows computer name in the list of connections. You're now ready to add connections to Windows Admin Center.

## Add connections to Windows Admin Center

To add or create an Azure VM, you must first register Windows Admin Center with Azure. You can add connections as managed nodes to Windows Admin Center from the **All connections** page. **All connections** is the default page that appears when you open Windows Admin Center. On this page, you can either add existing resources as connections or create new resources. The resources that you add appear in the connection list.

The types of resources that you can add from the **All connections** page are servers, Windows PCs, clusters, and Azure VMs. The resources that you can create are clusters and Azure VMs.

To add connections to Windows Admin Center:

1. Under **All connections**, select **+ Add**.

   :::image type="content" source="../media/launch/use-get-started-4.png" alt-text="Screenshot of the page that lists all connections.":::

2. The types of resources that you can add are displayed. Select **Add** for the resource type that you want to add.

   :::image type="content" source="../media/launch/use-get-started-5.png" alt-text="Screenshot of the page for adding resources, with resource types displayed.":::

3. Windows Admin Center supports various methods to add resources, depending on the resource type:

   - Add one resource at a time.
   - Add multiple resources by bulk importing.
   - Add resources by searching Active Directory.

   Select the tab based on how you want to add resources. The label for each tab can differ based on the resource type that you're adding.

   ### [Add one](#tab/add-one)

   Adding one resource at a time is the default method. The label for this tab appears as **Add cluster** when you're adding a cluster.

   1. Select the **Add one** or **Add cluster** tab.

   1. In the **Server name** box, enter the name of the resource.

      :::image type="content" source="../media/launch/use-get-started-6.png" alt-text="Screenshot of the page for adding resources when the tab for adding one resource is selected." lightbox="../media/launch/use-get-started-6.png":::

      As you begin entering text, Windows Admin Center starts searching for a resource based on your text string. If a match is found, you can add the name exactly as you entered it or use the default resource name. If no match is found, you can still add this resource to appear in your list of connections.

   ### [Import a list](#tab/import-a-list)

   You can add multiple resources at once by bulk importing from a .txt or .csv file. The label for this tab appears as **Import clusters** when you bulk import multiple clusters.

   1. Select the **Import a list** tab. Or select **Import clusters** to bulk import clusters.

   1. Under **Import source**, select the **Select a file** button to browse and select the file to import. Or drag and drop the file. The file can be a .txt or .csv file that contains a comma, or a new line-separated list of resources that you want to add.

      :::image type="content" source="../media/launch/use-get-started-7.png" alt-text="Screenshot of the page for adding resources when the tab for importing a list is selected." lightbox="../media/launch/use-get-started-7.png":::

   > [!NOTE]
   > The .csv file created by [exporting your connections with PowerShell](#use-powershell-to-import-or-export-your-connections-with-tags) contains extra information beyond the server names. It's not compatible with this import method.

   ### [Search Active Directory](#tab/search-active-directory)

   To use this search option, your Windows Admin Center computer must be joined to an Active Directory domain, and your account must have permission to read from Active Directory.

   1. Select the **Search Active Directory** tab.

      :::image type="content" source="../media/launch/use-get-started-8.png" alt-text="Screenshot of the page for adding resources when the Search Active Directory tab is selected." lightbox="../media/launch/use-get-started-8.png":::

   1. Enter your search criteria and then select **Search**. Wildcards (*) are supported.

---

4. (Optional:) Select **Add tags** to add connection tags. You can use tags to identify and filter related resources in your connection list. For more information, see [Use tags to organize your connections](#use-tags-to-organize-your-connections) later in this article.

5. When you finish adding resources, select **Add**.

   The selected resources appear in the connection list on the **All connections** page.

## Authenticate with the managed nodes

After you add connections as managed nodes, you must authenticate with them to connect.

Windows Admin Center supports several mechanisms for authenticating with a managed node. Single sign-on is the default.

> [!NOTE]
> To perform remote management, Windows Admin Center impersonates the provided user's security context and uses that security context to access the machine. The provided user is listed in the **Managing As** column on the **All Connections** page.

### Authenticate by single sign-on

You can use your current Windows credentials to authenticate with the managed node. This authentication is the default, and Windows Admin Center attempts the single sign-on when you add a resource.

### Authenticate by single sign-on when Windows Admin Center is deployed as a service on Windows Server

If you installed Windows Admin Center on Windows Server, additional configuration is required for single sign-on. For more information, see [Configure single sign-on](../configure/user-access-control.md#configure-single-sign-on).

### Authenticate by specifying credentials

1. In **All connections**, select a resource from the list.
1. Select **Manage as** to specify your credentials to authenticate to the managed node.

   :::image type="content" source="../media/launch/use-get-started-9.png" alt-text="Screenshot of the page for all connections with the command for using specific credentials for management.":::

1. If Windows Admin Center is running in service mode on Windows Server, but you don't have Kerberos delegation configured, you must reenter your Windows credentials.

   :::image type="content" source="../media/launch/use-get-started-10.png" alt-text="Screenshot of the page for specifying credentials.":::

You can apply the credentials to all connections, which will cache them for that specific browser session. If you reload your browser, you must reenter your **Manage as** credentials.

### Authenticate by Local Administrator Password Solution

If your environment uses [Local Administrator Password Solution (LAPS)](/previous-versions/mt227395(v=msdn.10)), and you have Windows Admin Center installed on your Windows PC, you can use LAPS credentials to authenticate with the managed node. If you use this scenario, you can [provide feedback](https://aka.ms/WACFeedback).

## Use tags to organize your connections

You can use tags to identify and filter related resources in your connection list. The ability to view a subset of your resources in the connection list is especially useful if you have many connections.

### Edit tags

You can add tags to a connection while you add a new connection. Or you can add or edit them later. For one or more connections on the **All connections** page.

To add or edit a tag:

1. In the list of connections, select one or more connections.

1. Select **Edit Tags**.

   :::image type="content" source="../media/launch/use-get-started-11.png" alt-text="Screenshot of the Edit Tags command.":::

1. On the **Available tags** pane, you can take any of these actions:

   - To add a new tag to your selected connections, select **Add tags** and enter a desired tag name.

   - To tag the selected connections with an existing tag name, select the checkbox next to the tag name that you want to apply.

   - To remove a tag from all selected connections, clear the checkbox next to the tag that you want to remove.

   - If a tag is applied to a subset of the selected connections, the checkbox appears in an intermediate state. You can select the checkbox and apply the tag to all selected connections, or clear the checkbox to remove the tag from all selected connections.

      :::image type="content" source="../media/launch/use-get-started-12.png" alt-text="Screenshot of the available tags.":::

1. Select **Save** to save your changes.

### Filter connections by tag

After you add tags to one or more connections, you can view the tags in the connection list and filter the connection list by tags.

To filter by a tag, select the filter icon next to the search box.

:::image type="content" source="../media/launch/use-get-started-13.png" alt-text="Screenshot of the filter icon." lightbox="../media/launch/use-get-started-13.png":::

You can select **Or**, **And**, or **Not** to modify the filter behavior of the selected tags.

:::image type="content" source="../media/launch/use-get-started-14.png" alt-text="Screenshot of the Or, And, and Not options for filter connections.":::

## Use PowerShell to import or export your connections with tags

[!INCLUDE [ps-connections](../includes/ps-connections.md)]

## View PowerShell scripts used in Windows Admin Center

After you connect to a server, cluster, or PC, you can view the PowerShell scripts that power the UI actions available in Windows Admin Center:

1. From within a tool, select the PowerShell icon on the application bar.

1. In the dropdown list, select a command of interest to go to the corresponding PowerShell script.

   :::image type="content" source="../media/launch/showscript.png" alt-text="Screenshot of the page for viewing PowerShell scripts for an overview.":::


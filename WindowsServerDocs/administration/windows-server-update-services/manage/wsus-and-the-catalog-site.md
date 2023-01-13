---
title: WSUS and the Catalog Site
description: Windows Server Update Service (WSUS) article - How to import hotfixes into WSUS by accessing the Microsoft Update catalog site
ms.topic: article
ms.assetid: f19a8659-5a96-4fdd-a052-29e4547fe51a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 01/11/2023
---
# WSUS and the Catalog Site

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The [Catalog Site](https://www.catalog.update.microsoft.com) is the Microsoft location from which you can import software updates, drivers, and hotfixes.

## The Microsoft Update Catalog Site

In order to import hotfixes into WSUS, you must access the Microsoft Update Catalog Site from a WSUS computer. Any computer that has the WSUS administrative console installed, whether or not it's a WSUS server, can be used to import hotfixes from the Catalog Site. You must be logged on to the computer as an administrator to import the hotfixes.

### To access the Microsoft Update Catalog Site

1. In the WSUS administrative console, select either the top server node or **Updates**, and in the **Actions** pane select **Import Updates**. A browser window will open at the Microsoft Update Catalog Web site.

1. You can browse this site for Windows hotfixes and hardware drivers. When you have found the ones you want, add them to your basket.

1. When you have finished browsing, go to the basket and select import to import your updates. To download the updates without importing them, clear the **Import directly into Windows Server Update Services** checkbox.

Approved updates imported from the Microsoft Update Catalog Site are downloaded the next time the WSUS server synchronizes. They aren't downloaded at the time of import from the Microsoft Update Catalog Site.

You must access the Microsoft Update Catalog Site through the WSUS console to ensure that the updates are imported in a WSUS-compatible format. If you access the Microsoft Update Catalog website manually, any updates that you download aren't imported into the WSUS server, but instead are downloaded as individual `.MSU` files. WSUS doesn't currently have a supported mechanism for importing files in the `.MSU` format.

> [!NOTE]
> You can remove updates that are imported from the Microsoft Update Catalog that are set as either **Not Approved** or **Declined**, by running the WSUS Server cleanup Wizard. You can re-import updates that have been previously removed from your WSUS systems through the Microsoft Update Catalog.

## Restricting access to hotfixes

WSUS administrators might consider restricting access to the hotfixes they've downloaded from the Microsoft Update Catalog Site. To restriction the available hotfixes complete the following steps:

1. Start the **Internet Information Services (IIS) Manager** console.

1. Navigate to the **Content** node under **WSUS Administration** web site.

1. On the **Content Home** pane, double-click in the **Authentication** option.

1. Select **Anonymous Authentication** and select **Disable** in the **Actions** pane on the right.

1. Select **Windows Authentication** and select **Enable** in the **Actions** pane on the right.

1. In the WSUS administrative console, create a WSUS target group for the computers that need the hotfix, and add them to the group. For more information about computers and groups, see [Managing WSUS Client computers and WSUS computer Groups](managing-wsus-client-computers-and-wsus-computer-groups.md) in this guide, and [Configure WSUS computer groups](../deploy/2-configure-wsus.md#24-configure-wsus-computer-groups) in the WSUS deployment guide.

1. Download the files for the hotfix.

1. Set the permissions of these files so that only machine accounts of those machines can read them. You'll also need to allow the Network Service account full access to the files.

1. Approve the hotfix for the WSUS target group created in Step 2.

## Importing updates in different languages

The Microsoft Update Catalog Web site includes updates that support multiple languages.

> [!IMPORTANT]
> Match the languages supported by the WSUS server with the languages supported by the imported updates.

If the WSUS server doesn't support all the languages included in the update, the update won't be deployed to client computers. If an update supporting multiple languages has been downloaded to the WSUS server but not yet deployed to client computers, and an administrator deselects one of the languages included in the update, the update won't be deployed to the clients.

---
title: WSUS and the Catalog Site
description: "Windows Server Update Service (WSUS) topic - How to import hotfixes into WSUS by accessing the Microsoft Update catalog site"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-wsus
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f19a8659-5a96-4fdd-a052-29e4547fe51a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# WSUS and the Catalog Site

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Catalog Site is the Microsoft location from which you can import hotfixes and hardware drivers.

## The Microsoft Update Catalog Site
In order to import hotfixes into WSUS, you must access the Microsoft Update Catalog Site from a WSUS computer. Any computer that has the WSUS administrative console installed, whether or not it is a WSUS server, can be used to import hotfixes from the Catalog Site. You must be logged on to the computer as an administrator to import the hotfixes.

#### To access the Microsoft Update Catalog Site

1.  In the WSUS administrative console, select either the top server node or  **Updates**, and in the **Actions** pane click **import Updates**. A browser window will open at the Microsoft Update Catalog Web site.

2.  In order to access the updates at this site, you must install the Microsoft Update Catalog activeX control.

3.  You can browse this site for Windows hotfixes and hardware drivers. When you have found the ones you want, add them to your basket.

4.  When you have finished browsing, go to the basket and click import to import your updates. To download the updates without importing them, clear the **import directly into Windows Server Update Services** checkbox.

Approved updates imported from the Microsoft Update Catalog Site are downloaded the next time the WSUS server synchronizes. They are not downloaded at the time of import from the Microsoft Update Catalog Site.

Note that you must access the Microsoft Update Catalog Site though the WSUS console to ensure that the updates are imported in a WSUS-compatible format. If you access the Microsoft Update Catalog website manually, any updates that you download are not imported into the WSUS server, but instead are downloaded as individual *.MSU files. WSUS does not currently have a supported mechanism for importing files in the \*.MSU format.

If you run The Server cleanup Wizard, updates imported from the Microsoft Update Catalog that are set as Not Approved or as Declined may be removed from the WSUS server. If they are removed, they can be re-imported from the Microsoft Update Catalog.

> [!NOTE]
> You can remove updates that are imported from the Microsoft Update Catalog that are set as either Not Approved or Declined, by running the WSUS Server cleanup Wizard. You can re-imported updates that have been previously removed from your WSUS systems through the Microsoft Update Catalog.

## Restricting access to hotfixes
WSUS administrators might consider restricting access to the hotfixes they have downloaded from the Microsoft Update Catalog Site. In order to make this restriction follow the steps below:

#### To restrict access to hotfixes

1.  Enable Windows authentication on the IIS Content vroot.

    -   Start IIS Manager.

    -   Navigate to the content node under WSUS Administration web site.

    -   On the **Content Home** pane, double click in the **Authentication** option.

    -   Select **Anonymous Authentication** and click **Disable** in the **Actions** pane on the right.

    -   Select **Windows Authentication** and click **Enable** in the **Actions** pane on the right.

2.  Create a WSUS target group for the computers that need the hotfix, and add them to the group. For more information about computers and groups, see [Managing WSUS Client computers and WSUS computer Groups](managing-wsus-client-computers-and-wsus-computer-groups.md) in this guide, and section [3.3. Configure WSUS computer groups](../deploy/2-configure-wsus.md#23-configure-wsus-computer-groups) of Step 3: Configure WSUS, in the WSUS deployment guide.

3.  Download the files for the hotfix.

4.  Set the permissions of these files so that only machine accounts of those machines can read them. You will also need to allow the Network Service account full access to the files.

5.  Approve the hotfix for the WSUS target group created in Step 2.

## Importing updates in different languages
The Microsoft Update Catalog Web site includes updates that support multiple languages. It is very **important** to match the languages supported by the WSUS server with the languages supported by these updates. If the WSUS server does not support all the languages included in the update, the update will not be deployed to client computers. Likewise, if an update supporting multiple languages has been downloaded to the WSUS server but not yet deployed to client computers, and an administrator deselects one of the languages included the update, the update will not be deployed to the clients.

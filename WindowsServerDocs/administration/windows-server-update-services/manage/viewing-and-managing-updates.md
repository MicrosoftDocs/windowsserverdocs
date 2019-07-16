---
title: Viewing and Managing Updates
description: "Windows Server Update Service (WSUS) topic - How to view and manage updates in the WSUS console"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-wsus
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac70192b-0309-4385-b697-2e8eda51911c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Viewing and Managing Updates

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use the WSUS console to view and manage updates.

## Viewing Updates
On the **Updates** page, you can do the following:

-   View updates. The update overview displays updates that have been synchronized from the update source to your WSUS server and are available for approval.

-   Filter updates. In the default view you can filter updates by approval status and installation status. The default setting is for unapproved updates that are needed by some clients or that have had installation failures on some clients. You can change this view by changing the approval status and installation status filters, and then clicking **Refresh**.

-   Create new update views. In the **Actions** pane, click **New Update View**. You can filter updates by classification, product, the group for which they have been approved, and synchronization date. You can sort the list by clicking the appropriate column heading in the title bar.

-   Search for updates. You can search for an individual update or set of updates by title, description, Knowledge Base article, or the Microsoft Security Response Center number for the update.

-   View details, status, and revision history for each update.

-   Approve and Decline updates.

#### To view updates

1.  In the WSUS administration console, expand the Updates node, and then click All Updates.

2.  By default, updates are displayed with their title, classification, installed/not applicable percentage, and approval status. If you wish to display more or different update properties, right-click the column heading bar and select the appropriate columns.

3.  To sort by different criteria, such as download status, title, classification, release date, or approval status, click the appropriate column heading.

#### To filter the list of updates displayed on the Updates page

1.  In the WSUS administration console, expand **Updates**, and then click **All Updates**.

2.  In the center pane next to **Approval**, select the desired approval status, and next to **Status** select the desired installation status. Click **Refresh**.

#### To create a new update view on WSUS

1.  In the WSUS administration console, expand **Updates**, and then click **All Updates**.

2.  In the **Actions** pane, click **New Update View**.

3.  In the **Add Update View** window, under **Step 1: select properties**, select the properties you need to filter the update view:

    -   Select Updates are in a specific classification to filter on updates belonging to one or more update classifications.

    -   Select Updates are for a specific product to filter on updates for one or more products or product families.

    -   Select Updates are approved for a specific group to filter on updates approved for one or more computer groups.

    -   Select Updates were synchronized within a specific time period to filter on updates synchronized at a specific time.

    -   Select Updates are WSUS updates to filter on WSUS updates.

4.  Under **Step 2: edit the properties**, click the underlined words to pick the values you want.

5.  Under **Step 3: Specify a name**, give your new view a name.

6.  Click **OK**.

Your new view will appear in the tree view pane under Updates. It will be displayed, like the standard views, in the center pane when you select it.

#### To search for an update

1.  Select the **Updates** node (or any node under it).

2.  In the **Actions** pane, click **Search**.

3.  In the **Search** window, on the **Updates** tab, enter your search criteria. You can use text from the **Title**, **Description**, and **Microsoft Knowledge Base (KB) article number** fields. Each of these items is a property listed on the **details** tab in the update properties.

#### To view the properties for an update

1.  In the WSUS administration console, expand **Updates**, and then click **All Updates**.

2.  In the list of updates, click the update you want to view.

3.  In the lower pane, you will see the different property sections:

    -   The title bar displays the title of the update; for example, Security Update for Windows Media Player 9 (KB911565).

    -   The Status section displays the installation status of the update (the computers on which it needs to be installed, computers on which it was installed with errors, computers on which it has been installed or is not applicable, and computers that have not reported status for the update), as well as general information (KB and MSRC numbers release date, etc.).

    -   The Description section displays a brief description of the update.

    -   The additional details section displays the following information:

        -   The installation behavior of the update (whether or not it is removable, requests a restart, requires user input, or must be installed exclusively).

        -   Whether or not the update has Microsoft Software License Terms

        -   The products to which the update applies

        -   The updates that supersede this update

        -   The updates that are superseded by this update

        -   The languages supported by the update

        -   The update ID

Note that you can perform this procedure on only one update at a time. If you select multiple updates, only the first update in the list will be displayed in the **Properties** pane.

## Managing Updates with WSUS
Updates are used for updating or providing a full file replacement for software that is installed on a computer. Every update that is available on Microsoft Update is made up of two components:

-   Metadata: Provides information about the update. For example, metadata supplies information for the properties of an update, thus enabling you to find out for what the update is useful. Metadata also includes Microsoft Software License Terms. The metadata package downloaded for an update is typically much smaller than the actual update file package.

-   Update files: The actual files required to install an update on a computer.

When updates are synchronized to your WSUS server, the metadata and update files are stored in two separate locations. Metadata is stored in the WSUS database. Update files can be stored either on your WSUS server or on Microsoft Update servers, depending on how you have configured your synchronization options. If you choose to store update files on Microsoft Update servers, only metadata is downloaded at the time of synchronization; you approve the updates through the WSUS console, and then client computers get the update files directly from Microsoft Update at the time of installation. For more information about options for storing updates, see section [1.3. Choose a WSUS storage strategy](../plan/plan-your-wsus-deployment.md#13-choose-a-wsus-storage-strategy) of Step 1: Prepare for Your WSUS Deployment, in the WSUS deployment guide.

You will be setting up and running synchronizations, adding computers and computer groups, and deploying updates on a regular basis. The following list gives examples of general tasks you might undertake in updating computers with WSUS.

-   Determine an overall update management plan based on your network topology and bandwidth, company needs, and organizational structure.

    -   Whether to set up a hierarchy of WSUS servers and how the hierarchy should be structured.

    -   What computer groups to create, and how to assign computers to them (server-side or client-side targeting).

    -   Which database to use for update metadata (for example, Windows Internal Database, SQL Server).

    -   Whether updates should be synchronized automatically, and at what time.

-   Set synchronization options, such as update source, product and update classification, language, connection settings, storage location, and synchronization schedule.

-   Get the updates and associated metadata on your WSUS server through synchronization from either Microsoft Update or an upstream WSUS server.

-   Approve or decline updates. You have the option of allowing users to install the updates themselves (if they are local administrators on their client computers).

-   Configure automatic approvals. You can also configure whether you want to enable automatic approval of revisions to existing updates or approve revisions manually. If you choose to approve revisions manually, then your WSUS server will continue using the older version until you manually approve the new revision.

-   Check the status of updates. You can view update status, print a status report, or configure e-mail for regular status reports.

## Update Products and Classifications
Updates available on Microsoft Update are differentiated by product (or product family) and classification.

A product is a specific edition of an operating system or application, for example, Windows Server 2012. A product family is the base operating system or application from which the individual products are derived. An example of a product family is Microsoft Windows, of which Windows Server 2012 is a member. You can select the products or product families for which you want your server to synchronize updates. You can specify a product family or individual products within the family. Selecting any product or product family will get updates for current and future versions of the product.

Update classifications represent the type of update. For any given product or product family, updates could be available among multiple update classifications (for example, Windows 7 family Critical Updates and Security Updates). The following table lists update classifications.

| Update Classifications  | Description   |
|--|--|
|Critical Updates|Broadly released fixes for specific problems addressing critical, non-security related bugs.|
|Definition Updates|Updates to virus or other definition files.|
|Drivers|Software components designed to support new hardware.|
|Feature packs|New feature releases, usually rolled into products at the next release.|
|Security updates|Broadly released fixes for specific products, addressing security issues.|
|Service packs|Cumulative sets of all hotfixes, security updates, critical updates, and updates created since the release of the product. Service packs might also contain a limited number of customer-requested design changes or features.|
|Tools|Utilities or features that aid in accomplishing a task or set of tasks.|
|Update rollups|A cumulative set of hotfixes, security updates, critical updates, and other updates that are packaged together for easy deployment. A rollup generally targets a specific area, such as security, or a specific component, such as Internet Information Services (IIS).|
|Updates|Broadly released fixes for specific problems addressing non-critical, non-security related bugs.|

## Icons used for updates in Windows Server Update Services
 Updates in WSUS are represented by one of the following icons.  
 To view these icons, you have to enable the Supersedence column in the Update Services console.
 
### No Icon
 The update has no supersedence relationship with any other update.

 **Operational Concerns:**  

 There are no operational concerns.  
 
### Superseding Icon
 ![icon](../../media/wsus/wsus-superseding.png) This update supersedes other updates.

 **Operational Concerns:**  

 There are no operational concerns.  

### Superseded & Superseding Icon
 ![icon](../../media/wsus/wsus-superseded.png) This update is superseded by another update, and supersedes other updates.

 **Operational Concerns:**  

 Replace these updates with the superseding updates when possible.
 
### Superseded Icon
 ![icon](../../media/wsus/wsus-superseded-leaf.png) This update is superseded by another update.

 **Operational Concerns:**  

 Replace these updates with the superseding updates when possible.

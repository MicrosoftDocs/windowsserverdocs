---
title: Setting up Update Synchronizations
description: "Windows Server Update Service (WSUS) topic - How to setup and configure Update Synchronizations"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-wsus
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ddd5c395-451b-44a0-8e08-a05db26d2282
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Setting up Update Synchronizations

>Applies To: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

During synchronization, a WSUS server downloads updates (update metadata and files) from an update source. It also downloads new product classifications and categories, if any. When your WSUS server synchronizes for the first time, it will download all of the updates that you specified when you configured synchronization options. After the first synchronization, your WSUS server downloads only updates from the update source, as well as revisions in metadata for existing updates, and expirations to updates.

The first time a WSUS server downloads updates may take a long time. If you are setting up multiple WSUS servers, you can speed up the process to a certain extent by downloading all the updates on one WSUS server and then copying the updates to the content directories of the other WSUS servers.

You can copy content from one WSUS server's content directory to another. The location of the content directory is specified when you run the WSUS post installation procedure. You can use the wsusutil.exe tool to export update metadata from one WSUS server to a file. You can then import that file into other WSUS servers.

## Setting up Update Synchronizations
The **Options** page is the central access point in the WSUS Administration Console for customizing how your WSUS server synchronizes updates. You can specify which updates are synchronized automatically, where your server gets updates, connection settings, and the synchronization schedule. You can also use the Configuration Wizard from the **Options** page to configure or reconfigure your WSUS server at any time.

### Synchronizing Update by Product and Classification
A WSUS server downloads updates based on the products or product families (for example, Windows, or Windows Server 2008, Datacenter edition) and classifications (for example, critical updates or security updates) that you specify. at the first synchronization, the WSUS server downloads all of the updates available in the categories that you have specified. In subsequent synchronizations, your WSUS server downloads only the newest updates (or changes to the updates already available on your WSUS server) for the categories you have specified.

You can specify update products and classifications on the **Options** page under **Products and Classifications**. Products are listed in a hierarchy, grouped by product family. If you select Windows, you automatically select every product that falls under that product hierarchy. By selecting the parent check box you select all items under it, as well as all future versions. selecting the child check boxes will not select the parent check boxes. The default setting for products is all Windows products, and the default setting for classifications is critical and security updates.

If a WSUS server is running in replica mode, you will not be able to perform this task. For more information about replica mode, see [Running WSUS Replica mode](running-wsus-replica-mode.md), and [Step 1: Prepare for Your WSUS Deployment](../plan/plan-your-wsus-deployment.md).

##### To specify update products and classifications for synchronization

1.  In the WSUS Administration Console, click the **Options** node.

2.  Click **Products and Classifications**, and then click the **Products** tab.

3.  Select the check boxes of the products or product families you want to update with WSUS, and then click **OK**.

4.  On the **Classifications** tab, select the check boxes of the update classifications you want your WSUS server to synchronize, and then click **OK**.

> [!NOTE]
> You can remove products or classifications in the same way. Your WSUS server will stop synchronizing new updates for the products you have cleared. However, updates that were synchronized for those products before you cleared them will remain on your WSUS server and will be listed as available.
> 
> To remove those products,  Decline the update, as documented in [Updates Operations](updates-operations.md), and then use the [The Server cleanup Wizard](the-server-cleanup-wizard.md) to remove them.

### Synchronizing Updates by Language
Your WSUS server downloads updates based on the languages that you specify. You can synchronize updates in all of the languages in which they are available, or you can specify a subset of languages. If you have a hierarchy of WSUS servers, and you need to download updates in different languages, make sure that you have specified all the necessary languages on the upstream server. On a downstream server you can specify a subset of the languages you specified on the upstream server.

### Synchronizing Updates from the Microsoft Update Catalog
for details about synchronizing updates from the Microsoft Update Catalog site, see: [WSUS and the Catalog Site](wsus-and-the-catalog-site.md).

## Configuring Proxy Server Settings
You can configure your WSUS server to use a proxy server during synchronization with an upstream server or Microsoft Update. This setting will apply only when your WSUS server runs synchronizations. By default your WSUS server will try to connect directly to the upstream server or Microsoft Update.

#### To specify a proxy server for synchronization

1.  In the WSUS Administration Console, click **Options**, and then click **Update Source and Proxy Server**.

2.  On the **Proxy Server** tab, select the **Use a proxy server when synchronizing** check box, and then type the server name and port number of the proxy server.

    > [!NOTE]
    > Configure WSUS with the same port number that the proxy server is configured to use.

    -   if you want to connect to the proxy server with specific user credentials, select the **Use user credentials to connect to the proxy server** check box, and then enter the user name, domain, and password of the user in the corresponding boxes.

    -   if you want to enable basic authentication for the user connecting to the proxy server, select the **Allow basic authentication (password is sent in cleartext)** check box.

3.  Click **OK**.

    > [!NOTE]
    > Because WSUS initiates all of its network traffic, there is no need to configure Windows Firewall on a WSUS server connected directly to Microsoft update.

## Configuring the Update Source
The update source is the location from which your WSUS server gets its updates and update metadata. You can specify that the update source should be either Microsoft Update or another WSUS server (the WSUS server that acts as the update source is the upstream server, and your server is the downstream server).

Options for customizing how your WSUS server synchronizes with the update source include the following:

-   You can specify a custom port for synchronization. For information about configuring ports, see [Step 3: Configure WSUS](../deploy/2-configure-wsus.md) in the WSUS deployment guide.

-   You can use Secure Socket Layers (SSL) to secure synchronization of update information between WSUS servers. For more information about using SSL, see section "3.5. Secure WSUS with the Secure Sockets Layer Protocol" of [Step 3: Configure WSUS](../deploy/2-configure-wsus.md) in the WSUS deployment guide.

## Synchronizing Manually or Automatically
You can either synchronize your WSUS server manually or specify a time for it to synchronize automatically.

#### To manually synchronize the WSUS server

1.  In the WSUS Administration Console, click **Options**, and then click **Synchronization Schedule**.

2.  Click **Synchronize manually**, and then click **OK**.

#### To set up an automatic synchronization schedule

1.  In the WSUS Administration Console, click **Options**, then click **Synchronization Schedule**.

2.  Click **Synchronize automatically**.

3.  For **First synchronization**, select the time you want synchronization to start each day.

4.  for **Synchronizations per day**, select the number of synchronizations you want to do each day. For example, if you want four synchronizations a day starting at 3:00 A.M., then synchronizations will occur at 3:00 A.M., 9:00 A.M., 3:00 P.M., and 9:00 P.M. each day. (Note that a  random time offset will be added to the scheduled synchronization time in order to space out the server connections to Microsoft Update.)

5.  Click **OK**.

#### To synchronize your WSUS server immediately

1.  On the WSUS Administration Console, select the top server node.

2.  In the **Overview** pane, under **Synchronization Status**, click **Synchronize now**.

> [!NOTE]
> The synchronization is initiated by the downstream server.

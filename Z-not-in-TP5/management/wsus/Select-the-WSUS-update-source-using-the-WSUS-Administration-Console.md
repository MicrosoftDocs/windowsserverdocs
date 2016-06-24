---
title: Select the WSUS update source using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 02fb3953-ed0a-4573-8d79-e15963ca35bb
---
# Select the WSUS update source using the WSUS Administration Console
After you install the [!INCLUDE[wsus_firstref_30SP2](includes/wsus_firstref_30SP2_md.md)] 3.0 SP2 server software, you must specify the upstream server to which the WSUS server synchronizes for updates. This topic describes how to specify the update source by using the WSUS Administration Console.

### To change the update source

1.  Open the WSUS Administration Console by following the instructions in [Open the WSUS Administration Console](Configure-WSUS-by-Using-the-WSUS-Administration-Console.md#opencon).

2.  In the left pane of the WSUS Administration Console, expand the server name, and then click **Options**.

3.  In the **Options** pane, click **Update Source and Update Server**, and then click the **Update Source** tab.

4.  Use the following options to modify the existing update source:

    -   To synchronize from Microsoft Update:

        1.  Select **Synchronize from Microsoft Updates**.

        2.  Click **Next**.

    -   To synchronize with a local upstream WSUS server:

        1.  Click **Synchronize from another Windows Server Update Services server**.

        2.  In the **Server name** text box, type the name of the local upstream WSUS server.

        3.  In the **Port number** text box, type the port number that this WSUS server will use to communicate with the upstream WSUS server. The default port number is 80.

            For more information about port configuration options, see [Configure Internet Information Services (IIS)](Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#iis).

        4.  To use Secure Sockets Layer (SSL) to help secure WSUS communications, select the **Use SSL when synchronizing update information** check box. This option works only if this WSUS server and the local upstream WSUS server support SSL.

            For more information about how to use SSL with WSUS, see [Secure WSUS with the Secure Sockets Layer Protocol](Secure-the-WSUS-3.0-SP2-Deployment.md#ssl).

        5.  If this WSUS server is a replica server, select the **This is a replica of the upstream server** check box.

            For more information about WSUS replica servers, see [Replica mode (centralized administration)](Design-the-WSUS-Server-Layout.md#replica).

        6.  Click **Next**.



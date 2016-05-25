---
title: Select the upstream server using the WSUS Server Configuration Wizard
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 32084144-3b42-41a3-b447-562327877a15
author: britw
---
# Select the upstream server using the WSUS Server Configuration Wizard
A WSUS server must synchronize to an upstream server. The upstream server is the Microsoft Update website or a local WSUS server. At least one local WSUS server must connect to Microsoft Update. The default option is Microsoft Update.  
  
For more information about upstream and downstream servers, see the [Design the WSUS Server Layout](../Topic/Design-the-WSUS-Server-Layout.md) section in this deployment guide.  
  
## <a name="procupstream"></a>To select the upstream server  
  
-   On the **Choose Upstream Server** page of the WSUS server configuration wizard, you can select the WSUS server to which this WSUS server will synchronize for updates.  
  
    -   To synchronize from Microsoft Update:  
  
        1.  Select **Synchronize from Microsoft Updates**.  
  
        2.  Click **Next**.  
  
    -   To synchronize with a local upstream WSUS server:  
  
        1.  Click **Synchronize from another Windows Server Update Services server**.  
  
        2.  In the **Server name** text box, type the name of the local upstream WSUS server.  
  
        3.  In the **Port number** text box, type the port number that this WSUS server will use to communicate with the upstream WSUS server. The default port number is 80.  
  
            For more information about port configuration options, see the [Configure Internet Information Services \(IIS\)](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#iis) section in this deployment guide.  
  
        4.  To use Secure Sockets Layer \(SSL\) to help secure WSUS communications, check the **Use SSL when synchronizing update information** check box. This option works only if this WSUS server and the local upstream WSUS server support SSL.  
  
            For more information about how to use SSL with WSUS, see the [Secure WSUS with the Secure Sockets Layer Protocol](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#ssl) section in this deployment guide.  
  
        5.  If this WSUS server is a replica server, select the **This is a replica of the upstream server** check box.  
  
            For more information about WSUS replica servers, see the [Replica mode \(centralized administration\)](../Topic/Design-the-WSUS-Server-Layout.md#replica) section in this deployment guide.  
  
        6.  Click **Next**.  
  

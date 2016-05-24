---
title: Configure and Manage Replica Servers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 98f0a612-9950-4c1d-ba02-a03ea9db81ef
author: britw
---
# Configure and Manage Replica Servers
A WSUS replica server inherits update approvals and computer groups from the upstream WSUS server. A WSUS deployment that uses replica servers typically consists of a single WSUS root server that manages updates, and one or more downstream replica WSUS servers.  
  
For planning guidance on when to use replica servers, see [Replica mode \(centralized administration\)](../Topic/Design-the-WSUS-Server-Layout.md#replica).  
  
In this topic:  
  
-   [Configure a replica server](../Topic/Configure-and-Manage-Replica-Servers.md#config)  
  
-   [Manage a replica server](../Topic/Configure-and-Manage-Replica-Servers.md#manage)  
  
-   [Import updates or metadata to a replica server](../Topic/Configure-and-Manage-Replica-Servers.md#import)  
  
## <a name="config"></a>Configure a replica server  
You can identify a WSUS server as a replica server by using the WSUS server configuration wizard, or by using the procedure that is described in this topic. For more information about the WSUS server configuration wizard, see [Configure WSUS by using the WSUS server configuration wizard](assetId:///ea86ec38-ddaa-4d97-a14b-714d18063ccb).  
  
### <a name="procrep"></a>To configure a WSUS replica server  
  
1.  Install the WSUS server software by following the instructions in [Install the WSUS 3.0 SP2 server software through the User Interface](assetId:///3bc2933c-8d26-4594-b989-e64b406f3147) or [Install the WSUS 3.0 SP2 server software in unattended mode](assetId:///2443408e-5bd2-4b1f-b0a5-7ee1452fe5bc).  
  
2.  Open the WSUS Administrator Console by following the instructions in [Open the WSUS Administration Console](../Topic/Configure-WSUS-by-Using-the-WSUS-Administration-Console.md#opencon).  
  
3.  In the WSUS Administration Console, expand the server name, and then click **Options**.  
  
4.  In the Options pane, click **Update Source and Proxy Server**.  
  
5.  On the Update Source page, select **Synchronize from another Windows Server Update Service server**.  
  
6.  In the **Server name** text box, type the name of the local upstream WSUS server.  
  
7.  In the **Port number** text box, type the port number that this WSUS server will use to communicate with the upstream WSUS server. The default port number is 80.  
  
    For more information about port configuration options, see [Configure Internet Information Services \(IIS\)](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#iis).  
  
8.  To use Secure Sockets Layer \(SSL\) to help secure WSUS communications, select the **Use SSL when synchronizing update information** check box. This option works only if this WSUS server and the local upstream WSUS server support SSL.  
  
    For more information about how to use SSL with WSUS, see [Secure WSUS with the Secure Sockets Layer Protocol](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#ssl).  
  
9. Select the **This is a replica of the upstream server** check box, and then click **OK**.  
  
## <a name="manage"></a>Manage a replica server  
You can perform limited administration on a WSUS replica server. This administration consists of the following tasks:  
  
-   Add and remove computers from computer groups.  
  
    You must assign the client computers that are serviced by the replica WSUS server to the computer groups that are inherited from the upstream WSUS server. For more information about how to assign computers to computer groups, see [Manage WSUS client computers &#91;SP\_2&#93;](assetId:///1ee6068f-99c9-4cdd-a080-b236ea7adbd8).  
  
-   View approved updates.  
  
    On a replica WSUS server, you can view updates that are approved on the upstream WSUS server. For more information about how to view approved updates, see [View Updates](assetId:///83961821-639f-41c5-b948-a9985fd32d2d) in the WSUS 3.0 SP2 Operations Guide.  
  
-   Monitor update, synchronization, computer status, and WSUS settings.  
  
    You can view all standard WSUS reports on replica WSUS servers. You can also roll up replica server reports to an upstream WSUS server. For more information about how to view and use reports, see [Use Reports in Windows Server Update Services 3.0 SP2](../Topic/Use-Reports-in-Windows-Server-Update-Services-3.0-SP2.md) in the WSUS 3.0 SP2 Operations Guide.  
  
## <a name="import"></a>Import updates or metadata to a replica server  
In some situations, you might want to import updates or metadata to a replica server. To copy update content to a replica server, follow these steps:  
  
1.  Turn off the replica setting on the replica server.  
  
2.  Export the updates and metadata from the upstream server.  
  
3.  Import the updates and metadata to the replica server.  
  
4.  Turn on the replica setting on the replica server.  
  
#### To import updates and metadata to a replica server  
  
1.  Follow the instructions in the [Export updates and metadata](../Topic/Configure-a-Disconnected-Network-to-Receive-Updates.md#Export) section to export the data from the upstream WSUS server.  
  
2.  Open the WSUS Administration Console by following the instructions in [Open the WSUS Administration Console](../Topic/Configure-WSUS-by-Using-the-WSUS-Administration-Console.md#opencon).  
  
3.  In the left pane of the WSUS Administration Console, expand the server name, and then click **Options**.  
  
4.  In the **Options** pane, click **Update Source and Update Server**, and then click the **Update Source** tab.  
  
5.  Clear the **This is a replica of the upstream server** check box, and then click **OK**. Do not close the WSUS Administration Console.  
  
6.  Import the content to the replica server by following the instructions in the [Import updates and metadata](../Topic/Configure-a-Disconnected-Network-to-Receive-Updates.md#Import) section.  
  
7.  Return to the WSUS Administration Console. In the **Options** pane, click **Update Source and Update Server**, and then click the **Update Source** tab.  
  
8.  Select the **This is a replica of the upstream server** check box, and then click **OK**.  
  

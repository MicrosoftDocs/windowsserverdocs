---
title: Configure Connection Request Policies
description: This topic provides information on how to configure Connection Request Policies in Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: f62c6a67-4dda-47f8-8bdf-9b76c37953e6
ms.author: lizross 
author: eross-msft
---

# Configure Connection Request Policies

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to create and configure connection request policies that designate whether the local NPS processes connection requests or forwards them to remote RADIUS server for processing.

Connection request policies are sets of conditions and settings that allow network administrators to designate which Remote Authentication Dial-In User Service (RADIUS) servers perform the authentication and authorization of connection requests that the server running Network Policy Server \(NPS\) receives from RADIUS clients.

The default connection request policy uses NPS as a RADIUS server and processes all authentication requests locally.

To configure a server running NPS to act as a RADIUS proxy and forward connection requests to other NPS or RADIUS servers, you must configure a remote RADIUS server group in addition to adding a new connection request policy that specifies conditions and settings that the connection requests must match.

You can create a new remote RADIUS server group while you are creating a new connection request policy with the New Connection Request Policy Wizard.

If you do not want the NPS to act as a RADIUS server and process connection requests locally, you can delete the default connection request policy.

If you want the NPS to act as both a RADIUS server, processing connection requests locally, and as a RADIUS proxy, forwarding some connection requests to a remote RADIUS server group, add a new policy using the following procedure and then verify that the default connection request policy is the last policy processed by placing it last in the list of policies.

## Add a Connection Request Policy

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

### To add a new connection request policy 

1. In Server Manager, click **Tools**, and then click **Network Policy Server** to open the NPS console. 
2. In the console tree, double-click **Policies**.
3. Right-click **Connection Request Policies**, and then click **New Connection Request Policy**.
4. Use the New Connection Request Policy Wizard to configure your connection request policy and, if not previously configured, a remote RADIUS server group.


For more information about managing NPS, see [Manage Network Policy Server](nps-manage-top.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).


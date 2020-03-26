---
title: Configure Remote RADIUS Server Groups
description: This topic provides information on how to configure Remote RADIUS Server Groups in Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: ca125e57-249c-4d97-85d1-2929cbf871f1
ms.author: lizross 
author: eross-msft
---

# Configure Remote RADIUS Server Groups

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to configure remote RADIUS server groups when you want to configure NPS to act as a proxy server and forward connection requests to other NPSs for processing.

## Add a Remote RADIUS Server Group

You can use this procedure to add a new remote RADIUS server group in the Network Policy Server (NPS) snap-in.

When you configure NPS as a RADIUS proxy, you create a new connection request policy that NPS uses to determine which connection requests to forward to other RADIUS servers. In addition, the connection request policy is configured by specifying a remote RADIUS server group that contains one or more RADIUS servers, which tells NPS where to send the connection requests that match the connection request policy.

>[!NOTE]
>You can also configure a new remote RADIUS server group during the process of creating a new connection request policy.

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

### To add a remote RADIUS server group 

1. In Server Manager, click **Tools**, and then click **Network Policy Server** to open the NPS console.
2. In the console tree, double-click **RADIUS Clients and Servers**, right-click **Remote RADIUS Server Groups**, and then click **New**.
3. The **New Remote RADIUS Server Group** dialog box opens. In **Group name**, type a name for the remote RADIUS server group.
4. **In RADIUS Servers**, click **Add**. The **Add RADIUS Servers** dialog box opens. Type the IP address of the RADIUS server that you want to add to the group, or type the Fully Qualified Domain Name \(FQDN\) of the RADIUS server, and then click **Verify**.
5. In **Add RADIUS Servers**, click the **Authentication/Accounting** tab. In **Shared secret** and **Confirm shared secret**, type the shared secret. You must use the same shared secret when you configure the local computer as a RADIUS client on the remote RADIUS server.
6. If you are not using Extensible Authentication Protocol (EAP) for authentication, click **Request must contain the message authenticator attribute**. EAP uses the Message-Authenticator attribute by default.
7. Verify that the authentication and accounting port numbers are correct for your deployment.
8. If you use a different shared secret for accounting, in **Accounting**, clear the **Use the same shared secret for authentication and accounting** check box, and then type the accounting shared secret in **Shared secret** and **Confirm shared secret**.
9. If you do not want to forward network access server start and stop messages to the remote RADIUS server, clear the **Forward network access server start and stop notifications to this server** check box.

For more information about managing NPS, see [Manage Network Policy Server](nps-manage-top.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).


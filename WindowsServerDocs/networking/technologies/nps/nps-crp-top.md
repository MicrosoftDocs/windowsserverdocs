---
title: Connection Request Processing
description: This topic provides an overview of Network Policy Server connection request processing in Windows Server 2016.
manager: dongill
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 849d661a-42c1-4f93-b669-6009d52aad39
ms.author: jamesmci 
author: jamesmci
---

# Connection Request Processing

>Applies To: Windows Server&reg; 2016

You can use connection request processing to specify where the authentication of connection requests is performed - on the local computer or at a remote RADIUS server that is a member of a remote RADIUS server group. 

If you want the local server running Network Policy Server (NPS) to perform authentication for connection requests, you can use the default connection request policy without additional configuration. Based on the default policy, NPS authenticates users and computers that have an account in the local domain and in trusted domains.

If you want to forward connection requests to a remote NPS or other RADIUS server, create a remote RADIUS server group and then configure a connection request policy that forwards requests to that remote RADIUS server group. With this configuration, NPS can forward authentication requests to any RADIUS server, and users with accounts in untrusted domains can be authenticated.

The following illustration shows the path of an Access-Request message from a network access server to a RADIUS proxy, and then on to a RADIUS server in a remote RADIUS server group. On the RADIUS proxy, the network access server is configured as a RADIUS client; and on each RADIUS server, the RADIUS proxy is configured as a RADIUS client.


![NPS Connection Request Processing](../../media/Nps-Connection-Request-Processing/Nps-Connection-Request-Processing.jpg)


>[!NOTE]
>The network access servers that you use with NPS can be gateway devices that are compliant with the RADIUS protocol, such as 802.1X wireless access points and authenticating switches, servers running Remote Access that are configured as VPN or dial-up servers, or other RADIUS compatible devices.

If you want NPS to process some authentication requests locally while forwarding other requests to a remote RADIUS server group, configure more than one connection request policy.

To configure a connection request policy that specifies which NPS or RADIUS server group processes authentication requests, see Connection Request Policies.

To specify NPS or other RADIUS servers to which authentication requests are forwarded, see Remote RADIUS Server Groups.


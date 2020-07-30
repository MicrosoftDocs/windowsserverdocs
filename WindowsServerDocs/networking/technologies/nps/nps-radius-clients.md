---
title: RADIUS Clients
description: This topic provides an overview of RADIUS Clients for Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: d3a09ac9-75f8-4f57-aab4-b0fdfe110118
ms.author: lizross 
author: eross-msft
---

# RADIUS Clients

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

A network access server \(NAS\) is a device that provides some level of access to a larger network. A NAS using a RADIUS infrastructure is also a RADIUS client, sending connection requests and accounting messages to a RADIUS server for authentication, authorization, and accounting.

>[!NOTE]
>Client computers, such as laptop computers and other computers running client operating systems, are not RADIUS clients. RADIUS clients are network access servers - such as wireless access points, 802.1X authenticating switches, virtual private network \(VPN\) servers, and dial-up servers - because they use the RADIUS protocol to communicate with RADIUS servers such as Network Policy Server \(NPS\) servers.

To deploy NPS as a RADIUS server or a RADIUS proxy, you must configure RADIUS clients in NPS.

## RADIUS client examples

Examples of network access servers are:

- Network access servers that provide remote access connectivity to an organization network or the Internet. An example is a computer running the Windows Server 2016 operating system and the  Remote Access service that provides either traditional dial-up or virtual private network (VPN) remote access services to an organization intranet.
- Wireless access points that provide physical layer access to an organization network using wireless-based transmission and reception technologies.
- Switches that provide physical layer access to an organization's network, using traditional LAN technologies, such as Ethernet.
- RADIUS proxies that forward connection requests to RADIUS servers that are members of a remote RADIUS server group that is configured on the RADIUS proxy.

## RADIUS Access-Request messages

RADIUS clients either create RADIUS Access-Request messages and forward them to a RADIUS proxy or RADIUS server, or they forward Access-Request messages to a RADIUS server that they have received from another RADIUS client but have not created themselves.

RADIUS clients do not process Access-Request messages by performing authentication, authorization, and accounting. Only RADIUS servers perform these functions.

NPS, however, can be configured as both a RADIUS proxy and a RADIUS server simultaneously, so that it processes some Access-Request messages and forwards other messages.

## NPS as a RADIUS client

NPS acts as a RADIUS client when you configure it as a RADIUS proxy to forward Access-Request messages to other RADIUS servers for processing. When you use NPS as a RADIUS proxy, the following general configuration steps are required:

1. Network access servers, such as wireless access points and VPN servers, are configured with the IP address of the NPS proxy as the designated RADIUS server or authenticating server. This allows the network access servers, which create Access-Request messages based on information they receive from access clients, to forward messages to the NPS proxy.

2. The NPS proxy is configured by adding each network access server as a RADIUS client. This configuration step allows the NPS proxy to receive messages from the network access servers and to communicate with them throughout authentication. In addition, connection request policies on the NPS proxy are configured to specify which Access-Request messages to forward to one or more RADIUS servers. These policies are also configured with a remote RADIUS server group, which tells NPS where to send the messages it receives from the network access servers.

3. The NPS or other RADIUS servers that are members of the remote RADIUS server group on the NPS proxy are configured to receive messages from the NPS proxy. This is accomplished by configuring the NPS proxy as a RADIUS client.

## RADIUS client properties

When you add a RADIUS client to the NPS configuration through the NPS console or through the use of the netsh commands for NPS or Windows PowerShell commands, you are configuring NPS to receive RADIUS Access-Request messages from either a network access server or a RADIUS proxy.

When you configure a RADIUS client in NPS, you can designate the following properties:

### Client name

 A friendly name for the RADIUS client, which makes it easier to identify when using the NPS snap-in or netsh commands for NPS.

### IP address

The Internet Protocol version 4 \(IPv4\) address or the Domain Name System \(DNS\) name of the RADIUS client.

### Client-Vendor

The vendor of the RADIUS client. Otherwise, you can use the RADIUS standard value for Client-Vendor.

### Shared secret

A text string that is used as a password between RADIUS clients, RADIUS servers, and RADIUS proxies. When the Message Authenticator attribute is used, the shared secret is also used as the key to encrypt RADIUS messages. This string must be configured on the RADIUS client and in the NPS snap-in.

### Message Authenticator attribute

Described in RFC 2869, "RADIUS Extensions," a Message Digest 5 \(MD5\) hash of the entire RADIUS message. If the RADIUS Message Authenticator attribute is present, it is verified. If it fails verification, the RADIUS message is discarded. If the client settings require the Message Authenticator attribute and it is not present, the RADIUS message is discarded. Use of the Message Authenticator attribute is recommended.

>[!NOTE]
>The Message Authenticator attribute is required and enabled by default when you use Extensible Authentication Protocol \(EAP\) authentication. 

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).


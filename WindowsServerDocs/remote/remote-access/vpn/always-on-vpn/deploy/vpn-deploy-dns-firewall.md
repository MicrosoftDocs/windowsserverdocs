---
title: Configure DNS and Firewall Settings
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: d8cf3bae-45bf-4ffa-9205-290d555c59da
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Configure DNS and Firewall Settings

>Applies To: Windows Server 2016, Windows 10

You can use this section to configure DNS and Firewall settings.

## Configure DNS name resolution

When remote VPN clients connect, they use the same DNS servers that your internal clients use, which allows them to resolve names in the same manner as the rest of your internal workstations. 

Because of this, you must ensure that the computer name that external clients use to connect to the VPN server matches the subject alternative name that is defined in the certificates you issue to the  VPN server. 

To ensure that remote clients can connect to your VPN server, you can create a DNS A (Host) record in your external DNS zone. The A record should use the certificate subject alternative name for the VPN server.

### To add a host (A or AAAA) resource record to a zone

1. On a DNS server, in Server Manager, click **Tools**, and then click **DNS**. DNS Manager opens.
2. In the DNS Manager console tree, click the server that you want to manage.
3. In the details pane, in **Name**, double\-click **Forward Lookup Zones** to expand the view.
4. In **Forward Lookup Zones** details, right\-click the forward lookup zone to which you want to add a record, and then click **New Host \(A or AAAA\)**. The **New Host** dialog box opens.
5. In **New Host**, in **Name**, type the certificate subject alternative name for the VPN server.
6. In IP address, type the IP address for the VPN server. You can type the address in IP version 4 (IPv4) format to add a host \(A\) resource record; or IP version 6 \(IPv6\) format to add a host \(AAAA\) resource record.
7. If you created a reverse lookup zone for a range of IP addresses that includes the IP address that you typed, you can select the **Create associated pointer \(PTR\) record** check box to create an additional pointer \(PTR\) resource record in a reverse zone for this host, based on the information that you entered in **Name** and **IP address**.
8. Click **Add Host**.

## Configure the edge firewall

Your edge firewall must allow and forward specific ports to your VPN server. If you use Network Address Translation \(NAT\) on your edge firewall, you might need to enable port forwarding for User Datagram Protocol \(UDP\) ports 500 and 4500. You should forward these ports to the IP address that is assigned to the external interface of your VPN server.

If you’re routing traffic inbound and performing NAT at or behind the VPN server, then you must open your firewall rules to allow ports 500 and 4500 inbound to the external IP address applied to the public interface on the VPN server.

In either case, if your firewall supports deep packet inspection and you have difficulty establishing client connections, you should attempt to relax or disable deep packet inspection for IKE sessions.

For information on how to make these configuration changes, see your firewall documentation.

For the next Always On VPN deployment steps, see [Configure Windows 10 Client Always On VPN Connections](vpn-deploy-client-vpn-connections.md).
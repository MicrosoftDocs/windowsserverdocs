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

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

When remote VPN clients connect, they use the same DNS servers that your internal clients use, which allows them to resolve names in the same manner as the rest of your internal workstations. Because of this, you must ensure that the computer name that external clients use to connect to the VPN server matches the subject alternative name that is defined in the certificates you issue to the  VPN server.

## STEP 1: Configure DNS name resolution
The DNS database contains resource records (entries) that resolve name resolution queries sent to the DNS server. Each DNS server contains the resource records (RRs) it needs to respond to name resolution queries for the portion of the DNS namespace for which it is authoritative. 

Although there are different types of resource records, you are adding the A and AAAA resource records:
- **A** resource record maps host (computer or other network device) to an IPv4 address. 
- **AAAA** record maps a host name to an IPv6 address.

1. On a DNS server, in Server Manager, click **Tools**, and click **DNS**.<br>DNS Manager opens.
2. In the navigation pane, click the server that you want to manage.
3. In the details pane, in Name, double\-click **Forward Lookup Zones** to expand the view.
4. Right\-click the forward lookup zone to which you want to add a record and click **New Host \(A or AAAA\)**.<br>The New Host dialog box opens.
5. In Name, type the certificate subject alternative name for the VPN server.
6. In IP address, enter the IP address for the VPN server.<br>You can enter the address in IP version 4 (IPv4) format to add a host \(A\) resource record; or IP version 6 \(IPv6\) format to add a host \(AAAA\) resource record.
7. If you created a reverse lookup zone for a range of IP addresses that includes the IP address that you typed, you can select the **Create associated pointer \(PTR\) record** check box to create an additional pointer \(PTR\) resource record in a reverse zone for this host, based on the information that you entered in **Name** and **IP address**.
8. Click **Add Host**.

## STEP 2: Configure the Firewalls

In this step, you configure the the following firewalls:

* Edge Firewall. Separates the External Perimeter Network from the Public Internet. 
* Internal Perimeter Network Firewall. Separates the Organization/Corporate Network from the Internal Perimeter Network. 

>[!NOTE]
>The NPS server on the Organization/Corporate network functions as a RADIUS Server for the VPN Server, which is a RADIUS Client. For more information about the RADIUS infrastructure, see [Network Policy Server (NPS)](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-top).

Because the Remote Access VPN server on the perimeter network is configured as a RADIUS Client and sends RADIUS traffic to the NPS on the Organization/Corporate network - and also receives RADIUS traffic from the NPS Server - you must configure the firewall to allow RADIUS traffic to flow in both directions.

Your Edge Firewall must allow and forward specific ports to your VPN server. If you use Network Address Translation \(NAT\) on your edge firewall, you might need to enable port forwarding for User Datagram Protocol \(UDP\) ports 500 and 4500. You should forward these ports to the IP address that is assigned to the external interface of your VPN server.

If you’re routing traffic inbound and performing NAT at or behind the VPN server, then you must open your firewall rules to allow ports 500 and 4500 inbound to the external IP address applied to the public interface on the VPN server.

In either case, if your firewall supports deep packet inspection and you have difficulty establishing client connections, you should attempt to relax or disable deep packet inspection for IKE sessions.

For instructions, see [Configure Firewalls for RADIUS Traffice](https://docs.microsoft.com/en-us/windows-server/networking/technologies/nps/nps-firewalls-configure)

For information on how to make these configuration changes, see your firewall documentation.




<!-- 

### RADIUS Traffic Ports on the VPN Server and NPS Server

By default, NPS and VPN listen for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. If Windows Firewall with Advanced Security is enabled when you install NPS, firewall exceptions for these ports are automatically created during the installation process for both Internet Protocol version 6 \(IPv6\) and IPv4 traffic. 

>[!IMPORTANT]
>If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.

### Use the Same RADIUS Ports for the Internal Perimeter Network Firewall Configuration

If you are using the default RADIUS port configuration on the VPN Server and the NPS Server, ensure that you open the following ports on the Internal Perimeter Network Firewall.

- Ports UDP1812, UDP1813, UDP1645, and UDP1646

If you are not using the default RADIUS ports in your NPS deployment, you must configure the firewall to allow RADIUS traffic on the ports that you are using.

For more information, see [Configure Firewalls for RADIUS Traffic](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-firewalls-configure).
-->


## Next steps
**[Configure Windows 10 Client Always On VPN Connections](vpn-deploy-client-vpn-connections.md)**. Configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection.

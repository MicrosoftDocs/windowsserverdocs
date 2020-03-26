---
title: Configure DNS and Firewall Settings
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: d8cf3bae-45bf-4ffa-9205-290d555c59da
ms.localizationpriority: medium 
ms.author: lizross
author: eross-msft
ms.date: 06/11/2018
---
# Step 5. Configure DNS and firewall settings

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Step 4. Install and Configure the NPS Server](vpn-deploy-nps.md)
- [**Next:** Step 6. Configure Windows 10 Client Always On VPN Connections](vpn-deploy-client-vpn-connections.md)

In this step, you configure DNS and Firewall settings for VPN connectivity.

## Configure DNS name resolution

When remote VPN clients connect, they use the same DNS servers that your internal clients use, which allows them to resolve names in the same manner as the rest of your internal workstations.

Because of this, you must ensure that the computer name that external clients use to connect to the VPN server matches the subject alternative name defined in certificates issued to the VPN server.

To ensure that remote clients can connect to your VPN server, you can create a DNS A (Host) record in your external DNS zone. The A record should use the certificate subject alternative name for the VPN server.

### To add a host (A or AAAA) resource record to a zone

1. On a DNS server, in Server Manager, select **Tools**, and then select **DNS**. DNS Manager opens.
2. In the DNS Manager console tree, select the server that you want to manage.
3. In the details pane, in **Name**, double-click **Forward Lookup Zones** to expand the view.
4. In **Forward Lookup Zones** details, right-click the forward lookup zone to which you want to add a record, and then select **New Host (A or AAAA)**. The **New Host** dialog box opens.
5. In **New Host**, in **Name**, enter the certificate subject alternative name for the VPN server.
6. In IP address, enter the IP address for the VPN server. You can enter the address in IP version 4 (IPv4) format to add a host (A) resource record, or IP version 6 (IPv6) format to add a host (AAAA) resource record.
7. If you created a reverse lookup zone for a range of IP addresses, including the IP address that you entered, then select the **Create associated pointer (PTR) record** check box.  Selecting this option creates an additional pointer (PTR) resource record in a reverse zone for this host, based on the information you entered in **Name** and **IP address**.
8. Select **Add Host**.

## Configure the Edge Firewall

The Edge Firewall separates the External Perimeter Network from the Public Internet. For a visual representation of this separation, see the illustration in the topic [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).

Your Edge Firewall must allow and forward specific ports to your VPN server. If you use Network Address Translation (NAT) on your edge firewall, you might need to enable port forwarding for User Datagram Protocol (UDP) ports 500 and 4500. Forward these ports to the IP address that is assigned to the external interface of your VPN server.

If you're routing traffic inbound and performing NAT at or behind the VPN server, then you must open your firewall rules to allow UDP ports 500 and 4500 inbound to the external IP address applied to the public interface on the VPN server.

In either case, if your firewall supports deep packet inspection and you have difficulty establishing client connections, you should attempt to relax or disable deep packet inspection for IKE sessions.

For information on how to make these configuration changes, see your firewall documentation.

## Configure the Internal Perimeter Network Firewall

The Internal Perimeter Network Firewall separates the Organization/Corporate Network from the Internal Perimeter Network. For a visual representation of this separation, see the illustration in the topic [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).

In this deployment, the Remote Access VPN server on the perimeter network is configured as a RADIUS client.  The VPN server sends RADIUS traffic to the NPS on the corporate network and also receives RADIUS traffic from the NPS.

Configure the firewall to allow RADIUS traffic to flow in both directions.

>[!NOTE]
>The NPS server on the Organization/Corporate network functions as a RADIUS Server for the VPN Server, which is a RADIUS Client. For more information about the RADIUS infrastructure, see [Network Policy Server (NPS)](../../../../../networking/technologies/nps/nps-top.md).

### RADIUS Traffic Ports on the VPN Server and NPS Server

By default, NPS and VPN listen for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. If you enable Windows Firewall with Advanced Security when installing NPS, firewall exceptions for these ports get created automatically during the installation process for both IPv6 and IPv4 traffic.

>[!IMPORTANT]
>If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.

### Use the Same RADIUS Ports for the Internal Perimeter Network Firewall Configuration

If you use the default RADIUS port configuration on the VPN Server and the NPS Server, make sure that you open the following ports on the Internal Perimeter Network Firewall:

- Ports UDP1812, UDP1813, UDP1645, and UDP1646

If you are not using the default RADIUS ports in your NPS deployment, you must configure the firewall to allow RADIUS traffic on the ports that you are using. For more information, see [Configure Firewalls for RADIUS Traffic](../../../../../networking/technologies/nps/nps-firewalls-configure.md).

## Next steps

[Step 6. Configure Windows 10 Client Always On VPN Connections](vpn-deploy-client-vpn-connections.md): In this step, you configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection. You can use several technologies to configure Windows 10 VPN clients, including Windows PowerShell, Microsoft Endpoint Configuration Manager, and Intune. All three require an XML VPN profile to configure the appropriate VPN settings.
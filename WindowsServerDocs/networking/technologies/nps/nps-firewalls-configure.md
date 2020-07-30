---
title: Configure Firewalls for RADIUS Traffic
description: This topic provides an overview of how to configure firewalls to allow RADIUS traffic for Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 58cca2b2-4ef3-4a09-a614-8bdc08d24f15
ms.author: lizross 
author: eross-msft
---

# Configure Firewalls for RADIUS Traffic

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Firewalls can be configured to allow or block types of IP traffic to and from the computer or device on which the firewall is running. If firewalls are not properly configured to allow RADIUS traffic between RADIUS clients, RADIUS proxies, and RADIUS servers, network access authentication can fail, preventing users from accessing network resources. 

You might need to configure two types of firewalls to allow RADIUS traffic:

- Windows Defender Firewall with Advanced Security on the local server running Network Policy Server (NPS).
- Firewalls running on other computers or hardware devices.

## Windows Firewall on the local NPS

By default, NPS sends and receives RADIUS traffic by using User Datagram Protocol \(UDP\) ports 1812, 1813, 1645, and 1646. Windows Defender Firewall on the NPS is automatically configured with exceptions, during the installation of NPS, to allow this RADIUS traffic to be sent and received.

Therefore, if you are using the default UDP ports, you do not need to change the Windows Defender Firewall configuration to allow RADIUS traffic to and from NPSs.

In some cases, you might want to change the ports that NPS uses for RADIUS traffic. If you configure NPS and your network access servers to send and receive RADIUS traffic on ports other than the defaults, you must do the following:

- Remove the exceptions that allow RADIUS traffic on the default ports.
- Create new exceptions that allow RADIUS traffic on the new ports.

For more information, see [Configure NPS UDP Port Information](nps-udp-ports-configure.md).

## Other firewalls

In the most common configuration, the firewall is connected to the Internet and the NPS is an intranet resource that is connected to the perimeter network.

To reach the domain controller within the intranet, the NPS might have:

- An interface on the perimeter network and an interface on the intranet (IP routing is not enabled). 
- A single interface on the perimeter network. In this configuration, NPS communicates with domain controllers through another firewall that connects the perimeter network to the intranet.

## Configuring the Internet firewall

The firewall that is connected to the Internet must be configured with input and output filters on its Internet interface \(and, optionally, its network perimeter interface\), to allow the forwarding of RADIUS messages between the NPS and RADIUS clients or proxies on the Internet. Additional filters can be used to allow the passing of traffic to Web servers, VPN servers, and other types of servers on the perimeter network.

Separate input and output packet filters can be configured on the Internet interface and the perimeter network interface.

### Configure Input Filters on the Internet Interface

Configure the following input packet filters on the Internet interface of the firewall to allow the following types of traffic:

- Destination IP address of the perimeter network interface and UDP destination port of 1812 (0x714) of the NPS.  This filter allows RADIUS authentication traffic from Internet-based RADIUS clients to the NPS. This is the default UDP port that is used by NPS, as defined in RFC 2865. If you are using a different port, substitute that port number for 1812.
- Destination IP address of the perimeter network interface and UDP destination port of 1813 (0x715) of the NPS. This filter allows RADIUS accounting traffic from Internet-based RADIUS clients to the NPS. This is the default UDP port that is used by NPS, as defined in RFC 2866. If you are using a different port, substitute that port number for 1813.
- \(Optional\) Destination IP address of the perimeter network interface and UDP destination port of 1645 \(0x66D\) of the NPS. This filter allows RADIUS authentication traffic from Internet-based RADIUS clients to the NPS. This is the UDP port that is used by older RADIUS clients.
- \(Optional\) Destination IP address of the perimeter network interface and UDP destination port of 1646 \(0x66E\) of the NPS. This filter allows RADIUS accounting traffic from Internet-based RADIUS clients to the NPS. This is the UDP port that is used by older RADIUS clients.

### Configure Output Filters on the Internet Interface

Configure the following output filters on the Internet interface of the firewall to allow the following types of traffic:

- Source IP address of the perimeter network interface and UDP source port of 1812 (0x714) of the NPS. This filter allows RADIUS authentication traffic from the NPS to Internet-based RADIUS clients. This is the default UDP port that is used by NPS, as defined in RFC 2865. If you are using a different port, substitute that port number for 1812.
- Source IP address of the perimeter network interface and UDP source port of 1813 (0x715) of the NPS. This filter allows RADIUS accounting traffic from the NPS to Internet-based RADIUS clients. This is the default UDP port that is used by NPS, as defined in RFC 2866. If you are using a different port, substitute that port number for 1813.
- \(Optional\) Source IP address of the perimeter network interface and UDP source port of 1645 \(0x66D\) of the NPS. This filter allows RADIUS authentication traffic from the NPS to Internet-based RADIUS clients. This is the UDP port that is used by older RADIUS clients.
- \(Optional\) Source IP address of the perimeter network interface and UDP source port of 1646 \(0x66E\) of the NPS. This filter allows RADIUS accounting traffic from the NPS to Internet-based RADIUS clients. This is the UDP port that is used by older RADIUS clients.

### Configure Input Filters on the Perimeter Network Interface

Configure the following input filters on the perimeter network interface of the firewall to allow the following types of traffic:

- Source IP address of the perimeter network interface and UDP source port of 1812 (0x714) of the NPS. This filter allows RADIUS authentication traffic from the NPS to Internet-based RADIUS clients. This is the default UDP port that is used by NPS, as defined in RFC 2865. If you are using a different port, substitute that port number for 1812.
- Source IP address of the perimeter network interface and UDP source port of 1813 (0x715) of the NPS. This filter allows RADIUS accounting traffic from the NPS to Internet-based RADIUS clients. This is the default UDP port that is used by NPS, as defined in RFC 2866. If you are using a different port, substitute that port number for 1813.
- \(Optional\) Source IP address of the perimeter network interface and UDP source port of 1645 \(0x66D\) of the NPS. This filter allows RADIUS authentication traffic from the NPS to Internet-based RADIUS clients. This is the UDP port that is used by older RADIUS clients.
- \(Optional\) Source IP address of the perimeter network interface and UDP source port of 1646 \(0x66E\) of the NPS. This filter allows RADIUS accounting traffic from the NPS to Internet-based RADIUS clients. This is the UDP port that is used by older RADIUS clients.

### Configure Output Filters on the Perimeter Network Interface

Configure the following output packet filters on the perimeter network interface of the firewall to allow the following types of traffic:

- Destination IP address of the perimeter network interface and UDP destination port of 1812 (0x714) of the NPS. This filter allows RADIUS authentication traffic from Internet-based RADIUS clients to the NPS. This is the default UDP port that is used by NPS, as defined in RFC 2865. If you are using a different port, substitute that port number for 1812.
- Destination IP address of the perimeter network interface and UDP destination port of 1813 (0x715) of the NPS. This filter allows RADIUS accounting traffic from Internet-based RADIUS clients to the NPS. This is the default UDP port that is used by NPS, as defined in RFC 2866. If you are using a different port, substitute that port number for 1813.
- \(Optional\) Destination IP address of the perimeter network interface and UDP destination port of 1645 \(0x66D\) of the NPS. This filter allows RADIUS authentication traffic from Internet-based RADIUS clients to the NPS. This is the UDP port that is used by older RADIUS clients.
- \(Optional\) Destination IP address of the perimeter network interface and UDP destination port of 1646 \(0x66E\) of the NPS. This filter allows RADIUS accounting traffic from Internet-based RADIUS clients to the NPS. This is the UDP port that is used by older RADIUS clients.

For added security, you can use the IP addresses of each RADIUS client that sends the packets through the firewall to define filters for traffic between the client and the IP address of the NPS on the perimeter network.

### Filters on the perimeter network interface

Configure the following input packet filters on the perimeter network interface of the intranet firewall to allow the following types of traffic:

- Source IP address of the perimeter network interface of the NPS. This filter allows traffic from the NPS on the perimeter network.

Configure the following output filters on the perimeter network interface of the intranet firewall to allow the following types of traffic:

- Destination IP address of the perimeter network interface of the NPS. This filter allows traffic to the NPS on the perimeter network.

### Filters on the intranet interface

Configure the following input filters on the intranet interface of the firewall to allow the following types of traffic:

- Destination IP address of the perimeter network interface of the NPS. This filter allows traffic to the NPS on the perimeter network.

Configure the following output packet filters on the intranet interface of the firewall to allow the following types of traffic:

- Source IP address of the perimeter network interface of the NPS. This filter allows traffic from the NPS on the perimeter network.


For more information about managing NPS, see [Manage Network Policy Server](nps-manage-top.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).





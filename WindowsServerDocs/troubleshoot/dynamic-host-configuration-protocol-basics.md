---
title: DHCP (Dynamic Host Configuration Protocol) Basics
description: "Learn more about: DHCP (Dynamic Host Configuration Protocol) Basics"
manager: dcscontentpm
ms.date: 5/26/2020
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
ms.reviewer:
---
# DHCP (Dynamic Host Configuration Protocol) Basics

Dynamic Host Configuration Protocol (DHCP) is a standard protocol defined by RFC 1541 (which is superseded by RFC 2131) that allows a server to dynamically distribute IP addressing and configuration information to clients. Normally the DHCP server provides the client with at least this basic information:

- IP Address

- Subnet Mask

- Default Gateway

Other information can be provided as well, such as Domain Name Service (DNS) server addresses and Windows Internet Name Service (WINS) server addresses. The system administrator configures the DHCP server with the options that are parsed out to the client.

## More Information

The following Microsoft products provide DHCP client functionality:

- Windows NT Server versions 3.5, 3.51, and 4.0

- Windows NT Workstation versions 3.5, 3.51, and 4.0

- Windows 95

- Microsoft Network Client version 3.0 for MS-DOS

- Microsoft LAN Manager Client version 2.2c for MS-DOS

- Microsoft TCP/IP-32 for Windows for Workgroups versions 3.11, 3.11a, and 3.11b

Different DHCP clients support different options that they can receive from the DHCP server.

The following Microsoft server operating systems provide DHCP server functionality:

- Windows NT Server version 3.5

- Windows NT Server version 3.51

- Windows NT Server version 4.0

When a client is initialized for the first time after it is configured to receive DHCP information, it initiates a conversation with the server.

Below is a summary table of the conversation between client and server, which is followed by a packet-level description of the process:

```
Source Dest Source Dest Packet
 MAC addr MAC addr IP addr IP addr Description
 -----------------------------------------------------------------
 Client Broadcast 0.0.0.0 255.255.255.255 DHCP Discover
 DHCPsrvr Broadcast DHCPsrvr 255.255.255.255 DHCP Offer
 Client Broadcast 0.0.0.0 255.255.255.255 DHCP Request
 DHCPsrvr Broadcast DHCPsrvr 255.255.255.255 DHCP ACK
```

The detailed conversation between DHCP client and DHCP server is as follows:

### DHCPDISCOVER

The client sends a DHCPDISCOVER packet. The following is an excerpt from a network monitor capture showing the IP and DHCP portions of a DHCPDISCOVER packet. In the IP section, you can see the Destination address is 255.255.255.255 and the Source address is 0.0.0.0. The DHCP section identifies the packet as a Discover packet and identifies the client in two places using the physical address of the network card. Note the values in the CHADDR field and the DHCP: Client Identifier field are identical.

```

IP: ID = 0x0; Proto = UDP; Len: 328
 IP: Version = 4 (0x4)
 IP: Header Length = 20 (0x14)
 IP: Service Type = 0 (0x0)
 IP: Precedence = Routine
 IP: ...0.... = Normal Delay
 IP: ....0... = Normal Throughput
 IP: .....0.. = Normal Reliability
 IP: Total Length = 328 (0x148)
 IP: Identification = 0 (0x0)
 IP: Flags Summary = 0 (0x0)
 IP: .......0 = Last fragment in datagram
 IP: ......0. = May fragment datagram if necessary
 IP: Fragment Offset = 0 (0x0) bytes
 IP: Time to Live = 128 (0x80)
 IP: Protocol = UDP - User Datagram
 IP: Checksum = 0x39A6
 IP: Source Address = 0.0.0.0
 IP: Destination Address = 255.255.255.255
 IP: Data: Number of data bytes remaining = 308 (0x0134)

DHCP: Discover (xid=21274A1D)
 DHCP: Op Code (op) = 1 (0x1)
 DHCP: Hardware Type (htype) = 1 (0x1) 10Mb Ethernet
 DHCP: Hardware Address Length (hlen) = 6 (0x6)
 DHCP: Hops (hops) = 0 (0x0)
 DHCP: Transaction ID (xid) = 556223005 (0x21274A1D)
 DHCP: Seconds (secs) = 0 (0x0)
 DHCP: Flags (flags) = 0 (0x0)
 DHCP: 0............... = No Broadcast
 DHCP: Client IP Address (ciaddr) = 0.0.0.0
 DHCP: Your IP Address (yiaddr) = 0.0.0.0
 DHCP: Server IP Address (siaddr) = 0.0.0.0
 DHCP: Relay IP Address (giaddr) = 0.0.0.0
 DHCP: Client Ethernet Address (chaddr) = 08002B2ED85E
 DHCP: Server Host Name (sname) = <Blank>
 DHCP: Boot File Name (file) = <Blank>
 DHCP: Magic Cookie = [OK]
 DHCP: Option Field (options)
 DHCP: DHCP Message Type = DHCP Discover
 DHCP: Client-identifier = (Type: 1) 08 00 2b 2e d8 5e
 DHCP: Host Name = JUMBO-WS
 DHCP: Parameter Request List = (Length: 7) 01 0f 03 2c 2e 2f 06
 DHCP: End of this option field

```

### DHCPOFFER

The DHCP server responds by sending a DHCPOFFER packet. In the IP section of the capture excerpt below, the Source address is now the DHCP server IP address, and the Destination address is the broadcast address 255.255.255.255. The DHCP section identifies the packet as an Offer. The YIADDR field is populated with the IP address the server is offering the client. Note the CHADDR field still contains the physical address of the requesting client. Also, we see in the DHCP Option Field section the various options being sent by the server along with the IP address. In this case the server is sending the Subnet Mask, Default Gateway (Router), Lease Time, WINS server address (NetBIOS Name Service), and the NetBIOS Node Type.

```

IP: ID = 0x3C30; Proto = UDP; Len: 328
 IP: Version = 4 (0x4)
 IP: Header Length = 20 (0x14)
 IP: Service Type = 0 (0x0)
 IP: Precedence = Routine
 IP: ...0.... = Normal Delay
 IP: ....0... = Normal Throughput
 IP: .....0.. = Normal Reliability
 IP: Total Length = 328 (0x148)
 IP: Identification = 15408 (0x3C30)
 IP: Flags Summary = 0 (0x0)
 IP: .......0 = Last fragment in datagram
 IP: ......0. = May fragment datagram if necessary
 IP: Fragment Offset = 0 (0x0) bytes
 IP: Time to Live = 128 (0x80)
 IP: Protocol = UDP - User Datagram
 IP: Checksum = 0x2FA8
 IP: Source Address = 157.54.48.151
 IP: Destination Address = 255.255.255.255
 IP: Data: Number of data bytes remaining = 308 (0x0134)

DHCP: Offer (xid=21274A1D)
 DHCP: Op Code (op) = 2 (0x2)
 DHCP: Hardware Type (htype) = 1 (0x1) 10Mb Ethernet
 DHCP: Hardware Address Length (hlen) = 6 (0x6)
 DHCP: Hops (hops) = 0 (0x0)
 DHCP: Transaction ID (xid) = 556223005 (0x21274A1D)
 DHCP: Seconds (secs) = 0 (0x0)
 DHCP: Flags (flags) = 0 (0x0)
 DHCP: 0............... = No Broadcast
 DHCP: Client IP Address (ciaddr) = 0.0.0.0
 DHCP: Your IP Address (yiaddr) = 157.54.50.5
 DHCP: Server IP Address (siaddr) = 0.0.0.0
 DHCP: Relay IP Address (giaddr) = 0.0.0.0
 DHCP: Client Ethernet Address (chaddr) = 08002B2ED85E
 DHCP: Server Host Name (sname) = <Blank>
 DHCP: Boot File Name (file) = <Blank>
 DHCP: Magic Cookie = [OK]
 DHCP: Option Field (options)
 DHCP: DHCP Message Type = DHCP Offer
 DHCP: Subnet Mask = 255.255.240.0
 DHCP: Renewal Time Value (T1) = 8 Days, 0:00:00
 DHCP: Rebinding Time Value (T2) = 14 Days, 0:00:00
 DHCP: IP Address Lease Time = 16 Days, 0:00:00
 DHCP: Server Identifier = 157.54.48.151
 DHCP: Router = 157.54.48.1
 DHCP: NetBIOS Name Service = 157.54.16.154
 DHCP: NetBIOS Node Type = (Length: 1) 04
 DHCP: End of this option field

```

### DHCPREQUEST

The client responds to the DHCPOFFER by sending a DHCPREQUEST. In the IP section of the capture below, the Source address of the client is still 0.0.0.0 and the Destination for the packet is still 255.255.255.255. The client retains 0.0.0.0 because the client hasn't received verification from the server that it's okay to start using the address offered. The Destination is still broadcast, because more than one DHCP server may have responded and may be holding a reservation for an Offer made to the client. This lets those other DHCP servers know they can release their offered addresses and return them to their available pools. The DHCP section identifies the packet as a Request and verifies the offered address using the DHCP: Requested Address field. The DHCP: Server Identifier field shows the IP address of the DHCP server offering the lease.

```

IP: ID = 0x100; Proto = UDP; Len: 328
 IP: Version = 4 (0x4)
 IP: Header Length = 20 (0x14)
 IP: Service Type = 0 (0x0)
 IP: Precedence = Routine
 IP: ...0.... = Normal Delay
 IP: ....0... = Normal Throughput
 IP: .....0.. = Normal Reliability
 IP: Total Length = 328 (0x148)
 IP: Identification = 256 (0x100)
 IP: Flags Summary = 0 (0x0)
 IP: .......0 = Last fragment in datagram
 IP: ......0. = May fragment datagram if necessary
 IP: Fragment Offset = 0 (0x0) bytes
 IP: Time to Live = 128 (0x80)
 IP: Protocol = UDP - User Datagram
 IP: Checksum = 0x38A6
 IP: Source Address = 0.0.0.0
 IP: Destination Address = 255.255.255.255
 IP: Data: Number of data bytes remaining = 308 (0x0134)

DHCP: Request (xid=21274A1D)
 DHCP: Op Code (op) = 1 (0x1)
 DHCP: Hardware Type (htype) = 1 (0x1) 10Mb Ethernet
 DHCP: Hardware Address Length (hlen) = 6 (0x6)
 DHCP: Hops (hops) = 0 (0x0)
 DHCP: Transaction ID (xid) = 556223005 (0x21274A1D)
 DHCP: Seconds (secs) = 0 (0x0)
 DHCP: Flags (flags) = 0 (0x0)
 DHCP: 0............... = No Broadcast
 DHCP: Client IP Address (ciaddr) = 0.0.0.0
 DHCP: Your IP Address (yiaddr) = 0.0.0.0
 DHCP: Server IP Address (siaddr) = 0.0.0.0
 DHCP: Relay IP Address (giaddr) = 0.0.0.0
 DHCP: Client Ethernet Address (chaddr) = 08002B2ED85E
 DHCP: Server Host Name (sname) = <Blank>
 DHCP: Boot File Name (file) = <Blank>
 DHCP: Magic Cookie = [OK]
 DHCP: Option Field (options)
 DHCP: DHCP Message Type = DHCP Request
 DHCP: Client-identifier = (Type: 1) 08 00 2b 2e d8 5e
 DHCP: Requested Address = 157.54.50.5
 DHCP: Server Identifier = 157.54.48.151
 DHCP: Host Name = JUMBO-WS
 DHCP: Parameter Request List = (Length: 7) 01 0f 03 2c 2e 2f 06
 DHCP: End of this option field

```

### DHCPACK

The DHCP server responds to the DHCPREQUEST with a DHCPACK, thus completing the initialization cycle. The Source address is the DHCP server IP address, and the Destination address is still 255.255.255.255. The YIADDR field contains the client's address, and the CHADDR and DHCP: Client Identifier fields are the physical address of the network card in the requesting client. The DHCP Option section identifies the packet as an ACK.

```

IP: ID = 0x3D30; Proto = UDP; Len: 328
 IP: Version = 4 (0x4)
 IP: Header Length = 20 (0x14)
 IP: Service Type = 0 (0x0)
 IP: Precedence = Routine
 IP: ...0.... = Normal Delay
 IP: ....0... = Normal Throughput
 IP: .....0.. = Normal Reliability
 IP: Total Length = 328 (0x148)
 IP: Identification = 15664 (0x3D30)
 IP: Flags Summary = 0 (0x0)
 IP: .......0 = Last fragment in datagram
 IP: ......0. = May fragment datagram if necessary
 IP: Fragment Offset = 0 (0x0) bytes
 IP: Time to Live = 128 (0x80)
 IP: Protocol = UDP - User Datagram
 IP: Checksum = 0x2EA8
 IP: Source Address = 157.54.48.151
 IP: Destination Address = 255.255.255.255
 IP: Data: Number of data bytes remaining = 308 (0x0134)

DHCP: ACK (xid=21274A1D)
 DHCP: Op Code (op) = 2 (0x2)
 DHCP: Hardware Type (htype) = 1 (0x1) 10Mb Ethernet
 DHCP: Hardware Address Length (hlen) = 6 (0x6)
 DHCP: Hops (hops) = 0 (0x0)
 DHCP: Transaction ID (xid) = 556223005 (0x21274A1D)
 DHCP: Seconds (secs) = 0 (0x0)
 DHCP: Flags (flags) = 0 (0x0)
 DHCP: 0............... = No Broadcast
 DHCP: Client IP Address (ciaddr) = 0.0.0.0
 DHCP: Your IP Address (yiaddr) = 157.54.50.5
 DHCP: Server IP Address (siaddr) = 0.0.0.0
 DHCP: Relay IP Address (giaddr) = 0.0.0.0
 DHCP: Client Ethernet Address (chaddr) = 08002B2ED85E
 DHCP: Server Host Name (sname) = <Blank>
 DHCP: Boot File Name (file) = <Blank>
 DHCP: Magic Cookie = [OK]
 DHCP: Option Field (options)
 DHCP: DHCP Message Type = DHCP ACK
 DHCP: Renewal Time Value (T1) = 8 Days, 0:00:00
 DHCP: Rebinding Time Value (T2) = 14 Days, 0:00:00
 DHCP: IP Address Lease Time = 16 Days, 0:00:00
 DHCP: Server Identifier = 157.54.48.151
 DHCP: Subnet Mask = 255.255.240.0
 DHCP: Router = 157.54.48.1
 DHCP: NetBIOS Name Service = 157.54.16.154
 DHCP: NetBIOS Node Type = (Length: 1) 04
 DHCP: End of this option field

```

If the client has previously had a DHCP assigned IP address and it is restarted, the client will specifically request the previously leased IP address in a special DHCPREQUEST packet. The Source address is 0.0.0.0 and the Destination is the broadcast address 255.255.255.255. Microsoft clients will populate the DHCP Option Field DHCP: Requested Address with the previously assigned address. Strictly RFC compliant clients will populate the CIADDR Field with the address requested. The Microsoft DHCP server will accept either.

```

IP: ID = 0x0; Proto = UDP; Len: 328
 IP: Version = 4 (0x4)
 IP: Header Length = 20 (0x14)
 IP: Service Type = 0 (0x0)
 IP: Precedence = Routine
 IP: ...0.... = Normal Delay
 IP: ....0... = Normal Throughput
 IP: .....0.. = Normal Reliability
 IP: Total Length = 328 (0x148)
 IP: Identification = 0 (0x0)
 IP: Flags Summary = 0 (0x0)
 IP: .......0 = Last fragment in datagram
 IP: ......0. = May fragment datagram if necessary
 IP: Fragment Offset = 0 (0x0) bytes
 IP: Time to Live = 128 (0x80)
 IP: Protocol = UDP - User Datagram
 IP: Checksum = 0x39A6
 IP: Source Address = 0.0.0.0
 IP: Destination Address = 255.255.255.255
 IP: Data: Number of data bytes remaining = 308 (0x0134)

DHCP: Request (xid=2757554E)
 DHCP: Op Code (op) = 1 (0x1)
 DHCP: Hardware Type (htype) = 1 (0x1) 10Mb Ethernet
 DHCP: Hardware Address Length (hlen) = 6 (0x6)
 DHCP: Hops (hops) = 0 (0x0)
 DHCP: Transaction ID (xid) = 660034894 (0x2757554E)
 DHCP: Seconds (secs) = 0 (0x0)
 DHCP: Flags (flags) = 0 (0x0)
 DHCP: 0............... = No Broadcast
 DHCP: Client IP Address (ciaddr) = 0.0.0.0
 DHCP: Your IP Address (yiaddr) = 0.0.0.0
 DHCP: Server IP Address (siaddr) = 0.0.0.0
 DHCP: Relay IP Address (giaddr) = 0.0.0.0
 DHCP: Client Ethernet Address (chaddr) = 08002B2ED85E
 DHCP: Server Host Name (sname) = <Blank>
 DHCP: Boot File Name (file) = <Blank>
 DHCP: Magic Cookie = [OK]
 DHCP: Option Field (options)
 DHCP: DHCP Message Type = DHCP Request
 DHCP: Client-identifier = (Type: 1) 08 00 2b 2e d8 5e
 DHCP: Requested Address = 157.54.50.5
 DHCP: Host Name = JUMBO-WS
 DHCP: Parameter Request List = (Length: 7) 01 0f 03 2c 2e 2f 06
 DHCP: End of this option field

```

At this point, the server may or may not respond. The behavior of the Windows NT DHCP server depends on the version of the operating system being used as well as other factors such as superscoping. If the server determines that the client can still use the address, it will either remain silent or ACK the DHCPREQUEST. If the server determines that the client cannot have the address, it will send a NACK.

```

IP: ID = 0x3F1A; Proto = UDP; Len: 328
 IP: Version = 4 (0x4)
 IP: Header Length = 20 (0x14)
 IP: Service Type = 0 (0x0)
 IP: Precedence = Routine
 IP: ...0.... = Normal Delay
 IP: ....0... = Normal Throughput
 IP: .....0.. = Normal Reliability
 IP: Total Length = 328 (0x148)
 IP: Identification = 16154 (0x3F1A)
 IP: Flags Summary = 0 (0x0)
 IP: .......0 = Last fragment in datagram
 IP: ......0. = May fragment datagram if necessary
 IP: Fragment Offset = 0 (0x0) bytes
 IP: Time to Live = 128 (0x80)
 IP: Protocol = UDP - User Datagram
 IP: Checksum = 0x2CBE
 IP: Source Address = 157.54.48.151
 IP: Destination Address = 255.255.255.255
 IP: Data: Number of data bytes remaining = 308 (0x0134)

DHCP: NACK (xid=74A005CE)
 DHCP: Op Code (op) = 2 (0x2)
 DHCP: Hardware Type (htype) = 1 (0x1) 10Mb Ethernet
 DHCP: Hardware Address Length (hlen) = 6 (0x6)
 DHCP: Hops (hops) = 0 (0x0)
 DHCP: Transaction ID (xid) = 1956644302 (0x74A005CE)
 DHCP: Seconds (secs) = 0 (0x0)
 DHCP: Flags (flags) = 0 (0x0)
 DHCP: 0............... = No Broadcast
 DHCP: Client IP Address (ciaddr) = 0.0.0.0
 DHCP: Your IP Address (yiaddr) = 0.0.0.0
 DHCP: Server IP Address (siaddr) = 0.0.0.0
 DHCP: Relay IP Address (giaddr) = 0.0.0.0
 DHCP: Client Ethernet Address (chaddr) = 08002B2ED85E
 DHCP: Server Host Name (sname) = <Blank>
 DHCP: Boot File Name (file) = <Blank>
 DHCP: Magic Cookie = [OK]
 DHCP: Option Field (options)
 DHCP: DHCP Message Type = DHCP NACK
 DHCP: Server Identifier = 157.54.48.151
 DHCP: End of this option field

```

The client will then begin the discover process, but the DHCPDISCOVER packet will still attempt to lease the same address. In many instances, the client will get the same address but may not.

```

IP: ID = 0x100; Proto = UDP; Len: 328
 IP: Version = 4 (0x4)
 IP: Header Length = 20 (0x14)
 IP: Service Type = 0 (0x0)
 IP: Precedence = Routine
 IP: ...0.... = Normal Delay
 IP: ....0... = Normal Throughput
 IP: .....0.. = Normal Reliability
 IP: Total Length = 328 (0x148)
 IP: Identification = 256 (0x100)
 IP: Flags Summary = 0 (0x0)
 IP: .......0 = Last fragment in datagram
 IP: ......0. = May fragment datagram if necessary
 IP: Fragment Offset = 0 (0x0) bytes
 IP: Time to Live = 128 (0x80)
 IP: Protocol = UDP - User Datagram
 IP: Checksum = 0x38A6
 IP: Source Address = 0.0.0.0
 IP: Destination Address = 255.255.255.255
 IP: Data: Number of data bytes remaining = 308 (0x0134)

DHCP: Discover (xid=3ED14752)
 DHCP: Op Code (op) = 1 (0x1)
 DHCP: Hardware Type (htype) = 1 (0x1) 10Mb Ethernet
 DHCP: Hardware Address Length (hlen) = 6 (0x6)
 DHCP: Hops (hops) = 0 (0x0)
 DHCP: Transaction ID (xid) = 1053902674 (0x3ED14752)
 DHCP: Seconds (secs) = 0 (0x0)
 DHCP: Flags (flags) = 0 (0x0)
 DHCP: 0............... = No Broadcast
 DHCP: Client IP Address (ciaddr) = 0.0.0.0
 DHCP: Your IP Address (yiaddr) = 0.0.0.0
 DHCP: Server IP Address (siaddr) = 0.0.0.0
 DHCP: Relay IP Address (giaddr) = 0.0.0.0
 DHCP: Client Ethernet Address (chaddr) = 08002B2ED85E
 DHCP: Server Host Name (sname) = <Blank>
 DHCP: Boot File Name (file) = <Blank>
 DHCP: Magic Cookie = [OK]
 DHCP: Option Field (options)
 DHCP: DHCP Message Type = DHCP Discover
 DHCP: Client-identifier = (Type: 1) 08 00 2b 2e d8 5e
 DHCP: Requested Address = 157.54.51.5
 DHCP: Host Name = JUMBO-WS
 DHCP: Parameter Request List = (Length: 7) 01 0f 03 2c 2e 2f 06
 DHCP: End of this option field

```

DHCP information obtained by the client from a DHCP server will have a lease time associated with it. The lease time defines how long the client can use the DHCP-assigned information. When the lease reaches certain milestones, the client will attempt to renew its DHCP information.

To view IP information on a Windows or Windows for Workgroups client, use the IPCONFIG utility. If the client is Windows 95, use WINIPCFG.

## References

For more information about DHCP, see RFC1541 and RFC2131. RFCs may be obtained via the Internet at numerous sites, for example: [http://www.rfc-editor.org/](http://www.rfc-editor.org/)
and [http://www.tech-nic.qc.ca/](http://www.tech-nic.qc.ca/)

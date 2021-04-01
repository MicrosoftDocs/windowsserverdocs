---
title: How to use automatic TCP/IP addressing without a DHCP server
description: Introduce how to use automatic TCP/IP addressing without a DHCP server.
manager: dcscontentpm
ms.date: 5/26/2020
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
ms.reviewer: robsmi
---
# How to use automatic TCP/IP addressing without a DHCP server

This article describes how to use automatic Transmission Control Protocol/Internet Protocol (TCP/IP) addressing without a Dynamic Host Configuration Protocol (DHCP) server being present on the network. The operating system versions listed in the "Applies to" section of this article have a feature called Automatic Private IP Addressing (APIPA). With this feature, a Windows computer can assign itself an Internet Protocol (IP) address in the event that a DHCP server is not available or does not exist on the network. This feature makes configuring and supporting a small Local Area Network (LAN) running TCP/IP less difficult.

## More Information

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

A Windows-based computer that is configured to use DHCP can automatically assign itself an Internet Protocol (IP) address if a DHCP server is not available. For example, this could occur on a network without a DHCP server, or on a network if a DHCP server is temporarily down for maintenance.

The Internet Assigned Numbers Authority (IANA) has reserved 169.254.0.0-169.254.255.255 for Automatic Private IP Addressing. As a result, APIPA provides an address that is guaranteed not to conflict with routable addresses.

After the network adapter has been assigned an IP address, the computer can use TCP/IP to communicate with any other computer that is connected to the same LAN and that is also configured for APIPA or has the IP address manually set to the 169.254.x.y (where x.y is the client's unique identifier) address range with a subnet mask of 255.255.0.0. Note that the computer cannot communicate with computers on other subnets, or with computers that do not use automatic private IP addressing. Automatic private IP addressing is enabled by default.

You may want to disable it in any of the following cases:

- Your network uses routers.

- Your network is connected to the Internet without a NAT or proxy server.

Unless you have disabled DHCP-related messages, DHCP messages provide you with notification when you change between DHCP addressing and automatic private IP addressing. If DHCP messaging is accidentally disabled, you can turn the DHCP messages back on by changing the value of the PopupFlag value in the following registry key from 00 to 01:
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\DHCP`

Note that you must restart your computer for the change to take effect. You can also determine whether your computer is using APIPA by using the Winipcfg tool in Windows Millennium Edition, Windows 98, or Windows 98 Second Edition:

Click Start , click Run , type "winipcfg" (without the quotation marks), and then click OK . Click More Info . If the IP Autoconfiguration Address box contains an IP address within the 169.254.x.x range, Automatic Private IP Addressing is enabled. If the IP Address box exists, automatic private IP addressing is not currently enabled.
For Windows 2000, Windows XP, or Windows Server 2003, you can determine whether your computer is using APIPA by using the IPconfig command at a command prompt:

Click Start , click Run , type "cmd" (without the quotation marks), and then click OK to open a MS-DOS command line window. Type "ipconfig /all" (without the quotation marks), and then hit the ENTER key. If the 'Autoconfiguration Enabled' line says "Yes", and the 'Autoconfiguration IP Address' is 169.254.x.y (where x.y is the client's unique identifier), then the computer is using APIPA. If the 'Autoconfiguration Enabled' line says "No", then the computer is not currently using APIPA.
You can disable automatic private IP addressing by using either of the following methods.

You can configure the TCP/IP information manually, which disables DHCP altogether. You can disable automatic private IP addressing (but not DHCP) by editing the registry. You can do so by adding the "IPAutoconfigurationEnabled" DWORD registry entry with a value of 0x0 to the following registry key for Windows Millennium Edition, Windows98, or Windows 98 Second Edition:  `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\DHCP`

For Windows 2000, Windows XP, and Windows Server 2003, APIPA can be disabled by adding the "IPAutoconfigurationEnabled" DWORD registry entry with a value of 0x0 to the following registry key:
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\<Adapter GUID>`
> [!NOTE]
> The **Adapter GUID** subkey is a globally unique identifier (GUID) for the computer's LAN adapter.

Specifying a value of 1 for IPAutoconfigurationEnabled DWORD entry will enable APIPA, which is the default state when this value is omitted from the registry.

## Examples of Where APIPA may be useful

### Example 1: No Previous IP Address and no DHCP Server

When your Windows-based computer (configured for DHCP) is initializing, it broadcasts three or more "discover" messages. If a DHCP server does not respond after several discover messages are broadcast, the Windows computer assigns itself a Class B (APIPA) address. Then the Windows computer will display an error message to the user of the computer (providing it has never been assigned an IP address from a DHCP server in the past). The Windows computer will then send out a Discover message every three minutes in an attempt to establish communications with a DHCP server.

### Example 2: Previous IP Address and no DHCP Server

The computer checks for the DHCP server and if none are found, an attempt is made to contact the default gateway. If the default gateway replies, then the Windows computer retains the previously-leased IP address. However, if the computer does not receive a response from the default gateway or if none are assigned, then it uses the automatic private IP addressing feature to assign itself an IP address. An error message is presented to the user and discover messages are transmitted every 3 minutes. Once a DHCP server comes on line, a message is generated stating communications have been re-established with a DHCP Server.

### Example 3: Lease Expires and no DHCP Server

The Windows-based computer tries to re-establish the lease of the IP address. If the Windows computer does not find a DCHP server, it assigns itself an IP address after generating an error message. The computer then broadcasts four discover messages, and after every 5 minutes it repeats the whole procedure until a DHCP server comes on line. A message is then generated stating that communications have been re-established with the DHCP Server.

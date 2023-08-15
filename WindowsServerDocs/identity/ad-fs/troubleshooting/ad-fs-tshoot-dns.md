---
title: AD FS Troubleshooting - DNS Resolution
description:  This document describes how to troubleshoot DNS aspects of AD FS
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---

# AD FS Troubleshooting - DNS
One of the first things to check, if AD FS is not working or responding, is DNS name resolution.  These are basic tests to determine if the AD FS servers or WAP servers are being found on your network.  For internal users, these tests should resolve to the AD FS servers (STS).    For external users, these tests should resolve to the WAP servers.

The remainder of this document will show how to do some quick name resolution checks using command-line tools.

## Ping test
Verifies IP-level connectivity to another TCP/IP computer by sending Internet Control Message Protocol (ICMP) Echo Request messages. The receipt of corresponding Echo Reply messages are displayed, along with round-trip times.  For more information, see [Ping](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff961503(v=ws.11)).


>[!NOTE]
>Be aware that some organizations block this port on their servers and you may get a **Request timed out** response.

### To use a PING test
1.  Open a command prompt
2. Enter ```ping <name of AD FS server>```
    a. Example:  ping sts.contoso.com
3. You should see a reply from the server

![Ping](media/ad-fs-tshoot-dns/dns1.png)

## NSLookup
Displays information that you can use to diagnose Domain Name System (DNS) infrastructure.  For more information, see [NSLookup](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc725991(v=ws.11)).

### To use a NSLookup
1.  Open a command prompt
2. Enter ```nslookup <name of AD FS server>```
    a. Example:  nslookup sts.contoso.com
3. You should see the dns information for the server
![NSLookup](media/ad-fs-tshoot-dns/dns2.png)

## Tracert
Determines the path taken to a destination by sending Internet Control Message Protocol (ICMP) Echo Request or ICMPv6 messages to the destination with incrementally increasing Time to Live (TTL) field values.   For more information, see [Tracert](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff961507(v=ws.11)).


### To use Tracert
1.  Open a command prompt
2. Enter ```tracert <name of AD FS server>```
    a. Example:  tracert sts.contoso.com
3. You should see the destination path used to reach the server
![Tracert](media/ad-fs-tshoot-dns/dns3.png)

## Next Steps

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)

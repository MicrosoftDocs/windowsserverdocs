---
title: What's New in DHCP
description: This topic provides an overview of new features for Dynamic Host Configuration Protocol (DHCP) in Windows Server 2016.
manager: brianlic
ms.topic: how-to
ms.assetid: c6f36998-5b64-45d1-b1f0-0f0d6604dbe3
ms.author: jgerend
author: JasonGerend
ms.date: 12/09/2020
---
# What's New in DHCP

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This topic describes the Dynamic Host Configuration Protocol (DHCP) functionality that is new or changed in Windows Server 2016.

DHCP is an Internet Engineering Task Force (IETF) standard that is designed to reduce the administrative burden and complexity of configuring hosts on a TCP/IP\-based network, such as a private intranet. By using the DHCP Server service, the process of configuring TCP/IP on DHCP clients is automatic.

The following sections provide information about new features and changes in functionality for DHCP.

## New DHCP Client-side features in the Windows 10 May 2020 Update

The DHCP client in Windows 10 has been updated in the 10 May 2020 Update (also referred to as Windows 10, version 2004). When you're running a Windows client and connect to the internet via a tethered Android phone, the connection should be marked as "metered". Previously, the connections were marked as unmetered. Note that not all Android tethered phones will be detected as metered, and some other networks may also show up as metered.

Additionally, the traditional Client Vendor Name has been updated for some Windows-based devices. This value used to be simply MSFT 5.0. Some devices will now show up as MSFT 5.0 XBOX.

## New DHCP Client-side features in the Windows 10 April 2018 Update

The DHCP client in Windows 10 has been updated in the Windows April 2018 Update (also referred to as Windows 10, version 1803) to read in and apply option 119, the Domain Search Option, from the DHCP server that your system connects to. The Domain Search Option provides DNS suffixes for DNS lookups of short names. DHCP option 119 is specified in [RFC 3397](https://tools.ietf.org/html/rfc3397).

## DHCP Subnet Selection Options

DHCP now supports option 82 \(sub-option 5\). You can use this option to allow DHCP proxy clients and relay agents to request an IP address for a specific subnet.


If you are using a DHCP relay agent that is configured with DHCP option 82, sub\-option 5, the relay agent can request an IP address lease for DHCP clients from a specific IP address range.

For more information, see [DHCP Subnet Selection Options](dhcp-subnet-options.md).

## New Logging Events for DNS Registration Failures by the DHCP Server

DHCP now includes logging events for circumstances in which DHCP server DNS record registrations fail on the DNS server.

For more information, see [DHCP Logging Events for DNS Record Registrations](dhcp-dns-events.md).

## DHCP NAP Is Not Supported in Windows Server 2016

Network Access Protection \(NAP\) is deprecated in Windows Server 2012 R2, and in Windows Server 2016 the DHCP Server role no longer supports NAP. For more information, see [Features Removed or Deprecated in Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn303411(v=ws.11)).

NAP support was introduced to the DHCP Server role with  Windows Server 2008, and is supported in Windows client and server operating systems prior to Windows 10 and Windows Server 2016. The following table summarizes support for NAP in Windows Server.

|Operating system|NAP support|
|--------------------|---------------|
| Windows Server 2008 |Supported|
| Windows Server 2008 R2 |Supported|
| Windows Server 2012 |Supported|
| Windows Server 2012 R2 |Supported|
| Windows Server 2016|Not supported|

In a NAP deployment, a DHCP server running an operating system that supports NAP can function as a NAP enforcement point for the NAP DHCP enforcement method. For more information about DHCP in NAP, see [Checklist: Implementing a DHCP Enforcement Design](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd314186(v=ws.10)).

In Windows Server 2016, DHCP servers do not enforce NAP policies, and DHCP scopes cannot be NAP\-enabled. DHCP client computers that are also NAP clients send a statement of health \(SoH\) with the DHCP request. If the DHCP server is running Windows Server 2016, these requests are processed as if no SoH is present. The DHCP server grants a normal DHCP lease to the client.

If servers that are running Windows Server 2016 are RADIUS proxies that forward authentication requests to a Network Policy Server \(NPS\) that supports NAP, these NAP clients are evaluated by NPS as non NAP\-capable, and NAP processing fails.

## Additional References

-   [Dynamic Host Configuration Protocol (DHCP)](./dhcp-top.md)

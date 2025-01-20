---
title: DNS in Windows and Windows Server
description: Learn about how DNS works in Windows Server 
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
ms.date: 01/20/2025

---

# How DNS works

>Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016

Domain Name System (DNS) is the default name resolution service used in Windows networks. DNS is part of the TCP/IP protocol suite and all TCP/IP network connections are by default configured with the IP address of at least one DNS server in order to perform name resolution on the network. Windows Server components that require name resolution attempt to use the DNS server before attempting to use the earlier default Windows name resolution service, Windows Internet Name Service (WINS).

Typically, Windows Server DNS is deployed in support of Active Directory Domain Services (AD DS). In this environment, DNS namespaces mirror the Active Directory forests and domains used by an organization. Network hosts and services are configured with DNS names so that they can be located in the network. They are also configured with DNS servers that resolve the names of Active Directory domain controllers.

Windows Server DNS is also commonly deployed as a non-Active Directory standard Domain Name System solution. Using Windows Server DNS to host an organization's Internet presence is one example of this usage.

See the following articles in this section to learn more about how DNS works in Windows Server.

- [DNS Architecture](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197427(v=ws.10))
- [DNS Protocol](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197470(v=ws.10))
- [DNS Physical Structure](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197495(v=ws.10))
- [DNS Processes and Interactions](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197552(v=ws.10))
- [Network Ports Used by DNS](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197515(v=ws.10))
- [DNS Reference Information](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197499(v=ws.10))
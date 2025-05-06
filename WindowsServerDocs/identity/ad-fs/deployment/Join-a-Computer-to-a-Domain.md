---
title: Join a computer to a domain
description: Learn how to configure a computer that functions as a federation server to join it to a domain.
ms.assetid: 10d6723e-c857-43da-9d2d-acb5641d3da8
ms.topic: how-to
author: xelu86
ms.author: alalve
ms.date: 05/06/2025
---

# Join a computer to a domain

For Active Directory Federation Services (AD FS) to operate effectively, each computer serving as a federation server must be joined to a domain. While federation server proxies can also be joined to a domain, it's not a mandatory requirement.

You don't have to join a Web server to a domain if the Web server is hosting claims-aware applications only.

## Prerequisites

You must be a member of one of the following groups:

- Account Operators
- Domain Admins
- Enterprise Admins

> [!NOTE]
> To keep time synchronized, organizations often use the Windows Time Service or a Network Time Protocol (NTP) server. Within a domain, computers typically sync their clocks with the Domain Controller, which should be aligned with a dependable time source. This process ensures consistent time settings across all devices in the domain, minimizing potential issues with Kerberos authentication.

## Join a device to a domain

# [Client device](client)

1. Select **Start**, type **Control Panel**, and then press **ENTER**.

1. Navigate to **System and Security**, and then select **System**.

1. Under **Computer name, domain, and workgroup settings**, select **Change settings**.

1. Under the **Computer Name** tab, select **Change**.
'
1. Under **Member of**, select **Domain**, type the name of the domain that you wish this computer to join, and then select **OK**.

1. Select **OK** in the Computer Name/Domain Changes dialog box, and then restart the computer.

# [Server device](server)

1. Select **Start**, type **Control Panel**, and then press **ENTER**.

1. Navigate to **System and Security**, and then select **System**.

1. Under **Related settings**, select **Rename this PC (advanced)**.

1. Under the **Computer Name** tab, select **Change**.

1. Under **Member of**, select **Domain**, type the name of the domain that you wish this server to join, and then select **OK**.

1. Select **OK** in the Computer Name/Domain Changes dialog box, and then restart the server.

---

## See also

- [Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)
- [Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)

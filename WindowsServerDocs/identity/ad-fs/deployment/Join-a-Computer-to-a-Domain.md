---
description: Learn how to configure a computer that functions as a federation server to join it to a domain.
ms.assetid: 10d6723e-c857-43da-9d2d-acb5641d3da8
title: Join a computer to a domain
author: xelu86
manager: tedhudek
ms.date: 08/19/2024
ms.topic: how-to
ms.author: alalve
---

# Join a computer to a domain

For Active Directory Federation Services (AD FS) to function, each computer that functions as a federation server must be joined to a domain. Federation server proxies can be joined to a domain, but this is not a requirement.

You don't have to join a Web server to a domain if the Web server is hosting claims-aware applications only.

Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

## To join a computer to a domain

1. On the Desktop, click the **Start** button, type **Control Panel**, and then press ENTER.

1. Navigate to **System and Security**, and then click **System**.

1. Under **Computer name, domain, and workgroup settings**, click **Change settings**.

1. Under the **Computer Name** tab, click **Change**.

1. Under **Member of**, click **Domain**, type the name of the domain that you wish this computer to join, and then click **OK**.

1. Click **OK** in the Computer Name/Domain Changes dialog box, and then restart the computer.

## To join a server to a domain

1. On the Desktop, click the **Start** button, type **Control Panel**, and then press ENTER.

1. Navigate to **System and Security**, and then click **System**.

1. Under **Related settings**, click **Rename this PC (advanced)**.

1. Under the **Computer Name** tab, click **Change**.

1. Under **Member of**, click **Domain**, type the name of the domain that you wish this server to join, and then click **OK**.

1. Click **OK** in the Computer Name/Domain Changes dialog box, and then restart the server.

## Related content

- [Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)
- [Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)

---
title: Configure alternative SMB ports (preview)
description: How to configure alternative SMB ports on Windows Server.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 02/07/2024
---

# Configure alternative SMB ports (preview)

<!--Insert PREVIEW note here--->

You can use the SMB client to connect to alternative TCP, QUIC, and RDMA ports. However, you can only connect to alternative ports if the SMB server is configured to support listening on that port.

You can also configure your deployment to block configuring alternative ports or specify that ports can only connect to certain servers.

## Prerequisites

In order to configure alternative ports, you need the following:

- Admin permissions
- An SMB client
- An SMB server configured to listen to the port you want to use

## Map an alternative port

To map an alternative port to your SMB client:

### [PowerShell](#tab/powershell)

<!--- Content here  -->

### [Command line](#tab/command-line)

<!--- Content here  -->

---

## Control or block alternative port usage

### [PowerShell](#tab/powershell)

<!--- Content here  -->

### [Command line](#tab/command-line)

<!--- Content here  -->

---

## Related content

- [Secure SMB traffic](smb-secure-traffic.md)
- [SMB security](smb-security.md)
- [SMB over QUIC](smb-over-quic.md)
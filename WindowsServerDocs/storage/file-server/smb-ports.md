---
title: Configure alternative SMB ports (preview)
description: How to configure alternative SMB ports on Windows Server.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 02/07/2024
---

# Configure alternative SMB ports (preview)

> [!IMPORTANT]
> Configuring alternative SMB ports is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

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

1. Open an elevated PowerShell window as an administrator.

1. Run one of the following commands to map a port:

   - Run this command to map a TCP port:

     ```powershell
     New-SmbMapping -RemotePath \\server\share -TcpPort <port number between 0 and 65536>
     ```

   - Run this command to map a QUIC port:

     ```powershell
     New-SmbMapping -RemotePath \\server\share -QuicPort <port number between 0 and 65536>
     ```

   - Run this command to map an RDMA port:

     ```powershell
     New-SmbMapping -RemotePath \\server\share -RdmaPort <port number between 0 and 65536>
     ```

### [Command line](#tab/command-line)

1. Open an elevated command-line prompt as an administrator.

1. Run one of the following commands to map a port:

   - Run this command to map a TCP port:

     ```cmd
     NET USE \\server\share /TCPPORT:<port number between 0 and 65536>
     ```

   - Run this command to map a QUIC port:

     ```cmd
     NET USE \\server\share /QUICPORT:<port number between 0 and 65536>
     ```

   - Run this command to map an RDMA port:

     ```cmd
     NET USE \\server\share /RDMAPORT:<port number between 0 and 65536>
     ```

---

## Control or block alternative port usage

The SMB client doesn't support changing the TCP listening port to anything but the default 445 port.

### [PowerShell](#tab/powershell)

You can configure the SMB over the QUIC server to use an alternative port by running the following commands in PowerShell:

```powershell
Get-SmbServerAlternativePort
New-SmbServerAlternativePort
Remove-SmbServerAlternativePort
Set-SmbServerAlternativePort
```

<!---Ask Ned if there's a way to change the RDMA, etc. ports.--->

### [Command line](#tab/command-line)

<!---Ask Ned if there's a CLI method for controlling port usage.-->

---

## Related content

- [Secure SMB traffic](smb-secure-traffic.md)
- [SMB security](smb-security.md)
- [SMB over QUIC](smb-over-quic.md)
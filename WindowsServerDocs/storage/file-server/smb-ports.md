---
title: Configure alternative SMB ports for Windows Server 2025
description: How to configure alternative SMB ports on Windows Server 2025
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 10/25/2024
---

# Configure alternative SMB ports

You can use the SMB client to connect to alternative TCP, QUIC, and RDMA ports. However, you can only connect to alternative ports if the SMB server is configured to support listening on that port.

You can also configure your deployment to block configuring alternative ports or specify that ports can only connect to certain servers.

## Prerequisites

In order to configure alternative ports, you need the following:

- Your system must be running one of the following two operating systems:

  - Windows 11, version 24H2 or later

  - Windows Server 2025 or later

- Admin permissions

- An SMB server configured to listen to the port you want to use

## Map an alternative port

To map an alternative port to your SMB client:

### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window as an administrator.

1. Run one of the following commands to map a port:

   - Run this command to map a TCP port:

     ```powershell
     New-SmbMapping -LocalPath <drive letter>: -RemotePath \\server\share -TcpPort <port number between 0 and 65536>
     ```

   - Run this command to map a QUIC port:

     ```powershell
     New-SmbMapping -LocalPath <drive letter>: -RemotePath \\server\share -QuicPort <port number between 0 and 65536>
     ```

   - Run this command to map an RDMA port:

     ```powershell
     New-SmbMapping -LocalPath <drive letter>: -RemotePath \\server\share -RdmaPort <port number between 0 and 65536>
     ```

### [Command line](#tab/command-line)

1. Open an elevated command-line prompt as an administrator.

1. Run one of the following commands to map a port:

   - Run this command to map a TCP port:

     ```cmd
     NET USE <drive letter>: \\server\share /TCPPORT:<port number between 0 and 65536>
     ```

   - Run this command to map a QUIC port:

     ```cmd
     NET USE <drive letter>: \\server\share /QUICPORT:<port number between 0 and 65536>
     ```

   - Run this command to map an RDMA port:

     ```cmd
     NET USE <drive letter>: \\server\share /RDMAPORT:<port number between 0 and 65536>
     ```

---

## Control or block alternative port usage

The SMB server in Windows and Windows Server only supports changing the SMB over QUIC listening port. You can't configure TCP or RDMA listening ports.

The only method currently available to configure alternative ports is through PowerShell. You can configure the SMB over the QUIC server to use an alternative port by running the following commands:

```powershell
#Lists all available alternative ports
Get-SmbServerAlternativePort 

#Creates a new alternative port
New-SmbServerAlternativePort -TransportType QUIC -Port <port number> -EnableInstances Default

#Deletes an alternative port
Remove-SmbServerAlternativePort

#Configures SMB to use a specific port
Set-SmbServerAlternativePort
```

## Related content

- [Secure SMB traffic](smb-secure-traffic.md)
- [SMB security](smb-security.md)
- [SMB over QUIC](smb-over-quic.md)

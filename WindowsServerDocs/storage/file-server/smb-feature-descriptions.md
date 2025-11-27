---
title: SMB features in Windows and Windows Server
description: "Discover the SMB features available in different Windows versions to enhance security, performance, and availability for your file-sharing needs."
author: robinharwood
ms.author: roharwoo
ms.topic: concept-article
ms.date: 11/27/2025
ai-usage: ai-assisted

#customer intent: As a Windows Server administrator, I want to understand the SMB features available in different Windows Server versions so that I can plan upgrades and configure file sharing with the appropriate security, performance, and availability capabilities.

---

# SMB features in Windows and Windows Server

Server Message Block (SMB) is the file sharing protocol that Windows uses to share files, printers, and other resources across a network. SMB evolves significantly with each version, adding new capabilities for security, performance, and reliability.

SMB features include:

- **Security and authentication** capabilities like SMB signing and encryption required by default, NTLM blocking, and authentication rate limiting to protect against attacks.
- **Networking and connectivity** options including SMB over QUIC for secure access without VPN, alternative ports, and RDMA support for high-performance workloads.
- **Performance** enhancements such as SMB compression, bandwidth limits, and improved directory caching.
- **High availability and scale** features like transparent failover, scale-out file servers, and rolling cluster upgrades.
- **Management and monitoring** tools including PowerShell cmdlets, performance counters, and dialect control.

For more information about specific SMB capabilities, see [SMB security enhancements](smb-security.md), [SMB over QUIC](smb-over-quic.md), and [SMB compression](smb-compression.md).

## SMB feature availability

The following tables show the SMB features available across different versions, grouped by feature category.

#### [Windows Server](#tab/windows-server)

| Feature | Windows Server 2025 | Windows Server 2022 | Windows Server 2019 | Windows Server 2016 | Windows Server 2012 R2 | Windows Server 2012 |
|---------|---------------------|---------------------|---------------------|---------------------|------------------------|---------------------|
| **Security & Authentication** |  |  |  |  |  |  |
| [SMB signing required by default](#smb-signing-required-by-default) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [SMB encryption](#smb-encryption) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [SMB NTLM blocking](#smb-ntlm-blocking) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [SMB authentication rate limiter](#smb-authentication-rate-limiter) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [SMB signing and encryption auditing](#smb-signing-and-encryption-auditing) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [SMB East-west encryption](#smb-east-west-encryption) | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| [AES-128-GMAC signing acceleration](#aes-128-gmac-signing-acceleration) | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| [Pre-Authentication Integrity](#pre-authentication-integrity) | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| [Guest access disabled](#guest-access-disabled) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| [Secure dialect negotiation](#secure-dialect-negotiation) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Networking & Connectivity** |  |  |  |  |  |  |
| [SMB over QUIC](#smb-over-quic) | ✅ | ✅<sup>1</sup> | ❌ | ❌ | ❌ | ❌ |
| [SMB over QUIC client access control](#smb-over-quic-client-access-control) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [SMB alternative ports](#smb-alternative-ports) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [SMB firewall rule hardening](#smb-firewall-rule-hardening) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [SMB Direct and RDMA encryption](#smb-direct-and-rdma-encryption) | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| [SMB Direct (RDMA)](#smb-direct-rdma) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [SMB Multichannel](#smb-multichannel) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Performance** |  |  |  |  |  |  |
| [SMB compression](#smb-compression) | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| [SMB bandwidth limits](#smb-bandwidth-limits) | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| [Directory Caching (enhanced)](#directory-caching-enhanced) | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| [Performance over WAN](#performance-over-wan) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [Write-through to disk](#write-through-to-disk) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| **High Availability & Scale** |  |  |  |  |  |  |
| [Rolling cluster upgrade support](#rolling-cluster-upgrade-support) | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| [Scale-Out File Server auto-rebalancing](#scale-out-file-server-auto-rebalancing) | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| [SMB Transparent Failover](#smb-transparent-failover) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [SMB Scale Out](#smb-scale-out) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Management & Monitoring** |  |  |  |  |  |  |
| [SMB dialect control](#smb-dialect-control) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB global mapping](#smb-global-mapping) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB-specific PowerShell cmdlets](#smb-specific-powershell-cmdlets) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [Performance Counters](#performance-counters) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Core Protocol Features** |  |  |  |  |  |  |
| [File Normalized Name Information API](#file-normalized-name-information-api) | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| [SMB Directory Leasing](#smb-directory-leasing) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

<sup>1</sup> Windows Server 2022 Datacenter: Azure Edition only.

#### [Windows client](#tab/windows-client)

| Feature | Windows 11 24H2 | Windows 11 | Windows 10 | Windows 8.1 | Windows 8 |
|---------|-----------------|------------|------------|-------------|-----------|
| **Security & Authentication** |  |  |  |  |  |
| [SMB signing required by default](#smb-signing-required-by-default) | ✅ | ❌ | ❌ | ❌ | ❌ |
| [SMB encryption](#smb-encryption) | ✅ | ✅ | ✅ | ✅ | ✅ |
| [SMB NTLM blocking](#smb-ntlm-blocking) | ✅ | ❌ | ❌ | ❌ | ❌ |
| [SMB authentication rate limiter](#smb-authentication-rate-limiter) | ✅ | ❌ | ❌ | ❌ | ❌ |
| [SMB signing and encryption auditing](#smb-signing-and-encryption-auditing) | ✅ | ❌ | ❌ | ❌ | ❌ |
| [AES-128-GMAC signing acceleration](#aes-128-gmac-signing-acceleration) | ✅ | ✅ | ❌ | ❌ | ❌ |
| [Pre-Authentication Integrity](#pre-authentication-integrity) | ✅ | ✅ | ✅<sup>1</sup> | ❌ | ❌ |
| [Guest access disabled](#guest-access-disabled) | ✅ | ✅ | ✅<sup>2</sup> | ❌ | ❌ |
| [Secure dialect negotiation](#secure-dialect-negotiation) | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Networking & Connectivity** |  |  |  |  |  |
| [SMB over QUIC](#smb-over-quic) | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB over QUIC client access control](#smb-over-quic-client-access-control) | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB alternative ports](#smb-alternative-ports) | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB firewall rule hardening](#smb-firewall-rule-hardening) | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB Direct and RDMA encryption](#smb-direct-and-rdma-encryption) | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB Direct (RDMA)](#smb-direct-rdma) | ✅ | ✅ | ✅<sup>3</sup> | ❌ | ❌ |
| [SMB Multichannel](#smb-multichannel) | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Performance** |  |  |  |  |  |
| [SMB compression](#smb-compression) | ✅ | ✅ | ❌ | ❌ | ❌ |
| [SMB bandwidth limits](#smb-bandwidth-limits) | ✅ | ✅ | ✅ | ✅ | ❌ |
| [Directory Caching (enhanced)](#directory-caching-enhanced) | ✅ | ✅ | ✅<sup>1</sup> | ❌ | ❌ |
| [Performance over WAN](#performance-over-wan) | ✅ | ✅ | ✅ | ✅ | ✅ |
| [Write-through to disk](#write-through-to-disk) | ✅ | ✅ | ✅<sup>4</sup> | ❌ | ❌ |
| **Management & Monitoring** |  |  |  |  |  |
| [SMB dialect control](#smb-dialect-control) | ✅ | ✅ | ✅<sup>2</sup> | ❌ | ❌ |
| [SMB global mapping](#smb-global-mapping) | ✅ | ✅ | ✅<sup>2</sup> | ❌ | ❌ |
| [SMB-specific PowerShell cmdlets](#smb-specific-powershell-cmdlets) | ✅ | ✅ | ✅ | ✅ | ✅ |
| [Performance Counters](#performance-counters) | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Core Protocol Features** |  |  |  |  |  |
| [File Normalized Name Information API](#file-normalized-name-information-api) | ✅ | ✅ | ✅<sup>1</sup> | ❌ | ❌ |
| [SMB directory leasing](#smb-directory-leasing) | ✅ | ✅ | ✅ | ✅ | ✅ |

<sup>1</sup> Windows 10 version 1607 and later.
<br><sup>2</sup> Windows 10 version 1709 and later.
<br><sup>3</sup> Windows 10 Enterprise, Education, and Pro for Workstations editions only.
<br><sup>4</sup> Windows 10 version 1809 and later.

#### [SMB dialect version](#tab/smb-dialect)

SMB features are introduced in specific dialect versions, but feature availability can vary depending on the operating system version. Both the client and server must support the required dialect version for a feature to be available.

| Feature | SMB 3.1.1 | SMB 3.02 | SMB 3.0 |
|---------|-----------|----------|---------|
| **Security & Authentication** |  |  |  |
| [SMB signing required by default](#smb-signing-required-by-default) | ✅ | ❌ | ❌ |
| [SMB encryption](#smb-encryption) | ✅ | ✅ | ✅ |
| [SMB NTLM blocking](#smb-ntlm-blocking) | ✅ | ❌ | ❌ |
| [SMB authentication rate limiter](#smb-authentication-rate-limiter) | ✅ | ❌ | ❌ |
| [SMB signing and encryption auditing](#smb-signing-and-encryption-auditing) | ✅ | ❌ | ❌ |
| [SMB East-west encryption](#smb-east-west-encryption) | ✅ | ❌ | ❌ |
| [AES-128-GMAC signing acceleration](#aes-128-gmac-signing-acceleration) | ✅ | ❌ | ❌ |
| [Pre-Authentication Integrity](#pre-authentication-integrity) | ✅ | ❌ | ❌ |
| [Guest access disabled](#guest-access-disabled) | ✅ | ❌ | ❌ |
| [Secure dialect negotiation](#secure-dialect-negotiation) | ✅ | ✅ | ✅ |
| **Networking & Connectivity** |  |  |  |
| [SMB over QUIC](#smb-over-quic) | ✅ | ❌ | ❌ |
| [SMB over QUIC client access control](#smb-over-quic-client-access-control) | ✅ | ❌ | ❌ |
| [SMB alternative ports](#smb-alternative-ports) | ✅ | ❌ | ❌ |
| [SMB firewall rule hardening](#smb-firewall-rule-hardening) | ✅ | ❌ | ❌ |
| [SMB Direct and RDMA encryption](#smb-direct-and-rdma-encryption) | ✅ | ❌ | ❌ |
| [SMB Direct (RDMA)](#smb-direct-rdma) | ✅ | ✅ | ✅ |
| [SMB Multichannel](#smb-multichannel) | ✅ | ✅ | ✅ |
| **Performance** |  |  |  |
| [SMB compression](#smb-compression) | ✅ | ❌ | ❌ |
| [SMB bandwidth limits](#smb-bandwidth-limits) | ✅ | ✅ | ❌ |
| [Directory Caching (enhanced)](#directory-caching-enhanced) | ✅ | ❌ | ❌ |
| [Performance over WAN](#performance-over-wan) | ✅ | ✅ | ✅ |
| [Write-through to disk](#write-through-to-disk) | ✅ | ❌ | ❌ |
| **High Availability & Scale** |  |  |  |
| [Rolling cluster upgrade support](#rolling-cluster-upgrade-support) | ✅ | ❌ | ❌ |
| [Scale-Out File Server auto-rebalancing](#scale-out-file-server-auto-rebalancing) | ✅ | ✅ | ❌ |
| [SMB Transparent Failover](#smb-transparent-failover) | ✅ | ✅ | ✅ |
| [SMB Scale Out](#smb-scale-out) | ✅ | ✅ | ✅ |
| **Management & Monitoring** |  |  |  |
| [SMB dialect control](#smb-dialect-control) | ✅ | ❌ | ❌ |
| [SMB global mapping](#smb-global-mapping) | ✅ | ❌ | ❌ |
| [SMB-specific PowerShell cmdlets](#smb-specific-powershell-cmdlets) | ✅ | ✅ | ✅ |
| [Performance Counters](#performance-counters) | ✅ | ✅ | ✅ |
| **Core Protocol Features** |  |  |  |
| [File Normalized Name Information API](#file-normalized-name-information-api) | ✅ | ❌ | ❌ |
| [SMB directory leasing](#smb-directory-leasing) | ✅ | ✅ | ✅ |

---

## Features

### Security and authentication

#### SMB signing required by default

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later
- 💻 Client: Windows 11 24H2 and later

**Description**:

SMB signing is now required by default for all SMB outbound connections. Previously, the system required SMB signing only when you connected to shares named `SYSVOL` and `NETLOGON` on Active Directory domain controllers. This enhancement ensures that the system signs all SMB traffic by default, providing protection against man-in-the-middle attacks and ensuring data integrity across all SMB connections.

#### SMB encryption

**SMB dialect version**: 3.0 and later

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

SMB encryption provides end-to-end encryption of SMB data and protects data from eavesdropping on untrusted networks. It requires no new deployment costs, and no need for Internet Protocol security (IPsec), specialized hardware, or WAN accelerators. You can configure encryption on a per share basis, or for the entire file server, and you can enable it for various scenarios where data traverses untrusted networks.

**Encryption algorithms by version:**

| Algorithm | SMB Dialect | Server Version | Client Version | Notes |
|-----------|-------------|----------------|----------------|-------|
| AES-128-CCM | 3.0 | Windows Server 2012 and later | Windows 8 and later | Original SMB 3.0 encryption algorithm, default for SMB 3.0 |
| AES-128-GCM | 3.1.1 | Windows Server 2016 and later | Windows 10 version 1607 and later | Default for SMB 3.1.1, faster than AES-CCM |
| AES-256-CCM | 3.1.1 | Windows Server 2022 and later | Windows 11 and later | Higher security encryption option |
| AES-256-GCM | 3.1.1 | Windows Server 2022 and later | Windows 11 and later | Higher security with better performance |

Windows automatically negotiates the most advanced cipher method when connecting to another computer that also supports it, and you can mandate it through Group Policy. AES-128-GCM is the default for SMB 3.1.1 connections, while older versions use AES-128-CCM. Windows Server still supports AES-128 for down-level compatibility.

**Default encryption behavior:**

| Feature | Version | Description |
|---------|---------|-------------|
| Optional encryption | Windows Server 2022 and earlier  / Windows 11 23H2 and earlier | You can enable encryption per share or per server, but it's not required by default |
| Encryption required by default | Windows Server 2025 / Windows 11 24H2 | SMB encryption is now required by default for all outbound SMB client connections. Administrators can mandate that all destination servers support SMB 3.x and encryption. If a server lacks these capabilities, the client can't establish a connection |

#### SMB NTLM blocking

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later
- 💻 Client: Windows 11 24H2 and later

**Description**:

The SMB client supports NTLM blocking for remote outbound connections. Windows Simple and Protected GSSAPI Negotiation Mechanism (SPNEGO) negotiates Kerberos, NTLM, and other mechanisms with the destination server to determine a supported security package. With NTLM blocking enabled, administrators can prevent the use of NTLM authentication for SMB connections, enforcing more secure authentication methods like Kerberos.

#### SMB authentication rate limiter

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later
- 💻 Client: Windows 11 24H2 and later

**Description**:

The SMB authentication rate limiter limits the number of authentication attempts within a certain time period, helping protect against brute-force authentication attacks. The service for the SMB server uses the authentication rate limiter to implement a delay between each failed NTLM- or PKU2U-based authentication attempt. The service is enabled by default, providing an extra layer of security against credential-based attacks.

#### SMB signing and encryption auditing

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later
- 💻 Client: Windows 11 24H2 and later

**Description**:

Administrators can enable auditing of the SMB server and client for support of SMB signing and encryption. If a non-Microsoft client or server lacks support for SMB encryption or signing, you can detect it. When a non-Microsoft device or software states it supports SMB 3.1.1 but doesn't support SMB signing, it violates the SMB 3.1.1 Preauthentication integrity protocol requirement. You can configure auditing through Group Policy or PowerShell.

#### SMB East-west encryption

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2022 and later
- 💻 Client: Not applicable (server-to-server feature)

**Description**:

Windows Server failover clusters now support granular control of encrypting and signing intra-node storage communications for Cluster Shared Volumes (CSV) and the storage bus layer (SBL). When using Storage Spaces Direct, you can now decide to encrypt or sign east-west communications within the cluster itself for higher security.

#### AES-128-GMAC signing acceleration

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2022 and later
- 💻 Client: Windows 11 and later

**Description**:

AES-128-GMAC signing now accelerates signing performance. This cryptographic improvement provides faster signing operations compared to previous methods while maintaining strong security guarantees. The acceleration is especially noticeable in high-throughput scenarios.

#### Pre-Authentication Integrity

**SMB dialect version**: 3.1.1
**Availability**:

- 🖥️ Server: Windows Server 2016 and later
- 💻 Client: Windows 10 version 1607 and later

**Description**:

Preauthentication integrity provides improved protection from a man-in-the-middle attacker tampering with SMB's connection establishment and authentication messages. This feature makes sure that the system can't change the initial handshake between client and server. It prevents downgrade attacks and protects the sign-in process. For more information, see [SMB 3.1.1 Preauthentication integrity](/archive/blogs/openspecification/smb-3-1-1-pre-authentication-integrity-in-windows-10).

#### Guest access disabled

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2019 and later
- 💻 Client: Windows 10 version 1709 and later

**Description**:

The SMB client no longer allows guest account access to a remote server or fallback to the guest account after invalid credentials. This security enhancement prevents potential unauthorized access through guest accounts. For more information, see [Guest access in SMB2 disabled by default](https://support.microsoft.com/help/4046019/guest-access-in-smb2-disabled-by-default-in-windows-10-and-windows-ser).

#### Secure dialect negotiation

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

Helps protect against man-in-the-middle attempt to downgrade dialect negotiation. The idea is to prevent an eavesdropper from downgrading the initially negotiated dialect and capabilities between the client and the server. For details, see [SMB3 Secure Dialect Negotiation](/archive/blogs/openspecification/smb3-secure-dialect-negotiation). This feature was replaced by Preauthentication Integrity in SMB 3.1.1, which provides enhanced protection.

### Networking and connectivity

#### SMB over QUIC

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 (all editions), Windows Server 2022 Datacenter: Azure Edition
- 💻 Client: Windows 11 and later

**Description**:

SMB over QUIC updates the SMB 3.1.1 protocol to use the QUIC protocol instead of TCP. By using SMB over QUIC along with TLS 1.3, users and applications can securely and reliably access data from edge file servers running in Azure. Mobile and telecommuter users no longer need a VPN to access their file servers over SMB when on Windows. QUIC provides low-latency, encrypted connections over the internet. For more information, see [SMB over QUIC](smb-over-quic.md).

#### SMB over QUIC client access control

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later
- 💻 Client: Windows 11 and later

**Description**:

Client access control for SMB over QUIC introduces more controls to restrict access to your data by using certificates. SMB over QUIC is an alternative to TCP and RDMA that supplies secure connectivity to edge file servers over untrusted networks. To learn more, see [Configure SMB over QUIC client access control](configure-smb-over-quic-client-access-control.md).

#### SMB alternative ports

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later
- 💻 Client: Windows 11 and later

**Description**:

You can use the SMB client to connect to alternative TCP, QUIC, and RDMA ports instead of their IANA/IETF defaults of 445, 443, and 5445. Previously, the SMB server in Windows mandated inbound connections to use the IANA-registered port TCP/445 while the SMB TCP client allowed only outbound connections to that same TCP port. To learn more, see [Configure alternative SMB ports](smb-ports.md).

#### SMB firewall rule hardening

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later
- 💻 Client: Windows 11 and later

**Description**:

Previously, when you created a share, the SMB firewall rules automatically enabled the **File and Printer Sharing** group for the relevant firewall profiles. Now, when you create an SMB share in Windows, the process automatically configures the new **File and Printer Sharing (Restrictive)** group, which no longer permits inbound NetBIOS ports 137-139. To learn more, see [SMB secure traffic](smb-secure-traffic.md).

#### SMB Direct and RDMA encryption

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2022 and later
- 💻 Client: Windows 11 and later

**Description**:

SMB Direct and RDMA supply a high bandwidth, low latency networking fabric for workloads like Storage Spaces Direct, Storage Replica, Hyper-V, and SQL Server. SMB Direct in Windows Server supports encryption. Previously, enabling SMB encryption disabled direct data placement, which seriously impacted performance. Now data is encrypted before data placement, leading to far less performance degradation while adding AES-128 and AES-256 protected packet privacy.

#### SMB Direct client

**SMB dialect version**: 3.1.1
**Availability**:

- 🖥️ Server: Windows Server 2016 and later
- 💻 Client: Windows 10 version 1607 and later (Enterprise, Education, and Pro for Workstations editions)
**Description**:

Windows 10 Enterprise, Windows 10 Education, and Windows 10 Pro for Workstations now include SMB Direct client support in addition to Windows Server. This support allows client operating systems to take advantage of RDMA-capable network adapters for high-performance file access.

#### SMB Direct (RDMA)

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

Supports the use of network adapters that have RDMA capability and can function at full speed with low latency, while using little CPU. For workloads such as Hyper-V or Microsoft SQL Server, SMB Direct enables a remote file server to resemble local storage.

SMB Direct in SMB 3 contributes to a substantial increase in performance compared to previous versions of SMB. Windows Server 2012 R2 enhances SMB Direct to improve performance for small I/O workloads, evident with higher speed network interfaces (40Gbps Ethernet and 56Gbps InfiniBand).

SMB Direct has the following requirements:

- At least two computers running Windows Server 2012 or later. No extra features need to be installed - the technology is on by default.
- Network adapters with RDMA capability. Currently, these adapters are available in three different types: iWARP, Infiniband, or RoCE (RDMA over Converged Ethernet).

#### SMB Multichannel

**SMB dialect version**: 3.0
**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

Enables aggregation of network bandwidth and network fault tolerance if multiple paths are available between the SMB client and server. This feature enables server applications to take full advantage of all available network bandwidth and be resilient to a network failure. SMB Multichannel in SMB 3 contributes to a substantial increase in performance compared to previous versions of SMB.

**Requirements**

SMB Multichannel has the following requirements:

- At least two computers running Windows Server 2012 or later. No extra features need to be installed - the technology is on by default.
- For information on recommended network configurations, see the See Also section at the end of this overview article.

### Performance

#### SMB compression

**SMB dialect version**: 3.1.1
**Availability**:

- 🖥️ Server: Windows Server 2022 and later
- 💻 Client: Windows 11 and later

**Description**:

SMB compression enables users and applications to compress files during network transfer, which reduces network bandwidth usage and speeds up transfers on slower or congested networks. You no longer need to manually zip files before transferring them. For more information, see [SMB compression](smb-compression.md).

**Compression algorithms by version:**

| Algorithm | Description | Server Version | Client Version |
|-----------|-------------|----------------|----------------|
| XPRESS (LZ77) | Lempel-Ziv 1977 algorithm, balanced compression ratio, and speed | Windows Server 2022 and later | Windows 11 and later |
| XPRESS Huffman (LZ77+Huffman) | LZ77 combined with Huffman encoding for improved compression | Windows Server 2022 and later | Windows 11 and later |
| LZNT1 | Lempel-Ziv variant optimized for NTFS compression | Windows Server 2022 and later | Windows 11 and later |
| PATTERN_V1 | Pattern-based compression for repetitive data | Windows Server 2022 and later | Windows 11 and later |
| LZ4 | Industry-standard algorithm with high-speed compression and decompression | Windows Server 2025 and later | Windows 11 24H2 and later |

Windows automatically negotiates the best available compression algorithm when both client and server support SMB compression. The LZ4 algorithm, introduced in Windows Server 2025 and Windows 11 24H2, provides improved compression performance for modern workloads.

**Default compression behavior by version:**

| Behavior | Initial Release | Updated Behavior |
|----------|-----------------|------------------|
| Compression sampling | Windows Server 2022 RTM, Windows 11 RTM | Disabled by default starting with KB5016693 (Server) and KB5016691 (Client) |
| Always attempt compression | Not default | Default starting with KB5016693 (Server) and KB5016691 (Client) |

In the original release of Windows Server 2022 and Windows 11, SMB compression used a sampling algorithm that tried to compress the first 500 MiB of a file and only continued if at least 100 MiB compressed successfully. Starting with KB5016693 and KB5016691, sampling is disabled by default and SMB always attempts to compress the entire file when requested.

To learn more about understanding and configuring compression, see [SMB compression](smb-compression.md).

#### SMB bandwidth limits

**SMB dialect version**: 3.02

**Availability**:

- 🖥️ Server: Windows Server 2012 R2 and later
- 💻 Client: Windows 8.1 and later

**Description**:

Use [Set-SmbBandwidthLimit](/powershell/module/smbshare/set-smbbandwidthlimit) to set bandwidth limits in three categories:

- Virtual Machine (Hyper-V over SMB traffic)
- Live Migration (Hyper-V Live Migration traffic over SMB)
- Default (all other types of SMB traffic)

This feature allows administrators to control network bandwidth usage for different types of SMB workloads.

#### Directory Caching (enhanced)

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2016 and later
- 💻 Client: Windows 10 version 1607 and later

**Description**:

SMB 3.1.1 includes enhancements to directory caching. Windows clients can now cache larger directories, approximately 500,000 entries. Windows clients attempt directory queries with 1 MB buffers to reduce round trips and improve performance. This enhancement is beneficial for applications that need to frequently enumerate large directories.

#### Performance over WAN

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

SMB 3.0 introduced directory opportunistic locks (oplocks) and oplock leases. For typical office and client workloads, oplocks and leases reduce network round trips by approximately 15%.

In SMB 3, the Windows implementation of SMB was refined to improve the caching behavior on the client and the ability to push higher throughputs.

SMB 3 features improvements to the CopyFile() API and to associated tools such as Robocopy, to push more data over the network. SMB 3.02 enhances `CopyFile SRV_COPYCHUNK` support when using File Explorer for remote copies (copying only 1/2 KiB per 16 MiB of file data over the network).

#### Write-through to disk

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2019 and later
- 💻 Client: Windows 10 version 1809 and later

**Description**:

This feature provides added assurance that writes to a file share make it through the software and hardware stack to the physical disk before the write operation returns as completed. Enable this feature by using `NET USE /WRITETHROUGH` or `New-SMBMapping -UseWriteThrough`. See [Controlling write-through behaviors in SMB](https://techcommunity.microsoft.com/t5/storage-at-microsoft/controlling-write-through-behaviors-in-smb/bc-p/1083417#M677).

### High availability and scale

#### Rolling cluster upgrade support

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2016 and later
- 💻 Client: Not applicable (server-side feature)

**Description**:

Enables [rolling cluster upgrades](../../failover-clustering/cluster-operating-system-rolling-upgrade.md) by letting SMB appear to support different max versions of SMB for clusters in the process of being upgraded. This feature allows administrators to upgrade cluster nodes one at a time without taking the entire cluster offline. For more information, see [Controlling SMB Dialects](https://techcommunity.microsoft.com/t5/storage-at-microsoft/controlling-smb-dialects/ba-p/860024).

#### Scale-Out File Server auto-rebalancing

**SMB dialect version**: 3.02

**Availability**:

- 🖥️ Server: Windows Server 2012 R2 and later
- 💻 Client: Windows 8.1 and later

**Description**:

Improves scalability and manageability for Scale-Out File Servers. SMB client connections are tracked per file share rather than per server. Clients are then redirected to the cluster node with the best access to the volume that the file share uses. This feature improves efficiency by reducing redirection traffic between file server nodes. Clients are redirected following an initial connection and when cluster storage is reconfigured.

#### SMB Transparent Failover

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

Enables administrators to perform hardware or software maintenance of nodes in a clustered file server without interrupting server applications storing data on these file shares. Also, if a hardware or software failure occurs on a cluster node, SMB clients transparently reconnect to another cluster node without interrupting server applications that are storing data on these file shares.

SMB Transparent Failover has the following requirements:

- A failover cluster running Windows Server 2012 or later with at least two configured nodes. The cluster must pass the cluster validation tests included in the validation wizard.
- File shares must be created with the Continuous Availability (CA) property, which is the default.
- File shares must be created on CSV volume paths to attain SMB Scale-Out.
- Client computers must be running Windows 8 or later, or Windows Server 2012 or later. These releases include the updated SMB client that supports continuous availability.

> [!NOTE]
> Down-level clients can connect to file shares that have the CA property, but transparent failover isn't supported for these clients.

#### SMB Scale Out

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

Support for multiple SMB instances on a Scale-Out File Server. Using Cluster Shared Volumes (CSV) version 2, administrators can create file shares that provide simultaneous access to data files, with direct I/O, through all nodes in a file server cluster. SMB Scale Out provides better utilization of network bandwidth and load balancing of the file server clients, and optimizes performance for server applications.

### Management and monitoring

#### SMB dialect control

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2025 and later (for SMB server dialect control), Windows Server 2019 and later (for SMB client dialect control)
- 💻 Client: Windows 11 24H2 and later (for SMB server dialect control), Windows 10 version 1709 and later (for SMB client dialect control)

**Description**:

Control minimum and maximum SMB dialect versions for both client (outbound) and server (inbound) connections. Starting with Windows Server 2019 and Windows 10 version 1709, you can control the SMB client dialect using registry values. Windows Server 2025 and Windows 11 24H2 added the ability to control SMB server dialects and introduced PowerShell cmdlets and Group Policy settings to configure both SMB client and server dialects, replacing the need for registry modifications. See [Controlling SMB Dialects](https://techcommunity.microsoft.com/t5/storage-at-microsoft/controlling-smb-dialects/ba-p/860024) and [Manage SMB dialects in Windows](manage-smb-dialects.md).

#### SMB global mapping

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2019 and later
- 💻 Client: Windows 10 version 1709 and later

**Description**:

Maps a remote SMB share to a drive letter accessible to all users on the local host, including containers. SMB global mapping is required to enable container I/O on the data volume to traverse the remote mount point. When you use SMB global mapping for containers, all users on the container host can access the remote share. Any application running on the container host also has access to the mapped remote share. See [Container Storage Support with CSV, Storage Spaces Direct, SMB Global Mapping](https://techcommunity.microsoft.com/t5/failover-clustering/container-storage-support-with-cluster-shared-volumes-csv/ba-p/372140).

#### SMB-specific PowerShell cmdlets

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

With Windows PowerShell cmdlets for SMB, an administrator can manage file shares on the file server, end to end, from the command line. This feature provides a comprehensive set of tools for managing SMB shares, connections, sessions, and configuration settings.

#### Performance counters

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

The new SMB performance counters provide detailed, per-share information about throughput, latency, and I/O per second (IOPS), allowing administrators to analyze the performance of SMB file shares where their data is stored. These counters are designed for server applications, such as Hyper-V and SQL Server, which store files on remote file shares.

### Core protocol features

#### File Normalized Name Information API

**SMB dialect version**: 3.1.1

**Availability**:

- 🖥️ Server: Windows Server 2016 and later
- 💻 Client: Windows 10 version 1607 and later

**Description**:

Adds native support for querying the normalized name of a file. For details, see [FileNormalizedNameInformation](/openspecs/windows_protocols/ms-fscc/20bcadba-808c-4880-b757-4af93e41edf6).

#### SMB directory leasing

**SMB dialect version**: 3.0

**Availability**:

- 🖥️ Server: Windows Server 2012 and later
- 💻 Client: Windows 8 and later

**Description**:

Improves application response times in branch offices. With the use of directory leases, roundtrips from client to server are reduced since metadata is retrieved from a longer living directory cache. Cache coherency is maintained because clients are notified when directory information on the server changes. Directory leases work with scenarios for HomeFolder (read/write with no sharing) and Publication (read-only with sharing).

---
title: SMB security hardening in Windows Server and Windows Client
description: Learn about SMB security enhancements that help harden your Windows Server 2025 environment and Windows 11 client devices.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 10/25/2024
---

# SMB security hardening

The latest SMB (Server Message Block) features introduced in Windows 11 24H2 and Windows Server 2025 are designed to enhance the security of your data, users, and organization. Most of these features are automatically enabled by default. These SMB features aim to provide a safer and more secure computing environment by reducing the risk of cyber attacks and data breaches in your environment.

Users can download the following versions to preview the security features before our major Operating System (OS) release:

- Windows 11, version 24H2 or later

- Windows Server 2025 or later

## SMB security features

Understanding SMB security features can help users safeguard their sensitive data and prevent unauthorized access to shared resources. The next section provides a brief overview of these features.

### SMB signing

Starting with Windows 11 24H2 and Windows Server 2025, all outbound and inbound SMB connections are now required to be signed by default. Previously, SMB signing was only required by default for connections to shares named **SYSVOL** and **NETLOGON**, and for clients of AD domain controllers.

SMB signing prevents data tampering and relay attacks that steal credentials. By making signing mandatory by default, administrators and users don't need to be experts in SMB network protocol security to enable this important security feature. Enabling SMB signing causes clients and servers to only accept packets that are signed, and reject any that aren't. Packets from guest users are rejected, which means that the feature allowing users to connect to a server without providing credentials (guest fallback) is disabled. This security measure helps prevent unauthorized access and data breaches by requiring users to authenticate themselves before accessing a server, which ensures that only authorized users can access the server and its resources.

To learn more, see [Control SMB signing behavior](smb-signing.md).

### SMB alternative ports

The SMB client can be used to establish connections with alternative ports for TCP, QUIC, and RDMA. These ports may differ from the default ports assigned by the Internet Assigned Numbers Authority (IANA) and the Internet Engineering Task Force (IETF), which are 445, 443, and 5445 for TCP, QUIC, and RDMA respectively.

In Windows Server, it's possible to host an SMB over QUIC connection on a firewall port that is permitted, but not necessarily the default port 443. However, it's important to note that connecting to alternative ports is only possible if the SMB server is configured to listen on that specific port. Additionally, it's possible to configure the deployment to disallow the use of alternative ports or to restrict their usage to certain servers.

To learn more, see [Configure alternative SMB ports](smb-ports.md).

### SMB auditing improvements

SMB now has the ability to audit the use of SMB over QUIC, and supports third-party encryption and signing. These features can be utilized at both the SMB server and client level. If you're using Windows or Windows Server devices, it's now simpler to determine whether they're using SMB over QUIC. You can also more easily verify whether third-party software supports signing and encryption before making them mandatory.

To learn more, see:

- [SMB over QUIC client auditing](smb-over-quic.md#smb-over-quic-client-auditing)

- [SMB signing and encryption auditing](smb-signing-overview.md#smb-signing-and-encryption-auditing)

### SMB authentication rate limiter

The SMB server service now limits the number of failed authentication attempts. This is applicable to SMB file sharing on both Windows Server and Windows Client. Brute force attacks attempt to guess usernames and passwords, and can bombard the SMB server with dozens to thousands of attempts per second. The SMB authentication rate limiter is now enabled by default, with a 2-second delay between each failed NTLM or Local KDC Kerberos-based authentication attempt. As a result, an attack that sends 300 guesses per second for 5 minutes (90,000 attempts) would now take 50 hours to complete. This makes it much less likely that an attacker persists with this method.

To learn more, see:

- [Configure SMB authentication rate limiter for Windows](configure-smb-authentication-rate-limiter.md)

- [SMB authentication rate limiter demo video](https://www.youtube.com/watch?v=BPC3plpGt40&t=8m17s)

### SMB client encryption mandate now supported

The SMB client can now mandate encryption for all outbound SMB connections. This measure ensures the highest level of network security and brings SMB signing to the same level of management. Once enabled, the SMB client only connects to an SMB server that supports SMB 3.0 or later and SMB encryption. It's possible for a third-party SMB server to support SMB 3.0 but not SMB encryption. Unlike SMB signing, encryption isn't mandatory by default.

To learn more, see [Configure the SMB client to require encryption in Windows](configure-smb-client-require-encryption.md).

### SMB dialect management

It's now possible to enforce the use of SMB 2 and 3 protocol versions. Previously, the SMB server and client only supported automatic negotiation of the highest matched dialect from SMB 2.0.2 to 3.1.1. With this new feature, you can intentionally prevent older protocol versions or devices from connecting. For instance, you can specify that connections only use SMB 3.1.1, the most secure dialect of the protocol. The minimum and maximum can be set independently on both the SMB client and server, and you can choose to set only a minimum if desired.

To learn more, see:

- [Manage SMB dialects in Windows and Windows Server 2025](manage-smb-dialects.md)

- [SMB dialect control demo video](https://www.youtube.com/watch?v=BPC3plpGt40&t=32m14s)

### SMB Firewall default port changes

The SMB NetBIOS ports are no longer included in the built-in firewall rules. These ports were only required for SMB1 usage, which is now deprecated and removed by default. This modification aligns SMB firewall rules with the standard behavior of the *Windows Server File Server* role. Administrators are able to reconfigure the rules to restore the legacy ports.

To learn more, see [Updated firewall rules](smb-secure-traffic.md#updated-firewall-rules).

### SMB insecure guest authentication

By default, Windows 11 Pro no longer permits SMB client guest connections or guest fallback to an SMB server. This brings Windows 11 Pro in line with the behavior of Windows 10 and Windows 11 Enterprise, Education, and Pro for Workstation editions. Guest logons don't require passwords and don't support standard security features like signing and encryption.

Permitting a client to use guest logons puts the user at risk of adversary-in-the-middle attack scenarios or malicious server scenarios. For instance, a phishing attack that deceives a user into opening a file on a remote share or a spoofed server that convinces a client that it's legitimate. The attacker doesn't need to know the user's credentials, and a weak password is disregarded. Only third-party remote devices may require guest access by default.

To learn more, see [How to enable insecure guest logons in SMB2 and SMB3](enable-insecure-guest-logons-smb2-and-smb3.md).

### SMB NTLM blocking

The SMB client can now prevent NTLM authentication for remote outbound connections. This modifies the previous behavior of always using negotiated authentication that could downgrade from Kerberos to NTLM. By blocking NTLM authentication, this safeguards client devices against sending NTLM requests to malicious servers, thus mitigating brute force, cracking, relay, and pass-the-hash attacks.

NTLM blocking is necessary for enforcing an organization's authentication to Kerberos, which is more secure because it verifies identities with its ticket system and superior cryptography. Administrators can specify exceptions to permit NTLM authentication over SMB to specific servers.

To learn more, see:

- [Block NTLM connections on SMB](smb-ntlm-blocking.md)

- [SMB NTLM blocking demo video](https://www.youtube.com/watch?v=BPC3plpGt40&t=27m23s)

### SMB over QUIC client access control

SMB over QUIC client access control enables you to limit which clients can access SMB over QUIC servers. The previous behavior allowed connection attempts from any client that trusted the QUIC server's certificate issuance chain. With client access control, an *allowlist* and *blocklist* are created for devices to connect to the file server.

A client must now have its own certificate and be on an *allowlist* to establish the QUIC connection before any SMB connection can occur. Client access control provides organizations with added protection without altering the authentication used during the SMB connection, and the user experience remains unaffected. Additionally, you can disable the SMB over QUIC client entirely or only allow connections to specific servers.

To learn more, see:

- [Configure SMB over QUIC client access control in Windows Server 2022 Azure Edition and Windows Server 2025](configure-smb-over-quic-client-access-control.md)

- [Configure SMB over QUIC client access control demo video](https://www.youtube.com/watch?v=BPC3plpGt40&t=39m36s)

### SMB over QUIC in Windows Server

SMB over QUIC is now available in all editions of Windows Server 2025 whereas it was only present in the Azure Edition of Windows Server 2022. SMB over QUIC is an alternative to the outdated TCP protocol and is intended for use on untrusted networks such as the Internet. TLS 1.3 and certificates are used to ensure that all SMB traffic is encrypted, enabling it to be utilized through edge firewalls by mobile and remote users without the need for a VPN. QUIC also ensures that if NTLM is required, a user challenge-response (password data) isn't exposed on the network like it is with TCP.

To learn more, see:

- [SMB over QUIC](smb-over-quic.md)

- [SMB over QUIC demo video](https://www.youtube.com/watch?v=BPC3plpGt40&t=35m30s)

### SMB Remote Mailslots deprecation

Remote Mailslots are no longer enabled by default for SMB and DC locator protocol usage with Active Directory (AD), as its deprecated. The Remote Mailslot protocol, which was originally introduced in MS DOS, is now considered obsolete and unreliable. It's also unsafe as it lacks any authentication or authorization mechanisms.

To learn more, see:

- [Deprecated features for Windows client](/windows/whats-new/deprecated-features)

- [Features removed or no longer developed starting with Windows Server 2025](/windows-server/get-started/removed-deprecated-features-windows-server-2025)

## See also

- [SMB security enhancements](smb-security.md)


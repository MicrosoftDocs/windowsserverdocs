---
title: LDAP Signing Overview for Active Directory
description: Learn how LDAP signing protects Active Directory LDAP sessions from tampering and replay attacks. Explore defaults by Windows Server version and event monitoring.
#customer intent: As an IT admin, I want to understand how LDAP signing works so that I can protect LDAP communications from tampering and replay attacks in my Active Directory environment.
ms.topic: concept-article
ms.date: 10/02/2026
author: robinharwood
ms.author: roharwoo
ms.reviewer: roharwoo
ai-usage: ai-assisted
---

# LDAP signing overview for Active Directory Domain Services

_LDAP signing_ is a security feature that cryptographically signs Lightweight Directory Access Protocol (LDAP) messages to verify their authenticity and integrity during Simple Authentication and Security Layer (SASL) sessions that don't use Transport Layer Security (TLS) in Active Directory Domain Services (AD DS) and Active Directory Lightweight Directory Services (AD LDS).

If you use LDAP to authenticate users and retrieve directory information in AD DS, unsigned traffic leaves your environment vulnerable to attack. Bad actors can modify packets in transit, tamper with query responses, or inject messages that alter directory objects.

This article explains how LDAP signing works, describes default behavior by Windows Server version, and covers event monitoring for troubleshooting.

## What LDAP signing does and doesn't do

LDAP signing provides **integrity and authenticity** but not confidentiality. Attackers can still read signed LDAP messages sent over port 389 without TLS. To help protect confidentiality, use TLS (LDAPS or STARTTLS) or SASL sealing.

LDAP signing applies only to **non-TLS SASL sessions**. When you use TLS, it provides message integrity, so LDAP signing doesn't apply separately. Signing and TLS address the same need (integrity) in different contexts.

LDAP signing doesn't protect **simple binds**. The LDAP protocol layer doesn't protect simple-bind credentials, so use TLS to protect them in transit. This limitation is why Microsoft recommends SASL with Kerberos for LDAP authentication.

## How signing, encryption, and channel binding relate

LDAP security involves four distinct protection layers, each addressing a different threat:

| Protection layer | What it provides | When it applies |
|---|---|---|
| **LDAP signing** | Message integrity and authenticity | Non-TLS SASL sessions on port 389 |
| **SASL sealing** | Confidentiality, integrity, and server identity | Non-TLS SASL sessions on port 389 |
| **TLS (LDAPS / STARTTLS)** | Confidentiality, integrity, and server identity | All session types over TLS (port 636, or port 389 with STARTTLS) |
| **Channel binding (CBT)** | Binds authentication to the specific TLS session, preventing credential relay | TLS + SASL sessions only (primarily protects against NTLM relay) |

Each layer protects against different attacks and applies in different scenarios. For non-TLS environments, LDAP signing helps protect message integrity, and SASL sealing adds confidentiality. For TLS environments, CBT helps close the NTLM relay gap. For more information about channel binding, see [LDAP channel binding for AD DS](ldap-channel-binding.md).

## How LDAP signing works

LDAP signing digitally signs LDAP messages to help ensure that data isn't tampered with during transmission. When you enable LDAP signing, both the client and server cryptographically sign their communications. The process rejects any unsigned or improperly signed requests, preventing unauthorized modifications to LDAP messages.

The signing process uses Simple Authentication and Security Layer (SASL) protocols, including Kerberos, NTLM, and Digest. NTLM and Digest are deprecated, so use Kerberos instead. When you enforce LDAP signing on a domain controller, it rejects SASL LDAP binds that don't request signing and rejects simple binds over unencrypted connections.

## Default LDAP signing behavior

The default LDAP signing settings depend on your Windows Server version and deployment type. Configure LDAP signing through Group Policy settings on domain controllers and client computers. To manage these policies, see [Manage LDAP signing by using Group Policy](../manage-ldap-signing-group-policy.md).

### Windows Server 2025 or later

Windows Server 2025 or later requires LDAP signing by default for new Active Directory deployments. Two policies control server-side signing:

- **Domain controller: LDAP server signing requirements**: sets the signing level, with **None** and **Require signing** options.
- **Domain controller: LDAP server signing requirements enforcement**: enabled by default on new deployments. When enabled, it enforces signing and takes precedence over the signing-level policy.

Client-side defaults also change:

- **LDAP client signing**: Windows Server 2025 or later LDAP clients use encrypted connections by default. When encryption is active, SASL sealing or TLS provides message integrity, so LDAP signing doesn't apply separately. For unencrypted connections, the client requests signing by default.

### Windows Server 2022 or earlier

Windows Server 2022 or earlier makes LDAP security features available but doesn't enforce them by default:

- **LDAP server signing**: optional by default; domain controllers accept both signed and unsigned LDAP binds.
- **LDAP client signing**: Windows Server 2022 or earlier LDAP clients request signing by default but can fall back to unencrypted, unsigned connections. When the connection is unencrypted, signing is the primary integrity protection.

This permissive default setting supports existing applications and devices but requires administrators to manually enable LDAP signing to protect against man-in-the-middle and replay attacks.

### Windows client versions

Client LDAP signing behavior varies by Windows version.

#### Windows 11, version 24H2 or later

Windows 11, version 24H2 or later encrypts LDAP connections by default. When encryption is active, SASL sealing or TLS provides message integrity, so LDAP signing doesn't apply separately. These clients also support LDAP signing for connections that don't use encrypted communication.

#### Earlier Windows client versions

Earlier Windows clients use unencrypted connections by default, making LDAP signing the primary integrity protection for these clients. The client application controls the use of encryption. All earlier versions of Windows request LDAP signing by default as LDAP clients.

### Upgrade considerations

When you upgrade from earlier Windows Server versions to Windows Server 2025:

- **Existing policies preserved**: if you have LDAP server-side or client-side signing policies in place, the upgrade maintains your current settings to prevent disruption.
- **No server policy set**: if no LDAP server signing policy exists, Windows Server 2025 requires LDAP signing by default.
- **Gradually enforce**: evaluate client compatibility by using event monitoring before requiring LDAP signing.
- **Migration path**: monitor `Event IDs 2887 and 2889` to identify unsigned clients, configure those clients to request signing, and then move to **Require signing** after validating compatibility.

For more information about the history of LDAP signing policy changes in Windows, see [2020, 2023, and 2024 LDAP channel binding and LDAP signing requirements for Windows](https://support.microsoft.com/topic/2020-2023-and-2024-ldap-channel-binding-and-ldap-signing-requirements-for-windows-kb4520412-ef185fb8-00f7-167d-744c-f299a66fc00a).

## LDAP signing event monitoring

LDAP signing generates specific events that help you monitor security status and troubleshoot connectivity problems. View these events in Event Viewer under **Applications and Services Logs** > **Directory Service**.

| Event ID | Description | Recommended action |
|----------|-------------|-------------------|
| 2886 | Logged at Directory Service startup. Warns that the domain controller (DC) doesn't reject unsigned SASL binds or clear-text simple binds. | Evaluate client compatibility and consider requiring signing. |
| 2887 | 24-hour summary of unsigned SASL binds and clear-text simple binds that the DC **permitted**. | Investigate which clients are making unsigned binds. Enable diagnostic logging (Event 2889) to identify specific clients. |
| 2888 | 24-hour summary of unsigned SASL binds and clear-text simple binds that the DC **rejected** because signing is enforced. | No immediate action needed; signing is working as configured. Review rejected client counts to track migration progress. |
| 2889 | Per-client detail: logs the IP address and identity of each client that attempted an unsigned or clear-text bind. To log this event, set the **16 LDAP Interface Events** diagnostic level to **2** (Basic). | Identify and update the specific clients. Disable diagnostic logging after investigation to avoid a performance impact. |

For channel binding events (3039-3041, 3074-3075), see [LDAP channel binding for AD DS](ldap-channel-binding.md).

### Event monitoring considerations

New Windows Server 2025 deployments require signing by default. When you enable signing on Windows Server 2022 or earlier, or in upgraded environments that kept the previous policy, consider these monitoring and compatibility factors:

- **Auditing**: **Advanced Audit Policy Configuration** in **Group Policy** under **Audit Directory Service Access** provides auditing for the deployment.
- **Regular monitoring**: Event Viewer under **Applications and Services Logs** > **Directory Service** shows events `2886` through `2889`.
- **Client identification**: Event 2887 reports the number of unsigned binds. Diagnostic logging captures Event 2889, which records each unsigned bind attempt, including the client IP address and identity.
- **Gradual implementation**: **Negotiate signing** helps identify unsigned clients before you switch to **Require signing** after verifying client compatibility.
- **Audit mode**: An audit-only deployment identifies incompatible clients before enforcement.
- **Noncompliant clients**: Clients that can't support signing require an upgrade or replacement. Isolate these clients on separate network segments if necessary.

For step-by-step troubleshooting guidance, see [How to enable LDAP signing in Windows Server](/troubleshoot/windows-server/active-directory/enable-ldap-signing-in-windows-server).

## LDAP client performance counters

Windows Server 2025 and Windows 11 version 24H2 introduce LDAP client performance counters that show detailed information about LDAP client operations. These counters monitor binds, connections, operations, requests, responses, and searches per process on the local client machine. Assess multiple processes simultaneously to identify performance bottlenecks, troubleshoot Active Directory performance problems, and optimize LDAP client behavior in production environments.

For more information about LDAP client performance counters, see [Active Directory LDAP client performance counters](ldap-client-performance-counters.md).

## Next steps

- [LDAP channel binding for AD DS](ldap-channel-binding.md)
- [Configure certificates for LDAP over SSL](configure-ldap-signing-certificates.md)
- [Manage LDAP signing by using Group Policy](../manage-ldap-signing-group-policy.md)
- [How to enable LDAP signing in Windows Server](/troubleshoot/windows-server/active-directory/enable-ldap-signing-in-windows-server)
- [Active Directory LDAP client performance counters](ldap-client-performance-counters.md)

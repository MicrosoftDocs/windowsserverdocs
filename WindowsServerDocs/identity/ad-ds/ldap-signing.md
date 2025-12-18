---
title: LDAP signing for Active Directory Domain Services on Windows Server
description: Understand the role of LDAP signing and channel binding in verifying data integrity and preventing session hijacking in Active Directory.
#customer intent: As an IT admin, I want to understand how to enable LDAP signing so that I can secure LDAP communications in my Active Directory environment.
ms.topic: concept-article
ms.date: 12/18/2025
author: robinharwood
ms.author: roharwoo
ms.reviewer: roharwoo
ai-usage: ai-assisted
---

# LDAP signing for Active Directory Domain Services

_LDAP signing_ is a security feature that cryptographically signs Lightweight Directory Access Protocol (LDAP) communications to verify data authenticity and integrity in Active Directory Domain Services (AD DS). _LDAP channel binding_ uses Channel Binding Tokens (CBT) to bind application-layer security with the underlying SSL/TLS session, preventing session hijacking and man-in-the-middle attacks. Together, these features protect LDAP traffic in AD DS environments from tampering, replay attacks, and unauthorized access.

Administrators widely use LDAP to authenticate users and retrieve directory information in AD DS. Without proper security measures, intruders can intercept authentication attempts, modify packets in transit, or hijack encrypted sessions. LDAP signing and channel binding provide essential protection layers that ensure both clients and servers can trust the authenticity and integrity of their communications.

This article explains how LDAP signing and channel binding work, describes the security improvements Microsoft has introduced over time, and highlights new features in Windows Server 2025.

## How LDAP signing works

LDAP signing digitally signs LDAP messages to ensure that data isn't tampered with during transmission. When you enable LDAP signing, both the client and server cryptographically sign their communications. The process rejects any unsigned or improperly signed requests, preventing unauthorized modifications to LDAP messages.

The signing process uses Simple Authentication and Security Layer (SASL) protocols, which include Negotiate, Kerberos, NTLM, and Digest protocols. When you enforce LDAP signing on a domain controller, it rejects SASL LDAP binds that don't request signing and rejects simple binds performed over nonencrypted connections.

Unsigned LDAP traffic is vulnerable to:

- **Replay attacks**: An intruder intercepts authentication attempts and tickets, then reuses them to impersonate legitimate users.
- **Man-in-the-middle attacks**: An attacker captures packets between client and server, modifies them, and forwards altered requests to the domain controller.

By default, LDAP uses port 389. LDAP over SSL/TLS (LDAPS) uses port 636 and establishes encryption immediately upon connection.

## How LDAP channel binding works

LDAP channel binding uses Channel Binding Tokens (CBT) to cryptographically bind application-layer security (such as an SSL/TLS session) with the underlying network connection. This binding ensures that even if an attacker intercepts the encrypted session, they can't hijack or downgrade the connection.

Channel binding is important when you use NTLM or Simple Bind authentication over SSL/TLS. Without CBT enforcement, SSL/TLS encryption alone doesn't prevent all man-in-the-middle scenarios. An attacker positioned between client and server could potentially intercept the connection. By binding the security context directly to the SSL/TLS session, CBT ensures the session remains tamper-proof throughout its lifetime.

When you enable channel binding:

1. The client establishes an SSL/TLS connection to the LDAP server.
1. A Channel Binding Token is generated based on the SSL/TLS session parameters.
1. The client includes this token when authenticating.
1. The server validates that the token matches the current SSL/TLS session.
1. If tokens mismatch or are missing when required, the connection is rejected.

## Default security behavior

The default LDAP security settings vary depending on your Windows Server version and deployment type.

### Windows Server 2019 and earlier

In Windows Server 2019 and earlier, LDAP security features are available but not enforced by default:

- **LDAP signing**: Optional by default; domain controllers accept both signed and unsigned LDAP binds.
- **LDAP channel binding**: Set to "Never" by default; domain controllers don't require Channel Binding Tokens.
- **Client behavior**: Windows clients prefer encrypted connections but fall back to unencrypted if necessary.

This permissive default allows compatibility with legacy applications and devices but requires administrators to manually enable security features to protect against man-in-the-middle attacks and session hijacking.

### Windows Server 2025 and later

Windows Server 2025 and later significantly strengthens the default security posture for new deployments:

- **LDAP signing**: All new Active Directory deployments require LDAP signing by default through the "Domain controller: LDAP server signing requirements enforcement" policy.
- **LDAP channel binding**: Set to "When supported" by default; domain controllers accept channel binding when clients provide it.
- **LDAP client encryption**: Preferred by default.
- **Channel binding auditing**: Enabled by default.

These enhanced defaults protect new environments immediately upon deployment and are compatible with clients that support modern security features.

### Upgrade considerations

When you upgrade from earlier Windows Server versions to Windows Server 2025:

- **Existing policies preserved**: Upgrade installations maintain their current LDAP security settings to prevent disruption.
- **Gradual enforcement recommended**: Evaluate client compatibility by using event monitoring before enabling signing or channel binding requirements.
- **Migration path**: Start with "When supported" for channel binding and "Negotiate signing" for signing, then move to full enforcement after validating compatibility.

For more information about the evolution of these requirements and specific deployment timelines, see [2020, 2023, and 2024 LDAP channel binding and LDAP signing requirements for Windows](https://support.microsoft.com/topic/2020-2023-and-2024-ldap-channel-binding-and-ldap-signing-requirements-for-windows-kb4520412-ef185fb8-00f7-167d-744c-f299a66fc00a).

## Group policy settings

You can configure LDAP signing and channel binding through Group Policy settings on domain controllers and client computers.

### LDAP signing policies

**Domain controller policy:**

- **Path**: Default Domain Controller Policy > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options
- **Setting**: Domain controller: LDAP server signing requirements
- **Options**:
  - **None**: Doesn't require signing (vulnerable to attacks)
  - **Require signing**: Rejects unsigned LDAP binds

**Client policy:**

- **Path**: Local Computer Policy > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options
- **Setting**: Network security: LDAP client signing requirements
- **Options**:
  - **None**: Client doesn't request signing
  - **Negotiate signing**: Client requests signing if server supports it
  - **Require signing**: Client requires signing for all LDAP traffic

### LDAP channel binding policy

**Domain controller policy:**

- **Path**: Default Domain Controller Policy > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options
- **Setting**: Domain controller: LDAP server channel binding token requirements
- **Options**:
  - **Never**: Doesn't require channel binding
  - **When supported**: Accepts channel binding when clients provide it
  - **Always**: Requires channel binding for all connections

## Event monitoring

LDAP signing and channel binding generate specific events that help you monitor security status and troubleshoot connectivity problems. You can see these events in Event Viewer under the Directory Service category.

### LDAP signing events

| Event ID | Name | Description | Recommended action |
|----------|------|-------------|-------------------|
| 2886 | LDAP signing not required | Domain controller accepts unsigned LDAP communications | Evaluate client compatibility and consider requiring signing |
| 2887 | Unsigned LDAP binds detected | Client made unsigned simple bind or SASL bind without SSL/TLS | Investigate client; configure to use LDAPS or signed LDAP |
| 2888 | LDAP signing disabled | Domain controller accepts all unsigned traffic (highly vulnerable) | Immediately enable LDAP signing to protect environment |
| 2889 | Signed LDAP communications | Domain controller successfully processed signed LDAP request | No action needed; indicates secure traffic |

### LDAP channel binding events

| Event ID | Name | Description | Recommended action |
|----------|------|-------------|-------------------|
| 3039 | Channel binding not supported | Client doesn't support CBT when policy requires it | Update client or temporarily adjust policy during migration |
| 3040 | Channel binding failure | Client attempted CBT but binding failed (token mismatch) | Verify SSL/TLS certificates and network configuration |
| 3041 | Channel binding successful | Client successfully used channel binding | No action needed; indicates secure communication |

### Event troubleshooting workflow

1. **Enable auditing**: Configure Advanced Audit Policy Configuration in Group Policy under Audit Directory Service Access.
1. **Monitor logs regularly**: Check Event Viewer > Directory Service for events 2886-2889 and 3039-3041.
1. **Identify problematic clients**: Investigate sources of Event 2887 or 3039. Update client configurations to support signing and channel binding.
1. **Implement gradually**: Start with "Negotiate signing" and "When supported" policies, then move to full enforcement after verifying client compatibility.
1. **Use audit mode**: Deploy changes in audit-only mode first to identify incompatible clients before enforcing.
1. **Update legacy systems**: Upgrade or replace clients that can't support signing or channel binding. Isolate them on separate network segments if necessary.

## LDAP client performance counters

Windows Server 2025 and Windows 11 version 24H2 introduce LDAP client performance counters that provide detailed visibility into LDAP client operations. These counters monitor binds, connections, operations, requests, responses, and searches per process on the local client machine. You can assess multiple processes simultaneously, helping you identify performance bottlenecks, troubleshoot Active Directory performance problems, and optimize LDAP client behavior in production environments.

For more information about LDAP client performance counters, see [Active Directory LDAP client performance counters](ldap-client-performance-counters.md).

## Next steps

> [!div class="nextstepaction"]
> [Configure certificates for LDAP over SSL](configure-ldap-signing-certificates.md)

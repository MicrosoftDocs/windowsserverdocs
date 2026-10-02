---
title: LDAP Channel Binding in Active Directory
description: Learn how LDAP channel binding prevents credential relay attacks on TLS-secured sessions, with auditing and enforcement details for Active Directory.
#customer intent: As an IT admin, I want to understand LDAP channel binding so that I can protect TLS-secured LDAP sessions from relay attacks in my Active Directory environment.
ms.topic: concept-article
ms.date: 10/02/2026
author: robinharwood
ms.author: roharwoo
ms.reviewer: roharwoo
ai-usage: ai-assisted
---

# LDAP channel binding overview for Active Directory Domain Services

 *Lightweight Directory Access Protocol (LDAP) channel binding* is a security feature that cryptographically ties Simple Authentication and Security Layer (SASL) authentication to the Transport Layer Security (TLS) session for an LDAP connection. When a domain controller requires a valid Channel Binding Token (CBT), it rejects authentication that an attacker relays over a different TLS session. Channel binding is the LDAP implementation of Extended Protection for Authentication (EPA). Active Directory uses Channel Binding Tokens (CBT) to verify that the client who authenticated is the same client who established the TLS connection.

When you use TLS to secure LDAP connections, TLS alone doesn't prevent an attacker from intercepting a client's authentication data and forwarding it to your domain controller over a separate TLS session. Without channel binding, the domain controller can't distinguish authentication that an attacker relays from legitimate authentication, leaving your environment vulnerable to credential relay attacks.

This article helps you understand how channel binding protects LDAP sessions, check which session types require it, and plan auditing and enforcement for your environment.

## What is Extended Protection for Authentication?

Extended Protection for Authentication (EPA) protects against credential relay (forwarding) attacks. In a relay attack, an attacker intercepts a client's authentication exchange and forwards it to a server over a different connection. Because Security Support Provider Interface (SSPI) authentication messages travel openly on the network (they aren't secrets like bearer tokens), an attacker can replay them from another session.

EPA addresses this vulnerability by binding the inner authentication protocol session key to the outer TLS channel. The authentication exchange includes a Channel Binding Token (CBT) based on the TLS session parameters. The server validates that the CBT in the authentication data matches its own TLS session. A mismatch means an attacker relays the authentication from a different channel, and the server rejects the request.

EPA provides two mechanisms:

- **Channel binding.** Cryptographically binds the authentication to the TLS session by using a CBT based on the server certificate. This mechanism provides the primary protection.
- **Service binding.** A name-based fallback for scenarios where the server doesn't have access to the TLS session key (for example, TLS terminating load balancers). The server verifies that the client authenticates to a name matching the server TLS certificate.

For more information about the EPA framework, see [Extended Protection for Authentication overview](/dotnet/framework/wcf/feature-details/extended-protection-for-authentication-overview) and [Supporting EPA in a service](/windows/win32/secauthn/epa-support-in-service).

## When does LDAP channel binding apply?

LDAP channel binding applies through the **Domain controller: LDAP server channel binding token requirements** policy only to **TLS-secured sessions that use Simple Authentication and Security Layer (SASL) authentication**.

The primary risk that channel binding addresses is NTLM credential relay. You can intercept and forward (relay) NTLM authentication tokens to a different server because NTLM doesn't inherently bind the authentication to a specific connection. An attacker can terminate the client's TLS session, open a separate TLS session to the domain controller, and relay the NTLM authentication data. Without CBT, the domain controller can't distinguish authentication that an attacker relays from legitimate authentication.

Kerberos reduces the risk of credential relay by providing its own mutual authentication and built-in replay detection. But CBT still applies to Kerberos SASL binds over TLS and provides extra assurance.

LDAPS connections that don't use channel binding are common in environments that don't enforce channel binding, but they leave the NTLM relay gap open. TLS alone encrypts the transport and authenticates the server, but it doesn't bind the inner authentication to the specific TLS session.

Channel binding doesn't apply to the following session types:

- **Simple bind over TLS.** LDAP signing and CBT don't protect simple binds. The LDAP protocol layer doesn't protect simple-bind credentials. Instead, a simple bind relies on TLS for confidentiality, integrity, and server identity verification. For the strongest protection, use SASL binds with Kerberos over TLS with CBT enabled.
- **Certificate bind over TLS.** Client certificate authentication is sufficient to block relay attacks. No CBT is exchanged.
- **Non-TLS SASL sessions.** Channel binding doesn't apply because no TLS channel exists. LDAP signing protects message integrity only when the client requests signing or the server requires it.

## How signing, encryption, and channel binding relate

LDAP security involves four distinct protection layers, each addressing a different threat:

| Protection layer | What it provides | When it applies |
|---|---|---|
| **LDAP signing** | Message integrity and authenticity | Non-TLS SASL sessions on port 389 |
| **SASL sealing** | Confidentiality, integrity, and server identity | Non-TLS SASL sessions on port 389 |
| **TLS (LDAPS/STARTTLS)** | Confidentiality, integrity, and server identity | All session types over TLS (port 636, or port 389 with STARTTLS) |
| **Channel binding (CBT)** | Binds authentication to the specific TLS session, preventing credential relay | TLS + SASL sessions only (primarily protects against NTLM relay) |

For information about LDAP signing, which protects non-TLS SASL sessions, see [LDAP signing for Active Directory Domain Services](ldap-signing.md).

For a detailed breakdown of which policy settings affect each session type, see [LDAP session security settings and requirements after ADV190023](/troubleshoot/windows-server/active-directory/ldap-session-security-settings-requirements-adv190023).

## How LDAP channel binding works

When you enable or require channel binding, the authentication flow for a TLS + SASL session works as follows:

1. The client and server establish a TLS connection.
1. Both sides independently derive a Channel Binding Token (CBT) from the TLS session.
1. The client includes its CBT in the SASL authentication exchange.
1. The server compares the client's CBT to its own. If they match, authentication succeeds. If they don't match, or the CBT is missing when required, the server rejects the connection.

Because the attacker in a relay scenario establishes a separate TLS session to the server, their TLS session parameters and therefore CBT differ from the client's original session. The relayed authentication data contains a CBT that doesn't match the attacker's TLS session, and the server rejects the request.

In other words, CBT ensures that the same client session establishes the TLS connection and sends the authentication inside the TLS tunnel. Without CBT, an attacker can terminate a client's TLS session, open their own TLS session to the domain controller, and relay the client's NTLM authentication data. The domain controller can't distinguish the relayed authentication from a legitimate one.

## Default behavior by Windows Server version

The default LDAP channel binding settings vary depending on your Windows Server version and deployment type. Configure channel binding by using the **Domain controller: LDAP server channel binding token requirements** Group Policy setting (registry value: `LdapEnforceChannelBinding`).

The policy accepts the following values:

| Value | Name | Behavior |
|-------|------|----------|
| 0 | Never | The server doesn't perform channel binding validation. |
| 1 | When supported | Clients that support CBT must provide it. Clients that don't support CBT are still allowed. The server logs auditing events. |
| 2 | Always | All applicable TLS and SASL clients must provide CBT. The server rejects authentication from clients that don't provide a valid token. |

### Windows Server 2025 or later

For new Active Directory deployments on Windows Server 2025 or later:

- **Channel binding policy**: Defaults to **When supported**. Domain controllers accept channel binding when clients provide it but don't reject clients that don't support CBT.
- **Channel binding auditing**: Logs events by default when clients connect without CBT.

### Windows Server 2022 or earlier

In Windows Server 2022 or earlier:

- **Channel binding policy**: Set to **Never**. Domain controllers don't validate Channel Binding Tokens.
- **Auditing**: The 2023-03 security updates enable CBT auditing by default on domain controllers.

## Channel binding audit events

Find channel binding events in Event Viewer under **Applications and Services Logs** > **Directory Service** with the event source `Microsoft-Windows-ActiveDirectory_DomainService`. These events help you assess client compatibility before enforcing channel binding requirements.

Windows Server 2025 enables CBT auditing by default. Starting in March 2023, Windows updates for Windows Server 2022 and Windows Server 2019 enabled CBT auditing by default. This change is part of the phased enforcement described in security advisory [ADV190023](https://msrc.microsoft.com/update-guide/advisory/ADV190023). For the complete timeline, see [2020, 2023, and 2024 LDAP channel binding and LDAP signing requirements for Windows](https://support.microsoft.com/topic/2020-2023-and-2024-ldap-channel-binding-and-ldap-signing-requirements-for-windows-kb4520412-ef185fb8-00f7-167d-744c-f299a66fc00a).

The system generates events 3039, 3074, and 3075 only when you set channel binding to **When supported** (1) or **Always** (2). Events 3074 and 3075 require Windows Server 2022 (August 2023 update) or Windows Server 2019 (October 2023 update) and diagnostic level 2.

| Event ID | Description | Trigger |
|----------|-------------|---------|
| 3039 | Client performs an LDAP bind over SSL/TLS and fails CBT validation. | Per-client: client sends an improperly formatted CBT, a CBT-capable client doesn't send a CBT, or CBT is required and not provided. Requires diagnostic level 2. |
| 3040 | 24-hour summary of completed, unprotected LDAPS binds. | Triggered when CBT policy is **Never** and at least one unprotected bind occurred. Diagnostic level 0. |
| 3041 | Startup or periodic reminder to enforce CBT validation and improve domain controller security. | Triggered every 24 hours or at service startup when CBT policy is **Never**. Diagnostic level 0. |
| 3074 | Client performs an LDAP bind over SSL/TLS and **would fail** CBT validation under enforcement. | Per-client: client sends an improperly formatted CBT. Requires diagnostic level 2. |
| 3075 | Client performs an LDAP bind over SSL/TLS and **doesn't provide** channel binding information. The event logs the client IP, identity, whether the client supports channel binding, and audit result flags. | Per-client: a CBT-capable client doesn't send a CBT. Requires diagnostic level 2. |

For the complete event reference and diagnostic logging instructions, see [2020, 2023, and 2024 LDAP channel binding and LDAP signing requirements for Windows](https://support.microsoft.com/topic/2020-2023-and-2024-ldap-channel-binding-and-ldap-signing-requirements-for-windows-kb4520412-ef185fb8-00f7-167d-744c-f299a66fc00a).

## Defense in depth: LDAP session security by scenario

The following table shows what protection each combination of LDAP settings provides. Use it to identify which security gaps exist in your environment and what changes close them.

| Scenario | Confidentiality | Message integrity | Credential relay protection |
|---|---|---|---|
| Port 389 + Simple Bind | None | None | None. Credentials travel in plain text. |
| Port 389 + SASL + LDAP signing | None. Attackers can read traffic on the wire. | LDAP signing (SASL session key) | Signing detects tampering and, with NTLM, doesn't prevent relay. |
| **Port 389 + SASL + LDAP sealing** | LDAP sealing (SASL session key) | LDAP signing (SASL session key) | LDAP sealing provides confidentiality and integrity for the established session. With NTLM, sealing doesn't mitigate NTLM relay attacks because an attacker can establish a separate sealed session. With Kerberos, mutual authentication and service binding help prevent classic relay attacks. |
| LDAPS + Simple Bind | TLS | TLS | None. Simple binds don't use CBT. |
| LDAPS + SASL (no CBT) | TLS | TLS | Vulnerable to NTLM relay |
| LDAPS + SASL + CBT | TLS | TLS | CBT binds authentication to the TLS session |
| **LDAPS + SASL (Kerberos) + CBT** | **TLS** | **TLS** | **Kerberos mutual authentication + CBT** |

For the strongest security posture, use SASL authentication with Kerberos over TLS and enforce channel binding. This combination provides encrypted transport, tamper-resistant authentication, and cryptographic binding between the authentication exchange and the TLS session, closing both man-in-the-middle and credential relay attack paths.

## Next steps

- [LDAP signing for Active Directory Domain Services](ldap-signing.md)
- [LDAP session security settings and requirements after ADV190023](/troubleshoot/windows-server/active-directory/ldap-session-security-settings-requirements-adv190023)
- [Microsoft Security Advisory ADV190023](https://msrc.microsoft.com/update-guide/advisory/ADV190023)
- [Extended Protection for Authentication overview (.NET)](/dotnet/framework/wcf/feature-details/extended-protection-for-authentication-overview)
- [Supporting EPA in a service (Win32)](/windows/win32/secauthn/epa-support-in-service)
- [Configure certificates for LDAP over SSL](configure-ldap-signing-certificates.md)
- [Manage LDAP signing by using Group Policy](../manage-ldap-signing-group-policy.md)
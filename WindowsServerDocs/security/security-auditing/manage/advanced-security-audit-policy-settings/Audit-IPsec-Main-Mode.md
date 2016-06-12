---
title: Audit IPsec Main Mode
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64357d5a-49b5-4567-8e4c-dee4c284a1a8
---
# Audit IPsec Main Mode
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit IPsec Main Mode**, which determines whether the operating system generates events for the results of the Internet Key Exchange \(IKE\) protocol and Authenticated Internet Protocol \(AuthIP\) during Main Mode negotiations.

IKE is an Internet standard, defined in RFC 2409, that defines a mechanism to establish IPsec security associations \(SAs\). An SA is a combination of a mutually agreeable policy and keys that define the security services and mechanisms that help protect communication between IPsec peers.

AuthIP is an enhanced version of IKE that offers additional flexibility with support for user\-based authentication, authentication with multiple credentials, improved authentication method negotiation, and asymmetric authentication. Like IKE, AuthIP supports Main Mode and Quick Mode negotiation.

Main Mode Internet Key Exchange \(IKE\) negotiation establishes a secure channel, known as the Internet Security Association and Key Management Protocol \(ISAKMP\) security association \(SA\), between two computers. To establish the secure channel, Main Mode negotiation determines a set of cryptographic protection suites, exchanges keying material to establish the shared secret key, and authenticates computer identities.

Event volume: High

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4646|Security ID: %1|
|4650|An IPsec Main Mode security association was established. Extended Mode was not enabled. Certificate authentication was not used.|
|4651|An IPsec Main Mode security association was established. Extended Mode was not enabled. A certificate was used for authentication.|
|4652|An IPsec Main Mode negotiation failed. **Note:** This audit event returns detailed audit data in the following categories: Local Endpoint, Local Certificate, Remote Endpoint, Remote Certificate, Additional Information, and Failure Information.|
|4653|An IPsec Main Mode negotiation failed. **Note:** This audit event returns detailed audit data in the following categories: Local Endpoint, Remote Endpoint, Additional Information, and Failure Information.|
|4655|An IPsec Main Mode security association ended.|
|4976|During Main Mode negotiation, IPsec received an invalid negotiation packet. If this problem persists, it could indicate a network issue or an attempt to modify or replay this negotiation.|
|5049|An IPsec Security Association was deleted.|
|5453|An IPsec negotiation with a remote computer failed because the IKE and AuthIP IPsec Keying Modules \(IKEEXT\) service is not started.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)



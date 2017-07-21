---
title: What’s New in Kerberos Authentication
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 7bd17803-6e42-4a3b-803f-e47c74725813
manager: alanth
author: justinha
ms.technology: security-authentication
ms.date: 11/09/2016
---

# What's New in Kerberos Authentication

>Applies To: Windows Server 2016 and Windows 10

## KDC support for Public Key Trust-based client authentication

Beginning with Windows Server 2016, KDCs support a way of public key mapping. 
If the public key is provisioned for an account, then the KDC supports Kerberos PKInit explicitly using that key. 
Since there is no certificate validation, self-signed certificates are supported and authentication mechanism assurance is not supported.

Key Trust is preferred when configured for an account regardless of the UseSubjectAltName setting.

## Kerberos client and KDC support for RFC 8070 PKInit Freshness Extension

Beginning with Windows 10, version 1607 and Windows Server 2016, Kerberos clients will attempt the [RFC 8070 PKInit freshness extension](https://datatracker.ietf.org/doc/draft-ietf-kitten-pkinit-freshness/) for public key based sign-ons. 

Beginning with Windows Server 2016, KDCs can support the PKInit freshness extension. 
By default, KDCs will not offer the PKInit freshness extension. To enable it, use the new KDC support for PKInit Freshness Extension KDC administravie template policy setting on all the DCs in the domain. 
When enabled, the following options are supported when the domain is Windows Server 2016 domain functional level (DFL):

- **Disabled**: The KDC will never offer the PKInit Freshness Extension and accept valid authentication requests without checking for freshness. Users will never receive the fresh public key identity SID.
- **Supported**: PKInit Freshness Extension is supported on request. Kerberos clients successfully authenticating with the PKInit Freshness Extension will get the fresh public key identity SID.
- **Required**: PKInit Freshness Extension is required for successful authentication. Kerberos clients that do not support the PKInit Freshness Extension will always fail when using public key credentials.

## Domain-joined device support for authentication using public key

Beginning with Windows 10 version 1507 and Windows Server 2016, if a domain-joined device is able to register its bound public key with a Windows Server 2016 domain controller (DC), then the device can authenticate with the public key using Kerberos authentication to a Windows Server 2016 DC.

If the device does not support a way to generate a bound public key, then only password is supported.

By default, devices will first use the public key and fallback to password. This allows the device to authenticate to down-level DCs.

If the Group Policy setting **Support for device authentication using certificate** is set to **Force**, then the device will need to find a DC that runs Windows Server 2016 or later to authenticate. If the policy is disabled, then password is always used. The setting is under Administrative Templates > System > Kerberos.

## Kerberos clients allow IPv4 and IPv6 address hostnames in Service Principal Names (SPNs)

Beginning with Windows 10 version 1507 and Windows Server 2016, Kerberos clients can be configured to support IPv4 and IPv6 hostnames in SPNs. 

Registry path:

HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters

To configure support for IP address hostnames in SPNs, create a TryIPSPN entry. 
This entry does not exist in the registry by default. 
After you have created the entry, change the DWORD value to 1. 
If not configured, IP address hostnames are not attempted.

If the SPN is registered in Active Directory, then authentication will succeed with Kerberos. 

## KDC support for Key Trust account mapping

Beginning with Windows Server 2016, domian controllers have support for Key Trust account mapping as well as fallback to existing AltSecID and User Principal Name (UPN) in the SAN behavior. When UseSubjectAltName is set to:

- 0: Explicit mapping is required. Then there must be either:
    - Key Trust (new with Windows Server 2016)
    - ExplicitAltSecID
- 1: Implicit mapping is allowed (default):
    1. If Key Trust is configured for account, then it is used for mapping (new with Windows Server 2016).
    2. If there is no UPN in the SAN, then AltSecID is attempted for mapping.
    3. If there is a UPN in the SAN, then UPN is attempted for mapping.

## See Also

- [Kerberos Authentication Overview](kerberos-authentication-overview.md)

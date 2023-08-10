---
title: PKI design considerations using Active Directory Certificate Services in Windows Server
description: Use this article to understand PKI design considerations for the Active Directory Certificate Services Certification Authority role.
ms.topic: conceptual
author: Orin-Thomas
ms.author: orthomas
contributor: orthomas
ms.date: 08/09/2023
---

# PKI design considerations using Active Directory Certificate Services

There are some things that you should consider when planning the deployment of a Public Key Infrastructure using Active Directory Certificate Services. Here you can find what you need to plan to successfully install and configure your PKI environment.

At a high-level you should:

- Plan a public key infrastructure (PKI) that is appropriate for your organization.
- Install and configure a Hardware Security Module (HSM) according to the HSM vendor instructions, if you're planning to use one.
- Create an appropriate `CAPolicy.inf`, if you want to modify the default installation settings.
- Choose cryptographic options
- Determine CA Name
- Determine validity period
- Select CA database
- Authority Information Access and Certificate Revocation List Distribution Point settings

## Plan for PKI

To ensure that your organization can take full advantage of your Active Directory Certificate Services (AD CS) installation, you must plan the PKI deployment appropriately. You should determine how many CAs you need and in what configuration before you install any CA. For example, do you need an Enterprise Root CA or a Standalone Root CA? How will certificate approval requests be handled? How will you manage certificate revocation? Creating an appropriate PKI design can be time consuming, but it's important for the success of your PKI.

## Use an HSM

An HSM is a dedicated hardware device that is managed separately from the operating system. These modules provide a secure hardware store for CA keys, in addition to a dedicated cryptographic processor to accelerate signing and encrypting operations. The operating system utilizes the HSM through the CryptoAPI interfaces, and the HSM functions as a cryptographic service provider (CSP) device.

HSMs typically are PCI adapters, but they're also available as network-based appliances, serial devices, and USB devices. If an organization plans to implement two or more CAs, you can install a single network-based HSM and share it among multiple CAs.

To set up a CA by using an HSM, the HSM must be installed and configured before you set up any CAs with keys that need to be stored on the HSM.

## Consider a CAPolicy.inf file

The `CAPolicy.inf` file isn't required to install AD CS, but it can be used to customize the settings of the CA. The `CAPolicy.inf` file contains various settings that are used when installing a CA or when renewing the CA certificate. The `CAPolicy.inf` file must be created and stored in the `%systemroot%` directory (typically `C:\Windows`) for it to be used.

The settings that you include in the `CAPolicy.inf` file depend largely on the deployment type that you want to create. For example, a root CA might have a `CAPolicy.inf` file that looks like this:

```ini
[Version]
Signature= "$Windows NT$"
[Certsrv_Server]
RenewalKeyLength=4096
RenewalValidityPeriod=Years
RenewalValidityPeriodUnits=20
LoadDefaultTemplates=0
```

## Select cryptographic options

Selecting cryptographic options for a certification authority (CA) can have significant security, performance, and compatibility implications for that CA. Although the default cryptographic options may be suitable for most CAs. The ability to implement custom options can be useful to administrators and application developers with a more advanced understanding of cryptography and a need for this flexibility. Cryptographic options can be implemented by using cryptographic service providers (CSPs) or key storage providers (KSPs).

CSPs are hardware and software components in Windows operating systems that provide generic cryptographic functions. CSPs can be written to provide various encryption and signature algorithms.

When you select the provider, hash algorithm, and key length, carefully consider what cryptographic options the applications and devices that you intend to use can support. Although it’s a best practice to select the strongest security options, not all applications and devices can support these.

Allow administrator interaction when the private key is accessed by the CA is an option that is typically used with hardware security modules (HSMs). This option allows the cryptographic provider to prompt the user for additional authentication when the private key of the CA is accessed. For example, requiring the administrator to enter a password before every cryptographic operation.

The built-in cryptographic providers support specific key lengths and hash algorithms as described in the following table.

| Cryptographic provider | Key lengths | Hash algorithm |
| ----------------------- | ----------- | -------------- |
| Microsoft Base Cryptographic Provider v1.0 | - 512<br> - 1024<br> - 2048<br> - 4096 | - SHA1<br>- MD2<br>- MD4<br>- MD5 |
| Microsoft Base DSS Cryptographic Provider | - 512<br> - 1024 |	SHA1
| Microsoft Base Smart Card Crypto Provider | - 1024<br>- 2048<br>- 4096 |	- SHA1<br>- MD2<br>- MD4<br>- MD5 |
| Microsoft Enhanced Cryptographic Provider v1.0 | - 512<br>- 1024<br>- 2048<br>- 4096 |	- SHA1<br>- MD2<br>- MD4<br>- MD5 |
| Microsoft Strong Cryptographic Provider | - 512<br>- 1024<br>- 2048<br>- 4096 | - SHA1<br>- MD2<br>- MD4<br>- MD5 |
| RSA#Microsoft Software Key Storage Provider | - 512<br>- 1024<br>- 2048<br>- 4096 | - SHA1<br>- SHA256<br>- SHA384<br>- SHA512<br>- MD2<br>- MD4<br>- MD5 |
| DSA#Microsoft Software Key Storage Provider | - 512<br>- 1024<br>- 2048 |	SHA1 |
| ECDSA_P256#Microsoft Software Key Storage Provider | 256 | - SHA1<br>- SHA256<br>- SHA384<br>- SHA512 |
| ECDSA_P384#Microsoft Software Key Storage Provider | 384 | - SHA1<br>- SHA256<br>- SHA384<br> - SHA512 |
| ECDSA_P521#Microsoft Software Key Storage Provider | 521 | - SHA1<br>- SHA256<br>- SHA384<br>- SHA512 |
| RSA#Microsoft Smart Card Key Storage Provider | - 1024<br>- 2048<br>- 4096 | - SHA1<br>- SHA256<br>- SHA384<br>- SHA512<br>- MD2<br>- MD4<br>- MD5 |
| ECDSA_P256#Microsoft Smart Card Key Storage Provider | 256 | - SHA1<br>- SHA256<br>- SHA384<br>- SHA512 |
| ECDSA_P384#Microsoft Smart Card Key Storage Provider | 384 | - SHA1<br>- SHA256<br>- SHA384<br>- SHA512 |
| ECDSA_P521#Microsoft Smart Card Key Storage Provider | 521 | - SHA1<br>- SHA256<br>- SHA384<br>- SHA512 |

## Determine CA name

Before you configure certification authorities (CAs) in your organization, you should establish a CA naming convention.

You can create a name by using any Unicode character, but you might want to use the ANSI character set if interoperability is a concern. For example, certain types of routers aren't able to use the Network Device Enrollment Service to enroll for certificates if the CA name contains special characters such as an underscore.

If you use non-Latin characters (such as Cyrillic, Arabic, or Chinese characters), your CA name must contain fewer than 64 characters. If you use only non-Latin characters, your CA name can be no more than 37 characters in length.

In Active Directory Domain Services (AD DS), the name that you specify when you configure a server as a CA becomes the common name of the CA. The common name is reflected in every certificate that the CA issues. For this reason, it's important that you don't use the fully qualified domain name for the common name of the CA. This way, malicious users who obtain a copy of a certificate can't identify and use the fully qualified domain name of the CA to create a potential security vulnerability.

The CA name shouldn't be identical to the name of the computer (NetBIOS or DNS name). Also, you can't change the name of a server after Active Directory Certificate Services (AD CS) is installed without invalidating all the certificates that are issued by the CA.

To change the server name after AD CS is installed, you must uninstall the CA, change the name of the server, reinstall the CA using the same keys and modify the registry to use the existing CA keys and database. You don't have to reinstall a CA if you rename a domain; however, you have to reconfigure the CA to support the name change.

## Determine validity period

Certificate-based cryptography uses public-key cryptography to protect and sign data. Over time, attackers could obtain data that was protected with the public key and attempt to derive the private key from it. Given enough time and resources, this private key could be compromised, effectively rendering all protected data unprotected. Also the names that are guaranteed by a certificate may need to be changed over time. Because a certificate is a binding between a name and a public key, when either change, the certificate should be renewed.

Every certificate has a validity period. After the end of the validity period, the certificate is no longer considered an acceptable or usable credential.

CAs can't issue certificates that are valid beyond their own validity period. A best practice is to renew the CA certificate when half of its validity period is expired. When installing a CA, you should plan this date and ensure that it's recorded as a future task.

## Select CA database

The certification authority's database is a file on the hard drive. In addition to this file, other files serve as the transaction logs, and they receive all modifications to the database before the changes are made. Because these files may be accessed frequently and simultaneously, you may wish to keep the database and transaction logs on separate volumes.

The location of the certificate database and log files are kept in the following registry location:

```Registry
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration
```

The registry contains following values:

- `DBDirectory`
- `DBLogDirectory`
- `DBSystemDirectory`
- `DBTempDirectory`

## Authority Information Access and Certificate Revocation List Distribution Point settings

After a root or subordinate CA is installed, you should configure the Authority Information Access (AIA) and CRL distribution point (CDP) extensions before the CA issues any certificates. The AIA extension specifies where to find up-to-date certificates for the CA. The CDP extension specifies where to find up-to-date CRLs that are signed by the CA. These extensions apply to all certificates that are issued by that CA.

Configuring these extensions ensures that this information is included in each certificate that the CA issues so that it's available to all clients. Using the extensions results in fewer failures due to unverified certificate chains or certificate revocations, which can result in unsuccessful VPN connections, failed smart card sign-ins, or unverified email signatures.

As a CA administrator, you can add, remove, or modify CRL distribution points and the locations for CDP and AIA certificate issuance. Modifying the URL for a CRL distribution point only affects newly issued certificates. Previously issued certificates continue to reference the original location, which is why you should establish these locations before your CA distributes any certificates.

Consider these guidelines when you configure CDP extension URLs:

- Avoid publishing delta CRLs on offline root CAs. Because you don't revoke many certificates on an offline root CA, a delta CRL is probably not needed.
- Adjust the default `LDAP://` and `https://` URL locations on the Extensions tab of the certification authority’s Properties Extension tab according to your needs.
- Publish a CRL on an HTTP Internet or extranet location so that users and applications outside the organization can perform certificate validation. You can publish the LDAP and HTTP URLs for CDP locations to enable clients to retrieve CRL data with HTTP and LDAP.
- Remember that Windows clients always retrieve the list of URLs in sequential order until a valid CRL is retrieved.
- Use HTTP CDP locations to provide accessible CRL locations for clients running non-Windows operating systems.

## Next steps

To learn more about deploying AD CS, see [Implement and manage Active Directory Certificate Services](/training/modules/implement-manage-active-directory-certificate-services/).

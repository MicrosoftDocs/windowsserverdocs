---
title: What is the Certification Authority Role Service in Windows Server
description: You can use this topic to understand the Active Directory Certificate Services Certification Authority role.
author: Orin-Thomas
ms.topic: conceptual
ms.author: orthomas
contributor: orthomas
ms.date: 06/20/2023
---

# What is the Certification Authority Role Service

This article provides information on the Certification Authority role service for Active Directory Certificate Services when deployed on the Windows Server operating system.

A certification authority (CA) is responsible for attesting to the identity of users, computers, and organizations. The CA authenticates an entity and vouches for that identity by issuing a digitally signed certificate. The CA can also manage, revoke, and renew certificates.

A certification authority can refer to following:

- An organization that vouches for the identity of an end user
- A server that is used by the organization to issue and manage certificates

By installing the Certification Authority role service of Active Directory Certificate Services (AD CS), you can configure your Windows server to act as a CA.

## Understanding Certification Authority types

Windows Server supports four different types of CA:

- Enterprise Root CA
- Enterprise Subordinate CA
- Standalone Root CA
- Standalone Subordinate CA

## Enterprise CAs and Standalone CAs

Enterprise CAs are integrated with Active Directory Domain Services (AD DS). They publish certificates and certificate revocation lists (CRLs) to AD DS. Enterprise CAs use information that is stored in AD DS, including user accounts and security groups, to approve or deny certificate requests. Enterprise CAs use certificate templates. When a certificate is issued, the Enterprise CA uses information in the certificate template to generate a certificate with the appropriate attributes for that certificate type.

If you want to enable automated certificate approval and automatic user certificate enrollment, use Enterprise CAs to issue certificates. These features are available only when the CA infrastructure is integrated with Active Directory. Additionally, only Enterprise CAs can issue certificates that enable smart card sign-in, because this process requires that smart card certificates are mapped automatically to the user accounts in Active Directory.

Stand-alone CAs do not require AD DS, and they do not use certificate templates. If you use stand-alone CAs, all information about the requested certificate type must be included in the certificate request. By default, all certificate requests that are submitted to stand-alone CAs are held in a pending queue until a CA administrator approves them. You can configure stand-alone CAs to issue certificates automatically upon request, but this is less secure, and it is usually not recommended because the requests are not authenticated.

You must use stand-alone CAs to issue certificates when you are using a non-Microsoft directory service or when AD DS is not available. You can use both enterprise and stand-alone certification authorities in your organization.

## Root CAs and subordinate CAs

Enterprise and stand-alone CAs can be configured as root CAs or as subordinate CAs. Subordinate CAs can further be configured as intermediate CAs (also referred to as a policy CA) or issuing CAs

A root CA is the CA that is at the top of a certification hierarchy. It must be trusted unconditionally by clients in your organization. All certificate chains terminate at a root CA. Whether you use enterprise or stand-alone CAs, you need to designate a root CA.

Since the root CA is the top CA in the certification hierarchy, the Subject field of the certificate that is issued by a root CA has the same value as the Issuer field of the certificate. Likewise, because the certificate chain terminates when it reaches a self-signed CA, all self-signed CAs are root CAs. The decision to designate a CA as a trusted root CA can be made at the enterprise level or locally by the individual IT administrator.

A root CA serves as the foundation upon which you base your certification authority trust model. It guarantees that the subject's public key corresponds to the identity information shown in the subject field of the certificates it issues. Different CAs might also verify this relationship by using different standards; therefore, it is important to understand the policies and procedures of the root certification authority before choosing to trust that authority to verify public keys.

The root CA is the most important CA in your hierarchy. If your root CA is compromised, all CAs in the hierarchy and all certificates issued from it are considered compromised. You can maximize the security of the root CA by keeping it disconnected from the network and by using subordinate CAs to issue certificates to other subordinate CAs or to end users. A disconnected root CA is also known as an Offline root CA.

CAs that are not root CAs are considered subordinate. The first subordinate CA in a hierarchy obtains its CA certificate from the root CA. This first subordinate CA can use this key to issue certificates that verify the integrity of another subordinate CA. These higher subordinate CAs are referred to as intermediate CAs. An intermediate CA is subordinate to a root CA, but it serves as a higher certifying authority to one or more subordinate CAs.

An intermediate CA is often referred to as a policy CA because it is typically used to separate classes of certificates that can be distinguished by policies. For example, policy separation includes the level of assurance that a CA provides or the geographical location of the CA to distinguish different end-entity populations. A policy CA can be online or offline.

## CA Private Keys

The private key is part of the CA identity, and it must be protected from compromise. Many organizations protect CA private keys by using a hardware security module (HSM). If an HSM is not used, the private key is stored on the CA computer.

Offline CAs should be stored in secure locations and not connected to the network. Issuing CAs use their private keys when issuing certificates, so the private key must be accessible (online) while the CA is in operation. In all cases, the CA and its private key on the CA should be physically protected.

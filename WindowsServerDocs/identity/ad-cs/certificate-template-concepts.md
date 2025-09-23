---
title: Certificate template concepts in Windows Server
description: This article describes certificate templates concepts for Active Directory Certificate Services in Windows Server.
author: Orin-Thomas
ms.topic: concept-article
ms.author: orthomas
ms.date: 02/18/2024
---

# Certificate templates concepts

Certificate templates can greatly simplify the task of administering an Active Directory Certificate Services (AD CS) certification authority (CA) by allowing an administrator to issue certificates preconfigured for selected tasks. The Certificate Templates snap-in allows an administrator to perform the following tasks:

- View properties for each certificate template.
- Copy and modify certificate templates.
- Control which users and computers can read templates and enroll for certificates.
- Perform other administrative tasks relating to certificate templates.

Certificate templates are the sets of rules and settings that are configured on a CA to be applied against incoming certificate requests. Certificate templates also give instructions to the client on how to create and submit a valid certificate request.

Only an enterprise CA can issue certificates based on a certificate template. The templates are stored in Active Directory Domain Services (AD DS) for use by every CA in the forest. This allows the CA to always have access to the current standard template and ensures consistent application of the certificate policy across the forest.

## Certificate template versions

Certificate template versions determine which features are available in a certificate template. Active Directory Certificate Services (AD CS) provides three versions of certificate templates that are available on enterprise certification authorities (CA).

- Version 1 certificate templates support general certificate needs and are compatible with all versions of AD CS from Windows 2000 onward. Version 1 templates are installed by default during CA setup and cannot be deleted. The only property that can be modified on a version 1 template is the set of assigned permissions that controls access to the template. Automatic enrollment is only supported for custom scripts and through group policy if using computer certificates. 
- Version 2 certificate templates were introduced with Windows Server 2003. An administrator can configure version 2 templates to control the way certificates are requested, issued, and used. Version 2 templates provide support for certificate autoenrollment.
- Version 3 certificate templates support all version 2 template features but also provide support for Suite B cryptographic algorithms. Suite B was created by the U.S. National Security Agency to specify cryptographic algorithms that must be used by U.S. government agencies to secure confidential information. Version 3 certificate templates are available through AD CS on all supported versions of Windows Server.

## Default certificate templates

A number of preconfigured certificate templates that are designed to meet the needs of most organizations are included with AD CS enterprise certification authorities (CAs). New certificate templates can be created by modifying a copy of an existing preconfigured template. The default certificate templates are described in the following table:

| Name | Description | Key usage | Subject type | Published to Active Directory Domain Services (AD DS)? | Template version |
|------|-------------|-----------|--------------|-------------------------------------------------------|------------------|
| Administrator | Allows trust list signing and user authentication. | Signature and encryption | User | Yes | 1 |
| Authenticated Session | Allows the subject to authenticate to a Web server. | Signature | User | No | 1 |
| Basic EFS | Used by Encrypting File System (EFS) to encrypt data. | Encryption | User | Yes | 1 |
| CA Exchange | Used to store keys that are configured for private key archival. | Encryption | Computer | No | 2 |
| CEP Encryption | Allows the certificate holder to act as a registration authority for Simple Certificate Enrollment Protocol (SCEP) requests. | Encryption | Computer | No | 1 |
| Code Signing | Used to digitally sign software. | Signature | User | No | 1 |
| Computer | Allows a computer to authenticate itself on the network. | Signature and encryption | Computer | No | 1 |
| Cross-Certification Authority | Used for cross-certification and qualified subordination. | Signature | Cross-certified CA | Yes | 2 |
| Directory E-mail Replication | Used to replicate e-mail within AD DS. | Signature and encryption | Computer | Yes | 2 |
| Domain Controller | Used by domain controllers as all-purpose certificates. | Signature and encryption | Computer | Yes | 1 |
| Domain Controller Authentication | Used to authenticate Active Directory computers and users. | Signature and encryption | Computer | No | 2 |
| EFS Recovery Agent | Allows the subject to decrypt files that were previously encrypted with EFS. | Encryption | User | No | 1 |
| Enrollment Agent | Used to request certificates on behalf of another subject. | Signature | User | No | 1 |
| Enrollment Agent (Computer) | Used to request certificates on behalf of another computer subject. | Signature | Computer | No | 1 |
| Exchange Enrollment Agent (Offline request) | Used to request certificates on behalf of another subject and supply the subject name in the request. | Signature | User | No | 1 |
| Exchange Signature Only | Used by the Microsoft Exchange Key Management Service to issue certificates to Exchange users for digitally signing e-mail. | Signature | User | No | 1 |
| Exchange User | Used by the Microsoft Exchange Key Management Service to issue certificates to Exchange users for encrypting e-mail. | Encryption | User | Yes | 1 |
| IPSEC | Used by Internet Protocol security (IPsec) to digitally sign, encrypt, and decrypt network communication. | Signature and encryption | Computer | No | 1 |
| IPSEC (Offline request) | Used by IPsec to digitally sign, encrypt, and decrypt network communication when the subject name is supplied in the request. | Signature and encryption | Computer | No | 1 |
| Kerberos Authentication | Used to authenticate Active Directory computers and users. | Signature and encryption | Computer | No | 2 |
| Key Recovery Agent | Recovers private keys that are archived on the CA. | Encryption | Key recovery agent | No | 2 |
| OCSP Response Signing | Used by an Online Responder to sign responses to certificate status requests. | Signature | Computer | No | 3 |
| RAS and IAS Server | Enables remote access servers and Internet Authentication Service (IAS) servers to authenticate their identity to other computers. | Signature and encryption | Computer | No | 2 |
| Root Certification Authority | Used to prove the identity of the root CA. | Signature | CA | No | 1 |
| Router (Offline request) | Used by a router when requested through a SCEP request from a CA that holds a CEP Encryption certificate. | Signature and encryption | Computer | No | 1 |
| Smartcard Logon | Allows the holder to authenticate by using a smart card. | Signature and encryption | User | No | 1 |
| Smartcard User | Allows the holder to authenticate and protect e-mail by using a smart card. | Signature and encryption | User | Yes | 1 |
| Subordinate Certification Authority | Used to prove the identity of the root CA. It is issued by the parent or root CA. | Signature | CA | No | 1 |
| Trust List Signing | Allows the holder to digitally sign a trust list. | Signature | User | No | 1 |
| User | Used by users for e-mail, EFS, and client authentication. | Signature and encryption | User | Yes | 1 |
| User Signature Only | Allows users to digitally sign data. | Signature | User | No | 1 |
| Web Server | Proves the identity of a Web server. | Signature and encryption | Computer | No | 1 |
| Workstation Authentication | Enables client computers to authenticate their identity to servers. | Signature and encryption | Computer | No | 2 |

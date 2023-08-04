---
title: What is Active Directory Certificate Services?
description: Overview of the Active Directory Certificate Services (AD CS) server role in Windows Server, including key features and next steps.
author: robinharwood
ms.author: wscontent
ms.topic: overview
ms.date: 03/20/2023
---

# What is Active Directory Certificate Services?

Active Directory Certificate Services (AD CS) is a Windows Server role for issuing and managing public key infrastructure (PKI) certificates used in secure communication and authentication protocols.

## Issue and manage certificates

Digital certificates can be used to encrypt and digitally sign electronic documents and messages as well as for authentication of computer, user, or device accounts on a network. For example, digital certificates are used to provide:

- Confidentiality through encryption.
- Integrity through digital signatures.
- Authentication by associating certificate keys with the computer, user, or device accounts on a computer network.

## Key features

AD CS provides the following important features:

- **Certification authorities:** Root and subordinate Certificate Authorities (CAs) are used to issue certificates to users, computers, and services, and to manage certificate validity.

- **Web enrollment:** Web enrollment allows users to connect to a CA with a Web browser in order to request certificates and retrieve certificate revocation lists (CRLs).

- **Online Responder:** The Online Responder service decodes revocation status requests for specific certificates, evaluates the status of these certificates, and sends back a signed response containing the requested certificate status information.

- **Network Device Enrollment Service:** The Network Device Enrollment Service allows routers and other network devices that don't have domain accounts to obtain certificates.

- **TPM key attestation:** Lets the certification authority verify the private key is protected by a hardware-based TPM and that the TPM is one that the CA trusts. TPM key attestation prevents the certificate from being exported to an unauthorized device and can bind the user identity to the device.

- **Certificate Enrollment Policy Web Service:** The Certificate Enrollment Policy Web Service enables users and computers to obtain certificate enrollment policy information.

- **Certificate Enrollment Web Service:** Certificate Enrollment Web Service enables users and computers to perform certificate enrollment through a web service. Together with the Certificate Enrollment Policy Web Service, this enables policy-based certificate enrollment when the client computer isn't a member of a domain or when a domain member isn't connected to the domain.

## Benefits

You can use AD CS to enhance security by binding the identity of a person, computer, or service to a
corresponding private key. AD CS gives you a cost-effective, efficient, and secure way to manage the
distribution and use of certificates. In addition to binding of identities and private keys, AD CS
also includes features that allow you to manage certificate enrollment and revocation.

You can use existing endpoint identity information in Active Directory to register certificates,
meaning you can have information automatically inserted into certificates. AD CS can also be used to
configure Active Directory group policies to designate which users and machines are allowed which
types of certificates. Group policy configuration enables role-based or attribute-based access
control.

Applications supported by AD CS include Secure/Multipurpose Internet Mail Extensions (S/MIME),
secure wireless networks, virtual private network (VPN), Internet Protocol security (IPsec),
Encrypting File System (EFS), smart card sign in, Secure Socket Layer/Transport Layer Security
(SSL/TLS), and digital signatures.

## Next steps

- [What is the Certification Authority Role Service?](certification-authority-role.md)
- [Implement and manage Active Directory Certificate Services](/training/modules/implement-manage-active-directory-certificate-services/)
- [All AD CS role services run on any version](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [All AD CS role services can be run on Server Core](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Windows PowerShell Reference for Certificate Services](/powershell/module/adcsdeployment)

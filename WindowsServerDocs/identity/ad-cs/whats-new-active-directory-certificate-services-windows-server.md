---
title: What is Active Directory Certificate Services in Windows Server?
description: Overview of Directory Certificate Services (AD CS) in Windows Server, including important functionality
author: robinharwood
ms.author: robinharwood
ms.topic: overview
ms.date: 02/27/2023
---

# What is Active Directory Certificate Services in Windows Server?

Applies To: Windows Server (All supported versions)

This article describes Active Directory Certificate Services (AD CS), including important functionality.

AD CS provides customizable services within Windows Server for issuing and managing on-premises public key infrastructure (PKI) certificates used in software security systems that employ public key technologies. These digital certificates can be used to encrypt and digitally sign electronic documents and messages as well as for authentication of computer, user, or device accounts on a network. For example, PKI certificates enable you to provide users confidentiality through encryption, enhance integrity using digital signatures, and authentication  by associating certificate keys with computer, user, or device accounts on a computer network. Digital certificates are used to provide:

- Confidentiality - through encryption
- Integrity - through digital signatures
- Authentication - by associating certificate keys with the computer, user, or device accounts on a computer network.

## Important features in AD CS

AD CS provides the following important features:

- Certification authorities (CAs). Root and subordinate CAs are used to issue certificates to users, computers, and services, and to manage certificate validity.
- Web enrollment. Web enrollment allows users to connect to a CA by means of a Web browser in order to request certificates and retrieve certificate revocation lists (CRLs).
- Online Responder. The Online Responder service decodes revocation status requests for specific certificates, evaluates the status of these certificates, and sends back a signed response containing the requested certificate status information.
- Network Device Enrollment Service. The Network Device Enrollment Service allows routers and other network devices that don't have domain accounts to obtain certificates.

## Real-world benefits for AD CS

You can use AD CS to enhance security by binding the identity of a person, device, or service to a corresponding private key. AD CS gives you a cost-effective, efficient, and secure way to manage the distribution and use of certificates.

In addition to binding of identities and private keys, AD CS also includes features that allow you to manage certificate enrollment and revocation in a variety of scalable environments.

You can leverage existing endpoint identity information in Active Directory to register for certificates. This means that users and computers registered to your Active Directory can have user information automatically inserted into certificates.

AD CS can also be used to configure Active Directory group policies to designate which users and machines are allowed which types of certificates. Group policy configuration enables role-based or attribute-based access control.

Applications supported by AD CS include Secure/Multipurpose Internet Mail Extensions (S/MIME), secure wireless networks, virtual private network (VPN), Internet Protocol security (IPsec), Encrypting File System (EFS), smart card logon, Secure Socket Layer/Transport Layer Security (SSL/TLS), and digital signatures.

## Important functionality

### Server Manager information

The installation of AD CS role services can be performed through the Server Manager. The following role services can be installed:

| **Role service** | **Description** |
| --- | --- |
| Certification Authority (CA) | Root and subordinate CAs are used to issue certificates to users, computers, and services, and to manage certificate validity. |
| --- | --- |
| Web Enrollment | CA Web enrollment allows users to connect to a CA by means of a Web browser in order to request certificates and retrieve certificate revocation lists (CRLs). |
| Online Responder | The Online Responder service decodes revocation status requests for specific certificates, evaluates the status of these certificates, and sends back a signed response containing the requested certificate status information. |
| Network Device Enrollment Service | The Network Device Enrollment Service (NDES) allows routers and other network devices that don't have domain accounts to obtain certificates. |
| Certificate Enrollment Policy Web Service | The Certificate Enrollment Policy Web Service enables users and computers to obtain certificate enrollment policy information. |
| Certificate Enrollment Web Service | The Certificate Enrollment Web Service is an Active Directory Certificate Services (AD CS) role service that enables users and computers to perform certificate enrollment by using the HTTPS protocol. When used together, the Certificate Enrollment Web Service and the Certificate Enrollment Policy Web Service enable policy-based certificate enrollment for

- domain member computers not connected to the domain
- computers that are not domain members |

### TPM key attestation

TPM key attestation is important functionality that lets the certification authority (CA) verify the private key is protected by a hardware-based TPM and that the TPM is one that the CA trusts. This functionality prevents the certificate from being exported to an unauthorized device, and can bind the user identity to the device.

All TPMs have an endorsement key that's unique to each TPM. In some cases, TPMs have an endorsement key certificate that chains to the manufacturer's issuing CA. Not all TPMs support attestation but when they do, you can optionally choose to validate the key attestation by using the endorsement key, or by using an endorsement key certificate.

To use TPM key attestation, the client operating system must be Windows 8.1 or Windows Server 2012 R2. To configure TPM key attestation, use a version 4 certificate template with an enterprise CA, and configure the settings on the  **Key Attestation**  tab. Don't select  **Don't store certificate and requests in the CA database**  on the  **Server**  tab of the certificate template properties, because this configuration isn't supported with TPM key attestation. In addition, standalone CAs and web enrollment don't support TPM key attestation.

When you configure TPM key attestation, you can choose increasing levels of assurance by specifying how to validate the endorsement key that's burned into the TPM by the manufacturer:

- **User credentials**. No additional configuration is required on the CA.
- **Endorsement certificate**. You must add the root and issuing CA certificates for the TPMs to new certificate stores on the CA. The new certificate stores are EKCA for the intermediate store, and EKRROT for the root store.
- **Endorsement key**. You must add each endorsement key for the TPMs to an approved list (EKPUB list).

  **Tip**

If the settings on the  **Key Attestation tab**  are not available, verify the following settings:

For more information, see the following resources:

- The [Key attestation](https://technet.microsoft.com/JJ889441) section in the [TPM Fundamentals [Windows 8]](https://technet.microsoft.com/library/JJ889441) topic
- [TPM Key Attestation](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn581921(v=ws.11))

New Windows PowerShell cmdlets are available in Windows Server 2012 R2. You can use these cmdlets to back up and restore a certification authority (CA) database.

| **Cmdlet name** | **New or improved** | **Description** |
| --- | --- | --- |
| Backup-CARoleService | New | Back up the CA database. |
| --- | --- | --- |
| Restore-CARoleService | New | Restore the CA database. |

For more information about these cmdlets, see [Backup-CARoleService](https://technet.microsoft.com/library/dn440704(v=wps.630).aspx) and [Restore-CARoleService](https://technet.microsoft.com/library/dn440703(v=wps.630).aspx).

To use these cmdlets in a migration scenario, see the following sections from [Active Directory Certificate Services Migration Guide for Windows Server 2012 R2](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn486797(v=ws.11)):

- [Backing up a CA database and private key](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn486805(v=ws.11))
- [Restoring the CA database and configuration on the destination server](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn486805(v=ws.11))

## Additional key AD CS functionality, including links to further guidance

- [Policy module support for the Network Device Enrollment Service](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Windows PowerShell for Certificate Services](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Integration with Server Manager](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Deployment and management capabilities from Windows PowerShell](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [All AD CS role services run on any version](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [All AD CS role services can be run on Server Core](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Support for key-based renewal](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Certificate template compatibility](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Support for certificate renewal with same key](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Support for internationalized domain names](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Increased security enabled by default on the CA role service](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [AD DS site awareness for AD CS and PKI clients](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Group-protected PFX format](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [Certificate lifecycle notifications](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))
- [CA private keys are included in the System State Backup image](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473011(v=ws.11))

## Related links

The following table provides additional resources for evaluating AD CS.

| **Content type** | **References** |
| --- | --- |
| **Product evaluation** | - [Test Lab Guide: Deploying an AD CS Two Tier PKI Hierarchy](https://go.microsoft.com/fwlink/?linkid=240233)
     - [Test Lab Guide: Demonstrating Key-Based Renewal](https://go.microsoft.com/fwlink/?linkid=242185)
     - [Test Lab Guide Mini-Module: Cross-Forest Certificate Enrollment using Certificate Enrollment Web Services](https://aka.ms/certxforest) |
| --- | --- |
| **Community resources** | - Community directory for documentation and information: [Windows PKI Documentation Reference and Library](https://aka.ms/pkilibrary)
     - Frequently asked questions (FAQs) list [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)
     - Support forum: [Windows Server Security Forum](https://aka.ms/adcsforum)
     - Product team blog: [Windows PKI Blog](https://blogs.technet.com/b/pki/)
     - Support Team Blog: [Ask the Directory Services team](https://blogs.technet.com/b/askds/)
     - Script repository: [TechNet Script Center Repository](https://gallery.technet.microsoft.com/scriptcenter) search for Certification, Certificate, or PKI.
     - Community technology overview: [Active Directory Certificate Services (AD CS) Overview](https://social.technet.microsoft.com/wiki/contents/articles/1137.aspx) |
| **Related technologies** | [Active Directory Domain Services](https://www.microsoft.com/server-cloud/windows-server/active-directory-overview.aspx)

  [Active Directory Rights Management Services](https://www.microsoft.com/server-cloud/windows-server/active-directory-overview.aspx)

  [Active Directory Federation Services](https://www.microsoft.com/server-cloud/windows-server/active-directory-overview.aspx)

  [Active Directory Lightweight Directory Services](https://www.microsoft.com/server-cloud/windows-server/active-directory-overview.aspx) |
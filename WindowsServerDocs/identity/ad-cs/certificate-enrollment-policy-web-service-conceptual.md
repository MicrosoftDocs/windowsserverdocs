---
title: Certificate Enrollment Policy Web Service Guidance
description: Learn more about Certificate Enrollment Policy Web Service, including Server Manager configuration and authentication options 
author: robinharwood
ms.topic: overview
ms.author: gswashington
ms.date: 09/21/2023
---

# Certificate Enrollment Policy Web Service guidance

Applies To: Windows Server 2012 R2, Windows Server 2012

The Certificate Enrollment Policy Web Service enables users and computers to obtain certificate enrollment policy information even when the computer is not a member of a domain or if a domain-joined computer is temporarily outside the security boundary of the corporate network. The Certificate Enrollment Policy Web Service works with the Certificate Enrollment Web Service to provide policy-based automatic certificate enrollment for these users and computers. The Certificate Enrollment Policy Web Service service utilizes an enrollment protocol based on WS-Trust Jump. WS-Trust Jump enables certificate policy retrieval, certificate enrollment, and certificate renewal using hypertext transfer protocol (HTTP) over secure sockets layer / transport layer security (SSL/TLS) encryption (HTTPS). 

The Certificate Enrollment Policy Web Service communicates with AD DS, using standard Lightweight Directory Access Protocol (LDAP) and secure LDAP (LDAPS) ports (TCP 389 and 636 respectively). The Certificate Enrollment Policy Web Service runs using the credentials of the Internet Information Services (IIS) DefaultAppPool (ApplicationPoolIdentity) by default. The account used is not configurable during role installation, but can be modified using IIS manager after installation. See [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx) for more detailed information including deployment considerations and example configurations.

This document provides information for the Server Manager configuration pages for the Certificate Enrollment Policy Web Service. For an overview of the service and its installation requirements, see [Certificate Enrollment Web Service Guidance](hh831822\(v=ws.11\).md). For more information about the Certificate Enrollment Web Service and the Certificate Enrollment Policy Web Service, see [Certificate Enrollment Web Services](https://go.microsoft.com/fwlink/?linkid=258862).

This article also provides guidance for authentication types that are presented when you use Server Manager to install the Certificate Enrollment Policy Web Service.

## Set the authentication type for Certificate Enrollment Policy Web Service

Clients that communicate with the Certificate Enrollment Policy Web Service must use one of the following authentication types:

- Windows integrated authentication, also known as Kerberos authentication

- Client certificate authentication, also known as X.509 certificate authentication

- User name and password authentication

> [!NOTE]
>
- If you want to configure key-based renewal, you must enable user name and password authentication or client certificate authentication.
- Anonymous authentication to the web services is not supported.

## Determine whether to enable key-based renewal for Certificate Enrollment Policy Web Service

Key-based renewal mode is a feature introduced in Windows Server 2012 that allows an existing valid certificate to be used to authenticate a certificate renewal request. This enables computers that aren't connected directly to the internal network the ability to automatically renew an existing certificate. To take advantage of this feature, the certificate client computers must be running at least Windows 8 or Windows Server 2012.

> [!NOTE]
> When key-based renewal mode is enabled for the Certificate Enrollment Policy Web Service, it won't accept requests for new certificates. You can install multiple instances of the Certificate Enrollment Policy Web Service on Windows Server 2012, but you must use the Windows PowerShell[Install-AdcsEnrollmentPolicyWebService](https://technet.microsoft.com/library/hh848384.aspx) to install additional instances.

## Server Certificate

The Certificate Enrollment Web Service and the Certificate Enrollment Policy Web Service must use Secure Sockets Layer (SSL) for communication with clients (by using HTTPS). Each service must have a valid certificate that has an enhanced key usage (EKU) policy of Server Authentication in the local computer certificate store.

> [!NOTE]
> If you haven't yet provided an SSL certificate to the server that is hosting the Certificate Enrollment Web Service, you can do so by following the instructions in the article [Configure SSL/TLS on a Web site in the domain with an Enterprise CA](https://social.technet.microsoft.com/wiki/contents/articles/12485.configure-ssltls-on-a-web-site-in-the-domain-with-an-enterprise-ca.aspx).

## Related content

- [Certificate Enrollment Web Service Guidance](hh831822\(v=ws.11\).md)

- [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx)

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)
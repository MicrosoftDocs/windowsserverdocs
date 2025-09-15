---
title: Certificate Enrollment Policy Web Service overview
description: Learn more about Certificate Enrollment Policy Web Service, including Server Manager configuration and authentication options. 
author: robinharwood
ms.topic: concept-article
ms.author: roharwoo
ms.date: 02/14/2025
#customer intent: As an IT administrator, I want to understand the configuration and authentication options for the Certificate Enrollment Policy Web Service so that I can properly set it up and manage it.
---

# Certificate Enrollment Policy Web Service overview

The Certificate Enrollment Policy Web Service lets users and computers obtain certificate enrollment policy information even when the computer isn't a member of a domain, or if the computer is domain-joined but temporarily outside of the secure corporate network. The Certificate Enrollment Policy Web Service works with the Certificate Enrollment Web Service to provide policy-based automatic certificate enrollment for these users and computers. The Certificate Enrollment Policy Web Service uses an enrollment protocol based on WS-Trust Jump. WS-Trust Jump enables certificate policy retrieval, certificate enrollment, and certificate renewal using hypertext transfer protocol (HTTP) over a secure sockets layer or transport layer security (SSL/TLS) encryption (HTTPS).

The Certificate Enrollment Policy Web Service communicates with Active Directory Domain Services (AD DS) using standard Lightweight Directory Access Protocol (LDAP) and the secure LDAP (LDAPS) ports, TCP 389, and TCP 636. The Certificate Enrollment Policy Web Service uses the credentials of the Internet Information Services (IIS) DefaultAppPool (ApplicationPoolIdentity) by default. You can't configure the account during role installation, but you can modify it using IIS manager after installation.

This article describes types of authentication you can use when configuring the Certificate Enrollment Policy Web Service in Server Manager. This article also describes the authentication options that Server Manager presents you when you use it to install the Certificate Enrollment Policy Web Service.

## Authentication types

Clients that communicate with the Certificate Enrollment Policy Web Service must use one of the following authentication types:

- Windows integrated authentication

- Client certificate authentication

- Username and password authentication

> [!NOTE]
> If you want to configure key-based renewal, you must enable username and password authentication or client certificate authentication.
> The Certificate Enrollment Policy Web Service doesn't support anonymous authentication.

## Key-based renewal

Key-based renewal mode allows an existing valid certificate to be used to authenticate a certificate renewal request. This feature allows computers that aren't connected directly to the internal network to automatically renew an existing certificate.

> [!NOTE]
> When you enable key-based renewal mode for the Certificate Enrollment Policy Web Service, the service doesn't accept requests for new certificates. You can install multiple instances of the Certificate Enrollment Policy Web Service on Windows Server, but you must use the [Install-AdcsEnrollmentPolicyWebService](/powershell/module/adcsdeployment/install-adcsenrollmentpolicywebservice) PowerShell cmdlet to install and configure new instances.

## Server certificate

The Certificate Enrollment Web Service and the Certificate Enrollment Policy Web Service must use Secure Sockets Layer (SSL) for communication with clients, which they can accomplish by using HTTPS. Each service must have a valid certificate with an enhanced key usage (EKU) policy of Server Authentication in the local computer certificate store.

> [!NOTE]
> If you haven't provided an SSL certificate to the server hosting the Certificate Enrollment Web Service yet, follow the instructions in [Configure SSL/TLS on a Web site in the domain with an Enterprise CA](https://social.technet.microsoft.com/wiki/contents/articles/12485.configure-ssltls-on-a-web-site-in-the-domain-with-an-enterprise-ca.aspx).

## Related content

- [Certificate Enrollment Web Service Guidance](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831822(v=ws.11))

- [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)


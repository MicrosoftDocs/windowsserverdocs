---
title: Request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server
description: Learn how to request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server.
author: gswashington
ms.topic: quickstart
ms.author: orthomas
ms.date: 09/09/2023
---

# Request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server

This article shows you how to request a certificate using the Certification Authority (CA) Web Enrollment Role Service in Windows Server. The CA Web Enrollment role service provides a set of web pages that allow interaction with the Certification Authority role service. See [Certification Authority Web Enrollment Guidance](/certification-authority-role.md) for more information about the CA Web Enrollment role service.

## Prerequisites

- Computer with Certificate Enrollment Web Service is installed that is a member of the domain and running Windows Server.
- Client computers must be running Windows or Windows Server.

## Request a basic certificate using Internet Explorer

1. In Internet Explorer, connect to `https://<servername>/certsrv`, where `<servername>` is the host name of the computer running the CA Web Enrollment role service.

1. Select **Request a certificate**.

1  On **Request a Certificate**, select **User Certificate**.

1. On the **User Certificate Identifying Information** page, do one of the following:

      - Comply to the message "No further identifying information is required. To complete your certificate, select Submit."

      - Enter your identifying information for the certificate request.

1. (Optional) Click **More Options** to specify the cryptographic service provider (CSP) and choose if you want to enable strong private key protection. (You receive a prompt every time you use the private key that is associated with the certificate.)

1. Select **Submit**.

1. Do one of the following:

      - If you see the **Certificate Pending** page, the CA administrator will have to approve the request before you can retrieve and install the certificate.

      - If you see the **Certificate Issued** page, select **Install this certificate**.

### Request a certificate with advanced options

#### To use Internet Explorer to create an advanced certificate request

1. In Internet Explorer, connect to `https://<servername>/certsrv`, where `<servername>` is the host name of the computer running the CA Web Enrollment role service.

1. Select **Request a certificate**.

1. Select **Advanced certificate request**.

1. Select **Create and submit a certificate request to this CA**.

1. Fill in the requested identifying information and other options that you require.

1. Select **Submit**.

1. Do one of the following:

      - If you see the **Certificate Pending** page, the CA administrator will have to approve the request before you can retrieve and install the certificate.

      - If you see the **Certificate Issued** page, select **Install this certificate**.

### Check a pending certificate request

#### To check a pending certificate request using Internet Explorer

1. In Internet Explorer, open `https://<servername>/certsrv`, where `<servername>` is the hostname of the computer running the CA Web Enrollment role service.

1. Select **View the status of a pending certificate request**.

1. If there are no pending certificate requests, a message appears confirm this. Otherwise, select the certificate request that you want to check, and select **Next**.

1. Check the following pending certificate requests:

      - **Still pending**. You must wait for the administrator of the certification authority to issue the certificate. To remove the certificate request, select **Remove**.

      - **Issued**. To install the certificate, select **Install this certificate**.

      - **Denied**. Contact the administrator of the certification authority for further information.

## Next steps

- [Certification Authority Web Enrollment Guidance](/certification-authority-role.md)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)
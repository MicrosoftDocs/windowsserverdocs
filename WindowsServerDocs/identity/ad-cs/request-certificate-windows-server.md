---
title: Request certificates using Web Enrollment in AD CS
description: Learn how to request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server.
author: gswashington
ms.topic: how-to
ms.author: wscontent
ms.date: 09/04/2023
---

# Request a certificate using Certification Authority Web Enrollment

This article shows you how to request a certificate using the Certification Authority (CA) Web Enrollment Role Service in Windows Server. The CA Web Enrollment role service provides a set of web pages that allow interaction with the Certification Authority role service. To learn more about Certification Authority Web Enrollment, see [What is the Certification Authority Role Service?](certification-authority-role.md).

## Prerequisites

Before you can submit a request, you must meet the following requirements:

- Have a server that is a domain member with the Certificate Enrollment Web Service installed.
- Client computers must be running Windows or Windows Server.

## Request a basic certificate

1. Using a web browser, connect to `https://<servername>/certsrv`, where `<servername>` is the host name of the computer running the CA Web Enrollment role service.

1. Select **Request a certificate**.

1. On the **Request a Certificate** page, select **User Certificate**.

1. On the **User Certificate Identifying Information** page, do one of the following:

      - Comply with the message "No further identifying information is required. To complete your certificate, select Submit."

      - Enter your identifying information for the certificate request.

1. (Optional) Select **More Options** to specify the cryptographic service provider (CSP) and choose if you want to enable strong private key protection. You receive a prompt every time you use the private key that is associated with the certificate.

1. Select **Submit**.

1. If you see the **Certificate Issued** web page, select **Download certificate chain**. Choose to save the file to your hard disk drive, and then import the certificate into your certificate store.

If you see the **Certificate Pending** web page, you can check the status of your request in the [Check a pending certificate request](#check-a-pending-certificate-request) section.

## Request a certificate with advanced options

1. Using a web browser, connect to `https://<servername>/certsrv`, where `<servername>` is the host name of the computer running the CA Web Enrollment role service.

1. Select **Request a certificate**.

1. Select **Advanced certificate request**.

1. Select **Create and submit a certificate request to this CA**.

1. Fill in the requested identifying information and other options that you require.

1. Select **Submit**.

1. If you see the **Certificate Issued** web page, select **Download certificate chain**. Choose to save the file to your hard disk drive, and then import the certificate into your certificate store.

If you see the **Certificate Pending** web page, you can check the status of your request in the following section.

### Check a pending certificate request

1. Using a web browser, open `https://<servername>/certsrv`, where `<servername>` is the hostname of the computer running the CA Web Enrollment role service.

1. Select **View the status of a pending certificate request**.

1. If there are no pending certificate requests, a message appears to confirm there are no pending request. Otherwise, select the certificate request that you want to check, and select **Next**.

1. Check the following pending certificate requests:

      - **Still pending**. You must wait for the administrator of the certification authority to issue the certificate. To remove the certificate request, select **Remove**.

      - **Issued**. To install the certificate, select **Install this certificate**.

      - **Denied**. Contact the administrator of the certification authority for further information.

## Next steps

- [What is the Certification Authority Role Service?](certification-authority-role.md)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

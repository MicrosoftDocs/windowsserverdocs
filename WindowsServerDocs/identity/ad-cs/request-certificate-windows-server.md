---
title: Request Certificates Using Web Enrollment in Active Directory Certificate Services
description: Request certificates easily with basic or advanced options using the Certification Authority Web Enrollment Role Service. Follow this guide to get started.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.date: 04/28/2025
#customer intent: As a security administrator, I want to know how to request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server.
---

# Request a certificate using Certification Authority Web Enrollment

This article explains how to request certificates using the Certification Authority (CA) Web Enrollment Role Service in Windows Server. The CA Web Enrollment role service provides web pages to interact with the Certification Authority role service. Learn more about the Certification Authority Web Enrollment role service in [What is the Certification Authority role service?](certification-authority-role.md).  

## Prerequisites

Before you can submit a request, you must meet the following requirements:

- Have a server that is a domain member with the Certificate Enrollment Web Service installed.
- Client computers must be running Windows or Windows Server.

## Request a basic certificate

1. Using a web browser, connect to `https://<servername>/certsrv`, where `<servername>` is the host name of the computer running the CA Web Enrollment role service.

1. Select **Request a certificate**.

1. On the **Request a Certificate** page, select **User Certificate**.

1. On the **User Certificate Identifying Information** page, follow one of these steps:  

      - If the message "No further identifying information is required. To complete your certificate, select Submit." appears, select **Submit**.  

      - Enter your identifying information for the certificate request.  

1. (Optional) Select **More Options** to specify the cryptographic service provider (CSP) and enable strong private key protection if needed. You receive a prompt every time you use the private key that is associated with the certificate.

1. Select **Submit**.

1. If you see the **Certificate Issued** web page, select **Download certificate chain**. Save the file to your hard disk drive, then import the certificate into your certificate store.  

If you see the **Certificate Pending** web page, check the status of your request in the [Check a pending certificate request](#check-a-pending-certificate-request) section.  

## Request a certificate with advanced options

1. Open a web browser and go to `https://<servername>/certsrv`, where `<servername>` is the hostname of the computer running the CA Web Enrollment role service.  

1. Select **Request a certificate**.

1. Select **Advanced certificate request**.

1. Select **Create and submit a certificate request to this CA**.

1. Fill in the requested identifying information and other options that you require.

1. Select **Submit**.

1. If you see the **Certificate Issued** web page, select **Download certificate chain**. Save the file to your hard disk drive, then import the certificate into your certificate store.  

If you see the **Certificate Pending** web page, you can check the status of your request in the following section.

### Check a pending certificate request

1. Using a web browser, open `https://<servername>/certsrv`, where `<servername>` is the hostname of the computer running the CA Web Enrollment role service.

1. Select **View the status of a pending certificate request**.

1. If there are no pending certificate requests, a message confirms there are no pending requests. Otherwise, select the certificate request that you want to check, and select **Next**.

1. Check the following pending certificate requests:

      - **Still pending**. Wait for the certification authority administrator to issue the certificate. To remove the certificate request, select **Remove**.

      - **Issued**. To install the certificate, select **Install this certificate**.

      - **Denied**. Contact the administrator of the certification authority for further information.

## Related content

- [What is the Certification Authority Role Service?](certification-authority-role.md)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

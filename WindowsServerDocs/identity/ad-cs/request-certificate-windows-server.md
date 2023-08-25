---
title: Request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server
description: Learn how to request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server.
author: gswashington
ms.topic: how-to
ms.author: orthomas
ms.date: 09/09/2023
---

# Request a certificate using the Certification Authority Web Enrollment Role Service in Windows Server

Applies To: Windows Server 2012 R2, Windows Server 2012

### Request a basic certificate

##### To use Internet Explorer to request a basic certificate

1. In Internet Explorer, connect to https://\<servername\>/certsrv, where \<servername\> is the host name of the computer running the CA Web Enrollment role service.

1. Click **Request a certificate**.

1  On **Request a Certificate**, click **User Certificate**.

1. On the **User Certificate Identifying Information** page, do one of the following:

      - Comply to the message "No further identifying information is required. To complete your certificate, press Submit."

      - Enter your identifying information for the certificate request.

1. (Optional) Click **More Options** to specify the cryptographic service provider (CSP) and choose if you want to enable strong private key protection. (You receive a prompt every time you use the private key that is associated with the certificate.)

1. Click **Submit**.

1. Do one of the following:

      - If you see the **Certificate Pending** page, the CA administrator will have to approve the request before you can retrieve and install the certificate.

      - If you see the **Certificate Issued** page, click **Install this certificate**.

### Request a certificate with advanced options

##### To use Internet Explorer to create an advanced certificate request

1. In Internet Explorer, connect to https://\<servername\>/certsrv, where \<servername\> is the host name of the computer running the CA Web Enrollment role service.

1. Click **Request a certificate**.

1. Click **Advanced certificate request**.

1. Click **Create and submit a certificate request to this CA**.

1. Fill in the requested identifying information and other options that you require.

1. Click **Submit**.

1. Do one of the following:

      - If you see the **Certificate Pending** page, the CA administrator will have to approve the request before you can retrieve and install the certificate.

      - If you see the **Certificate Issued** page, click **Install this certificate**.

### Check a pending certificate request

#### To check a pending certificate request using Internet Explorer

1. In Internet Explorer, open https://\<servername\>/certsrv, where \<servername\> is the hostname of the computer running the CA Web Enrollment role service.

1. Click **View the status of a pending certificate request**.

1. If there are no pending certificate requests, you will see a message to that effect. Otherwise, select the certificate request that you want to check, and click **Next**.

1. Check the following pending certificate requests:

      - **Still pending**. You must wait for the administrator of the certification authority to issue the certificate. To remove the certificate request, click **Remove**.

      - **Issued**. To install the certificate, click **Install this certificate**.

      - **Denied**. Contact the administrator of the certification authority for further information.

## Related content

- [You cannot download CA certificate from web enrollment pages](https://social.technet.microsoft.com/wiki/contents/articles/you-cannot-download-ca-certificate-from-web-enrollment-pages.aspx)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Windows Server Security Forum](https://aka.ms/adcsforum)

  - [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

  - [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

  - [Windows PKI Blog](https://blogs.technet.com/b/pki/)


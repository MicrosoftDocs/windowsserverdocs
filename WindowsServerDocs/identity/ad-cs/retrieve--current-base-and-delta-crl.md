---
title: Retrieve the current base and delta CRLs in Certification Authority Web Enrollment role service
description: Learn how to retrieve the current base and delta CRLs in CA Web Enrollment role service
author: gswashington
ms.author: wscontent
ms.topic: overview
ms.date: 09/09/2023

---

# Retrieve the current base and delta CRLs in Certification Authority Web Enrollment role service

>Applies To: Windows Server 2012 R2, Windows Server 2012

This article shows you how to retrive current base and delta CRLs in Certification Authority (CA) Web Enrollment role service. The CA Web Enrollment role service provides a set of web pages that allow interaction with the Certification Authority role service. See [Certification Authority Web Enrollment Guidance](/certification-authority-role.md) for more information about the CA Web Enrollment role service.

## To retrieve a certificate revocation list by using Internet Explorer

1.  In Internet Explorer, connect to https://\<servername\>/certsrv, where \<servername\> is the name of the computer running the CA Web Enrollment role service.

2.  Click **Download a CA certificate, certificate chain, or CRL**.

3.  Click the encoding method that you want to use for the CRL, **DER** or **Base 64**.

4.  Do one of the following:

      - Click **Download CA certificate**.

      - Click **Download CA certificate chain**.

      - Click **Download latest base CRL**.

      - Click **Download latest delta CRL**.


        > [!NOTE]
        > <BR>The latest base CRL must already be installed for the delta CRL to function.


5.  When the **File Download** dialog box appears, click **Save**. Select a folder on your computer to store the .crl file, and then click **Save**.

6.  Open Windows Explorer and locate the .crl file you just saved.

7.  Right-click the .cer or .crl file and click **Install Certificate** or **Install CRL**, and then click **Next**.

8.  When the Certificate Import Wizard opens, click **Automatically select the certificate store based on the type of certificate**.

## Next steps

For more information about Web Enrollment and troubleshooting common issues, see the following articles:

- [You cannot download CA certificate from web enrollment pages](https://social.technet.microsoft.com/wiki/contents/articles/you-cannot-download-ca-certificate-from-web-enrollment-pages.aspx)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)
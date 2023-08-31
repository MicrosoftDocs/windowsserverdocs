---
title: Retrieve the current base and delta CRLs in Certification Authority Web Enrollment role service
description: Learn how to submit a certificate in CA Web Enrollment role service by using a PKCS \#10 file or a PKCS \#7 file
author: gswashington
ms.author: wscontent
ms.topic: quickstart
ms.date: 09/09/2023

---

# Submit a certificate request by using a PKCS \#10 file or a PKCS \#7 file

This article shows you how to submit a certificate in CA Web Enrollment role service by using a PKCS \#10 file or a PKCS \#7 file. The CA Web Enrollment role service provides a set of web pages that allow interaction with the Certification Authority role service. See [Certification Authority Web Enrollment Guidance](/certification-authority-role.md) for more information about the CA Web Enrollment role service.

## Prerequisites

- Computer with Certificate Enrollment Web Service is installed that is a member of the domain and running Windows Server.
- Client computers must be running Windows or Windows Server.

## To submit a certificate request by using a PKCS \#10 or PKCS \#7 file by using Internet Explorer

1. In Internet Explorer, connect to `https://<servername>/certsrv`, where `<servername>` is the name of the computer running the CA Web Enrollment role service.

1. Select **Request a certificate**, and then click **Advanced certificate request**.

1. Select **Submit a certificate request using a base-64-encoded CMC or PKCS \#10 file, or submit a renewal request by using a base-64-encoded PKCS \#7 file**.

1. In Notepad, select **File**, select **Open**, select the PKCS \#10 or PKCS \#7 file, select **Edit**, select **Select all**, select **Edit**, and then select **Copy**. On the Web page, select the **Saved request** scroll box. Select **Edit**, and then select **Paste** to paste the contents of certificate request into the scroll box.

1. If you are connected to an enterprise CA, choose the certificate template that you want to use. By default, the appropriate template is named **Subordinate Certification Authority**.

1. If you have any attributes to add to the certificate request, enter them into **Additional Attributes**.

1. Select **Submit**.

1. Do one of the following:

    1. If you see the **Certificate Pending** web page, see [Check a pending certificate request]() earlier in this document.

    1. If you see the **Certificate Issued** web page, select **Download certificate chain**. Choose to save the file to your hard disk drive, and then import the certificate into your certificate store.

## Next steps

- [Certification Authority Web Enrollment Guidance](/certification-authority-role.md)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)
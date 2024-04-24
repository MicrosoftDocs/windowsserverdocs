---
title: "Submit certificate requests to AD CS using a PKCS #10 or PKCS #7 file in Windows Server"
description: "Learn how to submit a certificate in CA Web Enrollment role service by using a PKCS #10 file or a PKCS #7 file in Windows Server"
author: gswashington
ms.author: wscontent
ms.topic: how-to
ms.date: 09/09/2023

---

# Submit certificate requests using a PKCS #10 or a PKCS #7 file

This article shows you how to submit a certificate in Certification Authority (CA) Web Enrollment role service by using a PKCS #10 file or a PKCS #7 file. The CA Web Enrollment role service provides a set of web pages that allow interaction with the Certification Authority role service. For more information about the CA Web Enrollment role service, see [Certification Authority Web Enrollment Guidance](certification-authority-role.md).

## Prerequisites

Before you can submit a request, you must meet the following requirements:

- Have a server that is a domain member with the Certificate Enrollment Web Service installed.
- Client computers must be running Windows or Windows Server.

## Submit a certificate request by using a PKCS #10 or PKCS #7 file

1. Using a web browser, connect to `https://<servername>/certsrv`, where `<servername>` is the name of the computer running the CA Web Enrollment role service.

1. Select **Request a certificate**, and then select **Advanced certificate request**.

1. Select **Submit a certificate request using a base-64-encoded CMC or PKCS #10 file, or submit a renewal request by using a base-64-encoded PKCS #7 file**.

1. In Notepad, select **File**, select **Open**, select the PKCS #10 or PKCS #7 file.

1. Select **Edit**, select **Select all**, select **Edit**, and then select **Copy**.

1. Return to the web page, select the **Saved request** scroll box. Select **Edit**, and then select **Paste** to paste the contents of certificate request into the scroll box.

1. If you're connected to an enterprise CA, choose the certificate template that you want to use. By default, the appropriate template is named **Subordinate Certification Authority**.

1. If you have any attributes to add to the certificate request, enter them into **Additional Attributes**.

1. Select **Submit**.

1. If you see the **Certificate Issued** web page, select **Download certificate chain**. Choose to save the file to your hard disk drive, and then import the certificate into your certificate store.

If you see the **Certificate Pending** web page, you can check the status of your request in the following section.

## Check pending certificate requests

1. Using a web browser, open `https://<servername>/certsrv`, where `<servername>` is the hostname of the computer running the CA Web Enrollment role service.

1. Select **View the status of a pending certificate request**.

1. If there are no pending certificate requests, a message appears to confirm there are no request. Otherwise, select the certificate request that you want to check, and select **Next**.

1. Check the following pending certificate requests:

      - **Still pending**. You must wait for the administrator of the certification authority to issue the certificate. To remove the certificate request, select **Remove**.

      - **Issued**. To install the certificate, select **Install this certificate**.

      - **Denied**. Contact the administrator of the certification authority for further information.

## Next steps

- [Certification Authority Web Enrollment Guidance](certification-authority-role.md)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

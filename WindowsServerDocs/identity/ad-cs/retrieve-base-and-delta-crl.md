---
title: Retrieve base & delta CRLs using Web Enrollment in AD CS
description: Learn how to retrieve the current base and delta certificate revocation lists (CRLs) using Certification Authority Web Enrollment role service in Windows Server
author: gswashington
ms.author: wscontent
ms.topic: how-to
ms.date: 09/04/2023
---

# Retrieve base and delta CRLs using Certification Authority Web Enrollment

This article shows you how to retrieve the current base and delta certificate revocation lists (CRLs) using the Certification Authority (CA) Web Enrollment role service. The CA Web Enrollment role service provides a set of web pages that allow interaction with the Certification Authority role service. To learn more about Certification Authority Web Enrollment, see [What is the Certification Authority Role Service?](certification-authority-role.md).

## Prerequisites

Before you can retrieve base and delta CRLs, your computer must meet the following requirements:

- Have a server that is a domain member with the Certificate Enrollment Web Service installed.
- Client computers must be running Windows or Windows Server.

## Retrieve a certificate revocation list by using a web browser

1. Open your web browser and connect to `https://<servername>/certsrv`, where `<servername>` is the name of the server running the CA Web Enrollment role service.

1. Select **Download a CA certificate, certificate chain, or CRL**.

1. Select the encoding method that you want to use for the CRL, **DER** or **Base 64**.

1. Select one of the following actions:

   - **Download CA certificate**.

   - **Download CA certificate chain**.

   - **Download latest base CRL**.

   - **Download latest delta CRL**.

   > [!NOTE]
   > The latest base CRL must already be installed for the delta CRL to function.

1. When the **File Download** dialog box appears, select **Save**. Select a folder on your computer to store the `.crl` file, and then select **Save**.

1. Open Windows Explorer and locate the `.crl` file you saved.

1. Right-click the `.cer` or `.crl` file and select **Install Certificate** or **Install CRL**, and then select **Next**.

1. When the Certificate Import Wizard opens, select **Automatically select the certificate store based on the type of certificate**.

## Next steps

- [Certification Authority Web Enrollment Guidance](certification-authority-role.md)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)
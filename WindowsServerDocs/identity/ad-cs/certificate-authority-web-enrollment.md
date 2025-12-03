---
title: Certification Authority Web Enrollment
description: Learn about Certification Authority Web Enrollment in Active Directory Certificate Services (AD CS) and its benefits for certificate management.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 06/19/2025
---

# Certification Authority Web Enrollment in Active Directory Certificate Services

Certification Authority (CA) Web Enrollment in Active Directory Certificate Services (AD CS) simplifies certificate management by providing a browser-based interface to request and renew certificates, retrieve certificate revocations lists (CRLs) and enroll for smart card certificates. This role service is useful for organizations that need a flexible and interactive method for certificate enrollment without requiring specific client configurations. In this article, you learn about the features, capabilities, and configuration options of CA Web Enrollment, and how it compares to the Certificate Enrollment Web Service role service.

## Capabilities and common tasks

CA Web Enrollment enables users to submit `PKCS #10` requests to the CA interactively through a web browser and an Internet Information Services (IIS) web site. CA Web Enrollment is different from the related *Certificate Enrollment Web Service* role service. Although both CA Web Enrollment and Certificate Enrollment Web Service use HTTPS, they're fundamentally different technologies.

CA Web Enrollment is useful when you interact with a stand-alone CA because the Certificates Microsoft Management Console (MMC) snap-in can't be used to interact with a standalone CA. Enterprise CAs can accept certificate requests through the Certificates snap-in or the CA Web Enrollment role service pages.

The CA Web Enrollment role service includes updated sample webpages for web-based certificate enrollment operations. These webpages work together with the `CertEnroll` component. For more information about `CertEnroll`, see [Certificate Enrollment API](/windows/win32/seccertenroll/certenroll-portal).

The following table summarizes key differences between CA Web Enrollment and Certificate Enrollment Web Service:

| Feature / Capability | CA Web Enrollment | Certificate Enrollment Web Service |
|----------------------|-------------------|-------------------------------------|
| **Request Method** | Interactive, manually created certificate requests by the requestor, uploaded through the website. | Automated enrollment and renewal, suitable for large-scale deployments. |
| **Certificate Provisioning** | Browser-based interactive method for individual certificates. | Automated provisioning for extra certificates. |
| **Client Requirements** | No specific client components or configuration required. | Built-in client with Windows and Windows Server. |
| **Forest Consolidation** | Not supported. | Supported; enables PKI consolidation across multiple forests by eliminating per-forest CA deployments. |
| **Perimeter Network Enrollment** | Not supported. | Supported; allows certificate enrollment from outside the corporate network. |

For more information on forest consolidation and using perimeter networks, see [Certificate Enrollment Web Service in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx).

## Deployment topology

You can install CA Web Enrollment on a server that isn't a CA to separate web traffic from the CA. Installing CA Web Enrollment configures the computer as an enrollment registration authority. You must select a CA to use with the CA Web Enrollment pages. The CA that CA Web Enrollment uses is the **Target CA** in the user interface. You can select the target CA you want to use by using either the CA name or the computer name associated with the CA.

If you install the CA Web Enrollment pages on a computer that's not the target CA, the computer account where you installed the CA Web Enrollment pages must be trusted for delegation. For more information, see [Install Web Enrollment Support on Another Computer (Optional)](/previous-versions/windows/it-pro/windows-2000-server/cc962056(v=technet.10)) and [How to configure the Windows Server 2008 CA Web Enrollment Proxy](/archive/blogs/askds/how-to-configure-the-windows-server-2008-ca-web-enrollment-proxy).

> [!NOTE]
>
> - If the CA Web Enrollment pages don't install successfully on a migrated CA, it's possible the setup status in the registry isn't configured properly. For more information, see [Certification Authority Web Enrollment Configuration Failed 0x80070057 (WIN32: 87)](https://learn.microsoft.com/en-us/archive/technet-wiki/12035.ad-certification-authority-web-enrollment-configuration-failed-0x80070057-win32-87).
>
> - The CA Web Enrollment role service pages require that you secure them with secure sockets layer (SSL) or transport layer security (TLS). If you don't, you see the following error message: **In order to complete the certificate enrollment, the website for the CA must be configured to use HTTPS authentication**. To learn about configuring HTTPS authentication, see [Active Directory Certificate Services (AD CS): Error: "In order to complete certificate enrollment, the website for the CA must be configured to use HTTPS authentication](https://social.technet.microsoft.com/wiki/contents/articles/12039.active-directory-certificate-services-ad-cs-error-in-order-to-complete-certificate-enrollment-the-web-site-for-the-ca-must-be-configured-to-use-https-authentication.aspx).

## Use the CA Web Enrollment pages

If you're granted access permissions, you can perform the following tasks from the CA Web Enrollment pages:

- Request a basic certificate.

- Request a certificate with advanced options. Requesting with advanced options gives you greater control over the certificate request. Available options in an advanced certificate request include:

  - In **Cryptographic service provider (CSP) options**, you can configure the name of the cryptographic service provider, the key size (1024, 2048, and so on), the hash algorithm (such as SHA/RSA, SHA/DSA, MD2, or MD5) and the key specification (exchange or signature).

  - **Key generation options** lets you create a new key set or use an existing key set, mark the keys as exportable, enable strong key protection, and use the local computer store to generate the key.

  - **Additional options**. Save the request to a PKCS #10 file or add specific attributes to the certificate.

- Check a pending certificate request. If you submit a certificate request to a standalone certification authority, you need to check the status of the pending request to make sure the certification authority issued the certificate. If the authority issued the certificate, it becomes available on the webpage for you to install.

- Retrieve the certification authority's certificate to place in your trusted root store or install the entire certificate chain in your certificate store.

- Retrieve the current base and delta CRLs.

- Submit a certificate request by using a PKCS #10 file or a PKCS #7 file. In general, you use a PKCS #10 file to submit a request for a new certificate and a PKCS #7 file to submit a request to renew an existing certificate. Submitting requests with files is useful when the certificate requester is unable to submit a request online to the certification authority.

These web pages are located at `https://<servername>/certsrv`, where `<servername>` is the name of the server that hosts the CA Web Enrollment pages. The `certsrv` portion of the URL should always be in lowercase letters; otherwise, users can have trouble checking and retrieving pending certificates.

## Next steps

For more information about Web Enrollment and troubleshooting common issues, see the following articles:

- [AD CS: Web Enrollment](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732517(v=ws.10))

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

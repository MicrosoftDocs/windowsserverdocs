---
title: Certification Authority Web Enrollment Role Service in Windows Server
description: Use this article to understand the Active Directory Certification Authority Web Enrollment Role Service.
author: gswashington
ms.author: wscontent
ms.topic: overview
ms.date: 08/31/2023

---

# Certification Authority Web Enrollment Role Service

The Certification Authority (CA) Web Enrollment role service provides a set of web pages that allow users to perform certificate tasks. For example, requesting and renewing certificates, retrieving certificate revocations lists (CRLs) and enrolling for smart card certificates. These web pages are located at `https://<servername>/certsrv`, where `<servername>` is the name of the server that hosts the CA Web Enrollment pages. The `certsrv` portion of the URL should always be in lowercase letters; otherwise, users can have trouble checking and retrieving pending certificates.

> [!NOTE]
> The CA Web Enrollment role service pages require that you secure them with secure sockets layer (SSL) or transport layer security (TLS). If you don't, you'll see the following error message: "In order to complete the certificate enrollment, the website for the CA must be configured to use HTTPS authentication." To learn about configuring HTTPS authentication, see [Active Directory Certificate Services (AD CS): Error: "In order to complete certificate enrollment, the website for the CA must be configured to use HTTPS authentication](https://social.technet.microsoft.com/wiki/contents/articles/12039.active-directory-certificate-services-ad-cs-error-in-order-to-complete-certificate-enrollment-the-web-site-for-the-ca-must-be-configured-to-use-https-authentication.aspx).

## Certification Authority Web Enrollment

CA Web Enrollment lets client computers submit PKCS #10 requests to the CA interactively through a web browser and an Internet Information Services (IIS) web site. For example, when you install this role service, users in the `contoso.com` domain can enter `http://ca.contoso.com/CertSrv` into their web browser and see an interactive website that allows them to upload requests, download completed certificates, and download certificate revocation lists (CRLs).

CA Web Enrollment is different from the related _Certificate Enrollment Web Services_ role service. Although both CA Web Enrollment and Certificate Enrollment Web Services use HTTPS, they're fundamentally different technologies. 

CA Web Enrollment supports certificate requests and a broad set of client operating systems. CA Web Enrollment provides a browser-based interactive method of requesting individual certificates that doesn't require specific client components or configuration. Web Enrollment only supports interactive requests that the requester creates and uploads manually through the website.

Certificate Enrollment Web Services focuses on automated certificate requests and provisioning by using the builtin client, starting with the Windows and Windows Server operating systems. While using these services, the user doesn't have to make a request manually or interact with a website. Certificate Enrollment Web Services offers certain advantages for scenarios that involve enrolling and renewing extra certificates, including Forest Consolidation and Perimeter network certificate enrollment. Organizations with multiple forests can consolidate their Public Key Infrastructure (PKI) by eliminating the requirement for per-forest CA deployments. Forest consolidation enables organizations to consolidate PKI services by deploying fewer CAs. The Certificate Enrollment Web Services also lets organizations enable Active Directory Certificate Services (AD CS) using a perimeter network. Using a perimeter network lets users and computers outside the corporate network enroll for certificates.

For more information on forest consolidation and using perimeter networks, see [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx).

## Common tasks and capabilities

The CA Web Enrollment role service pages let you connect to the CA using a web browser to perform common tasks, including:

- Requesting certificates from the CA.

- Requesting the CA's certificate.

- Submitting a certificate request by using a PKCS #10 file.

- Retrieving the CA's certificate revocation list (CRL).

CA Web Enrollment is useful when you interact with a stand-alone CA because the Certificates Microsoft Management Console (MMC) snap-in can't be used to interact with a standalone CA. Enterprise CAs can accept certificate requests through the Certificates snap-in or the CA Web Enrollment role service pages.

The CA Web Enrollment role service includes updated sample webpages for web-based certificate enrollment operations. These webpages work together with the CertEnroll component.

For more information about CertEnroll, see [Certificate Enrollment API](/windows/win32/seccertenroll/certenroll-portal).

## CA for Web Enrollment

You can install CA Web Enrollment on a server that isn't a CA to separate web traffic from the CA. Installing CA Web Enrollment configures the computer as an enrollment registration authority. You must select a CA to use with the CA Web Enrollment pages. The CA that CA Web Enrollment uses is called the **Target CA** in the user interface. You can select the target CA by using either the CA name or the computer name associated with the CA. Select **Select** to locate the CA you want to use.

## Web Enrollment Configuration

If you install the CA Web Enrollment pages on a computer that's not the target CA, the computer account where you installed the CA Web Enrollment pages must be trusted for delegation. For more information, see the following resources:

- [Install Web Enrollment Support on Another Computer (Optional)](/previous-versions/windows/it-pro/windows-2000-server/cc962056(v=technet.10))
- [How to configure the Windows Server 2008 CA Web Enrollment Proxy](/archive/blogs/askds/how-to-configure-the-windows-server-2008-ca-web-enrollment-proxy)

> [!TIP]
> If the CA Web Enrollment pages don't install successfully on a migrated CA, it's possible the setup status in the registry isn't configured properly. For more information, see [Certification Authority Web Enrollment Configuration Failed 0x80070057 (WIN32: 87)](https://social.technet.microsoft.com/wiki/contents/articles/12035.certification-authority-web-enrollment-configuration-failed-0x80070057-win32-87-en-us.aspx)

## Use the CA Web Enrollment pages

If you've been granted access permissions, you can perform the following tasks from the CA Web Enrollment pages:

- Request a basic certificate.

- Request a certificate with advanced options. Requesting with advanced options gives you greater control over the certificate request. Available options in an advanced certificate request include:

  - In **Cryptographic service provider (CSP) options**, you can configure the name of the cryptographic service provider, the key size (1024, 2048, and so on), the hash algorithm (such as SHA/RSA, SHA/DSA, MD2, or MD5) and the key specification (exchange or signature).

  - **Key generation options** lest you create a new key set or use an existing key set, mark the keys as exportable, enable strong key protection, and use the local computer store to generate the key.

  - **Additional options**. Save the request to a PKCS #10 file or add specific attributes to the certificate.

- Check a pending certificate request. If you've submitted a certificate request to a standalone certification authority, you need to check the status of the pending request to make sure the certification authority has issued the certificate. If the authority issued the certificate, it becomes available on the webpage for you to install.

- Retrieve the certification authority's certificate to place in your trusted root store or install the entire certificate chain in your certificate store.

- Retrieve the current base and delta CRLs.

- Submit a certificate request by using a PKCS #10 file or a PKCS #7 file.

    > [!NOTE]
    >
    > - In general, you use a PKCS #10 file to submit a request for a new certificate and a PKCS #7 file to submit a request to renew an existing certificate. Submitting requests with files is useful when the certificate requester is unable to submit a request online to the certification authority.
    >
    > - You might need to make `https://<servername>` a trusted site for Internet Explorer to browse for a file on the computer's hard disk drive. To make `https://<servername>` a trusted site, open Internet Explorer, then go to **Tools** > **Internet Options** > **Security** > **Trusted Sites** > **Sites**, then enter the URL and select **OK**. Replace `<servername>` in the example URL with the host name of the server you want to connect to. If you typically use the fully qualified domain name (FQDN) to connect to the server, either create your entry using the FQDN instead of the host name or enter the FQDN and the host name together. Trusted sites are not required if you are using Microsoft Edge.

## Next steps

For more information about Web Enrollment and troubleshooting common issues, see the following articles:

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [You cannot download CA certificate from web enrollment pages](https://social.technet.microsoft.com/wiki/contents/articles/you-cannot-download-ca-certificate-from-web-enrollment-pages.aspx)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)
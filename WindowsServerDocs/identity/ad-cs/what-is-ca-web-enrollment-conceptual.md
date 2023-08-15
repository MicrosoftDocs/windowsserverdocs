---
title: Certification Authority Web Enrollment Guidance
description: 
author: gswashington
ms.author: wscontent
ms.topic: overview
ms.date: 08/31/2023

---

# Certification Authority Web Enrollment guidance

Applies To: Windows Server 2012 R2, Windows Server 2012

The Certification Authority (CA) Web Enrollment role service provides a set of web pages that allow interaction with the Certification Authority role service. These web pages are located at https://\<servername\>/certsrv, where \<servername\> is the name of the server that hosts the hosts the CA Web Enrollment pages. The certsrv portion of the URL should always be in lowercase letters; otherwise, users can have trouble checking and retrieving pending certificates.

> [!NOTE]
> Important to know, even if you're just skimming this article! The CA Web Enrollment role service pages require that you secure them with secure sockets layer (SSL) / transport layer security (TLS). If you don't, you'll see the following error: "In order to complete the certificate enrollment, the Web site for the CA must be configured to use HTTPS authentication." To resolve this issue, you must configure HTTPS authentication. See [Active Directory Certificate Services (AD CS): Error: "In order to complete certificate enrollment, the Web site for the CA must be configured to use HTTPS authentication](https://social.technet.microsoft.com/wiki/contents/articles/12039.active-directory-certificate-services-ad-cs-error-in-order-to-complete-certificate-enrollment-the-web-site-for-the-ca-must-be-configured-to-use-https-authentication.aspx) for guidance.

## Not to be confused with Certificate Enrollment Web Services

CA Web Enrollment is different from a related Windows technology, Certificate Enrollment Web Services. Although CA Web Enrollment and Certificate Enrollment Web Services both use HTTPS, they are fundamentally different technologies. CA Web Enrollment supports certificate requests and a broad set of client operating systems. The Certificate Enrollment Web Services offer automated requests and certificate provisioning for client computers starting with the Windows 7 and Windows Server 2008 R2 operating systems. CA Web Enrollment provides a browser-based interactive method of requesting individual certificates that doesn't require specific client components or configuration. CA Web Enrollment only supports interactive requests that the requester creates and uploads manually through the web site. 

CA Web Enrollment lets client computers submit PKCS #10 requests to the CA interactively through a web browser and Internet Information Services (IIS) application. For example, when this role service is installed, users in the contoso.com domain could enter http://ca.contoso.com/CertSrv Jump in their web browser and see an interactive web site that allows them to upload requests, download completed certificates, and download certificate revocation lists (CRLs).

Certificate Enrollment Web Services focus on automated certificate requests and provisioning by using the native client starting with the Windows 7 and Windows Server 2008 R2 operating systems. The user doesn't have to make a request manually or interact with a web site.

Certificate Enrollment Web Services offers certain advantages for additional certificate enrollment and renewal scenarios, including Forest Consolidation and Perimeter network certificate enrollment. Organizations with multiple forests can consolidate their PKI by eliminating the requirement for per-forest CA deployments. Forest consolidation enables organizations to consolidate PKI services by deploying fewer CAs. 

Certificate Enrollment Web Services also lets organizations enable AD CS using a perimeter network. Using a perimeter network lets users and computers outside the corporate network enroll for certificates.

For more information on forest consolidation and using perimiter networks, see [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx)

## Common tasks and capabilities of CA Web Enrollment role service

The CA Web Enrollment role service pages let you connect to the CA using a web browser to perform common tasks, including:

- Requesting certificates from the CA

- Requesting the CA's certificate

- Submitting a certificate request by using a PKCS \#10 file

- Retrieving the CA's certificate revocation list (CRL)

CA Web Enrollment is useful when you interact with a stand-alone CA because the Certificates Microsoft Management Console (MMC) snap-in can't be used to interact with a stand-alone CA. Enterprise CAs can accept certificate requests through the Certificates snap-in or the CA Web Enrollment role service pages.

Starting in Windows Server® 2008, the CA Web Enrollment role service includes updated sample web pages for web-based certificate enrollment operations. These web pages are updated to work together with the CertEnroll component (available starting with Windows Vista). These web pages also work together with Xenroll.

The certificate enrollment Web pages starting in Windows Server 2008 detect the client operating system and then select the appropriate control.

- If a client computer is running Windows Server 2003 or Windows XP, the certificate enrollment web pages use Xenroll.

- If the client computer is running at least Windows Vista® or Windows Server 2008, the CA Web Enrollment role service uses CertEnroll.

> [!IMPORTANT]
> In Windows® 8, CA Web Enrollment pages only work with Internet Explorer 10 for the desktop.
> Starting in Windows Server 2012 R2, client computers that run Windows XP aren't supported for web enrollment.

For more information about CertEnroll and Xenroll, see:

- [How to use Certificate Services Web enrollment pages together with Windows Vista or Windows Server 2008](https://support.microsoft.com/kb/922706)

- [Certificate-Related Changes for Windows Vista](https://technet.microsoft.com/library/cc749280.aspx)

- [Certificate Enrollment API](https://msdn.microsoft.com/library/windows/desktop/aa374863.aspx)

## CA for Web Enrollment

You can install CA Web Enrollment on a server that isn't a CA to separate web traffic from the CA. Installing CA Web Enrollment configures the computer as an enrollment registration authority. You must select a CA to be used with the CA Web Enrollment pages. The CA that CA Web Enrollment uses is called the **Target CA** in the user interface. You can select the target CA by using the CA name or the computer name that's associated with the CA. Select **Select** to locate the CA you want to use.

## Web Enrollment Configuration

If you install the CA Web Enrollment pages on a computer that's not the target CA, the computer account where the CA Web Enrollment pages are installed must be trusted for delegation. See the following resources for more information:

- [How to configure the Windows Server 2008 CA Web Enrollment Proxy](https://blogs.technet.com/b/askds/archive/2009/04/22/how-to-configure-the-windows-server-2008-ca-web-enrollment-proxy.aspx)

- [Install Web Enrollment Support on Another Computer (Optional)](https://technet.microsoft.com/library/cc962056.aspx)

> [!TIP]
> If CA Web Enrollment pages installation fails on a migrated CA, it's possible the setup status in the registry is incorrectly set. For more information, see [Certification Authority Web Enrollment Configuration Failed 0x80070057 (WIN32: 87)](https://social.technet.microsoft.com/wiki/contents/articles/12035.certification-authority-web-enrollment-configuration-failed-0x80070057-win32-87-en-us.aspx)

## Use the CA Web Enrollment pages

If you've been granted access permissions, you can perform the following tasks from the CA Web Enrollment pages:

- Request a basic certificate.

- Request a certificate with advanced options.

    This gives you greater control over the certificate request. Some of the user-selectable options that are available in an advanced certificate request include:

      - **Cryptographic service provider (CSP) options**. The name of the cryptographic service provider, the key size (1024, 2048, and so on), the hash algorithm (such as SHA/RSA, SHA/DSA, MD2, or MD5) and the key specification (exchange or signature).

      - **Key generation options**. Create a new key set or use an existing key set, mark the keys as exportable, enable strong key protection, and use the local computer store to generate the key.

      - **Additional options**. Save the request to a PKCS \#10 file or add specific attributes to the certificate.

- Check a pending certificate request. If you've submitted a certificate request to a stand-alone certification authority, you need to check the status of the pending request to see if the certification authority has issued the certificate. If the certificate has been issued, it'll be available for you to install it.

- Retrieve the certification authority's certificate to place in your trusted root store or install the entire certificate chain in your certificate store.

- Retrieve the current base and delta CRLs.

- Submit a certificate request by using a PKCS \#10 file or a PKCS \#7 file.

    > [!NOTE]
    > In general, you use a PKCS #10 file to submit a request for a new certificate and a PKCS #7 file to submit a request to renew an existing certificate. Submitting requests with files is useful when the certificate requester is unable to submit a request online to the certification authority.

> [!NOTE]
> You might need to make https://<servername> a trusted site for Internet Explorer to browse for a file on the computer's hard disk drive. To make https://servername a trusted site, in Internet Explorer, select **Tools**, then select **Internet Options**, select **Security**, **Trusted Sites**, and select **Sites**. Enter https://<servername> and select **OK**. Replace <servername> with the host name of the server to which you want to connect. If you typically use the fully qualified domain name (FQDN) to connect to the server, create your entry using the FQDN instead of or in addition to the host name.

> - If you submit the request and you immediately get a message that asks if you want to submit the request even though it doesn't contain a BEGIN or END tag, select **OK**.

## Next steps

- [You cannot download CA certificate from web enrollment pages](https://social.technet.microsoft.com/wiki/contents/articles/you-cannot-download-ca-certificate-from-web-enrollment-pages.aspx)

- [AD CS: Web Enrollment](https://technet.microsoft.com/library/cc732517.aspx)

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)
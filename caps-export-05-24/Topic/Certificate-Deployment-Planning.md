---
title: Certificate Deployment Planning
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f9e0c65-fb4d-487d-b5f4-bab2b1a12992
---
# Certificate Deployment Planning
Follow these steps for computer and user certificates deployment planning.  
  
-   [Planning certificate configuration](#bkmk_certconfig)  
  
-   [Planning User certificate enrollment](#bkmk_user)  
  
## <a name="bkmk_certconfig"></a>Planning certificate configuration  
The procedures for configuring certificate templates allow you to autoenroll computer and user certificates that meet X.509, Secure Sockets Layer\/Transport Layer Security \(SSL\/TLS\), Extensible Authentication Protocol \(EAP\), and Protected Extensible Authentication Protocol \(PEAP\) requirements.  
  
Computer and user certificates have the following minimum requirements:  
  
-   The Subject name must contain a value. If you issue a certificate that has a blank Subject, the certificate cannot be used for authentication.  
  
-   The certificate chains to a trusted root CA and does not fail any of the checks that are performed by CryptoAPI and that are specified in NPS network policy. Because you are issuing certificates from your own enterprise root CA, computer and user certificates issued by the CA automatically chain to the CA. Domain member computers have the CA certificate in the Trusted Root Certification Authorities folder in both the Local Computer and Current User certificate stores, which means that they trust the CA.  
  
-   The user or computer certificate is configured with the Client Authentication purpose in Application Policies extensions \(also called Enhanced Key Usage or EKU extensions\). The object identifier for Client Authentication is 1.3.6.1.5.5.7.3.2. By default, the User and Workstation Authentication certificate templates contain this purpose in Application Policies extensions.  
  
-   For user certificates, the Subject Alternative Name \(SubjectAltName\) extension, if used, must contain the user principal name \(UPN\). By default, the User certificate template is configured with the UPN.  
  
-   For computer certificates, the SubjectAltName extension, if used, must contain the computer's fully qualified domain name \(FQDN\), which is also called the DNS name. By default, the Workstation Authentication certificate template is not configured with this value and must be reconfigured to meet this requirement according to the instructions in [Configure the Workstation Authentication Certificate Template_1](../Topic/Configure-the-Workstation-Authentication-Certificate-Template_1.md).  
  
### Client computer display of certificates  
With PEAP and EAP\-TLS, client computers display a list of all installed certificates in the computer certificate store, with the following exceptions:  
  
-   Wireless clients do not display registry\-based and smart card\-logon certificates.  
  
-   Wireless clients and VPN clients do not display password\-protected certificates.  
  
-   Certificates that do not contain the Client Authentication purpose in Application Policies extensions are not displayed.  
  
In addition, 802.1X client computers do not use registry\-based certificates that are either smart card\-logon or password\-protected.  
  
## <a name="bkmk_user"></a>Planning User certificate enrollment  
Only domain member computers can refresh and be configured through Group Policy. For this reason, you can successfully autoenroll user certificates only if the user is connecting to the network using a domain member computer.  
  
To enroll user certificates to users connecting to the network on non\-domain member computers, you must provide users with the certificate using one of the following enrollment methods:  
  
-   Install from removable media.  
  
-   Use the Web enrollment pages provided with AD CS. For more information, see "Request a Certificate Over the Web" in the AD CS Help in the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Technical Library \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=110404](http://go.microsoft.com/fwlink/?LinkId=110404)\).  
  
-   Deploy smart cards, with the user certificate stored on the smart card.  
  
If users connect to the organization network with both a domain member computer and a non\-domain member computer, you can autoenroll user certificates to the user when the user logs on to the domain member computer, and then provide the user with instructions for using the Certificates Microsoft Management Console \(MMC\) snap\-in to export the certificate to a file for import using the MMC on the non\-domain member computer.  
  
> [!IMPORTANT]  
> Always use the Certificates MMC snap\-in to import a certificate from file; do not attempt to drag and drop the certificate into the MMC. In addition, if a certificate needs to be moved in the certificate store, do not drag and drop the certificate to another location. To move a certificate, you must export and then import it.  
  

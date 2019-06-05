---
ms.assetid: 9831b421-8fb7-4e15-ac27-c013cbca6d05
title: Certificate Requirements for Federation Servers
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Certificate Requirements for Federation Servers

In any Active Directory Federation Services \(AD FS\) design, various certificates must be used to secure communication and facilitate user authentications between Internet clients and federation servers. Each federation server must have a service communication certificate and a token\-signing certificate before it can participate in AD FS communications. The following table describes the certificate types that are associated with federation server.  
  
|Certificate type|Description|  
|--------------------|---------------|  
|Token\-signing certificate|A token\-signing certificate is an X509 certificate. Federation servers use associated public\/private key pairs to digitally sign all security tokens that they produce. This includes the signing of published federation metadata and artifact resolution requests.<br /><br />You can have multiple token\-signing certificates configured in the AD FS Management snap\-in to allow for certificate rollover when one certificate is close to expiring. By default, all the certificates in the list are published, but only the primary token\-signing certificate is used by AD FS to actually sign tokens. All certificates that you select must have a corresponding private key.<br /><br />For more information, see [Token-Signing Certificates](Token-Signing-Certificates.md) and [Add a Token-Signing Certificate](../../ad-fs/deployment/Add-a-Token-Signing-Certificate.md).|  
|Service communication certificate|Federation servers use a server authentication certificate, also known as a service communication for Windows Communication Foundation \(WCF\) Message Security. By default, this is the same certificate that a federation server uses as the Secure Sockets Layer \(SSL\) certificate in Internet Information Services \(IIS\). **Note:** The AD FS Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.<br /><br />For more information, see [Service Communications Certificates](Service-Communications-Certificates.md) and [Set a Service Communications Certificate](../../ad-fs/deployment/Set-a-Service-Communications-Certificate.md).<br /><br />Because the service communication certificate must be trusted by client computers, we recommend that you use a certificate that is signed by a trusted certification authority \(CA\). All certificates that you select must have a corresponding private key.|  
|Secure Sockets Layer \(SSL\) certificate|Federation servers use an SSL certificate to secure Web services traffic for SSL communication with Web clients and with federation server proxies.<br /><br />Because the SSL certificate must be trusted by client computers, we recommend that you use a certificate that is signed by a trusted CA. All certificates that you select must have a corresponding private key.|  
|Token\-decryption certificate|This certificate is used to decrypt tokens that are received by this federation server.<br /><br />You can have multiple decryption certificates. This makes it possible for a resource federation server to be able to decrypt tokens that are issued with an older certificate after a new certificate is set as the primary decryption certificate. All certificates can be used for decryption, but only the primary token\-decrypting certificate is actually published in federation metadata. All certificates that you select must have a corresponding private key.<br /><br />For more information, see [Add a Token-Decrypting Certificate](../../ad-fs/deployment/Add-a-Token-Decrypting-Certificate.md).|  
  
You can request and install an SSL certificate or service communication certificate by requesting a service communication certificate through the Microsoft Management Console \(MMC\) snap\-in for IIS. For more general information about using SSL certificates, see [IIS 7.0: Configuring Secure Sockets Layer in IIS 7.0](https://go.microsoft.com/fwlink/?LinkID=108544) and [IIS 7.0: Configuring Server Certificates in IIS 7.0](https://go.microsoft.com/fwlink/?LinkID=108545) .  
  
> [!NOTE]  
> In AD FS you can change the Secure Hash Algorithm \(SHA\) level that is used for digital signatures to either SHA\-1 or SHA\-256 \(more secure\). AD FSdoes not support the use of certificates with other hash methods, such as MD5 \(the default hash algorithm that is used with the Makecert.exe command\-line tool\). As a security best practice, we recommend that you use SHA\-256 \(which is set by default\) for all signatures. SHA\-1 is recommended for use only in scenarios in which you must interoperate with a product that does not support communications using SHA\-256, such as a non\-Microsoft product or AD FS 1. *x*.  
  
## Determining your CA strategy  
AD FS does not require that certificates be issued by a CA. However, the SSL certificate \(the certificate that is also used by default as the service communications certificate\) must be trusted by the AD FS clients. We recommend that you not use self\-signed certificates for these certificate types.  
  
> [!IMPORTANT]  
> Use of self\-signed, SSL certificates in a production environment can allow a malicious user in an account partner organization to take control of federation servers in a resource partner organization. This security risk exists because self\-signed certificates are root certificates. They must be added to the trusted root store of another federation server \(for example, the resource federation server\), which can leave that server vulnerable to attack.  
  
After you receive a certificate from a CA, make sure that all certificates are imported into the personal certificate store of the local computer. You can import certificates to the personal store with the Certificates MMC snap\-in.  
  
As an alternative to using the Certificates snap\-in, you can also import the SSL certificate with the IIS Manager snap\-in at the time that you assign the SSL certificate to the default Web site. For more information, see [Import a Server Authentication Certificate to the Default Web Site](../../ad-fs/deployment/Import-a-Server-Authentication-Certificate-to-the-Default-Web-Site.md).  
  
> [!NOTE]  
> Before you install the AD FS software on the computer that will become the federation server, make sure that both certificates are in the Local Computer personal certificate store and that the SSL certificate is assigned to the Default Web Site. For more information about the order of the tasks that are required to set up a federation server, see [Checklist: Setting Up a Federation Server](../../ad-fs/deployment/Checklist--Setting-Up-a-Federation-Server.md).  
  
Depending on your security and budget requirements, carefully consider which of your certificates will be obtained by a public CA or a corporate CA. The following figure shows the recommended CA issuers for a given certificate type. This recommendation reflects a best\-practice approach regarding security and cost.  
  
![cert requirements](media/adfs2_fedserver_certstory_1.png)  
  
## Certificate revocation lists  
If any certificate that you use has CRLs, the server with the configured certificate must be able to contact the server that distributes the CRLs.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)

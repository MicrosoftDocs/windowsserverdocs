---
ms.assetid: 95e82190-68c5-4e40-87b1-f1bd816ef4e9
title: Service Communications Certificates
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Service Communications Certificates

A federation server requires the use of service communication certificates for scenarios in which WCF message security is used.  
  
## Service communication certificate requirements  
Service communication certificates must meet the following requirements to work with AD FS:  
  
-   The service communication certificate must include the server authentication enhanced key usage \(EKU\) extension.  
  
-   The certificate revocation lists \(CRLs\) must be accessible for all the certificates in the chain from the service communication certificate to the root CA certificate. The root CA must also be trusted by any federation server proxies and Web servers that trust this federation server.  
  
-   The subject name that is used in the service communication certificate must match the Federation Service name in the properties of the Federation Service.  
  
## Deployment considerations for service communication certificates  
Configure service communication certificates so that all federation servers use the same certificate. If you are deploying the Federated Web Single\-Sign\-On \(SSO\) design, we recommend that your service communication certificate be issued by a public CA. You can request and install these certificates through the IIS Manager snap\-in.  
  
You can use self\-signed, service communication certificates successfully on federation servers in a test lab environment. However, for a production environment, we recommend that you obtain service communication certificates from a public CA. The following are reasons why you should not use self\-signed, service communication certificates for a live deployment:  
  
-   A self\-signed, SSL certificate must be added to the trusted root store on each of the federation servers in the resource partner organization. While this alone does not enable an attacker to compromise a resource federation server, trusting self\-signed certificates does increase the attack surface of a computer, and it can lead to security vulnerabilities if the certificate signer is not trustworthy.  
  
-   It creates a bad user experience. Clients will receive Security Alert prompts when they try to access federated resources that display the following message: "The security certificate was issued by a company you have not chosen to trust." This is expected behavior, because the self\-signed certificate is not trusted.  
  
    > [!NOTE]  
    > If necessary, you can work around this condition by using Group Policy to manually push down the self\-signed certificate to the trusted root store on each client computer that will attempt to access an AD FS site.  
  
-   CAs provide additional certificate\-based features, such as private key archive, renewal, and revocation, that are not provided by self\-signed certificates.  
  


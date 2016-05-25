---
title: Appendix B – Enable HTTPS communication on the HGS server
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 321059fb-b4cc-4851-9bb5-482f0d54e95e
robots: noindex,nofollow
---
# Appendix B – Enable HTTPS communication on the HGS server
### Initialize HGS server with HTTPS Certificate    
To enable HTTPS communication on the HGS server, you need to pass in the HTTPS certificate when initializing the HGS server. Modify the following example as appropriate (e.g. *–Http –Https –HttpsCertificatePath ‘C:\\HttpsCertificate.pfx’ –HttpsCertificatePassword $certificatePassword*), and run it in place of the command in Section 6.4.  
  
```  
Initialize-HgsServer –HgsServiceName $HgsServiceName -EncryptionCertificateThumbprint $encryptionCert.Thumbprint -SigningCertificateThumbprint $signingCert.Thumbprint -CommunicationsCertificateThumbprint $signingCert.Thumbprint –TrustActiveDirectory –Http –Https –HttpsCertificatePath ‘C:\\HttpsCertificate.pfx’ –HttpsCertificatePassword $certificatePassword -Force  
```    
***  
  >**Note:** If you are setting up multiple HGS servers in a High Availability configuration, be sure to import the same HTTPS certificate on each machine. The bolded part of the command above should be included every time you initialize an HGS server in your environment.  
  
### Configure VMM with HTTPS HGS endpoints    
In order to take advantage of the SSL encryption, you must specify the secure endpoints when configuring the HGS settings in VMM. For example, instead of the addresses shown in section 8.1.1, provide the following addresses:    
1.  <https://Relecloud.com/Attestation> for the Attestation URL    
2.  <https://Relecloud.com/KeyProtection> for the KPS URL  
    
### Ensure guarded hosts trust the HTTPS certificate    
If you chose to use a self-signed certificate for your HTTPS certificate, you will need to import the certificate into the Trusted Root Certificate Authorities store on every host. To do this, run the following command on each host machine, where the certificate file is the one generated in Section 6.3:  
  
    `Import-Certificate –FilePath “C:\\temp\\HttpsCertificate.cer” –CertStoreLocation Cert:\\LocalMachine\\Root`
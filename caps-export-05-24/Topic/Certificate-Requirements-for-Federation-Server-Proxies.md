---
title: Certificate Requirements for Federation Server Proxies
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 579932b6-abd5-46f8-85dd-cd638685ffff
author: billmath
---
# Certificate Requirements for Federation Server Proxies
Servers that are running in the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] role in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] are required to use Secure Sockets Layer \(SSL\) server authentication certificates. Federation server proxies use SSL server authentication certificates to secure Web server traffic communication with Web clients.  
  
Federation server proxies are usually exposed to computers on the Internet that are not included in your enterprise public key infrastructure \(PKI\). Therefore, use a server authentication certificate that is issued by a public \(third\-party\) certification authority \(CA\), for example, VeriSign.  
  
When you have a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] farm, all [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] computers must use the same server authentication certificate. For more information, see [When to Create a Federation Server Proxy Farm](../Topic/When-to-Create-a-Federation-Server-Proxy-Farm.md).  
  
It is important to verify that the subject name in the server authentication certificate matches the Federation Service name value that is specified in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in. To locate this value, open the snap\-in, right\-click **Service**, click **Edit Federation Service Properties**, and then find the value in **Federation Service name** text box.  
  
For general information about using SSL certificates, see Configuring Secure Sockets Layer in IIS 7.0 \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108544](http://go.microsoft.com/fwlink/?LinkID=108544)\) and Configuring Server Certificates in IIS 7.0 \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108545](http://go.microsoft.com/fwlink/?LinkID=108545)\).  
  
> [!NOTE]  
> Client authentication certificates are not required for AD FS [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies.  
  
If any certificate that you use has certificate revocation lists \(CRLs\), the server with the configured certificate must be able to contact the server that distributes the CRLs. The type of CRL determines what ports are used.  
  

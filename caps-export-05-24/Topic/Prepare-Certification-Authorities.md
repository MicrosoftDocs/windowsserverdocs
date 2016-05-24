---
title: Prepare Certification Authorities
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 02e2408b-7504-4478-86c9-005b5e864cfc
author: Femila
---
# Prepare Certification Authorities
  You can use this procedure to prepare certification authorities \(CAs\) for domain rename. Management of enterprise certificates can be sustained through a domain rename operation when the following requirements are in effect before domain rename:  
  
-   The CAs are not installed on domain controllers.  
  
-   As a best practice, all the CAs should include both Lightweight Directory Access Protocol \(LDAP\) and Hypertext Transfer Protocol \(HTTP\) URLs in their Authority Information Access \(AIA\) and Certificate Distribution Point \(CDP\) extensions.  
  
> [!CAUTION]  
>  If any certificate that the CA issues has only one of these URL types, the certificate may or may not work. Depending on the complexity of your domain configuration, steps in this document might not be sufficient for proper management of CAs after the domain rename operation. Proceed with these steps only if you have considerable expertise in handling Microsoft CAs.  
  
 If one or more of the following conditions exist at the time of domain rename, CA management is not supported:  
  
-   The CA is configured to have only LDAP URLs for its CDP or AIA. Because the old LDAP extensions would be invalid after the domain rename operation, all the certificates that are issued by the CA are no longer valid. As a workaround, you have to renew the existing CA hierarchy and all issued End Entity certificates.  
  
-   After the domain rename operation, the name constraints might not be valid. As a workaround, you will have to reissue cross\-certificates with appropriate name constraints.  
  
-   A Request for Comments \(RFC\) 822–style e\-mail name is used in the user account. If the CA \(or the certificate template\) is configured to include RFC 822\-style e\-mail names and this name style is used in the certificates that are issued, these certificates will contain an incorrect e\-mail name after domain rename operation. Any such Active Directory accounts should be changed before any certificate is issued.  
  
 As a best practice, the default LDAP and HTTP URLs require no special configuration before the domain rename operation.  
  
 Before you begin the domain rename operation, ensure that the certificate revocation lists \(CRLs\) and the CA certificates will not expire soon. If you find that they are close to expiration, complete the following tasks before the domain rename operation:  
  
1.  Renew the CA certificates.  
  
2.  Issue a new CRL with the appropriate validity period.  
  
3.  Wait until both of these previous items have propagated to all client computers.  
  
 For more information, see Active Directory Certificate Services \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122981](http://go.microsoft.com/fwlink/?LinkID=122981)\).  
  
  
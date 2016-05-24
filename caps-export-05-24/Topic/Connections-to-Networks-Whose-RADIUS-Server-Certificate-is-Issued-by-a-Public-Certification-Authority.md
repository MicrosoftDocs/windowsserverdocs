---
title: Connections to Networks Whose RADIUS Server Certificate is Issued by a Public Certification Authority
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 85f942a3-de56-45ad-b711-0b3c2ac19a12
---
# Connections to Networks Whose RADIUS Server Certificate is Issued by a Public Certification Authority
When you encounter a wireless network whose RADIUS server certificate is issued by a public certification authority \(CA\), and whose configuration requires use of an authentication method in which the client computer must verify the identity of the RADIUS server, the client computer checks the certificates that are installed in the Trusted Root Certification Authorities certificate store. If the public CA certificate exists in the certificate store, the client computer trusts the RADIUS server and authentication of the server is successful.  
  
When connecting to this type of network for the first time, if the public CA certificate is not in the Trusted Root Certification Authorities certificate store, you must manually accept the certificate.  
  
During subsequent auto\-connects, Windows compares the new certificate with the server certificate that was received during the first connection attempt. If the certificate is the same, then trust is established and Windows seamlessly authenticates the RADIUS server. If the certificate is not the same, the connection is dropped silently and you must manually connect to the network.  
  

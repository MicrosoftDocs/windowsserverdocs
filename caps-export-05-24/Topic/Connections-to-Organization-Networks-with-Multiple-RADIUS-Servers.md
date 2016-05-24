---
title: Connections to Organization Networks with Multiple RADIUS Servers
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 77695c33-e61f-4fd9-8394-6f70aba80244
---
# Connections to Organization Networks with Multiple RADIUS Servers
Wireless devices that are used on a network where more than one RADIUS server is deployed can encounter authentication issues, such as failure to automatically authenticate the RADIUS server, in circumstances where the server certificates on the RADIUS servers are not all issued by the same private certification authority \(CA\). Even if the wireless device successfully verifies the identity of a RADIUS server and connects to the network, moving to a new location or encountering a situation where a different RADIUS server processes a reconnection attempt can result in failure to automatically authenticate the server and establish a wireless connection. In this circumstance, you must manually connect to the network and accept the server certificate for the connection.  
  
To understand how to deploy multiple RADIUS servers without causing these authentication issues, it is important to understand the server certificate checks that are performed by [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] devices during the authentication process. The client performs the following checks on the RADIUS server certificate:  
  
-   The client compares the hashes of the issuing CA in the RADIUS server certificate with the hashes of the issuing CA of a certificate that you have previously chosen to trust. The issuing CA hashes in both certificates must match in order for authentication to proceed.  
  
-   The client verifies that the server certificate is issued by a private CA, which is determined by the presence of the RADIUS Enhanced Key Usage \(EKU\) extension in the certificate.  
  
If the server certificate passes both of these checks, then the authentication process continues; if the RADIUS server authenticates and authorizes the connection, the wireless device connects to the network seamlessly.  
  
If the server certificate does not pass both of these checks, Windows silently drops the connection and you must manually connect to the network.  
  
### Deployment requirements for multiple RADIUS servers  
In order to ensure that your RADIUS server deployment leverages the server certificate checks that are performed by wireless clients that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], and to provide wireless users with a seamless, automatic wireless connection experience, you must deploy server certificates with the following requirements.  
  
-   You must deploy a private CA rather than obtain server certificates from a third party public CA. In addition, the certificate template that you use to issue the certificates must contain the RADIUS EKU extension. This extension is **id\-kp\-eapOverLAN** and the object identifier \(OID\) for this EKU is 1.3.6.1.5.5.7.3.14. This EKU extension can only be configured on a private CA and is used by [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] to determine whether a private CA issued the certificate.  
  
-   All server certificates that are issued to all RADIUS servers must chain to the same private trusted root CA.  
  
> [!IMPORTANT]  
> If you deploy server certificates using Active Directory Certificate Services \(AD CS\) using the RAS and IAS Servers certificate template, you must add the **id\-kp\-eapOverLAN** EKU extension to the RAS and IAS Servers certificate template; it is not included in the template by default.  
  
If your server certificate deployment does not meet these requirements and you attempt to connect to the network, you must manually accept the server certificate when prompted by Windows. After you have accepted a server certificate, it is stored on the local computer and Windows attempts to use the certificate during subsequent connection attempts. If you have multiple RADIUS servers with server certificates that do not match the requirements, you must manually accept each certificate as you move through the network and encounter different authenticating servers.  
  

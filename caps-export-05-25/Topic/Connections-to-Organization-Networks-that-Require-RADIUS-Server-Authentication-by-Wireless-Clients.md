---
title: Connections to Organization Networks that Require RADIUS Server Authentication by Wireless Clients
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c3fd4d56-0c19-4f96-b8e5-785a598980a6
author: vhorne
---
# Connections to Organization Networks that Require RADIUS Server Authentication by Wireless Clients
When you use a laptop or other wireless device to connect to an organization network and the authentication method deployed for the connection requires that the wireless client authenticates the RADIUS server by using the server certificate, events differ based upon whether the wireless device is joined to the domain.  
  
Domain member computers and other devices automatically receive the private certification authority \(CA\) certificate when they log on to the network. This certificate is kept in the Trusted Root Certification Authorities certificate store on the domain member wireless client. During the authentication process for subsequent network connection attempts, the wireless client receives the server certificate from the Remote Authentication Dial\-In User Service \(RADIUS\) server, and then checks the certificates in the Trusted Root Certification Authorities certificate store to determine whether the CA is trusted. When the wireless client finds that the server certificate is issued by a trusted CA, the wireless client successfully authenticates the RADIUS server, and the rest of the authentication process can continue.  
  
When your wireless client is not a domain member, however, the CA certificate is not present in the Trusted Root Certification Authorities certificate store, so the wireless client cannot automatically trust the CA that issued the server certificate.  
  
For non\-domain joined wireless clients that are running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], when you attempt to connect to an organization network whose authentication methods require RADIUS server authentication by the client, the dialog box in the illustration below automatically opens to allow you to determine whether you trust the server certificate and want to connect to the network.  
  
![](../Image/wifi_server_id.jpg)  
  
If you trust the server certificate and choose to connect to the network, the certificate information is stored on the local computer so that subsequent connection attempts to the same wireless network and RADIUS server happen seamlessly and automatically.  
  
For information about connecting to networks with multiple RADIUS servers, see [Connections to Organization Networks with Multiple RADIUS Servers](../Topic/Connections-to-Organization-Networks-with-Multiple-RADIUS-Servers.md).  
  

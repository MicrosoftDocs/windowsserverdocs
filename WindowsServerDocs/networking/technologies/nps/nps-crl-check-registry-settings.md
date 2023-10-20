---
title: NPS CRL Check Registry Settings
description: This topic provides information about configuring Certificate Revocation List settings for EAP-TLS authentication on a Network Policy Server.
ms.topic: article
ms.assetid: 
ms.author: wscontent
author: marcussa
ms.date: 10/12/2023
ms.contributor: marcussa
---
# NPS CRL Check Registry Settings

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

You can use the following registry settings to change the way Network Policy Server (NPS) performs Certificate Revocation List (CRL) checks when EAP-TLS or PEAP-TLS is used.

> [!Warning]
> Incorrectly editing the registry can severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  

All of the listed registry settings can be configured on NPS servers with the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13`

> [!Important]
> All of the following registry settings must be added as a DWORD type and have the valid values of 0 or 1.  

## IgnoreNoRevocationCheck  

When set to 1, NPS allows EAP-TLS clients to connect even when NPS does not perform or cannot complete a revocation check of the certificate chain (excluding the root certificate) of the client. Typically, revocation checks fail because the certificate does not include CRL information.  
  
IgnoreNoRevocationCheck is set to 0 (disabled) by default. An EAP-TLS client cannot connect unless the server completes a revocation check of the certificate chain (including the root certificate) of the client and verifies that none of the certificates has been revoked.  
  
You can use this entry to authenticate clients when the certificate does not include CRL distribution points, such as might be the case with certificates issued by non-Microsoft certification authorities (CAs).  
  
## IgnoreRevocationOffline  

When set to 1, NPS allows EAP-TLS clients to connect even when a server that stores a CRL is not available on the network.  

IgnoreRevocationOffline is set to 0 by default. With this default setting, NPS does not allow clients to connect unless it can complete a revocation check of their certificate chain and verify that none of the certificates is revoked. When NPS cannot connect to a server that stores a revocation list, the certificate fails the revocation check and authentication fails.  
  
Setting IgnoreRevocationOffline to 1 prevents certificate validation failure because poor network conditions prevented NPS from successfully completing a revocation check.  
  
## NoRevocationCheck  
  
When set to 1, NPS prevents EAP-TLS from performing a revocation check of the certificate of the client. The revocation check verifies that the certificate of the client and the certificates in its certificate chain have not been revoked. NoRevocationCheck is set to 0 by default.  
  
## NoRootRevocationCheck  
  
When set to 1, NPS prevents EAP-TLS from performing a revocation check of the root CA certificate of the client.  
  
NoRootRevocationCheck is set to 0 by default. This entry only eliminates the revocation check of the root CA certificate of the client. A revocation check is still performed on the remainder of the certificate chain of the client.  
  
You can use this entry to authenticate clients when the certificate does not include CRL distribution points. Also, this entry can prevent certification-related delays that occur when a certificate revocation list is offline or expired.  
  
For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).  

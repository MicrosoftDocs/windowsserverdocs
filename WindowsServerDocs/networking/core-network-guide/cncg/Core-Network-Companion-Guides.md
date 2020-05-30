---
title: Core Network Companion Guides
description: This topic provides an overview of the companion guides to the Windows Server 2016 Core Network Guide
manager: brianlic
ms.technology: networking
ms.prod: windows-server
ms.topic: article
ms.assetid: d57af0bd-9301-4f62-9888-f528cd10451d
ms.author: lizross
author: eross-msft
---

# Core network companion guidance

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

While the Windows Server 2016 [Core Network Guide](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/core-network-guide) provides instructions on how to deploy a new Active Directory&reg; forest with a new root domain and the supporting networking infrastructure, Companion Guides provide you with the ability to add features to your network.

Each companion guide allows you to accomplish a specific goal after you have deployed your core network. In some cases, there are multiple companion guides that, when deployed together and in the correct order, allow you to accomplish very complex goals in a measured, cost-effective, reasonable manner.

If you deployed your Active Directory domain and core network before encountering the Core Network Guide, you can still use the Companion Guides to add features to your network. Simply use the Core Network Guide as a list of prerequisites, and know that to deploy additional features with the Companion Guides, your network must meet the prerequisites that are provided by the Core Network Guide.

## Core Network Companion Guide: Deploy Server Certificates for 802.1X Wired and Wireless Deployments 

This companion guide explains how to build upon the core network by deploying server certificates for computers that are running Network Policy Server \(NPS\), Remote Access Service \(RAS\), or both.

Server certificates are required when you deploy certificate-based authentication methods with Extensible Authentication Protocol \(EAP\) and Protected EAP \(PEAP\) for network access authentication. Deploying server certificates with Active Directory Certificate Services \(AD CS\) for EAP and PEAP certificate-based authentication methods provides the following benefits:

- Binding the identity of the NPS or RAS server to a private key
- A cost-efficient and secure method for automatically enrolling certificates to domain member NPS and RAS servers
- An efficient method for managing certificates and certification authorities
- Security provided by certificate-based authentication
- The ability to expand the use of certificates for additional purposes
  
For instructions on how to deploy server certificates, see [Deploy Server Certificates for 802.1X Wired and Wireless Deployments](server-certs/Deploy-Server-Certificates-for-802.1X-Wired-and-Wireless-Deployments.md).  
## Core Network Companion Guide: Deploy Password-Based 802.1X Authenticated Wireless Access

This companion guide explains how to build upon the core network by providing instructions about how to deploy Institute of Electrical and Electronics Engineers \(IEEE\) 802.1X\-authenticated IEEE 802.11 wireless access using Protected Extensible Authentication Protocol\–Microsoft Challenge Handshake Authentication Protocol version 2 \(PEAP\-MS\-CHAP v2\).

The authentication method PEAP\-MS\-CHAP v2 requires that authenticating servers running Network Policy Server \(NPS\) present wireless clients with a server certificate to prove the NPS identity to the client, however user authentication is not performed by using a certificate - instead, users provide their domain user name and password.

Because PEAP\-MS\-CHAP v2 requires that users provide password-based credentials rather than a certificate during the authentication process, it is typically easier and less expensive to deploy than EAP\-TLS or PEAP\-TLS.

Before you use this guide to deploy wireless access with the PEAP\-MS\-CHAP v2 authentication method, you must do the following:

1. Follow the instructions in the Core Network Guide to deploy your core network infrastructure, or already have the technologies presented in that guide deployed on your network.
2. Follow the instructions in the Core Network Companion Guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments, or already have the technologies presented in that guide deployed on your network.

For instructions on how to deploy wireless access with PEAP\-MS\-CHAP v2, see [Deploy Password-Based 802.1X Authenticated Wireless Access](wireless/a-deploy-8021X-wireless-access.md).

## Core Network Companion Guide: Deploy BranchCache Hosted Cache Mode

This companion guide explains how to deploy BranchCache in Hosted Cache Mode in one or more branch offices.

BranchCache is a wide area network (WAN) bandwidth optimization technology that is included in some editions of the Windows Server 2016 and Windows 10 operating systems, as well as in earlier versions of Windows and Windows Server.

When you deploy BranchCache in hosted cache mode, the content cache at a branch office is hosted on one or more server computers, which are called hosted cache servers. Hosted cache servers can run workloads in addition to hosting the cache, which allows you to use the server for multiple purposes in the branch office.

BranchCache hosted cache mode increases the cache efficiency because content is available even if the client that originally requested and cached the data is offline. Because the hosted cache server is always available, more content is cached, providing greater WAN bandwidth savings, and BranchCache efficiency is improved.

When you deploy hosted cache mode, all clients in a multiple-subnet branch office can access a single cache, which is stored on the hosted cache server, even if the clients are on different subnets.

For instructions on how to deploy BranchCache in Hosted Cache Mode, see [Deploy BranchCache Hosted Cache Mode](bc-hcm/1-Deploy-Bc-Hcm.md).

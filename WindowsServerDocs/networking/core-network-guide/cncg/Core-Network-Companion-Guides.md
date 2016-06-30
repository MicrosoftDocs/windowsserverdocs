---
title: Core Network Companion Guides
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d57af0bd-9301-4f62-9888-f528cd10451d
author: vhorne
---
# Core Network Companion Guides

>Applies To: Windows Server 2016 Technical Preview

While the Core Network Guide provides instructions on how to deploy a new Active Directory forest with a new root domain and the supporting networking infrastructure, Companion Guides provide you with the ability to add features to your network. Each companion guide allows you to accomplish a specific goal after you have deployed your core network. In some cases, there are multiple companion guides that, when deployed together and in the correct order, allow you to accomplish very complex goals in a measured, cost-effective, reasonable manner.  
  
If you deployed your Active Directory domain and core network before encountering the Core Network Guide, you can still use the Companion Guides to add features to your network. Simply use the Core Network Guide as a list of prerequisites, and know that to deploy additional features with the Companion Guides, your network must meet the prerequisites that are provided by the Core Network Guide.  
  
## Core Network Companion Guide: Deploy Server Certificates for 802.1X Wired and Wireless Deployments 
This guide explains how to build upon the foundation network by deploying server certificates for computers that are running Network Policy Server (NPS), Routing and Remote Access Service (RRAS), or both. Server certificates are required when you deploy certificate-based authentication methods with Extensible Authentication Protocol (EAP) and Protected EAP (PEAP) for network access authentication. Deploying server certificates with Active Directory Certificate Services (AD CS) for EAP and PEAP certificate-based authentication methods provides the following benefits:  
  
- Binding the identity of the NPS or RRAS server to a private key  
- A cost-efficient and secure method for automatically enrolling certificates to domain member NPS and RRAS servers  
- An efficient method for managing certificates and certification authorities  
- Security provided by certificate-based authentication  
- The ability to expand the use of certificates for additional purposes  
  
For instructions on how to deploy server certificates, see [Deploy Server Certificates for 802.1X Wired and Wireless Deployments](../../core-network-guide/cncg/server-certs/Deploy-Server-Certificates-for-802.1X-Wired-and-Wireless-Deployments.md).  
  


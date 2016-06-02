---
title: Overview of the Test Lab Scenario
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce584811-b209-48fe-ab2b-4c399bd0bd79
author: coreyp
---
# Overview of the Test Lab Scenario
Remote Access is a server role in the [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)], [!INCLUDE[winblue_server_1](includes/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](includes/win8_server_1_md.md)] operating systems that enables remote users to securely access internal network resources using DirectAccess or virtual private networks \(VPNs\) with the Routing and Remote Access Service \(RRAS\). This guide contains step\-by\-step instructions for extending the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](http://go.microsoft.com/fwlink/p/?LinkId=237004) to demonstrate a Remote Access one\-time password \(OTP\) configuration.  
  
> [!WARNING]  
> The design of this test lab guide includes infrastructure servers, such as a domain controller and a certification authority \(CA\) that are running either [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. Using this test lab guide to configure infrastructure servers that are running other operating systems has not been tested, and instructions for configuring other operating systems are not included in this guide.  
  
## About this guide  
Remote Access in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] adds support for client authentication with OTP. For the purposes of this test lab only RSA SecurID is used to demonstrate OTP functionality with Remote Access. Other RADIUS based OTP solutions are supported as well, but are outside the scope of this test lab. This guide contains instructions for configuring and demonstrating Remote Access using six servers and two client computers. The completed Remote Access with OTP test lab simulates an intranet, the Internet, and a home network, and demonstrates Remote Access functionality in different Internet connection scenarios.  
  
> [!IMPORTANT]  
> This lab is a proof of concept using the minimum number of computers. The configuration detailed in this guide is for test lab purposes only, and is not to be used in a production environment.  
  


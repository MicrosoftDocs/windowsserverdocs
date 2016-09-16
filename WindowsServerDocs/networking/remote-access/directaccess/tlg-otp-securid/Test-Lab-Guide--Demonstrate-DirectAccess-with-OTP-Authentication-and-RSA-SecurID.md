---
title: Test Lab Guide - Demonstrate DirectAccess with OTP Authentication and RSA SecurID
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 10c7a49c-5671-4bec-b562-13fdd67f4629
ms.author: coreyp
author: coreyp-at-msft
---
# Test Lab Guide: Demonstrate DirectAccess with OTP Authentication and RSA SecurID

>Applies To: Windows Server Technical Preview

Remote Access is a server role in the Windows Server&reg; 2016 Technical Preview, Windows Server&reg; 2012 R2 and Windows Server&reg; 2012 operating system that enables remote users to securely access internal network resources using DirectAccess or virtual private networks (VPNs) with the Routing and Remote Access Service (RRAS). This guide contains step-by-step instructions for extending the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](http://go.microsoft.com/fwlink/p/?LinkId=237004) to demonstrate a Remote Access one-time password (OTP) configuration.  
  
> [!WARNING]  
> The design of this test lab guide includes infrastructure servers, such as a domain controller and a certification authority (CA) that are running either Windows Server&reg; 2012 R2 or Windows Server&reg; 2012. Using this test lab guide to configure infrastructure servers that are running other operating systems has not been tested, and instructions for configuring other operating systems are not included in this guide.  
  
## About this guide  
Remote Access in Windows Server 2016 Technical Preview,  Windows Server 2012 R2  and  Windows Server 2012  adds support for client authentication with OTP. For the purposes of this test lab only RSA SecurID is used to demonstrate OTP functionality with Remote Access. Other RADIUS based OTP solutions are supported as well, but are outside the scope of this test lab. This guide contains instructions for configuring and demonstrating Remote Access using six servers and two client computers. The completed Remote Access with OTP test lab simulates an intranet, the Internet, and a home network, and demonstrates Remote Access functionality in different Internet connection scenarios.  
  
> [!IMPORTANT]  
> This lab is a proof of concept using the minimum number of computers. The configuration detailed in this guide is for test lab purposes only, and is not to be used in a production environment.  
  



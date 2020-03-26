---
title: Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c98106c-67cc-406a-810e-f2e09f7e2c5e
ms.author: lizross
author: eross-msft
---
# Test Lab Guide: Demonstrate a DirectAccess Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Remote Access is a server role in the  Windows Server 2016, Windows Server 2012 R2 and Windows Server 2012 operating systems that enables remote users to securely access internal network resources using DirectAccess or RRAS VPN. This guide contains step-by-step instructions for extending the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](https://go.microsoft.com/fwlink/p/?LinkId=237004) to demonstrate Remote Access in a multisite scenario.  
  
Deploying Remote Access in a multisite scenario enables you to configure Remote Access servers in geographically diverse locations. Previously, remote users were required to always connect to the corporate network through a particular DirectAccess server. With  Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012 and Windows 10 or Windows 8, you can configure entry points for each geographic location in your deployment. Each entry point can be a single Remote Access server or a cluster of Remote Access servers. Remote users have the option to connect to any of the organization's Remote Access entry points. For example, if a remote user usually connects to the Remote Access entry point located in Asia, but then goes on a business trip to Europe, the client computer automatically connects to the closest Remote Access entry point.  
  
## About this guide  
This guide contains instructions for configuring and demonstrating Remote Access using nine servers and three client computers. The completed Remote Access multisite test lab simulates an intranet, the Internet, and a home network and demonstrates Remote Access functionality in different Internet connection scenarios.  
  
> [!IMPORTANT]  
> This lab is a proof of concept using the minimum number of computers. The configuration detailed in this guide is for test lab purposes only, and is not to be used in a production environment.  
  



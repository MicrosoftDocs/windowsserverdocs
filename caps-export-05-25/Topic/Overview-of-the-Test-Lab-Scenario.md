---
title: Overview of the test lab scenario
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3ac9c36-4baf-442d-adb2-43a51b1ca95d
author: coreyp
---
# Overview of the test lab scenario
The Site\-to\-site VPN Corp\-to\-cloud test lab consists of the following:  
  
**Base Configuration test lab guide**  
  
-   One computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named DC1 that is configured as an intranet domain controller, Domain Name System \(DNS\) server, and Dynamic Host Configuration Protocol \(DHCP\) server.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named APP1 that is configured as a general application and web server.  
  
-   One member client computer running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] named CLIENT1 that will switch between Internet and intranet subnets.  
  
-   One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named EDGE1 that is configured as an Internet edge server.  
  
-   One standalone server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named INET1 that is configured as an Internet DNS server, web server, and DHCP server.  
  
The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Base Configuration test lab consists of two subnets that simulate the following:  
  
-   The Internet, referred to as the Internet subnet \(131.107.0.0\/24\).  
  
-   An intranet, referred to as the Corpnet subnet \(10.0.0.0\/24\), separated from the Internet subnet by EDGE1.  
  
Computers on each subnet connect using a physical hub, switch, or virtual switch. See the following figure for the configuration of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Base Configuration test lab.  
  
![](../Image/BaseConfigurationTLG.gif)  
  
**Corp\-to\-cloud test lab guide**  
  
Once the Base Configuration is in place, you will add the following three computers to create the cloud provider infrastructure:  
  
1.  One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named 3\-EDGE1 that is configured as an Internet edge server.  
  
2.  One intranet member server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] named 3DC\-1 that is configured as a domain controller.  
  
The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] The Corp\-to\-cloud test lab guide adds a subnet that simulates an intranet, referred to as Cloudnet subnet \(10.6.0.0\/24\) connected by site to site VPN to Corpnet by EDGE1 and 3\-EDGE1.  
  
Computers on each subnet connect using a physical hub, switch, or virtual switch. See the following figure for the configuration of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Corp\-to\-cloud test lab:  
  
![](../Image/Corp-to-cloudTLG.gif)  
  
In addition, you will configure EDGE1 and 3\-EDGE1 as site\-to\-site VPN servers to complete the Corp\-to\-Cloud test lab.  
  

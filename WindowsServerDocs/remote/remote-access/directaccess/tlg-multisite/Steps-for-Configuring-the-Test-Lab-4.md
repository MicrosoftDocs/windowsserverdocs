---
title: Steps for Configuring the Test Lab
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc7205b4-a822-4038-ab67-ec0a870737f2
ms.author: lizross
author: eross-msft
---
# Steps for Configuring the Test Lab

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following steps describe how to configure the Remote Access infrastructure, configure the Remote Access servers and clients and test DirectAccess connectivity from the Internet and Homenet subnets.  
  
In this test lab guide you will build a multisite Remote Access deployment by performing the following steps:  
  
-   [STEP 1: Complete the Base Configuration](assetId:///9eb4a9ba-9118-4ea3-8963-e643ec81c3ed). Complete all the steps in the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](https://go.microsoft.com/fwlink/p/?LinkId=237004).  
  
-   [STEP 2: Install and configure ROUTER1](assetId:///e4b1a298-d5b0-410e-970b-c5358a9378f9). ROUTER1 provides routing and forwarding functionality between the Corpnet and 2-Corpnet subnets.  
  
-   [STEP 3: Install and configure CLIENT2](assetId:///6cbee1b5-f6f6-443f-8fa9-31cc5c05a0ee). CLIENT2 is a  Windows 7  client computer that is used to demonstrate the backwards compatibility of a  Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012 Remote Access deployment.  
  
-   [STEP 4: Configure APP1](assetId:///a0ee655e-c01e-4bf3-a7b3-064e9614f810). Configure APP1 with ROUTER1 as the default gateway and 2-DC1 as the alternate DNS server.  
  
-   [STEP 5: Configure DC1](assetId:///205ca795-93ce-4e53-aa6b-b44c87f0e14a). Configure DC1 with an additional Active Directory site and additional security groups for  Windows 7  client computers.  
  
-   [STEP 6: Install and configure 2-DC1](assetId:///16752f61-edbf-4ff4-9d7a-e2077b66a127). In a multisite deployment, you have two or more domains and sites. 2-DC1 provides domain controller and DNS services for the corp2.corp.contoso.com domain.  
  
-   [STEP 7: Install and configure 2-APP1](assetId:///7d04b54e-590a-4d33-9766-415789859f29). 2-APP1 is a web and file server in the 2-Corpnet network.  
  
-   [STEP 8: Configure INET1](assetId:///8ecc0b63-8626-4939-8d26-3d51d051d231). INET1 simulates the Internet in this test lab guide. You must configure a DNS entry that resolves to the public IP address of 2-EDGE1.  
  
-   [STEP 9: Configure EDGE1](assetId:///562744dc-30f6-42fa-bd5f-60a013b2179e). Configure the 2-Corpnet DNS server and routing on EDGE1.  
  
-   [STEP 10: Install and configure 2-EDGE1](assetId:///1938c4f3-ca96-475d-9f2e-6bea3b7a4130). Two Remote Access servers are required in a multisite deployment. 2-EDGE1 provides Remote Access services for the second domain.  
  
-   [STEP 11: Configure multisite deployment](assetId:///537e4b68-043f-49c9-94d8-15ce8c4b18e2). After configuring both Remote Access servers, you can configure your multisite deployment.  
  
-   [STEP 12: Test DirectAccess connectivity](assetId:///aa293b5d-4b6f-4004-95f3-0ab54804b15c). Test DirectAccess connectivity from both client computers from the Internet subnet through EDGE1 and 2-EDGE1.  
  
-   [STEP 13: Test DirectAccess connectivity from behind a NAT device](assetId:///41f8195b-00a1-4991-9db8-3703514dbe0c). Test DirectAccess connectivity from behind a NAT device.  
  
-   [STEP 14: Snapshot the configuration](assetId:///7b56d5c9-c334-463e-9e29-d652ca110d84). After completing the test lab, take a snapshot of the working Remote Access multisite deployment so that you can return to it later to test additional scenarios.  
  



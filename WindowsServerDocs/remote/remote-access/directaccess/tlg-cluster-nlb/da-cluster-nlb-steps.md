---
title: Steps for Configuring the DirectAccess Cluster-NLB Test Lab
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e508d3ee-ffa6-463f-a3dd-9e35e745c005
ms.author: lizross
author: eross-msft
---
# Steps for Configuring the DirectAccess Cluster-NLB Test Lab

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following steps describe how to configure the Remote Access infrastructure, configure the Remote Access servers and clients, and test DirectAccess connectivity from the Internet and Homenet subnets.  
  
In this test lab guide you will build a Network Load Balancing (NLB) enabled Remote Access cluster by performing the following steps:  
  
-   [STEP 1 Complete the DirectAccess Configuration](STEP-1-Complete-the-DirectAccess-Configuration.md). Complete all the steps in the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](https://go.microsoft.com/fwlink/p/?LinkId=237004).  
  
-   [STEP 2: Configure EDGE1](STEP-2-Configure-EDGE1.md). Configure the Remote Access role on EDGE1 for load balancing.  
  
-   [STEP 3: Install and configure EDGE2](STEP-3-Install-and-Configure-EDGE2.md). EDGE2 acts as the second Remote Access server in a Remote Access cluster.  
  
-   [STEP 4: Create the network load balanced Remote Access cluster](STEP-4-Create-the-Network-Load-Balanced-Remote-Access-Cluster.md)-EDGE1 is configured as the first server in a Remote Access cluster. EDGE2 is joined to the cluster and NLB is configured for the cluster.  
  
-   [STEP 5: Test DirectAccess connectivity from the Internet and through the cluster](STEP-5-Test-DirectAccess-Connectivity-from-the-Internet-and-Through-the-Cluster.md). After NLB and cluster configuration is complete you can test DirectAccess client connectivity through the load balanced cluster.  
  
-   [STEP 6: Test DirectAccess client connectivity from behind a NAT device](STEP-6-Test-DirectAccess-Client-Connectivity-from-Behind-a-NAT-Device.md). Move the client computer behind a NAT device to simulate testing DirectAccess client connectivity from behind a home router.  
  
-   [STEP 7: Test connectivity when returning to the Corpnet](STEP-7-Test-Connectivity-When-Returning-to-the-Corpnet.md). Make sure that the client computer can still access corporate resources when returning to Corpnet.  
  
-   [STEP 8: Snapshot the configuration](da-cluster-nlb-s8-snapshot.md). After completing the test lab, take a snapshot of the working Remote Access NLB cluster so that you can return to it later to test additional scenarios.  
  



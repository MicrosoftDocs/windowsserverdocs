---
title: Steps for Configuring the Test Lab
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e508d3ee-ffa6-463f-a3dd-9e35e745c005
author: coreyp
---
# Steps for Configuring the Test Lab
The following steps describe how to configure the Remote Access infrastructure, configure the Remote Access servers and clients, and test DirectAccess connectivity from the Internet and Homenet subnets.  
  
In this test lab guide you will build a Network Load Balancing \(NLB\) enabled Remote Access cluster by performing the following steps:  
  
-   [STEP 1: Complete the DirectAccess test lab](assetId:///e14df5d0-f813-4079-8327-3e444ff5f101)—Complete all the steps in the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](http://go.microsoft.com/fwlink/p/?LinkId=237004).  
  
-   [STEP 2: Configure EDGE1](assetId:///f292ee3b-ca77-41f4-9ac3-c6ed5b244855)—Configure the Remote Access role on EDGE1 for load balancing.  
  
-   [STEP 3: Install and configure EDGE2](assetId:///e75e9778-0993-4f06-9421-6ddeaabfbd51)—EDGE2 acts as the second Remote Access server in a Remote Access cluster.  
  
-   [STEP 4: Create the network load balanced Remote Access cluster](assetId:///0607a59a-e295-4b5c-aabe-a299d461e544)—EDGE1 is configured as the first server in a Remote Access cluster. EDGE2 is joined to the cluster and NLB is configured for the cluster.  
  
-   [STEP 5: Test DirectAccess connectivity from the Internet and through the cluster](assetId:///1d10aefd-e240-491b-b7cf-6b8e1c0eb9a6)—After NLB and cluster configuration is complete you can test DirectAccess client connectivity through the load balanced cluster.  
  
-   [STEP 6: Test DirectAccess client connectivity from behind a NAT device](assetId:///56cfbafa-7a8d-4241-8930-b038e989b809)—Move the client computer behind a NAT device to simulate testing DirectAccess client connectivity from behind a home router.  
  
-   [STEP 7: Test connectivity when returning to the Corpnet](assetId:///399d51c2-0af3-43fb-8556-4cb169634842)—Make sure that the client computer can still access corporate resources when returning to Corpnet.  
  
-   [STEP 8: Snapshot the configuration](assetId:///0197db20-3e78-479a-ac42-378aea8fffaa)—After completing the test lab, take a snapshot of the working Remote Access NLB cluster so that you can return to it later to test additional scenarios.  
  


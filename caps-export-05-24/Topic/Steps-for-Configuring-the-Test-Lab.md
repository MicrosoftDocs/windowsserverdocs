---
title: Steps for Configuring the Test Lab
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fcb0565a-fc39-461b-b292-4d3caadc7404
---
# Steps for Configuring the Test Lab
The following steps describe how to configure the Remote Access infrastructure, configure the Remote Access servers and clients, and test DirectAccess connectivity from the Internet and Homenet subnets.  
  
In this test lab guide you will build a Network Load Balancing \(NLB\) enabled Remote Access cluster by performing the following steps:  
  
-   [STEP 1: Complete the DirectAccess Configuration_4](../Topic/STEP-1--Complete-the-DirectAccess-Configuration_4.md)—Complete all the steps in the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](http://go.microsoft.com/fwlink/p/?LinkId=237004).  
  
-   [STEP 2: Configure EDGE1](../Topic/STEP-2--Configure-EDGE1.md)—Configure the Remote Access role on EDGE1 for load balancing.  
  
-   [STEP 3: Install and Configure EDGE2_3](../Topic/STEP-3--Install-and-Configure-EDGE2_3.md)—EDGE2 acts as the second Remote Access server in a Remote Access cluster.  
  
-   [STEP 4: Create the Network Load Balanced Remote Access Cluster_1](../Topic/STEP-4--Create-the-Network-Load-Balanced-Remote-Access-Cluster_1.md)—EDGE1 is configured as the first server in a Remote Access cluster. EDGE2 is joined to the cluster and NLB is configured for the cluster.  
  
-   [STEP 5: Test DirectAccess Connectivity from the Internet and Through the Cluster](../Topic/STEP-5--Test-DirectAccess-Connectivity-from-the-Internet-and-Through-the-Cluster.md)—After NLB and cluster configuration is complete you can test DirectAccess client connectivity through the load balanced cluster.  
  
-   [STEP 6: Test DirectAccess Client Connectivity from Behind a NAT Device](../Topic/STEP-6--Test-DirectAccess-Client-Connectivity-from-Behind-a-NAT-Device.md)—Move the client computer behind a NAT device to simulate testing DirectAccess client connectivity from behind a home router.  
  
-   [STEP 7: Test Connectivity When Returning to the Corpnet_1](../Topic/STEP-7--Test-Connectivity-When-Returning-to-the-Corpnet_1.md)—Make sure that the client computer can still access corporate resources when returning to Corpnet.  
  
-   [STEP 8: Snapshot the Configuration_3](../Topic/STEP-8--Snapshot-the-Configuration_3.md)—After completing the test lab, take a snapshot of the working Remote Access NLB cluster so that you can return to it later to test additional scenarios.  
  

---
title: Steps for Configuring the Test Lab_3
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68f2ebae-6b33-4b5a-bfaa-911b5c365903
author: vhorne
---
# Steps for Configuring the Test Lab_3
The following steps describe how to configure the Remote Access infrastructure, configure the Remote Access servers and clients and test DirectAccess connectivity from the Internet and Homenet subnets.  
  
In this test lab guide you will build a multisite Remote Access deployment by performing the following steps:  
  
-   [STEP 1: Complete the DirectAccess Configuration_3](../Topic/STEP-1--Complete-the-DirectAccess-Configuration_3.md)—Complete all the steps in the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](http://go.microsoft.com/fwlink/p/?LinkId=237004).  
  
-   [STEP 2: Install and Configure ROUTER1_1](../Topic/STEP-2--Install-and-Configure-ROUTER1_1.md)—ROUTER1 provides routing and forwarding functionality between the Corpnet and 2\-Corpnet subnets.  
  
-   [STEP 3: Install and Configure CLIENT2_1](../Topic/STEP-3--Install-and-Configure-CLIENT2_1.md)—CLIENT2 is a [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] client computer that is used to demonstrate the backwards compatibility of a [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] Remote Access deployment.  
  
-   [STEP 4: Configure APP1_1](../Topic/STEP-4--Configure-APP1_1.md)—Configure APP1 with ROUTER1 as the default gateway and 2\-DC1 as the alternate DNS server.  
  
-   [STEP 5: Configure DC1](../Topic/STEP-5--Configure-DC1.md)—Configure DC1 with an additional Active Directory site and additional security groups for [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] client computers.  
  
-   [STEP 6: Install and Configure 2-DC1](../Topic/STEP-6--Install-and-Configure-2-DC1.md)—In a multisite deployment, you have two or more domains and sites. 2\-DC1 provides domain controller and DNS services for the corp2.corp.contoso.com domain.  
  
-   [STEP 7: Install and Configure 2-APP1](../Topic/STEP-7--Install-and-Configure-2-APP1.md)—2\-APP1 is a web and file server in the 2\-Corpnet network.  
  
-   [STEP 8: Configure INET1_1](../Topic/STEP-8--Configure-INET1_1.md)—INET1 simulates the Internet in this test lab guide. You must configure a DNS entry that resolves to the public IP address of 2\-EDGE1.  
  
-   [STEP 9: Configure EDGE1](../Topic/STEP-9--Configure-EDGE1.md)—Configure the 2\-Corpnet DNS server and routing on EDGE1.  
  
-   [STEP 10: Install and Configure 2-EDGE1](../Topic/STEP-10--Install-and-Configure-2-EDGE1.md)—Two Remote Access servers are required in a multisite deployment. 2\-EDGE1 provides Remote Access services for the second domain.  
  
-   [STEP 11: Configure the Multisite Deployment](../Topic/STEP-11--Configure-the-Multisite-Deployment.md)—After configuring both Remote Access servers, you can configure your multisite deployment.  
  
-   [STEP 12: Test DirectAccess Connectivity_1](../Topic/STEP-12--Test-DirectAccess-Connectivity_1.md)—Test DirectAccess connectivity from both client computers from the Internet subnet through EDGE1 and 2\-EDGE1.  
  
-   [STEP 13: Test DirectAccess Connectivity from Behind a NAT Device](../Topic/STEP-13--Test-DirectAccess-Connectivity-from-Behind-a-NAT-Device.md)—Test DirectAccess connectivity from behind a NAT device.  
  
-   [STEP 14: Snapshot the Configuration](../Topic/STEP-14--Snapshot-the-Configuration.md)—After completing the test lab, take a snapshot of the working Remote Access multisite deployment so that you can return to it later to test additional scenarios.  
  

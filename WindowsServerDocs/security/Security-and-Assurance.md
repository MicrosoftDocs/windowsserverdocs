---
title: Security and Assurance
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b886b2fd-3567-4f0a-8aa3-4ba7923d2d21
author: coreyp-at-msft
---
# Security and Assurance

>Applies To: Windows Server Technical Preview

This collection contains detailed information about security solutions and features for the IT professional to deploy in your datacenter and cloud environment. The following are security technologies and documentation for Windows Server 2016 Technical Preview.  
  
## Overview of Security in Windows Server 2016  
  
  
Link  |Description    
--------------|---------  
[Datacenter and Private Cloud Security Blog](https://blogs.technet.microsoft.com/datacentersecurity/)|This is the central blog site for technical content from the Microsoft Datacenter and Private Cloud Security team.  
[Windows Server Security YouTube channel](https://www.youtube.com/playlist?list=PL8nfc9haGeb5IZGM8HvmRozetHRpBDKSw)|You can find important technical videos about Windows Security on this channel.  
[Addressing emerging threats and landscape shifts](https://www.youtube.com/watch?v=B5JMYxYWx1k&feature=youtu.be)  | In this 6-minute video, Anders Vinberg provides an overview of Microsoft’s security and assurance strategy. Vinberg discusses industry trends and landscape shifts as they relate to security, and then focuses on Microsoft’s key initiatives to protect workloads from the underlying fabric, protect against direct attacks from privileged accounts, and, should intrusions happen, he explains how new detection and forensic capabilities can help better identify the threat.          
[Protecting Your Datacenter and Cloud from Emerging Threats blog post](http://blogs.technet.com/b/windowsserver/archive/2015/11/18/protecting-your-datacenter-and-cloud-november-update.aspx) |This blog post discusses how you can use Microsoft technologies to protect your datacenter and cloud investments from emerging threats.           
[Platform Vision & Strategy (5 of 7): Security and Assurance Overview (Ignite Video)](http://channel9.msdn.com/Events/Ignite/2015/BRK2482)   |This Ignite session addresses persistent threats, insider breaches, organized cybercrime, and securing the Microsoft Cloud Platform (on-premises and connected services with Azure). It includes scenarios for securing workloads, large enterprise tenants, and service providers.  
[Windows Server 2016 Security Blog Post](https://blogs.technet.microsoft.com/windowsserver/2016/04/25/ten-reasons-youll-love-windows-server-2016-8-security/)|This blog post from the Windows Server security team highlights many of the improvements in Windows Servers 2016 that increase security for hosting and hybrid cloud envrionments.    
  
  
  
## Introducing Shielded VMs  
  
  
Link  |Description   
---------|---------  
|[Shielded VM Demo](https://www.youtube.com/watch?v=SxfF9UT17p0&index=2&list=PL8nfc9haGeb5IZGM8HvmRozetHRpBDKSw) | This 4-minute describes the value of shielded VMs and the differences between a shielded VM and a non-shielded VM.  
[Shielded Virtual Machines in Windows Server video walkthrough](http://microsoft-cloud.cloudguides.com/Guides/Shielded%20Virtual%20Machines%20in%20Windows%20Server.htm)  |  This video walkthrough shows how the Host Guardian Service, a new role available in Windows Server 2016 Technical Preview, enables shielded virtual machines so that sensitive data is protected from unauthorized access by Hyper-V host administrators.         
[Harden the Fabric: Protecting Tenant Secrets in Hyper-V (Ignite Video)](http://channel9.msdn.com/Events/Ignite/2015/BRK3457)|This Ignite presentation discusses enhancements in Hyper-V, Virtual Machine Manager, and a new Guardian Server role to enable shielded VMs.     
[Guarded Fabric Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=708624) |This guide provides installation and validation information for Windows Server 2016 Technical Preview and System Center Virtual Machine Manager for Guarded Fabric Hosts and Shielded VMs.  
| [Shielded VM and Guarded Fabric Operations Guide](http://go.microsoft.com/fwlink/?LinkId=708320) |This guide provides best practices and recommendations for how to configure your Shielded VM environment, including information specific to Guarded Hosts and tenants.  
|[Shielded VM and Guarded Fabric Troubleshooting Guide](http://go.microsoft.com/fwlink/?LinkId=708321)|This guide provides information about how to resolve issues you may encounter in your Shielded VM environment.  
|[Shielded VM Article](http://windowsitpro.com/hyper-v/super-secure-hyper-v-environments-shielded-vms-2016)|This white paper provides an overview of how shielded VMs provide increase overall security to prevent tampering.  
## Privilged Access Management  
  
  
Link  |Description   
---------|---------  
[Securing Privileged Access](Securing-Privileged-Access\Securing-Privileged-Access.md) |This set of articles in the TechNet Library explains concepts and processes for securing privileged access.  
[Just in Time Administration with Microsoft Identity Manager](https://technet.microsoft.com/library/mt150258.aspx)  |This article discusses features and capabilities included in Microsoft Identity Manager, including support for Just In Time (JIT) Privileged Access Management.           
[Protecting Windows and Microsoft Azure Active Directory with<br />Privileged Access Management](http://channel9.msdn.com/Events/Ignite/2015/BRK3873) |This Ignite presentation covers Microsoft’s strategy and investments in Windows Server, PowerShell, Active Directory, Identity Manager, and Azure Active Directory for addressing the risks of administrator access through stronger authentication and managing access using Just in Time and Just Enough Administration.  
[Just Enough Administration Article](http://aka.ms/JEA)  | This document shares the vision and technical details of Just Enough Administration (JEA), a PowerShell toolkit designed to help organizations reduce risk by restricting operators to the only access required to perform specific tasks        
[JEA: A PowerShell Toolkit to Secure a Post-Snowden World](http://channel9.msdn.com/Events/Ignite/2015/BRK2470) |    This Ignite presentation discusses how you can use the Just Enough Administration PowerShell Toolkit to control administrator access and reduce breach expansion       
         
       
      
  
## Detecting and Responding to Threats  
  
  
  
Link  |Description  
---------|---------  
[Security Threat Analysis Using Microsoft Operations Management Suite](https://channel9.msdn.com/Events/Ignite/2015/BRK3464) |This Ignite presentation discusses how you can use Operational Insights to perform security threat analysis.         
[Microsoft Operations Management Suite (OMS)](https://www.microsoft.com/en-us/server-cloud/operations-management-suite/overview.aspx)   |The Microsoft Operations Management Suite (OMS) Security and Audit solution processes security logs and firewall events from on-premises and cloud environments to analyze and detect malicious behavior.   
[Microsoft Advanced Threat Analytics](http://blogs.technet.com/b/ad/archive/2015/07/22/microsoft-advanced-threat-analytics-coming-next-month.aspx)   |This blog post discusses Microsoft Advanced Threat Analytics, an on-premises product that uses Active Directory network traffic and SIEM data to discover and alert on potential threats.    
[Microsoft Advanced Threat Analytics](https://www.youtube.com/watch?v=0nA9FeTRZFw&list=PL8nfc9haGeb5IZGM8HvmRozetHRpBDKSw) | This 3-minute video presents an overview of how Microsoft is adding threat analytics capabilities in Windows Server 2016.  
   
## Network Security  
  
Link  |Description  
---------|---------  
[Datacenter Firewall Overview](https://technet.microsoft.com/library/dn920240.aspx)  |This overview discusses Datacenter Firewall, a network layer, 5-tuple (protocol, source and destination port numbers, source and destination IP addresses), stateful, multitenant firewall.   
      
[What's New in DNS in Windows Server 2016](../networking/dns/What-s-New-in-DNS-Server.md)  |This overview topic provides brief descriptions of new capabilities in DNS along with links for more information.   
  
  




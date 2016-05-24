---
title: Verifying DNS Configuration
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fd2d1025-40f5-4cc8-b81f-16acc2156b2a
author: Femila
---
# Verifying DNS Configuration
  Part of verifying Active Directory installation is verifying that Domain Name System \(DNS\) is installed and configured appropriately. Regarding DNS configuration for Active Directory forests, we recommend that you install the DNS Server service on all domain controllers. When you use the Active Directory Domain Services Installation Wizard to install DNS during installation of Active Directory Domain Services \(AD DS\), the wizard creates the DNS zone delegation automatically. The Net Logon service registers the required host and service resource records for the new domain controller when it restarts after installation.  
  
 The DNS Client service on a domain controller determines the DNS servers that the domain controller uses to locate other domain controllers. Verify that the primary and alternate DNS server settings are appropriate for the network segment.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   DNS snap\-in  
  
-   Network Connections  
  
 To complete this task, perform the following procedures:  
  
1.  [Verify DNS Server Configuration for a Domain Controller](../Topic/Verify-DNS-Server-Configuration-for-a-Domain-Controller.md)  
  
2.  [Verify DNS Client Settings](../Topic/Verify-DNS-Client-Settings.md)  
  
  
---
title: Configuring Windows-Based Clients to Synchronize Time
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 28988524-d691-4a4f-b24a-a84bb843d79e
author: Femila
---
# Configuring Windows-Based Clients to Synchronize Time
  Certain Windows\-based client computers do not automatically synchronize their time with their domain in Active Directory Domain Services \(AD DS\). The following client computers do not automatically synchronize to the domain time by using the Windows Time service \(W32time\):  
  
-   Client computers that run in a pre–Windows 2000 domain environment  
  
-   Client computers that run in a UNIX environment  
  
-   Computers that are not joined to a domain  
  
 You can configure these computers to request time from a particular time source, such as a domain controller in the domain. If you do not specify a source that is synchronized with the domain, each computer’s internal hardware clock governs its time.  
  
 **Task requirements**  
  
 The following tool is required to perform the procedures for this task:  
  
-   W32tm  
  
 To complete this task, you can perform the following procedures:  
  
-   [Configure a Manual Time Source for a Selected Client Computer](../Topic/Configure-a-Manual-Time-Source-for-a-Selected-Client-Computer.md)  
  
-   [Configure a Client Computer for Automatic Domain Time Synchronization](../Topic/Configure-a-Client-Computer-for-Automatic-Domain-Time-Synchronization.md)  
  
  
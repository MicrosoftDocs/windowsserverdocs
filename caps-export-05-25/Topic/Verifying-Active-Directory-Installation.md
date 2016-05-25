---
title: Verifying Active Directory Installation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 680432f8-1aeb-4253-bf91-e672e4ee160e
author: Femila
---
# Verifying Active Directory Installation
  There are several verification tasks that you can perform on a computer on which Active Directory Domain Services \(AD DS\) has been newly installed. Successfully completing the requirements of each verification task will provide a strong indication of a healthy, operational domain controller.  
  
 The individual procedures in this task are provided so that you can test specific criteria to determine the health of an Active Directory installation. To thoroughly test the domain controller for all directory service issues, you can run the **dcdiag \/v** command. The output of this command provides detailed information about the conditions on the domain controller. For information about using the Dcdiag.exe command\-line tool, see Dcdiag \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=104689](http://go.microsoft.com/fwlink/?LinkId=104689)\).  
  
 **Task requirements**  
  
 The following tools are recommended to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   DNS Manager  
  
-   Event Viewer  
  
-   Dcdiag.exe  
  
-   Ntdsutil.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Determine Whether a Server Object Has Child Objects](../Topic/Determine-Whether-a-Server-Object-Has-Child-Objects.md)  
  
2.  [Verify That an IP Address Maps to a Subnet and Determine the Site Association](../Topic/Verify-That-an-IP-Address-Maps-to-a-Subnet-and-Determine-the-Site-Association.md)  
  
     Check that the new domain controller is located in the correct site so that the new domain controller can locate replication partners and become part of the replication topology.  
  
3.  [Move a Server Object to a New Site](../Topic/Move-a-Server-Object-to-a-New-Site.md)  
  
     If you have performed an unattended installation and the domain controller was not placed in the site that you expected, you can move the server object to the correct site.  
  
4.  [Configure DNS Server Forwarders](../Topic/Configure-DNS-Server-Forwarders.md)  
  
5.  Complete all procedures for the [Verifying DNS Configuration](../Topic/Verifying-DNS-Configuration.md) task.  
  
6.  [Check the Status of the SYSVOL and Netlogon Shares](../Topic/Check-the-Status-of-the-SYSVOL-and-Netlogon-Shares.md)  
  
7.  [Verify DNS Registration and TCP - IP Connectivity](../Topic/Verify-DNS-Registration-and-TCP---IP-Connectivity.md)  
  
8.  [Verify a Domain Computer Account for a New Domain Controller](../Topic/Verify-a-Domain-Computer-Account-for-a-New-Domain-Controller.md)  
  
9. [Verify Active Directory Replication](../Topic/Verify-Active-Directory-Replication.md)  
  
10. [Verify the Availability of the Operations Masters](../Topic/Verify-the-Availability-of-the-Operations-Masters.md)  
  
  
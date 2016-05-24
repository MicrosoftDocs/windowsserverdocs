---
title: Require Encryption When Accessing Sensitive Network Resources
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1ce57aa6-1253-4002-a04c-64d1a4d859de
author: vhorne
---
# Require Encryption When Accessing Sensitive Network Resources
The use of authentication in the previously described goal \([Restrict Access to Only Trusted Computers](../Topic/Restrict-Access-to-Only-Trusted-Computers.md)\) enables a computer in the isolated domain to block traffic from untrusted computers. However, it does not prevent an untrusted computer from eavesdropping on the network traffic shared between two trusted computers, because by default network packets are not encrypted.  
  
For computers that share sensitive information over the network, [!INCLUDE[wfas](../Token/wfas_md.md)] allows you to require that all such network traffic be encrypted. Using encryption can help you comply with regulatory and legislative requirements such as those found in the Federal Information Security Management Act of 2002 \(FISMA\), the Sarbanes\-Oxley Act of 2002, the Health Insurance Portability and Accountability Act of 1996 \(HIPAA\), and other government and industry regulations. By creating connection security rules that apply to computers that host and exchange sensitive data, you can help protect the confidentiality of that data by encrypting it.  
  
The following illustration shows an encryption zone in an isolated domain. The rules that implement both the isolated domain and the different zones are deployed by using Group Policy and Active Directory.  
  
![](../Image/WFAS-DomainISOEncrypt.gif)  
  
This goal provides the following benefits:  
  
-   Computers in the encryption zone require authentication to communicate with other computers. This works no differently from the domain isolation goal and design. For more information, see [Restrict Access to Only Trusted Computers](../Topic/Restrict-Access-to-Only-Trusted-Computers.md).  
  
-   Computers in the encryption zone require that all inbound and outbound network traffic be encrypted.  
  
    For example, Woodgrove Bank processes sensitive customer data on a computer that must be protected from eavesdropping by computers on the network. Connection security rules specify that all traffic must be encrypted by a sufficiently complex encryption algorithm to help protect the data.  
  
-   Computers in the encryption zone are often good candidates for server isolation, where access is limited to only computer accounts and user accounts that are members of an authorized access group. In many organizations, the encryption zone and the server isolation zone are one and the same. For more information, see [Restrict Access to Only Specified Users or Computers](../Topic/Restrict-Access-to-Only-Specified-Users-or-Computers.md).  
  
The following components are required for this deployment goal:  
  
-   **Active Directory**: Active Directory supports centralized management of connection security rules by configuring the rules in one or more GPOs that can be automatically applied to all relevant computers in the domain. For more information about Active Directory, see [Additional Resources_2](../Topic/Additional-Resources_2.md).  
  
**Next:**[Restrict Access to Only Specified Users or Computers](../Topic/Restrict-Access-to-Only-Specified-Users-or-Computers.md)  
  

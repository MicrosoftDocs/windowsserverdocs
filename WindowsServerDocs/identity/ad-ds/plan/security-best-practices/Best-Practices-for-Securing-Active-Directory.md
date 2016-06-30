---
title: Best Practices for Securing Active Directory
ms.custom: 
  - AD
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1550791a-361c-4399-92c8-ac3fe862ee02
author: Femila
---
# Best Practices for Securing Active Directory

>Applies To: Windows Server Technical Preview

This document provides a practitioner's perspective and contains a set of practical techniques to help IT executives protect an enterprise Active Directory environment. Active Directory plays a critical role in the IT infrastructure, and ensures the harmony and security of different network resources in a global, interconnected environment. The methods discussed are based largely on the Microsoft Information Security and Risk Management (ISRM) organization's experience, which is accountable for protecting the assets of Microsoft IT and other Microsoft Business Divisions, in addition to advising a selected number of Microsoft Global 500 customers.  
  
-   [Foreword](https://technet.microsoft.com/library/dn487451.aspx)  
  
-   [Acknowledgements](https://technet.microsoft.com/library/dn487445.aspx)  
  
-   [Executive Summary](../../../ad-ds/manage/component-updates/Executive-Summary.md)  
  
-   [Introduction](../../../ad-ds/manage/component-updates/Introduction.md)  
  
-   [Avenues to Compromise](../../../ad-ds/plan/security-best-practices/Avenues-to-Compromise.md)  
  
-   [Attractive Accounts for Credential Theft](../../../ad-ds/plan/security-best-practices/Attractive-Accounts-for-Credential-Theft.md)  
  
-   [Reducing the Active Directory Attack Surface](../../../ad-ds/plan/security-best-practices/Reducing-the-Active-Directory-Attack-Surface.md)  
  
-   [Implementing Least-Privilege Administrative Models](../../../ad-ds/plan/security-best-practices/Implementing-Least-Privilege-Administrative-Models.md)  
  
-   [Implementing Secure Administrative Hosts](../../../ad-ds/plan/security-best-practices/Implementing-Secure-Administrative-Hosts.md)  
  
-   [Securing Domain Controllers Against Attack](../../../ad-ds/plan/security-best-practices/Securing-Domain-Controllers-Against-Attack.md)  
  
-   [Monitoring Active Directory for Signs of Compromise](../../../ad-ds/plan/security-best-practices/Monitoring-Active-Directory-for-Signs-of-Compromise.md)  
  
-   [Audit Policy Recommendations](../../../ad-ds/plan/security-best-practices/Audit-Policy-Recommendations.md)  
  
-   [Planning for Compromise](../../../ad-ds/plan/security-best-practices/Planning-for-Compromise.md)  
  
-   [Maintaining a More Secure Environment](../../../ad-ds/plan/security-best-practices/Maintaining-a-More-Secure-Environment.md)  
  
-   [Summary of Best Practices](../../../ad-ds/plan/security-best-practices/Summary-of-Best-Practices.md)  
  
-   [Appendices](../../../ad-ds/plan/security-best-practices/Appendices.md)  
  
-   [Appendix A: Patch and Vulnerability Management Software](../../../ad-ds/plan/security-best-practices/Appendix-A--Patch-and-Vulnerability-Management-Software.md)  
  
-   [Appendix B: Privileged Accounts and Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-B--Privileged-Accounts-and-Groups-in-Active-Directory.md)  
  
-   [Appendix C: Protected Accounts and Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-C--Protected-Accounts-and-Groups-in-Active-Directory.md)  
  
-   [Appendix D: Securing Built-In Administrator Accounts in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory.md)  
  
-   [Appendix E: Securing Enterprise Admins Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory.md)  
  
-   [Appendix F: Securing Domain Admins Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-F--Securing-Domain-Admins-Groups-in-Active-Directory.md)  
  
-   [Appendix G: Securing Administrators Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-G--Securing-Administrators-Groups-in-Active-Directory.md)  
  
-   [Appendix H: Securing Local Administrator Accounts and Groups](../../../ad-ds/plan/security-best-practices/Appendix-H--Securing-Local-Administrator-Accounts-and-Groups.md)  
  
-   [Appendix I: Creating Management Accounts for Protected Accounts and Groups in Active Directory](../../../ad-ds/manage/component-updates/Appendix-I--Creating-Management-Accounts-for-Protected-Accounts-and-Groups-in-Active-Directory.md)  
  
-   [Appendix J: Third-Party RBAC Vendors](../../../ad-ds/plan/security-best-practices/Appendix-J--Third-Party-RBAC-Vendors.md)  
  
-   [Appendix K: Third-Party PIM Vendors](../../../ad-ds/plan/security-best-practices/Appendix-K--Third-Party-PIM-Vendors.md)  
  
-   [Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md)  
  
-   [Appendix M: Document Links and Recommended Reading](../../../ad-ds/manage/Appendix-M--Document-Links-and-Recommended-Reading.md)  
  



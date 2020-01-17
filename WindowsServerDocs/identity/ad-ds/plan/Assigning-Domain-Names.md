---
ms.assetid: 73897497-b189-4305-b234-e057ffda163a
title: Assigning Domain Names
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Assigning Domain Names

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You must assign a name to every domain in your plan. Active Directory Domain Services (AD DS) domains have two types of names: Domain Name System (DNS) names and NetBIOS names. In general, both names are visible to end users. The DNS names of Active Directory domains include two parts, a prefix and a suffix. When creating domain names, first determine the DNS prefix. This is the first label in the DNS name of the domain. The suffix is determined when you select the name of the forest root domain. The following table lists the prefix naming rules for DNS names.  
  
|Rule|Explanation|  
|--------|---------------|  
|Select a prefix that is not likely to become outdated.|Avoid names such as a product line or operating system that might change in the future. We recommend using geographical names.|  
|Select a prefix that includes Internet standard characters only.|A-Z, a-z, 0-9, and (-), but not entirely numerical.|  
|Include 15 characters or less in the prefix.|If you choose a prefix length of 15 characters or less, the NetBIOS name is the same as the prefix.|  
  
For more information, see Naming conventions in Active Directory for computers, domains, sites, and OUs ([https://go.microsoft.com/fwlink/?LinkId=106629](https://go.microsoft.com/fwlink/?LinkId=106629)).  
  
> [!NOTE]  
>  Although Dcpromo.exe in Windows Server 2008 and Windows Server 2003 allows you to create a single-label DNS domain name, you should not use a single-label DNS name for a domain for several reasons. In Windows Server 2008 R2, Dcpromo.exe does not allow you to create a single-label DNS name for a domain. For more information, see [https://go.microsoft.com/fwlink/?LinkId=92467.](https://go.microsoft.com/fwlink/?LinkId=92467)   
  
If the current NetBIOS name of the domain is inappropriate to represent the region or fails to satisfy the prefix naming rules, select a new prefix. In this case, the NetBIOS name of the domain is different from the DNS prefix of the domain.  
  
For each new domain that you deploy, select a prefix that is appropriate for the region and that satisfies prefix naming rules. We recommend that the NetBIOS name of the domain be the same as the DNS prefix.  
  
Document the DNS prefix and NetBIOS names that you select for each domain in your forest. You can add the DNS and NetBIOS name information to the "Domain Planning" worksheet that you created to document your plan for new and upgraded domains. To open it, download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip from Job Aids for Windows Server 2003 Deployment Kit ([https://go.microsoft.com/fwlink/?LinkID=102558](https://go.microsoft.com/fwlink/?LinkID=102558)) and open "Domain Planning" (DSSLOGI_5.doc).  
  



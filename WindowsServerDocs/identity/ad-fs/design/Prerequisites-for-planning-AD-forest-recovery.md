title: Prerequisites for planning for Active Directory Forest Recovery
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 04/05/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.assetid: c49b40b2-598d-49aa-85b4-766bce960e0d
ms.technology: identity-adfs
---

This topic describes the virtualized domain controller cloning feature in Windows Server 2016, 2012 R2, and 2012.  
  
-   [Using virtualized domain controller cloning in Windows Server 2012 to expedite forest recovery](#BKMK_VDC)  
  
-   [Assumptions for Using This Guide for Planning Active Directory Forest Recovery](#BKMK_Assumptions)  
  
-   [Prerequisites for Using This Guide for Planning Active Directory Forest Recovery](#BKMK_Prereq)  
  
<a name="BKMK_VDC"></a>   
## Using virtualized domain controller cloning in Windows Server 2012 to expedite forest recovery  
 Virtualized domain controller (DC) cloning simplifies and expedites the process for installing additional virtualized DCs in a domain, especially in centralized locations such as datacenters where several DCs run on hypervisors. After you restore one virtual DC in each domain from backup, additional DCs in each domain can be rapidly brought online by using the virtualized DC cloning process. You can prepare the first virtualized DC that you recover, shut it down, and then copy that virtual hard disk as many times as is necessary in order to create cloned virtualized DCs to build out the domain.  
  
 The requirements for virtualized DC cloning are:  
  
-   The hypervisor must support VM-GenerationID. Hyper-V in Windows Server 2012 and Windows 8 is an example of a hypervisor that supports VM-GenerationID. Check with your hypervisor vendor if VM-GenerationID is supported.  
  
-   The virtualized DC that is used as a source for cloning must run Windows Server 2012 and be a member of the Cloneable Domain Controllers group.  
  
-   The PDC emulator must run Windows Server 2012. You can clone PDC emulator if it is virtualized.  
  
 For step-by-step instructions about how to perform virtualized DC cloning, see [Introduction to Active Directory Domain Services (AD DS) Virtualization (Level 100)](http://technet.microsoft.com/library/hh831734.aspx). For details about how virtualized DC cloning works, see [Virtualized Domain Controller Technical Reference (Level 300)](http://technet.microsoft.com/library/jj574214.aspx).  
  
<a name="BKMK_Assumptions"></a>   
## Assumptions for Using This Guide for Planning Active Directory Forest Recovery  
 First, this guide assumes that you have:  
  
-   Worked with Microsoft Support to determine the cause of the forest-wide failure. This guide does not suggest a cause of the failure or recommend any procedures to prevent the failure.  
  
-   Evaluated any possible remedies.  
  
-   Concluded, in consultation with Microsoft Support, that restoring the whole forest to its state before the failure occurred is the best way to recover from the failure. In many cases, forest recovery should be the last option.  
  
 Second, this guide assumes that you have followed the Microsoft best-practice recommendations for using Active Directory–integrated Domain Name System (DNS). Specifically, there should be an Active Directory–integrated DNS zone for each Active Directory domain. If this is not the case, you can still use the basic principles of this guide to perform forest recovery. However, you will need to take specific measures for DNS recovery based on your own environment. For more information about using Active Directory–integrated DNS, see [Designing a DNS Infrastructure to Support Active Directory](http://technet.microsoft.com/library/cc773132.aspx).  
  
 Although the objectives of this guide are to recover the forest and maintain or restore full DNS functionality, recovery can result in a DNS configuration that is changed from the configuration before the failure. After the forest is recovered, you can revert to the original DNS configuration. The recommendations in this guide do not describe how to configure DNS servers to perform name resolution of other portions of the corporate namespace where there are DNS zones that are not stored in AD DS.  
  
 Finally, although this guide is intended as a generic guide for forest recovery, not all possible scenarios are covered. For instance, beginning with Windows Server 2008, there is a Server Core version, which is a full version of Windows Server but without a full GUI. Although it is certainly possible to recover a forest consisting of just DCs that run Server Core, this guide has no detailed instructions. However, based on the guidance discussed here you will be able to design the required command-line actions yourself.  
  
<a name="BKMK_Prereq"></a>   
## Prerequisites for Using This Guide for Planning Active Directory Forest Recovery  
 Before you begin planning for recovery of an Active Directory forest, you should be familiar with the following:  
  
-   Fundamental Active Directory concepts  
  
-   The importance of operations master roles (also known as flexible single master operations or FSMO). These roles include the following:  
  
    -   Schema master  
  
    -   Domain naming master  
  
    -   Relative ID (RID) master  
  
    -   Primary domain controller (PDC) emulator master  
  
    -   Infrastructure master  
  
 In addition, you should have backed up and restored AD DS and SYSVOL in a lab environment on a regular basis. For more information, see [Backing up the System State data](../Topic/Appendix%20A:%20Forest%20Recovery%20Procedures.md#BKMK_Backup) and [Performing a nonauthoritative restore of Active Directory Domain Services](../Topic/Appendix%20A:%20Forest%20Recovery%20Procedures.md#BKMK_NonAuthoritativeRestore).
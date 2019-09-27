---
title: AD Forest Recovery Virtualization
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: c49b40b2-598d-49aa-85b4-766bce960e0d
ms.technology: identity-adds
---
# Active Directory Forest Recovery Virtualization

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

This topic describes the virtualized domain controller cloning feature in Windows Server 2016, 2012 R2, and 2012.  

## Using virtualized domain controller cloning to expedite forest recovery

Virtualized domain controller (DC) cloning simplifies and expedites the process for installing additional virtualized DCs in a domain, especially in centralized locations such as datacenters where several DCs run on hypervisors. After you restore one virtual DC in each domain from backup, additional DCs in each domain can be rapidly brought online by using the virtualized DC cloning process. You can prepare the first virtualized DC that you recover, shut it down, and then copy that virtual hard disk as many times as is necessary in order to create cloned virtualized DCs to build out the domain.  
  
The requirements for virtualized DC cloning are:  
  
- The hypervisor must support VM-GenerationID. Hyper-V in Windows Server 2016, 2012 and Windows 8 is an example of a hypervisor that supports VM-GenerationID. Check with your hypervisor vendor if VM-GenerationID is supported.  
- The virtualized DC that is used as a source for cloning must run Windows Server 2016 or 2012 and be a member of the Cloneable Domain Controllers group. 
- The PDC emulator must run Windows Server 2016 or 2012. You can clone PDC emulator if it is virtualized.  
  
For step-by-step instructions about how to perform virtualized DC cloning, see [Introduction to Active Directory Domain Services (AD DS) Virtualization (Level 100)](../Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md). For details about how virtualized DC cloning works, see [Virtualized Domain Controller Technical Reference (Level 300)](../deploy/virtual-dc/virtualized-domain-controller-technical-reference--level-300-.md). 

## Next steps

- [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)  
- [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)  
- [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)
- [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)
- [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
- [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)  
- [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)  
- [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md) 

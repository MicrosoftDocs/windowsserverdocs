---
title: AD Forest Recovery - Procedures
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 47a471fb-3b0b-4aa8-8525-1c92d0d51e93
ms.technology: identity-adds
---
# AD Forest Recovery - Procedures

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

This section contains procedures related to the forest recovery process. The procedures are applicable for Windows Server 2016, 2012 R2, 2012 and are also applicable to Windows Server 2008 R2 and 2008 with some minor exceptions.

Procedures that include steps that vary for Windows Server 2003 are found in [Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md).  

The following is a list of procedures that are used in backing up and restoring domain controllers and Active Directory.

- [Backing up a full server](AD-Forest-Recovery-Backing-up-a-Full-Server.md)  
- [Backing up the System State data](AD-Forest-Recovery-Backing-up-System-State.md)  
- [Performing a full server recovery](AD-Forest-Recovery-Perform-a-Full-Recovery.md)  
- [Performing an authoritative synch of DFSR-replicated SYSVOL](AD-Forest-Recovery-Authoritative-Recovery-SYSVOL.md)
- [Performing a nonauthoritative restore of Active Directory Domain Services](AD-Forest-Recovery-Nonauthoritative-Restore.md)  

These steps explain how to perform an authoritative restore of SYSVOL at the same time.  

- [Configuring the DNS Server service](AD-Forest-Recovery-Configure-DNS.md)  
- [Removing the global catalog](AD-Forest-Recovery-Remove-GC.md)  
- [Raising the value of available RID pools](AD-Forest-Recovery-Raise-RID-Pool.md)  
- [Invalidating the current RID pool](AD-Forest-Recovery-Invaildate-RID-Pool.md)  
- [Seizing an operations master role](AD-Forest-Recovery-Seizing-Operations-Master-Role.md)  
- [Cleaning up after a restore](AD-Forest-Recovery-Cleanup.md)
- [Cleaning metadata of removed writable domain controllers](AD-Forest-Recovery-Cleaning-Metadata.md)  
- [Resetting the computer account password of the domain controller](AD-Forest-Recovery-Reset-Computer-Account-DC.md)  
- [Resetting the krbtgt password](AD-Forest-Recovery-Resetting-the-krbtgt-password.md)  
- [Resetting a trust password on one side of the trust](AD-Forest-Recovery-Reset-Trust.md)  
- [Adding the global catalog](AD-Forest-Recovery-Add-GC.md)  
- [Resources to verify replication is working](AD-Forest-Recovery-Verify-Replication.md)  

## Next Steps

- [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)  
- [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)  
- [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)
- [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)
- [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
- [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)  
- [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)  
- [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md) 

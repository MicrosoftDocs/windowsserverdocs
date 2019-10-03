---
title: AD Forest Recovery - FAQ 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: ac9e5a3d-8b1e-41b7-8e02-f64b7acf1359
ms.technology: identity-adds
---
# AD Forest Recovery - FAQ

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2, Windows Server 2003

This document contains frequently asked questions (FAQs) regarding forest recovery:  

## General Recovery

**Q: What can I do to speed up recovery?**

Although speed of recovery is not the primary goal of this guide, you can achieve shorter recovery times by:  
  
- Creating a detailed forest recovery plan, updating it on a regular basis, and practicing it in a simulated test environment of reasonable size at least once a year  
- Using virtualized domain controller (DC) cloning  
   - Virtualized DC cloning expedites the process to get additional DCs running after one DC is restored from backup in each domain. The additional virtualized DCs can be cloned rather than waiting for potentially lengthy AD DS installations to be completed and for the completion of non-critical replication after installation.  
   - Forests where virtual DCs are hosted in a relatively small number of well-connected data centers potentially benefit most from cloning during recovery. However, any environment where multiple virtualized DCs for the same domain are co-located on the same hypervisor host should benefit.  
- Deploying read-only domain controllers (RODCs)  
   - RODCs can provide business continuity during the recovery process because they do not have to be disconnected from the network as writable DCs do. RODCs do not perform outbound replication. Therefore, they do not present the same risk that writable DCs pose for replicating damaging data back into the recovered environment.  
  
Other factors that affect the duration of the forest recovery process include the following:  
  
- When you restore DCs from backups, it takes time to:  
   - Locate the physical backup media, such as tapes.  
   - Reinstall the operating system.  
   - Restore data from backup media.  
      - You can reduce the time required to reinstall the operating system and restore data from backup by performing full server recovery instead of system state restore. Because full server recovery is binary-based, it completes much faster than system state restore.  
      - However, if the server contains data that is excluded from system state data that you do not want to restore, full server recovery might not be a viable alternative to system state restore. Consider the advantages of performing a full server recovery instead of a system state restore for your servers specifically, and prepare accordingly by performing the appropriate type of backup that you plan to restore later.  
- When you rebuild DCs, it takes time to replicate data for network-based promotions.  
   - You can decrease the time required for restoring DCs by performing the following steps:  
- Reduce the time for retrieving backup media by:  
   - Using the Active Directory Database Mounting Tool (Dsamain.exe) to identify the best backup to use for restore operations. For more information about using the Active Directory Database Mounting Tool, see the [Active Directory Database Mounting Tool Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkId=132577) (https://go.microsoft.com/fwlink/?LinkId=132577).  
   - Labeling the backup media clearly and storing the media in an organized fashion at a convenient, yet secure, location that allows fast retrieval.  
   - Using the Volume Shadow Copy Service with a storage area network (SAN) to maintain backups from different points in time. For more information, see [Windows Server 2003 Active Directory Fast Recovery with Volume Shadow Copy Service and Virtual Disk Service](https://go.microsoft.com/fwlink/?LinkId=70781) (https://go.microsoft.com/fwlink/?LinkId=70781).  
- Force the removal of AD DS from the DCs instead of reinstalling the operating system. If the cause of the forest-wide failure has been identified to be purely within the scope of AD DS, you do not have to reinstall the operating system on the DCs.  
   - For more information about forcing the removal of AD DS from a DC that runs Windows Server 2008 or later, see [Forcing the Removal of a Windows Server 2008 Domain Controller](https://go.microsoft.com/fwlink/?LinkId=132627) (https://go.microsoft.com/fwlink/?LinkId=132627). For more information about forcing the removal of AD DS from a DC that runs Windows Server 2003, see [article 332199](https://go.microsoft.com/fwlink/?LinkId=70780) in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkId=70780).  
- Use faster tape devices or disk backups to reduce the time that is required for restore operations.  
  
You can also help accelerate AD DS installations by using the Install from Media (IFM) feature to rebuild DCs in each domain. IFM reduces the replication latency that is incurred when you rebuild DCs in each domain.  
  
Businesses that have a more aggressive service-level agreement (SLA) might consider altering the forest recovery procedures to speed recovery.  
  
**Q: Can I automate the forest recovery process?**

Because of the complex and critical nature of the forest recovery process, there is currently no end-to-end automation of it. The forest recovery process is more a logistical and organizational challenge of restoring business continuity than a technical problem of process automation. Therefore, the individual who administers the environment should create a forest recovery plan that is specific to that environment and then automate sections of it that can be automated successfully.  
  
You can perform most of the forest recovery steps by using command-line tools. Therefore, most of the steps are scriptable. For example, Ntdsutil.exe is one of the most frequently used tools in the forest recovery process.  
  
Although scripts can speed recovery, you must thoroughly test these scripts before you apply them in a real environment. Also, you must update them according to changes in the Active Directory environment, such as the addition of a new domain or DC, or a new version of Active Directory.

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

---
title: Active Directory Operational Monitoring Service
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ed958673-57c1-4e33-9d1e-1711263e68b3
author: Femila
---
# Active Directory Operational Monitoring Service
  This Microsoft Premier Service offers an in\-depth understanding and hands\-on demonstration of Active Directory monitoring best practices. Even with monitoring tools already in place, this information is invaluable. By performing regular monitoring tasks, customers can reduce potential domain controller downtime, impact to user workflow, and ensure a healthy state of their Active Directory environments and all of the technology it supports.  
  
 This offering outlines the recommended daily, weekly, and monthly checks that should be performed for all Active Directory related technologies, including:  
  
-   Active Directory Replication  
  
-   Domain Controller Health  
  
-   Active Directory Object Health  
  
-   Domain Naming System \(DNS\)  
  
-   Windows Time Service  
  
-   SYSVOL Replication with FRS or DFSR  
  
 Each monitoring task provides detailed guidance on why we recommend the task and how to accomplish it. If you have had an Active Directory Risk Assessment in the past, you may have been asked several questions about if and how you monitor Active Directory. This offering will help you close the gap on why these tasks are so important. In addition, we provide several ways of completing the monitoring tasks with built\-in tools, sample Windows PowerShell scripts, and examples using System Center Operations Monitor.  
  
 Below are a few samples of what the offering provides and the level of detail it brings to your organization.  
  
-   [Monitor Replication Status (Active Directory Replication)](../Topic/Active-Directory-Operational-Monitoring-Service.md#BKMK_MonitorReplStatus)  
  
-   [Monitor DIT Database Partition Backup Signatures (Domain Controller Health)](../Topic/Active-Directory-Operational-Monitoring-Service.md#BKMK_MonitorDBPartitionBackupSigs)  
  
-   [Monitor for Orphaned Site Link Objects (Directory Object Health)](../Topic/Active-Directory-Operational-Monitoring-Service.md#BKMK_MonitorOrphanedSiteLinks)  
  
-   [Monitor for Orphaned Group Policy Templates (GPTs) (Directory Object Health)](../Topic/Active-Directory-Operational-Monitoring-Service.md#BKMK_MonitorOrphanedGPTs)  
  
##  <a name="BKMK_MonitorReplStatus"></a> Monitor Replication Status \(Active Directory Replication\)  
  
|||  
|-|-|  
|Frequency|**DAILY**|  
|Description|Monitor Active Directory replication status across all domain controllers in the forest.|  
|Reason|Identify problems and high replication latency by showing the current status of replication connections from each specified domain controller.|  
|Risks|Active Directory replication must be monitored to ensure all domain controllers are receiving updates for all directory objects and attributes. Failure to monitor replication could leave the administrative staff unaware that domain controllers are not receiving updates for extended periods of time. This can result in inconsistencies across domain controllers in the domain or forest and possibly blocked replication or introduce lingering objects from the non\-replicating domain controllers.|  
|Tool, Utility, Script|REPADMIN.EXE<br /><br /> \(Included with Windows Server 2003 Support Tools and Windows Server 2008 R2 built\-in tools when the AD DS Role is installed. It is also available in Remote Server Administration Tools \(RSAT\)\)|  
|Explanation|REPADMIN \/REPLSUMMARY summarizes the replication state and relative health of an Active Directory forest. This is done by inventorying and contacting every domain controller in the forest and collecting information such as replication deltas and replication failures.<br /><br /> It will also identify any domain controllers that could not be contacted and would report the failure reason. Note: Each dot after the first three dots represents a domain controller, with a maximum of 50 dots per line.|  
|Tool Information Resource|[Monitoring and Troubleshooting Active Directory Replication Using Repadmin](http://technet.microsoft.com/library/cc811551(v=ws.10))|  
|Scope|Replication scope between specified domain controller replication partners.|  
|Permission|Domain User|  
|Task \/ Command|REPADMIN \/REPLSUMMARY \* \/BYSRC \/BYDEST<br /><br /> Additional samples are provided in the actual service delivery|  
|Output Review|Provides examples of how to use the tools<br /><br /> Actual samples are provided in the delivery along with the most common errors and information to look for.|  
|Remediation Reference|[Monitor Forest\-Wide Replication](http://technet.microsoft.com/library/cc811556(v=ws.10))|  
  
##  <a name="BKMK_MonitorDBPartitionBackupSigs"></a> Monitor DIT Database Partition Backup Signatures \(Domain Controller Health\)  
  
|||  
|-|-|  
|Frequency|**DAILY**|  
|Description|Monitor Active Directory dSASignature has been set for each naming context \(NC\) on each domain controller being backed up in the forest.|  
|Reason|To identify if backups are not running correctly or backing up all NCs on each domain controller in the back\-up set.|  
|Risks|If the dSASignature is not being set this would identify backup issues on the domain controller and further troubleshooting should take place to identify the error. Note: Performing this test does not mitigate against backup failures, this procedure merely identifies database partitions that do not have the backup signature set. This should be used in conjunction with regular testing of all backups of domain controllers in all domains in the forest.|  
|Tool, Utility, Script|REPADMIN.EXE<br /><br /> \(Included with Windows Server 2003 Support Tools and Windows Server 2008 R2 built\-in tools when the AD DS Role is installed. It is also available in Remote Server Administration Tools \(RSAT\)\)|  
|Explanation|The DSA Signature attribute is modified every time that a system state backup is made. The operating system monitors this attribute. An event error message is logged when the backup latency interval criteria are met. Any domain controller that runs Windows Server 2003 SP1 or later may log the event because the DSA Signature attribute is a replicated attribute.<br /><br /> Note: This test only checks the dSASignature flag is being set. Regular system state restore procedures should still be undertaken to ensure they are valid and useable in the event of a domain controller restore operation.|  
|Tool Information Resource|[Monitoring and Troubleshooting Active Directory Replication Using Repadmin](http://technet.microsoft.com/library/cc811551(v=ws.10))|  
|Scope|Domain and forest specific for all application partitions|  
|Permission|Domain User|  
|Task \/ Command|REPADMIN \/showbackup \*<br /><br /> Additional samples are provided in the actual service delivery|  
|Output Review|Provides examples of how to use the tool\(s\)<br /><br /> Actual samples are provided in the delivery along with the most common errors and information to look for.|  
|Remediation Reference|[http:\/\/support.microsoft.com\/?id\=216993](http://support.microsoft.com/?id=216993)|  
  
##  <a name="BKMK_MonitorOrphanedSiteLinks"></a> Monitor for Orphaned Site Link Objects \(Directory Object Health\)  
  
|||  
|-|-|  
|Frequency|**MONTHLY**|  
|Description|Monitor orphaned site link objects|  
|Reason|Check for site links with 1 or 0 associated site objects.|  
|Risks|If a site link has become orphaned and only contains 1 site object, the site link will not be used by KCC. Although this does not pose as a risk, orphaned site link objects should either have an additional site added or should be deleted.|  
|Tool, Utility, Script|DSQUERY.EXE<br /><br /> \(Included with Windows Server 2003 Support Tools and Windows Server 2008 R2 built\-in tools when the AD DS Role is installed. It is also available in Remote Server Administration Tools \(RSAT\)\)|  
|Explanation|N\/A|  
|Tool Information Resource|[Dsquery](http://technet.microsoft.com/library/cc732952(WS.10).aspx)|  
|Scope|Domain\-wide|  
|Permission|Domain User|  
|Task \/ Command|dsquery \* "cn\=IP,cn\=inter\-site transports,CN\=Sites,cn\=configuration,\<DOMAIN\-DN\>" \-attr cn sitelist<br /><br /> Additional samples are provided in the actual service delivery|  
|Output Review|Provides examples of how to use the tools<br /><br /> Actual samples are provided in the delivery along with the most common errors and information to look for.|  
|Remediation|[http:\/\/technet.microsoft.com\/library\/cc740125\(WS.10\).aspx](http://technet.microsoft.com/library/cc740125(WS.10).aspx)|  
  
##  <a name="BKMK_MonitorOrphanedGPTs"></a> Monitor for Orphaned Group Policy Templates \(GPTs\) \(Directory Object Health\)  
  
|||  
|-|-|  
|Frequency|**MONTHLY**|  
|Description|Monitor for orphaned GPTs|  
|Reason|Identify GPO templates that have become orphaned in the SYSVOL\\Policies share folder.|  
|Risks|N\/A|  
|Tool, Utility, Script|FindOrphanedGPOsInSYSVOL.WSF \(GPMC Scripts\)<br /><br /> \(Included with Group Policy Management Console \(GPMC\) in Windows Server 2003 or later, or available as a separate download from: [http:\/\/www.microsoft.com\/downloads\/details.aspx?FamilyId\=38C1A89B\-A6D2\-4F2A\-A944\-9236999AEE65&displaylang\=en](http://www.microsoft.com/downloads/details.aspx?FamilyId=38C1A89B-A6D2-4F2A-A944-9236999AEE65&displaylang=en)\)|  
|Explanation|All GPOs consists of both Active Directory objects and folders and files in SYSVOL. The folder in SYSVOL is called a group policy template \(GPT\) folder. A GPT folder contains a GPOs setting that clients download when processing that GPO. When a GPO is deleted, both its AD objects and folders and files should be deleted. However, if anything is holding one or more files or folders in the GPT folder open, it will be left behind. This is called an orphaned GPT.|  
|Tool Information Resource|[Scripting Group Policy\-related Tasks](http://technet.microsoft.com/library/cc776655(WS.10).aspx)|  
|Scope|Domain\-wide|  
|Permission|Domain User|  
|Task \/ Command|cscript FindOrphanedGPOsInSYSVOL.wsf \/Domain:\<DNS\-DOMAIN\-NAME\><br /><br /> Additional samples are provided in the actual service delivery|  
|Output Review|Provides examples of how to use the tools<br /><br /> Actual samples are provided in the delivery along with the most common errors and information to look for.|  
|Remediation|[Group Policy Management Console Scripting Samples](http://msdn.microsoft.com/library/aa814151(VS.85).aspx)|  
  
## See Also  
 [Installing Remote Server Administration Tools](http://technet.microsoft.com/library/cc731420(v=ws.10))  
  
  
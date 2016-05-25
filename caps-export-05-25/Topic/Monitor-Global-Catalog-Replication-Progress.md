---
title: Monitor Global Catalog Replication Progress
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4475769a-fbfe-4de0-941c-d1649d98c8df
author: Femila
---
# Monitor Global Catalog Replication Progress
  You can monitor inbound replication progress to see the percentage of completeness of partial, read\-only, directory partition replication to the new global catalog server.  
  
> [!NOTE]  
>  Although you can change occupancy level requirements for global catalog advertisement to force advertisement to occur before full replica occupancy, doing so can cause e\-mail and search issues. Exchange servers use the global catalog for Address Book lookup. Therefore, in addition to causing Active Directory client search problems, the condition of a global catalog server being advertised before it receives all partial replicas can cause Address Book lookup and e\-mail delivery problems for Exchange clients.  
  
 Membership in **Domain Users** and the right to log on locally to the domain controller is the minimum required to complete this procedure. By default, members of **Account Operators**, **Administrators**, **Enterprise Admins**, **Domain Admins**, **Backup Operators**, **Print Operators**, and **Server Operators** have the right to log on locally to a domain controller. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To monitor global catalog replication progress  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /s:<servername> /v | find "%"`  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |s:\<servername\>|Specifies the name of the global catalog server that you want to monitor.|  
    |\/v &#124; find "%"|Finds the percentage of replication, and provides extended information.|  
  
3.  Repeat this command periodically to monitor progress. If the test shows no output, replication has completed.  
  
  
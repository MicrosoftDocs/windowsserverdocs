---
title: WSUS: Only required languages should be selected in the WSUS Configuration Wizard
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3db31079-2a9e-4c3b-a9cf-52b8506024c5
author: britw
---
# WSUS: Only required languages should be selected in the WSUS Configuration Wizard
*This topic is intended to address a specific issue identified by a [!INCLUDE[bpa](../Token/bpa_md.md)] \(BPA\) scan. You should apply the information in this topic only to computers that have had the Windows Server Update Services 3.0 SP2 \(WSUS\) [!INCLUDE[bpa](../Token/bpa_md.md)] run against them and are experiencing the issue addressed by this topic. For more information about [!INCLUDE[bpa](../Token/bpa_md.md)] and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786) on Microsoft TechNet.*  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**Product\/Feature**|Windows Server Update Services 3.0 SP2 \(WSUS 3.0 SP2\)|  
|**Severity**|Warning|  
|**Category**|Performance|  
  
## Issue  
  
> *All or multiple update languages are selected in the Configuration Wizard.*  
  
## Impact  
  
> *If all or multiple languages are selected, a large portion of disk space will be used. This option could easily fill the content drive to capacity.*  
  
## Resolution  
  
> *Select only required languages. Run WSUS Server Cleanup Wizard.*  
  
You can save disk space by choosing to obtain updates only for specific languages. The WSUS Configuration Wizard or the WSUS Administration Console lets you configure WSUS to receive updates for all languages or from a subset of languages. For detailed instructions on how to configure WSUS to receive updates for specific languages, see [Step 4: Configure Updates and Synchronization](http://go.microsoft.com/fwlink/?LinkId=168875) on Microsoft TechNet or download the [Windows Server Update Services 3.0 SP2 Step By Step Guide](http://go.microsoft.com/fwlink/?LinkId=139836) from the Microsoft Download Center.  
  
The Server Cleanup Wizard is integrated into the user interface of WSUS 3.0 SP2, and can be used to help you manage your disk space. This wizard can do the following:  
  
-   Remove unused updates and update revisions.  
  
    The wizard will remove all older updates and update revisions that are not approved.  
  
-   Delete computers not contacting the server.  
  
    The wizard will delete all client computers that have not contacted the server in thirty days or more.  
  
-   Delete unnecessary update files.  
  
    The wizard will delete all update files that are not needed by updates or by downstream servers.  
  
-   Decline expired updates.  
  
    The wizard will decline all updates that were expired by Microsoft.  
  
-   Decline superseded updates.  
  
    The wizard will decline all updates that meet all the following criteria:  
  
    -   The superseded update is optional.  
  
    -   The superseded update was on the server for thirty days or more.  
  
    -   The superseded update is currently not reported as needed by any client.  
  
    -   The superseded update has not been explicitly deployed to a computer group for ninety days or more.  
  
    -   The superseding update must be approved for install to a computer group.  
  
#### To run the Server Cleanup Wizard  
  
1.  In the WSUS administration console, select **Options**, and then **Server Cleanup Wizard**.  
  
2.  By default, this wizard will remove nonessential content and computers that have not contacted the server for 30 days or more. Select all possible options, and then click **Next**.  
  
3.  The wizard will begin the cleanup process, and will present a summary of its work when it is finished. Click **Finish** to complete the process.  
  
In some cases, especially if you run the Server Cleanup Wizard on a WSUS 3.0 SP2 server that has WSUS 2.0 downstream servers, you may see differences in update metadata on upstream and downstream servers. If this is the case, you may resolve your problem by restarting the upstream server or recycling the WSUS Application pool.  
  
#### To recycle the WSUS Application Pool in IIS  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Internet Information Services \(IIS\) Manager**.  
  
2.  In the tree view, expand the tree under the WSUS server name, and then expand **Application Pools**.  
  
3.  Right\-click **WSUSPool**, and then click **Recycle**.  
  
4.  Close [!INCLUDE[iismgr](../Token/iismgr_md.md)].  
  

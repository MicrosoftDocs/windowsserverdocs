---
title: WSUS: The SelfUpdate folder should be installed correctly on the default Web site or the WSUS Administration site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 309b2281-c23e-4a7b-8e82-f05f7b8b59ed
author: britw
---
# WSUS: The SelfUpdate folder should be installed correctly on the default Web site or the WSUS Administration site
*This topic addresses a specific issue identified by a [!INCLUDE[bpa](../Token/bpa_md.md)] scan. You should apply the information in this topic only to computers that have had the Windows Server Update Services \(WSUS\) [!INCLUDE[bpa](../Token/bpa_md.md)] run against them and are experiencing the issue addressed by this topic. For more information about [!INCLUDE[bpa](../Token/bpa_md.md)] and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786) on Microsoft TechNet.*  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**Product\/Feature**|Windows Server Update Services 3.0 SP2 \(WSUS 3.0 SP2\)|  
|**Severity**|Error|  
|**Category**|Operation|  
  
## Issue  
  
> *The SelfUpdate folder is missing or incorrectly installed on the default Web site or the WSUS Administration site.*  
  
## Impact  
  
> *Windows Update Agents will fail to verify the required version of the installed agent, which is required to communicate with the server. This will prevent Windows Update Agents from scanning for new updates or reporting their current status to the server.*  
  
## Resolution  
  
> *Create a SelfUpdate folder on the default Web site or the WSUS Administration site.*  
  
To make sure that the self\-update tree is working correctly, first make sure that there is a Web site set up on port 80 of the WSUS server. You must have a Web site that is running on port 80, even if you put the WSUS Web site on a custom port. The Web site that is running on port 80 does not have to be dedicated to WSUS. WSUS uses the site on port 80 only to host the self\-update tree. After verifying the Web site on port 80, you should run the WSUS script to guarantee a correct configuration of self\-update on port 80. Open a Command prompt on the WSUS server and type the following:  
  
**cscript***WSUSInstallDirectory***\\setup\\installselfupdateonport80.vbs** \(*WSUSInstallDirectory* is the directory in which WSUS is installed\).  
  
For more information about SelfUpdate, see [Issues with Client Self\-Update](http://go.microsoft.com/fwlink/?LinkId=189716) on Microsoft TechNet or download the [Windows Server Update Services 3.0 SP2 Operations Guide](http://go.microsoft.com/fwlink/?LinkId=139838) from the Microsoft Download Center.  
  

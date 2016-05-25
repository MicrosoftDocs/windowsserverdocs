---
title: Update Status Report Terminology for WSUS 3.0 SP2
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d10ba0c8-8d94-4bc5-a82d-bc8872e68667
author: britw
---
# Update Status Report Terminology for WSUS 3.0 SP2
WSUS provides update status reports for computers and computer groups in the WSUS network. You can filter the default views by update status and in some cases by combinations of status \(**Failed or Needed**, **Installed\/Not Applicable**, **No Status**, and so on\). The following table defines the status conditions that can be reported for an update.  
  
### Update Status Definitions  
  
|Status|Description|  
|----------|---------------|  
|Installed|The update is installed on the computer.|  
|Needed|When it refers to the status of one computer, **Needed** means that the update is compatible with \(and should be installed on\) the computer. When it refers to the status for a computer group, the **Needed** column displays the number of computers in the group to which the update is applicable. A positive **Needed** result means that the update is applicable, but it was not installed the last time that client computers contacted the WSUS server. Any of the following can be true when the status for an update is **Needed**:<br /><br />-   You have approved the update for installation but the client computers have not contacted the WSUS server since you approved it.<br />-   The update has already been downloaded and installed, but the client computer has not contacted the WSUS server since the update was installed.<br />-   The update has already been downloaded and installed, but the client computer must be restarted before changes go into effect. The client computer has not been restarted.<br />-   The update has been downloaded to the computer but has not been installed.<br />-   The update has not been downloaded or installed on the computer.|  
|Installed\/Not Applicable|When it refers to the status of one computer, **Installed\/Not Applicable** means that the update is not applicable to or required by that computer. When it refers to the status for a computer group, the **Installed\/Not Applicable** column displays the number of computers in the group for which the update is not applicable or not required.|  
|No status|**No status** usually means that the computer has not contacted the WSUS server since the update was synchronized.|  
|Failed|An error occurred when a detection or an installation was attempted on the computer.|  
|Last contacted|The date that the computer last contacted the WSUS server.|  
  

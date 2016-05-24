---
title: NTFS Health and Chkdsk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c380d9f-1840-4055-9780-4c46477680fc
---
# NTFS Health and Chkdsk
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] enables customers to confidently deploy multiterabyte NTFS file system volumes, which supports consolidation scenarios and maximizes storage utilization. Historically, customers have not deployed large NTFS volumes. The average deployment sizes were approximately 500 gigabyte \(GB\) because in the event of file system corruption, the entire volume would be offline for an indeterminate period of time. Chkdsk in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] introduces a new approach that prioritizes volume availability and allows for the detection of corruption while the volume remains online with data available.  
  
The new model of chkdsk has the following benefits:  
  
-   Customers can confidently deploy large volumes. Corruption\-related downtime is now proportional to only the number of corruptions on the volume.  
  
-   Customers who are using clustered shared volumes do not see any downtime, even for correcting corruption events that would normally require a remount.  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] actively monitors the health state of the file system volume, and it always provides the health state to the administrator.  
  
-   Customers do not see any downtime for transient corruption events.  
  
-   Customers experience significantly fewer corruption events.  
  
## Requirements  
  
-   Chkdsk is enabled by default on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   No special hardware is needed.  
  
## Technical overview  
In the event of file system corruption in previous versions of Windows Server, the file system volume would be taken offline, and its data would be unavailable for an indeterminate period of time while chkdsk ran and attempted to repair the corruption. The time for chkdsk to complete was proportional to the number of files on the volume, and this time could not be accurately predicted by customers. For a single corruption issue, the entire volume and all of its files would still be analyzed offline. This model was problematic for customers because it potentially imposed significant downtimes, which made it challenging for customers to meet necessary business objectives. In addition, analysis indicated that a significant portion of file system corruptions were due to transient errors—chkdsk would run, but it would not find any actual corruption.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] addresses this problem by prioritizing file system availability, even when corruption is present, and developing a new model for managing file system corruption. The model includes:  
  
-   Improved self\-healing: NTFS instantaneously self\-heals more issues online without requiring chkdsk to run offline. This reduces the number of times that chkdsk is required to run.  
  
-   Online analysis: In the previous model, almost all of the offline time required to run chkdsk was spent scanning and analyzing the drive. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the analysis phase of chkdsk, which was responsible for the majority of the offline time, becomes an online, background task. This allows the volume to remain online and available while the system determines whether there is corruption. There is also added logic in the model that verifies the type of corruption is not transient, preventing unnecessary analysis.  
  
-   Corruption correction: When the scan is completed, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] informs the administrator \(by using events and the management consoles\), that the volumes need to be repaired and suggests a solution, such as performing a remount or reboot. Because the analysis phase has already completed, no additional scanning or detection is required. Chkdsk directly fixes the identified corruption, and the offline time is minimized to seconds. Therefore, the offline time for a volume is no longer proportional to the number of files on the volume, but rather to the number of corruptions on the volume.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] always provides the current health state of the file system volume by using standard events that indicate the current state of the volume. The following figure illustrates how significantly the new chkdsk model changes downtime in the event of corruption.  
  
![](../Image/1_Chkdsk_Rev_Guide.gif)  
  
**Figure 1** Chkdsk downtimes  
  

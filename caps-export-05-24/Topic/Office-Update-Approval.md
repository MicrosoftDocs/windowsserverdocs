---
title: Office Update Approval
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 31b5f2b1-dd8c-49ea-bc92-51b27b7ad3c9
author: britw
---
# Office Update Approval
If you use WSUS to update Microsoft Office on your network computers, consider the following:  
  
-   You must use an original baseline source for Microsoft Office Administrative Install Points \(AIP\) to use WSUS to update Office XP and Office 2003 on client computers. If you are applying updates to the AIP, you cannot use WSUS. The two methods of applying updates are mutually exclusive. If you have applied an update to an AIP and want to roll back the AIP to an original baseline source, follow the instructions in [article 902349](http://go.microsoft.com/fwlink/?LinkId=63962) in the Microsoft Knowledge Base.  
  
> [!IMPORTANT]  
> Administrative Install Points are relevant only to Office XP and Office 2003. They are not used with Office 2007.  
  
-   If you have installed Microsoft Office per user, WSUS will not update Office.  
  
-   Users can access the public Microsoft Office Online website to look for updates to their Office installation through the Microsoft Office Update wizard. By using Group Policy, you can create policies that prevent users from getting Office updates from Microsoft Office Online.  
  
For more information and troubleshooting advice, see the following articles in the Microsoft Knowledge Base:  
  
-   If updates are offered to a user even though it has already been installed, see [Article 903775](http://go.microsoft.com/fwlink/?LinkId=78874) .  
  
-   If no applicable Microsoft Office updates are displayed when you use Microsoft Update or Windows Server Update Services, see [Article 903773](http://go.microsoft.com/fwlink/?LinkId=78871)  
  
-   For information on how to change an administrative installation point, see [Article 902349](http://go.microsoft.com/fwlink/?LinkId=78872)  
  

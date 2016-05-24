---
title: Set the synchronization schedule using the WSUS Server Configuration Wizard
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cec47d01-add3-46ed-ab27-8aa6d00a7ae0
author: britw
---
# Set the synchronization schedule using the WSUS Server Configuration Wizard
The **Set Sync Schedule** page in the WSUS server configuration wizard lets you set synchronization options. You can synchronize updates manually, or you can schedule automated synchronizations. The default option is to synchronize updates manually. You can perform a manual synchronization by using the WSUS Administration console.  
  
## <a name="procsynch"></a>To set the synchronization schedule  
  
-   To synchronize manually:  
  
    1.  Select **Synchronize manually**.  
  
    2.  Click **Next**.  
  
-   To synchronize automatically:  
  
    1.  Select **Synchronize automatically**.  
  
    2.  In the **First synchronization** text box, set the time of day when the first synchronization should occur.  
  
    3.  In the **Synchronizations per day** drop\-down menu, indicate how many times within each 24 hour period the WSUS server should synchronize. You can synchronize between 1 and 24 times in any 24\-hour period. The default setting is 1 time.  
  
        > [!NOTE]  
        > If the WSUS server is set to automatically synchronize with Microsoft Updates, the synchronization start time has a random offset up to 30 minutes from the synchronization time that you schedule.  
  
    4.  Click **Next**.  
  

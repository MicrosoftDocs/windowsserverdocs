---
title: Schedule WSUS synchronizations using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8d98368a-d40c-43ee-a129-5ec745accb30
author: britw
---
# Schedule WSUS synchronizations using the WSUS Administration Console
During synchronization, a WSUS server downloads updates \(update metadata and files\) from an update source. It also downloads any new product classifications and categories. When a WSUS server synchronizes for the first time, it downloads all of the updates that were specified in the synchronization options. After the first synchronization, a WSUS server downloads only updates from the update source, metadata revisions for existing updates, and expirations to updates.  
  
> [!NOTE]  
> The first time that a WSUS server downloads updates can be a lengthy process. If you are setting up multiple WSUS servers, you can speed up the process by downloading all the updates onto one WSUS server and then copying the updates to the content directories of other WSUS servers. Update metadata must be downloaded separately to each server.  
  
If a replica server fails to synchronize with the upstream server, it will retry the synchronization two times at approximately fifteen\-minute intervals. If both tries fail, the replica server will synchronize at the next scheduled time.  
  
## Synchronize updates by product and classification  
A WSUS server downloads updates for products or product families.  
  
If a WSUS server is running in replica mode, you cannot specify products and classifications; you can only perform this task on the root server. For more information about replica mode, see [Replica mode \(centralized administration\)](../Topic/Design-the-WSUS-Server-Layout.md#replica) and [Manage WSUS Replica Servers](../Topic/Manage-WSUS-Replica-Servers.md).  
  
> [!NOTE]  
> You can remove products or classifications in the same way. Your WSUS server will stop synchronizing new updates for the products you have cleared. However, updates that were synchronized for those products before you cleared them will remain on your WSUS server, and they will be listed as available. For more information about removing unused updates, see [Issues with Update Storage](../Topic/Issues-with-Update-Storage.md).  
  
## Synchronize updates by language  
A WSUS server downloads updates based on the languages that you specify. You can synchronize updates in all of the languages in which they are available, or you can specify a subset of languages. If you have a hierarchy of WSUS servers, and you need to download updates in different languages, make sure that you have specified all the necessary languages on the upstream server. On a downstream server you can specify a subset of the languages that you specified on the upstream server.  
  
## <a name="notifications"></a>Set the synchronization schedule  
The **Set Sync Schedule** page lets you set synchronization options. You can synchronize the [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] server to receive updates manually, or you can schedule automated synchronizations. The default option is to synchronize manually. You can perform a manual synchronization by using the WSUS Administration console.  
  
### <a name="procsynch"></a>To set the synchronization schedule  
  
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
  

---
title: Configure a Client Computer for Automatic Domain Time Synchronization
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d4daffe1-d40b-4e45-b77e-55b151bcc6fe
author: Femila
---
# Configure a Client Computer for Automatic Domain Time Synchronization
  By default, a computer that is joined to a domain synchronizes time through the domain hierarchy of reliable time sources. However, if a computer has been manually configured to synchronize from a specific time source—perhaps because it was formerly not joined to the domain—you must reconfigure the computer to begin sourcing its time from the domain hierarchy. You can use this procedure to configure a client computer that is currently synchronizing with a manually specified computer to synchronize time automatically from the domain hierarchy.  
  
> [!NOTE]  
>  The following procedure uses the **w32tm** command\-line tool. For more information about the **w32tm** command, type **w32tm \/?** at a command prompt or see Windows Time Service Tools and Settings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112116](http://go.microsoft.com/fwlink/?LinkId=112116)\).  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **the Domain Admins** group, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure a client computer for automatic domain time synchronization  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /config /syncfromflags:domhier /update  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |W32tm \/config \/update|Configures the computer for time synchronization.|  
    |\/syncfromflags:domhier|Specifies that time is synchronized with computers in the domain hierarchy.|  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net stop w32time  
    ```  
  
4.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net start w32time  
    ```  
  
  
---
title: Change the Windows Time Service Configuration on the PDC Emulator in the Forest Root Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4864003a-bf7c-4156-a011-91352a36a76c
author: Femila
---
# Change the Windows Time Service Configuration on the PDC Emulator in the Forest Root Domain
  The domain controller in the forest root domain that holds the primary domain controller \(PDC\) emulator operations master \(also known as flexible single master operations or FSMO\) role is the default time source for the domain hierarchy of time sources in the forest. When you create the forest, you configure this domain controller either to connect to a manual time source \(an external Network Time Protocol \(NTP\) server or a hardware clock device on the internal network\) or to use its own internal clock as its time source.  
  
 If you move the PDC emulator role to another domain controller or if you decide to configure a different domain controller as the reliable time source for the forest, you can use this procedure to change the Windows Time service \(W32time\) configuration on the PDC emulator that is currently configured as the reliable time source for the forest.  
  
> [!NOTE]  
>  The following procedure uses the **w32tm** command\-line tool. For more information about the **w32tm** command, type **w32tm \/?** at a command prompt or see Windows Time Service Tools and Settings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112116](http://go.microsoft.com/fwlink/?LinkId=112116)\).  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the Windows Time service configuration on the PDC emulator in the forest root domain  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /config /syncfromflags:domhier /reliable:no /update  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |W32tm \/config \/update|Configures the client to synchronize time.|  
    |\/syncfromflags:domhier|Specifies that time will be synchronized with the nearest time source in the domain hierarchy. Because this domain controller is in the forest root domain, it will synchronize with a reliable time source in the forest root domain.|  
    |\/reliable:no|Removes the status of reliable time source.|  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net stop w32time  
    ```  
  
4.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net start w32time  
    ```  
  
## See Also  
 [Videos about the Windows Time Service](http://www.microsoft.com/showcase/en/us/search?phrase=w32time)  
  
  
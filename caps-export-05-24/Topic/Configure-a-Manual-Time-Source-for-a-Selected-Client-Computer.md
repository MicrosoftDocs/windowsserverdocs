---
title: Configure a Manual Time Source for a Selected Client Computer
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 210981e2-753b-459e-8ab5-98f2dfba767b
author: Femila
---
# Configure a Manual Time Source for a Selected Client Computer
  You can use this procedure to configure a manual time source for a selected client computer. The default method of synchronizing time in a Windows forest is through the domain hierarchy, in which a client connects to a domain controller in its domain as its time source. A manual time source is a specified computer or computers from which the client synchronizes its time when it cannot synchronize through the domain hierarchy. To configure a computer for automatic domain time synchronization, see [Configure a Client Computer for Automatic Domain Time Synchronization](../Topic/Configure-a-Client-Computer-for-Automatic-Domain-Time-Synchronization.md).  
  
 Before you configure a manual time source for a client computer, you can determine the time difference between the time source and the computer as a means of testing basic Network Time Protocol \(NTP\) communication. After you complete the configuration of the manual time source on the client computer, be sure to monitor the System log in Event Viewer for Windows Time service \(W32time\) errors.  
  
> [!NOTE]  
>  The following procedure uses the **w32tm** command\-line tool. For more information about the **w32tm** command, type **w32tm \/?** at a command prompt or see Windows Time Service Tools and Settings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112116](http://go.microsoft.com/fwlink/?LinkId=112116)\).  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **the Domain Admins** group, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure a manual time source for a selected client computer  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click `Run as administrator`. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  To display the time difference between the local computer and a time source, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /stripchart /computer:<target> /samples:<n> /dataonly  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |W32tm \/stripchart|Displays a strip chart of the offset between synchronizing computers. A strip chart plots two\-dimensional data—in this case, the local time and the offset.|  
    |\/computer:\<target\>|Specifies the Domain Name System \(DNS\) name or IP address of the NTP server that you are comparing the local computer's time against, such as time.windows.com.|  
    |\/samples:\<n\>|Specifies the number of time samples that will be returned from the target computer to test basic NTP communication.|  
    |\/dataonly|Specifies that results show only data, not graphics.|  
  
3.  Open UDP port 123 for outgoing traffic on the firewall, if necessary.  
  
4.  Open UDP port 123 \(or a different port that you have selected\) for incoming NTP traffic.  
  
5.  To configure a manual time source for the selected computer, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /config /manualpeerlist:<peers> /syncfromflags:manual /update  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |W32tm \/config \/update|Configures the computer for time synchronization.|  
    |\/manualpeerlist:\<peers\>|Specifies the list of Domain Name System \(DNS\) names or IP addresses for the NTP time source with which the primary domain controller \(PDC\) emulator synchronizes. \(This list is referred to as the manual peer list.\) For example, you can specify time.windows.com as the NTP time server. When you specify multiple peers, use a space as the delimiter and enclose the names of the peers in quotation marks.|  
    |\/syncfromflags:manual|Specifies that time is synchronized with peers in the manual peer list.|  
  
> [!TIP]  
>  For links to SNTP server lists, see article [262680](http://go.microsoft.com/fwlink/?LinkID=60401) in the Microsoft Knowledge Base \(http:\/\/support.microsoft.com\/kb\/262680\).  
  
  
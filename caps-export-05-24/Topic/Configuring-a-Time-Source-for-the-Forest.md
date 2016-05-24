---
title: Configuring a Time Source for the Forest
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: aaefc0c5-1927-4519-bf30-9f8cf27177b6
author: Femila
---
# Configuring a Time Source for the Forest
  The first domain controller that you deploy in a domain holds the primary domain controller \(PDC\) emulator operations master \(also known as flexible single master operations or FSMO\) role for the domain. By default, the domain controller that holds the PDC emulator master role in the forest root domain is the reliable time source at the top of the time\-source domain hierarchy for the forest. As soon as you install the first domain controller in the forest, set the PDC emulator in the forest root domain to synchronize from a valid Network Time Protocol \(NTP\) source or from a hardware clock that is installed on the network. If no time source is configured on the PDC emulator or any other domain controller in the forest root domain, the PDC emulator advertises as a reliable time source and uses its internal clock as the source for forest synchronization. In this case, no manual configuration is required.  
  
 After initial deployment of your network, you typically reconfigure the time service on the PDC emulator in the forest root domain in only two situations:  
  
-   You move the PDC emulator role to a different computer. In this case, you must configure the Windows Time service for the new PDC emulator master role holder and reconfigure the original PDC emulator master role holder to synchronize from the domain and not from an external or internal time source.  
  
-   You change the time source for the PDC emulator. For example, you change from synchronizing with an external source to synchronizing with an internal hardware device.  
  
 In some environments, one or more domain controllers are configured to act as standby PDC emulator role holders. If the current PDC emulator fails or is otherwise unavailable, the role can quickly be transferred to the standby. If you anticipate moving the PDC emulator role and you want to avoid reconfiguring the new and old PDC emulator every time the role is moved, you can configure a domain controller in the forest root domain that is not the PDC emulator as the reliable time source for the forest. In this way, the root of the time service stays the same and remains properly configured.  
  
> [!NOTE]  
>  Make sure that the domain controller that you configure to be the forest time source is highly available and, if it is not the PDC emulator, that it does not hold other operations master roles that might have to be transferred.  
  
 Use the following recommendations for configuring the time source for the forest root domain, in this order of preference:  
  
1.  Install a hardware clock, such as a radio or Global Positioning System \(GPS\) device, as the time source for the forest root domain and configure Windows Time service \(W32time\) on the PDC emulator or other domain controller to synchronize with this device. Many consumer and enterprise devices are available that use NTP. You can install the device on an internal network and configure the PDC emulator to use it as its time source.  
  
     Hardware clocks have the following advantages:  
  
    -   More security. You do not have to connect to the Internet.  
  
    -   Highest accuracy, although the accuracy level of NTP servers is as high as that of Windows Time service; that is, the effect of the higher accuracy is not appreciated.  
  
     Hardware clocks have the following disadvantage:  
  
    -   Expense and maintenance. You must purchase and install a hardware clock, whereas you can connect to a public time server at no cost and without hardware installation.  
  
2.  Configure the Windows Time service on the PDC emulator or other domain controller to synchronize with an external time server. Computer clocks synchronize with external time servers by using the NTP protocol over an IP version 4 \(IPv4\) or IP version 6 \(IPv6\) network. You can manually configure the PDC emulator in the forest root domain to synchronize with the external time source.  
  
     External time servers have the following advantages:  
  
    -   Low cost or no cost. Cost is usually limited to bandwidth.  
  
    -   Good accuracy. Although hardware clocks have the highest accuracy, the accuracy of a hardware clock can actually exceed the accuracy of Windows Time service; therefore, the comparison of accuracy is not relevant.  
  
     External time servers have the following disadvantage:  
  
    -   Security risk. NTP synchronization with an external time source is not authenticated and is therefore less secure than if the time source is inside the network.  
  
 Many GPS receivers and other time devices can function as NTP servers on a network. You can configure your Active Directory forest to synchronize time from these external hardware devices only if they are also acting as NTP servers on your network. To do so, configure the domain controller functioning as the PDC emulator in your forest root to synchronize with the NTP server provided by the GPS device. To do so, see [Configure the Windows Time service on the PDC emulator](assetId:///ce8890cf-ef46-4931-8e4a-2fc5b4ddb047) \( HYPERLINK "http:\/\/go.microsoft.com\/fwlink\/?LinkId\=91969" http:\/\/go.microsoft.com\/fwlink\/?LinkId\=91969\).  
  
 If you are using an external time source, you can use the following sites to select an NTP server:  
  
-   USNO NTP Network Time Servers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112036](http://go.microsoft.com/fwlink/?LinkId=112036)\)  
  
-   Set Your Computer Clock Via the Internet: NIST Internet Time Service \(ITS\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112035](http://go.microsoft.com/fwlink/?LinkId=112035)\)  
  
-   NTP.Servers Web site \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=116972](http://go.microsoft.com/fwlink/?LinkID=116972)\)  
  
 If you choose to implement an NTP time synchronization product other than the Windows Time service, you must disable the Windows Time service on the forest root domain reliable time source. All NTP servers need access to UDP port 123. If the Windows Time service is running on a Windows Server 2003–based computer or a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based computer, port 123 will remain connected for the Windows Time service.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   W32tm.exe  
  
-   The Windows Firewall with Advanced Security snap\-in, if you need to check User Datagram Protocol \(UDP\) port status  
  
-   The Services snap\-in, if you need to disable the Windows Time service  
  
 To complete this task, perform the following procedures as needed:  
  
-   To configure the PDC emulator in the forest root domain to synchronize time from an external time source, see [Configure the Time Source for the Forest](../Topic/Configure-the-Time-Source-for-the-Forest.md). If you plan to use a different domain controller as the time source for the forest, perform this procedure on that domain controller instead of the PDC emulator.  
  
-   If the PDC emulator in the forest root domain is configured as the reliable time source for the forest and you move the PDC emulator role to a different domain controller, see [Change the Windows Time Service Configuration on the PDC Emulator in the Forest Root Domain](../Topic/Change-the-Windows-Time-Service-Configuration-on-the-PDC-Emulator-in-the-Forest-Root-Domain.md).  
  
-   If you are implementing a time synchronization product other than the Windows Time service in your environment that uses NTP, see [Disable the Windows Time Service](../Topic/Disable-the-Windows-Time-Service.md) to free UDP port 123 on the network.  
  
-   If you need more information about Windows Time service events, see [Enable Windows Time Service Debug Logging](../Topic/Enable-Windows-Time-Service-Debug-Logging.md).  
  
  
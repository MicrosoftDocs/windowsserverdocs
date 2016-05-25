---
title: Configure the Windows Time Service
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 92a73b00-12b7-49d0-b6be-007e626f387d
author: Femila
---
# Configure the Windows Time Service
When you deploy a forest root domain, it is important to correctly configure the Windows Time service \(W32time\) to meet the needs of your organization. The Windows Time service provides time synchronization to peers and clients, which ensures consistent time throughout an enterprise.  
  
By default, the first domain controller that you deploy holds the primary domain controller \(PDC\) emulator operations master role. Set the PDC emulator to synchronize with a valid Network Time Protocol \(NTP\) source. If you have not configured a source, the Windows Time service logs a message to the event log, and then uses the local clock when it provides time to clients.  
  
When you configure the time source on the forest root PDC emulator, follow these best practices in the order that they are presented:  
  
1.  Install a hardware clock, such as a radio or global positioning service \(GPS\) device, as the source for the PDC.  
  
    You can install any device that uses NTP on your internal network for use with the PDC.  
  
2.  Configure the Windows Time service to synchronize with an external time source. External time sources allow users to synchronize computer clocks through the NTP protocol over an IPv4 or IPv6 network.  
  
    The Microsoft time server \(time.windows.com\) uses NIST, the National Institute of Standards and Technology, located in Boulder, Colorado, as its external time provider. NIST provides the Automated Computer Time Service \(ACTS\), which can set a computer clock with an uncertainty of less than 10 milliseconds. The U.S. Naval Observatory \(USNO\) Time Service Department in Washington, D.C., is another source for accurate time synchronization in the United States. Many other sites exist throughout the world that you can use for time synchronization.  
  
    > [!NOTE]  
    > Because synchronization with an external time source is not authenticated, it is less secure.  
  
Repeat this operation if you transfer or seize the PDC emulator operations master role to another domain controller in the forest root domain.  
  
### To configure the Windows Time service on the first forest root domain controller  
  
1.  Log on to the first domain controller that you deployed.  
  
2.  At a command prompt, type the following command, and then press ENTER:  
  
    **w32tm \/stripchart \/computer:<target> \/samples:<number> \/dataonly**  
  
3.  Open User Datagram Protocol \(UDP\) port 123 for outgoing traffic, if needed.  
  
4.  Open UDP port 123 for incoming NTP traffic.  
  
    You can use a different port, if you prefer.  
  
5.  Type the following command to configure the PDC emulator, and then press ENTER:  
  
    **w32tm \/config \/manualpeerlist:<peers> \/syncfromflags:manual \/reliable:yes \/update**  
  
|Parameter|Description|  
|-------------|---------------|  
|W32tm \/stripchart|Displays a strip chart of the offset between synchronizing computers.|  
|W32tm \/config \/update|Configures the PDC emulator.|  
|\/computer:<target>|Specifies the Domain Name System \(DNS\) name or IP address of the NTP server whose time you want to compare to the local computer's time. An example of an NTP server is time.windows.com.|  
|\/samples:<number>|Specifies the number of time samples that the target computer returns.|  
|\/dataonly|Specifies that results show only data, not graphics.|  
|\/manualpeerlist:<peers>|Specifies the list of DNS names or IP addresses for the NTP time source with which the PDC emulator synchronizes. \(This list is referred to as the manual peer list.\) For example, you can specify time.windows.com as the NTP time server. When you specify multiple peers, use a space as the delimiter and enclose the names of the peers in quotation marks.|  
|\/syncfromflags:manual|Specifies to synchronize time with peers in the manual peer list.|  
|\/reliable:yes|Specifies that the computer is a reliable time service.|  
  
> [!NOTE]  
> When you specify a peer that is in the manual peer list, do not use the DNS name or IP address of a computer that uses the forest root domain controller as its source for time, such as another domain controller in the forest. The time service does not operate correctly if there are cycles in the time source configuration.  
  
For more information about configuring and deploying the Windows Time service, see Administering the Windows Time Service \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93658](http://go.microsoft.com/fwlink/?LinkId=93658)\).  
  
## See Also  
[Videos about the Windows Time Service](http://www.microsoft.com/showcase/en/us/search?phrase=w32time)  
  

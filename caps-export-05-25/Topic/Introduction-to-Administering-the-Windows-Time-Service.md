---
title: Introduction to Administering the Windows Time Service
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 187e13b5-694b-4aa1-9620-36b61107ac4b
author: Femila
---
# Introduction to Administering the Windows Time Service
  The [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Windows Time service \(W32time\) synchronizes the date and time for all computers running on a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] network. The service integrates Network Time Protocol \(NTP\) and time providers, making it a reliable and scalable time service for enterprise administrators.  
  
 The purpose of the Windows Time service is to make sure that all computers running versions of Windows 2000 Server, Windows Server 2003, Windows XP, Windows Vista, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in an organization use a common time. To guarantee appropriate common time usage, the Windows Time service uses a hierarchical relationship that controls authority and does not permit loops. A domain controller at the top of the hierarchy provides authoritative time to all other domain controllers, and domain clients use domain controllers as their time source. By default, the domain controller at the top of the hierarchy is the primary domain controller \(PDC\) operations master \(also known as flexible single master operations or FSMO\) in the forest root domain.  
  
## Windows time source selection  
 By default, Windows\-based computers use the following sources for time synchronization:  
  
-   For computers that are joined to a domain, the first query is to a time source in the parent domain.  
  
    > [!NOTE]  
    >  Computers that are not joined to a domain and are running Windows Vista are configured to synchronize with the following external time sources by default: time.windows.com, time.nist.gov, time\-nw.nist.gov, time\-a.nist.gov, and time\-b.nist.gov. Computers that are not joined to a domain and are running Windows XP or Windows XP Home Edition are configured to synchronize with time.windows.com by default.  
  
-   If the time client is in a single\-domain forest, the first query is to the PDC emulator in the domain.  
  
-   All PDC emulator operations masters follow the hierarchy of domains in the selection of their inbound time partner. A PDC emulator can synchronize its time from the PDC emulator in the parent domain or from any domain controller in the parent domain.  
  
 For more information about time source selection, see How Windows Time Service Works \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=117753](http://go.microsoft.com/fwlink/?LinkID=117753)\).  
  
 The authoritative time source at the root of the forest can acquire its time either by connecting to an installed hardware clock on the internal network or by connecting to an external NTP server, which is connected to a hardware device. If no domain controller is configured as the authoritative time source in the forest root domain, the domain controller that holds the PDC emulator operations master role uses its internal clock to provide time to forest computers.  
  
## External NTP time servers  
 Many external NTP servers are available over the Internet. Use the following information to select an NTP server:  
  
-   The National Institute of Standards and Technology \(NIST\) in Boulder, Colorado, which is used as the external time provider by the Microsoft time server \(time.windows.com\). NIST provides the Automated Computer Time Service \(ACTS\), which can set a computer clock with an uncertainty of less than 10 milliseconds. For more information about NTP and for a list of external time servers, see Set Your Computer Clock Via the Internet: NIST Internet Time Service \(ITS\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112035](http://go.microsoft.com/fwlink/?LinkId=112035)\).  
  
-   The U.S. Naval Observatory \(USNO\) Time Service Department in Washington, DC, is another reliable source for accurate time synchronization in the United States. To see a list of USNO servers and their descriptions, see USNO Network Time Servers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112036](http://go.microsoft.com/fwlink/?LinkId=112036)\).  
  
-   You can use many other sites throughout the world for time synchronization. For more NTP server lists and search criteria, see the NTP.Servers Web site \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116972](http://go.microsoft.com/fwlink/?LinkId=116972)\).  
  
 For the most highly accurate time synchronization, configure a hardware clock, such as a radio or Global Positioning System \(GPS\) device, as the time source for the PDC. There are many consumer and enterprise devices that use NTP, which makes it possible for you to install the device on an internal network for use with the PDC.  
  
 You use the **w32tm** command\-line tool to configure Windows Time service. For a detailed technical reference for the Windows Time service, including complete documentation of the **w32tm** command\-line tool and time service registry settings, see the Windows Time Service Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=100940](http://go.microsoft.com/fwlink/?LinkID=100940)\).  
  
## W32tm and net time  
 The **net time** commands are predecessors of **w32tm** commands, and they should not be used to configure the Windows Time service or to set the time on a computer while the Windows Time service is actively running. The recommended method for configuring the Windows Time service and displaying Windows Time service information for Windows XP, Windows Server 2003, Windows Vista, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating systems is to use **w32tm** commands.  
  
 Although the command **net time \/querysntp** appears to display the Simple Network Time Protocol \(SNTP\) server for Windows XP, Windows Server 2003, Windows Vista, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating systems, it does not display complete time configuration information. On Windows Vista and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can use the command **w32tm \/query \/configuration** to determine whether the computer is configured to synchronize time from the domain hierarchy or from a manual list of time servers. \(On Windows XP and Windows Server 2003, you can use the command **w32tm \/dumpreg \/subkey:parameters**\). The command output includes a line labeled **Type** that identifies the time synchronization method that the client is using. The following **Type** line outputs are possible for the time client:  
  
-   **NoSync**: The client does not synchronize time.  
  
-   **NTP**: The client synchronizes time from an external time source. Review the values in the **NtpServer** line in the output to see the name of the server or servers that the client uses for time synchronization.  
  
-   **NT5DS**: The client is configured to use the domain hierarchy for its time synchronization.  
  
-   **AllSync**: The client synchronizes time from any available time source, including domain hierarchy and external time sources.  
  
 For information about Windows Time Server Internet communication, see Windows Time Service and Resulting Internet Communication in Windows Server 2008 \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116982](http://go.microsoft.com/fwlink/?LinkId=116982)\).  
  
  
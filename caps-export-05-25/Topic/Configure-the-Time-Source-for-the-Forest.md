---
title: Configure the Time Source for the Forest
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: aa11868c-40fe-4dbe-85ab-4f66df08bd06
author: Femila
---
# Configure the Time Source for the Forest
  You can use these procedures to configure the Windows Time service \(W32time\) on the domain controller that holds the primary domain controller \(PDC\) emulator operations master role in the forest root domain to synchronize time from an external time server or a reliable time source. When you deploy a new forest root domain or when you move the role of the PDC emulator in the forest root domain to a new domain controller, you must configure the PDC emulator role holder in the forest root domain to synchronize time for the forest from an external time source on the Internet or from a hardware clock on the internal network. If you do not configure the PDC emulator to synchronize time from an external or internal time source, the PDC emulator uses its internal clock and is itself the reliable time source for the forest.  
  
 As an alternative to configuring the PDC emulator, you can configure a different domain controller in the forest root domain to synchronize time from a reliable time source. If there is such a domain controller in the forest root domain, the PDC emulator no longer advertises as a reliable time source.  
  
 The procedures in this topic configure the PDC emulator \(or other domain controller\) to connect to an external Network Time Protocol \(NTP\) time server for time synchronization. To configure the PDC emulator to synchronize time from a hardware clock device on the internal network, consult the instructions for the hardware clock device.  
  
 If you move the role of the PDC emulator to a new domain controller, you must also change the configuration of the Windows Time service on the previous PDC emulator. For more information, see [Change the Windows Time Service Configuration on the PDC Emulator in the Forest Root Domain](../Topic/Change-the-Windows-Time-Service-Configuration-on-the-PDC-Emulator-in-the-Forest-Root-Domain.md).  
  
 Before you configure the Windows Time service on the PDC emulator, you can determine the time difference between it and the time source as a means to test basic NTP communication.  
  
 If you have not selected a set of external NTP servers, use the following sites to create your list of time servers. This list is referred to in the procedure as the “manual peer list.”  
  
-   USNO NTP Network Time Servers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112036](http://go.microsoft.com/fwlink/?LinkId=112036)\).  
  
-   Set Your Computer Clock Via the Internet: NIST Internet Time Service \(ITS\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112035](http://go.microsoft.com/fwlink/?LinkId=112035)\).  
  
-   NTP.Servers Web site \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=116972](http://go.microsoft.com/fwlink/?LinkID=116972)\)  
  
 After you configure the Windows Time service on the PDC emulator, be sure to monitor the System log in Event Viewer for W32time errors.  
  
> [!NOTE]  
>  The following procedures use the **w32tm** command\-line tool. For more information about the **w32tm** command, type **w32tm \/?** at a command prompt or see Windows Time Service Tools and Settings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112116](http://go.microsoft.com/fwlink/?LinkId=112116)\).  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure the time source for the forest  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  To display the time difference between the local computer and the target time source and to check NTP communication, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /stripchart /computer:<target> /samples:<n> /dataonly  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |W32tm \/stripchart|Displays a strip chart of the offset between synchronizing computers. A strip chart plots two\-dimensional data—in this case, the local time and the offset.|  
    |\/computer:\<target\>|Specifies the Domain Name System \(DNS\) name or IP address of the NTP server that you are comparing the local computer's time against, such as time.windows.com or time\-nw.nist.gov.|  
    |\/samples:\<n\>|Specifies the number of time samples that will be returned from the target computer to test basic NTP communication.|  
    |\/dataonly|Specifies that results show only data, not graphics.|  
  
     If this procedure fails, check the System event log for Time\-Service errors and follow any resolution steps that are provided in the **More Info** link in the error. It is possible that a perimeter firewall is blocking access to the Internet time server. NTP port 123 must be open for outbound and inbound traffic on all routers and firewalls between the PDC emulator and the Internet. If necessary, enable debug logging for W32time, as described in [Enable Windows Time Service Debug Logging](../Topic/Enable-Windows-Time-Service-Debug-Logging.md). Resolve any NTP connection issues before you proceed to step 3.  
  
3.  To configure the PDC emulator to use an NTP time source, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /config /manualpeerlist:<peers> /syncfromflags:manual /reliable:yes /update  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |w32tm \/config \/update|Configures the computer to synchronize time.|  
    |\/manualpeerlist:\<peers\>|Specifies the list of DNS names or IP addresses for the NTP time source with which the PDC emulator synchronizes. \(This list is referred to as the manual peer list.\) For example, you can specify time.windows.com as the NTP time server. When you specify multiple peers, use a space as the delimiter and enclose the names of the peers in quotation marks.|  
    |\/syncfromflags:manual|Specifies that time will be synchronized with peers in the manual peer list.|  
    |\/reliable:yes|Specifies that the computer is a reliable time source.|  
  
> [!NOTE]  
>  When you specify a peer in the manual peer list, do not specify a computer that uses the forest root domain controller as its source for time, such as another domain controller in the forest. The time service does not operate correctly if there are cycles in the time source configuration. Peers should be external to the domain hierarchy.  
  
 After you configure the PDC emulator as the time source for the forest, log on to a client computer in the forest root domain and perform steps 1 and 2 in the preceding procedure to check Windows Time service performance on the PDC emulator. Use the DNS name of the PDC emulator for the computer target in the command.  
  
 If you receive error messages, the User Datagram Protocol \(UDP\) ports on the PDC emulator might be disabled or blocked. You can use the following procedure to check the port status on the PDC emulator, if necessary.  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To check UDP port status on the PDC emulator  
  
1.  To check inbound UDP port 123 status on the domain controller that is the PDC emulator, click **Start**, point to **Administrative Tools**, and then click **Windows Firewall with Advanced Security**.  
  
2.  Click **Inbound Rules**. Check that **Active Directory Domain Controller \- W32Time \(NTP\-UDP\-In\)** has a status of enabled \(green\) and is not blocked:  
  
    -   If this rule is disabled \(dimmed\), right\-click the rule, and then click **Enable**.  
  
    -   If the rule is blocked, right\-click the rule, and then click **Properties**. Under **Action**, click **Allow the connections**, and then click **OK**.  
  
3.  To check outbound UDP port status on the domain controller, click **Outbound Rules**.  
  
4.  Check that **Active Directory Domain Controller \(UDP\-Out\)** has a status of enabled and is not blocked:  
  
    -   If the rule is disabled \(dimmed\), right\-click the rule, and then click **Enable**.  
  
    -   If the rule is blocked, right\-click the rule, and then click **Properties**. Under **Action**, click **Allow the connections**, and then click **OK**.  
  
     Or  
  
     To open only outbound UDP port 123, create a separate outbound rule for the specific port, as follows:  
  
    1.  In **Windows Firewall with Advanced Security**, right\-click **Outbound Rules**, and then click **New**.  
  
    2.  In the New Outbound Rule Wizard, click **Port**, and then click **Next**.  
  
    3.  Click **UDP**, click **Specific local ports**, type **123**, and then click **Next**.  
  
    4.  Follow the directions in the wizard to configure the security settings and name the rule, and then click **Finish**.  
  
5.  To ensure that the PDC emulator responds, on an NTP client, repeat the test in step 2 of the procedure “To configure the Windows Time service on the PDC emulator” earlier in this topic.  
  
  
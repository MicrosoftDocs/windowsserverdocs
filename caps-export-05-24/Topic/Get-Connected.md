---
title: Get Connected
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99bd7ac1-9beb-438d-900e-426da41898b8
---
# Get Connected
Information about roles and features in Windows Server is available on the web. You can use one or more of the following methods to access information on the web:  
  
|Method|Description|More Information|  
|----------|---------------|--------------------|  
|Install Remote Server Administration Tools \(RSAT\)|Remote management of servers from an Internet\-connected client computer is the preferred method to access information on the web when you are administering Windows Server. To use this method, install RSAT on a client computer that has an Internet connection. The computer running RSAT must also have a network connection to the servers you want to manage.<br /><br />RSAT enables you to manage roles and features that are running on Windows Server from a compatible remote computer. The remote computer must be running an operating system that is compatible with the version of RSAT that is installed.<br /><br />With RSAT, you can use Server Manager and Microsoft Management Console snap\-ins in an environment that is connected to information on the web without the need to connect remote servers to the Internet. For more information, see http:\/\/go.microsoft.com\/fwlink\/?linkid\=404281.|[Remote Server Administration Tools](http://go.microsoft.com/fwlink/?linkid=404281)|  
|Connect the computer to the Internet|Depending on the network environment in your organization, security policies might limit the type of network connections that are available to computers and devices.<br /><br />If permitted by security policies in your environment, you can connect a computer running Windows Server to the Internet. Details to help you get connected are provided in this topic.|[Connecting to the Internet](../Topic/Get-Connected.md#connecting_local)|  
|Use another computer to view information on the web|You can use a different computer or a mobile device to view information on the web. You might connect this computer to the computer running Windows Server by using a remote access method such as Remote Desktop Services. In this scenario, the computer you use to view information on the web does not have RSAT installed, and you must manually type the web addresses into a web browser.<br /><br />For more information about the roles and services that are available in this version of Windows Server, see the following resources on the Microsoft TechNet website at http:\/\/go.microsoft.com\/fwlink\/?linkid\=306430.<br /><br />More information about Remote Desktop Services is available at http:\/\/go.microsoft.com\/fwlink\/?linkid\=306532.|[Windows Server](http://go.microsoft.com/fwlink/?linkid=306430)<br /><br />[Remote Desktop Services Overview](http://go.microsoft.com/fwlink/?linkid=306532)|  
  
## <a name="connecting_local"></a>Connecting to the Internet  
If you want to connect a computer running Windows Server to the Internet, you’ll need to check your adapters and settings \(including virtual network settings, if applicable\). See the following sections for more information:  
  
-   [Verify and repair network adapters](../Topic/Get-Connected.md#netadapter)  
  
-   [Review and verify virtual network settings](../Topic/Get-Connected.md#virtual)  
  
-   [Review and verify local network settings](../Topic/Get-Connected.md#local_network)  
  
-   [Review remote network settings](../Topic/Get-Connected.md#remote_network)  
  
### <a name="netadapter"></a>Verify and repair network adapters  
Verify that the computer has at least one network adapter installed and enabled. If the network connection is wired, verify that the network cable is connected and the network link is active. If there are problems with a network adapter, you can attempt to repair them manually, or you can use the network troubleshooter to automatically detect and repair basic configuration problems.  
  
Use the following procedure to verify the status of network adapters.  
  
##### To verify the status of network adapters  
  
1.  Open a Windows PowerShell prompt, type **Get\-NetAdapter**, and press ENTER. See the following example:  
  
    ```  
    PS C:\> Get-NetAdapter  
  
    Name                      InterfaceDescription                    ifIndex Status       MacAddress             LinkSpeed  
    ----                      --------------------                    ------- ------       ----------             ---------  
    Ethernet 2                Microsoft Hyper-V Network Adapter #4         24 Disconnected 00-15-5D-9F-DF-06        10 Gbps  
    Ethernet                  Microsoft Hyper-V Network Adapter #3         20 Up           00-15-5D-9F-DF-05        10 Gbps  
    ```  
  
    > [!TIP]  
    > -   To display only network adapters that are not **Up**, type **Get\-NetAdapter | ? Status –ne Up**.  
    > -   To display a detailed list of network interface parameters for the **Ethernet 2** adapter, type **Get\-NetAdapter –Name “Ethernet 2” | fl \***.  
    > -   To see a list of network status related Windows PowerShell commands, type **Get\-Command Get\-Net\***.  
    > -   To view the syntax for a command, use the **Get\-Help** cmdlet, for example: **Get\-Help Get\-NetAdapterStatistics**.  
  
2.  Verify that **Up** is displayed under **Status** for all network adapters that are currently in use.  
  
3.  If the status of a network adapter is not **Up**, verify that the adapter is required to connect to the Internet and repair the connection.  
  
    The actions required to repair a network adapter depend on its status. For example, a status of **Disconnected** can indicate a problem with the network cable or another network device, such as a switch or hub. If the computer is a virtual machine, a **Disconnected** status can indicate a problem with the virtual network that is associated with a network adapter. More information is provided later in this topic to help you troubleshoot virtual networks.  
  
4.  Type **ncpa.cpl** at a command prompt, and press ENTER to open the **Network Connections** control panel.  
  
5.  Right\-click inside the **Network Connections** window, point to **View**, and click **Details**.  
  
6.  Review the **Connectivity** column for each network adapter. At least one adapter must display **Internet access** in this column for the computer to successfully connect to the Internet.  
  
**Use the network troubleshooter**  
  
If you cannot repair network adapters manually, you can use the network troubleshooter to attempt repairs. The network troubleshooter analyzes your network configuration and performs basic tests, including a default gateway test, DNS test, firewall test, and Internet connectivity test. The network troubleshooter also saves network diagnostic information that you can use later to review network settings.  
  
> [!CAUTION]  
> During the troubleshooting process, the network troubleshooter might reset some or all network connections on the local computer.  
  
Use the following procedure to run the network troubleshooter.  
  
#### <a name="Tx"></a>To run the network troubleshooter  
  
1.  Type **ncpa.cpl** at a command prompt, and press ENTER to open the **Network Connections** control panel.  
  
2.  Right\-click the network connection you want to repair, and click **Diagnose**.  
  
3.  The network troubleshooter attempts to repair network problems automatically. If it is unable to repair the problem, it provides information about the type of problem found. Click **View detailed information**, and record the results that are listed under **Windows Network Diagnostics** and **Issues found**.  
  
4.  To save detailed results from the network troubleshooter, click **Detection details**, and then under **Other Networking Configuration and Logs**, click **NetworkConfiguration.cab**. Right\-click the **ipconfig.all.txt** file, click **Copy**, right\-click the desktop, and then click **Paste**. Also copy and paste the **route.print.txt** file.  
  
Information that you save from the network troubleshooter is helpful when you review local network settings, which is explained in the [Review and verify local network settings](../Topic/Get-Connected.md#local_network) section later in this topic.  
  
## <a name="virtual"></a>Review and verify virtual network settings  
Use the following procedures to verify virtual network settings. If the computer is not a virtual machine, you can skip this section.  
  
To connect a Hyper\-V virtual machine to the Internet, the server running Hyper\-V \(also known as a host\) must have a connection to the Internet, and Hyper\-V must be configured with an external virtual switch that provides access to the host’s Internet connection. At least one network adapter on the virtual machine must be connected to this external virtual switch directly or through a virtual network. For more information about Hyper\-V virtual switch functionality in Windows Server, see [Hyper\-V Virtual Switch Overview](http://go.microsoft.com/fwlink/?linkid=306536) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=306536\).  
  
The following procedures use Windows PowerShell to review virtual network settings on a virtual machine that is intended to connect to the Internet by using an external virtual switch that is configured on the Hyper\-V host. To use these commands, the Hyper\-V Module for Windows PowerShell must be installed. You can also use Hyper\-V Manager to perform these procedures. For more information about configuring virtual networks with Hyper\-V Manager, see [Configure Virtual Networks](http://go.microsoft.com/fwlink/?linkid=306679) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=306679\).  
  
> [!TIP]  
> -   To see a list of Hyper\-V status\-related Windows PowerShell commands, type **Get\-Command Get\-VM\***.  
> -   To see a list of all commands that are available in the Hyper\-V module, type **Get\-Command –Module Hyper\-V**.  
  
#### To verify virtual network settings  
  
1.  To verify that an external virtual switch is available on a virtual Hyper\-V host, type **Get\-VMSwitch –SwitchType External**, and press ENTER. See the following example:  
  
    ```  
    PS C:\> Get-VMSwitch -SwitchType External  
  
    Name                                                           SwitchType NetAdapterInterfaceDescription  
    ----                                                           ---------- ------------------------------  
    Intel(R) 82567LM-3 Gigabit Network Connection - Virtual Switch External   Intel(R) 82567LM-3 Gigabit Network Connection  
    ```  
  
2.  Verify that **External** is displayed under **SwitchType** for at least one virtual switch.  
  
3.  To verify that a virtual machine is connected to ports on the external virtual switch shown in the previous step, type **Get\-VMNetworkAdapter –VMName <vmname> | ft Name,SwitchName**, and press ENTER. See the following example:  
  
    ```  
    PS C:\> Get-VMNetworkAdapter -VMName VM02.contoso.com | ft Name,SwitchName,IPAddresses -Autosize  
  
    Name            SwitchName                                                     IPAddresses  
    ----            ----------                                                     -----------  
    Network Adapter Intel(R) 82567LM-3 Gigabit Network Connection - Virtual Switch {10.123.182.243, fe80::1106:7d3f:d7ac:d1f9, 2001:4898:2a:4:1106:7d3f:d7ac:d1f9}  
    Network Adapter Private network                                                {192.168.0.1, fe80::29c6:3513:2570:eeeb}  
    ```  
  
4.  Verify that the **SwitchName** that is displayed is the same as the **Name** of an external virtual switch displayed in the previous command output.  
  
5.  Virtual local area network \(VLAN\) settings can cause network connectivity issues. To display a list of virtual switch ports and associated VLANs, type **Get\-VMNetworkAdapterVlan**, and press ENTER. See the following example:  
  
    ```  
    PS C:\> Get-VMNetworkAdapterVlan  
  
    VMName                VMNetworkAdapterName                                           Mode     VlanList  
    ------                --------------------                                           ----     --------  
                          Internal network                                               Access   2  
                          Intel(R) 82567LM-3 Gigabit Network Connection - Virtual Switch Untagged  
    VM01.contoso.com      Network Adapter                                                Trunk    10,1-100  
    VM02.contoso.com      Network Adapter                                                Untagged  
    VM02.contoso.com      Network Adapter                                                Access   200  
    VM03.contoso.com      Network Adapter                                                Isolated 10,200  
    ```  
  
    If a VLAN ID is associated with a Hyper\-V host network adapter, or with virtual machines, it is displayed under **VlanList**. In this example, the first two network adapters are connected to the Hyper\-V host and the next four network adapters are connected to the virtual machines that are displayed under **VMName**.  
  
6.  Verify that the external network adapter on the virtual machine that you want to connect to the Internet is using the same VLAN configuration as the external virtual switch on the host running Hyper\-V. For example, if the external virtual switch on the Hyper\-V host is untagged, the corresponding network adapter on a virtual machine must also be untagged. Or, if virtual switch ports are configured to use VLAN access mode, both ports must be tagged with the same VLAN ID.  
  
    A virtual switch also provides support for VLAN trunk mode. In trunk mode, a virtual switch port receives traffic from all VLANs that you configure in an allowed VLAN list. In the following example, the virtual machine VM01.contoso.com is configured to send or receive traffic on any VLAN in the range 1\-100. If there is no VLAN specified in the packet, the packet is treated as if it is from VLAN 10.  
  
    ```  
    Set-VMNetworkAdapterVlan –VMName VM01.contoso.com –Trunk –AllowedVlanIdList 1-100 –NativeVlanId 10  
    ```  
  
    A virtual machine and virtual switch might also be configured with port VLANs \(PVLANs\). PVLAN is a virtual switch property that enables the use of two VLAN IDs: a primary VLAN ID and a secondary VLAN ID. A PVLAN can be set in one of the following three modes:  
  
    |PVLAN Mode|Description|  
    |--------------|---------------|  
    |Isolated|Communicates only with promiscuous ports in the PVLAN|  
    |Promiscuous|Communicates with all ports in the PVLAN|  
    |Community|Communicates with ports in the same community and any promiscuous ports in the PVLAN|  
  
    A PVLAN can be used to create an environment where virtual machines can interact only with the Internet and not have visibility into other virtual machine network traffic. To accomplish this, set the virtual switch ports on all virtual machines to the same PVLAN in isolated mode. In this configuration, all virtual machines are isolated from each other. In the following example, the PVLAN is set in isolated mode with a primary VLAN ID of 10 and a secondary VLAN ID of 200:  
  
    ```  
    Set-VMNetworkAdapterVlan –VMName VM03.contoso.com –Isolated –PrimaryVlanId 10 –SecondaryVlanId 200  
    ```  
  
In addition to VLANs and PVLANs, virtual switches can be configured with security policies and settings that can block access to the Internet. Hyper\-V Network Virtualization enables you to deploy virtual networks with the same capabilities \(and security policies\) as a physical network. If a virtual machine is located on a virtual network, review all virtual network settings in the same way that you would review local network settings for a physical host. See information later in this topic for help reviewing local network settings. For more information, see [Hyper\-V Network Virtualization Overview](http://go.microsoft.com/fwlink/?linkid=306685) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=306685\).  
  
## <a name="local_network"></a>Review and verify local network settings  
Next, verify and record the local network settings that you are using. These settings determine connectivity to the local area network \(LAN\), and they provide the local computer with the ability to resolve Domain Name System \(DNS\) names and to communicate with other computers and networks. If you are not sure these settings are correct, contact your network administrator.  
  
If the computer that you want to connect to the Internet is a virtual machine, see [Review and verify virtual network settings](../Topic/Get-Connected.md#virtual) before you perform these procedures.  
  
#### To review local network settings  
  
1.  If you saved files from the network troubleshooter in the [Verify and repair network adapters](../Topic/Get-Connected.md#netadapter) section of this topic, open the **ipconfig.all.txt** file to review local network settings.  
  
2.  If you did not run the network troubleshooter or you did not save files from the network troubleshooter, open a command prompt, type **ipconfig \/all**, and press ENTER.  
  
3.  Review and record the following settings for all network adapters:  
  
    |Setting|Description|  
    |-----------|---------------|  
    |DHCP enabled|Dynamic Host Configuration Protocol \(DHCP\) is enabled by default to dynamically configure network settings. If there are no DHCP servers available, or if installed roles or services require a static IP address, you must manually provide network settings.|  
    |IPv6 address|DHCP can provide a dynamic IPv6 address, or you can configure a static IPv6 address. By default, the computer will use a link\-local IPv6 address if an IPv6 address is not provided by DHCP or is statically configured. A link\-local IPv6 address is not sufficient to connect to the Internet.|  
    |IPv4 address|DHCP can provide a dynamic IPv4 address or you can configure a static IPv4 address. By default, the computer will use Automatic Private IP Addressing \(APIPA\) if an IPv4 address is not provided by DHCP or is statically configured. An IP address assigned by APIPA will be in the private IP address range of 169.254.0.1 – 169.254.255.254. An IP address assigned by APIPA is not sufficient to connect to the Internet.|  
    |Subnet mask|DHCP can provide a subnet mask or you can configure a subnet mask manually. The subnet mask determines which IP addresses the computer can connect to directly, without the use of routing. A computer uses routing to connect to IP addresses on different subnets, such as IP addresses on the Internet.<br /><br />If you saved files from the network troubleshooter in the previous procedure, all routes that are currently configured on the local computer are recorded in the **route.print.txt** file. Destinations that are on the same subnet \(determined by the subnet mask\) will display as **On\-link** under **Gateway**. If you did not run the network troubleshooter, or you did not save files from the network troubleshooter, you can display this information by typing **route print** at a command prompt and then pressing ENTER. You can also use the Windows PowerShell cmdlet **Get\-NetRoute**.|  
    |Default gateway|DHCP can provide the default gateway or you can configure a default gateway manually. The default gateway is an IP address on the local subnet where a computer sends network traffic by default. A computer will send traffic to the default gateway if it does not have a static route to the destination IP address. Typically, the default gateway is the IP address that the computer uses to send network traffic off the local network and to other networks, such as the Internet.<br /><br />If the computer is not configured with a default gateway, or if it is configured with an incorrect default gateway address, the computer might be unable to connect to other networks, such as the Internet.|  
    |DHCP server|If the computer is configured to use DHCP and it has successfully acquired an IP address configuration from a DHCP server, the IP address of the DHCP server will be displayed.|  
    |DNS servers|DHCP can provide a list of IP addresses for one or more DNS servers or you can configure the DNS server list manually. The computer uses DNS servers to translate host names to IP addresses and vice\-versa. At least one DNS server is required to provide DNS name resolution. Additional DNS servers are listed in case the primary DNS server does not respond. To use a DNS server, the computer must be able to connect to the DNS server using the local subnet or by routing through the network.<br /><br />If multiple DNS servers are assigned to a computer, the computer will use the first DNS server that is configured on its network adapter. If the computer has more than one network adapter, the first DNS server configured on the preferred network adapter is used. The preferred network adapter is the adapter that is highest in the binding order.<br /><br />To successfully connect to the Internet, a computer must have a network connection to its assigned DNS server, and that DNS server must be able to provide Internet name resolution by using forwarding or root hints. A computer will not use other DNS servers if the assigned DNS server responds to a query, even if that response is that it failed to resolve a name.|  
  
If network settings are not provided by DHCP, you must provide these settings manually.  
  
Whether settings are provided manually or by DHCP, verify that these settings are correct for the local subnet.  
  
### Verifying local network settings  
Following are some useful commands that you can use to test local network settings.  
  
**Windows PowerShell commands**  
  
|Command|Description|  
|-----------|---------------|  
|Test\-Connection|Sends Internet Control Message Protocol \(ICMP\) echo request packets to one or more computers.|  
|Resolve\-DnsName|Performs a DNS name query resolution for a specified name.|  
|Test\-DnsServer|Tests that a specified computer is a functioning DNS server.|  
  
**Windows commands**  
  
|Command|Description|  
|-----------|---------------|  
|Ping|Sends an ICMP echo request to a destination IP address.|  
|Tracert|Displays a list of router interfaces that exist between a source host and a destination.|  
|Pathping|Sends ICMP packets to each router on the way to a destination and displays results of the packets returned from each hop.|  
|NSlookup|Displays information that you can use to diagnose the DNS infrastructure.|  
  
> [!NOTE]  
> The commands that are used to test connections \(**Test\-Connection**, **ping**, **tracert**, and **pathping**\) will be blocked if the destination computer or device is configured to deny ICMP echo requests.  
  
##### To verify local network settings  
  
1.  When you test network connectivity to the local computer and other computers and devices, begin by verifying that the local computer is responding. Next, test network connectivity to computers and devices on a path from the local computer out to the Internet.  
  
    Network settings can be verified by testing connectivity to the following devices:  
  
    -   The loopback address \(127.0.0.1\)  
  
    -   An IP address assigned to the network adapter that you want to connect to the Internet  
  
    -   The IP address for the default gateway  
  
    -   The IP address for the default DNS server  
  
    -   An IP address on the Internet  
  
    -   A DNS name on the Internet  
  
    You can use the **ping** command or the **Test\-Connection** Windows PowerShell cmdlet to test connectivity. In the following example, 157.54.10.29 is the preferred DNS server for the host VM02.  
  
    ```  
    PS C:\> Test-Connection 157.54.10.29  
  
    Source        Destination     IPV4Address      IPV6Address                              Bytes    Time(ms)  
    ------        -----------     -----------      -----------                              -----    --------  
    VM02           157.54.10.29    157.54.10.29     2001:4898:c8:600b:3968:4760:1905:30e1    32       1  
    VM02           157.54.10.29    157.54.10.29     2001:4898:c8:600b:3968:4760:1905:30e1    32       1  
    VM02           157.54.10.29    157.54.10.29     2001:4898:c8:600b:3968:4760:1905:30e1    32       1  
    VM02           157.54.10.29    157.54.10.29     2001:4898:c8:600b:3968:4760:1905:30e1    32       1  
    ```  
  
    Remember that these commands can be blocked if the computer or device is configured to deny ICMP echo requests. Devices on the Internet are frequently configured to block ICMP.  
  
2.  Test routing to a remote host. In the following example, the **tracert** command is used without resolving the host names, and the number of hops is limited to 12. The first hop in this list is the default gateway. ICMP is blocked starting at hop \#9.  
  
    ```  
    C:\> Tracert -d -h 12 microsoft.com  
  
    Tracing route to microsoft.com [64.4.11.37]  
    over a maximum of 12 hops:  
  
      1    <1 ms    <1 ms    <1 ms  10.123.182.1  
      2     1 ms     1 ms    <1 ms  10.37.2.182  
      3     1 ms     1 ms     1 ms  10.37.67.61  
      4    <1 ms    <1 ms    <1 ms  10.37.44.102  
      5    <1 ms    <1 ms     1 ms  10.37.67.222  
      6     1 ms     1 ms     1 ms  10.37.45.77  
      7     1 ms     1 ms    <1 ms  131.107.202.166  
      8     2 ms     2 ms     2 ms  131.107.200.74  
      9     *        *        *     Request timed out.  
     10     *        *        *     Request timed out.  
     11     *        *        *     Request timed out.  
     12     *        *        *     Request timed out.  
  
    Trace complete.  
    ```  
  
    Verify that the computer is able to send traffic off the local network.  
  
3.  Test the default DNS server to verify that it is functional. See the following example.  
  
    ```  
    PS C:\> Test-DnsServer -IPAddress 157.54.10.29  
  
    IPAddress                               Result                                  RoundTripTime                           TcpTried  
    ---------                               ------                                  -------------                           --------  
    157.54.10.29                            Success                                 00:00:00                                False  
    ```  
  
    Verify that **Success** is displayed under **Result**.  
  
4.  Test DNS resolution for a name on the Internet. See the following example.  
  
    ```  
    PS C:\> Resolve-DnsName microsoft.com  
  
    Name                                           Type   TTL   Section    IPAddress  
    ----                                           ----   ---   -------    ---------  
    microsoft.com                                  A      710   Answer     64.4.11.37  
    microsoft.com                                  A      710   Answer     65.55.58.201  
    ```  
  
    Verify that no errors are displayed.  
  
If one or more of these commands fails, verify that the network settings are correct and use this information to repair the problem. If the local network settings are correct and you are unable to repair the problem, review the remote network settings.  
  
## <a name="remote_network"></a>Review remote network settings  
Nearly every network today implements policies and protocols to control access to and from the Internet. These remote network settings are in place to protect the local computer, but they can also prevent Internet access. If you are having trouble connecting to the Internet after you have verified the network adapter status and the local or virtual network settings, contact your network administrator to review the settings and verify that the remote network settings are not preventing you from connecting to the Internet.  
  
Examples of network security and isolation methods that can block Internet access include firewalls, MAC address filters, IP access control lists \(ACLs\), proxy servers, IP security \(IPsec\) policies, VLANs, Virtual Extensible LANs \(VXLAN\), and Network Virtualization for Generic Routing Encapsulation \(NVGRE\). For example, the local computer can be configured with a correct default gateway, IP address, and subnet mask, but the network troubleshooter reports that the default gateway is not available. This might be due to a network security or isolation policy applied to the local computer. These policies are common in some network environments, such as data centers.  
  
If one or more network security policies or settings are preventing the local computer from connecting to the Internet, a network administrator must enable this access. You cannot configure remote network settings on the local computer.  
  
Other remote network problems that can disrupt Internet access include the failure of network infrastructure services, devices, and connections. To determine if the issue is isolated to the local computer, you can attempt a connection to the Internet by using another computer that is located on the same subnet or on an adjacent subnet. If another computer is also affected, it is likely that the issue is not caused by settings on the local computer.  
  
## Related resources  
[Microsoft Management Console 3.0_deleted](../Topic/Microsoft-Management-Console-3.0_deleted.md)  
  

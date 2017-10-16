---
title: Converged NIC Teamed NIC Configuration
description: This topic provides instructions on how to configure Converged NIC in a datacenter configuration in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: f01546f8-c495-4055-8492-8806eee99862
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Converged NIC Teamed NIC Configuration

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following sections provide instructions for deploying Converged NIC in a Teamed NIC configuration with Switch Embedded Teaming \(SET\). The example configuration in this guide depicts two Hyper-V hosts, Hyper-V Host 1, and Hyper-V Host 2.

## Test Connectivity Between Source and Destination

This section provides the steps required to test connectivity between source and destination Hyper-V hosts.

The following illustration depicts two Hyper-V hosts, **Hyper-V Host 1** and **Hyper-V Host 2**. 

Both Hyper-V hosts have two network adapters. On each host, one adapter is connected to the 192.168.1.x/24 subnet, and one adapter is connected to the 192.168.2.x/24 subnet.

![Hyper-V hosts](../../media/Converged-NIC/1-datacenter-test-conn.jpg)

### Test NIC Connectivity to the Hyper-V Virtual Switch

By using this step, you can ensure that the physical NIC, for which you will later create a Hyper-V Virtual Switch, can connect to the destination host. 

This test demonstrates connectivity by using Layer 3 \(L3\) - or the IP layer - as well as the Layer 2 \(L2\) virtual local area networks \(VLAN\).

You can use the following Windows PowerShell command to obtain the properties of the network adapter.

    Get-NetAdapter -Name "Test-40G-1" | ft -AutoSize
     
Following are example results of this command.

|Name|InterfaceDescription|ifIndex|Status|MacAddress|LinkSpeed|
|-----|--------------------|-------|-----|----------|---------|
|
|Test-40G-1|Mellanox ConnectX-3 Pro Ethernet Adapter|11|Up|E4-1D-2D-07-43-D0|40 Gbps|

You can use one of the following commands to obtain additional adapter properties, including the IP address.

    Get-NetIPAddress -InterfaceAlias "Test-40G-1"

    Get-NetIPAddress -InterfaceAlias "TEST-40G-1" | Where-Object {$_.AddressFamily -eq "IPv4"} | fl InterfaceAlias,IPAddress
    
Following are example results of these commands.

|Parameter|Value|
|---------|-----|
|
|IPAddress| 192.168.1.3|
|InterfaceIndex|11|
|InterfaceAlias|Test-40G-1|
|AddressFamily|IPv4|
|Type| Unicast|
|PrefixLength|24|

### Verify that NIC Team Member has a Valid IP Address

You can use this step to verify that other NIC Team or Switch Embedded Team \(SET\) member physical NICs \(pNICs\) also have a valid IP address.

For this step, you can use a separate subnet, \(xxx.xxx.**2**.xxx vs xxx.xxx.**1**.xxx\), to facilitate sending from this adapter to the destination. 

Otherwise, if you locate both pNICs on the same subnet, the Windows TCP/IP stack load balances among the interfaces and simple validation becomes more complicated.

You can use the following Windows PowerShell command to obtain the properties of the second network adapter.

    Get-NetAdapter -Name "Test-40G-2" | ft -AutoSize

Following are example results of this command.

|Name |InterfaceDescription |ifIndex |Status |MacAddress |LinkSpeed|
|----|--------------------|-------|------|----------|---------|
|
|TEST-40G-2 |Mellanox ConnectX-3 Pro Ethernet A...\#2 |13 |Up |E4-1D-2D-07-40-70 |40 Gbps|

You can use one of the following commands to obtain additional adapter properties, including the IP address.

    Get-NetIPAddress -InterfaceAlias "Test-40G-2"

    Get-NetIPAddress -InterfaceAlias "Test-40G-2" | Where-Object {$\_.AddressFamily -eq "IPv4"} | fl InterfaceAlias,IPAddress

Following are example results of these commands.

|Parameter|Value|
|---------|-----|
|
|IPAddress|192.168.2.3|
|InterfaceIndex|13|
|InterfaceAlias|TEST-40G-2|
|AddressFamily|IPv4|
|Type|Unicast|
|PrefixLength|24|

### Verify that Additional NICs have Valid IP Addresses

You can use this step to ensure that the other NIC has a valid IP address.

For this step, you can use a separate subnet, \(xxx.xxx.**2**.xxx vs xxx.xxx.**1**.xxx\), to facilitate sending from this adapter to the destination. 

Otherwise, if you locate both pNICs on the same subnet, the Windows TCP/IP stack load balances among the interfaces and simple validation becomes more complicated.

You can use the following Windows PowerShell command to obtain the properties of the second network adapter.

    Get-NetAdapter -Name "Test-40G-2" | ft -AutoSize

Following are example results of this command.

|Name |InterfaceDescription |ifIndex |Status |MacAddress |LinkSpeed|
|----|--------------------|-------|------|----------|---------|
|
|TEST-40G-2 |Mellanox ConnectX-3 Pro Ethernet A...\#2 |13 |Up |E4-1D-2D-07-40-70 |40 Gbps|

You can use one of the following commands to obtain additional adapter properties, including the IP address.
    
    Get-NetIPAddress -InterfaceAlias "Test-40G-2"

    Get-NetIPAddress -InterfaceAlias "Test-40G-2" | Where-Object {$_.AddressFamily -eq "IPv4"} | fl InterfaceAlias,IPAddress

Following are example results of these commands.

|Parameter|Value|
|---------|-----|
|
|IPAddress|192.168.2.3|
|InterfaceIndex|13|
|InterfaceAlias|TEST-40G-2|
|AddressFamily|IPv4|
|Type|Unicast|
|PrefixLength|24|

### Ensure that Source and Destination Can Communicate

You can use this step to verify bi-directional communication \(ping from source to destination and vice-versa on both systems\).  In the following example, the **Test-NetConnection** Windows PowerShell command is used, but if you prefer you can use the **ping** command. 

    Test-NetConnection 192.168.1.5

Following are example results of this command.

|Parameter|Value|
|---------|-----|
|
|ComputerName|192.168.1.5|
|RemoteAddress|192.168.1.5|
|InterfaceAlias|Test-40G-1|
|SourceAddress|192.168.1.3|
|PingSucceeded|False|
|PingReplyDetails \(RTT\)|0 ms|

In some cases, you might need to disable Windows Firewall with Advanced Security to successfully perform this test. If you disable the firewall, keep security in mind and ensure that your configuration meets your organization's security requirements.

The following example command allows you to disable all firewall profiles.

    Set-NetFirewallProfile -All -Enabled False
    
After you disable the firewall, you can use the following command to test the connection.

    Test-NetConnection 192.168.1.5

Following are example results of this command.

|Parameter|Value|
|---------|-----|
|
|ComputerName|192.168.1.5|
|RemoteAddress|192.168.1.5|
|InterfaceAlias|Test-40G-1|
|SourceAddress|192.168.1.3|
|PingSucceeded|False|
|PingReplyDetails \(RTT\)|0 ms|

### Verify Connectivity for Additional NICs

With this step, you can repeat the previous steps for all subsequent pNICs that are included in the NIC or SET team.

You can use the following command to test the connection.
    
    Test-NetConnection 192.168.2.5

Following are example results of this command.

|Parameter|Value|
|---------|-----|
|
|ComputerName|192.168.2.5|
|RemoteAddress|192.168.2.5|
|InterfaceAlias|Test-40G-2|
|SourceAddress|192.168.2.3|
|PingSucceeded|False|
|PingReplyDetails \(RTT\)|0 ms|


## Configure VLANs

For this step, the NICs are in **ACCESS** mode. However when you create a Hyper-V Virtual Switch \(vSwitch\) later in this guide, the VLAN properties are applied at the vSwitch port level. 

Because a switch can host multiple VLANs, it is necessary for the Top of Rack \(ToR\) physical switch to have its port configured in Trunk mode.

Consult your ToR switch documentation for instructions on how to configure Trunk mode on the switch.

The following illustration depicts two Hyper-V hosts with two network adapters each that have VLAN 101 and VLAN 102 configured in network adapter properties.

![Configure virtual local area networks](../../media/Converged-NIC/2-datacenter-configure-vlans.jpg)

### Configure the VLAN IDs for both NICs

You can use this step to configure the VLAN IDs for NICs installed in your Hyper-V hosts.

According to the Institute of Electrical and Electronics Engineers \(IEEE\) networking standards, the Quality of Service \(QoS\) properties in the physical NIC act on the 802.1p header that is embedded within the 802.1Q \(VLAN\) header when you configure the VLAN ID.

#### Configure NIC Test-40G-1

With the following commands, configure the VLAN ID for the first NIC, Test-40G-1, then view the resulting configuration.

    
    Set-NetAdapterAdvancedProperty -Name "Test-40G-1" -RegistryKeyword VlanID -RegistryValue "101"
    Get-NetAdapterAdvancedProperty -Name "Test-40G-1" | Where-Object {$_.RegistryKeyword -eq "VlanID"} | ft -AutoSize
    
Following are example results of this command.

|Name |DisplayName| DisplayValue| RegistryKeyword |RegistryValue|
|----|-----------|------------|---------------|-------------|
|
|TEST-40G-1|VLAN ID|101|VlanID|{101}|


Ensure that the VLAN ID takes effect independent of the network adapter implementation by using the following command to restart the network adapter.

    Restart-NetAdapter -Name "Test-40G-1"

You can use the following command to ensure that the network adapter status is **Up** before proceeding.

    Get-NetAdapter -Name "Test-40G-1" | ft -AutoSize

Following are example results of this command.

|Name|InterfaceDescription|ifIndex| Status|MacAddress|LinkSpeed|
|----|--------------------|-------|------|----------| ---------|
|
|Test-40G-1|Mellanox ConnectX-3 Pro Ethernet Ada...|11|Up|E4-1D-2D-07-43-D0|40 Gbps|

#### Configure NIC Test-40G-2

With the following commands, configure the VLAN ID for the second NIC, Test-40G-2, then view the resulting configuration.

    
    Set-NetAdapterAdvancedProperty -Name "Test-40G-2" -RegistryKeyword VlanID -RegistryValue "102"
    Get-NetAdapterAdvancedProperty -Name "Test-40G-2" | Where-Object {$_.RegistryKeyword -eq "VlanID"} | ft -AutoSize
    

Following are example results of this command.

|Name |DisplayName| DisplayValue| RegistryKeyword |RegistryValue|
|----|-----------|------------|---------------|-------------|
|
|TEST-40G-2|VLAN ID|102|VlanID|{102}|

Ensure that the VLAN ID takes effect independent of the network adapter implementation by using the following command to restart the network adapter.

`Restart-NetAdapter -Name "Test-40G-2"  `              

You can use the following command to ensure that the network adapter status is **Up** before proceeding.

    Get-NetAdapter -Name "Test-40G-1" | ft -AutoSize

Following are example results of this command.

|Name|InterfaceDescription|ifIndex| Status|MacAddress|LinkSpeed|
|----|--------------------|-------|------|----------| ---------|
|
|Test-40G-2 |Mellanox ConnectX-3 Pro Ethernet Ada... |11 |Up |E4-1D-2D-07-43-D1 |40 Gbps|


### Verify Connectivity

You can use this section to verify connectivity after the network adapters are restarted. You can confirm connectivity after applying the VLAN tag to both adapters. If connectivity fails, you can inspect the switch VLAN configuration or destination participation in the same VLAN. 

>[!IMPORTANT]
>After you perform the steps in the previous section, it might take several seconds for the device to restart and become available on the network.

#### Verify connectivity for NIC Test-40G-1

To verify connectivity for the first NIC, you can run the following command.

    Test-NetConnection 192.168.1.5
    
Following are example results of this command.

|Parameter|Value|
|---------|-----|
|
|ComputerName|192.168.1.5|
|RemoteAddress|192.168.1.5|
|InterfaceAlias|Test-40G-1|
|SourceAddress|192.168.1.5|
|PingSucceeded|True|
|PingReplyDetails \(RTT\)|0 ms|

#### Verify connectivity for NIC Test-40G-2

You can use this section to test connectivity for NIC Test-40G-2.

You can use the following command to test connectivity for the second NIC.
    
    Test-NetConnection 192.168.2.5
    
Following are example results of this command.

|Parameter|Value|
|---------|-----|
|
|ComputerName|192.168.2.5|
|RemoteAddress|192.168.2.5|
|InterfaceAlias|Test-40G-2|
|SourceAddress|192.168.2.3|
|PingSucceeded|True|
|PingReplyDetails \(RTT\)|0 ms|

A **Test-NetConnection** failure or ping failure that occurs immediately after you perform **Restart-NetAdapter** is not uncommon, so wait for the network adapter to fully initialize, and then try again.

If the VLAN 101 connections work, but the VLAN 102 connections don’t work, the problem might be that the switch needs to be configured to allow port traffic on the desired VLAN. You can check for this by temporarily setting the failing adapters to VLAN 101, and repeating the connectivity test.

## Configure Quality of Service \(QoS\)

The next step is to configure Quality of Service \(QoS\), which requires that you first install the Windows Server 2016 feature Data Center Bridging \(DCB\).

The following illustration depicts your Hyper-V hosts after successfully configuring VLANs in the previous step.

![Configure Quality of Service](../../media/Converged-NIC/3-datacenter-configure-qos.jpg)

### Install Data Center Bridging \(DCB\)

You can use this step to install and enable DCB. In most cases, this step is optional for iWarp implementations, but it's necessary at the fabric scale, such as for cross-rack scenarios.

You can use the following command to install DCB on each of your Hyper-V hosts. 

    Install-WindowsFeature Data-Center-Bridging

Following are example results of this command.

|Success |Restart Needed |Exit Code|Feature Result|
|------- |-------------- |--------- |-------------- |
|
|True |No |Success| {Data Center Bridging}|

### Set the QoS policies for SMB-Direct 

You can use the following command to configure QoS policies for SMB Direct.

    New-NetQosPolicy "SMB" -NetDirectPortMatchCondition 445 -PriorityValue8021Action 3

Following are example results of this command.

|Parameter|Value|
|---------|-----|
|
|Name |SMB|
|Owner|Group Policy \(Machine\)|
|NetworkProfile|All|
|Precedence|127|
|JobObject|&nbsp;| 
|NetDirectPort|445
|PriorityValue|3

### Set policies for other traffic on the interface 

You can use the following command to set additional QoS policies.

    New-NetQosPolicy "DEFAULT" -Default -PriorityValue8021Action 0
 
Following are example results of this command.

|Parameter|Value|
|---------|-----|
|
|Name | DEFAULT|
|Owner|Group Policy \(Machine\)|
|NetworkProfile|All|
|Precedence|127|
|Template| Default|
|JobObject| &nbsp;|
|PriorityValue|0|

### Turn on Flow Control for SMB 

You can use the following commands to enable SMB flow control and to view the results.

    Enable-NetQosFlowControl -priority 3
    Get-NetQosFlowControl

Following are example results of this command.

|Priority|Enabled|PolicySet|IfIndex|IfAlias|
|---------|-----|--------- |-------| -------|
|
|0 |False |Global|&nbsp;|&nbsp;|
|1 |False |Global|&nbsp;|&nbsp;|
|2 |False |Global|&nbsp;|&nbsp;|
|3 |True |Global|&nbsp;|&nbsp;|
|4 |False |Global|&nbsp;|&nbsp;|
|5 |False |Global|&nbsp;|&nbsp;|
|6 |False |Global|&nbsp;|&nbsp;|
|7 |False |Global|&nbsp;|&nbsp;|

If your results do not match these results because items other than 3 have an Enabled value of True, you must perform the next step. If your results match these example results, and only item 3 has an Enabled value of True, you do not need to perform the next step, and can skip down to **Enable QoS for the target and destination network adapters**.

### Ensure Flow Control is Disabled for Other Traffic Classes \(Optional\)

You do not need to perform this step if **FlowControl** is not enabled for traffic classes 0,1,2,4,5,6, and 7.

If **FlowControl** is already enabled for any traffic classes other than 3 \(0,1,2,4,5,6, and 7\), you must disable **FlowControl** for these classes. 

>[!NOTE]
>Under more complex configurations, the other traffic classes might require flow control, however these scenarios are outside the scope of this guide.

You can use the following commands to disable SMB flow control for traffic classes 0,1,2,4,5,6, and 7, and to view the results.

    Disable-NetQosFlowControl -priority 0,1,2,4,5,6,7
    Get-NetQosFlowControl

Following are example results of this command.

|Priority|Enabled|PolicySet|IfIndex|IfAlias|
|---------|-----|--------- |-------| -------|
|
|0 |False |Global|&nbsp;|&nbsp;|
|1 |False |Global|&nbsp;|&nbsp;|
|2 |False |Global|&nbsp;|&nbsp;|
|3 |True |Global|&nbsp;|&nbsp;|
|4 |False |Global|&nbsp;|&nbsp;|
|5 |False |Global|&nbsp;|&nbsp;|
|6 |False |Global|&nbsp;|&nbsp;|
|7 |False |Global|&nbsp;|&nbsp;|

### Enable QoS for the local and destination network adapters 

With this step you can enable QoS for both the local and destination network adapters. Ensure that you run these commands on both of your Hyper-V hosts.

#### Enable QoS for NIC Test-40G-1

You can use the following commands to enable QoS and view the results of your configuration.

    Enable-NetAdapterQos -InterfaceAlias "Test-40G-1"
    Get-NetAdapterQos -Name "Test-40G-1"

Following are example results of this command.

**Name**: TEST-40G-1
**Enabled**: True
**Capabilities**:   

|Parameter|Hardware|Current|
|---------|--------|-------|
|
|MacSecBypass|NotSupported|NotSupported|
|DcbxSupport|None|None|
|NumTCs(Max/ETS/PFC)|8/8/8|8/8/8|
 
**OperationalTrafficClasses**: 

|TC|TSA|Bandwidth|Priorities|
|----|-----|--------|-------|
|
|0| Strict|&nbsp;|0-7|

**OperationalFlowControl**: Priority 3 Enabled
**OperationalClassifications**:

|Protocol|Port/Type|Priority|
|--------|---------|--------|
|
|Default|&nbsp;|0|
|NetDirect| 445|3|

#### Enable QoS for NIC Test-40G-2

You can use the following commands to enable QoS and view the results of your configuration.

    Enable-NetAdapterQos -InterfaceAlias "Test-40G-2"
    Get-NetAdapterQos -Name "Test-40G-2"

 
Following are example results of this command.

**Name**: TEST-40G-2
**Enabled**: True
**Capabilities**:   

|Parameter|Hardware|Current|
|---------|--------|-------|
|
|MacSecBypass|NotSupported|NotSupported|
|DcbxSupport|None|None|
|NumTCs(Max/ETS/PFC)|8/8/8|8/8/8|
 
**OperationalTrafficClasses**: 

|TC|TSA|Bandwidth|Priorities|
|----|-----|--------|-------|
|
|0| Strict|&nbsp;|0-7|

**OperationalFlowControl**: Priority 3 Enabled
**OperationalClassifications**:

|Protocol|Port/Type|Priority|
|--------|---------|--------|
|
|Default|&nbsp;|0|
|NetDirect| 445|3|


### Allocate 50% of the Bandwidth Reservation to SMB Direct \(RDMA\)

You can use the following commands to assign half of the bandwidth reservation to SMB Direct.

    New-NetQosTrafficClass "SMB" -priority 3 -bandwidthpercentage 50 -algorithm ETS

Following are example results of this command.

|Name|Algorithm |Bandwidth(%)| Priority |PolicySet |IfIndex |IfAlias |
|----|---------| ------------ |--------| ---------|------- |------- |
|
|SMB | ETS     | 50 |3 |Global |&nbsp;|&nbsp;|                                      
 
You can use the following command to view bandwidth reservation information.

    Get-NetQosTrafficClass | ft -AutoSize

Following are example results of this command.
 
|Name|Algorithm |Bandwidth(%)| Priority |PolicySet |IfIndex |IfAlias |
|----|---------| ------------ |--------| ---------|------- |------- |
|
|[Default]| ETS|50 |0-2,4-7|  Global|&nbsp;|&nbsp;| 
SMB |ETS|50 |3 |Global|&nbsp;|&nbsp;| 

### Create Traffic Classes for Tenant IP Traffic \(optional\)

You can use this step to create two additional traffic classes for tenant IP traffic. 

When you run the following example commands, you can omit the “IP1” and “IP2” values if you prefer.

    New-NetQosTrafficClass "IP1" -Priority 1 -bandwidthpercentage 10 -algorithm ETS

Following are example results of this command.

|Name|Algorithm |Bandwidth(%)| Priority |PolicySet |IfIndex |IfAlias |
|----|---------| ------------ |--------| ---------|------- |------- |
|
|IP1 |ETS |10 |1 |Global|&nbsp;|&nbsp;|


    New-NetQosTrafficClass "IP2" -Priority 2 -bandwidthpercentage 10 -algorithm ETS

Following are example results of this command.

|Name|Algorithm |Bandwidth(%)| Priority |PolicySet |IfIndex |IfAlias |
|----|---------| ------------ |--------| ---------|------- |------- |
|
|IP2 |ETS |10 |2 |Global|&nbsp;|&nbsp;|

You can use the following command to view QoS traffic classes.

    Get-NetQosTrafficClass | ft -AutoSize

Following are example results of this command.

|Name|Algorithm |Bandwidth(%)| Priority |PolicySet |IfIndex |IfAlias |
|----|---------| ------------ |--------| ---------|------- |------- |
|
|[Default] |ETS |30 |0,4-7 |Global|&nbsp;|&nbsp;|
|SMB |ETS |50 |3 |Global|&nbsp;|&nbsp;|
|IP1 |ETS |10 |1 |Global|&nbsp;|&nbsp;|
|IP2 |ETS |10 |2 |Global|&nbsp;|&nbsp;|

## Configure Debugger \(Optional\)

You can use this step to configure the debugger.

By default, the attached debugger blocks NetQos. You can use the following commands to override the debugger and view the results.

    Set-ItemProperty HKLM:"\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" AllowFlowControlUnderDebugger -type DWORD -Value 1 –Force
    
    Get-ItemProperty HKLM:"\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" | ft AllowFlowControlUnderDebugger

Following are example results of this command.

    AllowFlowControlUnderDebugger
    -----------------------------
    1

## Test RDMA \(Mode 1\)

You can use this step to ensure that the fabric is correctly configured prior to creating a vSwitch and transitioning to RDMA \(Mode 2\).

The following illustration depicts the current state of the Hyper-V hosts.

![Test RDMA](../../media/Converged-NIC/4-datacenter-test-rdma.jpg)

To verify the RDMA configuration, you can run the following command.

    Get-NetAdapterRdma | ft -AutoSize

Following are example results of this command.

|Name |InterfaceDescription |Enabled|
|----|--------------------|-------|
|
|TEST-40G-1| Mellanox ConnectX-4 VPI Adapter #2 |True|
|TEST-40G-2| Mellanox ConnectX-4 VPI Adapter |True|


### Determine the ifIndex value of your target adapter

You can use the following command to discover the ifIndex value of the target adapter.

    Get-NetIPConfiguration -InterfaceAlias "TEST*" | ft InterfaceAlias,InterfaceIndex,IPv4Address

Following are example results of this command.

|InterfaceAlias |InterfaceIndex |IPv4Address|
|-------------- |-------------- |-----------|
|TEST-40G-1 |14 |{192.168.1.3}|
|TEST-40G-2 | 13 |{192.168.2.3}|

### Download DiskSpd.exe and a PowerShell Script

To continue, you must first download the following items.

- Download the DiskSpd.exe utility and extract the utility into C:\TEST\ 
[http://tinyurl.com/z68h3rc](http://tinyurl.com/z68h3rc)

- Download the Test-RDMA powershell script to C:\TEST\ 
[https://github.com/Microsoft/SDN/blob/master/Diagnostics/Test-Rdma.ps1](https://github.com/Microsoft/SDN/blob/master/Diagnostics/Test-Rdma.ps1)

### Run the PowerShell script

When you run the Test-Rdma.ps1 Windows PowerShell script, you can pass the ifIndex value to the script, along with the IP address of the remote adapter on the same VLAN.

You can use the following example command to run the script with an ifIndex of 14 on the network adapter 192.168.1.5.
    
    C:\TEST\Test-RDMA.PS1 -IfIndex 14 -IsRoCE $true -RemoteIpAddress 192.168.1.5 -PathToDiskspd C:\TEST\Diskspd-v2.0.17\amd64fre\
    
    VERBOSE: Diskspd.exe found at C:\TEST\Diskspd-v2.0.17\amd64fre\\diskspd.exe
    VERBOSE: The adapter TEST-40G-1 is a physical adapter
    VERBOSE: Underlying adapter is RoCE. Checking if QoS/DCB/PFC is configured on each physical adapter(s)
    VERBOSE: QoS/DCB/PFC configuration is correct.
    VERBOSE: RDMA configuration is correct.
    VERBOSE: Checking if remote IP address, 192.168.1.5, is reachable.
    VERBOSE: Remote IP 192.168.1.5 is reachable.
    VERBOSE: Disabling RDMA on adapters that are not part of this test. RDMA will be enabled on them later.
    VERBOSE: Testing RDMA traffic now for. Traffic will be sent in a parallel job. Job details:
    VERBOSE: 0 RDMA bytes written per second
    VERBOSE: 0 RDMA bytes sent per second
    VERBOSE: 662979201 RDMA bytes written per second
    VERBOSE: 37561021 RDMA bytes sent per second
    VERBOSE: 1023098948 RDMA bytes written per second
    VERBOSE: 8901349 RDMA bytes sent per second
    VERBOSE: Enabling RDMA on adapters that are not part of this test. RDMA was disabled on them prior to sending RDMA traffic.
    VERBOSE: RDMA traffic test SUCCESSFUL: RDMA traffic was sent to 192.168.1.5
    

>[!NOTE]
>If the RDMA traffic fails, for the RoCE case specifically, consult your ToR Switch configuration for proper PFC/ETS settings that should match the Host settings. Refer to the QoS section in this document for reference values.

### Determine the ifIndex value of your target adapter

You can use the following command to discover the ifIndex value of the target adapter.

    Get-NetIPConfiguration -InterfaceAlias "TEST*" | ft InterfaceAlias,InterfaceIndex,IPv4Address

Following are example results of this command.

|InterfaceAlias |InterfaceIndex |IPv4Address|
|-------------- |-------------- |-----------|
|TEST-40G-1 |14 |{192.168.1.3}|
|TEST-40G-2 | 13 |{192.168.2.3}|

You can use the following example command to run the script with an ifIndex of 13 on the network adapter 192.168.2.5.

    
    C:\TEST\Test-RDMA.PS1 -IfIndex 13 -IsRoCE $true -RemoteIpAddress 192.168.2.5 -PathToDiskspd C:\TEST\Diskspd-v2.0.17\amd64fre\
    VERBOSE: Diskspd.exe found at C:\TEST\Diskspd-v2.0.17\amd64fre\\diskspd.exe
    VERBOSE: The adapter TEST-40G-2 is a physical adapter
    VERBOSE: Underlying adapter is RoCE. Checking if QoS/DCB/PFC is configured on each physical adapter(s)
    VERBOSE: QoS/DCB/PFC configuration is correct.
    VERBOSE: RDMA configuration is correct.
    VERBOSE: Checking if remote IP address, 192.168.2.5, is reachable.
    VERBOSE: Remote IP 192.168.2.5 is reachable.
    VERBOSE: Disabling RDMA on adapters that are not part of this test. RDMA will be enabled on them later.
    VERBOSE: Testing RDMA traffic now for. Traffic will be sent in a parallel job. Job details:
    VERBOSE: 0 RDMA bytes written per second
    VERBOSE: 0 RDMA bytes sent per second
    VERBOSE: 541185606 RDMA bytes written per second
    VERBOSE: 34821478 RDMA bytes sent per second
    VERBOSE: 954717307 RDMA bytes written per second
    VERBOSE: 35040816 RDMA bytes sent per second
    VERBOSE: Enabling RDMA on adapters that are not part of this test. RDMA was disabled on them prior to sending RDMA traffic.
    VERBOSE: RDMA traffic test SUCCESSFUL: RDMA traffic was sent to 192.168.2.5
    

## Create a Hyper-V Virtual Switch

You can use this section to create a Hyper-V Virtual Switch \(vSwitch\) on your Hyper-V hosts.

The following illustration depicts Hyper-V Host 1 with a vSwitch.

![Create a Hyper-V Virtual Switch](../../media/Converged-NIC/5-datacenter-create-vswitch.jpg)

### Create a vSwitch in Switch Embedded Teaming \(SET\) mode

You can use the following example command to create a SET switch independent team named **VMSTEST** on Hyper-V Host 1. Both of the network adapters on this computer, TEST-40G-1 and TEST-40G-2, are added to the SET team with this command.
    
    New-VMSwitch –Name "VMSTEST" –NetAdapterName "TEST-40G-1","TEST-40G-2" -EnableEmbeddedTeaming $true -AllowManagementOS $true
    
Following are example results of this command.

|Name |SwitchType |NetAdapterInterfaceDescription|
|---- |---------- |------------------------------|
|VMSTEST |External |Teamed-Interface|

You can use this command to view the physical adapter team in SET.

    Get-VMSwitchTeam -Name "VMSTEST" | fl

Following are example results of this command.

**Name**: VMSTEST
**Id**: ad9bb542-dda2-4450-a00e-f96d44bdfbec
**NetAdapterInterfaceDescription**: {Mellanox ConnectX-3 Pro Ethernet Adapter, Mellanox ConnectX-3 Pro Ethernet Adapter #2}
**TeamingMode**: SwitchIndependent
**LoadBalancingAlgorithm**: Dynamic

#### Display two views of the Host vNIC

You can use the following two commands for two different views of the Host vNIC.

You can use this command to display properties of the Host vNIC.

    Get-NetAdapter

Following are example results of this command.

|Name |InterfaceDescription |ifIndex |Status |MacAddress |LinkSpeed|
|---- --------------------|-------|------|----------|---------|
|
|vEthernet (VMSTEST)|Hyper-V Virtual Ethernet Adapter #2 |28 |Up|E4-1D-2D-07-40-71|80 Gbps|

You can use this command to display additional properties of the Host vNIC.

    Get-VMNetworkAdapter -ManagementOS

Following are example results of this command.

|Name |IsManagementOs |VMName |SwitchName |MacAddress |Status |IPAddresses|
|----|--------------|------|----------|----------|------|-----------|
|
|VMSTEST|True |VMSTEST |E41D2D074071| {Ok}|&nbsp;|

#### Test the network connection to the remote VLAN 101 adapter

You can use this command to test the connection to the remote VLAN 101 adapter.

`Test-NetConnection 192.168.1.5` 

Following are example results of this command.

    WARNING: Ping to 192.168.1.5 failed -- Status: DestinationHostUnreachable
    
    ComputerName   : 192.168.1.5
    RemoteAddress  : 192.168.1.5
    InterfaceAlias : vEthernet (CORP-External-Switch)
    SourceAddress  : 10.199.48.170
    PingSucceeded  : False
    PingReplyDetails (RTT) : 0 ms
    
### Reconfigure VLANs

You can use this step to remove the ACCESS VLAN setting from the physical NIC and to set the VLANID using the vSwitch.

You must remove the ACCESS VLAN setting to prevent both auto-tagging the egress traffic with the incorrect VLAN ID and from filtering ingress traffic which doesn’t match the ACCESS VLAN ID.

You can use the following commands to remove the ACCESS VLAN setting.
    
    Set-NetAdapterAdvancedProperty -Name "Test-40G-1" -RegistryKeyword VlanID -RegistryValue "0"
    Set-NetAdapterAdvancedProperty -Name "Test-40G-2" -RegistryKeyword VlanID -RegistryValue "0"
    

You can use the following commands to set the VLANID using the vSwitch specific Windows PowerShell commands and to view the results of this action.

    
    Set-VMNetworkAdapterVlan -VMNetworkAdapterName "VMSTEST" -VlanId "101" -Access -ManagementOS
    Get-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "VMSTEST"
    

Following are example results of this command.

VMName VMNetworkAdapterName Mode   VlanList
------ -------------------- ----   --------
       VMSTEST              Access 101     

You can use the following command to test the network connection and view the results.

    Test-NetConnection 192.168.1.5
    
    ComputerName   : 192.168.1.5
    RemoteAddress  : 192.168.1.5
    InterfaceAlias : vEthernet (VMSTEST)
    SourceAddress  : 192.168.1.3
    PingSucceeded  : True
    PingReplyDetails (RTT) : 0 ms
    

If your results are not similar to the example results and ping fails with the message "WARNING: Ping to 192.168.1.5 failed -- Status: DestinationHostUnreachable," confirm that the “vEthernet (VMSTEST)” has the proper IP address by running the following command.

    
    Get-NetIPAddress -InterfaceAlias "vEthernet (VMSTEST)"
    

If the IP address is not set, you can use the following command to correct the issue and view the results of your actions.

    
    New-NetIPAddress -InterfaceAlias "vEthernet (VMSTEST)" -IPAddress 192.168.1.3 -PrefixLength 24
    
    IPAddress : 192.168.1.3
    InterfaceIndex: 37
    InterfaceAlias: vEthernet (VMSTEST)
    AddressFamily : IPv4
    Type  : Unicast
    PrefixLength  : 24
    PrefixOrigin  : Manual
    SuffixOrigin  : Manual
    AddressState  : Tentative
    ValidLifetime : Infinite ([TimeSpan]::MaxValue)
    PreferredLifetime : Infinite ([TimeSpan]::MaxValue)
    SkipAsSource  : False
    PolicyStore   : ActiveStore
    
#### Rename the Management NIC

You can use this section to rename the Management NIC, and later use separate Host vNIC instances for RDMA.

You can run the following commands to rename the Management NIC and view some NIC properties.

    Rename-VMNetworkAdapter -ManagementOS -Name “VMSTEST” -NewName “MGT”
    Get-VMNetworkAdapter -ManagementOS

Following are example results of this command.

|Name |IsManagementOs |VMName |SwitchName |MacAddress |Status |IPAddresses
|----|--------------|------|----------|----------|------|-----------|
|
|CORP-External-Switch |True |&nbsp;|CORP-External-Switch |001B785768AA |{Ok}|&nbsp;|
|MGT |True |&nbsp;|VMSTEST |E41D2D074071 |{Ok}|&nbsp;|

You can run the following command to view some additional NIC properties.

    Get-NetAdapter

Following are example results of this command.

|Name |InterfaceDescription |ifIndex |Status |MacAddress |LinkSpeed|
|----|--------------------|------|----------|---------|------|
|
|vEthernet (MGT) |Hyper-V Virtual Ethernet Adapter #2 |28 |Up | E4-1D-2D-07-40-71 |80 Gbps|

## Test Hyper-V Virtual Switch RDMA

The following illustration depicts the current state of your Hyper-V hosts, including the vSwitch on Hyper-V Host 1.

![Test the Hyper-V Virtual Switch](../../media/Converged-NIC/6-datacenter-test-vswitch-rdma.jpg)

### Set Priority tagging on the Host vNIC to complement the previous VLAN settings

You can use the following example commands to set priority tagging on the Host vNIC and view the results of your actions.
    
    Set-VMNetworkAdapter -ManagementOS -Name "MGT" -IeeePriorityTag on
    Get-VMNetworkAdapter -ManagementOS -Name "MGT" | fl Name,IeeePriorityTag
    

    Name: MGT
    IeeePriorityTag : On
    
### Create two Host vNICs for RDMA

You can use the following example commands to create two host vNICs for RDMA and connect them to the vSwitch VMSTEST.
    
    Add-VMNetworkAdapter –SwitchName "VMSTEST" –Name SMB1 –ManagementOS
    Add-VMNetworkAdapter –SwitchName "VMSTEST" –Name SMB2 –ManagementOS
    
You can use the following example command to view Management NIC properties.
    
    Get-VMNetworkAdapter -ManagementOS
    
Following are example results of this command.

|Name |IsManagementOs |VMName |SwitchName |MacAddress |Status |IPAddresses|
|----|--------------|------|----------|----------|------|-----------|
|
|CORP-External-Switch |True |CORP-External-Switch |001B785768AA|{Ok} |&nbsp;| 
|Mgt |True |VMSTEST |E41D2D074071 |{Ok} |&nbsp;|
|SMB1 |True |VMSTEST |00155D30AA00 |{Ok} |&nbsp;|
|SMB2 |True |VMSTEST |00155D30AA01 |{Ok} |&nbsp;|

### Assign an IP address to the SMB Host vNICs

You can use this section to assign IP addressrd to the SMB Host vNICs vEthernet \(SMB1\) and vEthernet \(SMB2\).

The TEST-40G-1 and TEST-40G-2 physical adapters still have an ACCESS VLAN of 101 and 102 configured. Because of this, the adapters tag the traffic - and ping succeeds.

Previously, you configured both pNIC VLAN IDs to zero, then set the VMSTEST vSwitch to VLAN 101. After that, you were still able to ping the remote VLAN 101 adapter by using the MGT vNIC, but there are currently no VLAN 102 members.

Now you can use the following example command to remove the ACCESS VLAN setting from the physical NIC to prevent it from both auto-tagging the egress traffic with the incorrect VLAN ID and to prevent it from filtering ingress traffic that doesn’t match the ACCESS VLAN ID.

You can use the following example command to accomplish these goals by addtion a new IP address to interface vEthernet (SMB1), and view the results.

    
    New-NetIPAddress -InterfaceAlias "vEthernet (SMB1)" -IPAddress 192.168.2.111 -PrefixLength 24
    
    IPAddress : 192.168.2.111
    InterfaceIndex: 40
    InterfaceAlias: vEthernet (SMB1)
    AddressFamily : IPv4
    Type  : Unicast
    PrefixLength  : 24
    PrefixOrigin  : Manual
    SuffixOrigin  : Manual
    AddressState  : Invalid
    ValidLifetime : Infinite ([TimeSpan]::MaxValue)
    PreferredLifetime : Infinite ([TimeSpan]::MaxValue)
    SkipAsSource  : False
    PolicyStore   : PersistentStore
    

You can use the following example command to test the remote VLAN 102 adapter and view the results.
    
    Test-NetConnection 192.168.2.5 
    
    ComputerName   : 192.168.2.5
    RemoteAddress  : 192.168.2.5
    InterfaceAlias : vEthernet (SMB1)
    SourceAddress  : 192.168.2.111
    PingSucceeded  : True
    PingReplyDetails (RTT) : 0 ms
    
You can use the following example command to add a new IP address for interface vEthernet \(SMB2\), and view the results.
    
    New-NetIPAddress -InterfaceAlias "vEthernet (SMB2)" -IPAddress 192.168.2.222 -PrefixLength 24 
    
    IPAddress : 192.168.2.222
    InterfaceIndex: 44
    InterfaceAlias: vEthernet (SMB2)
    AddressFamily : IPv4
    Type  : Unicast
    PrefixLength  : 24
    PrefixOrigin  : Manual
    SuffixOrigin  : Manual
    AddressState  : Invalid
    ValidLifetime : Infinite ([TimeSpan]::MaxValue)
    PreferredLifetime : Infinite ([TimeSpan]::MaxValue)
    SkipAsSource  : False
    PolicyStore   : PersistentStore
    
You do not need to test the connection again because communication is established.

### Place the RDMA Host vNICs on VLAN 102

You can use this section to assign the RDMA Host vNICs to VLAN 102.

Because the “MGT” Host vNIC is located on VLAN 101, you can use the following example commands to place the RDMA Host vNICs on the pre-existing VLAN 102 and view the results of your actions.

    
    Set-VMNetworkAdapterVlan -VMNetworkAdapterName "SMB1" -VlanId "102" -Access -ManagementOS
    Set-VMNetworkAdapterVlan -VMNetworkAdapterName "SMB2" -VlanId "102" -Access -ManagementOS
    
    Get-VMNetworkAdapterVlan -ManagementOS
    
    VMName VMNetworkAdapterName Mode VlanList
    ------ -------------------- ---- --------
       SMB1 Access   102 
       Mgt  Access   101 
       SMB2 Access   102 
       CORP-External-Switch Untagged
    
### Inspect the Mapping of SMB1 and SMB2 to the underlying Physical NICs

You can use this section to inspect the mapping of SMB1 and SMB2 to the underlying physical NICs under the vSwitch SET Team.  The association of Host vNIC to Physical NICs is random and subject to rebalancing during creation and destruction.

In this circumstance you can use an indirect mechanism to check the current association.

The MAC addresses of SMB1 and SMB2 are associated with the NIC Team member TEST-40G-2. This is not ideal because Test-40G-1 does not have an associated SMB Host vNIC, and will not allow for utilization of RDMA traffic over the link until an SMB Host vNIC is mapped to it.

You can use the following example commands to view this information.

    
    Get-NetAdapterVPort (Preferred)
    
    Get-NetAdapterVmqQueue
    
    Name   QueueID MacAddressVlanID Processor VmFriendlyName
    ----   ------- ---------------- --------- --------------
    TEST-40G-1 1   E4-1D-2D-07-40-71 1010:17
    TEST-40G-2 1   00-15-5D-30-AA-00 1020:17
    TEST-40G-2 2   00-15-5D-30-AA-01 1020:17
    
    Get-VMNetworkAdapter -ManagementOS
    
    Name IsManagementOs VMName SwitchName   MacAddress   Status IPAddresses
    ---- -------------- ------ ----------   ----------   ------ -----------
    CORP-External-Switch True  CORP-External-Switch 001B785768AA {Ok}  
    Mgt  True  VMSTEST  E41D2D074071 {Ok}  
    SMB1 True  VMSTEST  00155D30AA00 {Ok}  
    SMB2 True  VMSTEST  00155D30AA01 {Ok}  
    

Both commands below should return no information because you have not yet performed mapping.
    
    Get-VMNetworkAdapterTeamMapping -ManagementOS -SwitchName VMSTEST -VMNetworkAdapterName SMB1
    Get-VMNetworkAdapterTeamMapping -ManagementOS -SwitchName VMSTEST -VMNetworkAdapterName SMB2
    
You can use the following example commands to map SMB1 and SMB2 to separate physical NIC team members, and to view the results of your actions.

>[!IMPORTANT]
>Ensure that you complete this step before proceeding, or your implementation will fail.
    
    Set-VMNetworkAdapterTeamMapping -ManagementOS -SwitchName VMSTEST -VMNetworkAdapterName "SMB1" -PhysicalNetAdapterName "Test-40G-1"
    Set-VMNetworkAdapterTeamMapping -ManagementOS -SwitchName VMSTEST -VMNetworkAdapterName "SMB2" -PhysicalNetAdapterName "Test-40G-2"
    
    Get-VMNetworkAdapterTeamMapping -ManagementOS -SwitchName VMSTEST
    
    NetAdapterName : Test-40G-1
    NetAdapterDeviceId : {BAA9A00F-A844-4740-AA93-6BD838F8CFBA}
    ParentAdapter  : VMInternalNetworkAdapter, Name = 'SMB1'
    IsTemplate : False
    CimSession : CimSession: .
    ComputerName   : 27-3145G0803
    IsDeleted  : False
    
    NetAdapterName : Test-40G-2
    NetAdapterDeviceId : {B7AB5BB3-8ACB-444B-8B7E-BC882935EBC8}
    ParentAdapter  : VMInternalNetworkAdapter, Name = 'SMB2'
    IsTemplate : False
    CimSession : CimSession: .
    ComputerName   : 27-3145G0803
    IsDeleted  : False
    
### Confirm the MAC associations

You can use the following example commands to confirm the MAC associations you have created previously.
    
    Get-NetAdapterVmqQueue
    
    Name   QueueID MacAddressVlanID Processor VmFriendlyName
    ----   ------- ---------------- --------- --------------
    TEST-40G-1 1   E4-1D-2D-07-40-71 1010:17
    TEST-40G-1 2   00-15-5D-30-AA-00 1020:17
    TEST-40G-2 1   00-15-5D-30-AA-01 1020:17
    

Because both Host vNICs reside on the same subnet and have the same VLAN ID \(102\), you can  validate communication from the remote system, and view the results of your actions.

>[!IMPORTANT]
>Run the following commands on the remote computer.

    
    Test-NetConnection 192.168.2.111
    
    
    ComputerName   : 192.168.2.111
    RemoteAddress  : 192.168.2.111
    InterfaceAlias : Test-40G-2
    SourceAddress  : 192.168.2.5
    PingSucceeded  : True
    PingReplyDetails (RTT) : 0 ms
    
    Test-NetConnection 192.168.2.222
    
    ComputerName   : 192.168.2.222
    RemoteAddress  : 192.168.2.222
    InterfaceAlias : Test-40G-2
    SourceAddress  : 192.168.2.5
    PingSucceeded  : True
    PingReplyDetails (RTT) : 0 ms 
    
    	
    Set-VMNetworkAdapter -ManagementOS -Name "SMB1" -IeeePriorityTag on
    Set-VMNetworkAdapter -ManagementOS -Name "SMB2" -IeeePriorityTag on
    Get-VMNetworkAdapter -ManagementOS -Name "SMB*" | fl Name,SwitchName,IeeePriorityTag,Status
    
    Name: SMB1
    SwitchName  : VMSTEST
    IeeePriorityTag : On
    Status  : {Ok}
    
    Name: SMB2
    SwitchName  : VMSTEST
    IeeePriorityTag : On
    Status  : {Ok}
    

    Get-NetAdapterRdma -Name "vEthernet*" | sort Name | ft -AutoSize
    
    Name  InterfaceDescription Enabled
    ----  -------------------- -------
    vEthernet (SMB2)  Hyper-V Virtual Ethernet Adapter #4  False  
    vEthernet (SMB1)  Hyper-V Virtual Ethernet Adapter #3  False  
    vEthernet (MGT)   Hyper-V Virtual Ethernet Adapter #2  False   
    
    
    Enable-NetAdapterRdma -Name "vEthernet (SMB1)"
    Enable-NetAdapterRdma -Name "vEthernet (SMB2)"
    Get-NetAdapterRdma -Name "vEthernet*" | sort Name | fl *
    
    
    Name  InterfaceDescription Enabled
    ----  -------------------- -------
    vEthernet (SMB2)  Hyper-V Virtual Ethernet Adapter #4  True   
    vEthernet (SMB1)  Hyper-V Virtual Ethernet Adapter #3  True  
    vEthernet (MGT)   Hyper-V Virtual Ethernet Adapter #2  False
      

### Validate RDMA functionality from the remote system

You can use this section to validate RDMA functionality from the remote system to the local system, which has a vSwitch, thereby testing both adapters that are members of the vSwitch SET team.

Because both Host vNICs \(SMB1 and SMB2\) are assigned to VLAN 102, you can select the VLAN 102 adapter on the remote system.  

In this process, the NIC Test-40G-2 does RDMA to SMB1 (192.168.2.111) and SMB2 (192.168.2.222).

Optional: You might need to disable the Firewall on this system.  Consult your fabric policy for details.

    
    Set-NetFirewallProfile -All -Enabled False
    
    Get-NetAdapterAdvancedProperty -Name "Test-40G-2"
    
    Name  DisplayNameDisplayValue   RegistryKeyword RegistryValue  
    ----  -----------------------   --------------- -------------  
    .
    .
    Test-40G-2VLAN ID102VlanID  {102} 
    
    Get-NetAdapter
    
    Name  InterfaceDescriptionifIndex Status   MacAddress LinkSpeed
    ----  --------------------------- ------   ---------- ---------
    Test-40G-2Mellanox ConnectX-3 Pro Ethernet A...#3   3 Up   E4-1D-2D-07-43-D140 Gbps
    
    
    Get-NetAdapterRdma
    
    Name  InterfaceDescription Enabled
    ----  -------------------- -------
    Test-40G-2Mellanox ConnectX-3 Pro Ethernet Adap... True   
    
    
    C:\TEST\Test-RDMA.PS1 -IfIndex 3 -IsRoCE $true -RemoteIpAddress 192.168.2.111 -PathToDiskspd C:\TEST\Diskspd-v2.0.17\amd64fre\
    VERBOSE: Diskspd.exe found at C:\TEST\Diskspd-v2.0.17\amd64fre\\diskspd.exe
    VERBOSE: The adapter Test-40G-2 is a physical adapter
    VERBOSE: Underlying adapter is RoCE. Checking if QoS/DCB/PFC is configured on each physical adapter(s)
    VERBOSE: QoS/DCB/PFC configuration is correct.
    VERBOSE: RDMA configuration is correct.
    VERBOSE: Checking if remote IP address, 192.168.2.111, is reachable.
    VERBOSE: Remote IP 192.168.2.111 is reachable.
    VERBOSE: Disabling RDMA on adapters that are not part of this test. RDMA will be enabled on them later.
    VERBOSE: Testing RDMA traffic now for. Traffic will be sent in a parallel job. Job details:
    VERBOSE: 34251744 RDMA bytes sent per second
    VERBOSE: 967346308 RDMA bytes written per second
    VERBOSE: 35698177 RDMA bytes sent per second
    VERBOSE: 976601842 RDMA bytes written per second
    VERBOSE: Enabling RDMA on adapters that are not part of this test. RDMA was disabled on them prior to sending RDMA traffic.
    VERBOSE: RDMA traffic test SUCCESSFUL: RDMA traffic was sent to 192.168.2.111
    
    
    C:\TEST\Test-RDMA.PS1 -IfIndex 3 -IsRoCE $true -RemoteIpAddress 192.168.2.222 -PathToDiskspd C:\TEST\Diskspd-v2.0.17\amd64fre\
    VERBOSE: Diskspd.exe found at C:\TEST\Diskspd-v2.0.17\amd64fre\\diskspd.exe
    VERBOSE: The adapter Test-40G-2 is a physical adapter
    VERBOSE: Underlying adapter is RoCE. Checking if QoS/DCB/PFC is configured on each physical adapter(s)
    VERBOSE: QoS/DCB/PFC configuration is correct.
    VERBOSE: RDMA configuration is correct.
    VERBOSE: Checking if remote IP address, 192.168.2.222, is reachable.
    VERBOSE: Remote IP 192.168.2.222 is reachable.
    VERBOSE: Disabling RDMA on adapters that are not part of this test. RDMA will be enabled on them later.
    VERBOSE: Testing RDMA traffic now for. Traffic will be sent in a parallel job. Job details:
    VERBOSE: 0 RDMA bytes written per second
    VERBOSE: 0 RDMA bytes sent per second
    VERBOSE: 485137693 RDMA bytes written per second
    VERBOSE: 35200268 RDMA bytes sent per second
    VERBOSE: 939044611 RDMA bytes written per second
    VERBOSE: 34880901 RDMA bytes sent per second
    VERBOSE: Enabling RDMA on adapters that are not part of this test. RDMA was disabled on them prior to sending RDMA traffic.
    VERBOSE: RDMA traffic test SUCCESSFUL: RDMA traffic was sent to 192.168.2.222
    
### Test for RDMA traffic from the local to the remote computer

In this section you can verify that RDMA traffic is sent from the local computer to the remote computer.

You can use the following example commands to test and view the traffic flow.

    
    Get-NetAdapter | ft –AutoSize
    
    Name  InterfaceDescriptionifIndex Status   MacAddress LinkSpeed
    ----  --------------------------- ------   ---------- ---------
    vEthernet (SMB2)  Hyper-V Virtual Ethernet Adapter #4  45 Up   00-15-5D-30-AA-0380 Gbps
    vEthernet (SMB1)  Hyper-V Virtual Ethernet Adapter #3  41 Up   00-15-5D-30-AA-0280 Gbps
    
    
    C:\TEST\Test-RDMA.PS1 -IfIndex 41 -IsRoCE $true -RemoteIpAddress 192.168.2.5 -PathToDiskspd C:\TEST\Diskspd-v2.0.17\amd64fre\
    VERBOSE: Diskspd.exe found at C:\TEST\Diskspd-v2.0.17\amd64fre\\diskspd.exe
    VERBOSE: The adapter vEthernet (SMB1) is a virtual adapter
    VERBOSE: Retrieving vSwitch bound to the virtual adapter
    VERBOSE: Found vSwitch: VMSTEST
    VERBOSE: Found the following physical adapter(s) bound to vSwitch: TEST-40G-1, TEST-40G-2
    VERBOSE: Underlying adapter is RoCE. Checking if QoS/DCB/PFC is configured on each physical adapter(s)
    VERBOSE: QoS/DCB/PFC configuration is correct.
    VERBOSE: RDMA configuration is correct.
    VERBOSE: Checking if remote IP address, 192.168.2.5, is reachable.
    VERBOSE: Remote IP 192.168.2.5 is reachable.
    VERBOSE: Disabling RDMA on adapters that are not part of this test. RDMA will be enabled on them later.
    VERBOSE: Testing RDMA traffic now for. Traffic will be sent in a parallel job. Job details:
    VERBOSE: 0 RDMA bytes written per second
    VERBOSE: 0 RDMA bytes sent per second
    VERBOSE: 0 RDMA bytes written per second
    VERBOSE: 15250197 RDMA bytes sent per second
    VERBOSE: 896320913 RDMA bytes written per second
    VERBOSE: 33947559 RDMA bytes sent per second
    VERBOSE: 912160540 RDMA bytes written per second
    VERBOSE: 34091930 RDMA bytes sent per second
    VERBOSE: Enabling RDMA on adapters that are not part of this test. RDMA was disabled on them prior to sending RDMA traffic.
    VERBOSE: RDMA traffic test SUCCESSFUL: RDMA traffic was sent to 192.168.2.5
    
    
    C:\TEST\Test-RDMA.PS1 -IfIndex 45 -IsRoCE $true -RemoteIpAddress 192.168.2.5 -PathToDiskspd C:\TEST\Diskspd-v2.0.17\amd64fre\
    VERBOSE: Diskspd.exe found at C:\TEST\Diskspd-v2.0.17\amd64fre\\diskspd.exe
    VERBOSE: The adapter vEthernet (SMB2) is a virtual adapter
    VERBOSE: Retrieving vSwitch bound to the virtual adapter
    VERBOSE: Found vSwitch: VMSTEST
    VERBOSE: Found the following physical adapter(s) bound to vSwitch: TEST-40G-1, TEST-40G-2
    VERBOSE: Underlying adapter is RoCE. Checking if QoS/DCB/PFC is configured on each physical adapter(s)
    VERBOSE: QoS/DCB/PFC configuration is correct.
    VERBOSE: RDMA configuration is correct.
    VERBOSE: Checking if remote IP address, 192.168.2.5, is reachable.
    VERBOSE: Remote IP 192.168.2.5 is reachable.
    VERBOSE: Disabling RDMA on adapters that are not part of this test. RDMA will be enabled on them later.
    VERBOSE: Testing RDMA traffic now for. Traffic will be sent in a parallel job. Job details:
    VERBOSE: 0 RDMA bytes written per second
    VERBOSE: 0 RDMA bytes sent per second
    VERBOSE: 385169487 RDMA bytes written per second
    VERBOSE: 33902277 RDMA bytes sent per second
    VERBOSE: 907354685 RDMA bytes written per second
    VERBOSE: 33923662 RDMA bytes sent per second
    VERBOSE: Enabling RDMA on adapters that are not part of this test. RDMA was disabled on them prior to sending RDMA traffic.
    VERBOSE: RDMA traffic test SUCCESSFUL: RDMA traffic was sent to 192.168.2.5
    
The final line in this output, "RDMA traffic test SUCCESSFUL: RDMA traffic was sent to 192.168.2.5," demonstrates that you have successfully configured Converged NIC on your adapter.

## All topics in this guide

This guide contains the following topics.

- [Converged NIC Configuration with a Single Network Adapter](cnic-single.md)
- [Converged NIC Teamed NIC Configuration](cnic-datacenter.md)
- [Physical Switch Configuration for Converged NIC](cnic-app-switch-config.md)
- [Troubleshooting Converged NIC Configurations](cnic-app-troubleshoot.md)

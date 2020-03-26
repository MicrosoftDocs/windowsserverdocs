---
title: Create Security Policies with Extended Port Access Control Lists
description: This topic provides information about extended port Access Control Lists (ACLs) in Windows Server 2016. 
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-hv-switch
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a92e61c3-f7d4-4e42-8575-79d75d05a218
ms.author: lizross
author: eross-msft
---
# Create Security Policies with Extended Port Access Control Lists

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides information about extended port Access Control Lists (ACLs) in Windows Server 2016. You can configure extended ACLs on the Hyper-V Virtual Switch to allow and block network traffic to and from the virtual machines (VMs) that are connected to the switch via virtual network adapters.  
  
This topic contains the following sections.  
  
-   [Detailed ACL rules](#bkmk_detailed)  
  
-   [Stateful ACL rules](#bkmk_stateful)  
  
## <a name="bkmk_detailed"></a>Detailed ACL rules  
Hyper-V Virtual Switch extended ACLs allow you to create detailed rules that you can apply to individual VM network adapters that are connected to the Hyper-V Virtual Switch. The ability to create detailed rules allows Enterprises and Cloud Service Providers (CSPs) to address network-based security threats in a multitenant shared server environment.  
  
With extended ACLs, rather than having to create broad rules that block or allow all traffic from all protocols to or from a VM, you can now block or allow the network traffic of individual protocols that are running on VMs. You can create extended ACL rules in Windows Server 2016 that include the following 5-tuple set of parameters: source IP address, destination IP address, protocol, source port, and destination port. In addition, each rule can specify network traffic direction (in or out), and the action the rule supports (block or allow traffic).  
  
For example, you can configure port ACLs for a VM to allow all incoming and outgoing HTTP and HTTPS traffic on port 80, while blocking the network traffic of all other protocols on all ports.  
  
This ability to designate the protocol traffic that can or cannot be received by tenant VMs provides flexibility when you configure security policies.  
  
### Configuring ACL rules with Windows PowerShell  
To configure an extended ACL, you must use the Windows PowerShell command **Add-VMNetworkAdapterExtendedAcl**. This command has four different syntaxes, with a distinct use for each syntax:  
  
1.  Add an extended ACL to all of the network adapters of a named VM - which is specified by the first parameter, -VMName. Syntax:  
  
    > [!NOTE]  
    > If you want to add an extended ACL to one network adapter rather than all, you can specify the network adapter with the parameter -VMNetworkAdapterName.  
  
    ```  
    Add-VMNetworkAdapterExtendedAcl [-VMName] <string[]> [-Action] <VMNetworkAdapterExtendedAclAction> {Allow | Deny}  
        [-Direction] <VMNetworkAdapterExtendedAclDirection> {Inbound | Outbound} [[-LocalIPAddress] <string>]  
        [[-RemoteIPAddress] <string>] [[-LocalPort] <string>] [[-RemotePort] <string>] [[-Protocol] <string>] [-Weight]  
        <int> [-Stateful <bool>] [-IdleSessionTimeout <int>] [-IsolationID <int>] [-Passthru] [-VMNetworkAdapterName  
        <string>] [-ComputerName <string[]>] [-WhatIf] [-Confirm]  [<CommonParameters>]  
    ```  
  
2.  Add an extended ACL to a specific virtual network adapter on a specific VM. Syntax:  
  
    ```  
    Add-VMNetworkAdapterExtendedAcl [-VMNetworkAdapter] <VMNetworkAdapterBase[]> [-Action]  
        <VMNetworkAdapterExtendedAclAction> {Allow | Deny} [-Direction] <VMNetworkAdapterExtendedAclDirection> {Inbound |  
        Outbound} [[-LocalIPAddress] <string>] [[-RemoteIPAddress] <string>] [[-LocalPort] <string>] [[-RemotePort]  
        <string>] [[-Protocol] <string>] [-Weight] <int> [-Stateful <bool>] [-IdleSessionTimeout <int>] [-IsolationID  
        <int>] [-Passthru] [-WhatIf] [-Confirm]  [<CommonParameters>]  
    ```  
  
3.  Add an extended ACL to all virtual network adapters that are reserved for use by the Hyper-V host management operating system.  
  
    > [!NOTE]  
    > If you want to add an extended ACL to one network adapter rather than all, you can specify the network adapter with the parameter -VMNetworkAdapterName.  
  
    ```  
    Add-VMNetworkAdapterExtendedAcl [-Action] <VMNetworkAdapterExtendedAclAction> {Allow | Deny} [-Direction]  
        <VMNetworkAdapterExtendedAclDirection> {Inbound | Outbound} [[-LocalIPAddress] <string>] [[-RemoteIPAddress]  
        <string>] [[-LocalPort] <string>] [[-RemotePort] <string>] [[-Protocol] <string>] [-Weight] <int> -ManagementOS  
        [-Stateful <bool>] [-IdleSessionTimeout <int>] [-IsolationID <int>] [-Passthru] [-VMNetworkAdapterName <string>]  
        [-ComputerName <string[]>] [-WhatIf] [-Confirm]  [<CommonParameters>]  
    ```  
  
4.  Add an extended ACL to a VM object that you have created in Windows PowerShell, such as **$vm = get-vm "my_vm"**. In the next line of code you can run this command to create an extended ACL with the following syntax:  
  
    ```  
    Add-VMNetworkAdapterExtendedAcl [-VM] <VirtualMachine[]> [-Action] <VMNetworkAdapterExtendedAclAction> {Allow |  
        Deny} [-Direction] <VMNetworkAdapterExtendedAclDirection> {Inbound | Outbound} [[-LocalIPAddress] <string>]  
        [[-RemoteIPAddress] <string>] [[-LocalPort] <string>] [[-RemotePort] <string>] [[-Protocol] <string>] [-Weight]  
        <int> [-Stateful <bool>] [-IdleSessionTimeout <int>] [-IsolationID <int>] [-Passthru] [-VMNetworkAdapterName  
        <string>] [-WhatIf] [-Confirm]  [<CommonParameters>]  
    ```  
  
### Detailed ACL rule examples  
Following are several examples of how you can use the **Add-VMNetworkAdapterExtendedAcl** command to configure extended port ACLs and to create security policies for VMs.  
  
-   [Enforce application-level security](#bkmk_enforce)  
  
-   [Enforce both user-level and application-level security](#bkmk_both)  
  
-   [Provide security support to a non-TCP/UDP application](#bkmk_tcp)  
  
> [!NOTE]  
> The values for the rule parameter **Direction** in the tables below are based on traffic flow to or from the VM for which you are creating the rule. If the VM is receiving traffic, the traffic is inbound; if the VM is sending traffic, the traffic is outbound. For example, if you apply a rule to a VM that blocks inbound traffic, the direction of inbound traffic is from external resources to the VM. If you apply a rule that blocks outbound traffic, the direction of outbound traffic is from the local VM to external resources.  
  
### <a name="bkmk_enforce"></a>Enforce application-level security  
Because many application servers use standardized TCP/UDP ports to communicate with client computers, it is easy to create rules that block or allow access to an application server by filtering traffic going to and coming from the port designated to the application.  
  
For example, you might want to allow a user to login to an application server in your datacenter by using Remote Desktop Connection (RDP). Because RDP uses TCP port 3389, you can quickly set up the following rule:  
  
|Source IP|Destination IP|Protocol|Source Port|Destination Port|Direction|Action|  
|-------------|------------------|------------|---------------|--------------------|-------------|----------|  
|*|*|TCP|*|3389|In|Allow|  
  
Following are two examples of how you can create rules with Windows PowerShell commands. The first example rule blocks all traffic to the VM named "ApplicationServer." The second example rule, which is applied to the network adapter of the VM named "ApplicationServer," allows only inbound RDP traffic to the VM.  
  
> [!NOTE]  
> When you create rules, you can use the **-Weight** parameter to determine the order in which the Hyper-V Virtual Switch processes the rules. Values for **-Weight** are expressed as integers; rules with a higher integer are processed before rules with lower integers. For example, if you have applied two rules to a VM network adapter, one with a weight of 1 and one with a weight of 10, the rule with the weight of 10 is applied first.  
  
```  
Add-VMNetworkAdapterExtendedAcl -VMName "ApplicationServer" -Action "Deny" -Direction "Inbound" -Weight 1  
Add-VMNetworkAdapterExtendedAcl -VMName "ApplicationServer" -Action "Allow" -Direction "Inbound" -LocalPort 3389 -Protocol "TCP" -Weight 10  
```  
  
### <a name="bkmk_both"></a>Enforce both user-level and application-level security  
Because a rule can match a 5-tuple IP packet (Source IP, Destination IP, Protocol, Source Port, and Destination Port), the rule can enforce a more detailed security policy than a Port ACL.  
  
For example, if you want to provide DHCP service to a limited number of client computers using a specific set of DHCP servers, you can configure the following rules on the Windows Server 2016 computer that is running Hyper-V, where the user VMs are hosted:  
  
|Source IP|Destination IP|Protocol|Source Port|Destination Port|Direction|Action|  
|-------------|------------------|------------|---------------|--------------------|-------------|----------|  
|*|255.255.255.255|UDP|*|67|Out|Allow|  
|*|10.175.124.0/25|UDP|*|67|Out|Allow|  
|10.175.124.0/25|*|UDP|*|68|In|Allow|  
  
Following are examples of how you can create these rules with Windows PowerShell commands.  
  
```  
Add-VMNetworkAdapterExtendedAcl -VMName "ServerName" -Action "Deny" -Direction "Outbound" -Weight 1  
Add-VMNetworkAdapterExtendedAcl -VMName "ServerName" -Action "Allow" -Direction "Outbound" -RemoteIPAddress 255.255.255.255 -RemotePort 67 -Protocol "UDP"-Weight 10  
Add-VMNetworkAdapterExtendedAcl -VMName "ServerName" -Action "Allow" -Direction "Outbound" -RemoteIPAddress 10.175.124.0/25 -RemotePort 67 -Protocol "UDP"-Weight 20  
Add-VMNetworkAdapterExtendedAcl -VMName "ServerName" -Action "Allow" -Direction "Inbound" -RemoteIPAddress 10.175.124.0/25 -RemotePort 68 -Protocol "UDP"-Weight 20  
```  
  
### <a name="bkmk_tcp"></a>Provide security support to a non-TCP/UDP application  
While most network traffic in a datacenter is TCP and UDP, there is still some traffic that utilizes other protocols. For example, if you want to permit a group of servers to run an IP-multicast application that relies on Internet Group Management Protocol (IGMP), you can create the following rule.  
  
> [!NOTE]  
> IGMP has a designated IP protocol number of 0x02.  
  
|Source IP|Destination IP|Protocol|Source Port|Destination Port|Direction|Action|  
|-------------|------------------|------------|---------------|--------------------|-------------|----------|  
|*|*|0x02|*|*|In|Allow|  
|*|*|0x02|*|*|Out|Allow|  
  
Following is an example of how you can create these rules with Windows PowerShell commands.  
  
```  
Add-VMNetworkAdapterExtendedAcl -VMName "ServerName" -Action "Allow" -Direction "Inbound" -Protocol 2 -Weight 20  
Add-VMNetworkAdapterExtendedAcl -VMName "ServerName" -Action "Allow" -Direction "Outbound" -Protocol 2 -Weight 20  
```  
  
## <a name="bkmk_stateful"></a>Stateful ACL rules  
Another new capability of extended ACLs allows you to configure stateful rules. A stateful rule filters packets based on five attributes in a packet - Source IP, Destination IP, Protocol, Source Port, and Destination Port.  
  
Stateful rules have the following capabilities:  
  
-   They always allow traffic and are not used to block traffic.  
  
-   If you specify that the value for the parameter **Direction** is inbound and traffic matches the rule, Hyper-V Virtual Switch dynamically creates a matching rule that allows the VM to send outbound traffic in response to the external resource.  
  
-   If you specify that the value for the parameter **Direction** is outbound and traffic matches the rule, Hyper-V Virtual Switch dynamically creates a matching rule that allows the external resource inbound traffic to be received by the VM.  
  
-   They include a timeout attribute that is measured in seconds. When a network packet arrives at the switch and the packet matches a stateful rule, Hyper-V Virtual Switch creates a state so that all subsequent packets in both directions of the same flow are allowed. The state expires if there is no traffic in either direction in the period of time that is specified by the timeout value.  
  
Following is an example of how you can use stateful rules.  
  
### Allow inbound remote server traffic only after it is contacted by the local server  
In some cases, a stateful rule must be employed because only a stateful rule can keep track of a known, established connection, and distinguish the connection from other connections.  
  
For example, if you want to allow a VM application server to initiate connections on port 80 to web services on the Internet, and you want the remote Web servers to be able to respond to the VM traffic, you can configure a stateful rule that allows initial outbound traffic from the VM to the Web services; because the rule is stateful, return traffic to the VM from the Web servers is also allowed. For security reasons, you can block all other inbound network traffic to the VM.  
  
To achieve this rule configuration, you can use the settings in the table below.  
  
> [!NOTE]  
> Due to formatting restrictions and the amount of information in the table below, the information is displayed differently than in previous tables in this document.  
  
|Parameter|Rule 1|Rule 2|Rule 3|  
|-------------|----------|----------|----------|  
|Source IP|*|*|*|  
|Destination IP|*|*|*|  
|Protocol|*|*|TCP|  
|Source Port|*|*|*|  
|Destination Port|*|*|80|  
|Direction|In|Out|Out|  
|Action|Deny|Deny|Allow|  
|Stateful|No|No|Yes|  
|Timeout (in seconds)|N/A|N/A|3600|  
  
The stateful rule allows the VM application server to connect to a remote Web server. When the first packet is sent out, Hyper-V Virtual switch dynamically creates two flow states to allow all packets sent to and all returning packets from the remote Web server. When the flow of packets between the servers stops, the flow states time out in the designated timeout value of 3600 seconds, or one hour.  
  
Following is an example of how you can create these rules with Windows PowerShell commands.  
  
```  
Add-VMNetworkAdapterExtendedAcl -VMName "ApplicationServer" -Action "Deny" -Direction "Inbound" -Weight 1   
Add-VMNetworkAdapterExtendedAcl -VMName "ApplicationServer" -Action "Deny" -Direction "Outbound" -Weight 1  
Add-VMNetworkAdapterExtendedAcl -VMName "ApplicationServer" -Action "Allow" -Direction "Outbound" 80 "TCP" -Weight 100 -Stateful -Timeout 3600  
```  
  



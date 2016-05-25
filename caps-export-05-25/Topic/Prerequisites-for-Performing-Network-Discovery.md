---
title: Prerequisites for Performing Network Discovery
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 19cc1421-720a-4624-a1d9-daeebd617514
author: vhorne
---
# Prerequisites for Performing Network Discovery
This topic provides prerequisite information for performing Network Discovery with Network Controller, including hardware and software configuration requirements, credential configuration, and Network Discovery configuration.  
  
This topic contains the following sections.  
  
-   [Requirements for Performing Network Discovery](#bkmk_require)  
  
-   [Configuring Network Discovery Credentials](#bkmk_credentials)  
  
-   [Performing Network Discovery Configuration](#bkmk_config)  
  
## <a name="bkmk_require"></a>Requirements for Performing Network Discovery  
Following are the required steps before you can perform Network Discovery with Network Controller in [!INCLUDE[winthreshold_server_1](../Token/winthreshold_server_1_md.md)].  
  
-   You must install Network Controller on one node or multiple nodes and configure it according to the instructions in the topic [Deploy Network Controller using Windows PowerShell](../Topic/Deploy-Network-Controller-using-Windows-PowerShell.md). A Network Controller cluster node can be a computer or a virtual machine \(VM\).  
  
-   All server computers and VMs that you want to discover on your network must be joined to an Active Directory domain.  
  
-   All network switches that you want to discover must be provisioned with Simple Network Management Protocol \(SNMP\) read credentials.  
  
Your switches must support standard SNMP Management Information Bases \(MIBs\) that are required for the discovery.  Following are the required SNMP MIBs.  
  
|MIB|Table name|Purpose|  
|-------|--------------|-----------|  
|RFC1213\-MIB|System \(“1.3.6.1.2.1.1”\)|Retrieve switch system information:  model, vendor, system OID, etc.|  
||ipRouteTable \(“1.3.6.1.2.1.4.21”\)|Retrieve the switch route table|  
|IF\-MIB|ifTable \(“1.3.6.1.2.1.2.2”\)|Retrieve the interface table|  
|IP\-MIB|ipNetToMediaTable \(“1.3.6.1.2.1.4.22”\)|Retrieve the Address Resolution Protocol \(ARP\) table|  
||ipNetToPhysicalTable\(“1.3.6.1.2.1.4.35”\)|Retrieve the ARP table.|  
||ipAddrTable \(“1.3.6.1.2.1.4.20”\)|Retrieve the IP address table.|  
|IP\-FORWARD\-MIB|ipCidrRouteTable \(“1.3.6.1.2.1.4.24.4”\)|Retrieve the CIDR table|  
|Q\-BRIDGE\-MIB|dot1qTpFdbTable \(“1.3.6.1.2.1.17.7.1.2.2”\)|Retrieve the MAC table|  
||dot1qVlanStaticTable \(“1.3.6.1.2.1.17.7.1.4.3”\)|Retrieve the static VLAN table|  
||dot1qVlanCurrentTable\(“1.3.6.1.2.1.17.7.1.4.2”\)|Retrieve the current VLAN table|  
|BRIDGE\-MIB|dot1dTpFdbTable \(“1.3.6.1.2.1.17.4.3”\)|Retrieve the MAC table.|  
|LLDP\-MIB|lldpLocPortTable \(“1.0.8802.1.1.2.1.3.7”\)|Retrieve the LLDP Local Port table|  
||lldpRemTable \(“1.0.8802.1.1.2.1.4.1”\)|Retrieve the LLDP Remote Port table|  
||lldpRemManAddrTable \(“1.0.8802.1.1.2.1.4.2”\)|Retrieve the remote management address table|  
||lldpLocalSystemData \(“1.0.8802.1.1.2.1.3”\)||  
|Entity\-MIB|entPhysicalTable\(“1.3.6.1.2.1.47.1.1.1.1”\)|Retrieve the physical port information so that the ports can be associated with the VLANs retrieved in the current VLAN table|  
||entAliasMappingTable \(“1.3.6.1.2.1.47.1.3.2”\)|Retrieve the logical index \(ifIndex\) from the physical index of the port|  
|IEEE8023\-LAG\-MIB|dot3adAggTable \(“1.2.840.10006.300.43.1.1”\)\-|Retrieve the port channels \/ aggregators configured on the switch|  
||dot3adAggPortListPorts \(“1.2.840.10006.300.43.1.1.2.1.1”\)|Retrieve the ports associated with each port channel \/ aggregator|  
  
## <a name="bkmk_credentials"></a>Configuring Network Discovery Credentials  
You must configure two sets of credentials before performing Network Discovery. SNMP credentials are used by Network Controller to access information about network switches.  Active Directory user account credentials, which consist of a user name and password, allow Network Controller to access server computers on your network. The following procedures provide instructions for both types of credentials.  
  
Membership in **Administrators**, or equivalent, is the minimum required to perform the procedures in the following sections. You can run these procedures on the local computer or from a remote computer.  
  
#### To add SNMP credentials to Network Controller  
  
1.  Perform this procedure for each network switch that you want to discover. Ensure that you replace variable values in the Windows PowerShell example commands below with values that are correct for your deployment.  
  
2.  Open Windows PowerShell and run the following [New-NetworkControllerCredential](https://technet.microsoft.com/library/mt576396.aspx) command.  
  
    ```  
    $cred=New-Object Microsoft.Windows.Networkcontroller.credentialproperties  
    $cred.type="snmpCommunityString"  
    $cred.value="abcd"    
    //Replace with the actual community string configured on the switches  
  
    New-NetworkControllerCredential -ConnectionUri https://networkcontroller -Properties $cred –ResourceId cred1  
    //ConnectionUri is the uri of the Network Controller  
    //ResourceId is the name of the credential resource  
    ```  
  
#### To add user account credentials to Network Controller  
  
1.  Perform this procedure to add administrator credentials for each server computer that you want to discover. Ensure that you replace variable values in the Windows PowerShell example commands below with values that are correct for your deployment.  
  
2.  Open Windows PowerShell and run the following [New-NetworkControllerCredential](https://technet.microsoft.com/library/mt576396.aspx) command.  
  
    ```  
    $cred=New-Object Microsoft.Windows.Networkcontroller.credentialproperties  
    $cred.type="usernamepassword"  
    $cred.username=”contoso\admin”  
    //Replace with the actual admin name on the host  
    $cred.value="abcd"    
    //Replace with the actual password configured on the host  
  
    New-NetworkControllerCredential -ConnectionUri https://networkcontroller -Properties $cred –ResourceId cred2  
    //ConnectionUri is the uri of the Network Controller  
    //ResourceId is the name of the credential resource  
    ```  
  
## <a name="bkmk_config"></a>Performing Network Discovery Configuration  
You must configure Network Discovery before performing any discovery operations.  
  
#### To configure Network Discovery  
  
1.  Open Windows PowerShell and run the following commands. Ensure that you replace variable values in the Windows PowerShell example commands below with values that are correct for your deployment.  
  
    ```  
    $config=New-Object Microsoft.Windows.Networkcontroller.ConfigurationProperties  
    $config.DiscoverHosts=”true”  
    //Whether to discover only switches, or to discover hosts as well  
    $config.DiscoveryIntervalInMinutes=”1440”  
    //Frequency at which discovery should be run. You can demand start the discovery as well. Default value is 1440 minutes.  
    $config.DiscoveryScopes=”10.0.0.1/24”  
    //IP subnets to which discovery should be scoped. Network devices outside these subnets will not appear in discovered topology.  
    $credential1=Get-NetworkControllerCredential –ConnectionUri https://networkcontroller –ResourceId cred1  
    $credential2=Get-NetworkControllerCredential –ConnectionUri https://networkcontroller –ResourceId cred2  
    $config.Credentials=@($credential1,$credential2)  
    //Reference to credentials created above. Each of these credentials will be tried on all devices till one of them succeeds  
    $config.DiscoverySeedDevices=”10.0.0.2”  
    //IP address of devices that will be used as starting point by network discovery algorithm to discover the network. This should be a switch, specifically a TOR or aggregate switch  
    $config.HopLimit=”3”  
    //Specifies the Number of hops from the seed devices that the network discovery should be restricted to. Network devices beyond the hops specified here will not be discovered. Default value is 3.  
    $config.ActiveDirectoryDomains=”abc.contoso.com”  
    //List ot Active Directory domains that should be looked up when searching for host records  
  
    Set-NetworkControllerTopologyConfiguration –ConnectionUri https://networkcontroller –Properties $config  
    ```  
  
Configuration for Network Discovery is now complete.  
  
To perform a network discovery, see [Perform Network Discovery](../Topic/Perform-Network-Discovery.md).  
  
## See Also  
[Network Discovery and Topology](../Topic/Network-Discovery-and-Topology.md)  
  

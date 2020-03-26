---
title: Troubleshoot the Windows Server Software Defined Networking Stack
description: This Windows Server guide examines the common Software Defined Networking (SDN) errors and failure scenarios and outlines a troubleshooting workflow that leverages the available diagnostic tools.
manager: ravirao
ms.prod: windows-server
ms.technology: networking-sdn
ms.topic: article
ms.assetid: 9be83ed2-9e62-49e8-88e7-f52d3449aac5
ms.author: lizross
author: JMesser81
ms.date: 08/14/2018

---
# Troubleshoot the Windows Server Software Defined Networking Stack

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This guide examines the common Software Defined Networking (SDN) errors and failure scenarios and outlines a troubleshooting workflow that leverages the available diagnostic tools.  

For more information about Microsoft's Software Defined Networking, see [Software Defined Networking](../../sdn/Software-Defined-Networking--SDN-.md).  

## Error types  
The following list represents the class of problems most often seen with Hyper-V Network Virtualization (HNVv1) in Windows Server 2012 R2 from in-market production deployments and coincides in many ways with the same types of problems seen in Windows Server 2016 HNVv2 with the new Software Defined Network (SDN) Stack.  

Most errors can be classified into a small set of classes:   
* **Invalid or unsupported configuration**  
   A user invokes the NorthBound API incorrectly or with invalid policy.   

* **Error in policy application**  
     Policy from Network Controller was not delivered to a Hyper-V Host, significantly delayed and / or not up to date on all Hyper-V hosts (for example, after a Live Migration).  
* **Configuration drift or software bug**  
  Data-path issues resulting in dropped packets.  

* **External error related to NIC hardware / drivers or the underlay network fabric**  
  Misbehaving task offloads (such as VMQ) or underlay network fabric misconfigured (such as MTU)   

  This troubleshooting guide examines each of these error categories and recommends best practices and diagnostic tools available to identify and fix the error.  

## Diagnostic tools  

Before discussing the troubleshooting workflows for each of these type of errors, let's examine the diagnostic tools available.   

To use the Network Controller (control-path) diagnostic tools, you must first install the RSAT-NetworkController feature and import the ``NetworkControllerDiagnostics`` module:  

```  
Add-WindowsFeature RSAT-NetworkController -IncludeManagementTools  
Import-Module NetworkControllerDiagnostics  
```  

To use the HNV Diagnostics (data-path) diagnostic tools, you must import the ``HNVDiagnostics`` module:

```  
# Assumes RSAT-NetworkController feature has already been installed
Import-Module hnvdiagnostics   
```  

### Network controller diagnostics  
These cmdlets are documented on TechNet in the [Network Controller Diagnostics Cmdlet Topic](https://docs.microsoft.com/powershell/module/networkcontrollerdiagnostics/). They help identify problems with network policy consistency in the control-path between Network Controller nodes and between the Network Controller and the NC Host Agents running on the Hyper-V hosts.

 The _Debug-ServiceFabricNodeStatus_ and _Get-NetworkControllerReplica_ cmdlets must be run from one of the Network Controller node virtual machines. All other NC Diagnostic cmdlets can be run from any host which has connectivity to the Network Controller and is in either in the Network Controller Management security group (Kerberos) or has access to the X.509 certificate for managing the Network Controller. 

### Hyper-V host diagnostics  
These cmdlets are documented on TechNet in the [Hyper-V Network Virtualization (HNV) Diagnostics Cmdlet Topic](https://docs.microsoft.com/powershell/module/hnvdiagnostics/). They help identify problems in the data-path between tenant virtual machines (East/West) and ingress traffic through an SLB VIP (North/South). 

The _Debug-VirtualMachineQueueOperation_, _Get-CustomerRoute_, _Get-PACAMapping_, _Get-ProviderAddress_, _Get-VMNetworkAdapterPortId_, _Get-VMSwitchExternalPortId_, and _Test-EncapOverheadSettings_ are all local tests which can be run from any Hyper-V host. The other cmdlets invoke data-path tests through the Network Controller and therefore need access to the Network Controller as descried above.

### GitHub
The [Microsoft/SDN GitHub Repo](https://github.com/microsoft/sdn) has a number of sample scripts and workflows which build on top of these in-box cmdlets. In particular, diagnostic scripts can be found in the [Diagnostics](https://github.com/Microsoft/sdn/diagnostics) folder. Please help us contribute to these scripts by submitting Pull Requests.

## Troubleshooting Workflows and Guides  

### [Hoster] Validate System Health
There is an embedded resource named _Configuration State_ in several of the Network Controller resources. Configuration state provides information about system health including the consistency between the network controller's configuration and the actual (running) state on the Hyper-V hosts. 

To check configuration state, run the following from any Hyper-V host with connectivity to the Network Controller.

>[!NOTE] 
>The value for the *NetworkController* parameter should either be the FQDN or IP address based on the subject name of the X.509 >certificate created for Network Controller.
>
>The *Credential* parameter only needs to be specified if the network controller is using Kerberos authentication (typical in VMM deployments). The credential must be for a user who is in the Network Controller Management Security Group.

```none
Debug-NetworkControllerConfigurationState -NetworkController <FQDN or NC IP> [-Credential <PS Credential>]

# Healthy State Example - no status reported
$cred = Get-Credential
Debug-NetworkControllerConfigurationState -NetworkController 10.127.132.211 -Credential $cred

Fetching ResourceType:     accessControlLists
Fetching ResourceType:     servers
Fetching ResourceType:     virtualNetworks
Fetching ResourceType:     networkInterfaces
Fetching ResourceType:     virtualGateways
Fetching ResourceType:     loadbalancerMuxes
Fetching ResourceType:     Gateways
```

A sample Configuration State message is shown below:

```none
Fetching ResourceType:     servers
---------------------------------------------------------------------------------------------------------
ResourcePath:     https://10.127.132.211/Networking/v1/servers/4c4c4544-0056-4b10-8058-b8c04f395931
Status:           Warning

Source:           SoftwareLoadBalancerManager
Code:             HostNotConnectedToController
Message:          Host is not Connected.
----------------------------------------------------------------------------------------------------------
```

>[!NOTE]
> There is a bug in the system where the Network Interface resources for the SLB Mux Transit VM NIC are in a Failure state with error "Virtual Switch - Host Not Connected To Controller". This error can be safely ignored if the IP configuration in the VM NIC resource is set to an IP Address from the Transit Logical Network's IP Pool. 
> There is a second bug in the system where the Network Interface resources for the Gateway HNV Provider VM NICs are in a Failure state with error "Virtual Switch - PortBlocked". This error can also be safely ignored if the IP configuration in the VM NIC resource is set to null (by design).


The table below shows the list of error codes, messages, and follow-up actions to take based on the configuration state observed.


| **Code**| **Message**| **Action**|  
|--------|-----------|----------|  
| Unknown| Unknown error| |  
| HostUnreachable                       | The host machine is not reachable | Check the Management network connectivity between Network Controller and Host |  
| PAIpAddressExhausted                  | The PA Ip addresses exhausted | Increase the HNV Provider logical subnet's IP Pool Size |  
| PAMacAddressExhausted                 | The PA Mac addresses exhausted | Increase the Mac Pool Range |  
| PAAddressConfigurationFailure         | Failed to plumb PA addresses to the host | Check the Management network connectivity between Network Controller and Host. |  
| CertificateNotTrusted                 | Certificate is not trusted  |Fix the certificates used for communication with the host. |  
| CertificateNotAuthorized              | Certificate not authorized | Fix the certificates used for communication with the host. |  
| PolicyConfigurationFailureOnVfp       | Failure in configuring VFP policies | This is a runtime failure.  No definite work arounds. Collect logs. |  
| PolicyConfigurationFailure            | Failure in pushing policies to the hosts, due to communication failures or others error in the NetworkController.| No definite actions.  This is due to failure in goal state processing in the Network Controller modules. Collect logs. |  
| HostNotConnectedToController          | The Host is not yet connected to the Network Controller | Port Profile not applied on the host or the host is not reachable from the Network Controller. Validate that HostID registry key matches the Instance ID of the server resource |  
| MultipleVfpEnabledSwitches            | There are multiple VFp enabled Switches on the host  | Delete one of the switches, since Network Controller Host Agent only supports one vSwitch with the VFP extension enabled |  
| PolicyConfigurationFailure            | Failed to push VNet policies for a VmNic due to certificate errors or connectivity errors  | Check if proper certificates have been deployed (Certificate subject name must match FQDN of host). Also verify the host connectivity with the Network Controller |  
| PolicyConfigurationFailure            | Failed to push vSwitch policies for a VmNic due to certificate errors or connectivity errors  | Check if proper certificates have been deployed (Certificate subject name must match FQDN of host). Also verify the host connectivity with the Network Controller|
| PolicyConfigurationFailure            | Failed to push Firewall policies for a VmNic due to certificate errors or connectivity errors | Check if proper certificates have been deployed (Certificate subject name must match FQDN of host). Also verify the host connectivity with the Network Controller|
| DistributedRouterConfigurationFailure | Failed to configure the Distributed router settings on the host vNic                          | TCPIP stack error. May require cleaning up the PA and DR Host vNICs on the server on which this error was reported |
| DhcpAddressAllocationFailure          | DHCP address allocation failed for a VMNic                                                    | Check if the static IP address attribute is configured on the NIC resource |  
| CertificateNotTrusted<br>CertificateNotAuthorized | Failed to connect to Mux due to network or cert errors | Check the numeric code provided in the error message code: this corresponds to the winsock error code. Certificate errors are granular (for example, cert cannot be verified, cert not authorized, etc.) |  
| HostUnreachable                       | MUX is Unhealthy (Common case is BGPRouter disconnected) | BGP peer on the RRAS (BGP virtual machine) or Top-of-Rack (ToR) switch is unreachable or not peering successfully. Check BGP settings on both Software Load Balancer Multiplexer resource  and BGP peer (ToR or RRAS virtual machine) |  
| HostNotConnectedToController          | SLB host agent is not connected  | Check that SLB Host Agent service is running; Refer to SLB host agent logs (auto running) for reasons why, in case SLBM (NC) rejected the cert presented by the host agent running state will show nuanced information  |  
| PortBlocked                           | The VFP port is blocked, due to lack of VNET / ACL policies | Check if there are any other errors, which might cause the policies to be not configured. |  
| Overloaded                            | Loadbalancer MUX is overloaded  | Performance issue with MUX |  
| RoutePublicationFailure               | Loadbalancer MUX is not connected to a BGP router | Check if the MUX has connectivity with the BGP routers and that BGP peering is setup correctly |  
| VirtualServerUnreachable              | Loadbalancer MUX is not connected to SLB manager | Check connectivity between SLBM and MUX |  
| QosConfigurationFailure               | Failed to configure QOS policies | See if sufficient bandwidth is available for all VM's if QOS reservation is used |


#### Check network connectivity between the network controller and Hyper-V Host (NC Host Agent service)
Run the *netstat* command below to validate that there are three ESTABLISHED connections between the NC Host Agent and the Network Controller node(s) and one LISTENING socket on the Hyper-V Host
- LISTENING on port TCP:6640 on Hyper-V Host (NC Host Agent Service)
- Two established connections from Hyper-V host IP on port 6640 to NC node IP on ephemeral ports (> 32000)
- One established connection from Hyper-V host IP on ephemeral port to Network Controller REST IP on port 6640

>[!NOTE]
>There may only be two established connections on a Hyper-V host if there are no tenant virtual machines deployed on that particular host.

```none
netstat -anp tcp |findstr 6640

# Successful output
  TCP    0.0.0.0:6640           0.0.0.0:0              LISTENING
  TCP    10.127.132.153:6640    10.127.132.213:50095   ESTABLISHED
  TCP    10.127.132.153:6640    10.127.132.214:62514   ESTABLISHED
  TCP    10.127.132.153:50023   10.127.132.211:6640    ESTABLISHED
```
#### Check Host Agent services
The network controller communicates with two host agent services on the Hyper-V hosts: SLB Host Agent and NC Host Agent. It is possible that one or both of these services is not running. Check their state and restart if they're not running.

```none
Get-Service SlbHostAgent
Get-Service NcHostAgent

# (Re)start requires -Force flag
Start-Service NcHostAgent -Force
Start-Service SlbHostAgent -Force
```

#### Check health of network controller
If there are not three ESTABLISHED connections or if the Network Controller appears unresponsive, check to see that all nodes and service modules are up and running by using the following cmdlets. 

```none
# Prints a DIFF state (status is automatically updated if state is changed) of a particular service module replica 
Debug-ServiceFabricNodeStatus [-ServiceTypeName] <Service Module>
```
The network controller service modules are:
- ControllerService
- ApiService
- SlbManagerService
- ServiceInsertion
- FirewallService
- VSwitchService
- GatewayManager
- FnmService
- HelperService
- UpdateService

Check that ReplicaStatus is **Ready** and HealthState is **Ok**.

In a production deployment is with a multi-node Network Controller, you can also check which node each service is primary on and its individual replica status.

```none  
Get-NetworkControllerReplica

# Sample Output for the API service module 
Replicas for service: ApiService

ReplicaRole   : Primary
NodeName      : SA18N30NC3.sa18.nttest.microsoft.com
ReplicaStatus : Ready

```
Check that the Replica Status is Ready for each service.

#### Check for corresponding HostIDs and certificates between network controller and each Hyper-V Host 
On a Hyper-V Host, run the following commands to check that the HostID corresponds to the Instance Id of a server resource on the Network Controller

```none
Get-ItemProperty "hklm:\system\currentcontrolset\services\nchostagent\parameters" -Name HostId |fl HostId

HostId : **162cd2c8-08d4-4298-8cb4-10c2977e3cfe**

Get-NetworkControllerServer -ConnectionUri $uri |where { $_.InstanceId -eq "162cd2c8-08d4-4298-8cb4-10c2977e3cfe"}

Tags             :
ResourceRef      : /servers/4c4c4544-0056-4a10-8059-b8c04f395931
InstanceId       : **162cd2c8-08d4-4298-8cb4-10c2977e3cfe**
Etag             : W/"50f89b08-215c-495d-8505-0776baab9cb3"
ResourceMetadata : Microsoft.Windows.NetworkController.ResourceMetadata
ResourceId       : 4c4c4544-0056-4a10-8059-b8c04f395931
Properties       : Microsoft.Windows.NetworkController.ServerProperties
```

*Remediation*
If using SDNExpress scripts or manual deployment, update the HostId key in the registry to match the Instance Id of the server resource. Restart the Network Controller Host Agent on the Hyper-V host (physical server)
If using VMM, delete the Hyper-V Server from VMM and remove the HostId registry key. Then, re-add the server through VMM.


Check that the thumbprints of the X.509 certificates used by the Hyper-V host (the hostname will be the cert's Subject Name) for (SouthBound) communication between the Hyper-V Host (NC Host Agent service) and Network Controller nodes are the same. Also check that the Network Controller's REST certificate has subject name of *CN=<FQDN or IP>*.

```  
# On Hyper-V Host
dir cert:\\localmachine\my  

Thumbprint                                Subject
----------                                -------
2A3A674D07D8D7AE11EBDAC25B86441D68D774F9  CN=SA18n30-4.sa18.nttest.microsoft.com
...

dir cert:\\localmachine\root

Thumbprint                                Subject
----------                                -------
30674C020268AA4E40FD6817BA6966531FB9ADA4  CN=10.127.132.211 **# NC REST IP ADDRESS**

# On Network Controller Node VM
dir cert:\\localmachine\root  

Thumbprint                                Subject
----------                                -------
2A3A674D07D8D7AE11EBDAC25B86441D68D774F9  CN=SA18n30-4.sa18.nttest.microsoft.com
30674C020268AA4E40FD6817BA6966531FB9ADA4  CN=10.127.132.211 **# NC REST IP ADDRESS**
...
```  

You can also check the following parameters of each cert to make sure the subject name is what is expected (hostname or NC REST FQDN or IP), the certificate has not yet expired, and that all certificate authorities in the certificate chain are included in the trusted root authority.

- Subject Name  
- Expiration Date  
- Trusted by Root Authority  

*Remediation*
If multiple certificates have the same subject name on the Hyper-V host, the Network Controller Host Agent will randomly choose one to present to the Network Controller. This may not match the thumbprint of the server resource known to the Network Controller. In this case, delete one of the certificates with the same subject name on the Hyper-V host and then re-start the Network Controller Host Agent service. If a connection can still not be made, delete the other certificate with the same subject name on the Hyper-V Host and delete the corresponding server resource in VMM. Then, re-create the server resource in VMM which will generate a new X.509 certificate and install it on the Hyper-V host.


#### Check the SLB Configuration State
The SLB Configuration State can be determined as part of the output to the Debug-NetworkController cmdlet. This cmdlet will also output the current set of Network Controller resources in JSON files, all IP configurations from each Hyper-V host (server) and local network policy from Host Agent database tables. 

Additional traces will be collected by default. To not collect traces, add the -IncludeTraces:$false parameter.

```none
Debug-NetworkController -NetworkController <FQDN or IP> [-Credential <PS Credential>] [-IncludeTraces:$false]

# Don't collect traces
$cred = Get-Credential 
Debug-NetworkController -NetworkController 10.127.132.211 -Credential $cred -IncludeTraces:$false

Transcript started, output file is C:\\NCDiagnostics.log
Collecting Diagnostics data from NC Nodes
```

>[!NOTE]
>The default output location will be the <working_directory>\NCDiagnostics\ directory. The default output directory can be changed by using the `-OutputDirectory` parameter. 

The SLB Configuration State information can be found in the _diagnostics-slbstateResults.Json_ file in this directory.

This JSON file can be broken down into the following sections:
 * Fabric
   * SlbmVips - This section lists the IP address of the SLB Manager VIP address which is used by the Network Controller to coodinate configuration and health between the SLB Muxes and SLB Host Agents.
   * MuxState - This section will list one value for each SLB Mux deployed giving the state of the mux
   * Router Configuration - This section will list the Upstream Router's (BGP Peer) Autonomous System Number (ASN), Transit IP Address, and ID. It will also list the SLB Muxes ASN and Transit IP.
   * Connected Host Info - This section will list the Management IP address all of the Hyper-V hosts available to run load-balanced workloads.
   * Vip Ranges - This section will list the public and private VIP IP pool ranges. The SLBM VIP will be included as an allocated IP from one of these ranges. 
   * Mux Routes - This section will list one value for each SLB Mux deployed containing all of the Route Advertisements for that particular mux.
 * Tenant
   * VipConsolidatedState - This section will list the connectivity state for each Tenant VIP including advertised route prefix, Hyper-V Host and DIP endpoints.

> [!NOTE]
> SLB State can be ascertained directly by using the [DumpSlbRestState](https://github.com/Microsoft/SDN/blob/master/Diagnostics/DumpSlbRestState.ps1) script available on the [Microsoft SDN GitHub repository](https://github.com/microsoft/sdn). 

#### Gateway Validation

**From Network Controller:**
```
Get-NetworkControllerLogicalNetwork
Get-NetworkControllerPublicIPAddress
Get-NetworkControllerGatewayPool
Get-NetworkControllerGateway
Get-NetworkControllerVirtualGateway
Get-NetworkControllerNetworkInterface
```

**From Gateway VM:**
```
Ipconfig /allcompartments /all
Get-NetRoute -IncludeAllCompartments -AddressFamily
Get-NetBgpRouter
Get-NetBgpRouter | Get-BgpPeer
Get-NetBgpRouter | Get-BgpRouteInformation
```

**From Top of Rack (ToR) Switch:**

`sh ip bgp summary (for 3rd party BGP Routers)`

**Windows BGP Router**
```
Get-BgpRouter
Get-BgpPeer
Get-BgpRouteInformation
```

In addition to these, from the issues we have seen so far (especially on SDNExpress based deployments), the most common reason for Tenant Compartment not getting configured on GW VMs seem to be the fact that the GW Capacity in FabricConfig.psd1 is less compared to what folks try to assign to the Network Connections (S2S Tunnels) in TenantConfig.psd1. This can be checked easily by comparing outputs of the following commands:

```
PS > (Get-NetworkControllerGatewayPool -ConnectionUri $uri).properties.Capacity
PS > (Get-NetworkControllerVirtualgatewayNetworkConnection -ConnectionUri $uri -VirtualGatewayId "TenantName").properties.OutboundKiloBitsPerSecond
PS > (Get-NetworkControllerVirtualgatewayNetworkConnection -ConnectionUri $uri -VirtualGatewayId "TenantName").property
```

### [Hoster] Validate Data-Plane
After the Network Controller has been deployed, tenant virtual networks and subnets have been created, and VMs have been attached to the virtual subnets, additional fabric level tests can be performed by the hoster to check tenant connectivity.

#### Check HNV Provider Logical Network Connectivity
After the first guest VM running on a Hyper-V host has been connected to a tenant virtual network, the Network Controller will assign two HNV Provider IP Addresses (PA IP Addresses) to the Hyper-V Host. These IPs will come from the HNV Provider logical network's IP Pool and be managed by the Network Controller.  To find out what these two HNV IP Addresses are 's

```none
PS > Get-ProviderAddress

# Sample Output
ProviderAddress : 10.10.182.66
MAC Address     : 40-1D-D8-B7-1C-04
Subnet Mask     : 255.255.255.128
Default Gateway : 10.10.182.1
VLAN            : VLAN11

ProviderAddress : 10.10.182.67
MAC Address     : 40-1D-D8-B7-1C-05
Subnet Mask     : 255.255.255.128
Default Gateway : 10.10.182.1
VLAN            : VLAN11
```

These HNV Provider IP Addresses (PA IPs) are assigned to Ethernet Adapters created in a separate TCPIP network compartment and have an adapter name of _VLANX_ where X is the VLAN assigned to the HNV Provider (transport) logical network.

Connectivity between two Hyper-V hosts using the HNV Provider logical network can be done by a ping with an additional compartment (-c Y) parameter where Y is the TCPIP network compartment in which the PAhostVNICs are created. This compartment can be determined by executing:

```none
C:\> ipconfig /allcompartments /all

<snip> ...
==============================================================================
Network Information for *Compartment 3*
==============================================================================
   Host Name . . . . . . . . . . . . : SA18n30-2
<snip> ...

Ethernet adapter VLAN11:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Microsoft Hyper-V Network Adapter
   Physical Address. . . . . . . . . : 40-1D-D8-B7-1C-04
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::5937:a365:d135:2899%39(Preferred)
   IPv4 Address. . . . . . . . . . . : 10.10.182.66(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.128
   Default Gateway . . . . . . . . . : 10.10.182.1
   NetBIOS over Tcpip. . . . . . . . : Disabled

Ethernet adapter VLAN11:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Microsoft Hyper-V Network Adapter
   Physical Address. . . . . . . . . : 40-1D-D8-B7-1C-05
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::28b3:1ab1:d9d9:19ec%44(Preferred)
   IPv4 Address. . . . . . . . . . . : 10.10.182.67(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.128
   Default Gateway . . . . . . . . . : 10.10.182.1
   NetBIOS over Tcpip. . . . . . . . : Disabled

*Ethernet adapter vEthernet (PAhostVNic):*
<snip> ...
```

>[!NOTE]
> The PA Host vNIC Adapters are not used in the data-path and so do not have an IP assigned to the "vEthernet (PAhostVNic) adapter".

For instance, assume that Hyper-V hosts 1 and 2 have HNV Provider (PA) IP Addresses of:

|- Hyper-V Host -|- PA IP Address 1|- PA IP Address 2|
|---             |---            |---             |
|Host 1 | 10.10.182.64 | 10.10.182.65 |
|Host 2 | 10.10.182.66 | 10.10.182.67 |

we can ping between the two using the following command to check HNV Provider logical network connectivity.

```none
# Ping the first PA IP Address on Hyper-V Host 2 from the first PA IP address on Hyper-V Host 1 in compartment (-c) 3
C:\> ping -c 3 10.10.182.66 -S 10.10.182.64

# Ping the second PA IP Address on Hyper-V Host 2 from the first PA IP address on Hyper-V Host 1 in compartment (-c) 3
C:\> ping -c 3 10.10.182.67 -S 10.10.182.64

# Ping the first PA IP Address on Hyper-V Host 2 from the second PA IP address on Hyper-V Host 1 in compartment (-c) 3
C:\> ping -c 3 10.10.182.66 -S 10.10.182.65

# Ping the second PA IP Address on Hyper-V Host 2 from the second PA IP address on Hyper-V Host 1 in compartment (-c) 3
C:\> ping -c 3 10.10.182.67 -S 10.10.182.65
```

*Remediation*
If HNV Provider ping does not work, check your physical network connectivity including VLAN configuration. The physical NICs on each Hyper-V host should be in trunk mode with no specific VLAN assigned. The Management Host vNIC should be isolated to the Management Logical Network's VLAN.

```none
PS C:\> Get-NetAdapter "Ethernet 4" |fl

Name                       : Ethernet 4
InterfaceDescription       : <NIC> Ethernet Adapter
InterfaceIndex             : 2
MacAddress                 : F4-52-14-55-BC-21
MediaType                  : 802.3
PhysicalMediaType          : 802.3
InterfaceOperationalStatus : Up
AdminStatus                : Up
LinkSpeed(Gbps)            : 10
MediaConnectionState       : Connected
ConnectorPresent           : True
*VlanID                     : 0*
DriverInformation          : Driver Date 2016-08-28 Version 5.25.12665.0 NDIS 6.60

# VMM uses the older PowerShell cmdlet <Verb>-VMNetworkAdapterVlan to set VLAN isolation
PS C:\> Get-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName <Mgmt>

VMName VMNetworkAdapterName Mode     VlanList
------ -------------------- ----     --------
<snip> ...        
       Mgmt                 Access   7
<snip> ...

# SDNExpress deployments use the newer PowerShell cmdlet <Verb>-VMNetworkAdapterIsolation to set VLAN isolation
PS C:\> Get-VMNetworkAdapterIsolation -ManagementOS

<snip> ...

IsolationMode        : Vlan
AllowUntaggedTraffic : False
DefaultIsolationID   : 7
MultiTenantStack     : Off
ParentAdapter        : VMInternalNetworkAdapter, Name = 'Mgmt'
IsTemplate           : True
CimSession           : CimSession: .
ComputerName         : SA18N30-2
IsDeleted            : False

<snip> ...
```

#### Check MTU and Jumbo Frame support on HNV Provider Logical Network

Another common problem in the HNV Provider logical network is that the physical network ports and/or Ethernet card do not have a large enough MTU configured to handle the overhead from VXLAN (or NVGRE) encapsulation. 
>[!NOTE]
> Some Ethernet cards and drivers support the new *EncapOverhead keyword which will automatically be set by the Network Controller Host Agent to a value of 160. This value will then be added to the value of the *JumboPacket keyword whose summation is used as the advertised MTU.
> e.g. *EncapOverhead = 160 and *JumboPacket = 1514 => MTU = 1674B

```none
# Check whether or not your Ethernet card and driver support *EncapOverhead
PS C:\ > Test-EncapOverheadSettings

Verifying Physical Nic : <NIC> Ethernet Adapter #2
Physical Nic  <NIC> Ethernet Adapter #2 can support SDN traffic. Encapoverhead value set on the nic is  160
Verifying Physical Nic : <NIC> Ethernet Adapter
Physical Nic  <NIC> Ethernet Adapter can support SDN traffic. Encapoverhead value set on the nic is  160
```

To test whether or not the HNV Provider logical network supports the larger MTU size end-to-end, use the _Test-LogicalNetworkSupportsJumboPacket_ cmdlet:
```none
# Get credentials for both source host and destination host (or use the same credential if in the same domain)
$sourcehostcred = Get-Credential
$desthostcred = Get-Credential

# Use the Management IP Address or FQDN of the Source and Destination Hyper-V hosts
Test-LogicalNetworkSupportsJumboPacket -SourceHost sa18n30-2 -DestinationHost sa18n30-3 -SourceHostCreds $sourcehostcred -DestinationHostCreds $desthostcred

# Failure Results
SourceCompartment : 3
pinging Source PA: 10.10.182.66 to Destination PA: 10.10.182.64 with Payload: 1632
pinging Source PA: 10.10.182.66 to Destination PA: 10.10.182.64 with Payload: 1472
Checking if physical nics support jumbo packets on host
Physical Nic  <NIC> Ethernet Adapter #2 can support SDN traffic. Encapoverhead value set on the nic is  160
Cannot send jumbo packets to the destination. Physical switch ports may not be configured to support jumbo packets.
Checking if physical nics support jumbo packets on host
Physical Nic  <NIC> Ethernet Adapter #2 can support SDN traffic. Encapoverhead value set on the nic is  160
Cannot send jumbo packets to the destination. Physical switch ports may not be configured to support jumbo packets.

# TODO: Success Results aftering updating MTU on physical switch ports
```

*Remediation*
* Adjust the MTU size on the physical switch ports to be at least 1674B (including 14B Ethernet header and trailer)
* If your NIC card does not support the EncapOverhead keyword, adjust the JumboPacket keyword to be at least 1674B


#### Check Tenant VM NIC connectivity
Each VM NIC assigned to a guest VM has a CA-PA mapping between the private Customer Address (CA) and the HNV Provider Address (PA) space. These mappings are kept in the OVSDB server tables on each Hyper-V host and can be found by executing the following cmdlet.

```none
# Get all known PA-CA Mappings from this particular Hyper-V Host
PS > Get-PACAMapping

CA IP Address CA MAC Address    Virtual Subnet ID PA IP Address
------------- --------------    ----------------- -------------
10.254.254.2  00-1D-D8-B7-1C-43              4115 10.10.182.67
10.254.254.3  00-1D-D8-B7-1C-43              4115 10.10.182.67
192.168.1.5   00-1D-D8-B7-1C-07              4114 10.10.182.65
10.254.254.1  40-1D-D8-B7-1C-06              4115 10.10.182.66
192.168.1.1   40-1D-D8-B7-1C-06              4114 10.10.182.66
192.168.1.4   00-1D-D8-B7-1C-05              4114 10.10.182.66
```
>[!NOTE]
> If the CA-PA mappings you expect are not output for a given tenant VM, please check the VM NIC and IP Configuration resources on the Network Controller using the _Get-NetworkControllerNetworkInterface_ cmdlet. Also, check the established connections between the NC Host Agent and Network Controller nodes.

With this information, a tenant VM ping can now be initiated by the Hoster from the Network Controller using the _Test-VirtualNetworkConnection_ cmdlet.

## Specific Troubleshooting Scenarios

The following sections provide guidance for troubleshooting specific scenarios.

### No network connectivity between two tenant virtual machines

1.  [Tenant] Ensure Windows Firewall in tenant virtual machines is not blocking traffic.  
2.  [Tenant] Check that IP addresses have been assigned to the tenant virtual machine by running _ipconfig_. 
3.  [Hoster] Run **Test-VirtualNetworkConnection** from the Hyper-V host to validate connectivity between the two tenant virtual machines in question. 

>[!NOTE]
>The VSID refers to the Virtual Subnet ID. In the case of VXLAN, this is the VXLAN Network Identifier (VNI). You can find this value by running the **Get-PACAMapping** cmdlet.

#### Example

    $password = ConvertTo-SecureString -String "password" -AsPlainText -Force
    $cred = New-Object pscredential -ArgumentList (".\administrator", $password) 

Create CA-ping between "Green Web VM 1" with SenderCA IP of 192.168.1.4 on Host "sa18n30-2.sa18.nttest.microsoft.com" with Mgmt IP of 10.127.132.153 to ListenerCA IP of 192.168.1.5 both attached to Virtual Subnet (VSID) 4114.

    Test-VirtualNetworkConnection -OperationId 27 -HostName sa18n30-2.sa18.nttest.microsoft.com -MgmtIp 10.127.132.153 -Creds $cred -VMName "Green Web VM 1" -VMNetworkAdapterName "Green Web VM 1" -SenderCAIP 192.168.1.4 -SenderVSID 4114 -ListenerCAIP 192.168.1.5 -ListenerVSID 4114

    Test-VirtualNetworkConnection at command pipeline position 1

Starting CA-space ping test
Starting trace session
Ping to 192.168.1.5 succeeded from address 192.168.1.4
Rtt = 0 ms


CA Routing Information:

    Local IP: 192.168.1.4
    Local VSID: 4114
    Remote IP: 192.168.1.5
    Remote VSID: 4114
    Distributed Router Local IP: 192.168.1.1
    Distributed Router Local MAC: 40-1D-D8-B7-1C-06
    Local CA MAC: 00-1D-D8-B7-1C-05
    Remote CA MAC: 00-1D-D8-B7-1C-07
    Next Hop CA MAC Address: 00-1D-D8-B7-1C-07

PA Routing Information:

    Local PA IP: 10.10.182.66
    Remote PA IP: 10.10.182.65

 <snip> ...

4. [Tenant] Check that there is no distributed firewall policies specified on the virtual subnet or VM network interfaces which would block traffic.    

Query the Network Controller REST API found in demo environment at sa18n30nc in the sa18.nttest.microsoft.com domain.

    $uri = "https://sa18n30nc.sa18.nttest.microsoft.com"
    Get-NetworkControllerAccessControlList -ConnectionUri $uri 

## Look at IP Configuration and Virtual Subnets which are referencing this ACL

1. [Hoster] Run ``Get-ProviderAddress`` on both Hyper-V hosts hosting the two tenant virtual machines in question and then run ``Test-LogicalNetworkConnection`` or ``ping -c <compartment>`` from the Hyper-V host to validate connectivity on the HNV Provider logical network
2.  [Hoster] Ensure that the MTU settings are correct on the Hyper-V hosts and any Layer-2 switching devices in between the Hyper-V Hosts. Run ``Test-EncapOverheadValue`` on all Hyper-V hosts in question. Also check that all Layer-2 switches in between have MTU set to least 1674 bytes to account for maximum overhead of 160 bytes.  
3.  [Hoster] If PA IP Addresses are not present and/or CA Connectivity is broken, check to ensure network policy has been received. Run ``Get-PACAMapping`` to see if the encapsulation rules and CA-PA mappings required for creating overlay virtual networks are correctly established.  
4.  [Hoster] Check that the Network Controller Host Agent is connected to the Network Controller. Run ``netstat -anp tcp |findstr 6640`` to see if the   
5.  [Hoster] Check that the Host ID in HKLM/ matches the Instance ID of the server resources hosting the tenant virtual machines.  
6. [Hoster] Check that the Port Profile ID matches the Instance ID of the VM Network Interfaces of the tenant virtual machines.  

## Logging, Tracing and advanced diagnostics

The following sections provide information on advanced diagnostics, logging, and tracing.

### Network controller centralized logging 

The Network Controller can automatically collect debugger logs and store them in a centralized location. Log collection can be enabled when you deploy the Network Controller for the first time or any time later. The logs are collected from the Network Controller, and network elements managed by Network Controller: host machines, software load balancers (SLB) and gateway machines. 

These logs include debug logs for the Network Controller cluster, the Network Controller application, gateway logs, SLB, virtual networking and the distributed firewall. Whenever a new host/SLB/gateway is added to the Network Controller, logging is started on those machines. 
Similarly, when a host/SLB/gateway is removed from the Network Controller, logging is stopped on those machines.

#### Enable logging

Logging is automatically enabled when you install the Network Controller cluster using the  **Install-NetworkControllerCluster** cmdlet. By default, the logs are collected locally on the Network Controller nodes at *%systemdrive%\SDNDiagnostics*. It is **STRONGLY RECOMMENDED** that you change this location to be a remote file share (not local). 

The Network Controller cluster logs are stored at *%programData%\Windows Fabric\log\Traces*. You can specify a centralized location for log collection with the **DiagnosticLogLocation** parameter with the recommendation that this is also be a remote file share. 

If you want to restrict access to this location, you can provide the access credentials with the **LogLocationCredential** parameter. If you provide the credentials to access the log location, you should also provide the **CredentialEncryptionCertificate** parameter, which is used to encrypt the credentials stored locally on the Network Controller nodes.  

With the default settings, it is recommended that you have at least 75 GB of free space in the central location, and 25 GB on the local nodes (if not using a central location) for a 3-node Network Controller cluster.

#### Change logging settings

You can change logging settings at any time using the ``Set-NetworkControllerDiagnostic`` cmdlet. The following settings can be changed:

- **Centralized log location**.  You can change the location to store all the logs, with the ``DiagnosticLogLocation`` parameter.  
- **Credentials to access log location**.  You can change the credentials to access the log location, with the ``LogLocationCredential`` parameter.  
- **Move to local logging**.  If you have provided centralized location to store logs, you can move back to logging locally on the Network Controller nodes with the ``UseLocalLogLocation`` parameter (not recommended due to large disk space requirements).  
- **Logging scope**.  By default, all logs are collected. You can change the scope to collect only Network Controller cluster logs.  
- **Logging level**.  The default logging level is Informational. You can change it to Error, Warning, or Verbose.  
- **Log Aging time**.  The logs are stored in a circular fashion. You will have 3 days of logging data by default, whether you use local logging or centralized logging. You can change this time limit with **LogTimeLimitInDays** parameter.  
- **Log Aging size**.  By default, you will have a maximum 75 GB of logging data if using centralized logging and 25 GB if using local logging. You can change this limit with the **LogSizeLimitInMBs** parameter.

#### Collecting Logs and Traces

VMM deployments use centralized logging for the Network Controller by default. The file share location for these logs is specified when deploying the Network Controller service template.

If a file location has not been specified, local logging will be used on each Network Controller node with logs saved under C:\Windows\tracing\SDNDiagnostics. These logs are saved using the following hierarchy:

- CrashDumps
- NCApplicationCrashDumps
- NCApplicationLogs
- PerfCounters
- SDNDiagnostics
- Traces

The Network Controller uses (Azure) Service Fabric. Service Fabric logs may be required when troubleshooting certain issues. These logs can be found on each Network Controller node at C:\ProgramData\Microsoft\Service Fabric.

If a user has run the _Debug-NetworkController_ cmdlet, additional logs will be available on each Hyper-V host which has been specified with a server resource in the Network Controller. These logs (and traces if enabled) are kept under C:\NCDiagnostics

### SLB Diagnostics

#### SLBM Fabric errors (Hosting service provider actions)

1.  Check that Software Load Balancer Manager (SLBM) is functioning and that the orchestration layers can talk to each other: SLBM -> SLB Mux and SLBM -> SLB Host Agents. Run [DumpSlbRestState](https://github.com/Microsoft/SDN/blob/master/Diagnostics/DumpSlbRestState.ps1) from any node with access to Network Controller REST Endpoint.  
2.  Validate the *SDNSLBMPerfCounters* in PerfMon on one of the Network Controller node VMs (preferably the primary Network Controller node - Get-NetworkControllerReplica):
    1.  Is Load Balancer (LB) engine connected to SLBM? (*SLBM LBEngine Configurations Total* > 0)  
    2.  Does SLBM at least know about its own endpoints? (*VIP Endpoints Total* >= 2 )  
    3.  Are Hyper-V (DIP) hosts connected to SLBM? (*HP clients connected*  == num servers)   
    4.  Is SLBM connected to Muxes? (*Muxes Connected* == *Muxes Healthy on SLBM* == *Muxes reporting healthy* = # SLB Muxes VMs).  
3.  Ensure the BGP router configured is successfully peering with the SLB MUX  
    1.  If using RRAS with Remote Access (i.e. BGP virtual machine):  
        1.  Get-BgpPeer should show connected  
        2.  Get-BgpRouteInformation should show at least a route for the SLBM self VIP  
    2.  If using physical Top-of-Rack (ToR) switch as BGP Peer, consult your documentation  
        1.  For example: # show bgp instance  
4.  Validate the *SlbMuxPerfCounters* and *SLBMUX* counters in PerfMon on the SLB Mux VM
5.  Check configuration state and VIP ranges in Software Load Balancer Manager Resource  
    1.  Get-NetworkControllerLoadBalancerConfiguration -ConnectionUri <https://<FQDN or IP>| convertto-json -depth 8 (check VIP ranges in IP Pools and ensure SLBM self-VIP (*LoadBalanacerManagerIPAddress*) and any tenant-facing VIPs are within these ranges)  
        1. Get-NetworkControllerIpPool -NetworkId "<Public/Private VIP Logical Network Resource ID>" -SubnetId "<Public/Private VIP Logical Subnet Resource ID>" -ResourceId "<IP Pool Resource Id>" -ConnectionUri $uri |convertto-json -depth 8 
    2.  Debug-NetworkControllerConfigurationState -  

If any of the checks above fail, the tenant SLB state will also be in a failure mode.  

**Remediation**   
Based on the following diagnostic information presented, fix the following:  
* Ensure SLB Multiplexers are connected  
  * Fix certificate issues  
  * Fix network connectivity issues  
* Ensure BGP peering information is successfully configured  
* Ensure Host ID in the registry matches Server Instance ID in Server Resource (reference Appendix for *HostNotConnected* error code)  
* Collect logs  

#### SLBM Tenant errors (Hosting service provider  and tenant actions)

1.  [Hoster] Check *Debug-NetworkControllerConfigurationState* to see if any LoadBalancer resources are in an error state. Try to mitigate by following the Action items Table in the Appendix.   
    1.  Check that a VIP endpoint is present and advertising routes  
    2.  Check how many DIP endpoints have been discovered for the VIP endpoint  
2.  [Tenant] Validate Load Balancer Resources are correctly specified  
    1.  Validate DIP endpoints which are registered in SLBM are hosting tenant virtual machines which correspond to the LoadBalancer Back-end Address pool IP configurations  
3.  [Hoster] If DIP endpoints are not discovered or connected:   
    1.  Check *Debug-NetworkControllerConfigurationState*  
        1.  Validate that NC and SLB Host Agent is successfully connected to the Network Controller Event Coordinator using ``netstat -anp tcp |findstr 6640)``  
    2.  Check *HostId* in *nchostagent* service regkey (reference *HostNotConnected* error code in the Appendix) matches the corresponding server resource's instance Id (``Get-NCServer |convertto-json -depth 8``)  
    3.  Check port profile id for virtual machine port matches corresponding virtual machine NIC resource's Instance Id   
4.  [Hosting provider] Collect logs   

#### SLB Mux Tracing

Information from the Software Load Balancer Muxes can also be determined through Event Viewer. 
1. Click on "Show Analytic and Debug Logs" under the Event Viewer View menu
2. Navigate to "Applications and Services Logs" > Microsoft > Windows > SlbMuxDriver > Trace in Event Viewer 
3. Right click on it and select "Enable Log"

>[!NOTE]
>It is recommended that you only have this logging enabled for a short time while you are trying to reproduce a problem

### VFP and vSwitch Tracing

From any Hyper-V host which is hosting a guest VM attached to a tenant virtual network, you can collected a VFP trace to determine where problems might lie.

```
netsh trace start provider=Microsoft-Windows-Hyper-V-VfpExt overwrite=yes tracefile=vfp.etl report=disable provider=Microsoft-Windows-Hyper-V-VmSwitch 
netsh trace stop
netsh trace convert .\vfp.etl ov=yes 
```

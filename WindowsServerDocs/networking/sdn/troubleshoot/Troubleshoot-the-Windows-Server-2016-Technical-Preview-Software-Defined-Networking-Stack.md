---
title: Troubleshoot the Windows Server 2016 Technical Preview Software Defined Networking Stack
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9be83ed2-9e62-49e8-88e7-f52d3449aac5
author: vhorne
---
# Troubleshoot the Windows Server 2016 Technical Preview Software Defined Networking Stack

>Applies To: Windows Server Technical Preview

This guide examines the common Software Defined Networking (SDN) errors and failure scenarios and outlines a troubleshooting workflow that leverages the available diagnostic tools.  
  
For more information about Microsoft's Software Defined Networking, see [Software Defined Networking](../../sdn/Software-Defined-Networking--SDN-.md).  
   
## Error types  
The following list represents the class of problems most often seen with HNVv1 in-market production deployments and coincides in many ways with the same types of problems seen in the new SDN Stack.  
  
Most errors can be classified into a small set of classes:   
* **Invalid or unsupported configuration**  
   A user invokes the NorthBound API incorrectly or with invalid policy.   
  
* **Error in policy application**  
     Policy from Network Controller was not delivered to Hyper-V Host, significantly delayed and / or not up to date on all Hyper-V hosts (e.g. after Live Migration).  
* **Configuration drift or software bug**  
 Data-path issues resulting in dropped packets.  
  
* **External error related to NIC hardware / drivers or the underlay network fabric**  
 Misbehaving task offloads (such as VMQ) or underlay network fabric misconfigured (such as MTU)   
   
 This troubleshooting guide examines each of these error categories and recommends best practices and diagnostic tools available to identify and fix the error.  
   
## Diagnostic tools  
  
Before discussing the troubleshooting workflows for each of these type of errors, let's examine the diagnostic tools available.   
  
To use these tools, you must first install the RSAT-NetworkController feature and import the ``NetworkControllerDiagnostics`` module:  
  
```  
Add-WindowsFeature RSAT-NetworkController -IncludeManagementTools  
Import-Module NetworkControllerDiagnostics  
```  
  
  
### Network controller diagnostics  
  
* **``Debug-NetworkControllerConfigurationState -NcIpAddress <FQDN of NC REST>``**  
 This script can run from anywhere that has Layer-3 connectivity to the NetworkController REST IP Address and has the Network Controller REST certificate installed. It queries the Network Controller to see if there are any tenant or fabric resources which are in a failure or warning configuration state based on the actual configuration state of the component. It also returns detailed info containing the source of the error, a message, and error code. The resources on which Configuration State has been implemented and the list of error codes are provided in the Appendix of this topic.  
 * **``Debug-SlbConfigState -NcIp <NC REST IP Address> [-LogPath <string>]``**  
  This script must be run from one of the Network Controller nodes. It queries the Network Controller Software Load Balancer (SLB) Manager service module and sends the output to a text file named ``SlbConfigState.txt``. The default log path location is under ``C:\Tools`` on the host from where the script ran. The text file includes information including the state of the SLB Multiplexers, how many Hyper-V Hosts are connected to the SLB Mux, BGP peering status, advertised routes, and VIPs.  
 * **``Debug-WinFabNodeStatus``**  
 This script must be run from one of the Network Controller nodes. It queries the Network Controller Service Fabric to show the replication status and health state of each Network Controller node. It also shows a "win-diff"-like evolution of the status of the nodes by regularly polling for changes.  
 * **``Get-Replica``**  
This script must be run from one of the Network Controller nodes. It queries the Network Controller's Service Fabric to determine which node the specific Network Controller service modules (e.g. SDNAPI, SlbManagerService, etc.) are primary. It also checks to see if there is a quorum of service module replicas running which are required for consensus and correct operation.  
* **``Test-VNetPing.ps1 -RestUri <string> -SenderIp <string> -ReceiverIp <string> -vNetResourceId <string>``** (available on [GitHub](https://github.com/Microsoft/SDN/blob/master/Diagnostics/Test-VNetPing.ps1))  
 This script allows you to create an ICMP packet to send between two Customer Address (CA) IP Addresses. The tenant administrator specifies the sender and receiver CA IP Addresses and references the virtual network where these IP addresses are attached. The ICMP packet attempts to traverse the layers in the Virtual Filtering Platform (VFP) Hyper-V virtual switch extension. To get the results, query the Network Controller using the ``Get-ConnectivityResults`` command.  
* **``Test-LogicalNetworkPing.ps1 -RestUri <string> -SenderIp <string> -ReceiverIp <string> -LogicalNetworkResourceId <string>``** (available on [GitHub](https://github.com/Microsoft/SDN/blob/master/Diagnostics/Test-LogicalNetworkPing.ps1))  
This script allows a user to create an ICMP packet to be sent between two Provider Address (PA) IP Addresses. The hosting provider administrator specifies the sender and receiver PA IP addresses and reference the HNV Provider logical network where these IPs are attached. To get the results, query the Network Controller using the ``Get-ConnectivityResults`` command.  
* **``Get-ConnectivityResults.ps1 -RestUri <string> [-OperationId <string>]``** (available on [GitHub](https://github.com/Microsoft/SDN/blob/master/Diagnostics/Get-ConnectivityResults.ps1))  
 This script checks the connectivity results from both CA and PA Connectivity checks. You can optionally supply an operation Id (returned by Test-*AConnectivity) as a parameter. If no Operation Id is given, all recent connectivity results are returned. Results are available for one hour.  
   
### Hyper-V host diagnostics  
The following scripts can be run as Windows PowerShell cmdlets on the physical server. Before using these scripts, an administrator must import the ``hnvdiagnostics`` module:  
  
```  
import-module hnvdiagnostics   
```  
* **``GetPACAMapping``**  
 This script returns a table of virtual network information for virtual machines hosted on the physical server. Each row contains the following information:  
  - **Customer Address (CA)**   
  The IP address assigned to the virtual machine NIC on the tenant virtual machine which is connected to a virtual subnet.  
  - **Virtual Subnet ID (VSID)**   
  This value is unique per virtual subnet and corresponds to the VxLAN Network Identifier (VNI) or the NVGRE Tenant Network Identifier (TNI) in the VxLAN and NVGRE headers respectively.  
  - **Provider Address (PA)**   
  The IP Address assigned to a hidden network adapter on the Hyper-V Host. This IP address is used as the encapsulating packet's Layer-3 IP header.   
  - **MAC Address**   
  The CA MAC Address assigned to the tenant virtual machine.  
* **``Get-CustomerRoute``**  
 This script returns a table listing the Customer Address (CA) Routing information as organized by Routing Domain ID (RDID). Each row contain the following information:  
  - **Virtual Subnet ID (VSID)**  
   This value is unique per virtual subnet and corresponds to the VxLAN Network Identifier (VNI) or the NVGRE Tenant Network Identifier (TNI) in the VxLAN and NVGRE headers respectively.   
   -    **CA IP Prefix**  
   The IP prefix for the virtual subnet.  
  - **CA IP Prefix Length**  
  The length (or subnet mask) of the CA IP Prefix.  
  - **CA IP Next Hop**  
  The next-hop required to reach the given CA IP Prefix, usually the default gateway assigned to the HNV distributed router.  
  - **Routing Domain ID**  
* **``Test-LogicalNetworkConnection [PA IP Address]``**  
   This script pings the supplied Provider Address (PA) IP Address on a remote host and automatically determines the correct TCP/IP network compartment where the PA Host vNIC resides. This command is short-hand for the following:  ``ping -c <PA Host vNIC compartment> <PA IP Address>``. PA Connectivity can also be checked through the Network Controller using the ``Test-LogicalNetworkPing.ps1`` command documented previously.  
  
## Troubleshooting scenarios  
The following are common troubleshooting scenarios, with a logical sequence of troubleshooting steps, specific diagnostic tools to use, required inputs, expected outputs, and follow-up actions for each output.  
  
### No network connectivity between two tenant virtual machines  
1.  [Tenant] Ensure Windows Firewall in tenant virtual machines is not blocking traffic.  
2.  [Tenant] Check that IP addresses have been assigned to the tenant virtual machine's VM NIC.  
3.  [Tenant] Run ``Test-VNetPing.ps1`` to validate connectivity between the two tenant virtual machines in question. Run the ``Get-NCVirtualNetwork`` command to determine the resource ID of the virtual network where the tenant virtual machines are attached. Specify the sender and receiver CA IP addresses.  
4.  [Tenant] Check that there is no distributed firewall policies specified on the virtual subnet or VM network interfaces which would block traffic.   
5.  [Tenant] If a failure is reported, run the ``Debug-NetworkControllerConfigurationScript`` to see if any resources are reporting an error. Consult the Appendix to determine next steps.  
6.  [Hosting provider] If a problem still exists, run ``Test-LogicalNetworkPing.ps1`` to validate connectivity between the two Hyper-V hosts themselves. Run ``Get-ProviderAddress`` on both Hyper-V hosts hosting the two tenant virtual machines in question. Run the ``Get-NCLogicalNetwork`` command to determine the resource ID of the HNV provider network. Specify the sender and receive PA IP addresses.  
7.  [Hosting provider]] Ensure that the MTU settings are correct on the Hyper-V hosts and any Layer-2 switching devices in between the Hyper-V Hosts. Run ``Test-EncapOverheadValue`` on all Hyper-V hosts in question. Also check that all Layer-2 switches in between have MTU set to least 1674 bytes to account for maximum overhead of 160 bytes.  
8.  [Hosting provider]] If PA IP Addresses are not present and/or CA Connectivity is broken, check to ensure network policy has been received. Run ``Get-PACAMapping`` to see if the encapsulation rules and CA-PA mappings required for creating overlay virtual networks are correctly established.  
9.  [Hosting provider]] Check that the Network Controller Host Agent is connected to the Network Controller. Run ``netstat -anp tcp |findstr 6640`` to see if the   
10. [Hosting provider]] Check that the Host ID in HKLM/ matches the Instance ID of the server resources hosting the tenant virtual machines.  
11. [Hosting provider]] Check that the Port Profile ID matches the Instance ID of the VM Network Interfaces of the tenant virtual machines.  
  
  
### Software Load Balancer (SLB) failures  
#### SLBM Fabric errors (Hosting service provider actions)  
1.  Check that Software Load Balancer Manager (SLBM) is functioning and that the orchestration layers can talk to each other: SLBM -> SLB Mux and SLBM -> SLB Host Agents. Run Debug-SlbConfigState  from any Network Controller node.  
2.  Validate the SDN SLBM counters through Perfmon / SDN SLBM perf counters. Look at the following counter names in bold:  
    1.  Is Load Balancer (LB) engine connected to SLBM? (SLBM LBEngine Configurations Total > 0)  
    2.  Does SLBM at least know about its own endpoints? (VIP Endpoints Total >= 2 )  
    3.  Are hosts connected to SLBM? (HP  clients connected  == num servers)   
    4.  Is SLBM connected to Muxes? (Muxes Connected == Muxes Healthy on SLBM == Muxes reporting healthy = num Muxes).  
3.  Ensure the BGP router configured is successfully peering with the SLB MUX  
    1.  If using RRAS with Remote Access (i.e. BGP VM):  
        1.  Get-BgpPeer should show connected  
        2.  Get-BgpRouteInformation should show at least a route for the SLBM self VIP  
    2.  If using physical Top-of-Rack (ToR) switch as BGP Peer, consult your documentation  
        1.  For example: # show bgp instance  
4.  Check configuration state and VIP ranges in Software Load Balancer Manager Resource  
    1.  Get-NCLoadBalancerManager | convertto-json -depth 8 (check VIP ranges and ensure SLBM self-VIP and any tenant-facing VIPs are within this range)  
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
1.  [Hosting provider] Check *Debug-NetworkControllerConfigurationState* to see if any LoadBalancer resources are in an error state. Try to mitigate by following the Action items Table in the Appendix.   
    1.  Check that a VIP endpoint is present and advertising routes  
    2.  Check how many DIP endpoints have been discovered for the VIP endpoint  
2.  [Tenant] Validate Load Balancer Resources are correctly specified  
    1.  Validate DIP endpoints which are registered in SLBM are hosting tenant virtual machines which correspond to the LoadBalancer Back-end Address pool IP configurations  
3.  [Hosting provider] If DIP endpoints are not discovered or connected:   
    1.  Check *Debug-NetworkControllerConfigurationState*  
        1.  Validate that NC and SLB Host Agent is successfully connected to the Network Controller Event Coordinator using ``netstat -anp tcp |findstr 6640)``  
    2.  Check *HostId* in *nchostagent* service regkey (reference *HostNotConnected* error code in the Appendix) matches the corresponding server resource's instance Id (``Get-NCServer |convertto-json -depth 8``)  
    3.  Check port profile id for virtual machine port matches corresponding virtual machine NIC resource's Instance Id   
4.  [Hosting provider] Collect logs   
  
  
### Underlay Network Error: Network Controller Cannot Communicate with Host  
1.  [Hoster] Verify basic IP connectivity over management network using ping  
2.  [Hoster] Query Network Controller for Configuration State of Server resource(s) using   
Debug-NetworkControllerConfigurationState  
    1.  [Hoster] Check socket connections:  
        1.  OVSDB: from Hyper-V Host to Network Controller REST IP (TCP:6640)  
        2.  (only after tenant resources are created) WCF: from Hyper-V Host to Network Controller Node (TCP: &lt;ephemeral port&gt;)   
    2.  [Hoster] Check SouthBound channel Certificates  on Hyper-V Host and ensure they match with what is loaded in Network Controller node (VM)  
  
        ```  
        dir cert:\\localmachine\my  
        dir cert:\\localmachine\root  
        ```  
        1.  Subject Name  
        2.  Expiration Date  
        3.  Trusted by Root Authority  
  
  
## Logging and advanced diagnostic  
### Network controller centralized logging  
The Network Controller can automatically collect debugger logs and store them in a centralized location. Log collection can be enabled when when you deploy the Network Controller for the first time or any time later. The logs are collected from the Network Controller, and network elements managed by Network Controller: host machines, software load balancers (SLB) and gateway machines. These logs include debug logs for the Network Controller cluster, the Network Controller application, gateway logs, SLB, virtual networking and the distributed firewall. Whenever a new host/SLB/gateway is added to the Network Controller, logging is started on those machines. Similarly, when a host/SLB/gateway is removed from the Network Controller, logging is stopped on those machines.  
  
### Enable logging  
Logging is automatically enabled when you install the Network Controller cluster using the  ``Install-NetworkControllerCluster`` cmdlet. By default, the logs are collected locally on the Network Controller nodes at *%systemdrive%\SDNDiagnostics*. It is **STRONGLY RECOMMENDED** that you change this location to be a remote file share (not local). The Network Controller cluster logs are stored at *%programData%\Windows Fabric\log\Traces*. You can specify a centralized location for log collection with the ``DiagnosticLogLocation`` parameter with the recommendation that this is also be a remote file share. If you want to restrict access to this location, you can provide the access credentials with the ``LogLocationCredential`` parameter. If you provide the credentials to access the log location, you should also provide the ``CredentialEncryptionCertificate`` parameter, which is used to encrypt the credentials stored locally on the Network Controller nodes.  
  
With the default settings, it is recommended that you have at least 75 GB of free space in the central location, and 25 GB on the local nodes (if not using a central location) for a 3-node Network Controller cluster.  
  
### Change logging settings  
You can change logging settings at any time using the ``Set-NetworkControllerDiagnostic`` cmdlet. The following settings can be changed:  
*   **Centralized log location**  
You can change the location to store all the logs, with the ``DiagnosticLogLocation`` parameter.  
*   **Credentials to access log location**  
You can change the credentials to access the log location, with the ``LogLocationCredential`` parameter.  
*   **Move to local logging**  
If you have provided centralized location to store logs, you can move back to logging locally on the Network Controller nodes with the ``UseLocalLogLocation`` parameter (not recommended due to large disk space requirements).  
*   **Logging scope**  
By default, all logs are collected. You can change the scope to collect only Network Controller cluster logs.  
*   **Logging level**  
The default logging level is Informational. You can change it to Error, Warning, or Verbose.  
*   **Log Aging time**  
The logs are stored in a circular fashion. You will have 3 days of logging data by default, whether you use local logging or centralized logging. You can change this time limit with ``LogTimeLimitInDays`` parameter.  
*   **Log Aging size**  
By default, you will have a maximum 75 GB of logging data if using centralized logging and 25 GB if using local logging. You can change this limit with the ``LogSizeLimitInMBs`` parameter.  
  
  
### Advanced diagnostics and log collection  
  
If the previous troubleshooting guidance does not solve your particular problem, you may need help from a support or software engineer. In this case, the engineer will need the output from the following components:  
```  
Debug-NetworkControllerConfigState -  
  
ovsdb-client.exe dump tcp:127.0.0.1:6641 ms_vtep  
  
ovsdb-client.exe dump tcp:127.0.0.1:6641 ms_firewall  
  
vfpctrl /list-vmswitch-port  
  
vfpctrl /port <port name> /get-port-state  
```  
  
## Appendix  
This appendix lists the error codes and messages output as a result of ``Test-Connectivity`` and ``Debug-NetworkControllerConfigurationState``.  
  
  
### Test-connectivity recovery actions  
If the packet is dropped due to rule misconfiguration, this is typically evident in the VFP rule traces. The following is a list of potentially common errors due to misconfiguration.  
  
  
Rule/Drop Reason  |Description  |Action    
---------|---------|---------  
No rule match     | Network Controller Host Agent was unable to program vSwitch layers or rules in Virtual Filtering Platform (VFP).        | Run the ``Debug-NetworkControllerConfigurationState`` to determine which resource is in an error state.          
PA route rule     |No route to PA destination|PA network configuration. For example: Duplicate PA IP address<br><br>Hosting provider should use ``Test-LogicalNetworkConnectivity`` (or ``ping -c <compartmentId> <PA IP>``) to diagnose PA connectivity issue.|       
ACL rules     |Packet isn't allowed through firewall         |Tenant admin should inspect and fix any ACLs applied on the VM NIC or virtual subnet which may be precluding traffic from flowing           
Address resolution failure(ARP/ND interception)|Address resolution failed for CA destination. This is likely a configuration issue.|Example: VM IP address was manually changed.<br><br>Network Controller configuration state should point out issues with address management (e.g. failure to assign IP through DHCP or duplicate CA)  
MAP encap rule|Missing CA-PA mapping|Tenant admin should consult Network Controller Configuration State (VM NIC resource) and IP configuration to ensure the CA IP address is correctly specified.           
Forwarding     |Packet does not match any of the ports for forwarding|Tenant admin should consult Network Controller Configuration State (VM NIC resource) and IP configuration to ensure the CA IP address is correctly specified.           
Redirection Rules|Misconfigured redirection rule causes the packet not to be redirected to DR IP.<br><br>In this case CA ping is used to ping infra service proxy endpoint (without setting up a listener).|Tenant administrator should consult Network Controller Configuration State (VM NIC resource) and IP configuration to ensure the CA IP address is correctly specified.           
  
### Network controller configuration state error codes and recovery actions  
  
  
  
| **Code**| **Message**| **Action**                                                                                 |  
|---------|------------|-----------|  
| Unknown| Unknown error|                                                                                                                                                                                                                                                                                                          |  
| HostUnreachable| The host machine is not reachable                                                             | Check the Management network connectivity between Network Controller and Host                                                                                                                                                                                                                                        |  
| PAIpAddressExhausted| The PA Ip addresses exhausted                                                                 | Increase the HNV Provider logical subnet's IP Pool Size.                                                                                                                                                                                                                                                    |  
| PAMacAddressExhausted| The PA Mac addresses exhausted.                                                               | Increase the Mac Pool Range.                                                                                                                                                                                                                                                                                |  
| PAAddressConfigurationFailure         | Failed to plumb PA addresses to the host.                                                     | Check the Management network connectivity between Network Controller and Host.                                                                                                                                                                                                                                        |  
| CertificateNotTrusted                 | Certificate is not trusted                                                                    |Fix the certificates used for communication with the host.                                                                                                                                                                                                                                                  |  
| CertificateNotAuthorized              | Certificate not authorized.                                                                   | Fix the certificates used for communication with the host.                                                                                                                                                                                                                                                 |  
| PolicyConfigurationFailureOnVfp       | Failure in configuring VFP policies.                                                         | This is a runtime failure.  No definite work arounds. Collect logs.                                                                                                                                                                                                                                        |  
| PolicyConfigurationFailure            | Failure in pushing policies to the hosts, due to communication            failures or others error in the NetworkController.| No definite actions.  This is due to failure in goal state processing in the Network Controller modules. Collect logs.                                                                                                                                                                                      |  
| HostNotConnectedToController                           | The Host is not yet connected to the Network Controller.                                       | Port Profile not applied on the host or the host is not reachable from the Network Controller. Validate that HostID registry key (under HKLM/System/CurrentControlSet/Services/NcHostAgent/Parameters) matches the Instance ID of the server resource in question (``Get-NCServer`` &#124; ``convertto-json -depth 8``) |  
| MultipleVfpEnabledSwitches| There are multiple VFp enabled Switches on the host                                           | Delete one of the switches, since Network Controller Host Agent only supports one vSwitch with the VFP extension enabled                                                                                                                                                                                   |  
| PolicyConfigurationFailure            | Failed to push VNet policies for a VmNic due to certificate errors or connectivity errors.     | Check if proper certificates have been deployed (Certificate subject name must match FQDN of host). Also verify the host connectivity with the Network Controller.                                                                                                                                          |  
| PolicyConfigurationFailure            | Failed to push vSwitch policies for a VmNic due to certificate errors or connectivity errors  | Check if proper certificates have been deployed (Certificate subject name must match FQDN of host). Also verify the host connectivity with the Network Controller.                                                                                                                                           |  
| PolicyConfigurationFailure            | Failed to push Firewall policies for a VmNic due to certificate errors or connectivity errors | Check if proper certificates have been deployed (Certificate subject name must match FQDN of host). Also verify the host connectivity with the Network Controller.                                                                                                                                          |  
| DistributedRouterConfigurationFailure | Failed to configure the Distributed router settings on the host vNic                          | TCPIP stack error. May require cleaning up the PA and DR Host vNICs on the server on which this error was reported.                                                                                                                                                                                          
| DhcpAddressAllocationFailure          | DHCP address allocation failed for a VMNic                                                    | Check if the static IP address attribute is configured on the NIC resource                                                                                                                                                                                                                                 |  
| CertificateNotTrusted<br>CertificateNotAuthorized               | Failed to connect to Mux due to network or cert errors                                        | Check the numeric code provided in the error message code: this corresponds to the winsock error code. Certificate errors are granular (for example, cert cannot be verified, cert not authorized, etc.)                                                                                                           |  
| HostUnreachable                       | MUX is Unhealthy (Common case is BGPRouter disconnected)                                      | BGP peer on the RRAS (BGP VM) or Top-of-Rack (ToR) switch is unreachable or not peering successfully. Check BGP settings on both Software Load Balancer Multiplexer resource (``Get-NCLoadBalancerMux``  &#124; ``convertto-json -depth 8``) and BGP peer (ToR or RRAS VM)                                               |  
| HostNotConnectedToController                           | SLB host agent is not connected                                                               | Refer to SLB host agent logs (auto running) for reasons why, in case SLBM (NC) rejected the cert presented by the host agent running state will show nuanced information                                                                                                                                   |  
| PortBlocked                           | The VFP port is blocked, due to lack of VNET / ACL policies.                                  | Check if there are any other errors, which might cause the policies to be not configured.                                                                                                                                                                                                                  |  
| Overloaded                            | Loadbalancer MUX is overloaded.                                                               | Performance issue with MUX.                                                                                                                                                                                                                                                                                |  
| RoutePublicationFailure               | Loadbalancer MUX is not connected to a BGP router.                                            | Check if the MUX has connectivity with the BGP routers and that BGP peering is setup correctly.                                                                                                                                                                                                            |  
| VirtualServerUnreachable              | Loadbalancer MUX is not connected to SLB manager.                                             | Check connectivity between SLBM and MUX.                                                                                                                                                                                                                                                                   |  
| QosConfigurationFailure               | Failed to configure QOS policies.                                                             | See if sufficient bandwidth is available for all VM's if QOS reservation is used.                                                                                                                                                                                                                          |



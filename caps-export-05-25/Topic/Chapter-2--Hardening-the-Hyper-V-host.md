---
title: Chapter 2: Hardening the Hyper-V host
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e716e3ac-a7a8-4d0a-bf18-bc088dd72fed
author: cwatsonmsft
---
# Chapter 2: Hardening the Hyper-V host
This chapter focuses on hardening servers that run the Hyper\-V role of Windows Server 2012, in both Full and Server Core installations. It contains security best practice recommendations to help protect against unauthorized access and resource tampering.  
  
Significant changes were introduced to the Hyper\-V role in Windows Server 2012. For more information about the new features introduced in Windows Server 2012 Hyper\-V, see [What’s New in Hyper\-V for Windows Server 2012](http://technet.microsoft.com/library/hh831410.aspx).  
  
## Installation Recommendations  
You can install Hyper\-V with either the Full \(Server with a GUI\) or the Server Core installation options of the 64\-bit editions of Windows Server 2012.  
  
Server Core is a minimal server installation option that provides a low\-maintenance server environment with limited functionality. With a Server Core installation only the minimal components that are necessary to support core functionality and key server roles are installed, including Hyper\-V \(if selected\).  
  
Using Server Core for Hyper\-V physical computers provides the primary security benefit of ensuring a minimized attack surface for the management operating system.  
  
It is important to note that Server Core cannot be managed locally using traditional graphical user interfaces \(GUIs\) such as Server Manager. Additionally some drivers, software agents, and applications are not compatible with a Server Core management operating system. In particular, some parts of the Microsoft .NET Framework are not included with Server Core installations. As a result, it may not be possible to run some .NET applications with the management operating system.  
  
Apart from the differences between the Full and Server Core options, the attack surface for the Hyper\-V component is the same in the Standard and Datacenter SKUs of Windows Server 2012.  
  
For installation instructions for Server Core, see[Configure and Manage Server Core Installations](http://technet.microsoft.com/library/jj574091.aspx). To check if your server hardware is compatible, see the [Windows Server Catalog](http://go.microsoft.com/fwlink/?LinkId=123535). After the installation of Hyper\-V, it is recommended that all appropriate updates are installed. A comprehensive list of Hyper\-V updates is available in the [HYPERLINK "http:\/\/social.technet.microsoft.com\/wiki\/contents\/articles\/15576.hyper\-v\-update\-list\-for\-windows\-server\-2012.aspx" Hyper\-V Update List](http://social.technet.microsoft.com/wiki/contents/articles/15576.hyper-v-update-list-for-windows-server-2012.aspx).  
  
## Anti\-malware software in the Management Operating System  
The installation or use of anti\-malware in the management operating system is not recommended.  
  
However, if you need to run anti\-malware in the Management Operating System for regulatory compliance or other reasons, we require that you configure any real\-time scanning components to exclude the directories where virtual machine files are stored, as well as the program files vmms.exe and vmwp.exe in C:\\Windows\\System32. If you do not create these exclusion rules, you might encounter errors when creating and starting virtual machines. The use of anti\-malware in the Management Operating System may be associated with a non\-trivial performance impact.  
  
## Virtual Machine Authentication for Live Migration  
Live migration to and from a Hyper\-V host is disabled by default, it can be enabled by a Hyper\-V administrator.  Live migration can be enabled for any available network interface or restricted to only specified interfaces.  It is recommended that you perform live migrations only over secure networks and configure live migration to only utilize these interfaces.  
  
When Hyper\-V hosts are within a cluster, the clustering framework automatically enables live migration. Hyper\-V in Windows Server 2012 allows virtual machines to be migrated outside a cluster. It is important to ensure that hosts are authenticated prior to migration operations. Hyper\-V allows using either Kerberos or CredSSP for this purpose. Both the source and destination hosts of a live migration will need to have the same settings for authentication. The usage of Kerberos requires a domain and trust relationships.  
  
Configuring constrained delegation is required if administration operations are to be performed using remote management tools. Additionally, the source and destination nodes of the intended live migration need to use the same protocol set.  
  
For more information on configuring authentication scheme for migration, see [Configure Live Migration and Migrating Virtual Machines without Failover Clustering](../Topic/Configure-Live-Migration-and-Migrating-Virtual-Machines-without-Failover-Clustering.md).  
  
## Securing Live Migration Traffic  
Live Migration traffic is not encrypted and could contain secrets. It is recommended to use a private, dedicated or secured network for live migration traffic. Isolating Live Migration traffic from other network traffic or encrypting it with IPSec or other network encryption helps in preventing man in the middle attacks.  
  
## Securing Storage Migration traffic  
Storage Migration traffic is not encrypted and could contain secrets  
  
Windows Server 2012 introduces the SMB 3.0 standard that provides end\-to\-end encryption of SMB data and protects data from eavesdropping occurrences on untrusted networks. It is recommended that this functionality is used. It is important to note that when performing storage migration between two Hyper\-V hosts the share is dynamically created thus share level encryption may not suffice.  
  
This requires no new deployment costs, and no need for Internet Protocol security \(IPsec\), specialized hardware, or WAN accelerators. SMB encryption may be configured on a per share basis, or for the entire file server, and may be enabled for a variety of scenarios where data traverses untrusted networks. It is recommended to use a private network to access the SMB share contents to isolate from any other traffic and prevent man\-in\-the\-middle attacks. SMB encryption or IPSec could be used to establish a secure communication channel between the virtual machine host and the SMB server.  
  
## WMI Encryption  
The Hyper\-V WMI service in the Virtual Machine Management Service \(vmms.exe\) process accepts encrypted connections as well. To avoid any information disclosure when remotely accessing WMI interfaces, the WMI client could set authentication level to PktPrivacy or RPC\_C\_AUTHN\_LEVEL\_PKT\_PRIVACY so that the WMI traffic between the client and the server is encrypted.  
  
A sample script for reference can be found at [Securing a Remote WMI Connection \(Windows\)](http://msdn.microsoft.com/library/windows/desktop/aa393266.aspx#setting_namespace_security_to_require_data_encryption_for_remote_connections) When you use Hyper\-V PowerShell module or the Hyper\-V manager UI, it is important to note that these clients already use an encrypted connection to the provider.  
  
Additionally, Windows Remote Management \(WinRM\) supports HTTPS transports. [Legacy WMI – Configuration and Security](http://technet.microsoft.com/library/cc782312.aspx) covers additional details.  
  
## Hyper\-V Replica  
Hyper\-V Replica was introduces with  Windows Server 2012 enabling virtual machines to be replicated across Hyper\-V hosts or clusters.  Hyper\-V Replica supports two modes of connectivity: HTTP and HTTPs.  
  
The HTTP based mechanism does not encrypt data and relies on an Active Directory infrastructure for authentication. VPN tunnels or IPsec encryption can provide the necessary encryption when HTTP based connectivity is used.  
  
The HTTPS based mechanism encrypts data and requires the use of certificates for authentication which are used by the primary and the replica sites for mutual authentication.  
  
In addition to authentication, it is critical to authorize only the primary servers\/clusters that are allowed to replicate to a given replica server\/broker.  The same identity that is authenticated by Active Directory or by certificates is used to authorize the connection to the primary servers\/cluster. Certificates be used even if there is no trust between domains as long as they’re issued by a trusted root authority.  
  
The authorization entry can be primary server name \(if it is a standalone server\), primary cluster broker name or wildcard entries.  Although wildcards are permitted, it is recommended to be as specific as possible to restrict access to the servers.  
  
Once a virtual machine is created on the replica site, the replica VM is associated with the primary server\/cluster that created it.  Modifications to the authorization entries will impact replication to replica VMs that are associated with the changed authorization entries.  
  
Using IP addresses in the authorization table is not allowed as it does not suffice the conditions for connection authentication.  
  
## Networking Security  
Network security policies are implemented in the Hyper\-V Virtual Switch.  The majority of these policies are configured per switch port, with the exception of diagnostics and tracing which are configured on a per switch instance.  
  
The list of security related capabilities that can be configured for individual switch ports include:  
  
### MAC Address Spoofing  
By default each virtual machine port is restricted to only pass traffic for the configured MAC address of that port.  This prevents malicious traffic from being sent from a spoofed address.  There are times when a virtual machine may validly need to deal with traffic of a different MAC address such as Network Load Balancing.  Enabling [MAC Address Spoofing](http://technet.microsoft.com/library/jj679878.aspx#bkmk_mac) will allow other MAC address traffic to pass to\/from the virtual machine.  
  
### Port Access Control Lists \(ACLs\)  
Each virtual switch port can have multiple [port ACLs](http://technet.microsoft.com/library/jj679878.aspx#bkmk_portacls) set.  Each ACL can be filtered by MAC address, IPv4, or IPv6 address.  The ACL can Allow or Deny packets.  IPv4\/IPv6 also allow filter masks for range matching.  
  
### DHCP Guard  
Each virtual machine can be prevented from acting as or responding as a DHCP server by enabling [DHCP Guard](http://technet.microsoft.com/library/jj679878.aspx#bkmk_dhcp).  
  
### Router Guard  
Each virtual machine can be prevented from issuing router advertisement and redirection messages by enabling [Router Guard](http://technet.microsoft.com/library/jj679878.aspx#bkmk_router).  
  
### Port Mirroring  
Traffic from virtual machines on the virtual switch can be copied to a monitoring virtual machine port by configuring [Port Mirroring](http://technet.microsoft.com/library/jj679878.aspx#bkmk_portmirror) on both the source ports and destination monitor.  
  
### Isolation: VLAN, Private VLAN \(PVLAN\), Hyper\-V Network Virtualization \(HNV\)  
There are several isolation mechanisms that are supported for tenants.  
  
With VLAN, it is possible to configure multiple VLANs for a particular virtual machine using trunk mode.  
  
Another isolation mechanism that helps utilize VLANs efficiently is PVLAN. Read more about [PVLAN and trunk mode](http://technet.microsoft.com/library/jj679878.aspx#bkmk_pvlan).  
  
Large\-scale isolation is provided by Hyper\-V Network Virtualization \(HNV\) and can be most easily deployed using System Center Virtual Machine Manager \(SCVMM\).  
  
### VM transmit rate limits  
Each switch port can be rate limited to ensure a particular virtual machine does not use so much bandwidth to deprive other virtual machines.  
  
### IPsec Task Offload  
IPsec is an endpoint\-to\-endpoint encryption tunnel.  The encryption computation does utilize CPU.  The computation can be offloaded from the virtual machines to the network adapter using the [IPsec Task Offload](http://technet.microsoft.com/library/jj679878.aspx#bkmk_ipsecto) capability, if the network adapter supports such offload.  
  
### Virtual Switch Extensions  
Firewall and networking traffic monitoring is available from third party [virtual switch extensions](http://technet.microsoft.com/library/hh831452.aspx).  Switch extensions can provide traffic monitoring in capturing, filtering, or forwarding extensions.  Security features, such as firewalls, intrusion detection, etc., can be implemented in Windows Filter Platform \(WFP\) extensions, as well as filtering and forwarding extensions.  
  
Each switch extension may include other security functionality and be subject to its own security recommendation.  
  
### Unified Tracing \/ Events Tracing \(ETW\)  
Virtual switch event tracing can be used to diagnose packet drops and related events.  Unified Tracing can be used to capture packets for deeper diagnosis.  See TechNet for more details on [Unified Tracing](http://technet.microsoft.com/library/hh848933.aspx) and using [HYPERLINK "http:\/\/technet.microsoft.com\/library\/jj129382.aspx" Netsh Commands for Network Tracing](http://technet.microsoft.com/library/jj129382.aspx).  
  
## Virtual Desktop Infrastructure  
  
### Remote Desktop Virtualization Host  
Remote Desktop Virtualization Host \(RD Virtualization Host\) is a Remote Desktop Services role service included with Windows Server 2012 and is an important component to the Virtual Desktop Infrastructure \(VDI\) solution offered by Microsoft. RD Virtualization Host integrates with the Hyper\-V role to provide virtual machines that can be used as personal virtual desktops or virtual desktop pools by using RemoteApp and Desktop Connection.  
  
A sufficiently privileged user role can make personal virtual desktops or virtual desktop pools available to users by using either RemoteApp and Desktop Connection or Remote Desktop Web Access \(RD Web Access\). These virtual desktops are virtual machines hosted on a computer that is running Windows Server 2012 on which Hyper\-V and RD Virtualization Host are also installed.  
  
The RDVH role is implemented in the Remote Desktop Virtualization Host Agent service, which has dependencies on the Hyper\-V Virtual Machine Management service, RPC, and Windows Management Instrumentation.  
  
The Remote Desktop Virtualization Host Agent service runs in a svchost instance under the NetworkServiceRemoteDesktopHyperVAgent group. This svchost is not shared with any other services. The RDVH Agent service uses the Automatic start option and is configured to log on with the Network Service Account.  
  
At the time of RDVH role installation, the service SID of the agent is configured to be part of the Hyper\-V Administrators local group.  
  
## See also:  
[Chapter 1: Overview](../Topic/Chapter-1--Overview.md)  
  
[Chapter 3: Roles & Delegation](../Topic/Chapter-3--Roles---Delegation.md)  
  
[Chapter 4: Protecting Virtual Machines](../Topic/Chapter-4--Protecting-Virtual-Machines.md)  
  
[Chapter 5: Best Practices Checklist](../Topic/Chapter-5--Best-Practices-Checklist.md)  
  

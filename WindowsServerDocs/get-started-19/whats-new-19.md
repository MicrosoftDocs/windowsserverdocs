---
title: What's new in Windows Server 2019
description: "What's new in Windows Server 2019"
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: dawnwood
ms.author: dawn.wood
ms.localizationpriority: high
ms.date: 10/02/2018
---

# What's new in Windows Server 2019

This topic describes the new features in Windows Server 2019. 

## Windows Admin Center

[Windows Admin Center](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/overview) is an evolution of Windows Server in-box management tools; it’s a single pane of glass that consolidates all aspects of local and remote server management. 
As a locally deployed, browser-based management experience, an Internet connection and Azure aren’t required. Windows Admin Center gives you full control of all aspects of your deployment, 
including private networks that aren’t Internet-connected.
<br/><br/>
Windows Admin Center is a free download, separate from the Windows Server 2019 download, for enhanced flexibility and remote management strategies.  See the Windows Admin Center OS support [matrix](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/plan/installation-options) for installation and management compatibility.

## Desktop experience

The <b>Desktop Experience</b> is back in Windows Server 2019!  It is not included in Windows Server, version 1709, Windows Server, version 1803, or Windows Server, version 1809.  
As with Windows Server 2016, during setup of the operating system it is possible to choose between Server Core installations or Server with Desktop Experience installations.

## Server Core app compatibility feature on demand

The [Server Core App Compatibility feature on demand (FOD)](https://docs.microsoft.com/en-us/windows-server/get-started-19/install-fod-19) significantly improves the app compatibility of the Windows Server Core installation option by including a subset of binaries and components from Windows Server with the Desktop Experience, without adding the Windows Server Desktop Experience graphical environment itself.  This is done to increase the functionality and compatibility of Server Core while keeping it as lean as possible.  
This optional feature on demand is available on a separate ISO and can be added to Windows Server Core installations and images only, using DISM. 

## System insights

<b>System Insights</b> is a new feature available in Windows Server 2019 that brings local predictive analytics capabilities natively to Windows Server. These predictive capabilities—each backed by a machine-learning model—locally analyze Windows Server system data, such as performance counters and events, 
providing insight into the functioning of your deployments and helping you reduce the operational expenses associated with monitoring your Windows Server instances. 

## Shielded Virtual Machines improvements

* You can now run shielded virtual machines on machines with intermittent connectivity to the Host Guardian Service by leveraging the new fallback HGS and offline mode features. Fallback HGS allows you to configure a second set of URLs for Hyper-V to try if it can't reach your primary HGS server. 
Offline mode allows you to continue to start up your shielded VMs, even if HGS can't be reached, as long as the VM has started successfully once, and the host's security configuration has not changed.
* We've also made it easier to troubleshoot your shielded virtual machines by enabling support for VMConnect Enhanced Session Mode and PowerShell Direct. These tools are particularly useful if you've lost network connectivity to your VM and need to update its configuration to restore access. 
These features do not need to be configured, and they will automatically become available when a shielded VM is placed on a Hyper-V host running build 17040 or later.
* For customers who run mixed-OS environments, Windows Server 2019 now supports running Ubuntu, Red Hat Enterprise Linux, and SUSE Linux Enterprise Server inside shielded virtual machines. 

## Storage Migration Service

Storage Migration Service (SMS) is a new role included in Windows Server Standard and Datacenter editions. SMS is a job-based orchestration and proxy that:
Allows administrators to inventory existing servers for their data, security, and network settings.
Migrates that data, security, and network settings to a new, modern target by using the SMB protocol.
Takes over the identity of the old server completely, while decommissioning the original source, in such a way that users and applications are unaffected and unaware that migration has taken place. 

## Container Networking with Kubernetes

[Container Networking with Kubernetes](https://docs.microsoft.com/en-us/windows-server/networking/sdn/technologies/containers/container-networking-overview) in Windows Server 2019 greatly improves usability of Kubernetes on Windows by enhancing platform networking resiliency and support of container networking plugins. 
Additionally, customers deploying workloads on Kubernetes network security to protect both Linux and Windows services using embedded tooling.

## Azure Network Adapter

Azure Network Adapter – Now with Windows Server 2019, Windows Admin Center enables a one-click experience to configure a point-to-site VPN connection between an on-premises Windows Server and an Azure Virtual Network.
This automates the configuration for the Azure Virtual Network gateway as well as the on-premises VPN client.  

## Software Defined Network (SDN)

For a complete list of what’s new in SDN see, [What’s New in SDN for Windows Server 2019](https://docs.microsoft.com/en-us/windows-server/networking/sdn/sdn-whats-new).
<br/>
* [Encrypted Networks](https://docs.microsoft.com/en-us/windows-server/networking/sdn/sdn-whats-new) - Virtual network encryption allows encryption of virtual network traffic between virtual machines that communicate with each other within subnets marked as ‘Encryption Enabled.’ 
It also utilizes Datagram Transport Layer Security (DTLS) on the virtual subnet to encrypt packets. DTLS protects against eavesdropping, tampering, and forgery by anyone with access to the physical network.
<br/>
* [Security with SDN](https://docs.microsoft.com/en-us/windows-server/networking/sdn/security/sdn-security-top) delivers many features to increase customer confidence in running workloads either on-premises or as a service provider in the cloud. 
These security enhancements are integrated into the comprehensive SDN platform that our customers have already been using since Windows Server 2016.
<br/>
* [High performance SDN gateways](https://docs.microsoft.com/en-us/windows-server/networking/sdn/gateway-performance) in Windows Server 2019 greatly improves the performance for IPsec and GRE connections. 
All this, with huge reductions in the CPU cycles/per byte, thereby providing ultra-high-performance throughput with much less CPU utilization.
<br/>
* **New Deployment UI and Windows Admin Center extension for SDN** - Now, with Windows Server 2019, it’s easy to deploy and manage through a new deployment UI and Windows Admin Center extension 
that will enable anyone to harness the power of SDN. 

## Network performance improvements for virtual workloads

[Network performance improvements for virtual workloads](https://docs.microsoft.com/en-us/windows-server/networking/technologies/hpn/hpn-insider-preview) will maximize the network throughput to virtual machines without requiring you to constantly tune or over-provision your host. This lowers the Operations & Maintenance cost while increasing the available density of your hosts. These new features are:

* Receive Segment Coalescing in the vSwitch
* Dynamic Virtual Machine Multi-Queue (d.VMMQ)

## HTTP/2 for a faster and safer Web

* Improved coalescing of connections to deliver an uninterrupted and properly encrypted browsing experience.
* Upgraded HTTP/2’s server-side cipher suite negotiation for automatic mitigation of connection failures and ease of deployment.
* Changed our default TCP congestion provider to Cubic to give you more throughput!

## Low Extra Delay Background Transport

Low Extra Delay Background Transport (LEDBAT) is a latency optimized, network congestion control provider designed to automatically yield bandwidth to users and applications, while consuming the entire bandwidth available when the network is not in use.   
This technology is intended for use in deploying large, critical updates across an IT environment without impacting customer facing services and associated bandwidth.

## Windows Time Service

The [Windows Time Service](https://docs.microsoft.com/en-us/windows-server/networking/windows-time-service/insider-preview) includes true UTC-compliant leap second support, a new time protocol called Precision Time Protocol, and end-to-end traceability.

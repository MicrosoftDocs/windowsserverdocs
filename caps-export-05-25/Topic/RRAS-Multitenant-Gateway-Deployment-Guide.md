---
title: RRAS Multitenant Gateway Deployment Guide
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f7de17b-d072-485e-8d4b-18189ccd0cbc
author: vhorne
---
# RRAS Multitenant Gateway Deployment Guide
You can use this guide to install and configure a multitenant gateway that provides your tenants with access to their cloud resources.  
  
This guide contains the following sections.  
  
-   [Configure the RRAS Multitenant Gateway for use with Hyper-V Network Virtualization](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-use-with-Hyper-V-Network-Virtualization.md)  
  
-   [Configure the RRAS Multitenant Gateway for use with VLANs_1](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-use-with-VLANs_1.md)  
  
-   [Configure the RRAS Multitenant Gateway for Site-to-Site VPN Connections](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-Site-to-Site-VPN-Connections.md)  
  
-   [Configure the RRAS Multitenant Gateway to Perform Network Address Translation for Tenant Computers](../Topic/Configure-the-RRAS-Multitenant-Gateway-to-Perform-Network-Address-Translation-for-Tenant-Computers.md)  
  
-   [Configure the RRAS Multitenant Gateway for Dynamic Routing with BGP](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-Dynamic-Routing-with-BGP.md)  
  
-   [Additional Resources_83](../Topic/Additional-Resources_83.md)  
  
In [!INCLUDE[winthreshold_server_1](../Token/winthreshold_server_1_md.md)], the Remote Access server role includes the Routing and Remote Access Service \(RRAS\) role service.  
  
This guide demonstrates how to use Windows PowerShell to deploy RRAS as a virtual machine \(VM\)\-based software gateway and router that allows Cloud Service Providers \(CSPs\) and Enterprises to enable datacenter and cloud network traffic routing between virtual and physical networks, including the Internet. You can deploy VM networks by using either Hyper\-V Network Virtualization or Virtual Local Area Networks \(VLANs\).  
  
RRAS is integrated with Hyper\-V Network Virtualization, and is able to route network traffic effectively in circumstances where there are many different customers – or tenants – who have isolated virtual networks in the same datacenter.  
  
Multi\-tenancy is the ability of a cloud infrastructure to support the virtual machine workloads of multiple tenants, but isolate them from each other, while all of the workloads run on the same infrastructure. The multiple workloads of an individual tenant can interconnect and be managed remotely, but these systems do not interconnect with the workloads of other tenants, nor can other tenants remotely manage them.  
  
> [!NOTE]  
> If you are using System Center 2012 R2 and Virtual Machine Manager, you can deploy Hyper\-V Network Virtualization with Windows Server Gateway rather than deploying RRAS as a Multitenant Gateway using Windows PowerShell. If you are not using System Center, this guide provides instructions on how to deploy an RRAS Multitenant Gateway using only Windows PowerShell. For more information, see [Windows Server Gateway](http://technet.microsoft.com/library/dn313101.aspx).  
  
### Who will be interested in this guide?  
Information Technology professionals that might be interested in this guide:  
  
-   Network administrators and architects who work for Cloud Service Providers  
  
-   Network administrators and architects who work for large organizations with Enterprise networks  
  
-   Other network and systems administrators who want to learn how to deploy virtual networking technologies by using Windows PowerShell  
  
### What this guide provides  
This deployment guide allows you to deploy the RRAS Multitenant Gateway \(MTGW\) by using Windows PowerShell. Using the RRAS MTGW, you can:  
  
-   Provide your tenants with dial\-in VPN access to their resources in your datacenter  
  
-   Use the RRAS Multitenant Gateway as an endpoint for multiple tenant site\-to\-site VPN connections to their remote sites  
  
-   Route traffic between Network Virtualization\-based VM Networks and the Internet  
  
-   Route traffic between VLAN\-based VM Networks and the Internet  
  
In addition, you can configure the gateway with Network Address Translation \(NAT\) services so that your tenant VMs can access Internet resources.  
  
### RRAS Multitenant Gateway deployment requirements  
Following are the requirements for deploying the RRAS MTGW by using this guide.  
  
-   You must have a minimum of two computers that are running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], one to use as the Hyper\-V Network Virtualization host, and one to use as the Hyper\-V host that runs the RRAS Multitenant Gateway VM.  
  
-   The Hyper\-V host used for Network Virtualization or VM VLAN deployment must be running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] with a minimum of 16 GB RAM and at least one network adapter.  
  
-   The Hyper\-V host used for the RRAS Multitenant Gateway must be running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] with a minimum of 8 GB RAM and at least two network adapters.  
  
> [!IMPORTANT]  
> For production environment deployments, requirements for the computer running Hyper\-V with one or more VMs configured as a RRAS MTGW are the same as for Windows Server Gateway. For more information, see [Windows Server Gateway Hardware and Configuration Requirements](http://technet.microsoft.com/library/dn423897.aspx).  
  
### <a name="bkmk_overview"></a>RRAS Multitenant Gateway deployment overview  
The following illustration depicts the RRAS Multitenant Gateway and a Hyper\-V Network Virtualization server and VMs that you can deploy by using this guide.  
  
![](../Image/rras_gateway_overview.jpg)  
  
For more information see either of the following sections:  
  
-   [Configure the RRAS Multitenant Gateway for use with Hyper-V Network Virtualization](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-use-with-Hyper-V-Network-Virtualization.md)  
  
-   [Configure the RRAS Multitenant Gateway for use with VLANs_1](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-use-with-VLANs_1.md)  
  
**Site\-to\-site VPN connections**  
  
You can configure the RRAS Multitenant Gateway with site\-to\-site VPN connections to your tenants’ Enterprise network sites:  
  
![](../Image/rras_csp_multitenant1.jpg)  
  
For more information, see [Configure the RRAS Multitenant Gateway for Site-to-Site VPN Connections](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-Site-to-Site-VPN-Connections.md).  
  
**Point\-to\-site VPN access**  
  
You can provide your tenants’ Administrators with point\-to\-site VPN access from anywhere on any device:  
  
![](../Image/rras_vpn.jpg)  
  
**Network Address Translation \(NAT\) for VM Internet access**  
  
You can configure Network Address Translation \(NAT\) to provide Internet access for tenant VMs. When you enable NAT, the commerce\-based and other applications running on the VMs can connect to resources on the Internet.  
  
![](../Image/rras_nat.jpg)  
  
For more information, see [Configure the RRAS Multitenant Gateway to Perform Network Address Translation for Tenant Computers](../Topic/Configure-the-RRAS-Multitenant-Gateway-to-Perform-Network-Address-Translation-for-Tenant-Computers.md).  
  
**Border Gateway Protocol \(BGP\) Routing**  
  
You can configure the RRAS Multitenant Gateway as a BGP router.  
  
For more information, see [Configure the RRAS Multitenant Gateway for Dynamic Routing with BGP](../Topic/Configure-the-RRAS-Multitenant-Gateway-for-Dynamic-Routing-with-BGP.md).  
  

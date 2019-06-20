---
title: Deploy Remote Access in a Cluster
description: This topic is part of the guide Deploy Remote Access in a Cluster in Windows Server 2016.
manager: dougkim
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid:
ms.author: pashort
author: shortpatti
---
# Deploy Remote Access in a Cluster

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Windows Server 2016 and Windows Server 2012 combine DirectAccess and Remote Access Service \(RAS\) VPN into a single Remote Access role. You can deploy Remote Access in a number of enterprise scenarios. This overview provides an introduction to the enterprise scenario for deploying multiple Remote Access servers in a cluster load balanced with Windows Network Load Balancing \(NLB\) or with an external load balancer \(ELB\), such as F5 Big\-IP.  

## <a name="BKMK_OVER"></a>Scenario description  
A cluster deployment gathers multiple Remote Access servers into a single unit, which then acts as a single point of contact for remote client computers connecting over DirectAccess or VPN to the internal corporate network using the external virtual IP \(VIP\) address of the Remote Access cluster.  Traffic to the cluster is load balanced using Windows NLB or with an external load balancer \(such as F5 Big\-IP\).  

## Prerequisites  
Before you begin deploying this scenario, review this list for important requirements:  

-   Default load balancing through Windows NLB.  

-   External load balancers are supported.  

-   Unicast mode is the default and recommended mode for NLB.  

-   Changing policies outside of the DirectAccess management console or PowerShell cmdlets is not supported.  

-   When NLB or an external load balancer is used, the IPHTTPS prefix cannot be changed to anything other than \/59.  

-   The load balanced nodes must be in the same IPv4 subnet.  

-   In ELB deployments, if manage out is needed, then DirectAccess clients cannot use&nbsp;Teredo. Only IPHTTPS can be used for end\-to\-end communication.  

-   Ensure all known NLB\/ELB hotfixes are installed.  

-   ISATAP in the corporate network is not supported. If you are using ISATAP, you should remove it and use native IPv6.  

## In this scenario  
The cluster deployment scenario includes a number of steps:  

1.  [Deploy an Always on VPN server with Advanced options](../../vpn/always-on-vpn/deploy/always-on-vpn-adv-options.md). A single Remote Access server with advanced settings must be deployed before setting up a cluster deployment.  

2.  [Plan a Remote Access Cluster Deployment](plan/Plan-a-Remote-Access-Cluster-Deployment.md). To build a cluster from a single server deployment a number of additional steps are required, including preparing certificates for the cluster deployment.  

3.  [Configure a Remote Access Cluster](configure/Configure-a-Remote-Access-Cluster.md). This consists of a number of configuration steps, including preparing the single server for Windows NLB or the external load balancer, preparing additional servers to join the cluster, and enabling load balancing.  

## <a name="BKMK_APP"></a>Practical applications  
Gathering multiple servers into a server cluster provides the following:  

-   Scalability. A single Remote Access server provides a limited level of server reliability and scalable performance. By grouping the resources of two or more servers into a single cluster, you increase the capacity for number of users and throughput.  

-   High availability. A cluster provides high availability for always\-on access. If one server in the cluster fails, remote users can continue to access the corporate network via a different server in the cluster. All servers in the cluster have the same set of cluster virtual IP \(VIP\) addresses, while still maintaining a unique, dedicated IP addresses for each server.  

-   Ease\-of\-management. A cluster allows management of multiple servers as a single entity. Shared settings can easily be set across cluster server. Remote Access settings can be managed from any of the servers in the cluster, or remotely using Remote Server Administration Tools \(RSAT\). In addition, the entire cluster can be monitored from a single Remote Access Management console.  

## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features required for the scenario:  

|Role\/feature|How it supports this scenario|  
|---------|-----------------|  
|Remote Access role|The role is installed and uninstalled using the Server Manager console. It encompasses both DirectAccess, which was previously a feature in Windows Server 2008 R2, and Routing and Remote Access Services \(RRAS\), which was previously a role service under the Network Policy and Access Services \(NPAS\) server role. The Remote Access role consists of two components:<br /><br />-   Always On VPN and Routing and Remote Access Services \(RRAS\) VPN-DirectAccess and VPN are managed together in the Remote Access Management console.<br />-   RRAS Routing-RRAS routing features are managed in the legacy Routing and Remote Access console.<br /><br />Dependencies are as follows:<br /><br />-   Internet Information Services \(IIS\) Web Server - This feature is required to configure the network location server and default web probe.<br />-   Windows Internal Database-Used for local accounting on the Remote Access server.|  
|Remote Access Management Tools feature|This feature is installed as follows:<br /><br />-   It is installed by default on a Remote Access server when the Remote Access role is installed, and supports the Remote Management console user interface.<br />-   It can be optionally installed on a server not running the Remote Access server role. In this case it is used for remote management of a Remote Access computer running DirectAccess and VPN.<br /><br />The Remote Access Management Tools feature consists of the following:<br /><br />-   Remote Access GUI and Command Line Tools<br />-   Remote Access module for Windows PowerShell<br /><br />Dependencies include:<br /><br />-   Group Policy Management Console<br />-   RAS Connection Manager Administration Kit \(CMAK\)<br />-   Windows PowerShell 3.0<br />-   Graphical Management Tools and Infrastructure|  
|Network Load Balancing|This feature provides load balancing in a cluster using Windows NLB.|  

## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  

-   At least two computers that meet the hardware requirements for Windows Server 2012.  

-   For the External Load Balancer scenario, dedicated hardware is required \(i.e. F5 BigIP\).  

-   In order to test the scenario, you must have at least one computer running Windows 10 configured as an Always On VPN client.   

## <a name="BKMK_SOFT"></a>Software requirements  
There are a number of requirements for this scenario:  

-   Software requirements for single server deployment. For more information see [Deploy a Single DirectAccess Server with Advanced Settings](../../directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md). A single Remote Access).  

-   In addition to software requirements for a single server there are a number of cluster\-specific requirements:  

    -   On each cluster server the IP\-HTTPS certificate subject name must match the ConnectTo address. A cluster deployment supports a mix of wildcard and non\-wildcard certificates on cluster servers.  

    -   If the network location server is installed on the Remote Access server, on each cluster server the network location server certificate must have the same subject name. In addition, the name of the network location server certificate must not have the same name as any server in the DirectAccess deployment.  

    -   IP\-HTTPS and network location server certificates must be issued using the same method with which the certificate to the single server was issued. For example, if the single server uses a public certification authority \(CA\) then all servers in the cluster must have a certificate issued by a public CA. Or if the single server uses a self\-signed certificate for IP\-HTTPS then all servers in the cluster must do likewise.  

    -   The IPv6 prefix assigned to DirectAccess client computers on server clusters must be 59 bits. If VPN is enabled, the VPN prefix must also be 59 bits.  

## <a name="KnownIssues"></a>Known issues  
The following are known issues when configuring a cluster scenario:  

-   After configuring DirectAccess in an IPv4\-only deployment with a single network adapter, and after the default DNS64 \(the IPv6 address which contains ":3333::"\) is automatically configured on the network adapter, attempting to enable load\-balancing via the Remote Access Management console causes a prompt for the user to supply an IPv6 DIP. If an IPv6 DIP is supplied, the configuration fails after clicking **Commit** with the error: The parameter is incorrect.  

    To resolve this issue:  

    1.  Download the backup and restore scripts from [Back up and Restore Remote Access Configuration](https://gallery.technet.microsoft.com/Back-up-and-Restore-Remote-e157e6a6).  

    2.  Back up your Remote Access GPOs using the downloaded script Backup\-RemoteAccess.ps1  

    3.  Attempt to enable load balancing until the step at which it fails. On the Enable Load Balancing dialog box, expand the details area, right\-click in the details area, and then click **Copy Script**.  

    4.  Open Notepad, and paste the contents of the clipboard. For example:  

        ```  
        Set-RemoteAccessLoadBalancer -InternetDedicatedIPAddress @('10.244.4.19 /255.255.255.0','fdc4:29bd:abde:3333::2/128') -InternetVirtualIPAddress @('fdc4:29bd:abde:3333::1/128', '10.244.4.21 /255.255.255.0') -ComputerName 'DA1.domain1.corp.contoso.com' -Verbose  
        ```  

    5.  Close any open Remote Access dialog boxes and close the Remote Access Management console.  

    6.  Edit the pasted text and remove the IPv6 addresses. For example:  

        ```  
        Set-RemoteAccessLoadBalancer -InternetDedicatedIPAddress @('10.244.4.19 /255.255.255.0') -InternetVirtualIPAddress @('10.244.4.21 /255.255.255.0') -ComputerName 'DA1.domain1.corp.contoso.com' -Verbose  
        ```  

    7.  In an elevated PowerShell window, run the command from the previous step.  

    8.  If the cmdlet fails while it is running \(not due to incorrect input values\), run the command Restore\-RemoteAccess.ps1 and follow instructions to make sure that the integrity of your original configuration is maintained.  

    9. You can now open the Remote Access Management console again.  

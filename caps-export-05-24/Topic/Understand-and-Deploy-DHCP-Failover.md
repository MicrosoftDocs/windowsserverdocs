---
title: Understand and Deploy DHCP Failover
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c2dfa9e-c4aa-4607-b498-d481a45b265a
---
# Understand and Deploy DHCP Failover
DHCP failover is a new feature available in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] ensuring continuous availability of DHCP service to clients.  
  
With DHCP failover, two DHCP servers share DHCP scope and lease information, enabling one server to provide DHCP leases to DHCP clients if the other server is unavailable.  
  
![](../Image/DHCP_failover-symbol.gif)  
  
This guide provides an overview of DHCP failover, including deployment information, and steps to migrate from split scope or clustered DHCP to DHCP failover.  
  
## DHCP high availability options  
In [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] and previous operating systems, two high availability options are available for DHCP server deployment:  
  
-   **DHCP in a Windows failover cluster**. This option places a DHCP server in a cluster with another DHCP server that assumes the load if the primary DHCP server fails. The clustering deployment option uses a single shared storage. The storage unit is a single point of failure, and requires an additional investment to achieve redundancy. Clustering can be relatively complex to configure and maintain.  
  
-   **Split scope DHCP**. Split scope DHCP uses two independent DHCP servers that share responsibility for a scope. Typically, 70% of the addresses in the scope are assigned to the primary server and the remaining 30% are assigned to a backup server. If clients cannot reach the primary server then they can acquire an IP address lease from the secondary server. Split scope deployment does not provide IP address continuity and is unusable in scenarios where the DHCP scope is already running with high address space utilization, a common scenario for IPv4 addressing.  
  
In [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and later operating systems, a new DHCP high availability option is also available:  
  
-   **DHCP failover**. DHCP failover provides redundancy and load balancing for DHCP services, enabling administrators to deploy a highly resilient DHCP service. With DHCP failover, Internet Protocol version 4 \(IPv4\) scopes with associated leases, reservations, options, and settings, are shared by two Windows DHCP servers. DHCP failover supports large scale DHCP deployments without the challenges of split scope and clustered DHCP.  
  
    Benefits of DHCP failover include:  
  
    -   **Simple**: A wizard is provided to create DHCP failover relationships between DHCP servers. The wizard automatically replicates scopes and settings from the primary server to the failover partner.  
  
    -   **Flexible**: DHCP failover can be configured to provide redundancy in hot standby mode, or with load balancing mode, client requests can be distributed between two DHCP servers.  
  
    -   **Seamless**: DHCP servers share lease information, allowing one server to assume responsibility for servicing of clients if the other server is unavailable. DHCP clients can keep the same IP address when a lease is renewed, even if the lease is issued by a different DHCP server.  
  
    -   **Muti\-site**: DHCP failover supports a deployment architecture that includes multiple sites. DHCP failover partner servers do not need to be located at the same physical site.  
  
> [!NOTE]  
> Microsoft’s implementation of DHCP failover is based on the Internet Engineering Task Force \(IETF\) [DHCP Failover Protocol](http://www.ietf.org/proceedings/59/I-D/draft-ietf-dhc-failover-12.txt) draft.  
  
## In this guide  
The following topics are available in this guide:  
  
|Topic|Description|  
|---------|---------------|  
|[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)|An overview of DHCP failover.|  
|[DHCP Failover Relationships](../Topic/DHCP-Failover-Relationships.md)|Details about how two DHCP servers share scope information and settings.|  
|[DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md)|Information about the two types of deployment options for DHCP failover.|  
|[DHCP Failover Communications](../Topic/DHCP-Failover-Communications.md)|Information about messaging between DHCP failover partner servers.|  
|[DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md)|Details about individual settings used for DHCP failover.|  
|[DHCP Failover Examples](../Topic/DHCP-Failover-Examples.md)|Examples of how DHCP failover works to maintain network continuity for DHCP clients during a service outage.|  
|[DHCP Failover Events and Performance](../Topic/DHCP-Failover-Events-and-Performance.md)|Information about new DHCP failover related events and performance counters.|  
|[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)|DHCP failover design information and configuration steps.|  
|[DHCP Failover Requirements](../Topic/DHCP-Failover-Requirements.md)|Software and hardware requirements to deploy DHCP failover.|  
|[DHCP Failover Architecture](../Topic/DHCP-Failover-Architecture.md)|Design options for DHCP failover.|  
|[Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md)|A list of steps to deploy DHCP failover.|  
|[Configure DHCP Failover using the Command Line](../Topic/Configure-DHCP-Failover-using-the-Command-Line.md)|Procedures to configure and deploy DHCP failover with Windows PowerShell.|  
|[Configure DHCP Failover using the DHCP Console](../Topic/Configure-DHCP-Failover-using-the-DHCP-Console.md)|Procedures to configure and deploy DHCP failover.|  
|[Replicate DHCP Failover Using the Command Line](../Topic/Replicate-DHCP-Failover-Using-the-Command-Line.md)|Procedures to replicate DHCP settings between DHCP failover servers using Windows PowerShell.|  
|[Replicate DHCP Failover Using the DHCP Console](../Topic/Replicate-DHCP-Failover-Using-the-DHCP-Console.md)|Procedures to replicate DHCP settings between DHCP failover servers using the DHCP console.|  
|[Migrate to DHCP Failover](../Topic/Migrate-to-DHCP-Failover.md)|Steps and recommendations to migrate from spit scope or clustered DHCP to DHCP failover.|  
  
## See Also  
[Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md)  
  

---
title: IPAM Deployment Planning
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 389a1c20-ee7c-4d38-9bdb-42f613094e63
---
# IPAM Deployment Planning
IPAM is an agentless multi\-server, multi\-service management feature that leverages standard Windows remote management protocols to manage, monitor and collect data from IP address infrastructure servers. IPAM relies on a host of remote management technologies to provide full functionality. Communication with multiple network elements throughout the enterprise is required for data gathering and configuration management. Depending on the scope of managed elements, this communication may need to traverse multiple security boundaries or domains.  
  
> [!NOTE]  
> IPAM must be installed on a domain member computer. You cannot install IPAM on a domain controller. If IPAM is installed on the same server with DHCP, then DHCP server discovery will be disabled.  
  
An IPAM server provides support for a single Active Directory forest. Multi\-forest topologies are not supported. Multiple IPAM servers can support a single domain, or a single IPAM server can support all domains in an Active Directory forest.  
  
## In this topic  
  
-   [Deployment topologies](../Topic/IPAM-Deployment-Planning.md#topologies)  
  
-   [Hardware and software requirements](../Topic/IPAM-Deployment-Planning.md#hard_soft)  
  
-   [IPAM specifications](../Topic/IPAM-Deployment-Planning.md#specifications)  
  
-   [Capacity planning](../Topic/IPAM-Deployment-Planning.md#capacity)  
  
## <a name="topologies"></a>Deployment topologies  
IPAM supports the following topologies for deployment in the enterprise:  
  
-   **Distributed**: An IPAM server deployed at every site in the enterprise.  
  
-   **Centralized**: One IPAM server in the enterprise.  
  
-   **Hybrid**: A central IPAM server deployed with dedicated IPAM servers at each site.  
  
The following diagram illustrates an example of the hybrid deployment model.  
  
![](../Image/IPAM_deploy-model.png)  
  
There is no automatic built\-in communication or database sharing between different IPAM servers. If multiple IPAM servers are deployed, you can customize the scope of discovery for each IPAM server, or filter the list of managed servers.  
  
If desired, you can leverage export and import functions in Windows PowerShell for IPAM to periodically update IP address range and address information between multiple IPAM servers.  
  
You can also customize the role of different IPAM servers that are deployed. For example, a single IPAM server might be implemented to manage IP addressing for the entire enterprise. A different IPAM server might be used to monitor DNS zone health or configure DHCP scopes. Alternatively, you can limit the discovery and management scope to create a dedicated IPAM server that will perform all functions but only for a specific group of managed servers. The scope of management assigned to an IPAM server is flexible and can be updated if the need arises by adding or removing managed servers and domains.  
  
## <a name="hard_soft"></a>Hardware and software requirements  
IPAM Server must be installed on a computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or a later operating system. IPAM Client must be installed on a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], or a later operating system. To install IPAM Client on a computer running a client operating system, you must first install the Remote Server Administration Tools \(RSAT\). Each client operating system has its own version of RSAT, for example:  
  
-   [Remote Server Administration Tools \(RSAT\) for Windows 8](http://www.microsoft.com/download/details.aspx?id=28972) are required to manage [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [Remote Server Administration Tools \(RSAT\) for Windows 8.1](http://www.microsoft.com/download/details.aspx?id=39296) are required to manage [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
**Active Directory**: An IPAM server must be joined to a domain as a domain member server. Installation in a workgroup environment is not supported, and installation on a domain controller is not supported.  
  
**Network**: An IPAM server requires a functional networking environment that includes IPv4 and IPv6 network connectivity to integrate with existing network services in the Active Directory forest. Server discovery requires that network settings on the IPAM server be configured to provide access to at least one domain controller and authoritative DNS server. Discovery of IPv6 address space requires that IPv6 is enabled on the IPAM server. The IPAM server must also have network connectivity to all servers that are marked as managed in the server inventory.  
  
**Other roles or features**: An IPAM server is intended as a single\-purpose server. It is not recommended to collocate other network infrastructure roles such as DNS or DHCP on the same server. IPAM installation is not supported on a domain controller, and discovery of DHCP servers will be disabled if you install IPAM on a server that is also running the DHCP Server service. The following features and tools are automatically installed when you install IPAM Server.  
  
|Feature or Tool|Description|  
|-------------------|---------------|  
|Remote Server Administration Tools|DHCP and DNS Server Tools and IP Address Management \(IPAM\) Client provides for remotely managing DHCP, DNS and IPAM servers.|  
|Windows Internal Database|Windows Internal Database is a relational data store that can be used only by Windows roles and features.|  
|Windows Process Activation Service|Windows Process Activation Service generalizes the IIS process model, removing the dependency on HTTP.|  
|Group Policy Management|Group Policy Management is a scriptable Microsoft Management Console \(MMC\), providing a single administrative tool for managing Group Policy.|  
|.NET Framework 4.5 Features|.NET Framework 4.5 provides a programming model for building and running applications designed for several different platforms.|  
  
The following are the minimum and recommended hardware requirements for IPAM Server.  
  
|Component|Requirement|  
|-------------|---------------|  
|Processor|Minimum: 1.4 GHz \(x64 processor\)<br /><br />Recommended: quad\-core, 2.66 GHz or faster|  
|Memory|Minimum: 2 GB RAM<br /><br />Recommended: 4 GB RAM or greater|  
|Disk Space|Minimum: 10 GB<br /><br />Recommended: 80 GB or greater**\***|  
  
**\***Use a fast storage device to host the IPAM database \(on the root drive\) to significantly improve IPAM performance.  
  
Actual hardware requirements will vary based on the number of managed servers that are monitored and managed by the IPAM server.  
  
## <a name="specifications"></a>IPAM specifications  
IPAM Server has the following specifications:  
  
1.  The scope of IPAM server discovery is limited to a single Active Directory forest. The forest itself may be comprised of a mix of trusted and untrusted domains.  
  
2.  IPAM supports only Microsoft domain controllers, DHCP, DNS, and NPS servers running [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and above.  
  
3.  DHCP operational event auditing is supported for DHCP servers running [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] and above.  
  
4.  IPAM installation on a DHCP server is not recommended. The IPAM server discovery feature will not be able to discover DHCP roles if DHCP Server is installed on the same computer.  
  
5.  IPAM supports only domain joined DHCP, DNS and NPS servers in a single Active Directory forest.  
  
6.  IPAM does not support management and configuration of non\-Microsoft network elements.  
  
7.  IPAM does not support external databases. Only a Windows Internal Database is supported.  
  
8.  A single IPAM server can support up to 150 DHCP servers and 500 DNS servers.  
  
9. A single IPAM server has been tested to support up to 6000 DHCP scopes and 150 DNS zones.  
  
10. IPAM stores 3 years of forensics data \(IP address leases, host MAC addresses, user login\/logoff information\) for 100,000 users in a Windows Internal Database. There is no database purge policy provided, and the administrator must purge data manually as needed.  
  
11. IP address utilization trends are provided only for IPv4.  
  
12. IP address reclaiming support is provided only for IPv4.  
  
13. No special processing is done for IPv6 stateless address auto configuration private extensions.  
  
14. No special processing for virtualization technology or virtual machine migration.  
  
15. IPAM does not check for IP address consistency with routers and switches.  
  
16. IPAM does not support auditing of IPv6 stateless address auto configuration on an unmanaged machine to track the user.  
  
17. IPAM users must be logged in using domain credentials. Do not log sign in to the IPAM server using the local Administrator account or another local user account on the IPAM server.  
  
18. If you are accessing the IPAM server from a remote IPAM client, you must be a member of the **WinRMRemoteWMIUsers** group on the IPAM server, in addition to being a member of the appropriate local IPAM security group.  
  
19. If the Group Policy based provisioning method is used, users must have domain administrator privileges to mark servers as managed or unmanaged in the server inventory.  
  
## <a name="capacity"></a>Capacity planning  
When planning disk space requirements and determining the number of IPAM servers to use on your network, consider the following questions:  
  
1.  How many IP address ranges will be managed by IPAM?  
  
2.  How many DHCP\-enabled devices are connected to the network?  
  
If the number of IP address ranges that you plan to manage with IPAM is less than 20,000 each for IPv4 and IPv6, you can deploy a single IPAM server to manage your IP address space. This is assuming a typical IP address range prefix is \/24 for IPv4 and \/64 for IPv6.  
  
However, you might wish to deploy more than one IPAM server to manage an expanding network. For example, if the organization has 30,000 IP address ranges and is increasing in size, you should deploy at least two IPAM servers. You might also plan to deploy more than one IPAM server if you will assign specific roles to different servers or you will deploy IPAM in a distributed or hybrid topology. For more information, see [Plan Your IPAM Deployment](../Topic/Plan-Your-IPAM-Deployment.md).  
  
### Planning disk capacity  
IPAM uses several data collection tasks to gather data from managed servers. This data includes information such as DHCP scopes, DHCP scope utilization, DNS zones, DNS zone events, DHCP lease logs, IPAM and DHCP configuration events, and network authentication events. Data collection tasks run in background and regularly update the local IPAM database, increasing its size. The IPAM database is located on the system root drive \(the operating system drive\), therefore it is important to ensure enough disk space is available on the system root drive to accommodate this data.  
  
> [!NOTE]  
> For purposes of planning disk capacity, a system lifetime of 5 years is assumed.  
  
Disk space requirements for the IPAM database can be evaluated based on three categories of stored data:  
  
1.  **Base database size**: This is the disk space required to hold IP address blocks, IP address ranges, IP address records, custom fields, DHCP configuration data, DHCP scopes, and other static managed server information. This type of data doesn’t increase over time; it grows only when more records are created in IPAM by administrators or if new managed servers are added. You should allocate 1.0 GB of free space on the root drive to accommodate this data.  
  
2.  **Utilization data**: IPAM keeps a track of utilization for IP address blocks, IP address ranges and DHCP scopes by periodically sampling and storing utilization statistics for these items. Each sample is stored in the local IPAM database to enable graphical display of utilization trends. The amount of data collected and stored depends on the number of IP address ranges in the system. Monthly usage is about 1.0 GB of data for every 10,000 IP address ranges. There is no simple method for clearing or purging utilization data from the system. Therefore, you should plan disk space consumption for a period of 5 years or the anticipated system lifetime. For example, if your IPAM server will manage 2000 IP Address ranges for a period of 5 years, you must allocate 1\*5\*12 \= 60 GB of disk space on the system root drive to accommodate utilization data.  
  
    |\# of IP Address Ranges|Disk Space Required|  
    |---------------------------|-----------------------|  
    |10,000 or less|1 GB \/ month|  
    |10,001 to 20,000|2 GB \/ month|  
    |20,001 to 40,000|3 GB \/ month|  
  
3.  **Event catalog data**: IPAM collects DHCP lease logs, DHCP configuration events, IPAM configuration events, and authentication events from all managed NPS servers and domain controllers. Depending on the size of your network, this data can require several GB of disk space. The amount of disk space required for storing event catalog data depends upon frequency at which these events occur on the network. To calculate disk space requirements for event catalog data, you must estimate the number of events per month together with the length of time you wish to maintain these events in IPAM database. Approximately 0.6 GB of free disk space is required for one million events.  
  
    For example, on a network with 2500 users where each user has a laptop, a desktop, and a smart phone, you can allocate 4 IP addresses to each user: one IP address each for the desktop computer, one for the phone and two for the laptop \(wired \+ wireless\). This means you will have about 10,000 IP addresses to manage. Also, assuming that a DHCP lease on wireless interfaces will be renewed every 8 hours and every 4 days on wired interfaces, you can expect three lease events per day \(24\/8\) for the wireless devices and one lease event on a wired interface in 4 days. Over a period of four days you can estimate a total of 2500\*2\*3\*4 \(wireless\) \+ 2500\*2\*1\*4 \(wired\) \= 80,000 DHCP lease events corresponding to 80000\*30\/4 \=600000 DHCP lease events per month.  
  
    Similarly, if you have 2500 users on the network, and expect each user to login, lock, and unlock their device 20 times per day, you can expect 2500\*20\*22 \= 1100000 user authentication events per month \(assuming 22 working days in month\). This corresponds to 600000\+1100000\= 1700000 records per month. To retain data initially for six months, and then purge three month old data on a quarterly basis, the disk must be able to store 1700000\*6 \= 10200000 records, corresponding to 0.6\*10200000\/1000000\= 6.12 GB of disk space.  
  
    > [!NOTE]  
    > These calculations do not take into account DHCP and IPAM configuration change events, machine authentication events, and DHCP events such as granting and expiration of leases. These events do not typically impact disk space requirements. However, you can take these events into consideration if required.  
  
To calculate overall disk space requirements, use the following formula:  
  
**Disk space** \= **Base database size** \+ **Utilization data** \+ **Event catalog data**  
  
In the example used previously, a network with 2500 users will require 1 GB \+ 60 GB \+ 6.12 GB \= 67.12 GP of free disk space for the IPAM database, storing utilization data for 5 years.  
  
|Organization Size|Base Size|Utilization Data|Event Catalog Data|Total|  
|---------------------|-------------|--------------------|----------------------|---------|  
|25,000 users|1 GB|60 GB|59 GB|120 GB|  
|50,000 users|1 GB|60 GB|117 GB|178 GB|  
|100,000 users|1 GB|60 GB|234 GB|295 GB|  
  
Assumptions:  
  
-   4 IP addresses are allocated per user.  
  
-   All IP addresses are issued by managed DHCP servers. Half of the IP addresses are wireless with leases refreshing every 8 hours; the other half are wired interfaces with leases refreshing every 4 days.  
  
-   Each user generates 20 domain controller authentication events and 1 NPS authentication event per working day.  
  
-   Event catalog data is purged every three months. Data is initially collected for 6 months and then three month old data is purged quarterly.  
  
-   There is an average of 22 working days per month.  
  
For information about purging event catalog data, see [EVENT CATALOG](../Topic/Using-the-IPAM-Client-Console.md#event_catalog).  
  
## See also  
[What is IPAM?](../Topic/What-is-IPAM-.md)  
  
[IPAM Terminology](../Topic/IPAM-Terminology.md)  
  
[Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md)  
  
[IPAM Architecture](../Topic/IPAM-Architecture.md)  
  
[IPAM Backup and Restore](../Topic/IPAM-Backup-and-Restore.md)  
  

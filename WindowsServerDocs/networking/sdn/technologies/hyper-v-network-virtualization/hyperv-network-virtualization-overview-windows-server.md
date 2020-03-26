---
title: Hyper-V Network Virtualization Overview in Windows Server 2016
description: This topic provides an overview of Hyper-V Network Virtualization in Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0115b7ad-d229-4c69-9d7e-a3f5fbaa3b2f
ms.author: lizross
author: eross-msft
---
# Hyper-V Network Virtualization Overview in Windows Server 2016

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In Windows Server 2016 and Virtual Machine Manager, Microsoft provides an end-to-end network virtualization solution.  There are five major components that comprise Microsoft's network virtualization solution:  

-   **Windows Azure Pack for Windows Server** provides a tenant facing portal to create virtual networks, and an administrative portal to manage virtual networks.  

-   **Virtual Machine Manager** (VMM) provides centralized management of the network fabric.  

-   **Microsoft Network Controller** provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter.  

-   **Hyper-V Network Virtualization** provides the infrastructure needed to virtualize network traffic.  

-   **Hyper-V Network Virtualization gateways** provide connections between virtual and physical networks.  

This topic introduces concepts and explains the key benefits and capabilities of Hyper-V Network Virtualization (one part of the overall network virtualization solution) in Windows Server 2016. It explains how network virtualization benefits both private clouds looking for enterprise workload consolidation and public cloud service providers of Infrastructure as a Service (IaaS).  

For more technical details about networking virtualization in Windows Server 2016, see [Hyper-V Network Virtualization Technical Details in Windows Server 2016](../../../sdn/technologies/hyper-v-network-virtualization/hyperv-network-virtualization-technical-details-windows-server.md).  

**Did you mean**  

-   [Hyper-V Network Virtualization Overview](assetId:///bf1dba9d-1960-4dd2-a5e2-99466a02044b) ( Windows Server 2012 R2 )  

-   [Hyper-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  

-   [Hyper-V Virtual Switch Overview](assetId:///e6ec46af-6ef4-49b3-b1f1-5268dc03f05b)  

## <a name="BKMK_OVER"></a>Feature description  
Hyper-V Network Virtualization provides "virtual networks" (called a VM network) to virtual machines similar to how server virtualization (hypervisor) provides "virtual machines" to the operating system. Network virtualization decouples virtual networks from the physical network infrastructure and removes the constraints of VLAN and hierarchical IP address assignment from virtual machine provisioning. This flexibility makes it easy for customers to move to IaaS clouds and efficient for hosters and datacenter administrators to manage their infrastructure, while maintaining the necessary multi-tenant isolation, security requirements, and supporting overlapping Virtual Machine IP addresses.  

Customers want to seamlessly extend their datacenters to the cloud. Today there are technical challenges in making such seamless hybrid cloud architectures. One of the biggest hurdles customers face is reusing their existing network topologies (subnets, IP addresses, network services, and so on.) in the cloud and bridging between their on-premises resources and their cloud resources.  Hyper-V Network Virtualization provides the concept of a VM Network that is independent of the underlying physical network. With this concept of a VM Network, composed of one or more Virtual Subnets, the exact location in the physical network of virtual machines attached to a virtual network is decoupled from the virtual network topology. As a result, customers can easily move their virtual subnets to the cloud while preserving their existing IP addresses and topology in the cloud so that existing services continue to work unaware of the physical location of the subnets. That is, Hyper-V Network Virtualization enables a seamless hybrid cloud.  

In addition to hybrid cloud, many organizations are consolidating their datacenters and creating private clouds to internally get the efficiency and scalability benefit of cloud architectures. Hyper-V Network Virtualization allows better flexibility and efficiency for private clouds by decoupling a business unit's network topology (by making it virtual) from the actual physical network topology. In this way, the business units can easily share an internal private cloud while being isolated from each other and continue to keep existing network topologies. The datacenter operations team has flexibility to deploy and dynamically move workloads anywhere in the datacenter without server interruptions providing better operational efficiencies and an overall more effective datacenter.  

For workload owners, the key benefit is that they can now move their workload "topologies" to the cloud without changing their IP addresses or re-writing their applications. For example, the typical three-tier LOB application is composed of a front end tier, a business logic tier, and a database tier. Through policy, Hyper-V Network Virtualization allows customer onboarding all or parts of the three tiers to the cloud, while keeping the routing topology and the IP addresses of the services (i.e. virtual machine IP addresses), without requiring the applications to be changed.  

For infrastructure owners, the additional flexibility in virtual machine placement makes it possible to move workloads anywhere in the datacenters without changing the virtual machines or reconfiguring the networks. For example Hyper-V Network Virtualization enables cross subnet live migration so that a virtual machine can live migrate anywhere in the datacenter without a service disruption. Previously live migration was limited to the same subnet restricting where virtual machines could be located. Cross subnet live migration allows administrators to consolidate workloads based on dynamic resource requirements, energy efficiency, and can also accommodate infrastructure maintenance without disrupting customer workload up time.  

## <a name="BKMK_APP"></a>Practical applications  
With the success of virtualized datacenters, IT organizations and hosting providers (providers who offer colocation or physical server rentals) have begun offering more flexible virtualized infrastructures that make it easier to offer on-demand server instances to their customers. This new class of service is referred to as Infrastructure as a Service (IaaS). Windows Server 2016 provides all the required platform capabilities to enable enterprise customers to build private clouds and transition to an IT as a service operational model. Windows Server 2016 2016 also enables hosters to build public clouds and offer IaaS solutions to their customers. When combined with Virtual Machine Manager and Windows Azure Pack to manage Hyper-V Network Virtualization policy, Microsoft provides a powerful cloud solution.  

Windows Server 2016 Hyper-V Network Virtualization provides policy-based, software-controlled network virtualization that reduces the management overhead faced by enterprises when they expand dedicated IaaS clouds, and it provides cloud hosters better flexibility and scalability for managing virtual machines to achieve higher resource utilization.  

An IaaS scenario that has virtual machines from different organizational divisions (dedicated cloud) or different customers (hosted cloud) requires secure isolation. Today's solution, virtual local area networks (VLANs), can present significant disadvantages in this scenario.  

**VLANs**  

Currently, VLANs are the mechanism that most organizations use to support address space reuse and tenant isolation. A VLAN uses explicit tagging (VLAN ID) in the Ethernet frame headers, and it relies on Ethernet switches to enforce isolation and restrict traffic to network nodes with the same VLAN ID. The main disadvantages with VLANs are as follows:  

-   Increased risk of an inadvertent outage due to cumbersome reconfiguration of production switches whenever virtual machines or isolation boundaries move in the dynamic datacenter.  

-   Limited in scalability because there is a maximum of 4094 VLANs and typical switches support no more than 1000 VLAN IDs.  

-   Constrained within a single IP subnet, which limits the number of nodes within a single VLAN and restricts the placement of virtual machines based on physical locations. Even though VLANs can be expanded across sites, the entire VLAN must be on the same subnet.  

**IP address assignment**  

In addition to the disadvantages that are presented by VLANs, virtual machine IP address assignment presents issues, which include:  

-   Physical locations in datacenter network infrastructure determine virtual machine IP addresses. As a result, moving to the cloud typically requires changing IP addresses of the service workloads.  

-   Policies are tied to IP addresses, such as firewall rules, resource discovery and directory services, and so on. Changing IP addresses requires updating all the associated policies.  

-   Virtual machine deployment and traffic isolation are dependent on the topology.  

When datacenter network administrators plan the physical layout of the datacenter, they must make decisions about where subnets will be physically placed and routed. These decisions are based on IP and Ethernet technology that influence the potential IP addresses that are allowed for virtual machines running on a given server or a blade that is connected to a particular rack in the datacenter. When a virtual machine is provisioned and placed in the datacenter, it must adhere to these choices and restrictions regarding the IP address. Therefore, the typical result is that the datacenter administrators assign new IP addresses to the virtual machines.  

The problem with this requirement is that in addition to being an address, there is semantic information associated with an IP address. For instance, one subnet may contain given services or be in a distinct physical location. Firewall rules, access control policies, and IPsec security associations are commonly associated with IP addresses. Changing IP addresses forces the virtual machine owners to adjust all their policies that were based on the original IP address. This renumbering overhead is so high that many enterprises choose to deploy only new services to the cloud, leaving legacy applications alone.  

Hyper-V Network Virtualization decouples virtual networks for customer virtual machines from the physical network infrastructure. As a result, it enables customer virtual machines to maintain their original IP addresses, while allowing datacenter administrators to provision customer virtual machines anywhere in the datacenter without reconfiguring physical IP addresses or VLAN IDs. The next section summarizes the key functionality.  

## <a name="BKMK_NEW"></a>Important functionality  
The following is a list of the key functionality, benefits, and capabilities of Hyper-V Network Virtualization in Windows Server 2016:  

-   **Enables flexible workload placement - Network isolation and IP address re-use without VLANs**  

    Hyper-V Network Virtualization decouples the customer's virtual networks from the physical network infrastructure of the hosters, providing freedom for workload placements inside the datacenters. Virtual machine workload placement is no longer limited by the IP address assignment or VLAN isolation requirements of the physical network because it is enforced within Hyper-V hosts based on software-defined, multitenant virtualization policies.  

    Virtual machines from different customers with overlapping IP addresses can now be deployed on the same host server without requiring cumbersome VLAN configuration or violating the IP address hierarchy. This can streamline the migration of customer workloads into shared IaaS hosting providers, allowing customers to move those workloads without modification, which includes leaving the virtual machine IP addresses unchanged. For the hosting provider, supporting numerous customers who want to extend their existing network address space to the shared IaaS datacenter is a complex exercise of configuring and maintaining isolated VLANs for each customer to ensure the coexistence of potentially overlapping address spaces. With Hyper-V Network Virtualization, supporting overlapping addresses is made easier and requires less network reconfiguration by the hosting provider.  

    In addition, physical infrastructure maintenance and upgrades can be done without causing a down time of customer workloads. With Hyper-V Network Virtualization, virtual machines on a specific host, rack, subnet, VLAN, or entire cluster can be migrated without requiring a physical IP address change or major reconfiguration.  

-   **Enables easier moves for workloads to a shared IaaS cloud**  

    With Hyper-V Network Virtualization, IP addresses and virtual machine configurations remain unchanged. This enables IT organizations to more easily move workloads from their datacenters to a shared IaaS hosting provider with minimal reconfiguration of the workload or their infrastructure tools and policies. In cases where there is connectivity between two datacenters, IT administrators can continue to use their tools without reconfiguring them.  

-   **Enables live migration across subnets**  

    Live migration of virtual machine workloads traditionally has been limited to the same IP subnet or VLAN because crossing subnets required the virtual machine's guest operating system to change its IP address. This address change breaks existing communication and disrupts the services running on the virtual machine. With Hyper-V Network Virtualization, workloads can be live migrated from servers running Windows Server 2016 in one subnet to servers running Windows Server 2016 in a different subnet without changing the workload IP addresses. Hyper-V Network Virtualization ensures that virtual machine location changes due to live migration are updated and synchronized among hosts that have ongoing communication with the migrated virtual machine.  

-   **Enables easier management of decoupled server and network administration**  

    Server workload placement is simplified because migration and placement of workloads are independent of the underlying physical network configurations. Server administrators can focus on managing services and servers, and network administrators can focus on overall network infrastructure and traffic management. This enables datacenter server administrators to deploy and migrate virtual machines without changing the IP addresses of the virtual machines. There is reduced overhead because Hyper-V Network Virtualization allows virtual machine placement to occur independently of network topology, reducing the need for network administrators to be involved with placements that might change the isolation boundaries.  

-   **Simplifies the network and improves server/network resource utilization**  

    The rigidity of VLANs and the dependency of virtual machine placement on a physical network infrastructure results in overprovisioning and underutilization. By breaking the dependency, the increased flexibility of virtual machine workload placement can simplify the network management and improve server and network resource utilization. Note that Hyper-V Network Virtualization supports VLANs in the context of the physical datacenter. For example, a datacenter may want all Hyper-V Network Virtualization traffic to be on a specific VLAN.  

-   **Is compatible with existing infrastructure and emerging technology**  

    Hyper-V Network Virtualization can be deployed in today's datacenter, yet it is compatible with emerging datacenter "flat network" technologies.  

    For example, HNV in Windows Server 2016 supports the VXLAN encapsulation format and the Open vSwitch Database Management Protocol (OVSDB) as the SouthBound Interface (SBI)..  

-   **Provides for interoperability and ecosystem readiness**  

    Hyper-V Network Virtualization supports multiple configurations for communication with existing resources, such as cross premise connectivity, storage area network (SAN), non-virtualized resource access, and so on. Microsoft is committed to working with ecosystem partners to support and enhance the experience of Hyper-V Network Virtualization in terms of performance, scalability, and manageability.  

-   **Policy-based configuration**  

    Network virtualization policies in Windows Server 2016 are configured through the Microsoft Network Controller. The network controller has a RESTful northbound API, and Windows PowerShell interface to configure policy. For more information about the Microsoft Network Controller, see [Network Controller](../../../sdn/technologies/network-controller/../../../sdn/technologies/network-controller/Network-Controller.md).  

## <a name="BKMK_SOFT"></a>Software requirements  
Hyper-V Network Virtualization using the Microsoft Network Controller requires Windows Server 2016 and the Hyper-V role.  

## <a name="BKMK_LINKS"></a>See also  
To learn more about Hyper-V Network Virtualization in Windows Server 2016 see the following links:  


|       Content type       |                                                                                                                                References                                                                                                                                |
|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Community Resources**  |     -   [Private Cloud Architecture Blog](https://blogs.technet.com/b/privatecloud/archive/2012/03/19/cloud-datacenter-network-architecture-in-the-windows-server-8-era.aspx)<br />-   Ask questions: [cloudnetfb@microsoft.com](mailto:%20cloudnetfb@microsoft.com)     |
|         **RFC**          |                                                                                                     -   VXLAN - [RFC 7348](https://www.rfc-editor.org/info/rfc7348)                                                                                                      |
| **Related Technologies** | -   [Network Controller](../../../sdn/technologies/network-controller/../../../sdn/technologies/network-controller/Network-Controller.md)<br />-   [Hyper-V Network Virtualization Overview](assetId:///bf1dba9d-1960-4dd2-a5e2-99466a02044b) ( Windows Server 2012 R2 ) |


---
title: Network Controller with Failover Clustering on Windows Server and Azure Local
description: Learn about Network Controller high availability using Failover Clustering for Software Defined Networking (SDN) in Windows Server and Azure Local.
author: robinharwood
ms.author: roharwoo
ms.topic: concept-article 
ms.date: 12/06/2024
zone_pivot_groups: windows-os
#Customer intent: As a network administrator, I want to understand how Network Controller works with Failover Clustering so that I can deploy and manage my tenant network configurations.

---

# Network Controller with Failover Clustering

:::zone pivot="windows-server"

Beginning with Windows Server 2025 Software Defined Networking infrastructure uses a smaller footprint for the Network Controller (NC), one of the core infrastructural components. NC can now be deployed directly on the host as a Failover Clustering service. Service Fabric based infrastructure continues to be supported. This article provides an overview of Network Controller high availability using Failover Clustering, how it works with Software Load Balancer and Gateways, and how it differs from Network Controller on Service Fabric.

:::zone-end

:::zone pivot="azure-local"

Beginning with Azure Local 2311.2, Software Defined Networking infrastructure uses a smaller footprint for the Network Controller (NC), one of the core infrastructural components. NC can now be deployed directly on the host as a Failover Clustering service. Service Fabric based infrastructure continues to be supported. This article provides an overview of Network Controller high availability using Failover Clustering, how it works with Software Load Balancer and Gateways, and how it differs from Network Controller on Service Fabric.

:::zone-end

## Network Controller as a role

Network Controller is a key component of the SDN ecosystem. It allows you to deploy and manage your tenant network configurations, including virtual networking, logical networking, and network security. In previous versions of Windows Server and Azure Local, Network Controller had to be hosted inside a VM. VM-based resource deployment is a long and resource-intensive. VMs took up more CPU and Memory, resources that could be spent on your core application workloads. Beginning with Windows Server 2025 and Azure Local 2311.2, the NC service will be natively integrated with the host machine using Failover Clustering, freeing up resources for your other workloads. The following illustration provides an overview of the key differences between NC on Service Fabric and NC on Failover Clustering.

:::image type="content" source="../../../media/network-controller-failover-cluster/failover-cluster-service-fabric-comparison.png" alt-text="A diagram comparing the differences between Network Controller with Failover Clustering and Network Controller with Service Fabric." lightbox="../../../media/network-controller-failover-cluster/failover-cluster-service-fabric-comparison.png":::

## Architecture

With Network Controller on Failover Clustering, all the Network Controller microservices are now contained in a failover cluster resource group. SDN microservices use a single database and single partition, rather than three databases duplicated across 3 VMs when using Service Fabric. With each SDN microservice as a Failover Clustering resource group, there’s a significant reduction in CPU utilization and storage.

Network Controller and all its services are set as a Failover Cluster group set across the servers in your Software Defined Networking cluster. For example, your network topology includes four servers clustered together with a single Top-of-Rack (ToR) Switch, and the Network Controller component as a _Failover Clustering Generic Resource_ is spread across all servers. Instead of the three VMs in previous versions, each Network Controller microservice is highly available as a Failover Cluster Resource Group. The following diagram shows a 4-node deployment with Network Controller on Failover Clustering.

:::image type="content" source="../../../media/network-controller-failover-cluster/concept.png" alt-text="A diagram showing a 4-node deployment with Network Controller on Failover Clustering" lightbox="../../../media/network-controller-failover-cluster/concept.png":::

The resource group has the same provisioning requirements as NC VMs. The API Microservice requires a floating IP address in your management network and DNS registration is still supported.

## High Availability

With Network Controller on Failover Clustering, resource ownership is associated with a specific node within the Failover Cluster. When a server goes down, resource groups are transferred to another node within the cluster. Replication of data is done through the underlying infrastructure of Failover Clustering which is Storage Replica. To learn more about Failover Clustering and Storage Replica, see the following resources:

:::zone pivot="windows-server"

- [Failover Clustering in Windows Server and Azure Local](../../../../failover-clustering/failover-clustering-overview.md)
- [Storage Replica Overview](../../../../storage/storage-replica/storage-replica-overview.md)

:::zone-end

:::zone pivot="azure-local"

- [Failover Clustering in Windows Server and Azure Local](../../../../failover-clustering/failover-clustering-overview.md?context=/azure-local/context/context)
- [Storage Replica Overview](../../../../storage/storage-replica/storage-replica-overview.md?context=/azure-local/context/context)

:::zone-end

## Software Load Balancing and Gateways

This transition from Service Fabric to Failover Clustering only affects our Network Controlling services. Other network function virtualization roles, such as the Software Load Balancer and Gateway are still hosted on Virtual Machines. Network Controller on Failover Clustering doesn't affect the behavior  or operation of other network function virtualization roles. For more details on Software Load Balancing and Gateways, visit the following links:

- [What is Software Load Balancer (SLB) for SDN?](/azure/azure-local/concepts/software-load-balancer)

- [What is Remote Access Service (RAS) Gateway for Software Defined Networking?](/azure/azure-local/concepts/gateway-overview)

## Next steps

:::zone pivot="windows-server"

Start deploying Network Controller with Failover Clustering in your Software Defined Networking environment, see [Deploy Network Controller with Failover Clustering](../../deploy/deploy-network-controller-failover-clustering.md).

To learn more about the requirements and configuration options, see [Plan a SDN Deployment](/azure/azure-local/concepts/plan-software-defined-networking-infrastructure).

:::zone-end

:::zone pivot="azure-local"

Start deploying Network Controller with Failover Clustering in your Software Defined Networking environment, see [Deploy Network Controller with Failover Clustering](../../deploy/deploy-network-controller-failover-clustering.md?context=/azure-local/context/context).

To learn more about the requirements and configuration options, see [Plan a SDN Deployment](/azure/azure-local/concepts/plan-software-defined-networking-infrastructure?context=/azure-local/context/context).

:::zone-end

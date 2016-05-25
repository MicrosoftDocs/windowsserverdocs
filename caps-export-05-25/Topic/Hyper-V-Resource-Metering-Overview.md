---
title: Hyper-V Resource Metering Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a8a93dcb-0bb0-4172-9bf0-d25bddf11b4a
author: cwatsonmsft
---
# Hyper-V Resource Metering Overview
IT organizations need tools to charge back business units that they support while providing the business units with the right amount of resources to match their needs. For hosting providers, it is equally important to issue chargebacks based on the amount of usage by each customer.  
  
To implement advanced billing strategies that measure both the assigned capacity of a resource and its actual usage, earlier versions of Hyper\-V required users to develop their own chargeback solutions that polled and aggregated performance counters. These solutions could be expensive to develop and sometimes led to loss of historical data.  
  
To assist with more accurate, streamlined chargebacks while protecting historical information, Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces Resource Metering, a feature that allows customers to create cost\-effective, usage\-based billing solutions. With this feature, service providers can choose the best billing strategy for their business model, and independent software vendors can develop more reliable, end\-to\-end chargeback solutions on top of Hyper\-V.  
  
## Key benefits  
Hyper\-V Resource Metering in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] allows organizations to avoid the expense and complexity associated with building in\-house metering solutions to track usage within specific business units. It enables hosting providers to quickly and cost\-efficiently create a more advanced, reliable, usage\-based billing solution that adjusts to the provider's business model and strategy.  
  
## Use of network metering port ACLs  
Enterprises pay for the Internet traffic in and out of their data centers, but not for the network traffic within their data centers. For this reason, providers generally consider Internet and intranet traffic separately for the purposes of billing. To differentiate between Internet and intranet traffic, providers can measure incoming and outgoing network traffic for any IP address range, by using network metering port ACLs.  
  
## Virtual machine metrics  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides two options for administrators to obtain historical data on a client's use of virtual machine resources: Hyper\-V cmdlets in Windows PowerShell and the new APIs in the Virtualization WMI provider. These tools expose the metrics for the following resources used by a virtual machine during a specific period of time:  
  
-   Average CPU usage, measured in megahertz over a period of time.  
  
-   Average physical memory usage, measured in megabytes.  
  
-   Minimum memory usage \(lowest amount of physical memory\).  
  
-   Maximum memory usage \(highest amount of physical memory\).  
  
-   Maximum amount of disk space allocated to a virtual machine.  
  
-   Total incoming network traffic, measured in megabytes, for a virtual network adapter.  
  
-   Total outgoing network traffic, measured in megabytes, for a virtual network adapter.  
  
Movement of virtual machines between Hyper\-V hosts—for example, through live, offline, or storage migrations—does not affect the collected data.  
  
## See Also  
[How to use Resource Metering with PowerShell](http://blogs.technet.com/b/virtualization/archive/2012/08/20/how-to-use-resource-metering-with-powershell.aspx)  
  

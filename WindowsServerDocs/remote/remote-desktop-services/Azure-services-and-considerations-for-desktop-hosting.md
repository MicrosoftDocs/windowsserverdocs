---
title: Azure services and considerations for desktop hosting
description: Learn about considerations unique to Azure with a Remote Desktop hosting solution.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f402ae3-5391-4c7d-afea-2c5c9044de46
author: lizap
manager: dongill
---
# Azure services and considerations for desktop hosting

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following sections describe Azure Infrastructure Services.  
  
##  Azure portal  
After the provider creates an Azure subscription, the Azure portal can be used to manually create each tenant's environment. This process can also be automated using PowerShell Scripts.  
  
Additional information:  
[Microsoft Azure](https://www.azure.microsoft.com)  
  
##  Azure Load Balancer  
The tenant's components run on virtual machines that communicate with each other on an isolated network. During the deployment process, these virtual machines can be accessed externally through the Azure Load Balancer using Remote Desktop Protocol endpoints or Remote PowerShell endpoint. Once a deployment is complete, these endpoints will typically be deleted to reduce the attack surface area. The only endpoints will be the HTTPS and UDP endpoints created for the VM running the RD Web and RD Gateway components. This allows clients on the Internet to connect to sessions running in the tenant's desktop hosting service. If a user opens an application that connects to the Internet, such as Internet Explorer Web browser, the connections will be passed through the Azure Load Balancer.  
  
[Microsoft Azure: Load Balancing Virtual Machines](https://azure.microsoft.com/documentation/articles/virtual-machines-linux-load-balance/)  
  
##  Security Considerations  
This Azure Desktop Hosting Reference Architecture Guide is designed to provide a highly secure and isolated environment for each tenant. The security of the system also depends on safeguards taken by the provider during deployment and operation of the hosted service. Following is a list of some mitigations that the provider must consider to help ensure the security of a desktop hosting solution based on this reference architecture.  
- All administrative passwords must be strong, and ideally randomly generated, changed frequently, and saved in secure central location that is only accessible by a select few provider administrators.  
- Care must be taken when replicating the tenant environment for new tenants to avoid using the same or weak administrative passwords.   
- The RD Web Access site URL, name, and certificates must be unique and recognizable to each tenant to mitigate spoofing attacks.  
- During the normal operation of the desktop hosting service, all public IP addresses should be deleted for all VMs except the RD Web and RD Gateway VM that allow users to securely connect to the tenant's desktop hosting cloud service. Public IP addresses may be temporarily added to allow management tasks to be performed but should always be deleted.  
  
Additional information:  
[Security and Protection Overview](https://technet.microsoft.com/library/hh831778.aspx)  
[Security Best Practices for IIS 8](https://technet.microsoft.com/library/jj635855.aspx)  
[Secure Windows Server 2012 R2](https://technet.microsoft.com/library/hh831360.aspx)  
  
##  Design Considerations  
Microsoft Azure Infrastructure Services have a number of constraints that must be considered when designing a multitenant desktop hosting service. The following is a list of some constraints that the provider must consider to achieve a functional and cost effective desktop hosting solution based on this reference architecture.  
  
- An Azure subscription has a maximum number of virtual networks, VM cores, and Cloud Services that can be used. Consequently, providers may need to create multiple subscriptions.   
- An Azure Cloud Service has a maximum number of VMs that can be used. Consequently, providers may need to create multiple Cloud Services for larger tenants.  
- The cost of Azure deployments are based partially on the number of VMs and the size of the VMs. Consequently, the provider should optimize the number and size of the VMs for each tenant to provide a functional and highly secure Desktop Hosting environment at the lowest cost.  
- The physical computer resources in the Azure data center are virtualized by using Hyper-V. The Hyper-V hosts are not configured in host clusters so the availability of the virtual machines is dependent on the availability of the individual servers used in the Azure infrastructure. To provide higher availability, multiple instances of each role service VM can be created in an availability set and then guest clustering can be implemented within the VMs.  
- In a typical storage configuration, a service provider will have a single storage account with multiple containers (e.g. one for each tenant), and multiple disks within each container. However, there are constraints on the total storage and performance that can be achieved for a single storage account. For service providers that support large numbers of tenants or tenants with requirements for large storage capacity and/or high performance, the service provider may need to create multiple storage accounts.  
  
Additional information:  
[Cloud Service Sizes for Microsoft Azure](https://azure.microsoft.com/documentation/articles/cloud-services-sizes-specs/)  
[Microsoft Azure Virtual Machine Pricing Details](https://azure.microsoft.com/pricing/details/virtual-machines/)  
[Hyper-V Overview](https://technet.microsoft.com/library/hh831531)  
[Microsoft Azure Storage Abstractions and their Scalability Targets](https://technet.microsoft.com/library/hh831531)  



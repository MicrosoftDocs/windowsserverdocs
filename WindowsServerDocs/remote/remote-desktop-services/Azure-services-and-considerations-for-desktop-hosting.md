---
title: Azure services and considerations for desktop hosting
description: Learn about considerations unique to Azure with a Remote Desktop hosting solution.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 07/06/2018
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f402ae3-5391-4c7d-afea-2c5c9044de46
author: heidilohr
manager: lizross
---
# Azure services and considerations for desktop hosting

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

The following sections describe Azure Infrastructure Services.
  
## Azure portal

After the provider creates an Azure subscription, the Azure portal can be used to manually create each tenant's environment. This process can also be automated using PowerShell scripts.  

For more information, visit the [Microsoft Azure](https://www.azure.microsoft.com) website.
  
## Azure Load Balancer

The tenant's components run on virtual machines that communicate with each other on an isolated network. During the deployment process, you can externally access these virtual machines through the Azure Load Balancer using Remote Desktop Protocol endpoints or a Remote PowerShell endpoint. Once a deployment is complete, these endpoints will typically be deleted to reduce the attack surface area. The only endpoints will be the HTTPS and UDP endpoints created for the virtual machine running the RD Web and RD Gateway components. This allows clients on the internet to connect to sessions running in the tenant's desktop hosting service. If a user opens an application that connects to the internet, such as a web browser, the connections will be passed through the Azure Load Balancer.  
  
For more information, see [What is Azure Load Balancer?](https://azure.microsoft.com/documentation/articles/virtual-machines-linux-load-balance/)
  
## Security considerations

This Azure Desktop Hosting Reference Architecture Guide is designed to provide a highly secure and isolated environment for each tenant. System security also depends on safeguards taken by the provider during deployment and operation of the hosted service. The following list describes some considerations the provider should take to keep their desktop hosting solution based on this reference architecture secure.

- All administrative passwords must be strong, ideally randomly generated, changed frequently, and saved in a secure central location only accessible to a select few provider administrators.  
- When replicating the tenant environment for new tenants, avoid using the same or weak administrative passwords.
- The RD Web Access site URL, name, and certificates must be unique and recognizable to each tenant to prevent spoofing attacks.  
- During the normal operation of the desktop hosting service, all public IP addresses should be deleted for all virtual machines except the RD Web and RD Gateway virtual machine that lets users securely connect to the tenant's desktop hosting cloud service. Public IP addresses may be temporarily added when necessary for management tasks, but they should always be deleted afterwards.  
  
For more information, see the following articles:

- [Security and protection](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831778(v=ws.11))  
- [Security best practices for IIS 8](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj635855(v=ws.11))  
- [Secure Windows Server 2012 R2](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831360(v=ws.11))  
  
## Design considerations

It's important to consider the constraints of Microsoft Azure Infrastructure Services when designing a multitenant desktop hosting service. The following list describes considerations the provider must take to achieve a functional and cost-effective desktop hosting solution based on this reference architecture.  
  
- An Azure subscription has a maximum number of virtual networks, VM cores, and Cloud Services that can be used. If a provider needs more resources than this, they may need to create multiple subscriptions.
- An Azure Cloud Service has a maximum number of virtual machines that can be used. The provider may need to create multiple Cloud Services for larger tenants that exceed the maximum.  
- Azure deployment costs are based partially on the number and size of virtual machines. The provider should optimize the number and size of the virtual machines for each tenant to provide a functional and highly secure Desktop Hosting environment at the lowest cost.  
- The physical computer resources in the Azure data center are virtualized by using Hyper-V. Hyper-V hosts are not configured in host clusters, so the availability of the virtual machines is dependent on the availability of the individual servers used in the Azure infrastructure. To provide higher availability, multiple instances of each role service virtual machine can be created in an availability set, then guest clustering can be implemented within the virtual machines.  
- In a typical storage configuration, a service provider will have a single storage account with multiple containers (for example, one for each tenant), and multiple disks within each container. However, there is a limit to the total storage and performance that can be achieved for a single storage account. For service providers that support large numbers of tenants or tenants with high storage capacity or performance requirements, the service provider may need to create multiple storage accounts.  
  
For more information, see the following articles:

- [Sizes for Cloud Services](https://docs.microsoft.com/azure/cloud-services/cloud-services-sizes-specs)  
- [Microsoft Azure virtual machine pricing details](https://azure.microsoft.com/pricing/details/virtual-machines/)  
- [Hyper-V overview](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831531(v=ws.11))  
- [Azure Storage scalability and performance targets](https://docs.microsoft.com/azure/storage/common/storage-scalability-targets)  

## Azure Active Directory Application Proxy

Azure Active Directory (AD) Application Proxy is a service provided in paid SKUs of Azure AD that allow users to connect to internal applications through Azure's own reverse-proxy service. This allows the RD Web and RD Gateway endpoints to be hidden inside of the virtual network, eliminating the need to be exposed to the internet by a public IP address. Hosters can use Azure AD Application Proxy to condense the number of virtual machines in the tenant's environment while still maintaining a full deployment. Azure AD Application Proxy also enables many of the benefits that Azure AD provides, such as conditional access and multi-factor authentication.

For more information, see [Get started with Application Proxy and install the connector](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy-enable).
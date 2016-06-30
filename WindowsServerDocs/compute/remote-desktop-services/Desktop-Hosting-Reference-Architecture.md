---
title: Desktop Hosting Reference Architecture
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1bac5dd3-8430-46ee-8bef-10cc4b7cc437
author: lizap
manager: msswadhwa
---
# Desktop Hosting Reference Architecture

>Applies To: Windows Server Technical Preview

This article defines a set of architectural blocks for using Remote Desktop Services (RDS) and Microsoft Azure virtual machines to create multitenant, hosted Windows desktop and application services, which we call "desktop hosting." You can use this architecture reference to create highly secure, scalable, and reliable desktop hosting solutions for small- and medium-sized organizations with 5 to 5000 users.    
  
The primary audience for this reference architecture are hosting providers who want to leverage Microsoft Azure Infrastructure Services to deliver desktop hosting services and Subscriber Access Licenses (SALs) to multiple tenants via the [Microsoft Service Provider Licensing Agreement](http://www.microsoft.com/hosting/en/us/licensing/splabenefits.aspx) (SPLA) program. A second audience for this reference architecture are end customers who want to create and manage desktop hosting solutions in Microsoft Azure Infrastructure Services for their own employees using [RDS User CALs extended rights through Software Assurance](http://download.microsoft.com/download/6/B/A/6BA3215A-C8B5-4AD1-AA8E-6C93606A4CFB/Windows_Server_2012_R2_Remote_Desktop_Services_Licensing_Datasheet.pdf) (SA).   
  
To deliver a desktop hosting solutions, hosting partners and SA customers leverage Windows Server and the Windows Desktop Experience feature to deliver Windows users an application experience that is familiar to business users and consumers. Although Windows 8.1, Windows 7, and earlier Windows client versions are not licensed for hosting environments with shared hardware, the Desktop Experience feature in Windows Server 2012 R2 provides a similar user experience and application support.    
  
The scope of this document is limited to:   
  
* Architectural design guidance for a desktop hosting service. Detailed information, such as deployment procedures, performance, and capacity planning is explained in separate documents. For more general information about Azure Infrastructure Services, see [Microsoft Azure Virtual Machines](https://azure.microsoft.com/documentation/services/virtual-machines/).   
  
* Session-based desktops, RemoteApp applications, and server-based personal desktops that use Windows Server 2016 Remote Desktop Session Host (RD Session Host). Windows client-based virtual desktop infrastructures are not covered because there is no Service Provider License Agreement (SPLA) for Windows client operating systems. Windows Server-based virtual desktop infrastructures are allowed under the SPLA, and Windows client-based virtual desktop infrastructures are allowed on dedicated hardware with end-customer licenses in certain scenarios. However, client-based virtual desktop infrastructures are out-of-scope for this document.   
  
* Microsoft products and features, primarily Windows Server 2016 and Microsoft Azure Infrastructure Services.   
  
* Desktop hosting services for tenants ranging in size from 5 to 5000 users.   For larger tenants, you may need to modify this architecture to provide adequate performance. The Server Manager RDS graphical user interface (GUI) is not recommended for deployments over 500 users. PowerShell is recommended for managing RDS deployments between 500 and 5000 users.   
  
* The minimum set of components and services required for a desktop hosting service. There are many optional components and services that can be added to enhance a desktop hosting service, but these are out-of-scope for this document.    
  
After reading this document, the reader should understand:   
- The building blocks that are necessary to provide a secure, reliable, multitenant desktop hosting solution based in Microsoft Azure Services.  
- The purpose of each building block and how they fit together.  
  
There are multiple ways to build a desktop hosting solution based on this architecture. This architecture outlines integration and improvements in Azure with Windows Server 2016. Other deployment options are available with the [Desktop Hosting Reference Architecture Guide](https://technet.microsoft.com/library/mt404690.aspx) for Windows Server 2012R2.    
  
The following topics are covered:  
- [Desktop hosting logical architecture](Desktop-hosting-logical-architecture.md)  
- [Desktop hosting service](Desktop-hosting-service.md)  
- [Azure services for desktop hosting](Azure-services-for-desktop-hosting.md)  
- [Tenant on-premises components](Tenant-on-premises-components.md)  
  
 



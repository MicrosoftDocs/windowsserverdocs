---
title: Create virtual machines for Remote Desktop
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b0f62d6f-0915-44ca-afef-be44a922e20e
author: lizap
manager: msswadhwa
---
# Create virtual machines for Remote Desktop

>Applies To: Windows Server Technical Preview

Use the following steps to create the virtual machines in the tenant's environment that will be used to run the Windows Server 2016 roles, services, and features required for a desktop hosting deployment.   
  
For this example of a basic deployment, the minimum of 3 virtual machines will be created. One virtual machine will host the Remote Desktop (RD) Connection Broker and License Server role services and a file share for the deployment. A second virtual machine will host the RD Gateway and Web Access role services.  A third virtual machine host the RD Session Host role service. For very small deployments, you can reduce VM costs by using AAD App Proxy to eliminate all public endpoints from the deployment and combining all the role services onto a single VM. For larger deployments, you can install the various role services on individual virtual machines to allow better scaling.  
  
This section outlines the steps necessary to deploy virtual machines for each role based on Windows Server images in the [Microsoft Azure Marketplace](https://azure.microsoft.com/marketplace/). If you need to create virtual machines from a custom image—which requires PowerShell, check out out [Create a Windows VM with Resource Manager and PowerShell](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-ps-create/). Then return here to attach Azure data disks for the file share and enter an external URL for your deployment.  
  
1.  [Create Windows virtual machines](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-hero-tutorial/) to host the RD Connection Broker, RD License Server, and File server.  
  
    For our purpose, we used the following naming conventions:  
    - RD Connection Broker and License Server:   
        - VM: Contoso-Cb1  
        - Availability set: CbAvSet    
    - RD Web Access and RD Gateway Server:   
        - VM: Contoso-WebGw1  
        - Availability set: WebGwAvSet  
          
    - RD Session Host:   
        - VM: Contoso-SH1  
        - Availability set: ShAvSet  
          
    Each VM uses the same resource group.  
2.  Create and attach an Azure data disk for the user profile disk (UPD) share:  
    1.  In the Azure portal click **Browse > Virtual machines**, and then click the VM created for the RD Connection Broker (for example, Contoso-Cb1).  
    2.  Click **Settings > Disks > Attach new**.  
    3.  Accept the defaults for name and type.  
    4.  Enter a size (in GB) that is large enough to hold network shares for the tenant's environment, including user profile disks and certificates. You can approximate 5 GB per user you plan to have  
    5.  Accept the defaults for location and host caching, and then click **OK**.  
3.  Enter an external URL/DNS name for your deployment to access it externally:  
    1.  In the Azure portal, click **Browse > Virtual machines**, and then click the VM you created created for RD Web Access and RD Gateway (for example, Contoso-WebGw1).  
    2.  Click **Public IP address/DNS name** in the **Essentials** pane.  
    3.  Click **Settings > Configuration**.  
    4.  Enter a DNS name label (like contoso), and then click **Save**. This DNS name label (contoso.westus.cloudapp.azure.com) is the DNS name that you'll use to connect to your RD Web Access and RD Gateway server.  



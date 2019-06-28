---
title: Seamlessly deploy RDS with ARM and Azure Marketplace
description: Learn how to create a small RDS deployment in Azure by using ARM templates and the Azure Marketplace.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5f72ceb6-6f90-48f6-bfc3-bdad63984ce7
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 02/10/2017
---
# Seamlessly deploy RDS with ARM and Azure Marketplace

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

Remote Desktop Services (RDS) is the platform of choice to cost-effectively host Windows desktops and applications. You can use an [Azure Marketplace offering](#basic-rds-through-the-azure-marketplace) or a [quickstart template](#customized-rds-using-quickstart-templates) to quickly create an RDS on Azure IaaS deployment. Azure marketplace creates a test domain for you, making it a simple and easy mechanism for testing and proof-of-concepts. The quickstart templates, on the other hand, allow you to use an existing domain, making them a great tool to build out a production environment. Once set up, you can connect to the published desktops and applications from various platforms and devices, using the Microsoft Remote Desktop apps for Windows, Mac, iOS, and Android.

## Basic RDS through the Azure Marketplace

Creating your deployment through the Azure Marketplace is the quickest way to get up and running. When everything is completed, your environment will look like the [basic RDS architecture](desktop-hosting-logical-architecture.md#basic-deployment). The offering creates all the RDS components that you need - all you need to do is supply some information. 

You'll need to supply the following information when you deploy the Marketplace offering:
- Administrator user name and password. This is a new user that will manage the deployment.
- DNS name and AD domain name. These are NEW resources that are created. Make sure the names are meaningful.
- VM size. You get to choose the size of VMs to use for the RDSH endpoints. You can also manually change the sizes after the initial deployment to help you optimize the VMs for your workloads and for cost.

Use these steps to create your small-footprint RDS deployment from the Azure Marketplace: 

1. Launch the Azure Marketplace RDS deployment:
   1. Sign into the [Azure portal](https://portal.azure.com).
   2. Click **New** to add your deployment.
   3. Type "RDS" in the search field and press Enter.
   4. Click **Remote Desktop Services (RDS) - Basic - Dev/Test**, and then click **Create**.
   5. Follow the steps in the portal to create and deploy RDS. You'll add key configuration details, like the information listed above. 
2. Connect to your deployment. When the deployment finishes, check the outputs section for final steps to complete and connect to your deployment.
   1. Download and run [this PowerShell script](https://gallery.technet.microsoft.com/Azure-Resource-Manager-4ea7e328) on your test device to install any certificates needed to connect to the RDS deployment. 
   
      This step is only necessary during the testing phase. When you deploy RDS in Azure in production, make sure to follow best practices like purchasing and using a publicly trusted SSL certificate on your web servers.

   2. When prompted, sign into your Azure account. Select the Azure subscription, resource group, and public IP address created for this new deployment.
   3. When the script is finished, the RD Web page launches in your default browser. You can double-check the RD Web page by comparing the URL for the page to the DNS address you provided during deployment. 
   
      Sign in with the admin credentials you created during deployment to see the default desktop published for you. You can also send users the RD Web site to test their desktops and applications.

      > [!TIP]
      > Forget the domain name or admin user? You can go back to the new Resource Group in the portal, click **Deployments**, and then view the parameters you entered.

Now that you have an RDS deployment, you can [add and manage users](rds-user-management.md).

## Customized RDS using Quickstart templates

You can use Azure Resource Manager templates to deploy RDS in Azure. This is especially useful if you want a basic RDS deployment but have existing components (like AD) that you want to use. Unlike the Marketplace offering, you can make further customizations, such as using an existing AD on a virtual network, using a custom OS image for the RDSH VMs, and layering on high availability for RDS components. After adding on high availability to each component, your environment will look like the [highly availabile RDS architecture](desktop-hosting-logical-architecture.md#highly-available-deployment).

Use these steps to create your small-footprint RDS deployment with an Azure RDS template: 

1. Pick your Azure Quickstart template:
   1. Go to the [RDS Azure Quickstart Templates](https://aka.ms/rdautomation) site.
   2. Choose the template that matches what you are trying to do. Make sure you meet any prerequisites for that specific template. (For example, if you are want to use a custom image for your VMs, make sure you have already uploaded that image to an Azure storage account.)
   3. Click **Deploy to Azure**.
   4. You'll need to provide some details (like admin user name, AD domain name) in the Azure portal. This varies based on the template you choose.
   5. Click **Purchase**.
2. Connect to your deployment. 
   1. Download and run [this PowerShell script](https://gallery.technet.microsoft.com/Azure-Resource-Manager-4ea7e328) on your test device to install any certificates needed to connect to the RDS deployment. 
   
      This step is only necessary during the testing phase. When you deploy RDS in Azure in production, make sure to follow best practices like purchasing and using a publicly trusted SSL certificate on your web servers.

   2. When prompted, sign into your Azure account. Select the Azure subscription, resource group, and public IP address created for this new deployment.
   3. When the script is finished, the RD Web page launches in your default browser. You can double-check the RD Web page by comparing the URL for the page to the DNS address you provided during deployment. 
   
      Sign in with the admin credentials you created during deployment to see the default desktop published for you. You can also send users the RD Web site to test their desktops and applications.

      > [!TIP]
      > Forget the domain name or admin user? You can go back to the new Resource Group in the portal, click **Deployments**, and then view the parameters you entered.

Now that you have an RDS deployment, you can [add and manage users](rds-user-management.md).

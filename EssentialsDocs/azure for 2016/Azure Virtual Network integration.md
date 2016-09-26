---
title: "Azure Virtual Network integration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: affff774-5fa6-4944-887a-9bfde05f6a3f
caps.latest.revision: 25
author: nnamuhcs
ms.author: coreyp
---

>Applies To: Windows Server 2016 Essentials

Azure Virtual Network integration
---------------------------------

As organizations make their way to cloud computing, rarely will they move all of their resources 100% at one time, but rather take an approach where some resources are in the cloud and some are still on premises. This hybrid approach makes it easy for organizations to not only move some computing resources to the cloud, but also enables them to grow their IT infrastructure without having to acquire new hardware.

When implementing this hybrid approach to computing, a seamless way for resources in both locations to communicate with one another is required. Azure Virtual Networking is an Azure service that enables organizations to create a point-to-point (P2P) or site-to-site (S2S) virtual private network that makes the resources that are running in Azure (such as virtual machines and storage) look as though they are on the local network for seamless application and resource access.

Configuration of an Azure Virtual Network can be complex. With Windows Server Essentials 2016 we have introduced the ability to easily configure your Azure Virtual Network through a simple wizard that helps the user choose the most appropriate defaults for their networked environment. As shown in the screenshot below, a new Azure Virtual Network integration task has been added to the Microsoft Cloud Services section of the Windows Essentials dashboard to introduce Azure Virtual Networking to the user as well as provide a quick link to initiate the integration.

<img src="./media/image1.PNG" width="505" height="252" />

A screenshot showing the Get Started tab on the Home page of the Windows Server Essentials dashboard. On the Get Started tab, the Services section has been selected, and the dashboard indicates under Microsoft Cloud Services Integration that Azure Virtual Network is currently disabled.

Upon clicking on the Integrate Now link for Azure Virtual Networking in the above screenshot, a dialog box will appear asking you log in to your Microsoft Azure account. If you do not have a Microsoft Azure account, you will have the option to sign-up for one at this screen, which will redirect the user to the Azure account sign-up portal:

<img src="./media/image2.PNG" width="376" height="306" />

A screenshot showing the Sign In To Microsoft Azure page of the Integrating With Azure Virtual Network wizard.

Once signing-in to Azure, the user will be presented with the option to choose which subscription they want to associate with the Azure Virtual Networking service:

<img src="./media/image3.PNG" width="375" height="304" />G05xx03.png

A screenshot showing the My Microsoft Azure Subscription page of the Integrating with Azure Virtual Network wizard

Once the user has chosen which Azure subscription they want to use for Azure Virtual Networking, they will be presented with the option to create a new Azure Virtual Network, or if one already has been setup under this subscription, the drop-down box will show it is available. The user will also choose a name for the Local Network that the Azure Virtual Network will use to identify resources in the local network of the user. Lastly, the user will choose which Azure Region they want their Azure Virtual Network to be hosted. Choosing a location that is physically nearest to the user’s local network is typically best for optimizing bandwidth speed for communicating with resources the user may host in their Azure services:

<img src="./media/image4.PNG" width="376" height="306" />

A screenshot showing the Set Up Azure Virtual Network page of the Integrating With Azure Virtual Network wizard.

The last step of the integration process is helping the user to setup the VPN device that will be used for the S2S VPN connection. Since most small businesses have only a few servers in their environment and lack the IT staff to properly configure a VPN Router to connect to Microsoft Azure, the default selection will be to setup the Windows Server Essentials server as the VPN server that resources in the user’s local network will connect to in order to access resources in the Azure Virtual Network. However, if the user would rather use another server in their environment as the VPN Server, or would rather user a VPN Router, they can select those options.

Due to the variation in router types and models, Windows Server Essentials does not attempt to automatically configure the VPN Router on behalf of the user. Selecting the VPN Router in this integration wizard only notifies Azure Virtual Networking of the device type for appropriate routing configurations necessary in Azure for connectivity.

Upon completing the integration wizard, a new tab will be visible in the Windows Server Essentials dashboard for Azure Virtual Networking:

<img src="./media/image5.PNG" width="491" height="243" />

A screenshot showing the Azure VNet page of the Windows Server Essentials dashboard. The Azure Virtual Network tab is selected and shows the status as Configuring.

Note that completing the configuration of an Azure Virtual Network in the cloud can take a long time, upwards to 30 minutes. During this time, the status of Configuring will be present in the Azure Virtual Network status page of the dashboard.

Once the configuration of the Azure Virtual Network is completed, the status will change to Connected and show the details of the user’s Azure Virtual Network such as data in/out, gateway IP address, local IP address and account details:

<img src="./media/image6.PNG" width="453" height="347" />

A screenshot showing the Azure VNet page of the Windows Server Essentials dashboard. The Azure Virtual Network tab is selected and shows the status as Connected, and under this status information the details of the virtual network are displayed.

In the tasks pane on the right side of the dashboard are the various tasks that the user can take with their Azure Virtual Network.

-   **Disconnect From Azure VNET** Setting up an Azure Virtual Network is free, but there is a charge for the VPN gateway that connects to on-premises and other VNETs in Azure. Disconnecting from the Azure VNET stops all billing.

-   **Switch Over VPN Device** In the event that the user wants to change from a VPN Server to a VPN Router, this task will enable the user to make the switch and notify the Azure VNET.

-   **Configure Azure VNET** This task allows the user to change advanced configuration options of the Azure VNET by redirecting them to the Azure portal configuration page for Azure VNET.

-   **Refresh Status** Refreshes the status page, updating the connection status of the Azure VNET including data in/out.

-   **Disable Azure VNET Integration** Disconnects the Azure VNET and removes integration from the Windows Server Essentials dashboard. Note this does not delete the Azure VNET, settings are still preserved in Azure if the user wants to later re-integrate Azure VNET with the dashboard.

-   **Learn More About Azure VNET** Link that takes the user to the public Azure site describing Azure Virtual Networking at <http://azure.microsoft.com/en-us/services/virtual-network/>.

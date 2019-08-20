---
title: Step 2 Plan the Basic DirectAccess Deployment
description: This topic is part of the guide Deploy a Single DirectAccess Server Using the Getting Started Wizard for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7ddcb162-dd92-406c-acab-d3de7239c644
ms.author: pashort
author: shortpatti
---
# Step 2 Plan the Basic DirectAccess Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

After planning the DirectAccess infrastructure, the next step in deploying DirectAccess on a single server with basic settings is to plan the settings for the Getting Started Wizard.  
  
|Task|Description|  
|----|--------|  
|Planning for client deployment|By default, the Getting Started Wizard deploys DirectAccess to all laptops and notebook computers in the domain by applying a WMI filter to the client settings GPO|  
|Planning for DirectAccess server deployment|Plan how to deploy the DirectAccess server.|  
  
## <a name="bkmk_2_1_client"></a>Planning for client deployment  
There are two decisions to make when planning your client deployment:  
  
1.  Will DirectAccess be available to mobile computers only, or to any computer?  
  
    When you configure DirectAccess clients in the Getting Started Wizard, you can choose to allow only mobile computers in the specified security groups to connect using DirectAccess. If you restrict access to mobile computers, DirectAccess automatically configures a WMI filter to ensure that the DirectAccess client GPO is applied only to mobile computers in the specified security groups. The DirectAccess administrator requires permissions to create or modify group policy WMI filters to enable this setting.  
  
2.  What security groups will contain the DirectAccess client computers?  
  
    DirectAccess settings are contained in the DirectAccess client GPO. The GPO is applied to computers that are part of the security groups that you specify in the Getting Started wizard. You can specify security groups contained in any supported domain. Before you configure DirectAccess, the security groups should be created. You can add computers to the security group after completing the DirectAccess deployment, but note that if you add client computers that reside in a different domain to the security group, the client GPO will not be applied to these clients. For example, if you created SG1 in domain A for DirectAccess clients, and later add clients from domain B to this group, the client GPO will not be applied to clients in domain B.  To avoid this issue, create a new client security group for each domain that contains client computers. Alternatively, if you do not want to create a new security group, run the Add-DAClient cmdlet with the name of the new GPO for the new domain.  
  
## <a name="bkmk_2_2_server"></a>Planning for DirectAccess server deployment  
There are a number of decisions to make when planning to deploy your DirectAccess server:  
  
-   **Network topology** -There are two topologies available when deploying a DirectAccess server:  
  
    -   **Two adapters** -With two network adapters, DirectAccess can be configured with one network adapter connected directly to the Internet, and the other is connected to the internal network. Or alternatively the server is installed behind an edge device such as a firewall or a router. In this configuration one network adapter is connected to the perimeter network, the other is connected to the internal network.  
  
    -   **Single network adapter** -In this configuration the DirectAccess server is installed behind an edge device such as a firewall or a router. The network adapter is connected to the internal network.  
  
-   **Network adapters** -The DirectAccess wizard automatically detects the network adapters configured on the DirectAccess server. You can make sure that the correct adapters are selected from the **Review** page.  
  
-   **IP-HTTPS certificate** -Since there is no PKI required in this deployment, the wizard automatically provisions self-signed certificates for IP-HTTPS and the Network Location Server (if no certificates are present), and automatically enables Kerberos proxy. The wizard also enables NAT64 and DNS64 for protocol translation in the IPv4-only environment. After the wizard successfully completes applying the configuration, click **Close**.  
  
-   **Windows 7 clients** -You cannot enable support for Windows 7 clients from the Getting Started wizard. This can be enabled from the Advanced Setup Wizard. For more details, see [Deploy a Single DirectAccess Server with Advanced Settings](../single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md).  
  
-   **VPN configuration** -Before you configure DirectAccess, decide if you are going to provide VPN access to remote clients. You should provide VPN access if you have client computers in your organization that do not support DirectAccess connectivity (either because they are unmanaged or run an operating system for which DirectAccess is not supported). The Getting Started Wizard configures VPN IP address assignment using DHCP and configures VPN clients to be authenticated using Active Directory.  
  
-   **Force Tunneling** -If you plan to use Force Tunneling, or might add it in the future, you should use [Deploy a Single DirectAccess Server with Advanced Settings](../single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md) to deploy a two tunnel configuration. Because of security considerations, Force Tunneling in a single tunnel configuration is not supported.  
  
## <a name="BKMK_Links"></a>Previous step  
  
-   [Step 1: Plan the Basic DirectAccess Infrastructure](da-basic-plan-s1-infrastructure.md)  
  



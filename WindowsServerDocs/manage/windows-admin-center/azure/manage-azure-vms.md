---
title: Manage Azure IaaS virtual machines
description: Managing Azure IaaS VMs with Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 09/07/2018
ms.localizationpriority: medium
ms.prod: windows-server
---

# Manage Azure IaaS virtual machines with Windows Admin Center

You can use Windows Admin Center to manage your Azure VMs as well as on-premises machines. There are several different configurations possible - choose the configuration that makes sense for your environment:
- [Manage Azure VMs from an on-premises Windows Admin Center gateway](#manage-with-an-on-premises-windows-admin-center-gateway)
- [Manage Azure VMs from a Windows Admin Center gateway installed on an Azure VM](#use-a-windows-admin-center-gateway-deployed-in-azure)

## Manage with an on-premises Windows Admin Center gateway

If you've already installed Windows Admin Center on an on-premises gateway (either on Windows 10 or Windows Server 2016), you can use this same gateway to manage Windows 10 or Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 VMs in Azure. 

### Connecting to VMs with a public IP

If your target VMs (the VMs you want to manage with Windows Admin Center) have public IPs, add them to your Windows Admin Center gateway by IP address, or by FQDN. There are a couple considerations to take into account:

- You must enable WinRM access to your target VM by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`
- If you haven't domain-joined the Azure VM, the VM behaves like a server in workgroup, so you'll need to make sure you account for [using Windows Admin Center in a workgroup](../support/troubleshooting.md#using-windows-admin-center-in-a-workgroup).
- You must also enable inbound connections to port 5985 for WinRM over HTTP in order for Windows Admin Center to manage the target VM:
  1. Run the following PowerShell script on the target VM to enable inbound connections to port 5985 on the guest OS:   
     `Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any`

  2. You must also open the port in Azure networking:

     - Select your Azure VM, select **Networking**, then **Add inbound port rule**. 
     - Ensure **Basic** is selected at the top of the **Add inbound security rule** pane.
     - In the **Port ranges** field, enter **5985**.
    
     If your Windows Admin Center gateway has a static IP, you can select to allow only inbound WinRM access from your Windows Admin Center gateway for added security.
     To do this, select **Advanced** at the top of the **Add inbound security rule** pane.

     For **Source**, select **IP Addresses**, then enter the Source IP address corresponding to your Windows Admin Center gateway.

     - For **Protocol** select **TCP**.
     - The rest can be left as default.

> [!NOTE]
> You must create a custom port rule. The WinRM port rule provided by Azure networking uses port 5986 (over HTTPS) instead of 5985 (over HTTP). 

### Connecting to VMs without a public IP

If your target Azure VMs don't have public IPs, and you want to manage these VMs from a Windows Admin Center gateway deployed in your on-premises network, you need to configure your on-premises network to have connectivity to the VNet on which the target VMs are connected. There are 3 ways you can do this: ExpressRoute, Site-to-Site VPN, or Point-to-Site VPN. [Learn which connectivity option makes sense in your environment.](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-plan-design) 

>[!TIP]
>If you wish to use a Point-to-Site VPN to connect your Windows Admin Center gateway to an Azure VNet to manage Azure VMs in that VNet, you can use the [Azure Network Adapter](https://aka.ms/WACNetworkAdapter) feature in Windows Admin Center. To do so, connect to the server on which Windows Admin Center is installed, navigate to the Network tool and select "Add Azure Network Adapter". When you provide the necessary details and click "Set up", Windows Admin Center will configure a Point-to-Site VPN to the Azure VNet you specify, after which, you can connect to and manage Azure VMs from your on-premises Windows Admin Center gateway.

Ensure WinRM is running on your target VMs by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

If you haven't domain-joined the Azure VM, the VM behaves like a server in workgroup, so you'll need to make sure you account for [using Windows Admin Center in a workgroup](../support/troubleshooting.md#using-windows-admin-center-in-a-workgroup).

If you run into any issues, consult [Troubleshoot Windows Admin Center](../support/troubleshooting.md) to see if additional steps are required for configuration (for example, if you are connecting using a local administrator account or are not domain-joined).

## Use a Windows Admin Center gateway deployed in Azure

You can manage Azure VMs without any on-premises dependency by deploying Windows Admin Center in the VNet where your target VMs are connected. 

To manage VMs outside of the VNet on which the Windows Admin Center gateway is deployed, you must establish VNet-to-VNet connectivity between the VNet of the Windows Admin Center gateway and the VNet of the target servers. You can establish this connectivity with VNet Peering, VNet-to-VNet connection, or a Site-to-Site connection. [Learn more about which VNet-to-VNet connectivity option makes sense in your environment.](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-vnet-vnet-resource-manager-portal)

Windows Admin Center can be installed on an existing or newly deployed VM in your environment. The VM that you choose for Windows Admin Center installation must have a public IP and DNS name.

[Learn more about Deploying a Windows Admin Center gateway in Azure](deploy-wac-in-azure.md)
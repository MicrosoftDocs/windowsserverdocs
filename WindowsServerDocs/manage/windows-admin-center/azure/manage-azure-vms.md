---
title: Manage Azure IaaS virtual machines
description: Managing Azure IaaS VMs with Windows Admin Center
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.date: 02/18/2021
---
# Manage Azure virtual machines with Windows Admin Center

This article describes how to use Windows Admin Center running on your on-premises PC or server to manage the operating system on one or more Azure virtual machines (in addition to on-premises servers, PCs, and VMs).

To instead use Windows Admin Center directly in the Azure portal to manage the operating system on a single Azure VM, see [Use Windows Admin Center in Azure](manage-vm.md). You can also use scripts to [set up a Windows Admin Center server in an Azure VM](deploy-wac-in-azure.md).

## Connecting to VMs with a public IP

If your target VMs (the VMs you want to manage with Windows Admin Center) have public IPs, add them to your Windows Admin Center gateway by IP address, or by fully qualified domain name (FQDN). There are a couple considerations to take into account:

- You must enable WinRM access to your target VM by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`
- If you haven't domain-joined the Azure VM, the VM behaves like a server in workgroup, so you'll need to make sure you account for [using Windows Admin Center in a workgroup](../support/troubleshooting.md#using-windows-admin-center-in-a-workgroup).
- You must also enable inbound connections to port 5985 for WinRM over HTTP in order for Windows Admin Center to manage the target VM:
  1. Run the following PowerShell script on the target VM to enable inbound connections to port 5985 on the guest OS:
     `Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any`

  2. You must also open the port in Azure networking:

     - Select your Azure VM, select **Network settings**, then **Create port rule**, and finally **inbound port rule**.
     - In the **Destination ranges** field, enter **5985**.

     If your Windows Admin Center gateway has a static IP, you can select to allow only inbound WinRM access from your Windows Admin Center gateway for added security.
     To do this, select **Advanced** at the top of the **Add inbound security rule** pane.

     For **Source**, select **IP Addresses**, then enter the Source IP address corresponding to your Windows Admin Center gateway.

     - For **Protocol** select **TCP**.
     - The rest can be left as default.

> [!NOTE]
> You must create a custom port rule. The WinRM port rule provided by Azure networking uses port 5986 (over HTTPS) instead of 5985 (over HTTP).

## Connecting to VMs without a public IP

If your target Azure VMs don't have public IPs, and you want to manage these VMs from a Windows Admin Center gateway deployed in your on-premises network, you need to configure your on-premises network to have connectivity to the VNet on which the target VMs are connected. There are 3 ways you can do this: ExpressRoute, Site-to-Site VPN, or Point-to-Site VPN. [Learn which connectivity option makes sense in your environment.](/azure/vpn-gateway/vpn-gateway-plan-design)

>[!TIP]
>If you wish to use a Point-to-Site VPN to connect your Windows Admin Center gateway to an Azure VNet to manage Azure VMs in that VNet, you can use the [Azure Network Adapter](https://aka.ms/WACNetworkAdapter) feature in Windows Admin Center. To do so, connect to the server on which Windows Admin Center is installed, navigate to the Network tool and select "Add Azure Network Adapter". When you provide the necessary details and click "Set up", Windows Admin Center will configure a Point-to-Site VPN to the Azure VNet you specify, after which, you can connect to and manage Azure VMs from your on-premises Windows Admin Center gateway.

Ensure WinRM is running on your target VMs by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

If you haven't domain-joined the Azure VM, the VM behaves like a server in workgroup, so you'll need to make sure you account for [using Windows Admin Center in a workgroup](../support/troubleshooting.md#using-windows-admin-center-in-a-workgroup).

If you run into any issues, consult [Troubleshoot Windows Admin Center](../support/troubleshooting.md) to see if additional steps are required for configuration (for example, if you are connecting using a local administrator account or are not domain-joined).

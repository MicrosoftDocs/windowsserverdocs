---
title: Configuring Azure Integration
description: Configuring Azure Integration Windows Admin Center (Project Honolulu); Connecting your Windows Admin Center gateway to Azure; managing Azure IaaS machines with Windows Admin Center.
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Configuring Azure integration

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Windows Admin Center supports several optional features that integrate with Azure services. The following documentation provides guidance on configuring the Windows Admin Center gateway to support these Azure integration features. 
[Learn about the Azure integration options available with Windows Admin Center.](../plan/azure-integration-options.md)

## Connect your gateway to Azure

To allow the Windows Admin Center gateway to communicate with Azure to leverage Azure Active Directory authentication for gateway access, or to create Azure resources on your behalf (e.g. to protect VMs managed in Windows Admin Center using Azure Site Recovery), you must first connect your Windows Admin Center gateway to Azure. This must only be done once for your Windows Admin Center gateway and is preserved upon updating your gateway to a newer version.

To connect your gateway, you must run the [New-AadApp.ps1 PowerShell script](https://aka.ms/HonoluluAzureConnectScript) available for download (there is also a hyperlink in the Windows Admin Center UI for this download), which creates a web application in Azure AD with the name "SME-*gateway*" and registers the application with the Windows Admin Center gateway. This allows Windows Admin Center to connect to Azure resources like AAD on your behalf. The script can be run from any machine that has access to the Windows Admin Center gateway and to Azure, with the Windows Admin Center gateway URL as the -GatewayEndpoint parameter. For example,

    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com"

If you are NOT using port 443, the GatewayEndpoint parameter should contain the port (i.e. https://myComputer:6516).

If there are multiple tenants associated with your Azure account, you can use the -TenantId parameter to specify the tenant in which you want to create the AAD application and associate with your Windows Admin Center gateway. For example,

    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com" -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

This script requires two Azure PowerShell modules: AzureRm.Resources and AzureAD. If you do not have these modules installed, execute the following commands in an elevated PowerShell console:

    PS C:>Install-Module AzureRM.Resources
    PS C:>Install-Module AzureAD

After running the script, you must refresh the browser page from which you are accessing the Windows Admin Center gateway. 

### Other considerations

If you have already configured your gateway for Azure connectivity when setting up Azure Site Recovery and used the New-AsrAadApp.ps1 available in our documentation prior to the 1803 release, you will need to delete your existing AAD application by navigating to the Azure portal > **Azure Active Directory** > **Application registration** > **All applications** and searching "ASR" (the old AAD app will be named "ASR-Honolulu-*gateway*"). Then run the [New-AadApp.ps1 script](https://aka.ms/HonoluluAzureConnectScript) to create the replacement application with the correct permissions.

## Manage Azure IaaS Virtual Machines with Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

You can use Project Windows Admin Center to manage your Azure VMs as well as on-premises machines. There are several different configurations possible. This article will walk through you those options to help you decide which configuration makes sense for your scenario.

### Manage with an on-premises Windows Admin Center gateway

If you've already installed Windows Admin Center on an on-premises gateway (either on Windows 10 or Windows Server 2016), you can use this same gateway to manage Windows 10 or Windows Server 2012, 2012R2, or 2016 VMs in Azure. 

#### Connecting to VMs with a public IP

If your target VMs (the VMs you wish to manage with Windows Admin Center) have public IPs, you can add them to your Windows Admin Center gateway by IP address, or by FQDN. There are a couple considerations to take into account:

You must enable WinRM access to your target VM by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

You must also enable inbound connections to port 5985 for WinRM over HTTP in order for Windows Admin Center to manage the target VM:

1. Run the following PS script on the target VM to enable inbound connections to port 5985 on the guest OS:   
`Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any`

2. You must also open the port in Azure networking:

    - select your Azure VM, select **Networking**, then **Add inbound port rule**. 
    - In the **Port ranges** field, enter **5985**.
    
    If your Windows Admin Center gateway has a static IP, you can select to only allow inbound WinRM access from your Windows Admin Center gateway for added security.
    To do this, select **Advanced** at the top of the "Add inbound security rule" pane.

    For **Source**, select **IP Addresses**, then enter the Source IP address corresponding to your Windows Admin Center gateway.

    - For **Protocol** select **TCP**.
    - The rest can be left as default.

> [!NOTE]
> You must create custom port rule. The WinRM port rule provided by Azure networking uses port 5986 (over HTTPS) instead of 5985 (over HTTP). 

#### Connecting to VMs without a public IP

If your target Azure VMs do not have public IPs, and wish to manage these VMs from a Windows Admin Center gateway deployed in your on-premises network, you will need to configure your on-premises network to have connectivity to the VNet on which the target VMs are connected. There are 3 ways you can do this: ExpressRoute, Site-to-Site VPN, or Point-to-Site. [Learn which connectivity option makes sense in your environment.](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-plan-design) 

Ensure WinRM is running on your target VM(s) by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

If you run into any issues, consult [Troubleshoot Project Windows Admin Center](../use/troubleshooting.md) to see if additional steps are required for configuration (for example, if you are connecting using a local administrator account or are not domain joined).

### Manage with a Windows Admin Center gateway deployed in Azure

#### Deployment considerations
You can manage Azure VMs without any on-premises dependency by deploying Windows Admin Center in the VNet where your target VMs are connected. 

To manage VMs outside of the VNet on which the Windows Admin Center gateway is deployed, you must establish VNet-to-VNet connectivity between the VNet of the Windows Admin Center gateway and the VNet of the target servers. This connectivity can be established with VNet Peering, VNet-to-VNet connection, or a Site-to-Site connection. [Learn more about which VNet-to-VNet connectivity option makes sense in your environment.](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-vnet-vnet-resource-manager-portal)

#### Deploying Windows Admin Center in an Azure VM
Windows Admin Center can be installed on an existing or newly deployed VM in your environment. The VM that you choose for Windows Admin Center installation must have a public IP and DNS name. 

Before installing Windows Admin Center on your desired gateway VM, you will need to install a SSL certificate to use for HTTPS communication, or you can choose to use a self-signed certificate generated by Windows Admin Center. However, you will get a warning when trying to connect from a browser if you choose the latter option. You can bypass this warning in Edge by clicking "Details" > "Go on to the webpage" or in Chrome by selecting "Advanced" > "Proceed to [webpage]". We recommend you only use self-signed certificates for test environments.


##### Install Windows Admin Center onto an Azure VM:
> [!NOTE]
> These instructions are for installing on full server with desktop experience. 

1. Visit [https://aka.ms/WindowsAdminCenter](https://aka.ms/WindowsAdminCenter) on your local machine to download Windows Admin Center to your local machine 

2. Establish a remote desktop connection to the VM, then copy the MSI from your local machine and paste into the VM

3. Double click the MSI to begin installation and step through the installer

   - By default, the installer chooses port 443 (HTTPS), which is recommended. If you wish to select a different port, note that you will need to open that port in your firewall as well. 

   - If you have already installed an SSL certificate on the VM, ensure you select that option and enter the thumbprint

4. Start the Windows Admin Center service (run C:/Program Files/Windows Admin Center/sme.exe)

[Learn more about deploying Windows Admin Center.](../deploy/install.md)

##### Configure the gateway VM to enable HTTPS port access: 

1. Navigate to your VM in the Azure portal and select **Networking**. 

2. Select **Add inbound port rule** and select **HTTPS** under **Service**. 

> [!NOTE]
> If you chose a port other than the default 443, choose **Custom** under Service and enter the port you chose in step 3 under **Port ranges**. 

 

At this point, you should be able to access Windows Admin Center from a modern browser (Edge or Chrome) on your local machine by navigating to the DNS name of your gateway VM. 

> [!NOTE]
> If you selected a port other than 443, you can access Windows Admin Center by navigating to https://< DNS name of your VM >:< custom port >

In order to add other VMs in the VNet, ensure WinRM is running on the target VMs by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`
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

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

Windows Admin Center supports several optional features that integrate with Azure services. Use the following information to configure the Windows Admin Center gateway to support these Azure integration features. 
[Learn about the Azure integration options available with Windows Admin Center.](../plan/azure-integration-options.md)

## Connect your gateway to Azure

To allow the Windows Admin Center gateway to communicate with Azure to leverage Azure Active Directory authentication for gateway access, or to create Azure resources on your behalf (for example, to protect VMs managed in Windows Admin Center using Azure Site Recovery), you must first connect your Windows Admin Center gateway to Azure. You only need to do this once for your Windows Admin Center gateway - the setting is preserved when you update your gateway to a newer version.

To connect your gateway, you must run the [New-AadApp.ps1 PowerShell script](https://aka.ms/WACAzureConnectScript) (there is also a hyperlink in the Windows Admin Center UI for this download, which is visible wherever you try to use an Azure integration feature for the first time), which creates a web application in Azure AD with the name "SME-*gateway*" and registers the application with the Windows Admin Center gateway. This allows Windows Admin Center to connect to Azure resources like Azure AD on your behalf. You can run the script from any computer that has access to the Windows Admin Center gateway and to Azure, with the Windows Admin Center gateway URL as the -GatewayEndpoint parameter. For example,

```powershell
    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com"
```

If you are NOT using port 443, the GatewayEndpoint parameter should contain the port (for example, https://myComputer:6516).

If you have multiple tenants associated with your Azure account, you can use the -TenantId parameter to specify the tenant in which you want to create the Azure AD application and associate with your Windows Admin Center gateway. For example,

```powershell
    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com" -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

This script requires two Azure PowerShell modules: AzureRm.Resources and AzureAD. If you don't have them installed, run the following commands in an elevated PowerShell console:

```powershell
    PS C:>Install-Module AzureRM.Resources
    PS C:>Install-Module AzureAD
```

After running the script, refresh the browser page from which you are accessing the Windows Admin Center gateway. 

### Other considerations

If you've already configured your gateway for Azure connectivity when you set up Azure Site Recovery and you used the New-AsrAadApp.ps1 available in our documentation prior to the GA release, you need to delete your existing Azure AD application. In the Azure portal go to**Azure Active Directory** > **Application registration** > **All applications** and search for "ASR" (the old Azure AD app is named "ASR-Honolulu-*gateway*"). Then run the [New-AadApp.ps1 script](https://aka.ms/WACAzureConnectScript) to create the replacement application with the correct permissions.

## Manage Azure IaaS virtual machines with Windows Admin Center

You can use Windows Admin Center to manage your Azure VMs as well as on-premises machines. There are several different configurations possible - choose the configuration that makes sense for your environment:

### Manage with an on-premises Windows Admin Center gateway

If you've already installed Windows Admin Center on an on-premises gateway (either on Windows 10 or Windows Server 2016), you can use this same gateway to manage Windows 10 or Windows Server 2012, Windows Server 2012 R2, or Windows Server 2016 VMs in Azure. 

#### Connecting to VMs with a public IP

If your target VMs (the VMs you want to manage with Windows Admin Center) have public IPs, add them to your Windows Admin Center gateway by IP address, or by FQDN. There are a couple considerations to take into account:

- You must enable WinRM access to your target VM by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`
- You must also enable inbound connections to port 5985 for WinRM over HTTP in order for Windows Admin Center to manage the target VM:
   1. Run the following PowerShell script on the target VM to enable inbound connections to port 5985 on the guest OS:   
`Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any`

   2. You must also open the port in Azure networking:

    - Select your Azure VM, select **Networking**, then **Add inbound port rule**. 
    - In the **Port ranges** field, enter **5985**.
    
    If your Windows Admin Center gateway has a static IP, you can select to allow only inbound WinRM access from your Windows Admin Center gateway for added security.
    To do this, select **Advanced** at the top of the **Add inbound security rule** pane.

    For **Source**, select **IP Addresses**, then enter the Source IP address corresponding to your Windows Admin Center gateway.

    - For **Protocol** select **TCP**.
    - The rest can be left as default.

> [!NOTE]
> You must create a custom port rule. The WinRM port rule provided by Azure networking uses port 5986 (over HTTPS) instead of 5985 (over HTTP). 

#### Connecting to VMs without a public IP

If your target Azure VMs don't have public IPs, and you want to manage these VMs from a Windows Admin Center gateway deployed in your on-premises network, you need to configure your on-premises network to have connectivity to the VNet on which the target VMs are connected. There are 3 ways you can do this: ExpressRoute, Site-to-Site VPN, or Point-to-Site. [Learn which connectivity option makes sense in your environment.](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-plan-design) 

Ensure WinRM is running on your target VMs by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

If you run into any issues, consult [Troubleshoot Windows Admin Center](../use/troubleshooting.md) to see if additional steps are required for configuration (for example, if you are connecting using a local administrator account or are not domain-joined).

### Use a Windows Admin Center gateway deployed in Azure

You can manage Azure VMs without any on-premises dependency by deploying Windows Admin Center in the VNet where your target VMs are connected. 

To manage VMs outside of the VNet on which the Windows Admin Center gateway is deployed, you must establish VNet-to-VNet connectivity between the VNet of the Windows Admin Center gateway and the VNet of the target servers. You can establish this connectivity with VNet Peering, VNet-to-VNet connection, or a Site-to-Site connection. [Learn more about which VNet-to-VNet connectivity option makes sense in your environment.](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-vnet-vnet-resource-manager-portal)

Windows Admin Center can be installed on an existing or newly deployed VM in your environment. The VM that you choose for Windows Admin Center installation must have a public IP and DNS name. 

Before installing Windows Admin Center on your desired gateway VM, install a SSL certificate to use for HTTPS communication, or you can choose to use a self-signed certificate generated by Windows Admin Center. However, you will get a warning when trying to connect from a browser if you choose the latter option. You can bypass this warning in Edge by clicking **Details > Go on to the webpage** or, in Chrome, by selecting **Advanced > Proceed to [webpage]**. We recommend you only use self-signed certificates for test environments.

#### Install Windows Admin Center onto an Azure VM:
> [!NOTE]
> These instructions are for installing on Windows Server with Desktop Experience, not on a Server Core installation. 

1. [Download Windows Admin Center](https://aka.ms/WACdownload) to your local computer.

2. Establish a remote desktop connection to the VM, then copy the MSI from your local machine and paste into the VM.

3. Double-click the MSI to begin installation, and follow the instructions in the wizard. Be aware of the following:

   - By default, the installer uses the recommended port 443 (HTTPS). If you want to select a different port, note that you need to open that port in your firewall as well. 

   - If you have already installed an SSL certificate on the VM, ensure you select that option and enter the thumbprint.

4. Start the Windows Admin Center service (run C:/Program Files/Windows Admin Center/sme.exe)

[Learn more about deploying Windows Admin Center.](../deploy/install.md)

#### Configure the gateway VM to enable HTTPS port access: 

1. Navigate to your VM in the Azure portal and select **Networking**. 

2. Select **Add inbound port rule** and select **HTTPS** under **Service**. 

> [!NOTE]
> If you chose a port other than the default 443, choose **Custom** under Service and enter the port you chose in step 3 under **Port ranges**. 

At this point, you should be able to access Windows Admin Center from a modern browser (Edge or Chrome) on your local computer by navigating to the DNS name of your gateway VM. 

> [!NOTE]
> If you selected a port other than 443, you can access Windows Admin Center by navigating to https://\<DNS name of your VM\>:\<custom port\>

In order to add other VMs in the VNet, ensure WinRM is running on the target VMs by running the following in PowerShell or the command prompt on the target VM: `winrm quickconfig`
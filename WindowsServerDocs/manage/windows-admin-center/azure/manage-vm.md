---
title: Manage a Windows Server VM using Windows Admin Center in Azure
description: Learn how to use Windows Admin Center in the Azure portal to connect and manage Windows Server VMs in an Azure VM
ms.topic: overview
author: prasidharora
ms.author: praror
ms.date: 07/26/2022
---
# Manage a Windows Server VM using Windows Admin Center in Azure

You can now use Windows Admin Center in the Azure portal to manage the Windows Server operating system inside an Azure VM. Manage operating system functions from the Azure portal and work with files in the VM without using Remote Desktop or PowerShell.

This article provides an overview of the functionality provided, requirements, and how to install Windows Admin Center and use it to manage a single VM. It also answers frequently asked questions, and provides a list of known issues and tips for troubleshooting in case something doesn't work.

:::image type="content" source="../../media/manage-vm/windows-admin-center-in-azure.png" alt-text="Screenshot showing Windows Admin Center in the Azure portal, displaying the files and folders on the running operating system." lightbox="../../media/manage-vm/windows-admin-center-in-azure.png":::

## Overview of functionality

Windows Admin Center in the Azure portal provides the essential set of management tools for managing Windows Server in a single Azure VM:

- Certificates
- Devices
- Events
- Files and file sharing
- Firewall
- Installed apps
- Local users and groups
- Performance Monitor
- PowerShell
- Processes
- Registry
- Remote Desktop
- Roles and features
- Scheduled tasks
- Services
- Storage
- Updates

We don't support extensions to Windows Admin Center in the Azure portal at this time.

If you manually installed Windows Admin Center in the VM to manage multiple systems, installing this VM extension reduces the functionality to managing just the VM in which the extension is installed. Uninstall the extension to get back full functionality.

## Requirements

This section provides the requirements for using Windows Admin Center in the Azure portal to manage your Azure IaaS VM:

- [Azure account with an active subscription](#azure-account-with-an-active-subscription)
- [Azure permissions](#azure-permissions)
- [Virtual machine requirements](#virtual-machine-requirements)
- [Networking requirements](#networking-requirements)
- [Management PC requirements](#management-pc-requirements)

### Azure account with an active subscription

You need an Azure account with an active subscription to deploy Windows Admin Center. If you don't have one already, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

### Azure permissions

To install the Windows Admin Center extension on your IaaS VM, your account must be granted the **Owner** or **Contributor** role in Azure.

Connecting to Windows Admin Center requires you to have **Reader** and **Windows Admin Center Administrator Login** permissions at the virtual machine resource level.

Learn more about [configuring role assignment for your VM](#configuring-role-assignments-for-the-vm).

### Virtual machine requirements

To use Windows Admin Center in the Azure portal, we install Windows Admin Center in each Azure VM that you want to use it to manage. The Azure VM has the following requirements:

- Windows Server 2022, Windows Server 2019 or Windows Server 2016
- At least 3 GiB of memory
- Be in any region of an Azure public cloud (it's not supported in Azure China, Azure Government, or other non-public clouds)

### Networking requirements

The VM also has the following networking requirements, which we step through during the installation procedure:

- Outbound internet access or an outbound port rule allowing HTTPS traffic to the `WindowsAdminCenter` and `AzureActiveDirectory` service tag

- An inbound port rule if using a public IP address to connect to the VM (not recommended)

> [!NOTE]
> Confiuring Windows Admin Center to communicate outbound through an HTTP/HTTPS proxy server is currently not supported.


Just like with Remote Desktop, we recommend connecting to the VM using a private IP address in the VM's virtual network to increase security. Using a private IP address doesn't require an inbound port rule, though it does require access to the virtual network (which we discuss next).

> [!NOTE]
> Inbound connectivity being redirected by another service (i.e. Azure Firewall) is not supported. You must have inbound connectivity from the Azure portal to one of the direct IP addresses of your VM (as seen on the "Networking" tab of your Azure VM in the Azure portal) on the port Windows Admin Center is installed.

### Management PC requirements

The management PC or other system that you use to connect to the Azure portal has the following requirements:

- The [Microsoft Edge](https://www.microsoft.com/edge) or Google Chrome web browser
- Access to the virtual network that's connected to the VM (this is more secure than using a public IP address to connect). There are many ways to connect to a virtual network, including by using a [VPN gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways).


## Installing in a VM

Before you can use Windows Admin Center in the Azure portal, you must install it in the VM you want to manage. Here's how:

1. Open the Azure portal and navigate to your VM's settings.
1. If the VM has all outbound internet traffic blocked, create an outbound port rule to connect to the Windows Admin Center service.

    To do so, navigate to Windows Admin Center (found in the Settings group) and select the checkbox titled "Open an outbound port for Windows Admin Center to install" on the Install screen of Windows Admin Center. Alternatively, you can run the following PowerShell commands:

    ```powershell-interactive
    $allowWindowsAdminCenter = New-AzNetworkSecurityRuleConfig  -Name "PortForWACService"  -Access Allow -Protocol Tcp -Direction Outbound -Priority 100 -DestinationAddressPrefix WindowsAdminCenter -SourcePortRange * -SourceAddressPrefix * -DestinationPortRange 443
    $allowAAD = New-AzNetworkSecurityRuleConfig  -Name "PortForAADService"  -Access Allow -Protocol Tcp -Direction Outbound -Priority 101 -DestinationAddressPrefix AzureActiveDirectory -SourcePortRange * -SourceAddressPrefix * -DestinationPortRange 443
    ```

1. In the virtual machine settings, navigate to **Windows Admin Center** (found in the **Settings** group).
1. To optionally provide access to your VM over the public internet from any IP address (convenient for testing but exposes the VM to attack from any host on the internet), you can select **Open this port for me**.

However, we recommend instead using a private IP address to connect with, or at least [manually creating an inbound port rule](#creating-an-inbound-port-rule-for-connecting-from-specific-public-ip-addresses) that's locked down to accept traffic from only the IP addresses you specify.

1. Select **Install**.

   Installing takes a few minutes. If you selected **Open this port for me** or manually created an inbound port rule in the last couple minutes, it might take another couple minutes before you can connect with Windows Admin Center.

:::image type="content" source="../../media/manage-vm/install-windows-admin-center.png" alt-text="Screenshot showing the install button for Windows Admin Center on a VM." lightbox="../../media/manage-vm/install-windows-admin-center.png":::

## Using with a VM

After you've installed Windows Admin Center in an Azure VM, here's how to connect to it and use it to manage Windows Server:

1. Open the Azure portal and navigate to your VM, then Windows Admin Center.
1. Select the IP address you want to use when connecting to the VM, and then select **Connect**.

Windows Admin Center opens in the portal, giving you access to the same tools you might be familiar with from using Windows Admin Center in an on-premises deployment.

> [!NOTE]
> Starting August 2022, Windows Admin Center now allows you to use Microsoft Entra ID-based authentication for your Azure IaaS VM. You will no longer be prompted for the credentials of a local administrator account.

:::image type="content" source="../../media/manage-vm/connect-to-vm.png" alt-text="Screenshot showing a VM's settings and connecting to Windows Admin Center by private IP address. "lightbox="../../media/manage-vm/connect-to-vm.png":::

If you see a "Failed to connect" message, ensure your account is a member of the **Windows Admin Center Administrator Login** role on the VM resource.

## Creating an inbound port rule for connecting from specific public IP addresses

Just like with Remote Desktop, opening an inbound port rule on your VM's public IP address exposes your VM to potential attack from any host on the internet, so we recommend instead accessing the VM using a private IP address.

However, if you need to use a public IP address, you can improve security by limiting the IP addresses that can reach your VM to only the IP addresses used by the systems you use to connect to the Azure portal. Here's how:

1. Open the Azure portal and navigate to your VM > **Networking** > **Inbound port rules**.
2. If you already installed Windows Admin Center and configured it to open an inbound port for your public IP address, select **PortForWAC**. Otherwise, select **Add inbound port rule**.
3. Provide the following values, specifying the public IP addresses of your management systems (separated with commas), and optionally changing the destination port from port 6516. Then select **Add**.

   | Field                        | Value              |
   | --------------------------   | ------------------ |
   | **Source**                   | IP address         |
   | **Source IP addresses**      | *Management system IPs* |
   | **Source port ranges**       | *                  |
   | **Destination**              | Any                |
   | **Destination port ranges**  | `6516`             |
   | **Protocol**                 | Any                |
   | **Action**                   | Allow              |

You might need to use a non-Microsoft website or app to find the public IP address of the system you're using to connect to the Azure portal.

## Configuring role assignments for the VM

Access to Windows Admin Center is controlled by the **Windows Admin Center Administrator Login** Azure role.

> [!NOTE]
> The Windows Admin Center Administrator Login role uses dataActions and thus cannot be assigned at management group scope. Currently these roles can only be assigned at the subscription, resource group or resource scope.

To configure role assignments for your VMs using the Microsoft Entra admin center experience:

1. Select the **Resource Group** containing the VM and its associated Virtual Network, Network Interface, Public IP Address or Load Balancer resource.

1. Select **Access control (IAM)**.

1. Select **Add** > **Add role assignment** to open the Add role assignment page.

1. Assign the following role. For detailed steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

    | Setting | Value |
    | --- | --- |
    | Role | **Windows Admin Center Administrator Login** |
    | Assign access to | User, group, service principal, or managed identity |

For more information on how to use Azure RBAC to manage access to your Azure subscription resources, see the following articles:

- [Assign Azure roles using Azure CLI](/azure/role-based-access-control/role-assignments-cli)
- [Assign Azure roles using the Azure CLI examples](/cli/azure/role/assignment#az-role-assignment-create). Azure CLI can also be used in the Azure Cloud Shell experience.
- [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal)
- [Assign Azure roles using Azure PowerShell](/azure/role-based-access-control/role-assignments-powershell).

## Proxy configuration
If the machine connects through a proxy server to communicate over the internet, review the following requirements to understand the network configuration required.

The Windows Admin Center extension can communicate through a proxy server by using the HTTPS protocol. Use the extensions settings for configuration as described in the following steps. Authenticated proxies are not supported.

> [!NOTE]
> Proxy configuration is only supported for extension versions greater than 0.0.0.321.

1. Use this flowchart to determine the values of the `Settings` parameters
    :::image type="content" source="../../media/manage-vm/enterprise-proxy-workflow.png" alt-text="Workflow for customers to understand the configuration needed to use proxies with Windows Admin Center." lightbox="../../media/manage-vm/enterprise-proxy-workflow.png":::

1. After you determine the `Settings` parameter values, provide these other parameters when you deploy the AdminCenter Agent. Use PowerShell commands, as shown in the following example:

```powershell
$wacPort = "6516"
$settings = @{"port" = $wacPort; "proxy" = @{"mode" = "application"; "address" = "http://[address]:[port]";}}
Set-AzVMExtension -ExtensionName AdminCenter -ExtensionType AdminCenter -Publisher Microsoft.AdminCenter -ResourceGroupName <resource-group-name> -VMName <virtual-machine-name> -Location <location> -TypeHandlerVersion "0.0" -settings $settings
```

## Updating Windows Admin Center

We're constantly releasing new versions of Windows Admin Center. For Windows Admin Center to automatically update to the latest version, the Azure Virtual Machine needs a control plane operation to take place. In the event you wish to update sooner, you can run the following commands:

```powershell
Set-AzContext <subscription_id>
Set-AzVMExtension -ExtensionName "AdminCenter" -Publisher "Microsoft.AdminCenter" -ExtensionType "AdminCenter" -ResourceGroupName <RG_name> -VMName <VM_name>
```

## Implementation details

Windows Admin Center is currently implemented in the Azure portal in the form of an extension that we install on each Azure VM with which you want to use Windows Admin Center.

This extension connects to an external service that manages certificates and DNS records so that you can easily connect to your VM.

Each Azure VM that uses the Windows Admin Center extension gets a public DNS record that Microsoft maintains in Azure DNS. We hash the record name with a salt to anonymize the VM's IP address when saving it in DNS - the IP addresses aren't saved in plain text in DNS. This DNS record is used to issue a certificate for Windows Admin Center on the VM, enabling encrypted communication with the VM.

Connecting an Azure VM to Windows Admin Center deploys a virtual account in the administrators group, giving you full administrator access on your VM. Access to your VM is controlled by the **Windows Admin Center Administrator Login** role in Azure. An Azure user with the **Owner** or **Contributor** roles assigned for a VM doesn't automatically have privileges to log into the VM.

## Troubleshooting

Here are some tips to try in case something isn't working. For general help troubleshooting Windows Admin Center (not specifically in Azure), see [Troubleshooting Windows Admin Center](../support/troubleshooting.md).

### Failed to connect error

1. In a new tab, open `https://<ip_address>:<port>`. If this page loads successfully with a certificate error, create a support request.

   If this page doesn't load successfully, there's something wrong with your connection to Windows Admin Center itself. Make sure that you're connected to the correct Vnet and are using the correct IP address before trying further troubleshooting.
1. If you're using a Public IP address, make sure that the port you selected upon installation is open to the internet. By default, the port is set to 6516. In your virtual machine, navigate to “Networking” > “Add inbound port rule”.
1. Make sure that the port can be reached.
    1. In the Azure portal, navigate to “Networking” and make sure that there are no conflicting rules with a higher priority that could be blocking the Windows Admin Center port
    1. In the Azure portal, navigate to “Connection troubleshoot” to test that your connection is working and the port can be reached.
1. Make sure that outbound traffic to Windows Admin Center is allowed on your virtual machine
    1. In the Azure portal, navigate to “Networking” and “Outbound port rules”.
    1. Create a new port rule for the `Windows Admin Center` and `Azure Active Directory` service tags.
    1. You can test this by running the following command using PowerShell inside of your virtual machine:

        ```powershell
        Invoke-RestMethod -Method GET -Uri https://<your_region>.service.waconazure.com
        ```

        ```Expected output
        Microsoft Certificate and DNS service for Windows Admin Center in the Azure Portal
        ```


    1. If you allowed all outbound traffic and are still seeing an error from the command above, check that there are no firewall rules blocking connection. If nothing seems wrong, create a support request as our service might be experiencing problems.
1. Make sure that the Windows Admin Center service is running on your VM.
    1. In the Azure portal, navigate to “Connect” > “RDP” > “Download RDP File”.
    1. Open the RDP file and sign in with your administrator credentials.
    1. Open Task Manager (Ctrl+Shift+Esc) and navigate to “Services”.
    1. Make sure ServerManagementGateway / Windows Admin Center is Running. If not, start the service.
1. Check that your installation is in a good state.
    1. In the Azure portal, navigate to “Connect” > “RDP” > “Download RDP File”.
    1. Open the RDP file and sign in with your administrator credentials.
    1. Open a browser and type `https://localhost:<port>` replacing `<port>` with the port on which you installed Windows Admin Center. Not sure what port you installed it on? Check out the Frequently Asked Questions later in this article.
    1. If this doesn’t load, there might be something wrong with your installation. Go back to the Azure portal, navigate to “Extensions”, and uninstall the Admin Center extension. Navigate back to “Windows Admin Center” and reinstall the extension.
1. Check that the firewall rule is open for SmeInboundOpenException.
    1. In the Azure portal, navigate to “Connect” > “RDP” > “Download RDP File”.
    1. Open the RDP file and sign in with your administrator credentials.
    1. Open the Control Panel and navigate to Control Panel\System and Security\Windows Defender Firewall\Allowed apps.
    1. Ensure that the SmeInboundOpenException rule is enabled for both Private and Public, then try to connect again.

### You get stuck on the "Windows Admin Center" loading page with the logo
This could occur if your browser blocks third party cookies. Currently, Windows Admin Center requires that you don't block third party cookies, and we're actively working to remove this requirement. In the meantime, please allow third party cookies in your browser.

1. On **Edge**:
    1. Navigate to the ellipses on the top right corner, and navigate to **Settings**
    1. Navigate to **Cookies and site permissions**
    1. Navigate to **Manage and delete cookies and site data**
    1. Ensure that the checkbox for **Block third-party cookies** is turned **off**

1. On **Chrome**
    1. Navigate to the ellipses on the top right corner, and navigate to **Settings**
    1. Navigate to **Privacy and Security**
    1. Navigate to **Cookies and other site data**
    1. Select the radio button for either **Block third-party cookies in Incognito** or **Allow all cookies**

### One of the Windows Admin Center tools isn’t loading or gives an error

Navigate to any other tool in Windows Admin Center and navigate back to the one that isn’t loading.

If no other tool is loading, there might be a problem with your network connectivity. Try closing the blade and then connecting again. If this doesn’t work, open a support ticket.

### The Windows Admin Center extension failed to install

1. Double-check to make sure that the VM meets the [requirements](#requirements).
1. Make sure that outbound traffic to Windows Admin Center is allowed on your virtual machine.
    1. In the Azure portal, navigate to “Networking” and “Outbound port rules”.
    1. Create a new outbound port rule for Windows Admin Center.
    1. Test connectivity by running the following command using PowerShell inside of your virtual machine:

        ```powershell
        Invoke-RestMethod -Method GET -Uri https://<your_region>.service.waconazure.com
        ```

        ```Expected output
        Microsoft Certificate and DNS service for Windows Admin Center in the Azure Portal
        ```

1. If you have allowed all outbound traffic, and are getting an error from the command above, check that there are no firewall rules blocking the connection.

If nothing seems wrong and Windows Admin Center still won't install, open a support request with the following information:

- Logs in the Azure portal. This can be found under Settings > Extensions > AdminCenter > View Detailed Status
- Logs in the VM. Share the logs from the following locations:
  - C:\WindowsAzure\Logs\Plugins\AdminCenter
  - C:\Packages\Plugins\AdminCenter
- Network trace, if appropriate. Network traces can contain customer data and sensitive security details, such as passwords, so we recommend reviewing the trace and removing any sensitive details before sharing it.

## Automate Windows Admin Center deployment using an ARM template

You can automate Windows Admin Center deployment in Azure portal by using this Azure Resource Manager template.

```json
const deploymentTemplate = {
        "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "vmName": {
                "type": "string"
            },
            "location": {
                "type": "string"
            },
            "extensionName": {
                "type": "string"
            },
            "extensionPublisher": {
                "type": "string"
            },
            "extensionType": {
                "type": "string"
            },
            "extensionVersion": {
                "type": "string"
            },
            "port": {
                "type": "string"
            },
            "salt": {
                "type": "string"
            }
        },
        "resources": [
            {
                "type": "Microsoft.Compute/virtualMachines/extensions",
                "name": "[concat( parameters('vmName'), '/' , parameters('extensionName') )]",
                "apiVersion": "2018-10-01",
                "location": "[parameters('location')]",
                "properties": {
                    "publisher": "[parameters('extensionPublisher')]",
                    "type": "[parameters('extensionType')]",
                    "typeHandlerVersion": "[parameters('extensionVersion')]",
                    "autoUpgradeMinorVersion": true,
                    "settings": {
                        "port": "[parameters('port')]",
                        "salt": "[parameters('salt')]",
                    }
                }
            }
        ];

const parameters = {
    vmName: <VM name>, 
    location: <VM location>, 
    extensionName: "AdminCenter", 
    extensionPublisher: "Microsoft.AdminCenter", 
    extensionType: "AdminCenter", 
    extensionVersion: "0.0", 
    port: "6516", 
    salt: <unique string used for hashing>
}
```

## Automate Windows Admin Center deployment using PowerShell

You can also automate Windows Admin Center deployment in Azure portal by using this PowerShell script.

```PowerShell
$resourceGroupName = <get VM's resource group name>
$vmLocation = <get VM location>
$vmName = <get VM name>
$vmNsg = <get VM's primary nsg>
$salt = <unique string used for hashing>

$wacPort = "6516"
$Settings = @{"port" = $wacPort; "salt" = $salt}

# Open outbound port rule for WAC service
Get-AzNetworkSecurityGroup -Name $vmNsg -ResourceGroupName $resourceGroupName | Add-AzNetworkSecurityRuleConfig -Name "PortForWACService" -Access "Allow" -Direction "Outbound" -SourceAddressPrefix "VirtualNetwork" -SourcePortRange "*" -DestinationAddressPrefix "WindowsAdminCenter" -DestinationPortRange "443" -Priority 100 -Protocol Tcp | Set-AzNetworkSecurityGroup

# Open outbound port rule for AAD
Get-AzNetworkSecurityGroup -Name $vmNsg -ResourceGroupName $resourceGroupName | Add-AzNetworkSecurityRuleConfig -Name "PortForAADService" -Access "Allow" -Direction "Outbound" -SourceAddressPrefix "VirtualNetwork" -SourcePortRange "*" -DestinationAddressPrefix "AzureActiveDirectory" -DestinationPortRange "443" -Priority 101 -Protocol Tcp | Set-AzNetworkSecurityGroup

# Install VM extension
Set-AzVMExtension -ResourceGroupName $resourceGroupName -Location $vmLocation -VMName $vmName -Name "AdminCenter" -Publisher "Microsoft.AdminCenter" -Type "AdminCenter" -TypeHandlerVersion "0.0" -settings $Settings

# Open inbound port rule on VM to be able to connect to WAC
Get-AzNetworkSecurityGroup -Name $vmNsg -ResourceGroupName $resourceGroupName | Add-AzNetworkSecurityRuleConfig -Name "PortForWAC" -Access "Allow" -Direction "Inbound" -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange $wacPort -Priority 100 -Protocol Tcp | Set-AzNetworkSecurityGroup
```

## Known issues

- If you change any of your networking rules, it takes Windows Admin Center about a minute or so to update its networking. The connection may fail for a few minutes.
- If you just started your virtual machine, it takes about a minute for the IP address to be registered with Windows Admin Center and thus, it may not load.
- The first load time of Windows Admin Center might be a little longer. Any subsequent load is just a few seconds.
- Chrome Incognito mode isn't supported.
- Azure portal desktop app is not supported.

## Frequently asked questions

### How much does it cost to use Windows Admin Center?

There's no cost to using the Windows Admin Center in the Azure portal.

### Can I use Windows Admin Center to manage the virtual machines running on my Azure VM?

You can install the Hyper-V role using the Roles and Features extension. Once installed, refresh your browser, and Windows Admin Center will show the Virtual Machine and Switch extensions.

### What servers can I manage using this extension?

You can use the extension to manage VMs running Windows Server 2016 or higher.

### How does Windows Admin Center handle security?

Traffic from the Azure portal to Windows Admin Center running on your VM uses HTTPS. Your Azure VM is managed using PowerShell and WMI over WinRM.

### For an inbound port, why must I open a port and why should the source be set to “Any”?

Windows Admin Center installs on your Azure Virtual Machine. The installation consists of a web server and a gateway. By publishing the web server to DNS and opening the firewall (the inbound port in your VM), you can access Windows Admin Center from the Azure portal. The rules for this port perform very similar to the “RDP” port. If you don’t wish to open this port up to “Any”, we recommend specifying the rule to the IP address of the machine used to open the Azure portal.

### Why must I create an outbound port rule?

There's an external Windows Admin Center service that manages certificates and DNS records for you. To allow your VM to interact with our service, you must create an outbound port rule.

### How do I find the port used for Windows Admin Center installation?

There are two ways to find out the port:

- Navigate to the Windows Admin Center extension in the Azure portal. Try to connect via an IP address that will result in a failed connection.
- To verify this value on your VM, open the Registry Editor on your VM and look for the “SmePort” registry key in “\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManagementGateway”

### Can I use PowerShell or the Azure CLI to install the extension on my VM?

Yes:

- PowerShell: [Set-AzVMExtension](/powershell/module/az.compute/set-azvmextension)
- Azure CLI: [az vm extension set](/cli/azure/vm/extension#az_vm_extension_set)

### I already have Windows Admin Center installed on my VM. Can I access it from the portal?

Yes, however you will still need to [install the extension](#installing-in-a-vm).

### Is there any documentation on the general functionality of Windows Admin Center and its tools?

Yes, see [Windows Admin Center overview](../overview.md) and [Manage Servers](../use/manage-servers.md).

### Do I have to install Windows Admin Center on each of my Azure VMs?

Yes, for our initial implementation, Windows Admin Center must be installed on every Azure VM you want to use it on.

### Can I use Windows Admin Center to manage all servers and virtual machines?

Yes, you can use Windows Admin Center on-premises to manage servers and virtual machines on-premises and in Azure. For details, see [Manage Azure VMs with Windows Admin Center](../azure/manage-azure-vms.md).

### Does Windows Admin Center in the Azure portal work with Azure Bastion?

No, unfortunately not.

### Is Windows Admin Center supported for VMs behind a load balancer?

Yes.

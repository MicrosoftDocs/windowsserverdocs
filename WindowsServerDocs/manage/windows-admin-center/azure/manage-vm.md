---
title: Use Windows Admin Center in the Azure portal to manage a Windows Server VM
description: An overview of using Windows Admin Center in the Azure portal to manage the Windows Server OS in an Azure VM. Includes the functionality provided, requirements, and how to install Windows Admin Center and use it to manage a VM. Also provides troubleshooting tips.
ms.topic: overview
author: jasongerend
ms.author: jgerend
ms.date: 02/18/2021
---
# Use Windows Admin Center in the Azure portal to manage a Windows Server VM

You can now use Windows Admin Center (preview) in the Azure portal to manage the Windows Server operating system inside an Azure VM. Manage operating system functions from the Azure portal as well as work with files in the VM without using Remote Desktop or PowerShell.

This article provides an overview of the functionality provided, requirements, and how to install Windows Admin Center and use it to manage a single VM. It also answers frequently asked questions, and provides a list of known issues and tips for troubleshooting in case something doesn't work.

:::image type="content" source="../../media/wac-in-azure/windows-admin-center-in-azure.png" alt-text="Screenshot showing Windows Admin Center in the Azure portal, displaying the files and folders on the running operating system." lightbox="../../media/wac-in-azure/windows-admin-center-in-azure.png":::

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

To use Windows Admin Center in the Azure portal, we install Windows Admin Center in each Azure VM that you want to use it to manage. The Azure VM has the following requirements:

- Windows Server 2019 or Windows Server 2016
- At least 3 GiB of memory
- Be in any region of an Azure public cloud (it's not supported in Azure China, Azure Government, or other non-public clouds)

The VM also has the following networking requirements, which we step through during the installation procedure:

- Outbound internet access or an outbound port rule allowing HTTPS traffic to the Windows Admin Center service IP address (we don't use service tags yet)

- An inbound port rule if using a public IP address to connect to the VM (not recommended)
<br>Just like with Remote Desktop, we recommend connecting to the VM using a private IP address in the VM's virtual network to increase security. Using a private IP address doesn't require an inbound port rule, though it does require access to the virtual network (which we discuss next).

The management PC or other system that you use to connect to the Azure portal has the following requirements:

- The [Microsoft Edge](https://www.microsoft.com/edge) or Google Chrome web browser
- Access to the virtual network that's connected to the VM (this is more secure than using a public IP address to connect). There are many ways to connect to a virtual network, including by using a [VPN gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways).

## Installing in a VM

Before you can use Windows Admin Center in the Azure portal, you must install it in the VM you want to manage. Here's how:

1. Open the Azure portal and navigate to your VM's settings.
2. If the VM has all outbound internet traffic blocked, create an outbound port rule to connect to the Windows Admin Center service. <br>To do so, in the virtual machine settings, navigate to **Networking** > **Outbound port rules**, select **Add outbound port rule**, enter the following values, and then select **Add**.

   | Field                        | Value              |
   | --------------------------   | ------------------ |
   | **Source**                   | VirtualNetwork     |
   | **Source port ranges**       | *                  |
   | **Destination**              | IP Addresses       |
   | **Destination IP addresses** | `20.66.2.0`        |
   | **Service**                  | HTTPS              |
   | **Action**                   | Allow              |

3. In the virtual machine settings, navigate to **Windows Admin Center** (found in the **Settings** group).
4. To optionally provide access to your VM over the public internet from any IP address (convenient for testing but exposes the VM to attack from any host on the internet), you can select **Open this port for me**.
<br>However, we recommend instead using a private IP address to connect with, or at least [manually creating an inbound port rule](#creating-an-inbound-port-rule-for-connecting-from-specific-public-ip-addresses) that's locked down to accept traffic from only the IP addresses you specify.
5. Select **Install**.<br>Installing takes a few minutes. If you selected **Open this port for me** or manually created an inbound port rule in the last couple minutes, it might take another couple minutes before you can connect with Windows Admin Center.

:::image type="content" source="../../media/wac-in-azure/install-windows-admin-center.png" alt-text="Screenshot showing the install button for Windows Admin Center on a VM." lightbox="../../media/wac-in-azure/install-windows-admin-center.png":::

## Using with a VM

After you've installed Windows Admin Center in an Azure VM, here's how to connect to it and use it to manage Windows Server:

1. Open the Azure portal and navigate to your VM, then Windows Admin Center.
2. If you're connecting using a private IP address, select the IP address you want to use when connecting to the VM, and then select **Connect**.
3. Enter credentials for an account with local Administrator permissions on the VM's operating system, and then select **Sign in**.<br>Windows Admin Center opens in the portal, giving you access to the same tools you might be familiar with from using Windows Admin Center in an on-premises deployment.

:::image type="content" source="../../media/wac-in-azure/connect-to-vm.png" alt-text="Screenshot showing a VM's settings and connecting to Windows Admin Center by private IP address. "lightbox="../../media/wac-in-azure/connect-to-vm.png":::

If you see a "Failed to connect" message and you installed Windows Admin Center or created an inbound port rule for it within the last couple minutes, wait another minute or two and try again--it can take a couple minutes for the rule to propagate.

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

## Implementation details

Windows Admin Center is currently implemented in the Azure portal in the form of an extension that we install on each Azure VM with which you want to use Windows Admin Center.

This extension connects to an external service that manages certificates and DNS records so that you can easily connect to your VM.

Each Azure VM that uses the Windows Admin Center extension gets a public DNS record that Microsoft maintains in Azure DNS. We hash the record name with a salt to anonymize the VM's IP address when saving it in DNS - the IP addresses aren't saved in plain text in DNS. This DNS record is used to issue a certificate for Windows Admin Center on the VM, enabling encrypted communication with the VM.

## Troubleshooting

Here are some tips to try in case something isn't working. For general help troubleshooting Windows Admin Center (not specifically in Azure), see [Troubleshooting Windows Admin Center](../support/troubleshooting.md).

### Failed to connect error

1. In a new tab, open `https://<ip_address>:<port>`. If this page loads successfully with a certificate error, create a support request.<br>If this page doesn't load successfully, there's something wrong with your connection to Windows Admin Center itself. Make sure that you are connected to the correct Vnet and are using the correct IP address before trying further troubleshooting.
1. If you are using a Public IP address, make sure that the port you selected upon installation is open to the internet. By default, the port is set to 6516. In your virtual machine, navigate to “Networking” > “Add inbound port rule”.
1. Make sure that the port can be reached.
    1. In the Azure portal, navigate to “Networking” and make sure that there are no conflicting rules with a higher priority that could be blocking the Windows Admin Center port
    1. In the Azure portal, navigate to “Connection troubleshoot” to test that your connection is working and the port can be reached.
1. Make sure that outbound traffic to Windows Admin Center is allowed on your virtual machine
    1. In the Azure portal, navigate to “Networking” and “Outbound port rules”.
    1. Create a new port rule for Windows Admin Center
    1. You can test this by running the following command using PowerShell inside of your virtual machine:

       ```powershell
       Invoke-RestMethod -Method GET -Uri https://wac.azure.com
       ```

       This should return:

       `You've found the Windows Admin Center in Azure APIs' home page. Please use the Azure portal to manage your virtual machines with Windows Admin Center.`

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
    1. If this doesn’t load, there might be something wrong with your installation. Go back to the Azure portal, navigate to “Extensions”, and uninstall the Admin Center extension. Navigate back to “Windows Admin Center (preview” and reinstall the extension.
1. Check that the firewall rule is open for SmeInboundOpenException.
    1. In the Azure portal, navigate to “Connect” > “RDP” > “Download RDP File”.
    1. Open the RDP file and sign in with your administrator credentials.
    1. Open the Control Panel and navigate to Control Panel\System and Security\Windows Defender Firewall\Allowed apps.
    1. Ensure that the SmeInboundOpenException rule is enabled for both Private and Public, then try to connect again.

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
        Invoke-RestMethod -Method GET -Uri https://wac.azure.com
        ```

        This should return:

        `You've found the Windows Admin Center in Azure APIs' home page. Please use the Azure portal to manage your virtual machines with Windows Admin Center.`
1. If you have allowed all outbound traffic, and are getting an error from the command above, check that there are no firewall rules blocking the connection.

If nothing seems wrong and Windows Admin Center still won't install, open a support request with the following information:

- Logs in the Azure portal. This can be found under Settings > Extensions > AdminCenter > View Detailed Status
- Logs in the VM. Share the logs from the following locations:
  - C:\WindowsAzure\Logs\Plugins\AdminCenter
  - C:\Packages\Plugins\AdminCenter
- Network trace, if appropriate. Network traces can contain customer data and sensitive security details, such as passwords, so we recommend reviewing the trace and removing any sensitive details before sharing it.

## Known issues

- If you change any of your networking rules, it takes Windows Admin Center about a minute or so to update its networking. The connection may fail for a few minutes.
- If you just started your virtual machine, it takes about a minute for the IP address to be registered with Windows Admin Center and thus, it may not load.
- The first load time of Windows Admin Center might be a little longer. Any subsequent load will be just a few seconds.
- Chrome Incognito mode isn't supported.

## Frequently asked questions

### How much does it cost to use Windows Admin Center?

There is no cost to using the Windows Admin Center in the Azure portal.

### Can I use Windows Admin Center to manage the virtual machines running on my Azure VM?

You can install the Hyper-V role using the Roles and Features extension. Once installed, refresh your browser, and Windows Admin Center will show the Virtual Machine and Switch extensions.

### What servers can I manage using this extension?

You can use the extension to manage VMs running Windows Server 2016 or higher.

### How does Windows Admin Center handle security?

Traffic from the Azure portal to Windows Admin Center running on your VM uses HTTPS. Your Azure VM is managed using PowerShell and WMI over WinRM.

### For an inbound port, why must I open a port and why should the source be set to “Any”? 

Windows Admin Center installs on your Azure Virtual Machine. The installation consists of a web server and a gateway. By publishing the web server to DNS and opening the firewall (the inbound port in your VM), you can access Windows Admin Center from the Azure portal. The rules for this port perform very similar to the “RDP” port. If you don’t wish to open this port up to “Any”, we recommend specifying the rule to the IP address of the machine used to open the Azure portal.

### Why must I create an outbound port rule?

There is an external Windows Admin Center service that manages certificates and DNS records for you. To allow your VM to interact with our service, you must create an outbound port rule.

### How do I find used for Windows Admin Center installation?

There are two ways to find out the port:

- Navigate to the Windows Admin Center (Preview) extension in the Azure portal. Try to connect via an IP address that will result in a failed connection.
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

Yes, you can use Windows Admin Center on-premises to manage servers and virtual machines on-premises and in Azure. For details, see [Manage Azure VMs with Windows Admin Center](manage-azure-vms.md).

### Does Windows Admin Center in the Azure portal work with Azure Bastion?

No, unfortunately not.

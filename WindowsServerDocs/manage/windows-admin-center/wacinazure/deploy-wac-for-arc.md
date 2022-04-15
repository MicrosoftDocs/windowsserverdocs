---
title: Use Windows Admin Center in the Azure portal to manage Arc-enabled Windows Server machines from anywhere
description: An overview of using Windows Admin Center in the Azure portal to manage the Windows Server OS on an Arc-enabled server. Includes the functionality provided, requirements, and how to install Windows Admin Center and use it to manage your Arc-enabled server. Also provides troubleshooting tips.
ms.topic: overview
author: prasidharora
ms.author: praror
ms.date: 04/14/2022
---
# Use Windows Admin Center to manage your Arc-enabled servers from the Azure Portal

You can now use Windows Admin Center (preview) in the Azure portal to manage the Windows Server operating system of your on-premises Arc-enabled infrastructure (hereby referred to as “hybrid machine”). Using this functionality, you can securely manage the Windows Server operating system from anywhere – without needing a VPN, public IP address or other inbound connectivity to your machine. 

The Windows Admin Center extension provides Azure users with granular management, configuration, troubleshooting, and maintenance functionality for managing your Arc-enabled servers in the Azure Portal. Windows Server infrastructure and workload management will no longer require you to establish line-of-sight or RDP – it can all be done natively from the Azure Portal. Windows Admin Center provides tools that you would normally find in Server Manager, Device Manager, Task Manager, and Hyper-V Manager and most other MMC tools.

This article provides an overview of the functionality provided, requirements, and how to install Windows Admin Center and use it to manage your hybrid machine. It also answers frequently asked questions, and provides a list of known issues and tips for troubleshooting in case something doesn't work.

:::image type="content" source="../../media/manage-vm/wac-in-azure-arc-overview.png" alt-text="Screenshot showing Windows Admin Center in the Azure portal for Arc-enabled server, displaying the Windows admin Center Overview page." lightbox="../../media/manage-vm/wac-in-azure-arc-overview.png":::

## Overview of functionality

Windows Admin Center in the Azure portal provides the essential set of management tools for managing Windows Server on a single hybrid machine without requiring any inbound port on your firewall:

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
- Virtual Machine
- Virtual Switches

We don't support additional extensions to Windows Admin Center in the Azure portal at this time.

If you manually installed Windows Admin Center on your hybrid machine manage multiple systems, enabling this capability will replace your existing instance of Windows Admin Center and removes the capability to manage other machines. You will lose access to your previously deployed instance of Windows Admin Center.

## Requirements

To use Windows Admin Center in the Azure portal, we install a small Windows Admin Center agent on each hybrid machine you wish machine via an Azure VM extension. The hybrid machine has the following requirements:

- Windows Server 2016 or higher 
- At least 3 GiB of memory
- Be in any region of an Azure public cloud (it's not supported in Azure China, Azure Government, or other non-public clouds)
- Running the latest Azure Arc agent

The hybrid machine also has the following networking requirements:
- Outbound internet access or an outbound port rule allowing HTTPS traffic to the following endpoints:
<br>- `*.wac.azure.com`
<br>- `pas.windows.net`
<br>- `azgn*.servicebus.windows.net`


> [!NOTE]
> No Inbound ports or connectivity is required

The management PC or other system that you use to connect to the Azure portal has the following requirements:

- The [Microsoft Edge](https://www.microsoft.com/edge) or Google Chrome web browser


## Setting up

Before you can use Windows Admin Center in the Azure portal, you must deploy the Windows Admin Center VM extension:
1.	Open the Azure portal and navigate to your Arc-enabled server
2.	Navigate to **Windows Admin Center** (found in the **Settings** group).
3.	Specify the port on which you wish to install Windows Admin Center and select **Install**.

:::image type="content" source="../../media/manage-vm/wac-in-azure-arc-install.png" alt-text="Screenshot showing the install button for Windows Admin Center on an Arc-enabled server." lightbox="../../media/manage-vm/wac-in-azure-arc-install.png":::

## Connecting

After you've installed Windows Admin Center on your hybrid machine, here's how to connect to it and use it to manage Windows Server:
1.	Open the Azure portal and navigate to your Arc-enabled server, then **Windows Admin Center (preview)**.
2.	Select **Connect**.
3.	Enter credentials for an account with local Administrator permissions on the hybrid machine’s operating system, and then select **Sign in**.
<br> Windows Admin Center opens in the portal, giving you access to the same tools you might be familiar with from using Windows Admin Center in an on-premises deployment.

:::image type="content" source="../../media/manage-vm/wac-in-azure-arc-connect.png" alt-text="Screenshot showing the Connect button for Windows Admin Center on an Arc-enabled server." lightbox="../../media/manage-vm/wac-in-azure-arc-connect.png":::

## How it works

This feature provides connectivity to your hybrid machine via Windows Admin Center without requiring any inbound port to be enabled on the firewall. Windows Admin Center, via the Arc agent, is able to securely establish a reverse proxy session connection with the Azure Arc service in an outbound manner.

Windows Admin Center is currently implemented in the Azure Portal in the form of an agent (or “extension”) that we install on each hybrid machine with which you want to use Windows Admin Center.

The agent communicates to an external service that manages certificates so that you can easily connect to your hybrid machine.
Clicking **Install** does the following 3 actions:

1.	Registers the new “Hybrid Connectivity” RP on your subscription. The Hybrid Connectivity RP hosts the proxy used for communication to your Arc-enabled server.
2.	Deploys an Azure “endpoint” resource on top of your Arc-enabled resource that enables a reverse proxy connection on the specified port. Note that this is simply a logical resource in Azure, and does not deploy anything on your server itself.
3.	Installs the Windows Admin Center agent on your hybrid machine with a valid TLS certificate

> [!NOTE]
> Uninstalling Windows Admin Center does not delete the logical Azure “endpoint” resource. This is kept for other experiences that might leverage this resource, such as SSH.

Clicking **Connect** does the following actions:
1.	The Azure Portal asks the Hybrid Connectivity RP for access to the Arc-enabled server
2.	The Hybrid Connectivity RP communicates with an L4 SNI proxy to establish a short-lived session-specific access to your Arc-enabled server on the Windows Admin Center port
3.	A unique short-lived URL is generated and connection to Windows Admin Center is established from the Portal

Connection to Windows Admin Center is end-to-end encrypted with SSL termination happening on your hybrid machine. 

## Troubleshooting

Here are some tips to try in case something isn't working. For general help troubleshooting Windows Admin Center (not specifically in Azure), see [Troubleshooting Windows Admin Center](../support/troubleshooting.md).

### Failed to connect error

1. Make sure that the Windows Admin Center service is running on your machine
    1. RDP into your server
    1. Open Task Manager (Ctrl+Shift+Esc) and navigate to “Services”
    1. Make sure ServerManagementGateway / Windows Admin Center is Running.
    1. If it is not, please start the service.

1. Check that your installation is in a good state
    1. RDP into your server
    1. Open a browser and type `https://localhost:<port>` replacing `<port>` with the port on which you installed Windows Admin Center. Not sure what port you installed it on? Check out the Frequently Asked Questions below.
    1. If this doesn’t load, open Task Manager > Details and end the Sme.exe process. Try loading `https://localhost:<port>` on your browser again.
    1. If this still doesn’t load, there might be something wrong with your installation. Please go back to the Azure Portal, navigate to “Extensions”, and uninstall the Admin Center extension. Navigate back to “Windows Admin Center (preview)” and reinstall the extension.

1. Check that the port is enabled for reverse proxy session
    1. RDP into your server
    1. This should return a list of ports under the incomingconnections.ports (preview) configuration that are enabled to be connected from Azure. Confirm that the port on which you installed Windows Admin Center is on this list. For example, if Windows Admin Center was installed on port 443, the result would be:
        `Local configuration setting`
        `incomingconnections.ports (preview): 443`
    1. In the event it is not on this list, run
        ```powershell
        azcmagent config set incomingconnections.ports <port>
        ```
    1. Note that if you are using another experience (like SSH) using this solution, you can specify multiple ports separated by a comma
1. Ensure you have outbound connectivity to the necessary ports
    1. The hybrid machine should have outbound connectivity to the following endpoints:
        a. *.wac.azure.com
        b. pas.windows.net
        c. azgn*.servicebus.windows.net

### One of the Windows Admin Center tools isn’t loading or gives an error

Navigate to any other tool in Windows Admin Center and navigate back to the one that isn’t loading.

If no other tool is loading, there might be a problem with your network connectivity. Try closing the blade and then connecting again. If this doesn’t work, open a support ticket.

### The Windows Admin Center extension failed to install

1. Double-check to make sure that the hybrid machine meets the [requirements](#requirements).
1. Make sure that outbound traffic to Windows Admin Center is allowed on your hybrid machine
    1. Test connectivity by running the following command using PowerShell inside of your virtual machine:

        ```powershell
        Invoke-RestMethod -Method GET -Uri https://wac.azure.com
        ```

        This should return:

        `You've found the Windows Admin Center in Azure APIs' home page. Please use the Azure portal to manage your virtual machines with Windows Admin Center.`
1. If you have allowed all outbound traffic, and are getting an error from the command above, check that there are no firewall rules blocking the connection.

If nothing seems wrong and Windows Admin Center still won't install, open a support request with the following information:

- Logs in the Azure portal. This can be found under Settings > Extensions > AdminCenter > View Detailed Status
- Logs in the hybrid machine.Run:
    ```powershell
    azcmagent logs
    ```
    and share the resulting .zip file
- Network trace, if appropriate. Network traces can contain customer data and sensitive security details, such as passwords, so we recommend reviewing the trace and removing any sensitive details before sharing it.

## Known issues

- Chrome incognito mode isn't supported
- Azure portal desktop app is not supported
- Detailed error messages for a failed connection is not available yet

## Frequently asked questions

### How much does it cost to use Windows Admin Center?

There is no cost to using the Windows Admin Center in the Azure portal.

### Can I use Windows Admin Center to manage the virtual machines running on my server?

You can install the Hyper-V role using the Roles and Features extension. Once installed, refresh your browser, and Windows Admin Center will show the Virtual Machine and Switch extensions.

### What servers can I manage using this extension?

You can use the capability to manage Arc-enabled Windows Server 2016 and higher. You can also manage Azure Stack HCI, see [Use Windows Admin Center in Azure to manage Azure Stack HCI](../wacinazure/deploy-wac-for-hci.md)

### How does Windows Admin Center handle security?

Traffic from the Azure Portal to Windows Admin Center is end-to-end encrypted. Your Arc-enabled server is managed using PowerShell and WMI over WinRM. Please email us if you’re looking for more information.

### Do I need an inbound port to use Windows Admin Center? 

No inbound connection is required to use Windows Admin Center.

### Why must I create an outbound port rule?

An outbound port rule is required for the service that we have built to communicate with your server. Our service issues you a certificate free-of-cost for your instance of Windows Admin Center. This service ensures that you can always connect to your instance of Windows Admin Center from the Azure Portal by keeping your WAC certificate up to date.

Furthermore, accessing Windows Admin Center from Azure requires no inbound port and only outbound connectivity via a reverse proxy solution. These outbound rules are required in order to establish the connection.

### How do I find the port used for Windows Admin Center installation?

RDP into your server, open the Registry Editor on your server and look for the “SmePort” registry key in “\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManagementGateway”

### Can I use PowerShell or the Azure CLI to install the extension on my VM?

Yes:

- PowerShell: [New-AzConnectedMachineExtension](/azure/azure-arc/servers/manage-vm-extensions-powershell)
- Azure CLI: [az connectedmachine extension create](/azure/azure-arc/servers/manage-vm-extensions-cli)

### I already have Windows Admin Center installed on my Arc server. Can I access it from the portal?

Yes. You can follow the same steps outlined in this document. Note that your instance of Windows Admin Center will no longer be usable. Please don’t do this if you use your instance of Admin Center to manage multiple servers.

### Is there any documentation on the general functionality of Windows Admin Center and its tools?

Yes, see [Windows Admin Center overview](../overview.md) and [Manage Servers](../use/manage-servers.md).
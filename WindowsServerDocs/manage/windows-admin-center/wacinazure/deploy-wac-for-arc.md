---
title: Manage Azure Arc-enabled Servers using Windows Admin Center in Azure preview
description: Learn how to deploy and troubleshoot Windows Admin Center in the Azure portal to connect and manage Arc-enabled Windows Server
ms.topic: overview
author: prasidharora
ms.author: praror
ms.date: 04/14/2022
---
# Use Windows Admin Center to manage your Arc-enabled servers from the Azure portal (preview)

> [!IMPORTANT]
> Windows Admin Center in the Azure portal is currently in preview.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Using Windows Admin Center in the Azure portal you can manage the Windows Server operating system of your Arc-enabled servers, known as hybrid machines. You can securely manage hybrid machines from anywhere – without needing a VPN, public IP address or other inbound connectivity to your machine.

The Windows Admin Center extension provides Azure users with granular management, configuration, troubleshooting, and maintenance functionality for managing your Arc-enabled servers in the Azure portal. Windows Server infrastructure and workload management will no longer require you to establish line-of-sight or RDP – it can all be done natively from the Azure portal. Windows Admin Center provides tools that you would normally find in Server Manager, Device Manager, Task Manager, and Hyper-V Manager and most other MMC tools.

This article provides an overview of the functionality provided, requirements, and how to install Windows Admin Center in the Azure portal  and use it to manage your hybrid machine. It also answers frequently asked questions, and provides a list of known issues and tips for troubleshooting in case something doesn't work.

:::image type="content" source="../../media/manage-vm/wac-in-azure-arc-overview.png" alt-text="Screenshot showing Windows Admin Center in the Azure portal for Arc-enabled server, displaying the Windows admin Center Overview page." lightbox="../../media/manage-vm/wac-in-azure-arc-overview.png":::

## Overview of functionality

Windows Admin Center in the Azure portal provides essential tools for managing Windows Server running on a single hybrid machine. Hybrid machines can be managed without the need to open any inbound ports on your firewall.

Using Windows Admin Center in the Azure portal you can manage:

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
- Roles and Features
- Scheduled tasks
- Services
- Storage
- Updates
- Virtual machines
- Virtual switches

We don't support other extensions for Windows Admin Center in the Azure portal at this time.

> [!WARNING]
> If you manually installed Windows Admin Center on your hybrid machine to manage multiple systems, enabling this capability will replace your existing instance of Windows Admin Center and removes the capability to manage other machines. You will lose access to your previously deployed instance of Windows Admin Center.

## Requirements

Before you can start using the Windows Admin Center in the Azure portal to manage a hybrid machine, there are a few things that you'll need.

### Azure account with an active subscription

You'll need an Azure account with an active subscription to deploy Azure Virtual Desktop. If you don't have one already, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

During the deployment of Windows Admin Center will attempt to register the *Microsoft.HybridConnectivity* resource provider for your subscription.  

> [!IMPORTANT]
> You must have permission to register a resource provider, which requires the `*/register/action` operation. This is included if you are assigned the [contributor or owner role](/azure/role-based-access-control/built-in-roles) on your subscription.

> [!NOTE]
> Resource provider registration is a one time task per subscription.

To check the status of the resource provider and register if needed:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Select **Subscriptions**.
1. Select the name of your subscription.
1. Select **Resource providers**.
1. Search for **Microsoft.HybridConnectivity**.
1. If the status is *NotRegistered*, select **Microsoft.HybridConnectivity**, and then select **Register**.
1. Verify that the status of Microsoft.DesktopVirtualization is **Registered**.

#### Azure permissions required

To install the Windows Admin Center extension for an Arc-enabled server resource, your account must be granted the **Owner**, **Contributor**, or **Windows Admin Center Administrator Login** role in Azure.

Connecting to Windows Admin center requires **Windows Admin Center Administrator Login** permissions at the Arc-enabled server resource.

[Learn more about assigning Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal)

### Hybrid machine

To use Windows Admin Center in the Azure portal, the Windows Admin Center agent must be installed on each hybrid machine you wish to manage via an Azure VM extension. The hybrid machine should meet the following requirements:

- Windows Server 2016 or later
- 3 GB of RAM or more
- Azure Arc agent version 1.13.21320.014 or later

> [!NOTE]
> Windows Admin Center isn't supported in Azure China 21Vianet, Azure Government, or other non-public clouds

## Networking

The hybrid machine should also meet the following networking requirements:

- Outbound internet access or an outbound port rule allowing HTTPS traffic to the following endpoints:

  - `*.wac.azure.com` or the `WindowsAdminCenter` [service tag](/azure/virtual-network/service-tags-overview) when using hybrid machines in Azure
  - `pas.windows.net`
  - `*.servicebus.windows.net`

> [!NOTE]
> No Inbound ports are required in order to use Windows Admin Center.

Make sure you review the [supported devices and recommended browsers](/azure/azure-portal/azure-portal-supported-browsers-devices) before accessing the Azure portal from the management machine or system.

## Deployment

Before you can use Windows Admin Center in the Azure portal, you must deploy the Windows Admin Center VM extension using the following steps:

1. Open the Azure portal and navigate to your Arc-enabled server.
2. Navigate to **Windows Admin Center**, which can be found in the **Settings** group.
3. Specify the port on which you wish to install Windows Admin Center and select **Install**.

:::image type="content" source="../../media/manage-vm/wac-in-azure-arc-install.png" alt-text="Screenshot showing the install button for Windows Admin Center on an Arc-enabled server." lightbox="../../media/manage-vm/wac-in-azure-arc-install.png":::

## Connecting

After you've installed Windows Admin Center on your hybrid machine, here's how to connect to it and use it to manage Windows Server:

1. Open the Azure portal and navigate to your Arc-enabled server, then **Windows Admin Center (preview)** in the **Settings** group.
2. Select **Connect**.
3. Enter credentials for an account with local Administrator permissions on the hybrid machine’s operating system, and then select **Sign in**.

Windows Admin Center opens in the portal, giving you access to the same tools you might be familiar with from using Windows Admin Center in an on-premises deployment.

:::image type="content" source="../../media/manage-vm/wac-in-azure-arc-connect.png" alt-text="Screenshot showing the Connect button for Windows Admin Center on an Arc-enabled server." lightbox="../../media/manage-vm/wac-in-azure-arc-connect.png":::

## How it works

This feature provides connectivity to your hybrid machine via Windows Admin Center without requiring any inbound port to be enabled on the firewall. Windows Admin Center, via the Arc agent, is able to securely establish a reverse proxy session connection with the Azure Arc service in an outbound manner.

For each hybrid machine that you want to manage with Windows Admin Center in the Azure portal, an agent must be deployed.

The agent communicates to an external service that manages certificates so that you can easily connect to your hybrid machine.

Clicking **Install** does the following actions:

1. Registers the *Microsoft.HybridConnectivity* resource provider on your subscription. The resource provider hosts the proxy used for communication to your Arc-enabled server.
2. Deploys an Azure *endpoint* resource on top of your Arc-enabled resource that enables a reverse proxy connection on the specified port. This is simply a logical resource in Azure, and doesn't deploy anything on your server itself.
3. Installs the Windows Admin Center agent on your hybrid machine with a valid TLS certificate.

> [!NOTE]
> Uninstalling Windows Admin Center does not delete the logical Azure endpoint resource. This is kept for other experiences that might leverage this resource, such as SSH.

Clicking **Connect** does the following actions:

1. The Azure portal asks the *Microsoft.HybridConnectivity* resource provider for access to the Arc-enabled server.
2. The resource provider communicates with a Layer 4 SNI proxy to establish a short-lived session-specific access to your Arc-enabled server on the Windows Admin Center port.
3. A unique short-lived URL is generated and connection to Windows Admin Center is established from the Portal.

Connection to Windows Admin Center is end-to-end encrypted with SSL termination happening on your hybrid machine.

## Troubleshooting

Here are some tips to try in case something isn't working. For general help troubleshooting Windows Admin Center (not specifically in Azure), see [Troubleshooting Windows Admin Center](../support/troubleshooting.md).

### Failed to connect error

1. Make sure that the Windows Admin Center service is running on your machine.
    1. RDP into your server.
    1. Open **Task Manager (Ctrl+Shift+Esc)** and navigate to **Services**.
    1. Make sure **ServerManagementGateway / Windows Admin Center** is running.
    1. If it isn't running, start the service.

1. Check that your installation is in a good state.
    1. RDP into your server.
    1. Open a browser and type `https://localhost:<port>` replacing `<port>` with the port on which you installed Windows Admin Center. Not sure what port you installed it on? Check out the Frequently Asked Questions below.
    1. If this doesn’t load, open Task Manager > Details and end the Sme.exe process. Try loading `https://localhost:<port>` on your browser again.
    1. If this still doesn’t load, there might be something wrong with your installation. Go back to the Azure portal, navigate to “Extensions”, and uninstall the Admin Center extension. Navigate back to “Windows Admin Center (preview)” and reinstall the extension.

1. Check that the port is enabled for reverse proxy session.
    1. RDP into your server.
    1. Open PowerShell as an administrator and run:

        ```powershell
        azcmagent config list
        ```

    1. This should return a list of ports under the incomingconnections.ports (preview) configuration that are enabled to be connected from Azure. Confirm that the port on which you installed Windows Admin Center is on this list. For example, if Windows Admin Center is installed on port 443, the result would be:

        ```Output
        Local configuration setting
        incomingconnections.ports (preview): 443
        ```

    1. In the event it isn't on this list, run

        ```powershell
        azcmagent config set incomingconnections.ports <port>
        ```

        If you're using another experience (like SSH) using this solution, you can specify multiple ports separated by a comma.

1. Ensure you have outbound connectivity to the necessary ports
    1. The hybrid machine should have outbound connectivity to the following endpoints:
       - `*.wac.azure.com` or the WindowsAdminCenter ServiceTag
       - `pas.windows.net`
       - `*.servicebus.windows.net`

### One of the Windows Admin Center tools isn’t loading or gives an error

1. Navigate to any other tool in Windows Admin Center and navigate back to the one that isn’t loading.

1. If no other tool is loading, there might be a problem with your network connectivity. Try closing the blade and then connecting again. If this doesn’t work, open a support ticket.

### The Windows Admin Center extension failed to install

1. Double-check to make sure that the hybrid machine meets the [requirements](#requirements).
1. Make sure that outbound traffic to Windows Admin Center is allowed on your hybrid machine
    1. Test connectivity by running the following command using PowerShell inside of your virtual machine:

        ```powershell
        Invoke-RestMethod -Method GET -Uri https://wac.azure.com
        ```

        ```Expected output
        You've found the Windows Admin Center in Azure APIs' home page. Please use the Azure portal to manage your virtual machines with Windows Admin Center.
        ```

1. If you've allowed all outbound traffic and are getting an error from the command above, check that there are no firewall rules blocking the connection.

If nothing seems wrong and Windows Admin Center still won't install, open a support request with the following information:

- Logs from the Azure portal. Windows Admin Center logs can be found under **Settings > Extensions > AdminCenter > View Detailed Status**.
- Logs in the hybrid machine. Run the following PowerShell command and share the resulting .zip file.

    ```powershell
    azcmagent logs
    ```

- Network trace, if appropriate. Network traces can contain customer data and sensitive security details, such as passwords, so we recommend reviewing the trace and removing any sensitive details before sharing it.

## Known issues

- Chrome incognito mode isn't supported.
- Azure portal desktop app isn't supported.
- Detailed error messages for failed connections aren't yet available.

## Frequently asked questions

### How much does it cost to use Windows Admin Center?

There's no cost to using the Windows Admin Center in the Azure portal.

### Can I use Windows Admin Center to manage the virtual machines running on my server?

You can install the Hyper-V role using the Roles and Features extension. Once installed, refresh your browser, and Windows Admin Center will show the Virtual Machine and Switch extensions.

### What servers can I manage using this extension?

You can use the capability to manage Arc-enabled Windows Server 2016 and later. You can also [use Windows Admin Center in Azure to manage Azure Stack HCI](../wacinazure/deploy-wac-for-hci.md).

### How does Windows Admin Center handle security?

Traffic from the Azure portal to Windows Admin Center is end-to-end encrypted. Your Arc-enabled server is managed using PowerShell and WMI over WinRM.

### Do I need an inbound port to use Windows Admin Center?

No inbound connection is required to use Windows Admin Center.

### Why must I create an outbound port rule?

An outbound port rule is required for the service that we have built to communicate with your server. Our service issues you a certificate free-of-cost for your instance of Windows Admin Center. This service ensures that you can always connect to your instance of Windows Admin Center from the Azure portal by keeping your WAC certificate up to date.

Furthermore, accessing Windows Admin Center from Azure requires no inbound port and only outbound connectivity via a reverse proxy solution. These outbound rules are required in order to establish the connection.

### How do I find the port used for Windows Admin Center installation?

To verify the value of SmePort registry setting:

1. RDP into your server
1. Open the **Registry Editor**
1. Navigate to the key `\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManagementGateway`
1. Read the value of `SmePort` to find the port used

### Can I use PowerShell or the Azure CLI to install the extension on my VM?

Yes, to install the extension:

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following command:

```powershell
New-AzConnectedMachineExtension 
```

Learn more about how to [enable Azure VM extensions using PowerShell](/azure/azure-arc/servers/manage-vm-extensions-powershell).

# [Azure CLI](#tab/azcli)

From a command prompt, run the following command:

```azurecli
az connectedmachine extension create
```

Learn more about how to [enable Azure VM extensions using the Azure CLI](/azure/azure-arc/servers/manage-vm-extensions-cli).

---

### I already have Windows Admin Center installed on my Arc server. Can I access it from the portal?

Yes. You can follow the same steps outlined in this document.

> [!WARNING]
> Enabling this capability will replace your existing instance of Windows Admin Center and removes the capability to manage other machines. Your previously deployed instance of Windows Admin Center will no longer be usable. Please don’t do this if you use your instance of Admin Center to manage multiple servers.

### Is there any documentation on the general functionality of Windows Admin Center and its tools?

Yes, see [Windows Admin Center overview](../overview.md) and [Manage Servers](../use/manage-servers.md).

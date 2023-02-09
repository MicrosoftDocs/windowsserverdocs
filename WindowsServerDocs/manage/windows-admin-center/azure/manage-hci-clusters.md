---
title: Manage Azure Stack HCI clusters with Windows Admin Center in Azure (preview)
description: Learn how to use Windows Admin Center in the Azure portal to connect and manage Azure Stack HCI.
ms.topic: overview
author: prasidharora
ms.author: praror
ms.date: 05/06/2022
---
# Manage Azure Stack HCI clusters using Windows Admin Center in Azure (preview)

>Applies to Azure Stack HCI, version 21H2 and later

> [!IMPORTANT]
> Windows Admin Center in the Azure portal is currently in preview.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Using Windows Admin Center in the Azure portal you can manage the Azure Stack HCI operating system of your cluster. You can securely manage your cluster from anywhere–without needing a VPN, public IP address, or other inbound connectivity to your machine.

With Windows Admin Center extension in Azure, you get the management, configuration, troubleshooting, and maintenance functionality for managing your Azure Stack HCI cluster in the Azure portal. Azure Stack HCI cluster and workload management no longer require you to establish line-of-sight or Remote Desktop Protocol (RDP)–it can all be done natively from the Azure portal. Windows Admin Center provides tools that you'd normally find in Failover cluster manager, Device Manager, Task Manager, Hyper-V Manager, and most other Microsoft Management Console (MMC) tools.

This article provides an overview of using Windows Admin Center in the Azure portal, requirements, and how to install Windows Admin Center and use it to manage your cluster. It also answers frequently asked questions, and provides a list of known issues and tips for troubleshooting in case something doesn't work.

:::image type="content" source="../../media/manage-vm/windows-admin-center-in-azure-hci-dashboard.png" alt-text="Screenshot showing Windows Admin Center in the Azure portal for an Azure Stack HCI cluster, displaying the Windows Admin Center Dashboard page." lightbox="../../media/manage-vm/windows-admin-center-in-azure-hci-dashboard.png":::

## Overview of Windows Admin Center in Azure

Windows Admin Center in the Azure portal provides essential tools for managing your Azure Stack HCI cluster. You can manage clusters without the need to open any inbound port on your firewall.

Using Windows Admin Center in the Azure portal, you can manage:

- Servers
- Volumes
- Drives
- SDN infrastructure
- Diagnostics
- Security
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
> If you manually installed Windows Admin Center on your cluster to manage multiple systems, enabling Windows Admin Center in Azure will replace your existing instance of Windows Admin Center and removes the capability to manage other machines. You will lose access to your previously deployed instance of Windows Admin Center.

## Requirements

This section provides the requirements for using Windows Admin Center in the Azure portal to manage a hybrid machine:

- [Azure account with an active subscription](#azure-account-with-an-active-subscription)
- [Azure permissions](#azure-permissions)
- [Azure region availability](#azure-region-availability)
- [Azure Stack HCI requirements](#azure-stack-hci-requirements)
- [Networking requirements](#networking-requirements)

### Azure account with an active subscription

You'll need an Azure account with an active subscription to deploy Windows Admin Center. If you don't have one already, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

During the deployment of Windows Admin Center,  you'll register the *Microsoft.HybridConnectivity* resource provider for your subscription.  

> [!IMPORTANT]
> You must have permission to register a resource provider, which requires the `*/register/action` operation. This is included if you are assigned the [contributor or owner role](/azure/role-based-access-control/built-in-roles) on your subscription.

> [!NOTE]
> Resource provider registration is a one time task per subscription.

To check the status of the resource provider, and register if needed:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Select **Subscriptions**.
1. Select the name of your subscription.
1. Select **Resource providers**.
1. Search for **Microsoft.HybridConnectivity**.
1. Verify that the status of Microsoft.HybridConnectivity is **Registered**.
    1. If the status is *NotRegistered*, select **Microsoft.HybridConnectivity**, and then select **Register**.

### Azure permissions

Connecting to Windows Admin center requires you to have **Reader** and **Windows Admin Center Administrator Login** permissions at the Arc-enable Azure Stack HCI resource.

[Learn more about assigning Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

### Azure region availability

Windows Admin Center is supported in the following Azure regions:

- East US
- West Europe
- Southeast Asia
- Australia East

> [!NOTE]
> Windows Admin Center isn't supported in Azure China 21Vianet, Azure Government, or other non-public clouds

### Azure Stack HCI requirements

To use Windows Admin Center in the Azure portal, the Windows Admin Center agent must be installed on every node of your cluster via an Azure VM extension. Each node of the cluster should meet the following requirements:

- Azure Stack HCI, version 21H2 or later
- 3 GB of memory or more
- The Azure Stack HCI cluster must be [connected to Azure using Azure Arc](/azure-stack/hci/deploy/register-with-azure)
- Azure Arc agent version 1.13.21320.014 or later

### Networking requirements

Every node of the Azure Stack HCI cluster must meet the following networking requirements:

- Outbound internet access or an outbound port rule allowing HTTPS traffic to the following endpoints:

  - `*.wac.azure.com` or the `WindowsAdminCenter` [service tag](/azure/azure-arc/servers/network-requirements#service-tags) (for extension versions less than 0.0.0.203)
  - `*.waconazure.com` or the `WindowsAdminCenter` [service tag](/azure/azure-arc/servers/network-requirements#service-tags) (for extension versions greater than or equal to 0.0.0.203)
  - `pas.windows.net`
  - `*.servicebus.windows.net`

> [!NOTE]
> No inbound ports are required in order to use Windows Admin Center.


> [!NOTE]
> Confiuring Windows Admin Center to communicate through an HTTP/HTTPS proxy server is currently not supported.

The management machine where the Azure Portal is running must meet the following networking requirements:

- Outbound internet access over port `6443`


Make sure you review the [supported devices and recommended browsers](/azure/azure-portal/azure-portal-supported-browsers-devices) before accessing the Azure portal from the management machine or system.

## Install Windows Admin Center in the Azure portal

Before you can use Windows Admin Center in the Azure portal, you must deploy the Windows Admin Center VM extension using the following steps:

1. Open the Azure portal and navigate to your Azure Stack HCI cluster.
2. Under the **Settings** group, select **Windows Admin Center**.
3. Specify the port on which you wish to install Windows Admin Center, and then select **Install**.

:::image type="content" source="../../media/manage-vm/windows-admin-center-in-azure-hci-install.png" alt-text="Screenshot showing the install button for Windows Admin Center on an Azure Stack HCI cluster." lightbox="../../media/manage-vm/windows-admin-center-in-azure-hci-install.png":::

## Connect to Windows Admin Center in the Azure portal

After you've installed Windows Admin Center on your cluster, perform the following steps to connect to it and use it to manage Azure Stack HCI:

1. Open the Azure portal and navigate to your Azure Stack HCI cluster, and then under the **Settings** group, select **Windows Admin Center**.
2. Select **Connect**.
3. Enter credentials for an account with local Administrator permissions on the cluster's operating system, and then select **Sign in**.

Windows Admin Center opens in the portal, giving you access to the same tools you might be familiar with from using Windows Admin Center in an on-premises deployment.

:::image type="content" source="../../media/manage-vm/windows-admin-center-in-azure-hci-connect.png" alt-text="Screenshot showing the Connect button for Windows Admin Center on an Azure Stack HCI cluster." lightbox="../../media/manage-vm/windows-admin-center-in-azure-hci-connect.png":::

## Configuring role assignments

Access to Windows Admin Center is controlled by the **Windows Admin Center Administrator Login** Azure role.

> [!NOTE]
> The Windows Admin Center Administrator Login role uses dataActions and thus cannot be assigned at management group scope. Currently these roles can only be assigned at the subscription, resource group or resource scope.

To configure role assignments for your cluster using the Azure AD Portal experience:

1. Select the **Resource Group** containing the cluster and the associated Azure Arc resources.

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

## How it works

By using Windows Admin Center in Azure, you can connect to your cluster without requiring any inbound port to be enabled on the firewall. Windows Admin Center, via the Arc agent, is able to securely establish a reverse proxy session connection with the Azure Arc service in an outbound manner.

For each Azure Stack HCI cluster that you want to manage with Windows Admin Center in the Azure portal, you must deploy an agent to all the nodes in the cluster.

The agent communicates to an external service that manages certificates so that you can easily connect to your cluster.

Clicking **Install** performs the following actions:

1. Registers the *Microsoft.HybridConnectivity* resource provider on your subscription. The resource provider hosts the proxy used for communication to your Arc-enabled cluster.
2. Deploys an Azure *endpoint* resource on top of each of your Arc-enabled resources in your cluster that enables a reverse proxy connection on the specified port. This is simply a logical resource in Azure, and doesn't deploy anything on your server itself.
3. Installs the Windows Admin Center agent on your hybrid machine with a valid TLS certificate.

> [!NOTE]
> Uninstalling Windows Admin Center does not delete the logical Azure endpoint resource. This is kept for other experiences that might leverage this resource, such as SSH.

Clicking **Connect** performs the following actions:

1. The Azure portal asks the Microsoft.HybridConnectivity resource provider for access to the Arc-enabled server.
2. The resource provider communicates with a Layer 4 SNI proxy to establish a short-lived session-specific access to one of your Arc-enabled nodes of the cluster on the Windows Admin Center port.
3. A unique short-lived URL is generated and connection to Windows Admin Center is established from the Azure portal.

Connection to Windows Admin Center is end-to-end encrypted with SSL termination happening on your cluster.

## Troubleshooting

Here are some tips to try in case something isn't working. For general Windows Admin Center troubleshooting (not specifically in Azure), see [Troubleshooting Windows Admin Center](../support/troubleshooting.md).

### Failed to connect error

1. Restart the HIMDS service.
    1. RDP into each node of your cluster.
    1. Open PowerShell as an administrator and run:

        ```powershell
        Restart-Service -Name himds
        ```
        
1. Make sure that the Windows Admin Center service is running on your cluster.
    1. RDP into each node of your cluster.
    1. Open **Task Manager (Ctrl+Shift+Esc)** and navigate to **Services**.
    1. Make sure **ServerManagementGateway / Windows Admin Center** is running.
    1. If it isn't, start the service.

1. Check that the port is enabled for reverse proxy session.
    1. RDP into each node of your cluster.
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

1. Ensure you have outbound connectivity to the necessary ports.
    1. Each node of your cluster should have outbound connectivity to the following endpoint
       - `*.wac.azure.com` or the WindowsAdminCenter ServiceTag
       - `pas.windows.net`
       - `*.servicebus.windows.net`

### One of the Windows Admin Center tools isn’t loading or gives an error

1. Navigate to any other tool in Windows Admin Center and navigate back to the one that isn’t loading.

1. If no other tool is loading, there might be a problem with your network connectivity. Try closing the blade and then connecting again. If this doesn’t work, open a support ticket.

### The Windows Admin Center extension failed to install

1. Double-check to make sure that the cluster meets the [requirements](#requirements).
1. Make sure that outbound traffic to Windows Admin Center is allowed on each node of your cluster.
    1. Test connectivity by running the following command using PowerShell inside of your virtual machine:

        ```powershell
        Invoke-RestMethod -Method GET -Uri https://wac.azure.com
        ```

        ```Expected output
        You've found the Windows Admin Center in Azure APIs' home page. Please use the Azure portal to manage your virtual machines with Windows Admin Center.`
        ```

1. If you've allowed all outbound traffic and are getting an error from the command above, check that there are no firewall rules blocking the connection.

If nothing seems wrong and Windows Admin Center still won't install, open a support request with the following information:

- Logs in the Azure portal. This can be found under **Settings** > **Extensions** > **AdminCenter** > **View Detailed Status**.
- Logs on each node of the cluster. Run the following PowerShell command and share the resulting .zip file.

    ```powershell
    azcmagent logs
    ```

- Network trace, if appropriate. Network traces can contain customer data and sensitive security details, such as passwords, so we recommend reviewing the trace and removing any sensitive details before sharing it.

## Known issues

- Chrome incognito mode isn't supported.
- Azure portal desktop app isn't supported.
- Detailed error messages for failed connections aren't available yet.

## Frequently asked questions

Find answers to the frequently asked questions about using Windows Admin Center in Azure.

### How much does it cost to use Windows Admin Center?

There's no cost associated to use the Windows Admin Center in the Azure portal.

### Can I use Windows Admin Center to manage the virtual machines running on my cluster?

You can install the Hyper-V role using the Roles and Features extension. Once installed, refresh your browser, and Windows Admin Center will show the Virtual Machine and Switch extensions.

### What clusters can I manage using this extension?

You can use the capability to manage Arc-enabled Azure Stack HCI clusters, version 21H2 or later. You can also [use Windows Admin Center to manage your Arc-enabled servers](manage-arc-hybrid-machines.md)

### How does Windows Admin Center handle security?

Traffic from the Azure portal to Windows Admin Center is end-to-end encrypted. Your Arc-enabled cluster is managed using PowerShell and WMI over WinRM.

### Do I need an inbound port to use Windows Admin Center?

No inbound connection is required to use Windows Admin Center.

### Why must I create an outbound port rule?

An outbound port rule is required for the service that we have built to communicate with your server. Our service issues you a certificate free-of-cost for your instance of Windows Admin Center. This service ensures that you can always connect to your instance of Windows Admin Center from the Azure portal by keeping your WAC certificate up to date.

Furthermore, accessing Windows Admin Center from Azure requires no inbound port and only outbound connectivity via a reverse proxy solution. These outbound rules are required in order to establish the connection.

### How do I find the port used for Windows Admin Center installation?

To verify the value of SmePort registry setting:

1. RDP into your server.
1. Open the **Registry Editor**.
1. Navigate to the key `\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManagementGateway`.
1. Read the value of `SmePort` to find the port used.

### I already have Windows Admin Center installed on one or all nodes of my cluster. Can I access it from the portal?

Yes. You can follow the same steps outlined in this document.

> [!WARNING]
> Enabling this capability will replace your existing instance of Windows Admin Center and removes the capability to manage other machines. Your previously deployed instance of Windows Admin Center will no longer be usable.

## Next steps

- Learn about [Windows Admin Center](../overview.md)
- Learn about [managing servers with Windows Admin Center](../use/manage-servers.md)
- Learn about [Azure Stack HCI](/azure-stack/hci/overview)
- Learn about [connecting Azure Stack HCI to Azure](/azure-stack/hci/deploy/register-with-azure)

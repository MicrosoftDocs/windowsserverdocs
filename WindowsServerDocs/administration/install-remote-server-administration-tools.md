---
title: Install and Manage Remote Server Administration Tools in Windows
description: Learn about the available Remote Server Administration Tools (RSAT) and how to install, enable, and use RSAT on Windows Server and Windows 10 or 11 clients
#customer intent: As an IT administrator, I want to manage Windows Server roles and features remotely from my Windows PC, so that I can efficiently administer servers without direct access.
ms.topic: install-set-up-deploy
ms.author: roharwoo
author: robinharwood
ms.date: 08/22/2025
zone_pivot_groups: windows-os-version-plus-client
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-description
  - ai-seo-date:08/20/2025
---
# Install and manage Remote Server Administration Tools in Windows

Remote Server Administration Tools (RSAT) for Windows Server are a collection of utilities that enable IT administrators to remotely manage roles and features on Windows Server systems from a Windows client computer. This article provides an overview of the Remote Server Administration Tools (RSAT) for Windows. The article also shows you how to install and use them to manage Windows Server roles and features from a Windows Server or Windows client computer.

The method to install the RSATs varies depending on your platform. Make sure to select your platform from the buttons at the start of the article.

## What are Remote Server Administration Tools?

RSAT includes several types of tools to help you manage servers remotely:

- **Server Manager** - A central console for server tasks
- **MMC snap-ins** - Focused tools for specific services  
- **PowerShell modules** - Command-line scripts and automation
- **Command-line tools** - Direct server control from the command prompt

These tools streamline remote administration, making it easier to configure, monitor, and troubleshoot Windows Server environments from anywhere.

### Available tools

You can use the following RSATs from either a Windows Server or Windows client machine. The following table shows you which tools are available to each platform.

| RSAT Tool Name | Description | Windows Server | Windows client (Feature on Demand) | Windows client (DISM) |
|--|--|:-:|:-:|:-:|
| **Feature Administration Tools** | | | | |
| BitLocker Drive Encryption Administration Utilities | Manage BitLocker Drive Encryption on remote servers. | ✅ | ✅ | ✅ |
| BITS Server Extensions Tools | Administer Background Intelligent Transfer Service extensions. | ✅ | ❌ | ❌ |
| DataCenterBridging LLDP Tools | Configure Data Center Bridging and LLDP settings. | ✅ | ✅ | ✅ |
| Failover Clustering Tools | Manage and configure failover clusters. | ✅ | ✅ | ✅ |
| IP Address Management (IPAM) Client | Administer IP address infrastructure using IPAM. | ✅ | ✅ | ✅ |
| Network Load Balancing Tools | Configure and manage network load balancing clusters. | ✅ | ✅ | ✅ |
| Shielded VM Tools | Manage Shielded Virtual Machines. | ✅ | ❌ | ❌ |
| SNMP Tools | Administer SNMP services and settings. | ✅ | ❌ | ❌ |
| Storage Migration Service Tools | Manage storage migration services. | ✅ | ✅ | ✅ |
| Storage Replica Module for Windows PowerShell | Configure and manage storage replication. | ✅ | ✅ | ✅ |
| System Insights Module for Windows PowerShell | Access predictive analytics for Windows Server. | ✅ | ✅ | ✅ |
| WINS Server Tools | Manage Windows Internet Name Service (WINS) servers. | ✅ | ❌ | ❌ |
| **Role Administration Tools** | | | | |
| AD DS and AD LDS Tools | Manage Active Directory Domain Services and Lightweight Directory Services. | ✅ | ✅ | ✅ |
| Hyper-V Management Tools | Manage Hyper-V hosts and virtual machines. | ✅ | ❌ | ✅ |
| Remote Desktop Services Tools | Manage Remote Desktop Session Host, Gateway, and other RDS roles. | ✅ | ✅ | ✅ |
| Windows Server Update Services Tools | Administer WSUS servers and manage updates for Windows systems. | ✅ | ✅ | ✅ |
| Active Directory Certificate Services Tools | Manage AD Certificate Services and related components. | ✅ | ✅ | ✅ |
| Active Directory Rights Management Services Tools | Administer AD Rights Management Services. | ✅ | ❌ | ❌ |
| DHCP Server Tools | Administer and configure DHCP servers and scopes. | ✅ | ✅ | ✅ |
| DNS Server Tools | Manage DNS servers, zones, and records. | ✅ | ✅ | ✅ |
| Fax Server Tools | Manage fax server roles and settings. | ✅ | ❌ | ❌ |
| File Services Tools | Administer shared folders, quotas, and file server resources. | ✅ | ✅<sup>1</sup> | ✅<sup>1</sup> |
| Network Controller Management Tools | Manage network controllers in Windows Server. | ✅ | ✅ | ✅ |
| Network Policy and Access Services Tools | Administer network policies and access services. | ✅ | ❌ | ❌ |
| Print and Document Services Tools | Administer print servers and printers. | ✅ | ❌ | ❌ |
| Remote Access Management Tools | Manage remote access roles and VPN services. | ✅ | ✅ | ✅ |
| Volume Activation Tools | Configure and manage volume activation services. | ✅ | ✅ | ✅ |
| Windows Deployment Services Tools | Manage Windows Deployment Services for network-based OS installations. | ✅ | ❌ | ❌ |
| Server Manager | Centralized management console for managing server roles and features. | ✅<sup>2</sup> | ✅ | ✅ |

1. Tools for managing Services for NFS on local and remote computers can be added as a Windows Optional Feature using DISM.
1. Server Manager is included with Windows Server by default and not listed as a Remote Server Administration Tool.

To learn more about the available Features on Demand RSAT, see the [list of RSAT available via Features on Demand](/windows-hardware/manufacture/desktop/features-on-demand-non-language-fod#remote-server-administration-tools-rsat).

## Prerequisites

To use Remote Server Administration Tools, you need the following prerequisites:

- A computer running one of the following operating systems:

  - Windows 10 (October 2018 Cumulative Update or later) Pro or Enterprise editions only

  - Windows 11 Pro or Enterprise editions only

  - Any supported version of Windows Server

- Administrative privileges on the computer where RSAT is installed.

- Administrative privileges on the remote Windows Server systems for the service you want to manage.

- Network connectivity to the remote Windows Server systems you want to manage.

## Install Remote Server Administration Tools

:::zone pivot="windows-server-2025,windows-server-2022, windows-server-2019, windows-server-2016"

To install Remote Server Administration Tools on Windows Server, select your preferred method:

### [Server Manager](#tab/server-manager)

To install RSATs using Server Manager, follow these steps:

1. Sign in to the Windows Server computer with an account that has administrative privileges.

1. Open **Server Manager** from the Start menu or taskbar.

1. In Server Manager, select on **Manage** in the top right corner.

1. Select **Add Roles and Features** from the dropdown menu.

1. In the **Add Roles and Features Wizard**, select **Next** until you reach the **Features** section.

1. In the **Select features** section, scroll down to find the **Remote Server Administration Tools** category.

1. Expand the **Remote Server Administration Tools** category to see the available tools.

1. Select the specific tools you want to install by checking the corresponding checkboxes.

1. Select **Next** and then select **Install** to begin the installation process.

1. Wait for the installation to complete, then select **Close**.

1. Once the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

### [Windows PowerShell](#tab/windows-powershell)

To install Remote Server Administration Tools using the Install-WindowsFeature PowerShell cmdlet, follow these steps:

1. Sign in to the Windows Server computer with an account that has administrative privileges.
1. Open **Windows PowerShell** with administrative privileges (Run as Administrator).
1. To review the tools available for installation, run the following command and take note of the specific tools you want to install:

   ```powershell
   Get-WindowsFeature -Name RSAT*
   ```

1. Install the desired RSAT tools by running the following command, replacing `<FeatureName>` with the specific feature names you want to install. You can specify multiple features by separating them with commas.

   ```powershell
   Install-WindowsFeature -Name <FeatureName> -IncludeAllSubFeature
   ```

   For example, to install the Active Directory Domain Services tools, you would run:

   ```powershell
   Install-WindowsFeature -Name RSAT-AD-Tools -IncludeAllSubFeature
   ```

1. After the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

---

:::zone-end

::: zone pivot="windows-client-11"

### Install RSAT as Feature on Demand

Some RSAT tools are available as **Features on Demand**, review the [Available tools](#available-tools) to see which tools are available as Features on Demand.

To install Remote Server Administration Tools on Windows client, select your preferred method:

### [Desktop experience](#tab/desktop-experience)

To install RSAT using the desktop experience:

1. Sign in to the Windows client computer with an account that has administrative privileges.

1. Select **Start**, type _Optional Features_ in the search box, then select **Add an optional feature**.

1. Scan the list to see if the tool you need is already installed. If not, at the top of the page, select **Views features**, then:

    - Search for and select the tool you want to install, select **Next**, then **Install**

1. Review the installation progress. Once the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

### [PowerShell](#tab/powershell)

To install Remote Server Administration Tools using PowerShell, follow these steps:

1. Run PowerShell as an Administrator.

1. Run the following cmdlet to make sure that OpenSSH is available:

   ```powershell
   Get-WindowsCapability -Online | Where-Object Name -like 'RSAT*'
   ```

   The command should return the following output if neither are already installed:

   ```powershell
   Name  : Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
   State : NotPresent
   ```

1. After that, run the following cmdlets to the tool you need, replacing `<FeatureName>` with the specific feature names you want to install. You can specify multiple features by separating them with commas:

    ```powershell
    # Install the Active Directory Domain Services tools
    Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
    ```

    Both commands should return the following output:

    ```powershell
    Path          :
    Online        : True
    RestartNeeded : False
    ```

---

### Install RSAT as a Windows Feature

To install RSAT using the Windows Features dialog, select your preferred method:

### [Desktop experience](#tab/desktop-experience)

To install RSAT using the desktop experience:

1. Select **Start**, type _Windows Features_ in the search box, then select **Turn Windows features on or off**.

1. In the **Windows Features** dialog box, search for tool you want to install, such as **Hyper-V Management Tools**, and check the box next to it. You might need to expand the category to see the specific tool.

1. Select **OK** to install the selected RSAT tools.

1. Once the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

### [PowerShell](#tab/powershell)

To install RSAT Windows Features using PowerShell, follow these steps:

1. Run PowerShell as an Administrator.

1. Run the following cmdlet to make sure that RSAT is available. If you prefer, you can replace `*Tools*` with the specific feature name you want to install:

   ```powershell
   Get-WindowsOptionalFeature -Online -FeatureName *tools* | FT FeatureName,DisplayName,Description,State
   ```

   The command should return the following output if neither are already installed:

   ```powershell
   FeatureName                  DisplayName                                 Description
   -----------                  -----------                                 -----------
   IIS-WebServerManagementTools Web Management Tools                        Install Web management console and tools
   IIS-ManagementScriptingTools IIS Management Scripts and Tools            Manage a local Web server with IIS configur...
   Microsoft-Hyper-V-Tools-All  Hyper-V Management Tools                    Includes GUI and command-line tools for man...
   ```

1. Install the desired RSAT tools by running the following command, replacing `<FeatureName>` with the specific feature names you want to install. Using the `-All` switch enables the parent and all of its default dependencies if required by the feature.

   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName <FeatureName> -All
   ```

1. After the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

---

::: zone-end

::: zone pivot="windows-client-10"

### Install RSAT as Feature on Demand

Some RSAT tools are available as Features on Demand, review the [Available tools](#available-tools) to see which tools are available as Features on Demand.

To install Remote Server Administration Tools on Windows client, select your preferred method:

### [Desktop experience](#tab/desktop-experience)

To install RSAT using the desktop experience:

1. Sign in to the Windows client computer with an account that has administrative privileges.

1. Select **Start**, type _Optional Features_ in the search box, then select **Optional Features** (also referred to as **Manage optional features**).

1. Scan the list to see if the tool you need is already installed. If not, at the top of the page, select **Add a feature**, then:

    - Search for the tool you want to install, then select **Install**

1. Review the installation progress. Once the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

### [PowerShell](#tab/powershell)

To install Remote Server Administration Tools using PowerShell, follow these steps:

1. Run PowerShell as an Administrator.

1. Run the following cmdlet to make sure that RSAT is available:

   ```powershell
   Get-WindowsCapability -Online | Where-Object Name -like 'RSAT*'
   ```

   The command should return the following output if neither are already installed:

   ```powershell
   Name  : Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
   State : NotPresent
   ```

1. After that, run the following cmdlets to the tool you need, replacing `<FeatureName>` with the specific feature names you want to install. You can specify multiple features by separating them with commas:

    ```powershell
    # Install the Active Directory Domain Services tools
    Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
    ```

    Both commands should return the following output:

    ```powershell
    Path          :
    Online        : True
    RestartNeeded : False
    ```

---

### Install RSAT as a Windows Feature

To install RSAT using the Windows Features dialog, select your preferred method:

### [Desktop experience](#tab/desktop-experience)

To install RSAT using the desktop experience:

1. Select **Start**, type _Windows Features_ in the search box, then select **Turn Windows features on or off**.

1. In the **Windows Features** dialog box, search for tool you want to install, such as **Hyper-V Management Tools**, and check the box next to it. You might need to expand the category to see the specific tool.

1. Select **OK** to install the selected RSAT tools.

1. Once the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

### [PowerShell](#tab/powershell)

To install RSAT Windows Features using PowerShell, follow these steps:

1. Run PowerShell as an Administrator.

1. Run the following cmdlet to make sure that RSAT is available. If you prefer, you can replace `*Tools*` with the specific feature name you want to install:

   ```powershell
   Get-WindowsOptionalFeature -Online -FeatureName *tools* | FT FeatureName,DisplayName,Description,State
   ```

   The command should return the following output if neither are already installed:

   ```powershell
   FeatureName                  DisplayName                                 Description
   -----------                  -----------                                 -----------
   IIS-WebServerManagementTools Web Management Tools                        Install Web management console and tools
   IIS-ManagementScriptingTools IIS Management Scripts and Tools            Manage a local Web server with IIS configur...
   Microsoft-Hyper-V-Tools-All  Hyper-V Management Tools                    Includes GUI and command-line tools for man...
   ```

1. Install the desired RSAT tools by running the following command, replacing `<FeatureName>` with the specific feature names you want to install. Using the `-All` switch enables the parent and all of its default dependencies if required by the feature.

   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName <FeatureName> -All
   ```

1. After the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting **Windows Tools** from the Start menu.

---

:::zone-end

## Manage local and remote servers with Server Manager

Server Manager can be used along with the other tools included in Remote Server Administration Tools to manage both local and remote servers from a single experience. You can use Server Manager to install, configure, and manage roles and features on multiple remote servers from a single console.

:::zone pivot="windows-server-2025,windows-server-2022, windows-server-2019, windows-server-2016"

Server Manager is included with Windows Server by default and doesn't need to be installed separately. In the following steps, you'll use Server Manager to add an example Remote Server Administration Tool and launch the associated management tool.

1. For new installations of Windows Server, Server Manager opens automatically by default. If Server Manager doesn't open automatically, open the Start menu, then select **Server Manager**.

   :::image type="content" source="media/install-remote-server-administration-tools/server-manager.png" alt-text="Screenshot showing Server Manager Dashboard with configuration options and status tiles for installed roles.":::

1. In Server Manager, select on **Manage** in the top right corner.

1. Select **Add Roles and Features** from the dropdown menu.

1. In the **Add Roles and Features Wizard**, select **Next** until you reach the **Features** section.

1. Expand the **Remote Server Administration Tools** category, then expand the **Role Administration Tools** category.

1. Select the checkbox next to **DNS Server Tools**, then select **Next**.

1. Select **Install** to begin the installation process.

1. Select **Close** once the installation is complete.

1. To manage a DNS server, select **Tools** in the top right corner of Server Manager, then select **DNS** from the dropdown menu.

1. You can now use the DNS Manager console to manage the DNS server or right-click the server name in the left pane to connect to a different DNS server.

To learn more about using Server Manager to manage remote servers, see [Server Manager](server-manager/server-manager.md).

:::zone-end

::: zone pivot="windows-client-11, windows-client-10"

Server Manager is included with Remote Server Administration Tools and can be installed as a Feature on Demand. In the following steps, you'll install Server Manager and use to add an example role to a remote server and launch the associated management tool.

1. Install the _RSAT: Server Manager_ feature on demand by following the steps in the [Install RSAT as Feature on Demand](#install-rsat-as-feature-on-demand) section.

1. Install any other RSAT tools you want to use, such as the _RSAT: DNS Server Tools_.

1. Once installed, open the Start menu, type _Server Manager_, then select **Server Manager** from the search results.

1. In Server Manager, select on **Tools** in the top right corner.

1. Select the tool you want to use, such as **DNS** from the dropdown menu.

1. When prompted, enter the name or IP address of the remote server you want to manage, then select **OK**.

   :::image type="content" source="media/install-remote-server-administration-tools/server-manager-dns-tools.png" alt-text="A screenshot showing Server Manager with the DNS Manager window open.":::

To learn more about using Server Manager to manage remote servers, see [Server Manager](server-manager/server-manager.md).

:::zone-end

## Related content

- [Configure Features on Demand in Windows Server](server-manager/configure-features-on-demand-in-windows-server.md)
- [Configure remote Management in Server Manager](server-manager/configure-remote-management-in-server-manager.md)
- [Server Manager](server-manager/server-manager.md)
'

---
title: Remote Server Administration Tools in Windows
description: 
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 08/18/2025
zone_pivot_groups: windows-os-version-plus-client
#customer intent: As an IT administrator, I want to manage Windows Server roles and features remotely from my Windows PC, so that I can efficiently administer servers without direct access.
---
# Remote Server Administration Tools in Windows

Remote Server Administration Tools (RSAT) for Windows Server are a collection of utilities that enable IT administrators to remotely manage roles and features on Windows Server systems from a Windows client computer. This article provides an overview of the Remote Server Administration Tools (RSAT) for Windows. The article also shows you how to use them to manage Windows Server roles and features from a Windows Server or Windows client computer.

The method to install the RSATs varies depending on your platform. Make sure to select your platform from the buttons at the start of the article.

## What are Remote Server Administration Tools (RSAT)?

 RSAT includes tools such as Server Manager, Microsoft Management Console (MMC) snap-ins, Windows PowerShell modules, and command-line utilities, allowing administrators to efficiently perform server management tasks without needing direct access to the server itself. These tools streamline remote administration, making it easier to configure, monitor, and troubleshoot Windows Server environments from virtually anywhere.

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

1. Tools for managing Services for NFS on local and remote computers can be added as a Windows Optional Feature using DISM.

To learn more about the available Features on Demand RSAT, see the [list of RSAT tools available via **Features on Demand**](/windows-hardware/manufacture/desktop/features-on-demand-non-language-fod#remote-server-administration-tools-rsat).

## Prerequisites

To use Remote Server Administration Tools, you need the following prerequisites:

- A computer running one of the following operating systems:

  - Windows 10 (version 1809 or later) Pro or Enterprise editions only

  - Windows 11 Pro or Enterprise editions only

  - Any supported version of Windows Server

- Administrative privileges on the computer where RSAT is installed.

- Administrative privileges on the remote Windows Server systems for the service you want to manage.

- Network connectivity to the remote Windows Server systems you want to manage.

## Install Remote Server Administration Tools

:::zone pivot="windows-server-2025,windows-server-2022, windows-server-2019, windows-server-2016"

To install Remote Server Administration Tools on Windows Server, select your preferred method:

### [Server Manager](#tab/server-manager)

To install RSATs using Server Manager follow these steps:

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

1. Once the installation is complete, you can access the tools from the **Tools** menu in Server Manager or selecting ** **Windows Tools** from the Start menu.

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

Some RSAT tools are available as **Features on Demand** (FoD), review the [Available tools](#available-tools) to see which tools are available as Features on Demand (FoD).

To install Remote Server Administration Tools on Windows client, select your preferred method:

### [Desktop experience](#tab/desktop-experience)

To install RSAT using the desktop experience:

1. Sign in to the Windows client computer with an account that has administrative privileges.

1. Select **Start**, type _Optional Features_ in the search box, then select **Add an optional feature**.

1. Scan the list to see if the tool you need is already installed. If not, at the top of the page, select **Views features**, then:

    - Search for and select the tool you want to install, select **Next**, then **Install**

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

1. In the **Windows Features** dialog box, search for tool you want to install, such as **Hyper-V Management Tools**, and check the box next to it. You may need to expand the category to see the specific tool.

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

Some RSAT tools are available as **Features on Demand** (FoD), review the [Available tools](#available-tools) to see which tools are available as Features on Demand (FoD).

To install Remote Server Administration Tools on Windows client, select your preferred method:

### [Desktop experience](#tab/desktop-experience)

To install RSAT using the desktop experience:

1. Sign in to the Windows client computer with an account that has administrative privileges.

1. Select **Start**, type _Optional Features_ in the search box, then select **Optional Features** (also referred to as **Manage optional features**).

1. Scan the list to see if the OpenSSH is already installed. If not, at the top of the page, select **Add a feature**, then:

    - Search for the tool you want to install, then select **Install**

    - Search for the tool you want to install, then select **Install**

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

1. In the **Windows Features** dialog box, search for tool you want to install, such as **Hyper-V Management Tools**, and check the box next to it. You may need to expand the category to see the specific tool.

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


### Run Remote Server Administration Tools

> [!NOTE]
> After installing Remote Server Administration Tools for Windows 10, the **Administrative Tools** folder is displayed on the **Start** menu. You can access the tools from the following locations.
>
> -   The **Tools** menu in the Server Manager console.
> -   **Control Panel\System and Security\Administrative Tools**.
> -   A shortcut saved to the desktop from the **Administrative Tools** folder (to do this, right click the **Control Panel\System and Security\Administrative Tools** link, and then click **Create Shortcut**).

The tools installed as part of Remote Server Administration Tools for Windows 10 cannot be used to manage the local client computer. Regardless of the tool you run, you must specify a remote server, or multiple remote servers, on which to run the tool. Because most tools are integrated with Server Manager, you add remote servers that you want to manage to the Server Manager server pool before managing the server by using the tools in the **Tools** menu. For more information about how to add servers to your server pool, and create custom groups of servers, see [Add servers to Server Manager](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831453(v=ws.11)) and [Create and manage server groups](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh868009(v=ws.11)).

In Remote Server Administration Tools for Windows 10, all GUI-based server management tools, such as mmc snap-ins and dialog boxes, are accessed from the **Tools** menu of the Server Manager console. Although the computer that runs Remote Server Administration Tools for Windows 10 runs a client-based operating system, after installing the tools, Server Manager, included with Remote Server Administration Tools for Windows 10, opens automatically by default on the client computer. Note that there is no **Local Server** page in the Server Manager console that runs on a client computer.

##### To start Server Manager on a client computer

1.  On the **Start** menu, click **All Apps**, and then click **Administrative Tools**.

2.  In the **Administrative Tools** folder, click **Server Manager**.

Although they are not listed in the Server Manager console **Tools** menu, Windows PowerShell cmdlets and Command prompt management tools are also installed for roles and features as part of Remote Server Administration Tools. For example, if you open a Windows PowerShell session with elevated user rights (Run as Administrator), and run the cmdlet `Get-Command -Module RDManagement`, the results include a list of remote Desktop Services cmdlets that are now available to run on the local computer after installing Remote Server Administration Tools, as long as the cmdlets are targeted at a remote server that is running all or part of the remote Desktop Services role.

##### To start Windows PowerShell with elevated user rights (Run as administrator)

1.  On the **Start** menu, click **All Apps**, click **Windows System**, and then click **Windows PowerShell**.

2.  To run Windows PowerShell as an administrator from the desktop, right-click the **Windows PowerShell** shortcut, and then click **Run as Administrator**.

> [!NOTE]
> You can also start a Windows PowerShell session that is targeted at a specific server by right-clicking a managed server in a role or group page in Server Manager, and then clicking **Windows PowerShell**.


## Known issues

### **Issue**: RSAT FOD installation fails with error code 0x800f0954

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update) in WSUS/Configuration Manager environments
>
> **Resolution**: To install FODs on a domain-joined PC which receives updates through WSUS or Configuration Manager, you will need to change a Group Policy setting to enable downloading FODs directly from Windows Update or a local share. For more details and instructions on how to change that setting, see [How to make Features on Demand and language packs available when you're using WSUS/SCCM](/windows/deployment/update/fod-and-lang-packs).

---

### **Issue**: RSAT FOD installation via Settings app does not show status/progress

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update)
>
> **Resolution**: To see installation progress, click the **Back** button to view status on the **Manage optional features** page.

---

### **Issue**: RSAT FOD uninstallation via Settings app may fail

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update)
>
> **Resolution**: In some cases, uninstallation failures are due to the need to manually uninstall dependencies. Specifically, if RSAT tool A is needed by RSAT tool B, then choosing to uninstall RSAT tool A will fail if RSAT tool B is still installed. In this case, uninstall RSAT tool B first, and then uninstall RSAT tool A. See the list of RSAT FODs including dependencies.

---

### **Issue**: RSAT FOD uninstallation appears to succeed, but the tool is still installed

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update)
>
> **Resolution**: Restarting the PC will complete the removal of the tool.

---

### **Issue**: RSAT missing after Windows 10 upgrade

> **Impact**: Any RSAT .MSU package installation (prior to RSAT FODs) not automatically reinstalled
>
> **Resolution**: An RSAT installation cannot be persisted across OS upgrades due to the RSAT .MSU being delivered as a Windows Update package. Please install RSAT again after upgrading Windows 10. Note that this limitation is one of the reasons why we've moved to FODs starting with Windows 10 1809. RSAT FODs which are installed will persist across future Windows 10 version upgrades.

## See Also
>- [Remote Server Administration Tools for Windows 10](https://go.microsoft.com/fwlink/?LinkID=404281)
>- [Remote Server Administration Tools (RSAT) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](/archive/technet-wiki/)
'

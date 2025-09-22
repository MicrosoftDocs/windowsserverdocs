---
title: Install Hyper-V in Windows and Windows Server
description: Gives instructions for installing the Hyper-V role using Server Manager or Windows PowerShell. And gives instructions for enablings Hyper-V on Windows.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 05/23/2025
zone_pivot_groups: windows
#customer intent: As an IT administrator, I want to install and enable Hyper-V so that I can create and manage virtual machines effectively.
---
# Install Hyper-V

This article shows how to install Hyper-V in **Windows** and **Windows Server**. Follow the set of instructions that fit your needs.

:::zone pivot="windows-server"

To create and run virtual machines, install the Hyper-V role on Windows Server by using Server Manager, or the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature) cmdlet in Windows PowerShell.

To learn more about Hyper-V, see the [Hyper-V Technology Overview](../Hyper-V-Technology-Overview.md). To try out Windows Server 2025, you can download and install an evaluation copy. See the [Evaluation Center](https://www.microsoft.com/evalcenter/evaluate-windows-server-2025).

## Check requirements for Windows Server

Before you install Windows Server or add the Hyper-V role, make sure that:

- Your computer hardware is compatible. For more information, see [System Requirements for Windows Server](../../../get-started/hardware-requirements.md) and [System requirements for Hyper-V on Windows Server](../host-hardware-requirements.md).

- You don't plan to use third-party virtualization apps that rely on the same processor features that Hyper-V requires. Examples include VMware Workstation and VirtualBox. You can install Hyper-V without uninstalling these other apps. But, if you try to use them to manage virtual machines when the Hyper-V hypervisor is running, the virtual machines might not start or might run unreliably. For details and instructions for turning off the Hyper-V hypervisor if you need to use one of these apps, see [Virtualization applications don't work together with Hyper-V, Device Guard, and Credential Guard](https://support.microsoft.com/help/3204980/virtualization-applications-do-not-work-together-with-hyper-v-device-g).

If you want to install only the management tools, such as Hyper-V Manager, see [Remotely manage Hyper-V hosts with Hyper-V Manager](../Manage/Remotely-manage-Hyper-V-hosts.md).

## Install Hyper-V

### [PowerShell](#tab/powershell)

**To install Hyper-V on Windows Server using PowerShell:**

1. On the Windows desktop, select the Start button and type any part of the name **Windows PowerShell**.

1. Right-click Windows PowerShell and select **Run as Administrator**.

    >[!IMPORTANT]
    >You must run PowerShell as an Administrator, or the commands fail.

1. To install Hyper-V on a server you're connected to remotely, run the following command and replace `<computer_name>` with the name of server. If you're connected locally to the server, run the command without `-ComputerName <computer_name>`.

    ```powershell
    Install-WindowsFeature -Name Hyper-V -ComputerName <computer_name> -IncludeManagementTools -Restart
    ```

    ![Screenshot of PowerShell window after running the command to install Hyper-V in Windows Server.](./media/install-hyper-v-powershell.png)

1. The installation starts. As soon as installation finishes, the computer restarts.

    ![Screenshot of PowerShell window showing the progress to install Hyper-V in Windows Server.](./media/install-hyper-v-powershell-progress.png)

1. After the server restarts, you can see that the Hyper-V role is installed by running the following command:

    ```powershell
    Get-WindowsFeature Hyper-V -ComputerName <computer_name>
    ```

    If you're connected locally to the server, run the command without `-ComputerName <computer_name>`.

> [!NOTE]
> If you install this role on a server that runs the Server Core installation option of Windows Server and use the parameter `-IncludeManagementTools`, only the Hyper-V Module for Windows PowerShell is installed. You can use the GUI management tool, Hyper-V Manager, on another computer to remotely manage a Hyper-V host that runs on a Server Core installation. For instructions on connecting remotely, see [Remotely manage Hyper-V hosts with Hyper-V Manager](../Manage/Remotely-manage-Hyper-V-hosts.md).

### [GUI](#tab/gui)

**To install Hyper-V on Windows Server by using Server Manager:**

1. Open **Server Manager** if it's not already open. To start the application, select **Start**, and then search for and select **Server Manager**.

1. In **Server Manager**, on the **Manage** menu, select **Add Roles and Features**.

1. On the **Before you begin** page, verify that your destination server and network environment are prepared for the role and feature you want to install. Select **Next**.

1. On the **Select installation type** page, select **Role-based or feature-based installation**, and then select **Next**.

1. On the **Select destination server** page, select a server from the server pool, and then select **Next**.

1. On the **Select server roles** page, select **Hyper-V**. From the **Add Roles and Features Wizard** page, select **Add Features**, and then select **Next**.

    ![Screenshot of PowerShell window after running the command to enable Hyper-V.](./media/add-hyper-v-role.png)

1. On the **Select features** page, select **Next**, and then select **Next** again.

    ![Screenshot of Hyper-V installation settings.](./media/hyper-v-settings.png)

1. On the **Create Virtual Switches** page, **Virtual Machine Migration** page, and **Default Stores** page, select the options that suit your specific environment.

1. On the **Confirm installation selections** page, select **Restart the destination server automatically if required**, and then select **Install**.

1. When installation is finished, verify that Hyper-V installed correctly. Open the **All Servers** page in Server Manager and select a server on which you installed Hyper-V. Check the **Roles and Features** tile on the page for the selected server.

---

::: zone-end

:::zone pivot="windows"

Enable Hyper-V to create virtual machines on Windows. Hyper-V can be enabled in many ways including using the **Windows control panel**, **PowerShell**, or using the **Deployment Imaging Servicing and Management tool (DISM)**. This article walks through each option.

>[!NOTE]
> Hyper-V is built into Windows as an optional feature--there's no Hyper-V download.

## Check requirements for Windows

- Windows 10 (Pro or Enterprise), or Windows 11 (Pro or Enterprise)
- 64-bit Processor with Second Level Address Translation (SLAT).
- CPU support for VM Monitor Mode Extension (VT-c on Intel CPUs).
- Minimum of 4-GB memory.

>[!NOTE]
> The Hyper-V role **can't** be installed on Windows 10 Home or Windows 11 Home.

For more information and troubleshooting, see [Windows Hyper-V System Requirements](/virtualization/hyper-v-on-windows/reference/hyper-v-requirements).

## Enable Hyper-V

### [PowerShell](#tab/powershell)

**To enable Hyper-V on Windows using PowerShell:**

1. On the Windows desktop, select the Start button and type any part of the name **Windows PowerShell**.

1. Right-click Windows PowerShell and select **Run as Administrator**.

    >[!IMPORTANT]
    >You must run PowerShell as an Administrator, or the commands fail.

1. Run the following command:

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
    ```

    ![Screenshot of PowerShell window after running the command to enable Hyper-V.](./media/enable-hyper-v-powershell.png)

1. Enter **Y** to have the computer restart to complete the installation.

**To enable the Hyper-V role on Windows using DISM:**

The Deployment Image Servicing and Management tool (DISM) helps configure Windows and Windows images. Among its many applications, DISM can enable Windows features while the operating system is running.

1. On the Windows desktop, select the Start button and type any part of the name **Windows PowerShell**.

1. Right-click Windows PowerShell and select **Run as Administrator**.

1. Type the following command:

    ```powershell
    DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
    ```

    ![Console window showing Hyper-V being enabled.](./media/enable-hyper-v-dism.png)

1. You see that the feature is enabled and that "The operation completed successfully."

For more information about DISM, see the [DISM Technical Reference](/windows-hardware/manufacture/desktop/dism-reference--deployment-image-servicing-and-management).

### [GUI](#tab/gui)

**To enable Hyper-V on Windows 11:**

1. Navigate to the Control Panel. Select **Start**, then search for **Control Panel** to open the application.

1. Select **Programs**, then **Programs and Features**.

1. Select **Turn Windows Features on or off**.

1. Select **Hyper-V** and then select **OK**.

![Windows programs and features dialogue box](./media/enable-hyper-v.png)

When the installation completes, you're prompted to restart your computer.

**To enable Hyper-V on Windows 10:**

1. Select **Start**, then search for and select **Settings**.

1. Select **Apps & features**. Then select **Programs and Features**

1. Select **Turn Windows features on or off**.

1. Select **Hyper-V** and then select **OK**.

1. To complete the installation, restart your computer.

---

::: zone-end

## Next step

- [Create a virtual machine in Hyper-V](/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v)



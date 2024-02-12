---
title: Use local resources on Hyper-V virtual machine with VMConnect
description: Describes the requirements for using local resources with VMConnect
ms.topic: article
ms.assetid: 18eface5-7518-4c6b-9282-93e2e3e87492
ms.author: benarm
author: BenjaminArmstrong
ms.date: 02/16/2023
---
# Use local resources on Hyper-V virtual machine with VMConnect

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 11, Windows 10, Windows 8.1

Virtual Machine Connection (VMConnect) lets you use a computer's local resources in a virtual machine, like a removable USB flash drive or a printer. Enhanced session mode also lets you resize the VMConnect window. This article shows you how to configure the host and then give the virtual machine access to a local resource.

Enhanced session mode and Type clipboard text are available only for virtual machines that run recent Windows operating systems. See [Requirements for using local resources](#requirements-for-using-local-resources).

For virtual machines that run Ubuntu, see [Changing Ubuntu Screen Resolution in a Hyper-V VM](/archive/blogs/virtual_pc_guy/changing-ubuntu-screen-resolution-in-a-hyper-v-vm).

## Turn on enhanced session mode on a Hyper-V host

If your Hyper-V host runs Windows 10 or Windows 8.1, enhanced session mode is on by default, so you can skip this and move to the next section. But if your host runs Windows Server 2016 or Windows Server 2012 R2, do this first.

Turn on enhanced session mode:

1.  Connect to the computer that hosts the virtual machine.

2.  In Hyper-V Manager, select the host's computer name.

    ![Screenshot that shows a host computer name listed under Hyper-V Manager in the left pane.](media/Hyper-V-HyperVManager-HostNameSelected.png)

3.  Select **Hyper-V settings**.

    ![Screenshot that shows the Hyper-V settings option under Actions in the right pane.](media/HyperV-ActionsHyperVSettings.png)

4.  Under **Server**, select **Enhanced session mode policy**.

    ![Screenshot that shows the Enhanced session mode policy option under the Security section.](media/Hyper-V-Settings-ServerEnhancedSessionModePolicy.png)

5.  Select the **Allow enhanced session mode** check box.

    ![Screenshot that shows the Allow enhanced session mode checkbox for Enhanced session mode policy.](media/Hyper-V-Settings-EnhancedSessionModePolicyCheckBox.png)

6.  Under **User**, select **Enhanced session mode**.

    ![Screenshot that shows the Enhanced session mode option under the User section. ](media/Hyper-V-Settings-UserEnhancedSessionMode.png)

7.  Select the **Allow enhanced session mode** check box.

8.  Click **Ok**.

## Choose a local resource

Local resources include printers, the clipboard, and local drive(s) on the computer where you're running VMConnect. For more information, see [Requirements for using local resources](#requirements-for-using-local-resources).

To choose a local resource:

1.  Open VMConnect.

2.  Select the virtual machine that you want to connect to.

3.  Click **Show options**.

    ![Screenshot that calls out Show options on the bottom left of the dialog box.](media/HyperV-VMConnect-DisplayConfig.png)

4.  Select **Local resources**.

    ![Screenshot that calls out the Local resources tab.](media/HyperV-VMConnect-DisplayConfig-LocalResources.png)

5.  Click **More**.

    ![Screenshot that calls out the More button.](media/HyperV-VMConnect-DisplayConfig-LocalResourcesMore.png)

6.  Select the drive that you want to use on the virtual machine and click **Ok**.

    ![Screenshot that shows the local resources and drives that you can select.](media/HyperV-VMConnect-Settings-LocalResourcesDrives.png)

7.  Select **Save my settings for future connections to this virtual machine**.

    ![Screenshot that calls out the checkbox to select for this option.](media/HyperV-VMConnect-SaveSettings.png)

8.  Click **Connect**.

The path to the local drive shared to the virtual machine, in a Windows-based guest VM, is located at **This PC** under **Redirected drives and folders**.  The path for a Linux-based guest VM is located at **/home/shared-drives**.

## Edit VMConnect settings

You can easily edit your connection settings for VMConnect by running the following command in Windows PowerShell or the command prompt:

`VMConnect.exe <ServerName> <VMName> /edit`

> [!Note]
> An elevated command prompt may be required.

## Requirements for using local resources

To be able to use a computer's local resources on a virtual machine:

-   The Hyper-V host must have **Enhanced session mode policy** and **Enhanced session mode** settings turned on.

-   The computer on which you use VMConnect must run Windows 10, Windows 8.1, Windows Server 2016, or Windows Server 2012 R2.

-   The virtual machine must have Remote Desktop Services enabled, and run Windows 10, Windows 8.1, Windows Server 2016, or Windows Server 2012 R2 as the guest operating system.

If the computer running VMConnect and the virtual machine both meet the requirements, you can use any of the following local resources if they're available:

-   Display configuration

-   Audio

-   Printers

-   Clipboards for copy and paste

-   Smart cards

-   USB devices

-   Drives

-   Supported plug and play devices

## Why use a computer's local resources?

You may want to use the computer's local resources to:

-   Troubleshoot a virtual machine without a network connection to the virtual machine.

-   Copy and paste files to and from the virtual machine in the same way you copy and paste using a Remote Desktop Connection (RDP).

-   Sign in to the virtual machine by using a smart card.

-   Print from a virtual machine to a local printer.

-   Test and troubleshoot developer applications that require USB and sound redirection without using RDP.

## See also
[Connect to a Virtual Machine](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc742407(v=ws.11))

[Should I create a generation 1 or 2 virtual machine in Hyper-V?](../plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md)

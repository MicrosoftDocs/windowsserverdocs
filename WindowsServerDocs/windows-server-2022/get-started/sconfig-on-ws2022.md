---
title: Configure a Server Core installation of Windows Server with Sconfig.cmd
description: Explains how to use Sconfig.cmd
ms.date: 10/17/2017
ms.topic: article
ms.assetid: e6cac074-c6fc-46dd-9664-fa0342c0a5e8
author: jaimeo
ms.author: jaimeo
manager: dongill
ms.localizationpriority: medium
---

# Configure a Server Core installation of Windows Server 2022 with Sconfig.cmd

> Applies to: Windows Server 2022

In Windows Server 2022 you can use the Server Configuration tool (Sconfig.cmd) to configure and manage several common aspects of Server Core installations including networking configuration, domain membership, installation of updates, and operating system activation.  

You can use Sconfig.cmd on both Server Core and Server with Desktop Experience installations of Windows Server. On Server Core deployments of Windows Server 2022, Sconfig.cmd runs automatically after logon unless disabled. A PowerShell Windows with Sconfig running will restart automatically if you accidentally close the existing PowerShell window with Sconfig running. You must be a member of the local Administrators group to use Sconfig. You cannot use Sconfig.cmd through a remote PowerShell session. You can use Sconfig.cmd when signed on directly, have established a Remote Desktop Connection session, or have have an SSH connection after installing and configuring the SSH Server role on the Windows Server 2022 instance. 

## Start the Server Configuration Tool

Sconfig.cmd starts automatically on Server Core installations. If you want to run Sconfig.cmd on a Desktop Experience installation, perform the following steps:

1. Change to the system drive.

2. Type `Sconfig.cmd`, and then press ENTER. The Server Configuration tool interface opens:

    ![Screenshot of Sconfig.cmd user interface](../media/sconfig-on-ws2022/2022-main-sconfig-page.png)

## Domain/Workgroup

The current Domain/Workgroup settings are displayed in the default Server Configuration tool screen. You can join a domain or a workgroup by accessing the **Domain/Workgroup** settings page from the main menu and following the instructions, supplying any required information. You will only be able to join a domain if the computer is able to resolve the DNS address of a domain controller in the targert domain's Active Directory Domain Services forest and you have the credentials of an account that has permission to perform a domain join operation. You have the option of changing the computer's name as a part of the domain join operation.

## Computer name

The current computer name is displayed in the default Server Configuration Tool screen. You can change the computer name by accessing the **Computer Name** settings page from the main menu and following the instructions.

## Add local administrator

To add additional users to the local administrators group, use the **Add Local Administrator** option on the main menu. On a domain joined machine, enter the user in the following format: domain\username. On a non-domain joined machine (workgroup machine), enter only the user name. The changes take effect immediately.

## Remote management

You can enable various remote management scenarios from the **Configure Remote Management** main menu option:

- Enable or disable remote management. Allows use of Remote PowerShell, Windows Admin Center, and Microsoft Management Console connections. Enabled by default.

- Enable or disable response to ping. Allows use of remote ping to verify network connectivity. Disabled by default.
 
## Update settings

The current Windows Update settings are displayed in the default Server Configuration Tool screen. You can configure the server to use Automatic or Manual updates on the **Windows Update Settings** configuration option on the main menu.

When **Automatic** is selected, the system will check for and install updates every day at 3:00 AM. The settings take effect immediately. When **Manual** updates are selected, the system will not check for updates automatically.

The **Download Only** option will scan for updates, download any that are available, and then notify you in the Action Center that they are ready for installation. This is default option.

## Install updates

Allows you to check for an install updates. You can choose to search for updates from the following categories:

- All quality updates

- Recommended quality updates only

- Feature updates

The search will return any available updates within the category. You will be presented with the option of installing all available updates, a specific update, or none of the available updates.

## Remote desktop

The current status of remote desktop settings is displayed in the default Server Configuration Tool screen. You can configure the following Remote Desktop settings by accessing the **Remote Desktop** main menu option and following the instructions on screen.

- Enable Remote Desktop for Clients running Remote Desktop with Network Level Authentication

- Enable Remote Desktop for clients running any version of Remote Desktop

- Disable Remote

## Network settings

You can configure the IPv4 address to be assigned automatically by a DHCP Server or you can assign a static IP address manually as well as subnet mask and default gateway. 

You can also use this menu to configure a primary and secondary DNS server.

By default Windows Server will attempt to provision a network address from a DHCP server and will assign an APIPA address to network interfaces if no DHCP server is available.

## Date and time settings

Selecting the Date and Time option will open the Date and Time control panel when connected directly to the server or remotely through Remote Desktop. You can use this control panel to set the date and time and to modify the computer's time zone settings.

## Telemetry settings

This option lets you configure whether anonymized Windows Server telemetry is fowarded to Microsoft.

## Windows Activation settings

This option lets you to display current license and activation status, install a product key, and activate windows.

## Log off user

Logs off the currently signed on user. 

## Restart server

Restarts the server. The computer will complete any pending update installations.

## Shut down server

Shuts down the server

## Exit to command line (PowerShell)

Closes the Sconfig.cmd menu and provides a PowerShell prompt. To return to the Server Configuration Tool, type **Sconfig.cmd**, and then press ENTER.

## Disable Sconfig.cmd from automatically starting

Sconfig.cmd automatically starts on Windows Server 2022 Server Core installations. You can stop Sconfig from launching automatically by running the PowerShell command "Set-Sconfig -AutoLaunch $False"
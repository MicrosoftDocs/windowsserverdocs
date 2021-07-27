---
title: Configure a Server Core installation with Sconfig.cmd
description: In Windows Server 2022 you can use the Server Configuration tool (Sconfig.cmd) to configure and manage several common aspects of Server Core installations including networking configuration, domain membership, installation of updates, and operating system activation.  
ms.prod: windows-server
ms.date: 07/27/2021
ms.topic: article
ms.assetid: e6cac074-c6fc-46dd-9664-fa0342c0a5e8
author: Orin-Thomas
ms.author: inhenkel
manager: femila
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

To join a standalone server core instance to a domain Sconfig, perform the following steps:

1. From the Sconfig main menu, type `1` and press **Enter** to enter the Change domain/workgroup membership menu.

2. On the Change domain/workgroup membership menu, press `D` and press **Enter** to join a domain.

3. At the prompt, type the name of the domain to join and press **Enter**

4. At the prompt, type the name of the domain user authorized to perform the domain join in the format `DOMAIN\user` and press **Enter**

5. At the password prompt, provide the password for the authorized user and press **Enter**

6. At the prompt asking if you want to change the computer name press either `Y` or `N` and press Enter. If you press Y, provide the new name for the computer and press **Enter**. You will need to reenter the password for the user account you used to join the computer to the domain.

7. You will be prompted to restart the computer. Press `Y` and press Enter to restart the computer.

8. After the computer restarts, press `ESC` to switch users so you can sign in with a Domain account. 

## Computer name

The current computer name is displayed in the default Server Configuration Tool screen. You can change the computer name by accessing the **Computer Name** settings page from the main menu and following the instructions.

To change the computer name using Sconfig, perform the following steps:

1. From the Sconfig main menu, type 2 and press **Enter** to enter the Computer name menu.

2. At the prompt, provide the new computer name and press **Enter**

3. If changing the name of a computer that is domain joined, provide the credentials of a user with permissions to rename the computer account, pressing enter after username and then password **Enter**

4. When prompted to restart the computer, press `Y` and press **Enter**

## Add local administrator

To add additional users to the local administrators group, use the **Add Local Administrator** option on the main menu. The changes take effect immediately.

To add a domain user account to the local Administrators group using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `3` and press **Enter** to enter the **Add Local Administrator** settings menu.

2. At the prompt provide the username and press **Enter** 

## Remote management

You can enable various remote management scenarios from the **Configure Remote Management** main menu option:

- Enable or disable remote management. Allows use of Remote PowerShell, Windows Admin Center, and Microsoft Management Console connections. Enabled by default.

- Enable or disable response to ping. Allows use of remote ping to verify network connectivity. Disabled by default.

To configure remote management settings using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `4` and press **Enter** to enter the Configure remote management menu.

2. Type `1` and press **Enter** to enable remote management or type `2` and press **Enter** to disable remote management.

To configure server response to ping using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `4` and press **Enter** to enter the Configure remote management menu.

2. Type `3` and press **Enter** to enable server response to ping or type `4` and press **Enter** to disable server response to ping.

## Update settings

The current Windows Update settings are displayed in the default Server Configuration Tool screen. You can configure the server to use Automatic or Manual updates on the **Windows Update Settings** configuration option on the main menu.

When **Automatic** is selected, the system will check for and install updates every day at 3:00 AM. The settings take effect immediately. When **Manual** updates are selected, the system will not check for updates automatically.

The **Download Only** option will scan for updates, download any that are available, and then notify you in the Action Center that they are ready for installation. This is default option.

To configure Update settings using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `5` and press **Enter** to enter the Update settings menu.

2. Review the current update configuration and then choose between the following options:

    * Type `A` and press **Enter** to select updates to be installed Automatically.

    * Type `D` and press **Enter** to have updates periodically checked for and automatically downloaded but not installed. You can install downloaded updates from the **Install updates** menu.

    * Type `M` and press **Enter** to require a manual update check. You can install updates from the **Install updates** menu.

## Install updates

Allows you to check for and to install updates. You can choose to search for updates from the following categories:

- All quality updates

- Recommended quality updates only

- Feature updates

The search will return any available updates within the category. You will be presented with the option of installing all available updates, a specific update, or none of the available updates.

To install updates using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `6` and press **Enter** to enter the **Install Updates** menu.

2. On the Install updates menu, choose from one of the following options:

    * To check for all updates that are currently applicable to the server, type `1` and press **Enter**.

    * To check only for recommended updates that are applicable to the server, type `2` and press **Enter**.

    * To check for features updates that are applicable to the server, type `3` and press **Enter**.

3. After you have made your selection, a list of available updates will be displayed. You can choose from the following options:

    * To install all available updates, type `A` and press **Enter**.

    * To install none of the available updates, type `N` and press **Enter**.

    * To install a specific update from the list, type `S` and press **Enter** and then type the update number and press **Enter**.

## Remote desktop

The current status of remote desktop settings is displayed in the default Server Configuration Tool screen. You can configure the following Remote Desktop settings by accessing the **Remote Desktop** main menu option and following the instructions on screen.

- Enable Remote Desktop for Clients running Remote Desktop with Network Level Authentication

- Enable Remote Desktop for clients running any version of Remote Desktop

- Disable Remote

To configure Remote Desktop settings using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `7` and press **Enter** to enter the Remote Desktop settings menu.

2. On the Remote Desktop menu, type `E` and press **Enter** to enable Remote Desktop. Alternatively, press `D` and press **Enter** to disable Remote Desktop.

3. When enabling Remote Desktop, choose between the following options:

* To allow only clients running remote desktop with network level authentication (more secure) type `1` and press **Enter**.

* To allow clients running any version of remote desktop (less secure) type `2` and press **Enter**.

## Network settings

You can configure the IPv4 address to be assigned automatically by a DHCP Server or you can assign a static IP address manually as well as subnet mask and default gateway. By default Windows Server will attempt to provision a network address from a DHCP server and will assign an APIPA address to network interfaces if no DHCP server is available. In addition to configuring an IPv4 address, you can also use this menu to configure a primary and secondary DNS server.

To configure IPv4 address settings using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `8` and press **Enter** to enter the XXXXXX settings menu.

2. On the **Network settings** menu in this list of available interfaces, type the number of the Interface (such as `1`) and press **Enter** to select that interface.

3. On the **Network adapter settings** page, choose one of the following options:

* Type `1` and press **Enter** to set the network adapter address.

    1. Press `D` and press **Enter** to configure DHCP or press `S` and press **Enter** to configure a static address.

    2. If you choose the static IP address option, provide the IPv4 address, subnet mask (in dotted quad notation (example 255.255.255.0)) and default gateway address, pressing **Enter** after each entry.

* Type `2` and press **Enter** to set the DNS server address

    1. Provide the IPv4 address of the preferred DNS server and press **Enter**

    2. Provide the IPv4 address of the alterate DNS server and press **Enter**

* Type `3` and press **Enter** to clear current DNS server settings

## Date and time settings

Selecting the Date and Time option will open the Date and Time control panel when connected directly to the server or remotely through Remote Desktop. You can use this control panel to set the date and time and to modify the computer's time zone settings.

## Telemetry settings

This option lets you configure whether anonymized Windows Server telemetry is forwarded to Microsoft.

To configure telemetry settings using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `10` and press **Enter** to enter the Telemetry settings menu.

2. To change the telemetry setting, type `Y` for Yes or `N` for No and press **Enter**.

3. If you choose to change the telemetry settings, you can choose one of the following options:

    1. To disable telemetry, type `1` and press **Enter**.

    2. To set telemetry to Required, type `2` and press **Enter**.

    3. To set telemetry to Optional, type `3` and press **Enter**

To understand more about these telemetry options navigate to https://go.microsoft.com/fwlink/?LinkID-811315

## Windows Activation settings

This option lets you to display current license and activation status, install a product key, and activate windows. 

To perform activation tasks using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `11` and press **Enter** to enter the Windows Activation settings menu.

* Type `1` and press **Enter** to view the current Activation status

* Type `2` and press **Enter** to attempt Activation with the currently installed product key.

* Type `3` and press **Enter** to add a new product key. At the prompt type the product key and press **Enter**. Press **Enter** again once the product key is installed and then return to this menu to perform activation.

## Log off user

To log off as the current user using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `12` and press Enter.

2. At the prompt asking if you are sure, type `Y` and press Enter. The currently signed on account will be logged off. 

## Restart server

To restart the server using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `13` and press **Enter**. 

2. At the prompt asking if you are sure, type `Y` and press Enter. The server will restart.

## Shut down server

To shut down the server using Sconfig, perform the following steps:

1. From the Sconfig main menu, type `14` and press **Enter**.

2. At the prompt asking if you are sure, type `Y` and press Enter. The server will shut down.

## Exit to command line (PowerShell)

Closes the Sconfig.cmd menu and provides a PowerShell prompt. 

To exit to PowerShell from the main menu of Sconfig, type `15` and press Enter. To return to the Server Configuration Tool, type `Sconfig.cmd`, and then press ENTER or type `exit` which will close the current command prompt window and open a new instance of Sconfig.cmd.

## Disable Sconfig.cmd from automatically starting

Sconfig.cmd automatically starts on Windows Server 2022 Server Core installations. You can stop Sconfig from launching automatically by running the PowerShell command `Set-Sconfig -AutoLaunch $False`.

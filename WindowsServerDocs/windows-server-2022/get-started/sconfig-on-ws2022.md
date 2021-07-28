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

You can use the Server Configuration tool *Sconfig.cmd* to configure and manage Server Core and Server with Desktop Experience installations of Windows Server. The tool to configures and manages common aspects of Server Core installations including:

•	networking configuration 
•	domain membership
•	installation of updates
•	operating system activation

There are some things to keep in mind about *Sconfig.cmd*:

•	On Server Core deployments of Windows Server 2022, it runs automatically after logon unless disabled.
•	A PowerShell window with *Sconfig.cmd* running will restart automatically if you accidentally close the existing PowerShell window. 
•	You must be a member of the local Administrators group to use it. 
•	You can’t use it through a remote PowerShell session. 
•	You can use it when:
    o	You have signed on directly 
    o	Have established a Remote Desktop Connection session 
    o	Have an SSH connection after installing and configuring the SSH Server role on the Windows Server 2022 instance 

## Start the Server Configuration Tool

*Sconfig.cmd* starts automatically on Server Core installations. If you want to run it on a Desktop Experience installation, do these steps:

1. Change to the system drive.
1. Type `Sconfig.cmd`, and then press `Enter` The Server Configuration tool interface opens:

    ![Screenshot of Sconfig.cmd user interface](../media/sconfig-on-ws2022/2022-main-sconfig-page.png)

## Set the domain/workgroup settings

The current Domain/Workgroup settings are displayed on the default Server Configuration tool screen. You can join a domain or a workgroup by accessing the **Domain/Workgroup** settings page from the main menu and following the instructions, supplying any required information. 

> [NOTE]
> You’ll only be able to join a domain if the computer is able to resolve the DNS address of a domain controller in the target domain's Active Directory Domain Services forest and you have the credentials of an account that has permission to perform a domain join operation. You have the option of changing the computer's name as a part of the domain join operation.

To join a standalone server core instance to a domain with *Sconfig.cmd*, perform the following steps:

1. From the main menu, type `1` and press `Enter` to enter the Change domain/workgroup membership menu.
1. On the Change domain/workgroup membership menu, press `D`. 
1. Press `Enter` to join a domain.
1. Type the name of the domain to join and press `Enter`.
1. Type the name of the domain user authorized to perform the domain join in the format of `DOMAIN\user` and press `Enter`.
1. At the password prompt, provide the password for the authorized user and press `Enter`.
1. At the prompt asking if you want to change the computer name press either `Y` or `N` and press `Enter`. 
1. If you press `Y`, provide the new name for the computer and press `Enter`. You will need to reenter the password for the user account you used to join the computer to the domain.
1. You will be prompted to restart the computer. Press `Y` and press `Enter` to restart the computer.
1. After the computer restarts, press `ESC` to switch users so you can sign in with a Domain account.

## Set the computer name

The current computer name is displayed in the default Server Configuration Tool screen. You can change the computer name by accessing the **Computer Name** settings page from the main menu and following the instructions.

To change the computer name, perform the following steps:

1. From the main menu, type `2` and press `Enter` to enter the computer name menu.
1. At the prompt, provide the new computer name and press `Enter`.
1. If changing the name of a computer that is domain joined, provide the credentials of a user with permissions to rename the computer account. Press `Enter` after username and then enter the password and press `Enter`.
1. When prompted to restart the computer, press `Y` and press `Enter`.

## Add a local administrator

To add additional users to the local administrators group, use the **Add Local Administrator** option on the main menu. 

To add a domain user account to the local Administrators group, perform the following steps:

1. From the main menu, type `3` and press `Enter` to enter the **Add Local Administrator** settings menu.
1. At the prompt provide the username and press `Enter`. 

The changes take effect immediately.

## Configure remote management settings

You can enable various remote management scenarios from the **Configure Remote Management** main menu option:

- **Enable or disable remote management.** allows the use of Remote PowerShell, Windows Admin Center, and Microsoft Management Console connections. It is enabled by default.
- **Enable or disable response to ping** allows the use of remote ping to verify network connectivity. It is disabled by default.

1. From the main menu, type `4` and press `Enter` to enter the **Configure remote management** menu.
1. Type `1` and press `Enter` to enable remote management or type `2` and press `Enter` to disable remote management.

### Configure server response to ping

1. From the main menu, type `4` and press `Enter` to enter the Configure remote management menu.
1. To disable server response to ping, type `3` and press `Enter` to enable server response to ping or type `4` and press `Enter`.

## Update settings

The Windows Update settings are displayed in the default Server Configuration Tool screen. You can configure the server to use automatic or manual updates on the **Windows Update Settings** configuration option on the main menu.

When **Automatic** is selected, the system will check for and install updates every day at 3:00 AM. The settings take effect immediately. 

When **Manual** updates are selected, the system will not check for updates automatically.

The **Download Only** option will scan for updates, download any that are available, and then notify you in the Action Center that they are ready for installation. This is default option.

### Configure update settings

1. From the Sconfig main menu, type `5` and press `Enter` to enter the Update settings menu.
1. Review the update configuration and then choose between the following options:
    - Type `A` and press `Enter` to select updates to be installed automatically.
    - Type `D` and press `Enter` to have updates periodically checked for and automatically downloaded, but not installed. You can install downloaded updates from the **Install updates** menu.
    - Type `M` and press `Enter` to require a manual update check. You can install updates from the **Install updates** menu.

### Install updates

You can choose to search for updates from the following categories:

- All quality updates
- Recommended quality updates only
- Feature updates

The search returns any available updates within the category. You will be presented with the option of installing all available updates, a specific update, or none of the available updates.

1. From the main menu, type `6` and press `Enter` to enter the **Install Updates** menu.
1. From the **Install updates** menu, choose from one of the following options:

    - To check for all updates that are currently applicable to the server, type `1` and press `Enter`.
    - To check only for recommended updates that are applicable to the server, type `2` and press `Enter`.
    - To check for feature updates that are applicable to the server, type `3` and press `Enter`.

1. After you have made your selection, a list of available updates will be displayed. You can choose from the following options:

    - To install all available updates, type `A` and press `Enter`.
    - To install none of the available updates, type `N` and press `Enter`.
    - To install a specific update from the list, type `S` and press `Enter` and then type the update number and press `Enter`.

## Configure Remote Desktop settings

The status of remote desktop settings is displayed in the default Server Configuration Tool screen. You can configure the following Remote Desktop settings by accessing the **Remote Desktop** main menu option and following the instructions on screen.

- Enable Remote Desktop for Clients running Remote Desktop with Network Level Authentication
- Enable Remote Desktop for clients running any version of Remote Desktop
- Disable Remote

1. From the Sconfig main menu, type `7` and press `Enter` to enter the Remote Desktop settings menu.
1. On the Remote Desktop menu, type `E` and press `Enter` to enable Remote Desktop. Alternatively, press `D` and press `Enter` to disable Remote Desktop.
1. When enabling Remote Desktop, choose between the following options:
    - To allow only clients running remote desktop with network level authentication (more secure) type `1` and press `Enter`.
    - To allow clients running any version of remote desktop (less secure) type `2` and press `Enter`.

## Configure network settings

You can configure the IPv4 address to be assigned automatically by a DHCP Server or you can assign a static IP address manually as well as subnet mask and default gateway. By default, Windows Server will attempt to provision a network address from a DHCP server and will assign an APIPA address to network interfaces if no DHCP server is available. In addition to configuring an IPv4 address, you can also use this menu to configure a primary and secondary DNS server.

1. From the main menu, type `8` and press `Enter` to enter the XXXXXX settings menu.
1. On the **Network settings** menu in this list of available interfaces, type the number of the Interface (such as `1`) and press `Enter` to select that interface.
1. On the **Network adapter settings** page, choose one of the following options:
    1. Type `1` and press `Enter` to set the network adapter address.
    1. Press `D` and press `Enter` to configure DHCP or press `S` and press `Enter` to configure a static address.
    1. If you choose the static IP address option, provide the IPv4 address, subnet mask (in dotted quad notation (example 255.255.255.0)) and default gateway address, pressing `Enter` after each entry.
2. Type `2` and press `Enter` to set the DNS server address
    1. Provide the IPv4 address of the preferred DNS server and press `Enter`.
    1. Provide the IPv4 address of the alternate DNS server and press `Enter`.
3. Type `3` and press `Enter` to clear current DNS server settings

## Date and time settings

Selecting the Date and Time option will open the Date and Time control panel when connected directly to the server or remotely through Remote Desktop. You can use this control panel to set the date and time and to modify the time zone settings.

## Configure telemetry settings

This option lets you configure whether anonymized Windows Server telemetry is forwarded to Microsoft.

1. From the Sconfig main menu, type `10` and press `Enter` to enter the Telemetry settings menu.
1. To change the telemetry setting, type `Y` for Yes or `N` for No and press `Enter`.
1. If you choose to change the telemetry settings, you can choose one of the following options:
    1. To disable telemetry, type `1` and press `Enter`.
    1. To set telemetry to Required, type `2` and press `Enter`.
    1. To set telemetry to Optional, type `3` and press `Enter`

To understand more about telemetry options, see [Telemetry Options](https://go.microsoft.com/fwlink/?LinkID-811315).

## Configure Windows activation settings

This option lets you to display current license and activation status, install a product key, and activate windows. 

1. From the Sconfig main menu, type `11` and press `Enter` to enter the **Windows Activation settings** menu.
    - Type `1` and press `Enter` to view the current Activation status.
    - Type `2` and press `Enter` to attempt Activation with the currently installed product key.
    - Type `3` and press `Enter` to add a new product key. At the prompt type the product key and press `Enter`. Press `Enter` again once the product key is installed and then return to this menu to perform activation.

## Log off the current user

1. From the main menu, type `12` and press Enter.
1. At the prompt asking if you are sure, type `Y` and press Enter. The currently signed on account will be logged off. 

## Restart the server

1. From the main menu, type `13` and press `Enter`.
1. At the prompt asking if you are sure, type `Y` and press Enter. The server will restart.

## Shut down the server

1. From the main menu, type `14` and press `Enter`.
1. At the prompt asking if you are sure, type `Y` and press Enter. The server will shut down.

## Exit to command line (PowerShell)

This closes the Sconfig.cmd menu and provides a PowerShell prompt. 

To exit to PowerShell from the main menu, type `15` and press `Enter`. To return to the Server Configuration Tool, type `Sconfig.cmd`, and then press `Enter` or type `exit` which closes the current command prompt window and open a new instance of **Sconfig.cmd**.

## Disable *Sconfig.cmd* from automatically starting

*Sconfig.cmd* automatically starts on Windows Server 2022 Server Core installations. You can stop *Sconfig.cmd* from launching automatically by running the PowerShell command `Set-Sconfig -AutoLaunch $False`.

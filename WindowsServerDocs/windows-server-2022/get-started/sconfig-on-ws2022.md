---
title: Configure Server Core with SConfig
description: In Windows Server 2022 and Azure Stack HCI, you can use the Server configuration tool (SConfig) to configure and manage several common aspects of server lifecycle. It includes network configuration, Active Directory domain membership, installation of updates, and operating system activation
ms.prod: windows-server
ms.date: 07/27/2021
ms.topic: article
ms.assetid: e6cac074-c6fc-46dd-9664-fa0342c0a5e8
author: Orin-Thomas
ms.author: inhenkel
manager: femila
---

# Configure Server Core in Windows Server 2022 and Azure Stack HCI with Server configuration tool (SConfig)

> Applies to: Windows Server 2022, Azure Stack HCI

You can use the Server configuration tool *(SConfig)* to configure and manage a Windows Server instance or Azure Stack HCI. On Windows Server deployed in Server Core installation option, SConfig is the primary way to configure and manage common aspects of operating system, including the following.

-	network configuration 
-	Active Directory domain membership
-	installation of updates
-	operating system activation

> [!NOTE] 
> *SConfig* is a convenient tool which is especially helpful if you need to configure or troubleshoot a single server. However, it's not the only way to configure settings, and might not be efficient at large scale. If you need to setup more than a handful of servers, we recommend that you leverage automatic installation options using [Answer files](/windows-hardware/customize/desktop/wsim/answer-files-overview) (unattend.xml), [Microsoft Deployment Toolkit (MDT)](/mem/configmgr/mdt) or [System Center](/system-center).
> 
> Similarly, for ongoing management across multiple server instances, we recommend remote management approaches using tools like [Windows Admin Center](/windows-server/manage/windows-admin-center/overview), [Server Manager](/windows-server/administration/server-manager/server-manager) or System Center. You may also use Group Policy to automatically configure numerous operating system settings, such as enabling remote management and setting up updates. Each of these tools work equally well with Server Core and Server with Desktop Experience, removing or greatly reducing the need for locally managing one server a time.

There are some things to keep in mind about *SConfig.*

-	On Windows Server 2022 (deployed in Server Core installation option) and Azure Stack HCI, *SConfig* runs automatically after user signs in, unless autolaunch is disabled.
-	Starting with Windows Server 2022 and Azure Stack HCI, *SConfig* is based on PowerShell.
-	*SConfig* will restart automatically if you accidentally close the existing PowerShell window.
-	You must be a member of the local Administrators group to use *SConfig.*
-	You can use *SConfig* in the following scenarios:
    - you have signed in locally
    - you are connected with Remote Desktop.
-	You can’t use *SConfig* in a remote PowerShell session. If the server is already configured in such a way that it supports remote PowerShell connectivity, we recommend that you use more scalable and feature-rich tools to manage the server remotely.

    
## Start the Server configuration tool (SConfig)

*SConfig* starts automatically on Windows Server (deployed in Server Core installation option) and Azure Stack HCI. If you want to run it on Windows Server with Desktop Experience, follow these steps.

1. Launch PowerShell.
1. Type `SConfig`, and then press `Enter`. The Server configuration tool interface opens.

    ![Screenshot of SConfig user interface](../media/sconfig-on-ws2022/2022-main-sconfig-page.png)

> [!NOTE] 
> Launching SConfig from a Command prompt (CMD) window by running `SConfig.cmd` works in the current versions of Windows Server and Azure Stack HCI, just like [it did in previous versions](/windows-server/get-started/sconfig-on-ws2016). (Except if PowerShell was uninstalled.) However, this functionality is [deprecated](/windows-server/windows-server-2022/get-started/removed-features#features-were-no-longer-developing) and may be removed in the future versions of the operating system. The recommended way to manually launch *SConfig* is by running `SConfig` in a PowerShell window.

## Join a domain or workgroup

The current Active Directory domain or workgroup settings are displayed on the main screen of *SConfig.* You can join an Active Directory domain or a workgroup by accessing the **Domain/workgroup** settings page from the main menu and following the instructions, supplying any required information.

> [!NOTE] 
> You’ll only be able to join a domain if the computer is able to resolve the DNS address of a domain controller in the target domain's Active Directory Domain Services forest and you have the credentials of an account that has permission to perform a domain join operation. You may need to configure network settings and/or date and time before joining the domain. You have the option of changing the computer name as a part of the domain join operation.

To join a standalone server instance to a domain with *SConfig,* follow these steps.

1. From the main menu, type `1` and press `Enter` to enter the Change domain/workgroup membership menu.
1. On the Change domain/workgroup membership menu, press `D`. 
1. Press `Enter` to join a domain.
1. Type the name of the domain to join and press `Enter`.
1. Type the name of the domain user authorized to join computers to domain. Use the format of `domain\user` or `user@domain.com` and press `Enter`.
1. At the password prompt, provide the password for the specified user and press `Enter`.
1. At the prompt asking if you want to change the computer name, press either `Y` or `N` and press `Enter`. 
1. If you press `Y`, provide the new name for the computer and press `Enter`. You will need to reenter the password for the user account you specified when joining the computer to domain.
1. You will be prompted to restart the computer. Press `Y` and press `Enter` to restart the computer.
1. After the computer restarts, press `ESC` to switch users so you can sign in with a Domain account.

## Set the computer name

The current computer name is displayed on the main screen of *SConfig*. You can change the computer name by accessing the **Computer Name** settings page from the main menu and following the instructions.

To change the computer name, follow these steps.

1. From the main menu, type `2` and press `Enter` to enter the computer name menu.
1. At the prompt, provide the new computer name and press `Enter`.
1. If changing the name of a computer that is domain joined, provide the credentials of a user with permissions to rename the computer account. Press `Enter` after username and then enter the password and press `Enter`.
1. When prompted to restart the computer, press `Y` and press `Enter`.

## Add a local administrator

To add other users or groups to the local Administrators group, use the **Add local administrator** option on the main menu. 

To add a domain user account to the local Administrators group, do the following.

1. From the main menu, type `3` and press `Enter` to enter the **Add local administrator** settings menu.
1. At the prompt, provide the username and press `Enter`. 

The changes take effect immediately.

## Configure remote management

You can enable various remote management scenarios from the **Configure remote management** main menu option:

- **Enable or disable remote management** allows the use of remote PowerShell (also known as PowerShell remoting), Windows Admin Center, and certain Microsoft Management Console snap-ins. It is enabled by default for an authenticated domain network (if the server is joined to an Active Directory domain), or for the local subnet (for computers joined into a workgroup.)
- **Enable or disable response to ping** allows the use of remote ICMP echo requests (“ping”) to verify network connectivity. It is disabled by default.

1. From the main menu, type `4` and press `Enter` to enter the **Configure remote management** menu.
1. Type `1` and press `Enter` to enable remote management or type `2` and press `Enter` to disable remote management.

### Configure server response to ICMP echo requests (“ping”)

1. From the main menu, type `4` and press `Enter` to enter the Configure remote management menu.
1. To disable server response to ping, type `3` and press `Enter` to enable server response to ping or type `4` and press `Enter`.

## Update settings

The Microsoft Update settings are displayed in the main *SConfig* screen. You can configure the server to use automatic or manual updates on the **Update settings** configuration option on the main menu.

When **Automatic** is selected, the system will check for and install updates every day at 3:00 AM. (Time is interpreted according to the effective time zone configured on the server, which may or may not be the same as the official time zone in the area.) The settings take effect immediately.

When **Manual** updates are selected, the system will not check for updates automatically.

The **Download only** option will scan for updates, download any that are available, and then notify you in the Action center that they are ready for installation. It is the default option.

> [!NOTE] 
> Action center is only available on Windows Server with Desktop Experience, and it is only visible while you're signed in to the server. On Server Core and Azure Stack HCI, you won't receive any notifications.

### Configure updates

1. From the *SConfig* main menu, type `5` and press `Enter` to enter the Update settings menu.
1. Review the update configuration and then choose between the following options.
    - Type `A` and press `Enter` to select updates to be installed automatically.
    - Type `D` and press `Enter` to have updates periodically checked for and automatically downloaded, but not installed. You can install downloaded updates from the **Install updates** menu.
    - Type `M` and press `Enter` to require a manual update check. You can install updates from the **Install updates** menu.

### Install updates

You can choose to search for updates from the following categories.

- All quality updates
- Recommended quality updates only
- Feature updates

> [!NOTE] 
> [The terminology for update types](/windows/deployment/update/get-started-updates-channels-tools#types-of-updates) (but not necessarily release cadence and schedule) is unified with Windows 10 and Windows 11. Hence, *Feature updates* is another name for what used to be known as Operating system upgrades. Regular monthly updates, including security updates, are referred to as *Quality updates.*
>
> [Feature updates from Microsoft Update](/azure-stack/hci/manage/preview-channel) are currently only available for Azure Stack HCI. If you want to [upgrade Windows Server](/windows-server/upgrade/upgrade-overview) to a newer version, you need to use traditional installation media (such as an ISO) for that. From there, you either [run Setup.exe](/windows-hardware/manufacture/desktop/windows-setup-command-line-options) directly or leverage some automation solution such as System Center. *SConfig* does not specifically facilitate for these scenarios.

The search returns any available updates within the category. You will be presented with the option of installing all available updates, a specific update, or none of the available updates.

1. From the main *SConfig* menu, type `6` and press `Enter` to enter the **Install updates** menu.
1. From the **Install updates** menu, choose from one of the following options.

    - To check for all quality updates that are currently applicable to the server, type `1` and press `Enter`.
    - To check only for recommended quality updates that are applicable to the server, type `2` and press `Enter`.
    - To check for feature updates that are applicable to the server, type `3` and press `Enter`.

1. After you have made your selection, a list of available updates will be displayed. You can choose from the following options.

    - To install all available updates, type `A` and press `Enter`.
    - To install none of the available updates, type `N` and press `Enter`.
    - To install a specific update from the list, type `S` and press `Enter` and then type the update number and press `Enter`.

## Configure Remote desktop

The status of Remote desktop settings is displayed in the main *SConfig* screen. You can configure the following Remote desktop settings by accessing the **Remote desktop** main menu option and following the instructions on screen.

- Enable Remote desktop for clients that support Network level authentication (NLA)
- Enable Remote desktop for clients running any version of Remote desktop software
- Disable Remote desktop

1. From the *SConfig* main menu, type `7` and press `Enter` to enter the Remote desktop settings menu.
1. On the Remote desktop menu, type `E` and press `Enter` to enable Remote desktop. Alternatively, press `D` and press `Enter` to disable Remote desktop.
1. When enabling Remote desktop, choose between the following options.
    - To allow only clients running Remote desktop with Network level authentication (more secure), type `1` and press `Enter`.
    - To allow clients running any version of Remote desktop (less secure), type `2` and press `Enter`.

## Configure network

By default, the operating system will attempt to provision a network address from a DHCP server. If no DHCP server is available, it will assign an Automatic private IP address (APIPA) to the network interface. Alternatively, you can assign a static IPv4 address manually, and specify the subnet mask and default gateway. When configuring an IPv4 address, you can also use this menu to configure primary and secondary DNS servers.

1. From the main menu, type `8` and press `Enter` to enter the Network settings menu.
1. On the **Network settings** menu in this list of available interfaces, type the number of the Interface (such as `1`) and press `Enter` to select that interface.
1. On the **Network adapter settings** page, choose one of the following options.
    1. Type `1` and press `Enter` to set the network adapter address.
    1. Press `D` and press `Enter` to configure DHCP or press `S` and press `Enter` to configure a static IP address.
    1. If you choose the static IP address option, provide the IPv4 address, subnet mask (in dotted quad notation, such as `255.255.255.0`), and default gateway address, pressing `Enter` after each entry.
2. Type `2` and press `Enter` to set the DNS server address.
    1. Provide the IPv4 address of the preferred DNS server and press `Enter`.
    1. Provide the IPv4 address of the alternate DNS server and press `Enter`.
3. Type `3` and press `Enter` to clear current DNS server settings.

## Date and time settings

Selecting the Date and time option will open the Date and time Control panel applet. You can use this applet to set the date and time and to modify the time zone settings.

## Configure Operating system diagnostic data (telemetry)

This option lets you configure whether anonymized diagnostic data is forwarded to Microsoft.

1. From the *SConfig* main menu, type `10` and press `Enter` to enter the Telemetry settings menu.
1. To change the diagnostic data setting, type `Y` for Yes or `N` for No and press `Enter`.
1. If you want to change the diagnostic data settings, you can choose one of the available options.

> [!NOTE] 
> Windows Server and Azure Stack HCI have different default configuration regarding to diagnostic data. For information specific to Windows Server, see [Configure Windows diagnostic data in your organization](/windows/privacy/configure-windows-diagnostic-data-in-your-organization#diagnostic-data-settings). For Azure Stack HCI, see [Azure Stack HCI data collection](/azure-stack/hci/concepts/data-collection). Please note that you cannot configure the latter in *SConfig.* To learn more about Microsoft approach to privacy, see [Privacy at Microsoft](https://go.microsoft.com/fwlink/?LinkID=811315).

## Windows activation

This option lets you display current license and activation status, install a product key, and activate Windows Server. 

> [!NOTE] 
> Activation is only needed for Windows Server. This menu item is not available on Azure Stack HCI. [Azure Stack HCI registration](/azure-stack/hci/manage/manage-azure-registration#unregister-azure-stack-hci-by-using-powershell) is a different process, and it is currently not integrated to *SConfig*.

1. From the *SConfig* main menu, type `11` and press `Enter` to enter the **Windows activation settings** menu.
    - Type `1` and press `Enter` to view the current Activation status.
    - Type `2` and press `Enter` to attempt Activation with the currently installed product key.
    - Type `3` and press `Enter` to add a new product key. At the prompt, type in the product key and press `Enter`. Press `Enter` again once the product key is installed and then return to this menu to perform activation.

## Log the current user off

1. From the main menu, type `12` and press Enter.
1. At the prompt asking if you are sure, type `Y` and press Enter. The currently signed on account will be logged off. 

## Restart the server

1. From the main menu, type `13` and press `Enter`.
1. At the prompt asking if you are sure, type `Y` and press Enter. The server will restart.

## Shut down the server

1. From the main menu, type `14` and press `Enter`.
1. At the prompt asking if you are sure, type `Y` and press Enter. The server will shut down.

## Exit to command line (PowerShell)

This menu item closes the *SConfig* menu and returns to an interactive PowerShell prompt. You can use it to run arbitrary PowerShell commands and scripts for advanced configuration or troubleshooting. Many of these specialized options are not available natively in *SConfig.* For example, configure [storage](/powershell/module/storage), advanced [network adapter settings](/powershell/module/netadapter) (such as setting VLAN IDs) and [install device drivers](/windows-hardware/drivers/devtest/pnputil-command-syntax).

> [!NOTE]
> As a general rule, every setting available in the operating system can be controlled using command line tools or scripts. However, many of these settings are more conveniently managed remotely using graphical tools such as Windows Admin Center, Server Manager and System Center.

To exit to PowerShell from *SConfig* main menu, type `15` and press `Enter`. To return to Server configuration tool, type `SConfig` in PowerShell, and then press `Enter`. Alternatively, type `exit`. It will close the current PowerShell window and open a new instance of *SConfig* automatically.

> [!NOTE] 
> If you happened to manually launch SConfig from a Command prompt session (as opposite to a PowerShell session), then exiting SConfig via menu option `15` will get you back to Command prompt. Even though the menu item says _“Exit to command line (PowerShell)”,_ in this specific case, there will be no interactive PowerShell session left.

### PowerShell is the default shell on Server Core

Before Windows Server 2022, the default shell on Server Core was classic Command prompt (CMD). It launched by default when user signed in to Server Core. From there, you could either launch *SConfig,* or run arbitrary command-line tools.

Starting with Windows Server 2022 (when deployed in Server Core installation option) and Azure Stack HCI, the default shell is changed to PowerShell. It starts by default, and *SConfig* is launched automatically within the PowerShell window. If you exit *SConfig* by using menu option `15`, you get to the interactive PowerShell session.

However, if PowerShell was uninstalled, the default shell falls back to CMD. Unlike in previous versions of the operating system, if PowerShell is uninstalled, *SConfig* won't run either automatically, or if you try to launch it manually. You will only be able to use the classic command line tools such as [netsh.exe](/windows-server/networking/technologies/netsh/netsh) and [diskpart.exe](/windows-server/administration/windows-commands/diskpart).

> [!NOTE]
> [Diskpart is deprecated](/windows/compatibility/vds-is-transitioning-to-windows-storage-management-api) and might not provide full functionality. For example, unlike PowerShell, it cannot manage Storage Spaces.

The change in default shell should be transparent for most users because you can run all the same command-line tools in PowerShell as you could in CMD. Moreover, PowerShell is much more capable than CMD both in terms of interactive language features and number of commands being available. However, in some edge case scenarios, a command in PowerShell might behave differently from CMD. For example, you might notice that if you were using batch file syntax (such as `set foo=bar`) in an interactive session. (If you were running a batch file, i.e. a file with `.cmd` or `.bat` extension, it would be processed by CMD even if launched from PowerShell. In this scenario, so you won't observe any differences.)

You can explicitly transition to the classic Command prompt by simply typing `cmd` in PowerShell and pressing `Enter`. Alternatively, type `start cmd` if you prefer to launch a new window.

> [!NOTE] 
> If you intend to _reload_ an existing PowerShell session (e.g. for module updates to take effect), launching *SConfig* and exiting it won't be sufficient. The reason is *SConfig* itself being a PowerShell application which runs within an existing PowerShell session. Exiting *SConfig* will get you into the original session.
>
> Instead, to reload a PowerShell session, type `exit` and press `Enter`. This will close the existing PowerShell window, and a new one will be started automatically. (The latter part is specific to Server Core and Azure Stack HCI. On Server with Desktop Experience, you will have to manually launch a new PowerShell window.)

## Disable *SConfig* from starting automatically

*SConfig* automatically starts on Windows Server 2022 (when deployed in Server Core installation option) and on Azure Stack HCI. You can stop *SConfig* from launching automatically by running the following command in PowerShell: `Set-SConfig -AutoLaunch $False`.

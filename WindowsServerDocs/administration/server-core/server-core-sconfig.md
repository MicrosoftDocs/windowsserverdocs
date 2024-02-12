---
title: Configure a Server Core installation of Windows Server and Azure Stack HCI with the Server Configuration tool (SConfig)
description: In Windows Server and Azure Stack HCI, you can use the Server Configuration tool (SConfig) to configure and manage several common aspects of server lifecycle. It includes network configuration, Active Directory domain membership, installation of Microsoft updates, and operating system activation
ms.topic: article
author: Orin-Thomas
ms.author: inhenkel
manager: femila
ms.date: 08/18/2021
ms.assetid: e6cac074-c6fc-46dd-9664-fa0342c0a5e8
---

# Configure a Server Core installation of Windows Server and Azure Stack HCI with the Server Configuration tool (SConfig)

You can use the Server Configuration tool (SConfig) to configure and manage a Windows Server instance or Azure Stack HCI. When Windows Server is installed with the Server Core installation option, SConfig is the primary way to configure and manage common aspects of the operating system, including:

- Network configuration
- Active Directory domain membership
- Installation of Microsoft updates
- Operating system activation

> [!NOTE]
> SConfig is a convenient tool which is especially helpful if you need to configure or troubleshoot a single server. However, it's not the only way to configure settings, and might not be efficient at large scale. If you need to setup more than a handful of servers, we recommend that you leverage more automated installation processes, such as [Answer files](/windows-hardware/customize/desktop/wsim/answer-files-overview) (unattend.xml), [Microsoft Deployment Toolkit (MDT)](/mem/configmgr/mdt) or [Microsoft Endpoint Configuration Manager](/mem/configmgr/). If you're deploying a virtualization host or a virtual machine, the best way to install and configure the operating system is often [System Center Virtual Machine Manager (VMM)](/system-center/vmm).
>
> Similarly, for ongoing management across multiple server instances, we recommend remote management approaches using tools like [Windows Admin Center](/windows-server/manage/windows-admin-center/overview), [Server Manager](/windows-server/administration/server-manager/server-manager) or components of [System Center](/system-center/). You may also use [Group Policy](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831791(v=ws.11)) to automatically configure numerous operating system settings, such as enabling remote management and configuring updates. Each of these tools work equally well with Server Core and Server with Desktop Experience installation options, removing or greatly reducing the need for locally managing one server a time.

Here are some things to keep in mind about SConfig:

- Starting with Windows Server 2022 (deployed with the Server Core installation option) and Azure Stack HCI automatically run SConfig after user signs in, unless AutoLaunch is disabled. On previous versions of Windows Server, SConfig needs to be launched using `SConfig.cmd`.
- Also starting with Windows Server 2022 and Azure Stack HCI, SConfig is based on PowerShell and will restart automatically if you accidentally close the existing PowerShell window.
- You must be a member of the local Administrators group to use SConfig.
- You can use SConfig in the following scenarios:
  - you have signed in locally
  - you are connected with Remote desktop.
- You can’t use SConfig in a remote PowerShell session. If the server is already configured in such a way that it supports remote PowerShell connectivity, we recommend that you use more scalable and feature-rich tools to manage the server remotely.

## Start SConfig

SConfig starts automatically starting with Windows Server 2022 (deployed in Server Core installation option) and Azure Stack HCI. To run SConfig on previous versions of Windows Server, follow these steps: It is also possible to run SConfig on Windows Server installed with the Server with Desktop Experience installation option using these steps:

1. Launch PowerShell.
1. Type `SConfig`, and then press `Enter`. The Server configuration tool interface opens.

   :::image type="content" source="../media/sconfig-main-page.png" alt-text="SConfig user interface":::

> [!NOTE]
> Launching SConfig from a Command prompt (CMD) window by running `SConfig.cmd` also works in Windows Server 2022 and Azure Stack HCI, just like it did in previous versions. However, this method is [no longer being developed](../../get-started/removed-deprecated-features-windows-server-2022.md) and may be removed in the future versions of the operating system. The recommended way to manually launch SConfig if required is by running `SConfig` in a PowerShell window.

## Join a domain or workgroup

The current Active Directory domain or workgroup settings are displayed on the main screen of SConfig. You can join an Active Directory domain or a workgroup by accessing the **Domain/workgroup** settings page from the main menu and following the instructions, supplying any required information.

> [!NOTE]
> You’ll only be able to join a domain if the computer is able to resolve the DNS address of a domain controller in the target domain's Active Directory Domain Services forest and you have the credentials of an account that has permission to perform a domain join operation. You may need to configure network settings and/or the date and time before joining the domain. You also have the option of changing the computer name as a part of the domain join operation.

To join a standalone server instance to a domain with SConfig, follow these steps:

1. From the main menu, type `1` and press `Enter` to enter the **Change domain/workgroup membership** settings page.
1. On the Change domain/workgroup membership menu, press `D`.
1. Press `Enter` to join a domain.
1. Type the name of the domain to join and press `Enter`.
1. Type the name of the domain user authorized to join computers to domain. Use the format of `domain\user` or `user@domain.com` and press `Enter`.
1. At the password prompt, provide the password for the specified user and press `Enter`.
1. At the prompt asking if you want to change the computer name, press either `Y` or `N` and press `Enter`.
1. If you press `Y`, provide the new name for the computer and press `Enter`. You will need to reenter the password for the user account you specified when joining the computer to domain.
1. You will be prompted to restart the computer. Press `Y` and press `Enter` to restart the computer.
1. After the computer restarts, press `ESC` to switch users so you can sign in with a domain account.

## Set the computer name

The current computer name is displayed on the main screen of SConfig. You can change the computer name by accessing the **Computer Name** settings page from the main menu and following the instructions.

To change the computer name, follow these steps:

1. From the main menu, type `2` and press `Enter` to enter the **Computer name** settings page.
1. At the prompt, provide the new computer name and press `Enter`.
1. If changing the name of a computer that is domain joined, provide the credentials of a user with permissions to rename the computer account. Press `Enter` after entering a username and then type the password and press `Enter`.
1. When prompted to restart the computer, press `Y` and press `Enter`.

## Add a local administrator

To add other users or groups to the local Administrators group, use the **Add local administrator** option on the main menu.

To add a domain user account to the local Administrators group, do the following:

1. From the main menu, type `3` and press `Enter` to enter the **Add local administrator** settings page.
1. At the prompt, provide the username and press `Enter`.

The changes take effect immediately.

## Configure remote management

You can enable various remote management scenarios from the **Configure remote management** settings page:

- **Enable or disable remote management** allows the use of remote PowerShell (also known as PowerShell remoting), Windows Admin Center, and certain Microsoft Management Console snap-ins. It is enabled by default for an authenticated domain network (if the server is joined to an Active Directory domain), or for the local subnet (for computers joined into a workgroup).
- **Enable or disable response to ping** allows the use of remote ICMP echo requests (“ping”) to verify network connectivity. It is disabled by default.

1. From the main menu, type `4` and press `Enter` to enter the **Configure remote management** settings page.
1. Type `1` and press `Enter` to enable remote management or type `2` and press `Enter` to disable remote management.

### Configure server response to ICMP echo (ping) requests

1. From the main menu, type `4` and press `Enter` to enter the **Configure remote management** settings page.
1. To enable server response to ping, type `3` and press `Enter`, or to disable server response to ping or type `4` and press `Enter`.

## Update settings

The Microsoft Update settings are displayed in the main SConfig screen. You can configure the server to use automatic or manual updates on the **Update setting** settings page.

When **Automatic** is selected, the system will check for and install updates every day at 3:00 AM. (Time is interpreted according to the effective time zone configured on the server, which may or may not be the same as the official time zone in the area).

The **Download only** option will scan for updates, download any that are available, and then notify you in the Action center that they are ready for installation. It is the default option.

When **Manual updates** is selected, the system will not check for updates automatically.

> [!NOTE]
> Action center is only available on Windows Server installed with the Server with Desktop Experience installation option, and it is only visible while you're signed in to the server. On Server Core and Azure Stack HCI, you won't receive any notifications.

### Configure updates

1. From the SConfig main menu, type `5` and press `Enter` to enter the **Update setting** settings page.
1. Review the update configuration and then choose between the following options:
    - Type `A` and press `Enter` to select updates to be installed automatically.
    - Type `D` and press `Enter` to have updates periodically checked for and automatically downloaded, but not installed.
    - Type `M` and press `Enter` to require you to check manually for updates.

### Install updates

You can choose to search for updates from the following categories:

- All quality updates
- Recommended quality updates only
- Feature updates

> [!NOTE]
> The [terminology for update types](/windows/deployment/update/get-started-updates-channels-tools#types-of-updates) (but not necessarily release cadence and schedule) is unified with Windows 10 and Windows 11. Hence, *Feature updates* is another name for what used to be known as operating system upgrades. Regular monthly updates, including security updates, are referred to as *Quality updates*.
>
> [Feature updates from Microsoft Update](/azure-stack/hci/manage/preview-channel) are currently only available for Azure Stack HCI. If you want to [upgrade Windows Server](/windows-server/upgrade/upgrade-overview) to a newer version, you need to use traditional installation media (such as an ISO). From there, you either [run Setup.exe](/windows-hardware/manufacture/desktop/windows-setup-command-line-options) directly or leverage an automation solution such as mentioned earlier. SConfig does not specifically facilitate these scenarios.

The search returns any available updates within the category. You will be presented with the option of installing all available updates, a specific update, or none of the available updates.

1. From the main SConfig menu, type `6` and press `Enter` to enter the **Install updates** settings page.
1. Choose from one of the following options:

    - To check for all quality updates that are currently applicable to the server, type `1` and press `Enter`.
    - To check only for recommended quality updates that are applicable to the server, type `2` and press `Enter`.
    - To check for feature updates that are applicable to the server, type `3` and press `Enter`.

1. After you have made your selection, a list of available updates will be displayed. You can choose one the following options:

    - To install all available updates, type `A` and press `Enter`.
    - To install none of the available updates, type `N` and press `Enter`.
    - To install a specific update from the list, type `S` and press `Enter`, then type the update number, and press `Enter`.

## Configure Remote desktop

The status of Remote desktop settings is displayed in the main SConfig screen. You can configure the following Remote desktop settings by accessing the **Remote desktop** settings page and following the instructions on screen:

- Enable Remote desktop for clients that support Network level authentication (NLA)
- Enable Remote desktop for clients running any version of Remote desktop software
- Disable Remote desktop

1. From the SConfig main menu, type `7` and press `Enter` to enter the **Remote desktop** settings page.
1. On the Remote desktop menu, type `E` and press `Enter` to enable Remote desktop. Alternatively, press `D` and press `Enter` to disable Remote desktop.
1. When enabling Remote desktop, choose between the following options:
    - To allow only clients running Remote desktop with Network level authentication (more secure), type `1` and press `Enter`.
    - To allow clients running any version of Remote desktop (less secure), type `2` and press `Enter`.

## Configure network

By default, the operating system will attempt to provision a network address from a DHCP server. If no DHCP server is available, it will assign an Automatic Private IP Address (APIPA) to the network interface. Alternatively, you can assign a static IPv4 address manually, and specify the subnet mask and default gateway. When configuring an IPv4 address, you can also use this settings page to configure primary and secondary DNS servers.

1. From the main menu, type `8` and press `Enter` to enter the **Network settings** settings page.
1. In this list of available interfaces, type the number of the Interface, such as `1`, and press `Enter` to select that interface.
1. On the **Network adapter settings** settings page, choose one of the following options:
    1. Type `1` and press `Enter` to set the network adapter address.
    1. Press `D` and press `Enter` to configure DHCP or press `S` and press `Enter` to configure a static IP address.
    1. If you choose the static IP address option, provide the IPv4 address, subnet mask (in dotted quad notation, such as `255.255.255.0`), and default gateway address, pressing `Enter` after each entry.
1. Type `2` and press `Enter` to set the DNS server address.
    1. Provide the IPv4 address of a preferred DNS server and press `Enter`.
    1. Provide the IPv4 address of an alternate DNS server and press `Enter`.
1. Type `3` and press `Enter` to clear current DNS server settings.

## Date and time settings

Selecting the Date and time option from the main menu will open the Date and Time Control Panel applet. You can use this applet to set the date and time and to modify the time zone settings.

## Configure operating system diagnostic data (telemetry)

This option lets you configure whether anonymized statistical information about your system is forwarded to Microsoft.

1. From the SConfig main menu, type `10` and press `Enter` to enter the **Telemetry setting** settings page.
1. To change the telemetry setting, type `Y` for Yes or `N` for No and press `Enter`.

> [!NOTE]
> Windows Server and Azure Stack HCI have different default configuration regarding to telemetry. For information specific to Windows Server, see [Configure Windows diagnostic data in your organization](/windows/privacy/configure-windows-diagnostic-data-in-your-organization#diagnostic-data-settings). For Azure Stack HCI, see [Azure Stack HCI data collection](/azure-stack/hci/concepts/data-collection). Please note that you cannot configure Azure Stack HCI data collection in SConfig. To learn more about Microsoft's approach to privacy, see [Privacy at Microsoft](https://go.microsoft.com/fwlink/?LinkID=811315).

## Windows activation

This option lets you display current license and activation status, install a product key, and activate Windows Server

> [!NOTE]
> Activation is only needed for Windows Server. This menu item is not available on Azure Stack HCI as [Azure Stack HCI registration](/azure-stack/hci/manage/manage-azure-registration#unregister-azure-stack-hci-by-using-powershell) is a different process.

1. From the SConfig main menu, type `11` and press `Enter` to enter the **Windows activation** settings page.
2. Choose one of the following options:
    - Type `1` and press `Enter` to view the current Activation status.
    - Type `2` and press `Enter` to attempt Activation with the currently installed product key.
    - Type `3` and press `Enter` to add a new product key. At the prompt, type in the product key and press `Enter`. Press `Enter` again once the product key is installed and then return to this menu and use option `2` to perform activation.

## Log off the current user

1. From the main menu, type `12` and press Enter.
1. At the prompt asking if you are sure, type `Y` and press Enter. The currently signed in user will be logged off.

## Restart the server

1. From the main menu, type `13` and press `Enter`.
1. At the prompt asking if you are sure, type `Y` and press Enter. The server will restart.

## Shut down the server

1. From the main menu, type `14` and press `Enter`.
1. At the prompt asking if you are sure, type `Y` and press Enter. The server will shut down.

## Exit to command line (PowerShell)

This menu item closes the SConfig menu and returns to an interactive PowerShell prompt (or Command Prompt (CMD) for Windows Server 2019 or Windows Server 2016). You can use it to run arbitrary PowerShell commands and scripts for advanced configuration or troubleshooting. Many of these specialized options are not available natively in SConfig. Examples of this are, configuring [storage](/powershell/module/storage), advanced [network adapter settings](/powershell/module/netadapter) (such as setting VLAN IDs), and [installing device drivers](/windows-hardware/drivers/devtest/pnputil-command-syntax).

> [!NOTE]
> As a general rule, every setting available in the operating system can be controlled using command line tools or scripts. However, many of these settings are more conveniently managed remotely using graphical tools such as Windows Admin Center, Server Manager and System Center.

To exit to PowerShell from SConfig main menu, type `15` and press `Enter`. To return to Server configuration tool, type `SConfig`, and then press `Enter`. Alternatively, starting with Windows Server 2022 and Azure Stack HCI, type `exit`. It will close the current PowerShell window and open a new instance of SConfig automatically.

> [!NOTE]
> If you happened to manually launch SConfig from a Command Prompt session (as opposite to a PowerShell session), then exiting SConfig via menu option `15` will get you back to Command prompt. Even though the menu item says **Exit to command line (PowerShell)**, in this specific case, there is no interactive PowerShell session left.

### PowerShell is the default shell on Server Core

Before Windows Server 2022, the default shell on Server Core was Command Prompt (CMD). It launched by default when user signed in to Server Core. From there, you could either launch SConfig, or run arbitrary command-line tools.

Starting with Windows Server 2022 (when deployed with the Server Core installation option) and Azure Stack HCI, the default shell is PowerShell. It starts by default, and SConfig is launched automatically within the PowerShell window. If you exit SConfig by using menu option `15`, you get to the interactive PowerShell session.

However, if PowerShell is uninstalled, the default shell falls back to CMD. Unlike in previous versions of the operating system, if PowerShell is uninstalled, SConfig won't run either automatically or manually. You will only be able to use the classic command-line tools such as [netsh.exe](/windows-server/networking/technologies/netsh/netsh) and [diskpart.exe](/windows-server/administration/windows-commands/diskpart).

> [!NOTE]
> [Diskpart is deprecated](/windows/compatibility/vds-is-transitioning-to-windows-storage-management-api) and might not provide full functionality. For example, unlike PowerShell, it cannot manage Storage Spaces.

The change in default shell should be transparent for most users because you can run all the same command-line tools in PowerShell as you could in CMD. Moreover, PowerShell is much more capable than CMD both in terms of interactive language features and number of commands being available. However, in some edge case scenarios, a command in PowerShell might behave differently from CMD, such as if you were using batch file syntax (such as `set foo=bar`) in an interactive session. If you run a batch file instead, that is, a file with `.cmd` or `.bat` extension, it would be processed by CMD even if launched from PowerShell. In this scenario, you won't observe any differences.

You can explicitly transition to Command Prompt by typing `cmd` in PowerShell and pressing `Enter`. Alternatively, type `start cmd` if you prefer to launch a new window.

> [!NOTE]
> If you intend to *reload* an existing PowerShell session (e.g. for module updates to take effect), launching SConfig and exiting it won't be sufficient. This is because SConfig itself is a PowerShell application which runs within an existing PowerShell session. Exiting SConfig will get you into the original session.
>
> Instead, to reload a PowerShell session, type `exit` and press `Enter`. This will close the existing PowerShell window, and a new one will be started automatically. Note that reloading a PowerShell session is specific to Server Core installations of Windows Server and Azure Stack HCI. On Server with Desktop Experience installations of Windows Server, you will have to manually launch a new PowerShell window.

## Disable SConfig from starting automatically

SConfig launches automatically starting with Windows Server 2022 (when deployed with the Server Core installation option) and on Azure Stack HCI. You can stop SConfig from launching automatically by running the following command in PowerShell:

```powershell
Set-SConfig -AutoLaunch $False
```

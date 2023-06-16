---
title: Configure EAP profiles and settings in Windows
description: This article presents information about different ways to configure Extensible Authentication Protocol (EAP) settings.
author: samyun
ms.author: wscontent
ms.topic: conceptual
ms.date: 06/16/2023
---

# Configure EAP profiles and settings in Windows

> Applies to: Windows Server 2022, Windows 11, Windows 10

This article presents information about commonly used different ways to configure Extensible Authentication Protocol (EAP) settings. Specifically, it describes configuring EAP profiles using XML and command line tools. It also shows how to configure EAP settings and profiles using various UI in Windows.

## XML Profiles

As outlined in [XML profiles for EAP](network-access.md#xml-profiles-for-eap), connection profiles for Wi-Fi, Ethernet, and VPN are XML files that contain the configuration options for that connection. These profiles can be imported/exported and manually edited. When profiles are created or edited in UI (as detailed in the following sections), Windows internally sets the corresponding XML configuration options. As a result, you can use the UI to create a profile, and then export it to see the XML configuration options that were set.

> [!NOTE]
> Not every configuration option is exposed in the UI. It may be required, depending on your scenario, to manually edit the XML profile to set the desired configuration options, then import the updated profile for deployment.
>
> For example, when using Mobile Device Management (MDM) policies (such as [Wi-Fi CSP](/windows/client-management/mdm/wifi-csp)), you need to provision the full XML profile.

An example of a Wi-Fi profile can be found in [this sample](/windows/win32/nativewifi/wpa2-enterprise-with-tls-profile-sample).

### Import and export profiles with command line tools

Importing and exporting profiles using a command line tool can be helpful in many scenarios. For example, when configuring MDM or Group Policy isn't possible, manually or scripting these commands can be the quickest option. It can also be used to export profiles after configuring them through other UI.

### netsh

`netsh` is a command line tool that can be used to view and configure various network related settings. For more information, see [Network shell (netsh)](/windows-server/networking/technologies/netsh/netsh). `netsh` can be called from both `cmd` and `powershell`. The following table lists some common `netsh` commands and examples for importing and exporting profiles. `/?` can be used with any `netsh` command to get more information about the command, including syntax.

### [Wi-Fi](#tab/netsh-wifi)

| Command | Description |
| --- | --- |
| `netsh wlan show profiles` | Shows all Wi-Fi profiles, including the profile name. |
| `netsh wlan show profiles name="ProfileName"` | Shows detailed information about a specific Wi-Fi profile |
| `netsh wlan export profile name="ProfileName" folder="C:\Profiles"` | Exports a Wi-Fi profile to the specified folder. The folder must exist. |
| `netsh wlan add profile filename="C:\Profiles\ProfileName.xml"` | Adds a Wi-Fi profile from the specified file. |
| `netsh wlan delete profile name="ProfileName"` | Deletes a Wi-Fi profile. |

### [Wired](#tab/netsh-wired)

| Command | Description |
| --- | --- |
| `netsh lan show profiles` | Shows all wired profiles, including the profile name and other details. |
| `netsh lan show profiles interface="Ethernet"` | Shows detailed information about the wired profile on a specific interface. |
| `netsh lan export profile interface="Ethernet" folder="C:\Profiles"` | Exports a wired profile to the specified folder. The folder must exist. If no interface is specified, the machine profile is exported. |
| `netsh lan add profile filename="C:\Profiles\ProfileName.xml" interface="Ethernet"` | Adds a wired profile from the specified file to the specified interface. If no interface is specified, the profile is added as the machine profile. |
| `netsh lan delete profile interface="ProfileName"` | Deletes a wired profile. If no interface is specified, the machine profile is deleted. |

---

### PowerShell

[PowerShell](/PowerShell) is a command line shell and scripting language that can be used to view and configure various settings. It includes various commands (cmdlets) that can be used to import and export connection profiles. The [Get-Help](/powershell/module/microsoft.powershell.core/get-help) cmdlet can be used with any cmdlet to get more information about that cmdlet, including syntax.

### [VPN](#tab/powershell-vpn)

For detailed information about these cmdlets, see [Get-VpnConnection](/powershell/module/vpnclient/get-vpnconnection), [Set-VpnConnection](/powershell/module/vpnclient/set-vpnconnection), and [Add-VpnConnection](/powershell/module/vpnclient/add-vpnconnection).

| Command | Description |
| --- | --- |
| `Get-VpnConnection` | Shows all VPN profiles, including the profile name and other details. |
| `Get-VpnConnection -Name "ProfileName"` | Shows summary information about a specific VPN profile. |
| `(Get-VpnConnection -Name "ProfileName").EapConfigXmlStream.InnerXml \| Out-File -FilePath "C:\Profiles\vpn_eap.xml"` | Exports the EAP configuration for a specific VPN profile to a file. |
| `Set-VpnConnection -Name "ProfileName" -EapConfigXmlStream (Get-Content -Path "C:\Profiles\vpn_eap.xml")` | Imports the EAP configuration from a file and updates the specified VPN profile with it. |

---

## Settings app (Desktop Windows)

On the Windows desktop client, some Wi-Fi and Ethernet settings can be configured through the Settings app. The following screenshots show the Windows 11 Settings app, but the UI is similar in Windows 10. However, certain features and options may only be available in Windows 11.

### [Wi-Fi](#tab/settings-wifi)

Windows 10 and 11 have support for adding Wi-Fi profiles with a specific configuration in the Settings app. This setting can be found in the Settings app under **Network & internet** > **Wi-Fi** > **Manage known networks** > **Add network**:
:::image type="content" source="images/desktop/settings-l1.png" alt-text="Network & internet page on Windows 11 settings app":::
:::image type="content" source="images/desktop/wifi-l2.png" alt-text="Wi-Fi page on Windows 11 settings app":::
:::image type="content" source="images/desktop/wifi-manage-known-networks.png" alt-text="Manage known networks page on Windows 11 settings app":::
:::image type="content" source="images/desktop/add-new-wifi-network.png" alt-text="Add a new network dialog in Windows 11 settings app":::

This dialog allows you to configure the SSID, security type, and other settings for the Wi-Fi profile. When a security type supporting EAP is selected, such as **WPA3-Enterprise AES**, the dialog shows an option to configure the EAP settings:
:::image type="content" source="images/desktop/add-new-wifi-network-eaptls.png" alt-text="Add a new network dialog, showing WPA3-Enterprise and EAP-TLS, on Windows 11 settings app":::

> [!TIP]
> Once the network is added, it is not possible to edit the EAP settings through the Settings app. To edit the EAP settings, either:
>
> * delete the profile and re-add it with the correct settings, or
> * use the `netsh` commands described in [netsh](#netsh) to manually edit the profile.

### [Wired](#tab/settings-wired)

Windows 11 added support for changing 802.1X authentication settings on wired connections in the Settings app. This setting can be found in the Settings app under **Network & internet** > **Ethernet** > **Authentication settings** > **Edit** > **Ethernet authentication settings**: :
:::image type="content" source="images/desktop/settings-l1.png" alt-text="Network & internet page on Windows 11 settings app":::
:::image type="content" source="images/desktop/ethernet-l2.png" alt-text="Ethernet page on Windows 11 settings app":::
:::image type="content" source="images/desktop/ethernet-auth-settings-dialog.png" alt-text="Ethernet authentication settings dialog in Windows 11 settings app":::

Toggling **On** the **Enable IEEE 802.1X authentication** setting allows you to edit the EAP settings for this profile:
:::image type="content" source="images/desktop/ethernet-auth-settings-dialog-expanded.png" alt-text="Ethernet authentication settings dialog, expanded, in Windows 11 settings app":::

If the computer has a machine profile configured or the interface has a profile configured by Group Policy, the **Enable IEEE 802.1X authentication** setting is disabled and can't be changed:
:::image type="content" source="images/desktop/ethernet-auth-settings-dialog-grouppolicy.png" alt-text="Ethernet authentication settings dialog, disabled by group policy, in Windows 11 settings app":::

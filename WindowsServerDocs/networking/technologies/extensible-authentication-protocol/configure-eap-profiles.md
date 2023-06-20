---
title: Configure EAP profiles and settings in Windows
description: This article presents information about different ways to configure Extensible Authentication Protocol (EAP) settings.
author: samyun
ms.author: wscontent
ms.topic: conceptual
ms.date: 06/19/2023
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

On the Windows desktop client, many common Wi-Fi, Ethernet, and VPN settings can be configured through the Settings app. The following screenshots show the Windows 11 Settings app, but the UI is similar in Windows 10. However, certain features and options may only be available in Windows 11.

### [Wi-Fi](#tab/settings-wifi)

Windows 10 and 11 have support for adding Wi-Fi profiles with a specific configuration (including 802.1X) in the Settings app. This setting can be found in the Settings app under **Network & internet** > **Wi-Fi** > **Manage known networks** > **Add network**:
:::image type="content" source="images/desktop/settings-l1.png" alt-text="Screenshot of Network & internet page on Windows 11 settings app.":::
:::image type="content" source="images/desktop/wifi-l2.png" alt-text="Screenshot of Wi-Fi page on Windows 11 settings app.":::
:::image type="content" source="images/desktop/wifi-manage-known-networks.png" alt-text="Screenshot of Manage known networks page on Windows 11 settings app.":::
:::image type="content" source="images/desktop/add-new-wifi-network.png" alt-text="Screenshot of Add a new network dialog in Windows 11 settings app.":::

This dialog allows you to configure the SSID, security type, and other settings for the Wi-Fi profile. When a security type supporting EAP is selected, such as **WPA3-Enterprise AES**, the dialog shows an option to configure the EAP settings:
:::image type="content" source="images/desktop/add-new-wifi-network-eap-tls.png" alt-text="Screenshot of Add a new network dialog, showing WPA3-Enterprise and EAP-TLS, on Windows 11 settings app.":::

> [!TIP]
> Once the network is added, it is not possible to edit the EAP settings through the Settings app. To edit the EAP settings, either:
>
> * delete the profile and re-add it with the correct settings, or
> * use the `netsh` commands described in [netsh](#netsh) to manually edit the profile.

### [Wired](#tab/settings-wired)

Windows 11 added support for changing 802.1X authentication settings on wired connections in the Settings app. This setting can be found in the Settings app under **Network & internet** > **Ethernet** > **Authentication settings** > **Edit** > **Ethernet authentication settings**:
:::image type="content" source="images/desktop/settings-l1.png" alt-text="Screenshot of Network & internet page on Windows 11 settings app.":::
:::image type="content" source="images/desktop/ethernet-l2.png" alt-text="Screenshot of Ethernet page on Windows 11 settings app.":::
:::image type="content" source="images/desktop/ethernet-auth-dialog.png" alt-text="Screenshot of Ethernet authentication settings dialog in Windows 11 settings app.":::

Toggling **On** the **Enable IEEE 802.1X authentication** setting allows you to edit the EAP settings for this profile:
:::image type="content" source="images/desktop/ethernet-auth-dialog-expanded.png" alt-text="Screenshot of Ethernet authentication settings dialog, expanded, in Windows 11 settings app.":::

If the computer has a machine profile configured or the interface has a profile configured by Group Policy, the **Enable IEEE 802.1X authentication** setting is disabled and can't be changed:
:::image type="content" source="images/desktop/ethernet-auth-dialog-group-policy.png" alt-text="Screenshot of Ethernet authentication settings dialog, disabled by group policy, in Windows 11 settings app.":::

### [VPN](#tab/settings-vpn)

Windows 10 and 11 have support for modifying VPN profiles, including EAP options, in the Settings app. This setting can be found in the Settings app under **Network & internet** > **VPN**:
:::image type="content" source="images/desktop/settings-l1.png" alt-text="Screenshot of Network & internet page on Windows 11 settings app.":::
:::image type="content" source="images/desktop/vpn-l2.png" alt-text="Screenshot of VPN page on Windows 11 settings app.":::

Selecting **Add VPN** allows you to add a new VPN profile:
:::image type="content" source="images/desktop/vpn-add-dialog.png" alt-text="Screenshot of Add a VPN connection dialog in Windows 11 settings app.":::

Once added, the VPN profile can be edited by expanding the profile and selecting **Advanced options** > **Edit**:
:::image type="content" source="images/desktop/vpn-expanded.png" alt-text="Screenshot of VPN page with selected profile in Windows 11 settings app.":::
:::image type="content" source="images/desktop/vpn-advanced-options.png" alt-text="Screenshot of VPN advanced options page for a profile in Windows 11 settings app.":::
:::image type="content" source="images/desktop/vpn-edit-dialog.png" alt-text="Screenshot of VPN profile Edit dialog in Windows 11 settings app.":::

---

## Group Policy Editor (Desktop and Server)

[Group Policy](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831791(v=ws.11)) is an infrastructure that lets you manage configurations for users and computers. Using **Group Policy**, you can configure Wi-Fi, Ethernet, and VPN settings based on rules you define. The following screenshots show the Windows Server 2022 Group Policy Management Editor, but the UI is similar for Desktop Windows' Control Panel and Local Group Policy Editor. For more information on the options shown in the following screenshots, see [Extensible Authentication Protocol (EAP) for network access](network-access.md#extensible-authentication-protocol-eap-for-network-access).

### [Wi-Fi](#tab/group-policy-wifi)

**Group Policy** options for Wi-Fi are located under **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Wireless Network (IEEE 802.11) Policies**:
:::image type="content" source="images/group-policy/editor/wifi-l1.png" alt-text="Screenshot showing Wireless Network (IEEE 802.11) Policies option in Group Policy Management Editor.":::

Right-clicking on **Wireless Network (IEEE 802.11) Policies** and selecting **Create A New Wireless Network Policy for Windows Vista and Later Releases** opens the **New Wireless Network Policy Properties** dialog:
:::image type="content" source="images/group-policy/editor/wifi-new-policy.png" alt-text="Screenshot showing Create A New Wireless Network Policy for Windows Vista and Later Releases option in Group Policy Management Editor.":::
:::image type="content" source="images/group-policy/editor/wifi-new-network.png" alt-text="Screenshot showing the New Wireless Network Policy Properties dialog.":::

This dialog allows you to set the policy name, a description, and **Add**/**Edit**/**Remove** profiles, as well as **Import** and **Export** [XML Profiles](#xml-profiles).

Clicking **Add** and selecting **Infrastructure** opens the **New Profile properties** dialog:
:::image type="content" source="images/group-policy/editor/wifi-new-profile.png" alt-text="Screenshot showing the New Profile properties dialog.":::

This dialog allows you to set the **Profile Name** and add the SSIDs this profile applies to.

Selecting **Security** allows you to configure the EAP settings for the profile:
:::image type="content" source="images/group-policy/editor/wifi-new-profile-security.png" alt-text="Screenshot showing the Security tab of the New Profile properties dialog.":::

This dialog allows you to configure the security type and other settings for the Wi-Fi profile. When an **Authentication** type supporting 802.1X authentication is selected (such as **WPA2-Enterprise**), the [802.1X security options](network-access.md#security-settings) are visible. See [EAP methods](#eap-methods) for details on each network authentication method.

When the **Advanced...** button is selected, the **Advanced Security Settings** dialog is shown:
:::image type="content" source="images/group-policy/editor/wifi-advanced-security.png" alt-text="Screenshot showing the Advanced security settings dialog for Wi-Fi.":::

This dialog allows you to set some [advanced 802.1X settings](network-access.md#advanced-security-settings--ieee-8021x) and [Single Sign On](network-access.md#advanced-security-settings--single-sign-on) options.

> [!TIP]
> Not every setting is available for configuration in the Group Policy Editor. However, this can be worked around by importing an XML profile with the desired settings. For more information, see [XML Profiles](#xml-profiles).

### [Wired](#tab/group-policy-wired)

**Group Policy** options for Wired are located under **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Wired Network (IEEE 802.3) Policies**:
:::image type="content" source="images/group-policy/editor/wired-l1.png" alt-text="Screenshot showing Wired Network (IEEE 802.3) Policies option in Group Policy Management Editor.":::

Right-clicking on **Wired Network (IEEE 802.3) Policies** and selecting **Create A New Wired Network Policy for Windows Vista and Later Releases** opens the **New Wired Network Policy Properties** dialog:
:::image type="content" source="images/group-policy/editor/wired-new-policy.png" alt-text="Screenshot showing Create A New Wired Network Policy for Windows Vista and Later Releases option in Group Policy Management Editor.":::
:::image type="content" source="images/group-policy/editor/wired-new-policy-props.png" alt-text="Screenshot showing the New Wired Network Policy Properties dialog.":::

This dialog allows you to set the policy name, a description, and the following options:

|Setting|XML element|Description|
|--|--|--|
|Use Windows Wired Auto Config service for clients|[enableAutoConfig](/windows/win32/nativewifi/lan-policyschema-enableautoconfig-globalflags-element)|If selected, the Windows Wired Auto Config (**dot3svc**) can be used to connect to wired networks without explicit configuration. If unselected, the network specified in this policy is the only network available for connection. |
|Don't allow shared user credentials for network authentication|**enableExplicitCreds**|If selected, shared user credentials aren't allowed for network authentication. Credentials must be explicit. |
|Enable block period (minutes)|**blockPeriod**|Defaulting to 20 minutes, specifies the duration for which automatic authentication attempts will be blocked from occurring after a failed authentication attempt.|

Selecting **Security** allows you to configure the EAP settings for the profile:
:::image type="content" source="images/group-policy/editor/wired-new-policy-security.png" alt-text="Screenshot showing the Security tab of the New Wired Network Properties dialog.":::

This dialog allows you to configure the security type and other settings for the wired network. For more information, see [802.1X security options](network-access.md#security-settings). See [EAP methods](#eap-methods) for details on each network authentication method.

When the **Advanced...** button is selected, the **Advanced Security Settings** dialog is shown:
:::image type="content" source="images/group-policy/editor/wired-advanced-security.png" alt-text="Screenshot showing the Advanced security settings dialog for Wired.":::

This dialog allows you to set some [advanced 802.1X settings](network-access.md#advanced-security-settings--ieee-8021x) and [Single Sign On](network-access.md#advanced-security-settings--single-sign-on) options.

> [!TIP]
> Not every setting is available for configuration in the Group Policy Editor. However, this can be worked around by backing up the **Group Policy Object**, editing the **Backup.xml** file with the desired settings, and re-importing it. For more information, see [XML Profiles](#xml-profiles).

---

## EAP methods

For an overview on the different EAP methods, see [Authentication methods](network-access.md#authentication-methods).

### Microsoft: Smart Card or other certificate

For more information on this dialog, see [EAP-TLS](network-access.md?tabs=eap-tls#authentication-method-configuration-settings).
:::image type="content" source="images/group-policy/methods/eap-tls-properties.png" alt-text="Screenshot showing the Smart Card or other certificate Properties dialog.":::

Selecting **Advanced** opens the [Configure Certificate Selection](network-access.md?tabs=eap-tls#cert-filteringinfo) dialog:
:::image type="content" source="images/group-policy/methods/certificate-selection.png" alt-text="Screenshot showing the Configure Certificate Selection dialog.":::

### Microsoft: Protected EAP (PEAP)

For more information on this dialog, see [PEAP](network-access.md?tabs=peap#authentication-method-configuration-settings).
:::image type="content" source="images/group-policy/methods/peap-properties.png" alt-text="Screenshot showing the Protected EAP Properties dialog.":::

Selecting **Configure...** when **Secured password (EAP-MSCHAP v2)** is selected opens the **EAP MSCHAPv2** dialog:
:::image type="content" source="images/group-policy/methods/mschapv2-properties.png" alt-text="Screenshot showing the EAP MSCHAPv2 Properties dialog.":::

### Microsoft: EAP-SIM

For more information on this dialog, see [EAP-SIM](network-access.md?tabs=eap-sim#cellular-authentication-configuration-settings).
:::image type="content" source="images/group-policy/methods/eap-sim-properties.png" alt-text="Screenshot showing the EAP-SIM Properties dialog.":::

### Microsoft: EAP-TTLS

For more information on this dialog, see [EAP-TTLS](network-access.md?tabs=eap-ttls#authentication-method-configuration-settings).
:::image type="content" source="images/group-policy/methods/eap-ttls-properties.png" alt-text="Screenshot showing the TTLS Properties dialog.":::

### Microsoft: EAP-AKA

For more information on this dialog, see [EAP-AKA](network-access.md?tabs=eap-aka#cellular-authentication-configuration-settings).
:::image type="content" source="images/group-policy/methods/eap-aka-properties.png" alt-text="Screenshot showing the EAP-AKA Properties dialog.":::

### Microsoft: EAP-AKA'

For more information on this dialog, see [EAP-AKA'](network-access.md?tabs=eap-aka-prime#cellular-authentication-configuration-settings).
:::image type="content" source="images/group-policy/methods/eap-aka-prime-properties.png" alt-text="Screenshot showing the EAP-AKA' Properties dialog.":::

### Microsoft: EAP-TEAP

For more information on this dialog, see [TEAP](network-access.md?tabs=teap#authentication-method-configuration-settings).
:::image type="content" source="images/group-policy/methods/teap-properties.png" alt-text="Screenshot showing the TEAP Properties dialog.":::

## Additional resources

- [Managing the New Wireless Network (IEEE 802.11) Policies Settings](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh994701(v=ws.11))
- [Managing the New Wired Network (IEEE 802.3) Policies Settings](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831813(v=ws.11))
- [Advanced Security Settings for Wired and Wireless Network Policies](/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh994696(v=ws.11))

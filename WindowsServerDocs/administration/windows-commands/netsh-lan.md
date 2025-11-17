---
title: netsh lan
description: Reference article for the netsh lan command that manages and configures LAN settings on your Windows-based computer.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/25/2025
---

# netsh lan

The `netsh lan` command allows you to manage and configure local area network (LAN) settings on your computer.

## Syntax

```
netsh lan add | delete | dump | export | help | reconnect | set | show | ?
```

```
netsh lan add profile [filename=]<string> [interface=]<string>
netsh lan delete profile [interface=]<string>
netsh lan export profile [folder=]<string> [interface=]<string>
```

```
netsh lan reconnect [interface=]<string>
```

```
netsh lan set autoconfig [enabled=] <yes|no> [interface=] <string>
netsh lan set blockperiod [value=]<0-60>
netsh lan set eapuserdata [filename=]<string> [allusers]<yes|no> [interface=]<string>
```

```
netsh lan set profileparameter [[interface=]<string>]
                               [authMode=]<machineOrUser|machineOnly|userOnly|guest>
                               [ssoMode=]<preLogon|postLogon|none> [maxDelay=]<1-120>
                               [allowDialog=]<yes|no> [userVLAN=]<yes|no>
                               [oneXEnabled=]<yes|no> [oneXEnforced=]<yes|no>
```

```
netsh lan set trace [mode=]<yes|no|persistent>
```

```
netsh lan show interfaces
netsh lan show profiles [interface=]<string>
netsh lan show [settings | tracing]
```

## Parameters

| Command | Description |
|--|--|
| add profile `filename=<string>` `interface=<string>` | Adds a new profile configuration entry to a table for LAN settings. <br><br> **filename** - The name of the profile XML file. <br> **interface** - The name of the network interface the profile is added to. |
| delete profile `interface=<string>` | Removes a profile configuration entry from a table for LAN settings. <br><br> **interface** - The name of the network interface. |
| dump | Displays a script of the current LAN configuration. Can also be exported to a text file. |
| export profile `folder=<string>` `interface=<string>` | Exports the LAN profiles as XML files for backup or restore. <br><br> **folder** - The name of the folder where the profile XML files is saved to. <br> **interface** - The name of the network interface. |
| reconnect `interface=<string>` | Re-establishes a connection on a network interface. If the string value contains spaces, it must be wrapped in double quotes (**" "**). <br><br> **interface** - The name of the network interface to reconnect to. |
| set allowexplicitcreds `allow=<yes|no>` | Allows or disallows the use of shared user credentials. The `allow` parameter required. |
| set autoconfig `enabled=<yes|no>` `interface=<string>` | **enabled** - specifies whether autoconfiguration is set to on or off. <br> **interface** - The name of the network interface. <br><br> Both parameters are required. |
| set blockperiod `value=<0-60>` | **value** - Sets the duration, in minutes, where automatic connection attempts to a network are paused. The blocked state is cleared when you manually attempt to connect to a LAN, when a session changes, or when the network media reconnects. |
| set eapuserdata `filename=<string>` `allusers=<yes|no>` `interface=<string>` | **filename** - Specifies the name of the user data XML file. <br> **allusers** - Specifies whether userdata should be saved for all users or the current user. <br> **interface** - The name of the network interface. <br><br> Both `filename` and `allusers` parameters are required. If the interface name isn't specified, the machine userdata is set. |
| set profileparameter `interface=<string>` <br> `authMode=<machineOrUser` \| `machineOnly` \| `userOnly` \| `guest>` <br> `ssoMode=<preLogon` \| `postLogon` \| `none>` <br> `maxDelay=<1-120>` <br> `allowDialog=<yes|no>` <br> `userVLAN=<yes|no>` <br> `oneXEnabled=<yes|no>` <br> `oneXEnforced=<yes|no>` | Configures or modifies LAN profile settings. <br><br> **interface** - The name of the network interface. <br> **authMode** - The method type used for authenticating credentials. <br> **ssoMode** - The type of single sign-on (SSO) used (if any). <br> **maxDelay** - The timeout value to establish an SSO connection. <br> **allowDialog** - Enables or disables a dialog for prelogon. Prelogon is relevant in scenarios where network authentication is needed before a user logs into the system, such as with 802.1X authentication. <br> **userVLAN** - Specifies whether the network connection can switch to a different Virtual Local Area Network (VLAN) after a user authenticates. <br> **oneXEnabled** - Specifies whether 802.1X authentication is enabled on the network interface. <br> **oneXEnforced** - Specifies if 802.1X authentication is enforced. When enforced, the network interface requires successful 802.1X authentication before allowing network access. |
| set tracing `mode=<yes|no|persistent>` | Specifies if you want to enable or disable logging trace files for the LAN connection for diagnostic purposes. If set to `persistent`, tracing is enabled even after a network adapter is disabled, re-enabled, or a system is rebooted. |
| show `interfaces` \| `profiles` \| `settings` \| `tracing` | Displays the current LAN settings and information. <br><br> `interfaces` - Displays the local LAN interfaces.<br> `profiles` - Displays all local configured LAN profiles. <br> `settings` - Displays the local global LAN settings. <br> `tracing` - Displays if LAN tracing is enabled or disabled. |
| help or ? | Displays a list of commands and their descriptions in the current context. |

## Remarks

- **add profile**: The `interface` parameter is optional. The filename parameter is required and specifies the XML file that contains the profile data.

- **delete profile**: The `interface` parameter is optional. If you specify an interface, the profile is deleted only from that interface. If no interface is specified, the profile is deleted from the machine profile.

- **export profile**: The `interface` parameter is optional. If an interface name is specified, the profile for that interface is exported as "InterfaceName.xml". If no interface is specified, all profiles are exported, and the machine profile is saved as "MachineProfile.xml".

  The folder name is required and must point to an existing folder accessible from the local computer. You can use an absolute path or a relative path based on the current working directory. The value "." refers to the current directory, while ".." refers to its parent directory. Universal Naming Convention (UNC) paths aren't supported.

- **reconnect**: The `interface` parameter is optional. If an interface name is specified, only that interface reconnects. If no interface is specified, all interfaces reconnect.

- **set profileparameter**: Modifies the profile on specified interface. If the interface is specified, then only profile on that interface is modified. At least one parameter besides `interface` must be specified.

## Examples

To add a new LAN profile from an XML file to a specific interface, run the following command:

```cmd
netsh lan add profile filename="C:\Profiles\MyLANProfile.xml" interface="Ethernet"
```

To re-establish a connection on a network interface, run the following command:

```cmd
netsh lan reconnect interface="Ethernet"
```

To enable autoconfiguration on a network interface, run the following command:

```cmd
netsh lan set autoconfig enabled=yes interface="Ethernet"
```

To configure a LAN profile to use machine-only authentication mode, run the following command:

```cmd
netsh lan set profileparameter interface="Ethernet" authMode=machineOnly
```

To set the block period for automatic connection attempts to 30 minutes, run the following command:

```cmd
netsh lan set blockperiod value=30
```

To save Extensible Authentication Protocol (EAP) user data to an XML file for all users on a specific interface, run the following command:

```cmd
netsh lan set eapuserdata filename="C:\UserData\EAPConfig.xml" allusers=yes interface="Ethernet"
```

To display all the local configured LAN profiles, run the following command:

```cmd
netsh lan show profiles
```

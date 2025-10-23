---
title: netsh mbn
description: The netsh mbn command manages Mobile Broadband (MBN) interfaces, cellular modems, and SIM-based network connections in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/09/2025
---

# netsh mbn

The `netsh mbn` command is used to configure, monitor, and troubleshoot Mobile Broadband (MBN) interfaces, including cellular modems and SIM-based network connections. It provides a range of options for managing profiles, connections, radio states, and advanced settings for mobile broadband devices on Windows.

The **WWAN AutoConfig** service must be running on your device for certain commands and parameters to function.

## Syntax

```
netsh mbn [add | connect | delete | disconnect | dump | help | set | show | test | ?]
```

```
netsh mbn add dmprofile [interface=]<string> [name=]<string>
netsh mbn add profile [interface=]<string> [name=]<string>
```

```
netsh mbn connect [interface=]<string> [connmode=]tmp|name [name=]<string>
```

```
netsh mbn delete dmprofile [interface=]<string> [name=]<string>
netsh mbn delete profile [interface=]<string> [name=]<string>
```

```
netsh mbn disconnect [interface=]<string>
```

```
netsh mbn set acstate [interface=]<string> [state=]autooff|autoon|manualoff|manualon
netsh mbn set dataenablement [interface=]<string> [profileset=]internet|mms|all [mode=]yes|no
netsh mbn set dataroamcontrol [interface=]<string> [profileset=]internet|mms|all [state=]none|partner|all
netsh mbn set enterpriseapnparams [interface=]<string> [allowusercontrol=]yes|no|nc [allowuserview=]yes|no|nc
                                  [profileaction=]add|delete|modify|nc
netsh mbn set highestconncategory [interface=]<string> [highestcc=]admim|user|operator|device
netsh mbn set powerstate [interface=]<string> [state=]on|off
netsh mbn set profileparameter [name=]<string> [[interface=]<string>] [cost]=default|unrestricted|fixed|variable
netsh mbn set slotmapping [interface=]<string> [slotindex=]<integer>
netsh mbn set tracing [mode=]yes|no
```

```
netsh mbn show acstate [interface=]<string>
               basestationinfo [interface=]<string>
               capability [interface=]<string>
               connection [interface=]<string>
               d3cold [interface=]<string>
               dataenablement [interface=]<string>
               dataroamcontrol [interface=]<string>
               dmprofiles [name=]<string> [interface=]<string>
               enterpriseapnparams [interface=]<string>
               highestconncategory [interface=]<string>
               homeprovider [interface=]<string>
               interfaces
               McmInfo [interface=]<string>
               netlteattachinfo [interface=]<string>
               pin [interface=]<string>
               pinlist [interface=]<string>
               preferredproviders [interface=]<string>
               profiles [name=]<string> [interface=]<string> [purpose=]<string>
               profilestate [interface=]<string> [name=]<string>
               provisionedcontexts [interface=]<string> [name=]<string>
               purpose
               radio [interface=]<string>
               readyinfo [interface=]<string> [slotindex=]<integer>
               signal [interface=]<string>
               slotmapping [interface=]<string>
               slotstatus [interface=]<string>
               smsconfig [interface=]<string>
               tracing
               UICCCardAdditionalInfoWithEFHPLMNwAct [interface=]<string>
               visibleproviders [interface=]<string>
```

```
netsh mbn test [feature=<feature area>] [testPath=<path>] [taefPath=<path>] [param=<test input params>]
```

## Parameters

| Command | Description |
|--|--|
| mbn `add` | `dmprofile` - Adds a Mobile Broadband Device Management Config Profile for the given interface for all users: <br> `interface` - The interface name. <br> `name` - The XML profile name. <br><br> `profile` - Adds a Mobile Broadband Network Profile for the given interface for all users: <br> `interface` - The interface name. <br> `name` - The XML profile name. <br><br> The `interface` and `name` parameters are required. |
| mbn `connect` | Connects to a Mobile Broadband Network using a specified profile. The device must be registered before running this command. The `interface` parameter is required. <br><br> `connmode` - Determines how connection parameters are provided: <br> - `tmp`: Use a profile XML file for a temporary connection. <br> - `name`: Use a profile that was previously stored with the `netsh mbn add profile` command. <br><br> `name` - If `connmode` is set to `tmp`, specify the profile XML file name. If `connmode` is set to `name`, specify the stored profile name. |
| mbn `delete` | `dmprofile` - Removes a Mobile Broadband Device Management Config Profile for the given interface.  <br> `interface` - The interface name. <br> `name` - The XML profile name. <br><br> `profile` - Removes a Mobile Broadband Network Profile from the given interface: <br> `interface` - The interface name. <br> `name` - The XML profile name. <br><br> The `interface` and `name` parameters are required. |
| mbn `disconnect` | Disconnects from the Mobile Broadband Network on the specified interface: <br> `interface` - The interface name. <br><br> The `interface` parameter is required. |
| mbn `dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| mbn `set` | Configures one of the following settings: <br><br> `acstate` - Configures the auto-connect behavior for Mobile Broadband data on the interface. The parameters `interface` and `state` are required. <br> `state` - Configures one of the following values: <br> - `autooff`: Turns auto connect token off. <br> - `autoon`: Turns auto-connect token on. <br> - `manualoff`: Turns off the manual connect token. <br> - `manualon`: Turns on the manual connect token. <br><br> `dataenablement` - Enables or disables Mobile Broadband data for a specified profile set and interface. The parameters `interface`, `profileset`, and `mode` are required. <br> `profileset` - Is the name of the profile set: <br> - `internet`, `mms`, or `all` <br> - `mode`: Enables (`yes`) or disables (`no`) the target profile set. <br><br> `dataroamcontrol` - Adjusts data roaming settings for Mobile Broadband on the selected profile set and interface. The parameters `interface`, `profileset`, and `mode` are required. <br> `profileset` - Is the name of the profile set: <br> - `internet`, `mms`, or `all` <br> - `state`: Applies changes to the home carrier only (`none`), home and partner carriers only (`partner`), or home, partner, and roaming carriers (`all`). <br><br> `enterpriseapnparams` - Modifies enterprise Access Point Name (APN) parameters for Mobile Broadband on the specified interface. The parameters `interface`, `allowusercontrol`, `allowuserview`, and `profileaction` are required. <br> - `allowusercontrol`: Allows (`yes`) or disallows (`no`) end user control of enterpriseAPN. Use `nc` to leave at default state. <br> - `allowuserview`: Allows (`yes`) or disallows (`no`) end user view of enterpriseAPN. Use `nc` to leave at default state. <br> - `profileaction`:  Adds (`add`), deletes (`delete`) or modifies (`modify`) an enterpriseAPN profile. Use `nc` to leave at default state. <br><br> `highestconncategory` - Specifies the highest allowed connection category for Mobile Broadband on the given interface. The parameters `interface` and `highestcc` are required. <br> - Sets one of the provisioned profile types: <br> - `admin` <br> - `user` <br> - `operator` <br> - `device` <br><br> `powerstate` - Switches the Mobile Broadband radio on or off for the specified interface. The parameters `interface` and `state` are required. <br> `state`: Enables (`yes`) or disables (`no`) the radio transceiver. <br><br> `profileparameter` - Updates parameters within a Mobile Broadband Network Profile. The `name` parameter and at least one other parameter, such as `interface` or `cost`, must be specified. <br> - `name`: The profile name to be modified. <br> - `interface`: The interface name. <br> - `cost`: The cost associated with the profile. <br><br> `slotmapping` - Assigns modem slot mapping for Mobile Broadband on the specified interface. The parameters `interface` and `slotindex` are required. <br> - `interface`: The interface name. <br> - `slotindex`: The interface slot index number to be set. <br><br> `tracing` - Turns tracing on or off for Mobile Broadband operations. The `mode` parameter is required. <br> - `mode`: Enables (`yes`) or (`disables`) tracing for the Mobile Broadband. |
| mbn `show` | Displays on of the following information: <br><br> `acstate interface=` - Displays the auto connect state for Mobile Broadband data on the specified interface. <br><br> `basestationinfo interface=` - Displays base station information for the specified interface. <br><br> `capability interface=` - Displays capability details for the specified interface. <br><br> `connection interface=` - Displays current connection details for the specified interface. <br><br> `d3cold interface=` - Indicates whether the modem supports D3Cold power state for the specified interface. <br><br> `dataenablement interface=` - Displays the data enablement status for the specified interface. <br><br> `dataroamcontrol interface=` - Displays the data roaming control status for the specified interface. <br><br> `dmprofiles` - Lists Direct Management Config profiles configured on the system. Use the `name` and `interface` parameters to filter for specific profiles on certain interfaces. <br><br> `enterpriseapnparams interface=` - Displays enterprise APN parameters for the specified interface. <br><br> `highestconncategory interface=` - Displays the highest connection category for the specified interface. <br><br> `homeprovider interface=` - Displays home provider details for the specified interface. <br><br> `interfaces` - Lists all Mobile Broadband interfaces on the system. <br><br> `McmInfo interface=` - Displays MCM-related information for the specified interface. <br><br> `netlteattachinfo interface=` - Displays LTE attach information for the specified interface. <br><br> `pin interface=` - Displays PIN information for the specified interface. <br><br> `pinlist interface=` - Displays the list of PINs for the specified interface. <br><br> `preferredproviders interface=` - Displays the list of preferred providers for the specified interface. <br><br> `profiles` - Lists all configured profiles on the system. Use the `name` and `interface` parameters to filter for specific profiles on certain interfaces. If `purpose` is provided, only profiles with the matching purpose GUID are displayed. The following strings are acceptable: <br> - `GUID` <br> - `internet` <br> - `supl` <br> - `mms` <br> - `ims` <br> - `allhost` <br><br>`profilestate` - Displays the state of a profile for the specified interface. The `interface` and `name` parameters are required. <br><br> `provisionedcontexts interface=` - Displays provisioned context information for the specified interface. <br><br> `purpose` - Displays available purpose group GUIDs. <br><br> `radio interface=` - Displays radio state information for the specified interface. <br><br> `readyinfo` - Displays readiness information for the specified interface. The `interface` parameter is required while `slotindex` is optional. <br><br> `signal interface=` - Displays signal strength and quality for the specified interface. <br><br> `slotmapping interface=` - Displays modem slot mapping for the specified interface. <br><br> `slotstatus interface=` - Displays modem slot status for the specified interface. <br><br> `smsconfig interface=` - Displays SMS configuration details for the specified interface. <br><br> `tracing` - Indicates whether tracing is enabled or disabled. <br><br> `UICCCardAdditionalInfoWithEFHPLMNwAct interface=` - Displays EFInfo in UICC for the specified interface. <br><br> `visibleproviders interface=` - Displays the list of visible providers for the specified interface. |
| mbn `test` | Performs mobile broadband testing operations. <br><br> `feature` (required) - Is the feature area: <br> - `connectivity` <br> - `power` <br> - `radio` <br> - `esim` <br> - `esimhlk` <br> - `sms` <br> - `dssa` <br> - `lte` <br> - `bringup` <br> - `nr` <br> `testpath` - Is the path containing the test binaries. <br> `taefpath` - Is the path containing the TAEF binaries. <br> `param` - Tests other fields using colon separated values: <br> - `connectivity`, `radio`, or `bringup`: The `AccessString` or `UserName` (if applicable), and `Password` (if applicable). <br> - `esim`: The `ActivationCode`. <br><br> The `testPath` and `taefPath` parameters are optional on amd64 devices where HLK Server is installed. |
| mbn `help` or `?` | Displays a list of commands and their descriptions in the current context. |

## Remarks

- Values given to the `interface` parameter must be wrapped in double quotes (**" "**) for interface names containing a space.

- If you're in the `mbn` context, you can run `show interfaces` to display all interface names.

## Examples

To add a Device Management profile for the mobile broadband interface named "Cellular", with the profile name "EnterpriseDM", run the following command:

```cmd
netsh mbn add dmprofile interface=Cellular name=EnterpriseDM
```

To connect the mobile broadband interface "Cellular" using a temporary profile XML file named "temp_profile.xml", run the following command:

```cmd
netsh mbn connect interface=Cellular connmode=tmp name=temp_profile.xml
```

To disconnect the mobile broadband interface "Cellular", run the following command:

```cmd
netsh mbn disconnect interface=Cellular
```

To turn on auto-connect for the "Cellular" interface, run the following command:

```cmd
netsh mbn set acstate interface=Cellular state=autoon
```

To add an enterprise APN profile for the "Cellular" interface, allowing user control, and view, run the following command:

```cmd
netsh mbn set enterpriseapnparams interface=Cellular allowusercontrol=yes allowuserview=yes profileaction=add
```

To display the tracing status for Mobile Broadband commands, run the following command:

```cmd
netsh mbn show tracing
```

To perform a connectivity test with the AccessString "internet", run the following command:

```cmd
netsh mbn test feature=connectivity param="AccessString=internet"
```

To perform an eSIM test that selects the DSSA category, run the following command:

```cmd
netsh mbn test feature=esim param="/select:\"(@Category='DSSA')\""
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)

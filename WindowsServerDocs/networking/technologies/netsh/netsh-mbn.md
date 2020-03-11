---
title: Netsh Commands for Mobile Broadband Network (MBN)
description: Use netsh mbn to query and configure mobile broadband settings and parameters.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 
manager: 
ms.author: 
author: apdutta
ms.date: 02/20/2020
---

# Netsh mbn commands


Use **netsh mbn** to query and configure mobile broadband settings and parameters.

> [!TIP]
> You can get help on the netsh mbn command by using 
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;netsh mbn /?

The available netsh mbn commands are:

- [add](#add)
- [connect](#connect)
- [delete](#delete)
- [disconnect](#disconnect)
- [diagnose](#diagnose)
- [dump](#dump)
- [help](#help)
- [set](#set)
- [show](#show)

## add

Adds a configuration entry to a table.

The available netsh mbn add commands are:

- [dmprofile](#dmprofile)
- [profile](#profile)

### dmprofile

Adds a DM Config profile in the Profile Data Store.

**Syntax**

```powershell
add dmprofile [interface=]<string> [name=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **name**      | Name of the profile XML file. It is the name of the XML file containing the profile data.     | Required |


**Example**

```powershell
add dmprofile interface="Cellular" name="Profile1.xml"
```


### profile

Adds a network profile in the Profile Data Store.

**Syntax**

```powershell
add profile [interface=]<string> [name=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **name**      | Name of the profile XML file. It is the name of the XML file containing the profile data.     | Required |


**Example**

```powershell
add profile interface="Cellular" name="Profile1.xml"
```


## connect

Connects to a Mobile Broadband network.

**Syntax**

```powershell
connect [interface=]<string> [connmode=]tmp|name [name=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **connmode**  | Specifies how connection parameters are being provided. The connection can be requested using a profile XML, or using profile name for the profile XML that has been previously stored in Mobile Broadband Profile Data Store using "netsh mbn add profile" command. In former case, the parameter connmode shall hold "tmp" as value. Whereas, it shall be "name" in the latter case                                       | Required |
| **name**      | Name of the profile XML file. It is the name of the XML file containing the profile data.     | Required |


**Examples**

```powershell
connect interface="Cellular" connmode=tmp name=d:\profile.xml
connect interface="Cellular" connmode=name name=MyProfileName
```


## delete

Deletes a configuration entry from a table.

The available netsh mbn delete commands are:

- [dmprofile](#dmprofile)
- [profile](#profile)

### dmprofile

Deletes a DM Config profile from the Profile Data Store.

**Syntax**

```powershell
delete dmprofile [interface=]<string> [name=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **name**      | Name of the profile XML file. It is the name of the XML file containing the profile data.     | Required |

**Example**

```powershell
delete dmprofile interface="Cellular" name="myProfileName"
```

### profile

Deletes a network profile from the Profile Data Store.

**Syntax**

```powershell
delete profile [interface=]<string> [name=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **name**      | Name of the profile XML file. It is the name of the XML file containing the profile data.     | Required |


**Example**

```powershell
delete profile interface="Cellular" name="myProfileName"
```

## diagnose

Runs diagnostics for basic cellular problems.

**Syntax**

```powershell
diagnose [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
diagnose interface="Cellular"
```


## disconnect

Disconnects from a Mobile Broadband network.

**Syntax**

```powershell
disconnect [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
disconnect interface="Cellular"
```


## dump

Displays a configuration script. 

Creates a script that contains the current configuration.  If saved to a file, this script can be used to restore altered configuration settings.

**Syntax**

```powershell
dump
```

## help

Displays a list of commands.

**Syntax**

```powershell
help
```

## set

Sets configuration information.

The available netsh mbn set commands are:

- [acstate](#acstate)
- [dataenablement](#dataenablement)
- [dataroamcontrol](#dataroamcontrol)
- [enterpriseapnparams](#enterpriseapnparams)
- [highestconncategory](#highestconncategory)
- [powerstate](#powerstate)
- [profileparameter](#profileparameter)
- [slotmapping](#slotmapping)
- [tracing](#tracing)

### acstate

Sets the Mobile Broadband data auto connect state for the given interface.

**Syntax**

```powershell
set acstate [interface=]<string> [state=]autooff|autoon|manualoff|manualon
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **name**      | The auto connect state to be set. One of the following values:<br>autooff: Auto connect token off.<br>autoon: Auto connect token on.<br>manualoff: Manual connect token off.<br>manualon: Manual connect token on. | Required |


**Example**

```powershell
set acstate interface="Cellular" state=autoon
```


### dataenablement

Turns the Mobile Broadband data on or off for the given profile set and interface.

**Syntax**

```powershell
set dataenablement [interface=]<string> [profileset=]internet|mms|all [mode=]yes|no
```

**Parameters**

|                |                                                                                               |          |
|----------------|-----------------------------------------------------------------------------------------------|----------|
| **interface**  | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **profileset** | Name of the profile set.                                                                      | Required |
| **mode**       | One of the following values:<br>yes: Enables the target profile set.<br>no: Disables the target profile set.| Required |


**Example**

```powershell
set dataenablement interface="Cellular" profileset=mms mode=yes
```


### dataroamcontrol

Sets the Mobile Broadband data roam control state for the given profile set and interface.

**Syntax**

```powershell
set dataroamcontrol [interface=]<string> [profileset=]internet|mms|all [state=]none|partner|all
```

**Parameters**

|                |                                                                                               |          |
|----------------|-----------------------------------------------------------------------------------------------|----------|
| **interface**  | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **profileset** | Name of the profile set.                                                                      | Required |
| **mode**       | One of the following values:<br>none: Home carrier only.<br>partner: Home and partner carriers only.<br>all: Home, partner and roaming carriers.| Required |


**Example**

```powershell
set dataroamcontrol interface="Cellular" profileset=mms mode=partner
```


### enterpriseapnparams

Sets the Mobile Broadband data enterpriseAPN parameters for the given interface.

**Syntax**

```powershell
set enterpriseapnparams [interface=]<string> [allowusercontrol=]yes|no|nc [allowuserview=]yes|no|nc [profileaction=]add|delete|modify|nc
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **allowusercontrol** | One of the following values:<br>yes: allow end user control enterpriseAPN.<br>no: disallow end user control enterpriseAPN.<br>nc: no change. | Required |
| **allowuserview** |One of the following values:<br>yes: allow end user view enterpriseAPN.<br>no: disallow end user view enterpriseAPN.<br>nc: no change. | Required |
| **profileaction** | One of the following values:<br>add: an enterpriseAPN profile is just added.<br>delete: an enterpriseAPN profile is just deleted.<br>modify: an enterpriseAPN profile is just modified.<br>nc: no change. | Required |


**Example**

```powershell
set enterpriseapnparams interface="Cellular" profileset=mms mode=yes
```


### highestconncategory

Sets the Mobile Broadband data highest connnection category for the given interface.

**Syntax**

```powershell
set highestconncategory [interface=]<string> [highestcc=]admim|user|operator|device
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **highestcc** | One of the following values:<br>admin: admin provisioned profiles.<br>user: user proviioned profiles.<br>operator: operator proviioned profiles.<br>device: device proviioned profiles. | Required |


**Example**

```powershell
set highestconncategory interface="Cellular" highestcc=operator
```


### powerstate

Turns the Mobile Broadband radio on or off for the given interface.

**Syntax**

```powershell
set powerstate [interface=]<string> [state=]on|off
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **state**      | One of the following values:<br>on: power on radio transceiver.<br>off:  power off the radio transceiver. | Required |


**Example**

```powershell
set powerstate interface="Cellular" state=on
```


### profileparameter

Set parameters in a Mobile Broadband Network Profile.

**Syntax**

```powershell
set profileparameter [name=]<string> [[interface=]<string>] [[cost]=default|unrestricted|fixed|variable]
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **name**      | Name of the profile to be  modified. If the interface is specified then only the profile on that interface is modified. | Required |
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Optional |
| **cost**      | Cost associated with the profile.                                                             | Optional |


**Remarks**

At least one parameter between the interface name and the cost must be specified.


**Example**

```powershell
set profileparameter name="profile 1" cost=default
```


### slotmapping

Sets the Mobile Broadband modem slot mapping for the given interface.

**Syntax**

```powershell
set slotmapping [interface=]<string> [slotindex=]<integer>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **slotindex** | Slot index to be set.                                                                         | Required |


**Example**

```powershell
set slotmapping interface="Cellular" slotindex=1
```


### tracing

Enable or disable tracing.

**Syntax**

```powershell
set tracing [mode=]yes|no
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **mode**      | One of the following values:<br>yes: Enables tracing for Mobile Broadband.<br>no: Disables tracing for Mobile Broadband.     | Required |


**Example**

```powershell
set tracing mode=yes
```

## show

Displays mobile broadband network information.

The available netsh mbn set commands are:

- [acstate](#acstate)
- [capability](#capability)
- [connection](#connection)
- [dataenablement](#dataenablement)
- [dataroamcontrol](#dataroamcontrol)
- [dmprofiles](#dmprofiles)
- [enterpriseapnparams](#enterpriseapnparams)
- [highestconncategory](#highestconncategory)
- [homeprovider](#homeprovider)
- [interfaces](#interfaces)
- [netlteattachinfo](#netlteattachinfo)
- [pin](#pin)
- [pinlist](#pinlist)
- [preferredproviders](#preferredproviders)
- [profiles](#profiles)
- [profilestate](#profilestate)
- [provisionedcontexts](#provisionedcontexts)
- [purpose](#purpose)
- [radio](#radio)
- [readyinfo](#readyinfo)
- [signal](#signal)
- [slotmapping](#slotmapping)
- [slotstatus](#slotstatus)
- [smsconfig](#smsconfig)
- [tracing](#tracing)
- [visibleproviders](#visibleproviders)

### acstate  

Shows the Mobile Broadband data auto connect state for the given interface.

**Syntax**

```powershell
show acstate [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show acstate interface="Cellular"
```


### capability

Shows the interface capability information for the given interface.

**Syntax**

```powershell
show capability [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show capability interface="Cellular"
```


### connection

Shows the current connection information for the given interface.

**Syntax**

```powershell
show connection [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show connection interface="Cellular"
```


### dataenablement

Shows the Mobile Broadband data enablement state for the given interface.

**Syntax**

```powershell
show dataenablement [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show dataenablement interface="Cellular"
```


### dataroamcontrol

Shows the Mobile Broadband data roam control state for the given interface.

**Syntax**

```powershell
show dataroamcontrol [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show dataroamcontrol interface="Cellular"
```


### dmprofiles

Shows a list of DM Config profiles configured on the system.

**Syntax**

```powershell
show dmprofiles [[name=]<string>] [[interface=]<string>]
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **name**      | Name of the profile to display.                                                               | Optional |
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Optional |

**Remarks**
    
Shows the profile data or lists the profiles on the system.

If profile name is given then the content of the profile will be displayed. Otherwise profiles will be listed for the interface.

If interface name is given, only the specified profile on the given interface will be listed. Otherwise, first matched profile will be displayed.

**Example**

```powershell
show dmprofiles name="profile 1" interface="Cellular"
show dmprofiles name="profile 2"
show dmprofiles
```


### enterpriseapnparams

Shows the Mobile Broadband data enterpriseAPN parameters for the given interface.

**Syntax**

```powershell
show enterpriseapnparams [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show enterpriseapnparams interface="Cellular"
```


### highestconncategory

Shows the Mobile Broadband data highest connnection category for the given interface.

**Syntax**

```powershell
show highestconncategory [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show highestconncategory interface="Cellular"
```


### homeprovider

Shows the home provider information for the given interface.

**Syntax**

```powershell
show homeprovider [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show homeprovider interface="Cellular"
```


### interfaces

Shows a list of Mobile Broadband interfaces on the system. There are no parameters for this command.

**Syntax**

```powershell
show interfaces
```


### netlteattachinfo

Shows the Mobile Broadband network LTE attach information for the given interface.

**Syntax**

```powershell
show netlteattachinfo [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show netlteattachinfo interface="Cellular"
```

### pin      

Shows the pin information for the given interface.

**Syntax**

```powershell
show pin [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show pin interface="Cellular"
```


### pinlist  

Shows the pin list information for the given interface.

**Syntax**

```powershell
show pinlist [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show pinlist interface="Cellular"
```


### preferredproviders

Shows the preferred providers list for the given interface.

**Syntax**

```powershell
show preferredproviders [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show preferredproviders interface="Cellular"
```


### profiles 

Shows a list of profiles configured on the system.

**Syntax**

```powershell
show profiles [[name=]<string>] [[interface=]<string>] [[purpose=]<string>]
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **name**      | Name of the profile to display.                                                               | Optional |
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Optional |
| **purpose**   | Purpose | Optional |

**Remarks**

If profile name is given then the content of the profile will be displayed. Otherwise profiles will be listed for the interface.

If interface name is given, only the specified profile on the given interface will be listed. Otherwise, first matched profile will be displayed.

If the purpose is provided, only profiles with the matching purpose GUID will be displayed.  Otherwise, profiles will not be filtered by purpose.  The string can either be a GUID with curly brackets or one of the following strings: internet, supl, mms, ims, or allhost.
	
**Example**

```powershell
show profiles interface="Cellular" purpose="{00000000-0000-0000-0000-000000000000}"
show profiles name="profile 1" interface="Cellular"
show profiles name="profile 2"
show profiles
```

### profilestate

Shows the state of a Mobile Broadband profile for the given interface.

**Syntax**

```powershell
show profilestate [interface=]<string> [name=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |
| **name**      | Name of the profile. It is the name of the profile that has the state to be shown.            | Required |

**Example**

```powershell
show profilestate interface="Cellular" name="myProfileName"
```

### provisionedcontexts

Shows the provisioned contexts information for the given interface.

**Syntax**

```powershell
show provisionedcontexts [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show provisionedcontexts interface="Cellular"
```


### purpose  

Shows the purpose group GUIDs that can be used to filter profiles on the device. There are no parameters for this command.

**Syntax**

```powershell
show purpose
```


### radio    

Shows the radio state information for the given interface.

**Syntax**

```powershell
show radio [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show radio interface="Cellular"
```


### readyinfo

Shows the ready information for the given interface.

**Syntax**

```powershell
show readyinfo [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show readyinfo interface="Cellular"
```


### signal   

Shows the signal information for the given interface.

**Syntax**

```powershell
show signal [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show signal interface="Cellular"
```


### slotmapping

Shows the Mobile Broadband modem slot mapping for the given interface.

**Syntax**

```powershell
show slotmapping [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show slotmapping interface="Cellular"
```


### slotstatus

Shows the Mobile Broadband modem slot status for the given interface.

**Syntax**

```powershell
show slotstatus [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show slotstatus interface="Cellular"
```


### smsconfig

Shows the SMS configuration information for the given interface.

**Syntax**

```powershell
show smsconfig [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show smsconfig interface="Cellular"
```


### tracing  

Shows whether Mobile Broadband tracing is enabled or disabled.

**Syntax**

```powershell
show tracing 
```


### visibleproviders

Shows the visible providers list for the given interface.

**Syntax**

```powershell
show visibleproviders [interface=]<string>
```

**Parameters**

|               |                                                                                               |          |
|---------------|-----------------------------------------------------------------------------------------------|----------|
| **interface** | Interface name. It is one of the interface names shown by "netsh mbn show interfaces" command. | Required |


**Example**

```powershell
show visibleproviders interface="Cellular"
```

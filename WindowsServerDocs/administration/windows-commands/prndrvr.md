---
title: prndrvr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82b09e3e-bd38-4df1-9953-b0e9ee2565a3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# prndrvr

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Use the **prndrvr** command to add, delete, and list printer drivers.

## Syntax
```
cscript prndrvr {-a | -d | -l | -x | -?} [-m <model>] [-v {0|1|2|3}] 
[-e <environment>] [-s <ServerName>] [-u <UserName>] [-w <Password>] 
[-h <path>] [-i <inf file>]
```

## Parameters

|Parameter|Description|
|-------|--------|
|-a|Installs a driver.|
|-d|deletes a driver.|
|-l|lists all printer drivers installed on the server specified by the **-s** parameter. If you do not specify a server, Windows lists the printer drivers installed on the local computer.|
|-x|deletes all printer drivers and additional printer drivers not in use by a logical printer on the server specified by the **-s** parameter. If you do not specify a server to remove from the list, Windows deletes all unused printer drivers on the local computer.|
|-m \<DrivermodelName\>|Specifies (by name) the driver you want to install. Drivers are often named for the model of printer they support. See the printer documentation for more information.|
|-v {0 &#124; 1 &#124; 2 &#124; 3}|Specifies the version of the driver you want to install. See the description of the **-e**parameter for information on which versions are available for which environment. If you do not specify a version, the version of the driver appropriate for the version of Windows running on the computer where you are installing the driver is installed.<br /><br />-   version **0** supports Windows 95, Windows 98, and Windows Millennium edition.<br />-   version **1** supports Windows NT 3.51.<br />-   version **2** supports Windows NT 4.0.<br />-   version **3** supports Windows Vista, Windows XP, Windows 2000, and the Windows Server 2003 operating systems. Note that this is the only printer driver version that Windows Vista supports.|
|-e \<Environment>|Specifies the environment for the driver you want to install. If you do not specify an environment, the environment of the computer where you are installing the driver is used. The supported environment parameters are:<br /><br />-   **"Windows NT x86"**<br />-   **"Windows x64"**<br />-   **"Windows IA64"**|
|-s \<ServerName>|Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.|
|-u \<UserName> -w \<Password>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work.|
|-h \<path>|Specifies the path to the driver file. If you do not specify a path, the path to the location where Windows was installed is used.|
|-i \<Filename.inf>|Specifies the complete path and file name for the driver you want to install. If you do not specify a file name, the script uses one of the inbox printer .inf files in the inf subdirectory of the Windows directory.<br /><br />if the driver path is not specified, the script searches for driver files in the driver.cab file.|
|/?|Displays help at the command prompt.|

## Remarks
- The **prndrvr** command is a Visual Basic script located in the %WINdir%\System32\printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the prndrvr file, or change directories to the appropriate folder.

  For example:
  ```
  cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prndrvr
  ```
- If the information that you supply contains spaces, use quotation marks around the text (for example, `"computer Name"`).
- The -x option deletes all additional printer drivers (drivers installed for use on clients running alternate versions of Windows), even if the primary driver is in use. If the fax component is installed, this option also deletes fax drivers. The primary fax driver is deleted if it is not in use (that is, if there is no queue using it). If the primary fax driver is deleted, the only way to re-enable fax is to reinstall the fax component.
- Used without parameters, **prndrvr** displays command-line help for the **prndrvr** command.

## <a name="BKMK_examples"></a>Examples

To list all drivers on the \\\printServer1 server, type:
```
cscript Prndrvr -l -s
```

To add a version 3 Windows x64 printer driver for the "Laser printer model 1" model of printer using the C:\temp\Laserprinter1.inf driver information file for a driver stored in the C:\temp folder type:
```
cscript Prndrvr -a -m "Laser printer model 1" -v 3 -e "Windows x64" -i c:\temp\Laserprinter1.inf -h c:\temp
```

To delete a version 3 Windows NT x86 printer driver for "Laser printer model 1", type:
```
cscript Prndrvr -a -m "Laser printer model 1" -v 3 -e "Windows NT x86" 
```

#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[print Command Reference](print-command-reference.md)

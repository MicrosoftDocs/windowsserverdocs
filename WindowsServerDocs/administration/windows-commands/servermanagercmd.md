---
title: servermanagercmd
description: Reference article for the servermanagercmd command, which installs and removes roles, role services, and features.
ms.topic: reference
ms.assetid: 507c4b87-8e13-4872-8b34-0c7508eecbc1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# servermanagercmd

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Installs and removes roles, role services, and features. Also displays the list of all roles, role services, and features available, and shows which are installed on this computer.

> [!IMPORTANT]
> This command, servermanagercmd, has been deprecated and it's not guaranteed to be supported in future releases of Windows. We recommend instead that you use the Windows PowerShell cmdlets that are available for Server Manager. For more information, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

## Syntax

```
servermanagercmd -query [[[<drive>:]<path>]<query.xml>] [-logpath [[<drive>:]<path>]<log.txt>]
servermanagercmd -inputpath  [[[<drive>:]<path>]<answer.xml>] [-resultpath <result.xml> [-restart] | -whatif] [-logpath [[<drive>:]<path>]<log.txt>]
servermanagercmd -install <id> [-allSubFeatures] [-resultpath [[<drive>:]<path>]<result.xml> [-restart] | -whatif] [-logpath [[<Drive>:]<path>]<log.txt>]
servermanagercmd -remove <id> [-resultpath <result.xml> [-restart] | -whatif] [-logpath  [[<drive>:]<path>]<log.txt>]
servermanagercmd [-help | -?]
servermanagercmd -version
```

### Parameters

| Parameter | Description |
|--|--|
| -query `[[[<drive>:]<path>]<query.xml>]` | Displays a list of all roles, role services, and features installed and available for installation on the server. You can also use the short form of this parameter, **-q**. If you want the query results saved to an XML file, specify an XML file to replace `<query.xml>`. |
| -inputpath  `[[[<drive>:]<path>]<answer.xml>]` | Installs or removes the roles, role services, and features specified in an XML answer file represented by `<answer.xml>`. You can also use the short form of this parameter, **-p.** |
| -install `<id>` | Installs the role, role service, or feature specified by `<id>`. The identifiers are case-insensitive. Multiple roles, role services, and features must be separated by spaces. The following optional parameters are used with the **-install** parameter:<ul><li>**-setting** `<SettingName>=<SettingValue>` - Specifies required settings for the installation.</li><li>**-allSubFeatures** - Specifies the installation of all subordinate services and features along with the parent role, role service, or feature named in the `<id>` value.<p>**NOTE**<br>Some role containers do not have a command line identifier to allow installation of all role services. This is the case when role services cannot be installed in the same instance of the Server Manager command. For example, the Federation Service role service of active directory Federation Services and the Federation Service Proxy role service cannot be installed by using the same Server Manager command instance.</li><li>**-resultpath** `<result.xml>` - Saves installation results to an XML file represented by `<result.xml>`. You can also use the short form of this parameter, **-r**.<p>**NOTE**<br>You can't run servermanagercmd with both the **-resultpath** parameter and the **-whatif** parameter specified.</li><li>**-restart** - Restarts the computer automatically when installation is complete (if restarting is required by the roles or features installed).</li><li>**-whatif** - Displays any operations specified for the **-install** parameter. You can also use the short form of the **-whatif** parameter, **-w**. You can't run **servermanagercmd** with both the **-resultpath** parameter and the **-whatif** parameter specified.</li><li>**-logpath** `<[[<drive>:]<path>]<log.txt>>` - Specifies a name and location for the log file, other than the default, `%windir%\temp\servermanager.log`.</li></ul> |
| -remove `<id>` | Removes the role, role service, or feature specified by `<id>`. The identifiers are case-insensitive. Multiple roles, role services, and features must be separated by spaces. The following optional parameters are used with the **-remove** parameter:<ul><li>**-resultpath** `<[[<drive>:]<path>]result.xml>` - Saves removal results to an XML file represented by `<result.xml>`. You can also use the short form of this parameter, **-r**.<p>**NOTE**<br>You can't run servermanagercmd with both the **-resultpath** and the **-whatif** parameters specified.</li><li>**-restart** - Restarts the computer automatically when removal is complete (if restarting is required by remaining roles or features).</li><li>**-whatif** - Displays any operations specified for the -remove parameter. You can also use the short form of the -whatif parameter, **-w**. You can't run servermanagercmd with both the **-resultpath** and the **-whatif** parameters specified.</li><li>**-logpath**`<[[<Drive>:]<path>]<log.txt>>` - Specifies a name and location for the log file, other than the default, `%windir%\temp\servermanager.log`.</li></ul> |
| -version | Displays the Server Manager version number. You can also use the short form, **-v**. |
| -help | Displays help in the Command prompt window. You can also use the short form, **-?**. |

## Examples

To display a list of all roles, role services, and features available, and which roles, role services, and features are installed on the computer, type:

```
servermanagercmd -query
```

To install the Web Server (IIS) role, and save the installation results to an XML file represented by *installResult.xml*, type:

```
servermanagercmd -install Web-Server -resultpath installResult.xml
```

To display detailed information about the roles, role services, and features that would be installed or removed, based upon instructions that are specified in an XML answer file represented by *install.xml*, type:

```
servermanagercmd -inputpath install.xml -whatif
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Server Manager overview](/windows-server/administration/server-manager/server-manager)

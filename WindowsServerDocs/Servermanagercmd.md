---
title: Servermanagercmd
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 507c4b87-8e13-4872-8b34-0c7508eecbc1
author: jpjofre
---
# Servermanagercmd
  
> [!IMPORTANT]  
> This command is available only on servers that are running [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)]. **Servermanagercmd.exe** has been deprecated, and is not available in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. For information about how to install or remove [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], see [Install or uninstall roles, role services, and features](http://go.microsoft.com/fwlink/?LinkID=239563) on Microsoft TechNet.  
  
Installs and removes [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)]. Also displays the list of all [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] available, and shows which are installed on this computer. For additional information about the [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] that you can specify by using this tool, see the [Server Manager Help](http://go.microsoft.com/fwlink/?LinkID=137387). \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=137387\).  
  
For examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
servermanagercmd -query [[[<Drive>:]<Path>]<query.xml>] [-logPath   [[<Drive>:]<Path>]<log.txt>]  
  
servermanagercmd -inputpath  [[<Drive>:]<Path>]<answer.xml> [-resultPath <result.xml> [-restart] | -whatIf] [-logPath [[<Drive>:]<Path>]<log.txt>]  
  
servermanagercmd -install <Id> [-allSubFeatures] [-resultPath   [[<Drive>:]<Path>]<result.xml> [-restart] | -whatIf] [-logPath   [[<Drive>:]<Path>]<log.txt>]  
  
servermanagercmd -remove <Id> [-resultPath    <result.xml> [-restart] | -whatIf] [-logPath  [[<Drive>:]<Path>]<log.txt>]  
  
servermanagercmd [-help | -?]  
  
servermanagercmd -version  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\-query \[\[\[<Drive>:\]<Path>\]<*query.xml*>\]|Displays a list of all [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] installed and available for installation on the server. You can also use the short form of this parameter, **\-q**. If you want the query results saved to an XML file, specify an XML file to replace *query.xml*.|  
|\-inputPath  <\[\[<Drive>:\]<Path>\]*answer.xml*>|Installs or removes the [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] specified in an XML answer file represented by *answer.xml*. You can also use the short form of this parameter, **\-p.**|  
|\-install <*Id*>|Installs the [!INCLUDE[rrsorf_sing](includes/rrsorf_sing_md.md)] specified by *Id*. The identifiers are case\-insensitive. Multiple [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] must be separated by spaces. The following optional parameters are used with the **\-install** parameter.<br /><br />-   **\-setting** <*SettingName*>\=<*SettingValue*>   Specifies required settings for the installation.<br />-   **\-allSubFeatures** Specifies the installation of all subordinate services and features along with the parent [!INCLUDE[rrsorf_sing](includes/rrsorf_sing_md.md)] named in the *Id* value. **Note:**     Some role containers do not have a command line identifier to allow installation of all role services. This is the case when role services cannot be installed in the same instance of the [!INCLUDE[rmt](includes/rmt_md.md)] command. For example, the Federation Service role service of Active Directory Federation Services and the Federation Service Proxy role service cannot be installed by using the same [!INCLUDE[rmt](includes/rmt_md.md)] command instance.<br />-   **\-resultPath** <*result.xml*>   Saves installation results to an XML file represented by *result.xml*. You can also use the short form of this parameter, **\-r**. **Note:**     You cannot run **servermanagercmd** with both the **\-resultPath** parameter and the **\-whatIf** parameter specified.<br />-   **\-restart** Restarts the computer automatically when installation is complete \(if restarting is required by the roles or features installed\).<br />-   **\-whatIf** Displays any operations specified for the **\-install** parameter. You can also use the short form of the **\-whatIf** parameter, **\-w**. You cannot run **servermanagercmd** with both the **\-resultPath** parameter and the **\-whatIf** parameter specified.<br />-   **\-logPath** <\[\[<Drive>:\]<Path>\]*log.txt*>   Specifies a name and location for the log file, other than the default, **%windir%\\temp\\servermanager.log**.|  
|\-remove <*Id*>|Removes the [!INCLUDE[rrsorf_sing](includes/rrsorf_sing_md.md)] specified by *Id*. The identifiers are case\-insensitive. Multiple [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] must be separated by spaces. The following optional parameters are used with the **\-remove** parameter.<br /><br />-   **\-resultPath** <\[\[<Drive>:\]<Path>\]*result.xml*>   Saves removal results to an XML file represented by *result.xml*. You can also use the short form of this parameter, **\-r**. **Note:**     You cannot run **servermanagercmd** with both the **\-resultPath** parameter and the **\-whatIf** parameter specified.<br />-   **\-restart** Restarts the computer automatically when removal is complete \(if restarting is required by remaining roles or features\).<br />-   **\-whatIf** Displays any operations specified for the **\-remove** parameter. You can also use the short form of the **\-whatIf** parameter, **\-w**. You cannot run **servermanagercmd** with both the **\-resultPath** parameter and the **\-whatIf** parameter specified.<br />-   **\-logPath** <\[\[<Drive>:\]<Path>\]*log.txt*>   Specifies a name and location for the log file, other than the default, **%windir%\\temp\\servermanager.log**.|  
|\-help|Displays Help in the Command Prompt window. You can also use the short form, **\-?**.|  
|\-version|Displays the [!INCLUDE[rmt](includes/rmt_md.md)] version number. You can also use the short form, **\-v**.|  
  
## Remarks  
**Servermanagercmd** is deprecated, and is not guaranteed to be supported in future releases of Windows. We recommend that if you are running [!INCLUDE[rmt](includes/rmt_md.md)] on computers that are running [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], you use the [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets that are available for [!INCLUDE[rmt](includes/rmt_md.md)]. For more information, see [Server Manager cmdlets](http://go.microsoft.com/fwlink/?LinkID=137653).  
  
Servermanagercmd can be run from any directory on the server's local drives. You must be a member of the Administrators group on the server on which you want to install or remove software.  
  
> [!IMPORTANT]  
> Because of security restrictions imposed by User Account Control in [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], you must run **Servermanagercmd** in a Command Prompt window opened with elevated permissions. To do this, right\-click the Command Prompt executable, or the **Command Prompt** object on the **Start** menu, and then click **Run as administrator**.  
  
## <a name="BKMK_examples"></a>Examples  
The following example shows how to use **servermanagercmd** to display a list of all [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] available, and which [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] are installed on the computer.  
  
```  
servermanagercmd -query  
  
```  
  
The following example shows how to use **servermanagercmd** to install the [!INCLUDE[webiis](includes/webiis_md.md)] role, and save the installation results to an XML file represented by *installResult.xml*.  
  
```  
servermanagercmd -install Web-Server -resultPath installResult.xml  
```  
  
The following example shows how to use the **–whatIf** parameter with **servermanagercmd** to display detailed information about the [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] that would be installed or removed, based upon instructions that are specified in an XML answer file represented by *install.xml*.  
  
```  
servermanagercmd -inputPath install.xml -whatIf  
```  
  
#### Additional references  
  
-   For a complete list of the [!INCLUDE[rrsorf_sing](includes/rrsorf_sing_md.md)] identifiers you can specify for the *Id* parameter, or more information about using an XML answer file with **Servermanagercmd**, see the [Server Manager Help](http://go.microsoft.com/fwlink/?LinkID=137387). \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=137387\).  
  
-   See [Server Manager cmdlets](http://go.microsoft.com/fwlink/?LinkID=137653) for a listing of [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets that are available for [!INCLUDE[rmt](includes/rmt_md.md)].  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  


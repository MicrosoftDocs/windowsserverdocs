---
title: mapadmin
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b17332c7-8622-4223-9c43-2fb9cf4d992d
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# mapadmin
You can use **Mapadmin** to manage User Name Mapping for Microsoft Services for Network File System.
## Syntax
```
mapadmin [<computer>] [-u <user> [-p <password>]]
mapadmin [<computer>] [-u <user> [-p <password>]] {start | stop}
mapadmin [<computer>] [-u <user> [-p <password>]] config <option[...]>
mapadmin [<computer>] [-u <user> [-p <password>]] add -wu <WindowsUser> -uu <UNIXUser> [-setprimary]
mapadmin [<computer>] [-u <user> [-p <password>]] add -wg <WindowsGroup> -ug <UNIXGroup> [-setprimary]
mapadmin [<computer>] [-u <user> [-p <password>]] setprimary -wu <WindowsUser> [-uu <UNIXUser>]
mapadmin [<computer>] [-u <user> [-p <password>]] setprimary -wg <WindowsGroup> [-ug <UNIXGroup>]
mapadmin [<computer>] [-u <user> [-p <password>]] delete <option[...]>
mapadmin [<computer>] [-u <user> [-p <password>]] list <option[...]>
mapadmin [<computer>] [-u <user> [-p <password>]] backup <filename> 
mapadmin [<computer>] [-u <user> [-p <password>]] restore <filename>
mapadmin [<computer>] [-u <user> [-p <password>]] adddomainmap -d <WindowsDomain> {-y <<NISdomain>> | -f <path>}
mapadmin [<computer>] [-u <user> [-p <password>]] removedomainmap -d <WindowsDomain> -y <<NISdomain>>
mapadmin [<computer>] [-u <user> [-p <password>]] removedomainmap -all
mapadmin [<computer>] [-u <user> [-p <password>]] listdomainmaps
```
## Description
The **mapadmin** command-line utility administers User Name Mapping on the local or  remote computer running Microsoft Services for Network File System. If you are logged on with an account that does not have administrative credentials, you can specify a user name and password of an account that does.
In addition to specific command arguments, **mapadmin** accepts the following arguments and options:
<computer>
Specifies the remote computer running the User Name Mapping service that you want to administer. You can specify the computer using a Windows Internet Name Service (WINS) name or a Domain Name System (DNS) name, or by Internet Protocol (IP) address.
-u <user>
Specifies the user name of the user whose credentials are to be used. It might be necessary to add the domain name to the user name in the form *domain***\\***user name*.
-p <password>
Specifies the password of the user. If you specify the **-u** option but omit the **-p** option, you are prompted for the user's password.
The specific action that **mapadmin** performs depends on the command argument you specify:
## Parameters
### start
Starts the User Name Mapping service.
### stop
Stops the User Name Mapping service.
### config
Specifies general settings for User Name Mapping. The following options are available with this command argument:
**-r <dddd>:<hh>:<mm>** - Specifies the refresh interval for updating from the Windows and NIS databases in days, hours, and minutes. The minimum interval is 5 minutes.
**-i {yes | no}** - Turns simple mapping on (**yes**) or off (**no**). By default, simple mapping is on.
**add** - Creates a new mapping for a user or group. The following options are available with this command argument:
|Option|Definition|
|----------|--------------|
|-wu <name>|Specifies the name of the Windows user for which a new mapping is being created.|
|-uu <name>|Specifies the name of the UNIX user for which a new mapping is being created.|
|-wg <group>|Specifies the name of the Windows group for which a new mapping is being created.|
|-ug <group>|Specifies the name of the UNIX group for which a new mapping is being created.|
|-setprimary|Specifies that the new mapping is the primary mapping.|
**setprimary** - Specifies which mapping is the primary mapping for a UNIX user or group with multiple mappings. The following options are available with this command argument:
|Option|Definition|
|----------|--------------|
|-wu <name>|Specifies the Windows user of the primary mapping. If more than one mapping for the user exists, use the **-uu** option to specify the primary mapping.|
|-uu <name>|Specifies the UNIX user of the primary mapping.|
|-wg <group>|Specifies the Windows group of the primary mapping. If more than one mapping for the group exists, use the **-ug** option to specify the primary mapping.|
|-ug <group>|Specifies the UNIX group of the primary mapping.|
**delete** - Removes the mapping for a user or group. The following options are available for this command argument:
|Option|Definition|
|----------|--------------|
|-wu <user>|The Windows user for which the mapping will be deleted, specified as <*WindowsDomain>\\<User Name>*. You must specify either the **-wu** or the **-uu** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-wu** option, all mappings for the specified user will be deleted.|
|-wg <group>|The Windows group for which the mapping will be deleted, specified as <WindowsDomain>\\<groupname>. You must specify either the **-wg** or the **-ug** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-wg** option, all mappings for the specified group will be deleted.|
|-uu <user>|The UNIX user for whom the mapping will be deleted, specified as <User Name>. You must specify either the **-wu** or the **-uu** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-uu** option, all mappings for the specified user will be deleted.|
|-ug <group>|The UNIX group for which the mapping will be deleted, specified as <groupname>. You must specify either the **-wg** or the **-ug** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-ug** option, all mappings for the specified group will be deleted.|
**list** - Displays information about user and group mappings. The following options are available with this command argument:
|Option|Definition|
|----------|--------------|
|-all|Lists both simple and advanced mappings for users and groups.|
|-simple|Lists all simple mapped users and groups.|
|-advanced|Lists all advanced mapped users and groups. Maps are listed in the order in which they are evaluated. Primary maps, marked with an asterisk (*), are listed first, followed by secondary maps, which are marked with a carat (^).|
|-wu <name>|Lists the mapping for a specified Windows user.|
|-wg <group>|Lists the mapping for a Windows group.|
|-uu <name>|Lists the mapping for a UNIX user.|
|-ug <group>|Lists the mapping for a UNIX group.|
**backup** - Saves User Name Mapping configuration and mapping data to the file specified by <filename>.
**restore** - Replaces configuration and mapping data with data from the file (specified by <filename>) that was created using the **backup** command argument.
**adddomainmap** - Adds a simple map between a Windows domain and an NIS domain or password and group files. The following options are available for this command argument:
|Option|Definition|
|----------|--------------|
|-d <WindowsDomain>|Specifies the Windows domain to be mapped.|
|-y <NISdomain>|Specifies the NIS domain to be mapped.<br /><br />**-n** <nisServer> Specifies the NIS server for the NIS domain specified with the **-y** option.|
|-f <path>|Specifies the fully qualified path of directory containing the password and group files to be mapped. The files must be located on the computer being managed, and you cannot use **mapadmin** to manage a remote computer to set up maps based on password and group files.|
**removedomainmap** - Removes a simple map between a Windows domain and an NIS domain. The following options and argument are available for this command argument:
|Option|Definition|
|----------|--------------|
|-d <WindowsDomain>|Specifies the Windows domain of the map to be removed.|
|-y <NISdomain>|Specifies the NIS domain of the map to be removed.|
|-all|Specifies that all simple maps between Windows and NIS domains are to be removed. This will also remove any simple map between a Windows domain and password and group files.|
**listdomainmaps** - Lists the Windows domains that are mapped to NIS domains or password and group files.
## Notes
-   If you do not specify a command argument, **mapadmin** displays the current settings for User Name Mapping.
-   For all options that specify a user or group name, the following formats can be used:
-   For Windows users, use the form <domain>\\<user name>, \\\\<computer>\\<user name>, \\<computer>\\<user name>, or <computer>\\<user name>
-   For Windows groups, use the form <domain>\\<<groupname>>, \\\\<computer>\\<<groupname>>, \\<computer>\\<<groupname>>, or <computer>\\<<groupname>>
-   For UNIX users, use the form <NISdomain>\\<user name>, <user name>@<NISdomain>, user <name>@PCNFS, or PCNFS\\<user name>
-   For UNIX groups, use the form <NISdomain>\\<groupname>, <groupname>@<NISdomain>, <groupname>@PCNFS, or PCNFS\\<groupname>
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

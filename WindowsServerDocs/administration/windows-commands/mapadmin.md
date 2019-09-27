---
title: mapadmin
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b17332c7-8622-4223-9c43-2fb9cf4d992d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
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

&lt;computer&gt;
Specifies the remote computer running the User Name Mapping service that you want to administer. You can specify the computer using a Windows Internet Name Service (WINS) name or a Domain Name System (DNS) name, or by Internet Protocol (IP) address.

-u &lt;user&gt;
Specifies the user name of the user whose credentials are to be used. It might be necessary to add the domain name to the user name in the form <em>domain</em>**\\**<em>user name</em>.

-p &lt;password&gt;
Specifies the password of the user. If you specify the **-u** option but omit the **-p** option, you are prompted for the user's password.
The specific action that **mapadmin** performs depends on the command argument you specify:

## Parameters
### start
starts the User Name Mapping service.

### stop
Stops the User Name Mapping service.

### config
Specifies general settings for User Name Mapping. The following options are available with this command argument:
**-r &lt;dddd&gt;:&lt;hh&gt;:&lt;mm&gt;** - Specifies the refresh interval for updating from the Windows and NIS databases in days, hours, and minutes. The minimum interval is 5 minutes.
**-i {yes | no}** - Turns simple mapping on (**yes**) or off (**no**). By default, simple mapping is on.
**add** - creates a new mapping for a user or group. The following options are available with this command argument:

|Option|Definition|
|-----|-------|
|-wu &lt;name&gt;|Specifies the name of the Windows user for which a new mapping is being created.|
|-uu &lt;name&gt;|Specifies the name of the UNIX user for which a new mapping is being created.|
|-wg &lt;group&gt;|Specifies the name of the Windows group for which a new mapping is being created.|
|-ug &lt;group&gt;|Specifies the name of the UNIX group for which a new mapping is being created.|
|-setprimary|Specifies that the new mapping is the primary mapping.|

**setprimary** - Specifies which mapping is the primary mapping for a UNIX user or group with multiple mappings. The following options are available with this command argument:

|Option|Definition|
|-----|-------|
|-wu &lt;name&gt;|Specifies the Windows user of the primary mapping. If more than one mapping for the user exists, use the **-uu** option to specify the primary mapping.|
|-uu &lt;name&gt;|Specifies the UNIX user of the primary mapping.|
|-wg &lt;group&gt;|Specifies the Windows group of the primary mapping. If more than one mapping for the group exists, use the **-ug** option to specify the primary mapping.|
|-ug &lt;group&gt;|Specifies the UNIX group of the primary mapping.|

**delete** - removes the mapping for a user or group. The following options are available for this command argument:

|Option|Definition|
|-----|-------|
|-wu &lt;user&gt;|The Windows user for which the mapping will be deleted, specified as &lt;*WindowsDomain&gt;\\&lt;User Name&gt;*. You must specify either the **-wu** or the **-uu** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-wu** option, all mappings for the specified user will be deleted.|
|-wg &lt;group&gt;|The Windows group for which the mapping will be deleted, specified as &lt;WindowsDomain&gt;\\&lt;groupname&gt;. You must specify either the **-wg** or the **-ug** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-wg** option, all mappings for the specified group will be deleted.|
|-uu &lt;user&gt;|The UNIX user for whom the mapping will be deleted, specified as &lt;User Name&gt;. You must specify either the **-wu** or the **-uu** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-uu** option, all mappings for the specified user will be deleted.|
|-ug &lt;group&gt;|The UNIX group for which the mapping will be deleted, specified as &lt;groupname&gt;. You must specify either the **-wg** or the **-ug** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-ug** option, all mappings for the specified group will be deleted.|

**list** - Displays information about user and group mappings. The following options are available with this command argument:

|Option|Definition|
|-----|-------|
|-all|lists both simple and advanced mappings for users and groups.|
|-simple|lists all simple mapped users and groups.|
|-advanced|lists all advanced mapped users and groups. Maps are listed in the order in which they are evaluated. Primary maps, marked with an asterisk (*), are listed first, followed by secondary maps, which are marked with a carat (^).|
|-wu &lt;name&gt;|lists the mapping for a specified Windows user.|
|-wg &lt;group&gt;|lists the mapping for a Windows group.|
|-uu &lt;name&gt;|lists the mapping for a UNIX user.|
|-ug &lt;group&gt;|lists the mapping for a UNIX group.|

**backup** - Saves User Name Mapping configuration and mapping data to the file specified by &lt;filename&gt;.
**restore** - replaces configuration and mapping data with data from the file (specified by &lt;filename&gt;) that was created using the **backup** command argument.
**adddomainmap** - adds a simple map between a Windows domain and an NIS domain or password and group files. The following options are available for this command argument:

|Option|Definition|
|-----|-------|
|-d &lt;WindowsDomain&gt;|Specifies the Windows domain to be mapped.|
|-y &lt;NISdomain&gt;|Specifies the NIS domain to be mapped.&lt;br /&gt;&lt;br /&gt;**-n** &lt;nisServer&gt; Specifies the NIS server for the NIS domain specified with the **-y** option.|
|-f &lt;path&gt;|Specifies the fully qualified path of directory containing the password and group files to be mapped. The files must be located on the computer being managed, and you cannot use **mapadmin** to manage a remote computer to set up maps based on password and group files.|

**removedomainmap** - removes a simple map between a Windows domain and an NIS domain. The following options and argument are available for this command argument:

|Option|Definition|
|-----|-------|
|-d &lt;WindowsDomain&gt;|Specifies the Windows domain of the map to be removed.|
|-y &lt;NISdomain&gt;|Specifies the NIS domain of the map to be removed.|
|-all|Specifies that all simple maps between Windows and NIS domains are to be removed. This will also remove any simple map between a Windows domain and password and group files.|

**listdomainmaps** - lists the Windows domains that are mapped to NIS domains or password and group files.

## Notes
-   if you do not specify a command argument, **mapadmin** displays the current settings for User Name Mapping.
-   for all options that specify a user or group name, the following formats can be used:
-   for Windows users, use the form &lt;domain&gt;\\&lt;user name&gt;, \\\\&lt;computer&gt;\\&lt;user name&gt;, \\&lt;computer&gt;\\&lt;user name&gt;, or &lt;computer&gt;\\&lt;user name&gt;
-   for Windows groups, use the form &lt;domain&gt;\\&lt;&lt;groupname&gt;&gt;, \\\\&lt;computer&gt;\\&lt;&lt;groupname&gt;&gt;, \\&lt;computer&gt;\\&lt;&lt;groupname&gt;&gt;, or &lt;computer&gt;\\&lt;&lt;groupname&gt;&gt;
-   for UNIX users, use the form &lt;NISdomain&gt;\\&lt;user name&gt;, &lt;user name&gt;@&lt;NISdomain&gt;, user &lt;name&gt;@PCNFS, or PCNFS\\&lt;user name&gt;
-   for UNIX groups, use the form &lt;NISdomain&gt;\\&lt;groupname&gt;, &lt;groupname&gt;@&lt;NISdomain&gt;, &lt;groupname&gt;@PCNFS, or PCNFS\\&lt;groupname&gt;

## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)

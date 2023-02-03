---
title: mapadmin
description: Reference article for the mapadmin command, which manages User Name Mapping for Microsoft Services for Network File System.
ms.topic: reference
ms.assetid: b17332c7-8622-4223-9c43-2fb9cf4d992d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# mapadmin

The **mapadmin** command-line utility administers User Name Mapping on the local or remote computer running Microsoft Services for Network File System. If you are logged on with an account that does not have administrative credentials, you can specify a user name and password of an account that does.

## Syntax

```
mapadmin [<computer>] [-u <user> [-p <password>]]
mapadmin [<computer>] [-u <user> [-p <password>]] {start | stop}
mapadmin [<computer>] [-u <user> [-p <password>]] config <option[...]>
mapadmin [<computer>] [-u <user> [-p <password>]] add -wu <windowsuser> -uu <UNIXuser> [-setprimary]
mapadmin [<computer>] [-u <user> [-p <password>]] add -wg <windowsgroup> -ug <UNIXgroup> [-setprimary]
mapadmin [<computer>] [-u <user> [-p <password>]] setprimary -wu <Windowsuser> [-uu <UNIXuser>]
mapadmin [<computer>] [-u <user> [-p <password>]] setprimary -wg <Windowsgroup> [-ug <UNIXgroup>]
mapadmin [<computer>] [-u <user> [-p <password>]] delete <option[...]>
mapadmin [<computer>] [-u <user> [-p <password>]] list <option[...]>
mapadmin [<computer>] [-u <user> [-p <password>]] backup <filename>
mapadmin [<computer>] [-u <user> [-p <password>]] restore <filename>
mapadmin [<computer>] [-u <user> [-p <password>]] adddomainmap -d <Windowsdomain> {-y <<NISdomain>> | -f <path>}
mapadmin [<computer>] [-u <user> [-p <password>]] removedomainmap -d <Windowsdomain> -y <<NISdomain>>
mapadmin [<computer>] [-u <user> [-p <password>]] removedomainmap -all
mapadmin [<computer>] [-u <user> [-p <password>]] listdomainmaps
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<computer>` | Specifies the remote computer running the User Name Mapping service that you want to administer. You can specify the computer using a Windows Internet Name Service (WINS) name or a Domain Name System (DNS) name, or by Internet Protocol (IP) address. |
| -u `<user>` | Specifies the user name of the user whose credentials are to be used. It might be necessary to add the domain name to the user name in the form *domain\username*. |
| -p `<password>` | Specifies the password of the user. If you specify the **-u** option but omit the **-p** option, you are prompted for the user's password. |
| `start | stop` | Starts or stops the User Name Mapping service. |
| config | Specifies general settings for User Name Mapping. The following options are available with this parameter:<ul><li>**-r `<dddd>:<hh>:<mm>`:** Specifies the refresh interval for updating from the Windows and NIS databases in days, hours, and minutes. The minimum interval is 5 minutes.</li><li>**-i `{yes | no}`:** Turns simple mapping on (**yes**) or off (**no**). By default, mapping is turned on.</li></ul> |
| add | Creates a new mapping for a user or group. The following options are available with this parameter:<ul><li>**-wu `<name>`:** Specifies the name of the Windows user for which a new mapping is being created.</li><li>**-uu `<name>`:** Specifies the name of the UNIX user for which a new mapping is being created.</li><li>**-wg `<group>`:** Specifies the name of the Windows group for which a new mapping is being created.</li><li>**-ug `<group>`:** Specifies the name of the UNIX group for which a new mapping is being created.</li><li>**-setprimary:** Specifies that the new mapping is the primary mapping.</li></ul> |
| setprimary | Specifies which mapping is the primary mapping for a UNIX user or group with multiple mappings. The following options are available with this parameter:<ul><li>**-wu `<name>`:** Specifies the Windows user of the primary mapping. If more than one mapping for the user exists, use the **-uu** option to specify the primary mapping.</li><li>**-uu `<name>`:** Specifies the UNIX user of the primary mapping.</li><li>**-wg `<group>`:** Specifies the Windows group of the primary mapping. If more than one mapping for the group exists, use the **-ug** option to specify the primary mapping.</li><li>**-ug `<group>`:** Specifies the UNIX group of the primary mapping.</li></ul> |
| delete | Removes the mapping for a user or group. The following options are available for this parameter:<ul><li>**-wu `<user>`:** Specifies the Windows user for which the mapping will be deleted, specified as `<windowsdomain>\<username>`.<p>You must specify either the **-wu** or the **-uu** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-wu** option, all mappings for the specified user will be deleted.</li><li>**-uu `<user>`:** Specifies the UNIX user for whom the mapping will be deleted, specified as `<username>`.<p>You must specify either the **-wu** or the **-uu** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-uu** option, all mappings for the specified user will be deleted.</li><li>**-wg `<group>`:** Specifies the Windows group for which the mapping will be deleted, specified as `<windowsdomain>\<username>`.<p>You must specify either the **-wg** or the **-ug** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-wg** option, all mappings for the specified group will be deleted.</li><li>**-ug `<group>`:** Specifies the UNIX group for which the mapping will be deleted, specified as `<groupname>`.<p>You must specify either the **-wg** or the **-ug** option, or both. If you specify both options, the particular mapping identified by the two options will be deleted. If you specify only the **-ug** option, all mappings for the specified group will be deleted.</li></ul> |
| list | Displays information about user and group mappings. The following options are available with this parameter:<ul><li>**-all:** Lists both simple and advanced mappings for users and groups.</li><li>**-simple:** Lists all simple mapped users and groups.</li><li>**-advanced:** Lists all advanced mapped users and groups. Maps are listed in the order in which they are evaluated. Primary maps, marked with an asterisk (*), are listed first, followed by secondary maps, which are marked with a carat `(^)`.</li><li>**-wu `<name>`:** Lists the mapping for a specified Windows user.</li><li>**-wg `<group>`:** Lists the mapping for a Windows group.</li><li>**-uu `<name>`:** Lists the mapping for a UNIX user.</li><li>**-ug `<group>`:** Lists the mapping for a UNIX group.</li></ul> |
| backup | Saves User Name Mapping configuration and mapping data to the file specified by `<filename>`. |
| restore | Replaces configuration and mapping data with data from the file (specified by `<filename>`) that was created using the **backup** parameter. |
| adddomainmap | Adds a simple map between a Windows domain and an NIS domain or password and group files. The following options are available for this parameter:<ul><li>**-d `<windowsdomain>`:** Specifies the Windows domain to be mapped.</li><li>**-y `<NISdomain>`:** Specifies the NIS domain to be mapped. You must use the **-n `<NISserver>`** parameter to specify the NIS server for the NIS domain specified by the **-y** option.</li><li>**-f `<path>`:** Specifies the fully-qualified path of directory containing the password and group files to be mapped. The files must be located on the computer being managed, and you can't use **mapadmin** to manage a remote computer to set up maps based on password and group files.</li></ul> |
| removedomainmap | Removes a simple map between a Windows domain and an NIS domain. The following options and argument are available for this parameter:<ul><li>**-d `<windowsdomain>`:** Specifies the Windows domain of the map to be removed.</li><li>**-y `<NISdomain>`:** Specifies the NIS domain of the map to be removed.</li><li>**-all:** Specifies that all simple maps between Windows and NIS domains are to be removed. This will also remove any simple map between a Windows domain and password and group files.</li></ul> |
| listdomainmaps | Lists the Windows domains that are mapped to NIS domains or password and group files. |

#### Remarks

- If you don't specify any paramters, the **mapadmin** command displays the current settings for User Name Mapping.

- For all options that specify a user or group name, the following formats can be used:

    - For Windows users, use the formats: `<domain>\<username>`, `\\<computer>\<username>`, `\<computer>\<username>`, or `<computer>\<username>`

    - For Windows groups, use the formats: `<domain>\<groupname>`, `\\<computer>\<groupname>`, `\<computer>\<groupname>`, or `<computer>\<groupname>`

    - For UNIX users, use the formats: `<NISdomain>\<username>`, `<username>@<NISdomain>`, `<username>@PCNFS`, or `PCNFS\<username>`

    - For UNIX groups, use the formats: `<NISdomain>\<groupname>`, `<groupname>@<NISdomain>`, `<groupname>@PCNFS`, or `PCNFS\<groupname>`

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

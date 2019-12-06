---
title: macfile
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e2ce586c-b316-41d3-90f8-4be0d074cc0e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# macfile

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Manages File Server for Macintosh servers, volumes, directories, and files. You can automate administrative tasks by including a series of commands in batch files and starting them manually or at predetermined times. 
-   [To modify directories in Macintosh-accessible volumes](#BKMK_Moddirs)
-   [To join a Macintosh file's data and resource forks](#BKMK_Joinforks)
-   [To change the logon message and limit sessions](#BKMK_LogonLimit)
-   [To add, change, or remove Macintosh-accessible volumes](#BKMK_addvol)

## <a name="BKMK_Moddirs"></a>To modify directories in Macintosh-accessible volumes

### Syntax
```
macfile directory[/server:\\<computerName>] /path:<directory> [/owner:<OwnerName>] [/group:<GroupName>] [/permissions:<Permissions>]
```

### Parameters
-   /server:\\\\<computerName>
    Specifies the server on which to change a directory. If omitted, the operation is performed on the local computer.
-   /path:<directory>
    Required. Specifies the path to the directory that you want to change. The directory must exist. **macfile directory** does not create directories.
-   /owner:<OwnerName>
    changes the owner of the directory. If omitted, the owner remains unchanged.
-   /group:<GroupName>
    Specifies or changes the Macintosh primary group that is associated with the directory. If omitted, the primary group remains unchanged.
-   /permissions:<Permissions>
    Sets permissions on the directory for the owner, primary group, and world (everyone). An 11-digit number is used to set permissions. The number 1 grants permission and 0 revokes permission (for example, 11111011000). If omitted, permissions remain unchanged.
    The position of the digit determines which permission is set, as described in the following table.

    |Position|Sets Permission for|
    |------|------------|
    |First|OwnerSeeFiles|
    |Second|OwnerSeeFolders|
    |Third|OwnerMakechanges|
    |Fourth|GroupSeeFiles|
    |Fifth|GroupSeeFolders|
    |Sixth|GroupMakechanges|
    |Seventh|WorldSeeFiles|
    |Eighth|WorldSeeFolders|
    |Ninth|WorldMakechanges|
    |Tenth|The directory cannot be renamed, moved, or deleted.|
    |Eleventh|The changes apply to the current directory and all subdirectories.|

-   /?
    Displays help at the command prompt.

### Remarks
- if the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"**<em>computer Name</em>**"**).
- Use **macfiledirectory** to make an existing directory in a Macintosh-accessible volume available to Macintosh users. The **macfiledirectory** command does not create directories. Use File Manager, the command prompt, or the **macintosh new folder** command to create a directory in a Macintosh-accessible volume before you use the **macfile directory** command.
  ### <a name="BKMK_Examples"></a>Examples
  The following example changes the permissions of the subdirectory May sales, in the Macintosh-accessible volume Statistics, on the E drive of the local server. The example assigns See Files, See Folders, and Make changes permissions to the owner and See Files and See Folders permissions to all other users, while preventing the directory from being renamed, moved, or deleted.
  ```
  macfile directory /path:"e:\statistics\may sales" /permissions:11111011000
  ```

## <a name="BKMK_Joinforks"></a>To join a Macintosh file's data and resource forks

### Syntax
```
macfile forkize[/server:\\<computerName>] [/creator:<CreatorName>] [/type:<typeName>]  [/datafork:<Filepath>] [/resourcefork:<Filepath>] /targetfile:<Filepath>
```

### Parameters

|         Parameter          |                                                                                                           Description                                                                                                            |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /server:\\\\<computerName> |                                                            Specifies the server on which to join files. If omitted, the operation is performed on the local computer.                                                            |
|   /creator:<CreatorName>   |                                      Specifies the creator of the file. The Macintosh finder uses the **/creator** command-line option to determine the application that created the file.                                       |
|      /type:<typeName>      |                                 Specifies the type of file. The Macintosh finder uses the **/type** command-line option to determine the file type within the application that created the file.                                 |
|    /datafork:<Filepath>    |                                                                   Specifies the location of the data fork that is to be joined. You can specify a remote path.                                                                   |
|  /resourcefork:<Filepath>  |                                                                 Specifies the location of the resource fork that is to be joined. You can specify a remote path.                                                                 |
|   /targetfile:<Filepath>   | Required. Specifies the location of the file that is created by joining a data fork and a resource fork, or specifies the location of the file whose type or creator you are changing. The file must be on the specified server. |
|             /?             |                                                                                               Displays help at the command prompt.                                                                                               |

### Remarks
- if the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"**<em>computer Name</em>**"**).

### Examples
To create the file treeapp on the Macintosh-accessible volume D:\Release, using the resource fork C:\Cross\Mac\Appcode, and to make this new file appear to Macintosh clients as an application (Macintosh applications use the type APPL) with the creator (signature) set to MAGNOLIA, type:
```
macfile forkize /resourcefork:c:\cross\mac\appcode /type:APPL /creator:MAGNOLIA /targetfile:D:\Release\treeapp
```
To change the file creator to Microsoft Word 5.1, for the file WOrd.txt in the directory D:\Word documents\Group files, on the server \\\SERverA, type:
```
macfile forkize /server:\\servera /creator:MSWD /type:TEXT /targetfile:"d:\Word documents\Group files\Word.txt"
```

## <a name="BKMK_LogonLimit"></a>To change the logon message and limit sessions
### Syntax
```
macfile server [/server:\\<computerName>] [/maxsessions:{Number | unlimited}] [/loginmessage:<Message>]
```

### Parameters

|               Parameter                |                                                                                                                                                                           Description                                                                                                                                                                            |
|----------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|       /server:\\\\<computerName>       |                                                                                                                        Specifies the server on which to change parameters. If omitted, the operation is performed on the local computer.                                                                                                                         |
| /maxsessions:{Number &#124; unlimited} |                                                                                         Specifies the maximum number of users who can simultaneously use File and print Servers for Macintosh. If omitted, the **maxsessions** setting for the server remains unchanged.                                                                                         |
|        /loginmessage:<Message>         | changes the message Macintosh users see when logging on to the File Server for Macintosh server. The maximum number of characters for the logon message is 199. If omitted, the **loginmessage** message for the server remains unchanged. To remove an existing logon message, include the **/loginmessage** parameter, but leave the *Message* variable blank. |
|                   /?                   |                                                                                                                                                               Displays help at the command prompt.                                                                                                                                                               |

### Remarks
- if the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"**<em>computer Name</em>**"**).

### Examples
To change the number of File and print Server for Macintosh sessions that are permitted on the local server from the current setting to five sessions, and to add the logon message "Log off from Server for Macintosh when you are finished.", type:
```
macfile server /maxsessions:5 /loginmessage:"Log off from Server for Macintosh when you are finished."
```

## <a name="BKMK_addvol"></a>To add, change, or remove Macintosh-accessible volumes
### Syntax
```
macfile volume {/add|/set} [/server:\\<computerName>] /name:<volumeName>/path:<directory>[/readonly:{true | false}] [/guestsallowed:{true | false}] [/password:<Password>] [/maxusers:{<Number>>|unlimited}]
macfile volume /remove[/server:\\<computerName>] /name:<volumeName>
```

### Parameters

|              Parameter               |                                                                                                                                                                       Description                                                                                                                                                                        |
|--------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|          {/add &#124; /set}          |                                                                                                                      Required when you are adding or changing a Macintosh-accessible volume. adds or changes the specified volume.                                                                                                                       |
|      /server:\\\\<computerName>      |                                                                                                             Specifies the server on which to add, change, or remove a volume. If omitted, the operation is performed on the local computer.                                                                                                              |
|          /name:<volumeName>          |                                                                                                                                          Required. Specifies the volume name to be added, changed, or removed.                                                                                                                                           |
|          /path:<directory>           |                                                                                                                Required and valid only when you are adding a volume. Specifies the path to the root directory of the volume to be added.                                                                                                                 |
|    /readonly:{true &#124; false}     | Specifies whether users can change files in the volume. type true to specify that users cannot change files in the volume. type false to specify that users can change files in the volume. If omitted when adding a volume, changes to files are allowed. If omitted when changing a volume, the **readonly** setting for the volume remains unchanged. |
|  /guestsallowed:{true &#124; false}  |      Specifies whether users who log on as guests can use the volume. type true to specify that guests can use the volume. type false to specify that guests cannot use the volume. If omitted when adding a volume, guests can use the volume. If omitted when changing a volume, the **guestsallowed** setting for the volume remains unchanged.       |
|         /password:<Password>         |                                                                               Specifies a password that will be required to access the volume. If omitted when adding a volume, no password is created. If omitted when changing a volume, the password remains unchanged.                                                                               |
| /maxusers:{<Number>>&#124;unlimited} |                                                 Specifies the maximum number of users who can simultaneously use the files on the volume. If omitted when adding a volume, an unlimited number of users can use the volume. If omitted when changing a volume, the **maxusers** value remains unchanged.                                                 |
|               /remove                |                                                                                                                                Required when you are removing a Macintosh-accesible volume. removes the specified volume.                                                                                                                                |
|                  /?                  |                                                                                                                                                           Displays help at the command prompt.                                                                                                                                                           |

### Remarks
- if the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"**<em>computer Name</em>**"**).

### Examples
To create a volume called US Marketing Statistics on the local server, using the Stats directory in the E drive, and to specify that the volume cannot be accessed by guests, type:
```
macfile volume /add /name:"US Marketing Statistics" /guestsallowed:false /path:e:\Stats
```
To change the volume created above to be read-only and to require a password, and to set the number of maximum users to five, type:
```
macfile volume /set /name:"US Marketing Statistics" /readonly:true /password:saturn /maxusers:5
```
To add a volume called Landscape Design, on the server \\\Magnolia, using the trees directory in the E drive, and to specify that the volume can be accessed by guests, type:
```
macfile volume /add /server:\\Magnolia /name:"Landscape Design" /path:e:\trees
```
To remove the volume called Sales Reports on the local server, type:
```
macfile volume /remove /name:"Sales Reports"
```

## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)

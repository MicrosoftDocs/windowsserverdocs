---
title: Macfile
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e2ce586c-b316-41d3-90f8-4be0d074cc0e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Macfile

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Manages File Server for Macintosh servers, volumes, directories, and files. You can automate administrative tasks by including a series of commands in batch files and starting them manually or at predetermined times. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).
-   [To modify directories in Macintosh-accessible volumes](#BKMK_ModDirs)
-   [To join a Macintosh file's data and resource forks](#BKMK_JoinForks)
-   [To change the logon message and limit sessions](#BKMK_LogonLimit)
-   [To add, change, or remove Macintosh-accessible volumes](#BKMK_AddVol)
## <a name="BKMK_ModDirs"></a>To modify directories in Macintosh-accessible volumes
### Syntax
```
macfile directory[/server:\\<ComputerName>] /path:<Directory> [/owner:<OwnerName>] [/group:<GroupName>] [/permissions:<Permissions>]
```
### Parameters
-   /server:\\\\<ComputerName>
    Specifies the server on which to change a directory. If omitted, the operation is performed on the local computer.
-   /path:<Directory>
    Required. Specifies the path to the directory that you want to change. The directory must exist. **Macfile directory** does not create directories.
-   /owner:<OwnerName>
    Changes the owner of the directory. If omitted, the owner remains unchanged.
-   /group:<GroupName>
    Specifies or changes the Macintosh primary group that is associated with the directory. If omitted, the primary group remains unchanged.
-   /permissions:<Permissions>
    Sets permissions on the directory for the owner, primary group, and world (everyone). An 11-digit number is used to set permissions. The number 1 grants permission and 0 revokes permission (for example, 11111011000). If omitted, permissions remain unchanged.
    The position of the digit determines which permission is set, as described in the following table.
    |Position|Sets Permission for|
    |------------|-----------------------|
    |First|OwnerSeeFiles|
    |Second|OwnerSeeFolders|
    |Third|OwnerMakeChanges|
    |Fourth|GroupSeeFiles|
    |Fifth|GroupSeeFolders|
    |Sixth|GroupMakeChanges|
    |Seventh|WorldSeeFiles|
    |Eighth|WorldSeeFolders|
    |Ninth|WorldMakeChanges|
    |Tenth|The directory cannot be renamed, moved, or deleted.|
    |Eleventh|The changes apply to the current directory and all subdirectories.|
-   /?
    Displays Help at the command prompt.
### Remarks
-   If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"***Computer Name***"**).
-   Use **macfiledirectory** to make an existing directory in a Macintosh-accessible volume available to Macintosh users. The **macfiledirectory** command does not create directories. Use File Manager, the command prompt, or the **macintosh new folder** command to create a directory in a Macintosh-accessible volume before you use the **macfile directory** command.
### <a name="BKMK_Examples"></a>Examples
The following example changes the permissions of the subdirectory May sales, in the Macintosh-accessible volume Statistics, on the E drive of the local server. The example assigns See Files, See Folders, and Make Changes permissions to the owner and See Files and See Folders permissions to all other users, while preventing the directory from being renamed, moved, or deleted.
```
macfile directory /path:"e:\statistics\may sales" /permissions:11111011000
```
## <a name="BKMK_JoinForks"></a>To join a Macintosh file's data and resource forks
### Syntax
```
macfile forkize[/server:\\<ComputerName>] [/creator:<CreatorName>] [/type:<TypeName>]  [/datafork:<FilePath>] [/resourcefork:<FilePath>] /targetfile:<FilePath>
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|/server:\\\\<ComputerName>|Specifies the server on which to join files. If omitted, the operation is performed on the local computer.|
|/creator:<CreatorName>|Specifies the creator of the file. The Macintosh Finder uses the **/creator** command-line option to determine the application that created the file.|
|/type:<TypeName>|Specifies the type of file. The Macintosh Finder uses the **/type** command-line option to determine the file type within the application that created the file.|
|/datafork:<FilePath>|Specifies the location of the data fork that is to be joined. You can specify a remote path.|
|/resourcefork:<FilePath>|Specifies the location of the resource fork that is to be joined. You can specify a remote path.|
|/targetfile:<FilePath>|Required. Specifies the location of the file that is created by joining a data fork and a resource fork, or specifies the location of the file whose type or creator you are changing. The file must be on the specified server.|
|/?|Displays Help at the command prompt.|
### Remarks
-   If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"***Computer Name***"**).
### Examples
To create the file Treeapp on the Macintosh-accessible volume D:\Release, using the resource fork C:\Cross\Mac\Appcode, and to make this new file appear to Macintosh clients as an application (Macintosh applications use the type APPL) with the creator (signature) set to MAGNOLIA, type:
```
macfile forkize /resourcefork:c:\cross\mac\appcode /type:APPL /creator:MAGNOLIA /targetfile:D:\Release\Treeapp
```
To change the file creator to Microsoft Word 5.1, for the file WORD.txt in the directory D:\Word documents\Group files, on the server \\\SERVERA, type:
```
macfile forkize /server:\\servera /creator:MSWD /type:TEXT /targetfile:"d:\Word documents\Group files\Word.txt"
```
## <a name="BKMK_LogonLimit"></a>To change the logon message and limit sessions
### Syntax
```
macfile server [/server:\\<ComputerName>] [/maxsessions:{Number | unlimited}] [/loginmessage:<Message>]
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|/server:\\\\<ComputerName>|Specifies the server on which to change parameters. If omitted, the operation is performed on the local computer.|
|/maxsessions:{Number &#124; unlimited}|Specifies the maximum number of users who can simultaneously use File and Print Servers for Macintosh. If omitted, the **maxsessions** setting for the server remains unchanged.|
|/loginmessage:<Message>|Changes the message Macintosh users see when logging on to the File Server for Macintosh server. The maximum number of characters for the logon message is 199. If omitted, the **loginmessage** message for the server remains unchanged. To remove an existing logon message, include the **/loginmessage** parameter, but leave the *Message* variable blank.|
|/?|Displays Help at the command prompt.|
### Remarks
-   If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"***Computer Name***"**).
### Examples
To change the number of File and Print Server for Macintosh sessions that are permitted on the local server from the current setting to five sessions, and to add the logon message "Log off from Server for Macintosh when you are finished.", type:
```
macfile server /maxsessions:5 /loginmessage:"Log off from Server for Macintosh when you are finished."
```
## <a name="BKMK_AddVol"></a>To add, change, or remove Macintosh-accessible volumes
### Syntax
```
macfile volume {/add|/set} [/server:\\<ComputerName>] /name:<VolumeName>/path:<Directory>[/readonly:{true | false}] [/guestsallowed:{true | false}] [/password:<Password>] [/maxusers:{<Number>>|unlimited}]
macfile volume /remove[/server:\\<ComputerName>] /name:<VolumeName>
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|{/add &#124; /set}|Required when you are adding or changing a Macintosh-accessible volume. Adds or changes the specified volume.|
|/server:\\\\<ComputerName>|Specifies the server on which to add, change, or remove a volume. If omitted, the operation is performed on the local computer.|
|/name:<VolumeName>|Required. Specifies the volume name to be added, changed, or removed.|
|/path:<Directory>|Required and valid only when you are adding a volume. Specifies the path to the root directory of the volume to be added.|
|/readonly:{true &#124; false}|Specifies whether users can change files in the volume. Type true to specify that users cannot change files in the volume. Type false to specify that users can change files in the volume. If omitted when adding a volume, changes to files are allowed. If omitted when changing a volume, the **readonly** setting for the volume remains unchanged.|
|/guestsallowed:{true &#124; false}|Specifies whether users who log on as guests can use the volume. Type true to specify that guests can use the volume. Type false to specify that guests cannot use the volume. If omitted when adding a volume, guests can use the volume. If omitted when changing a volume, the **guestsallowed** setting for the volume remains unchanged.|
|/password:<Password>|Specifies a password that will be required to access the volume. If omitted when adding a volume, no password is created. If omitted when changing a volume, the password remains unchanged.|
|/maxusers:{<Number>>&#124;unlimited}|Specifies the maximum number of users who can simultaneously use the files on the volume. If omitted when adding a volume, an unlimited number of users can use the volume. If omitted when changing a volume, the **maxusers** value remains unchanged.|
|/remove|Required when you are removing a Macintosh-accesible volume. Removes the specified volume.|
|/?|Displays Help at the command prompt.|
### Remarks
-   If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, **"***Computer Name***"**).
### Examples
To create a volume called US Marketing Statistics on the local server, using the Stats directory in the E drive, and to specify that the volume cannot be accessed by guests, type:
```
macfile volume /add /name:"US Marketing Statistics" /guestsallowed:false /path:e:\Stats
```
To change the volume created above to be read-only and to require a password, and to set the number of maximum users to five, type:
```
macfile volume /set /name:"US Marketing Statistics" /readonly:true /password:saturn /maxusers:5
```
To add a volume called Landscape Design, on the server \\\Magnolia, using the Trees directory in the E drive, and to specify that the volume can be accessed by guests, type:
```
macfile volume /add /server:\\Magnolia /name:"Landscape Design" /path:e:\Trees
```
To remove the volume called Sales Reports on the local server, type:
```
macfile volume /remove /name:"Sales Reports"
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

---
title: macfile
description: Reference article for the macfile command, which manages File Server for Macintosh servers, volumes, directories, and files.
ms.topic: reference
ms.assetid: e2ce586c-b316-41d3-90f8-4be0d074cc0e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# macfile

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Manages File Server for Macintosh servers, volumes, directories, and files. You can automate administrative tasks by including a series of commands in batch files and starting them manually or at predetermined times.

## Modify directories in Macintosh-accessible volumes

To change the directory name, location, owner, group, and permissions for Macintosh-accessible volumes.

### Syntax

```
macfile directory[/server:\\<computername>] /path:<directory> [/owner:<ownername>] [/group:<groupname>] [/permissions:<permissions>]
```

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| /server:`\\<computername>` | Specifies the server on which to change a directory. If omitted, the operation is performed on the local computer. |
| /path:`<directory>` | Specifies the path to the directory that you want to change. This parameter is required. **Note:** The directory must exist, using **macfile directory** won't create directories. |
| /owner:`<ownername>` | Changes the owner of the directory. If omitted, the owner name won't change. |
| /group:`<groupname>` | Specifies or changes the Macintosh primary group that is associated with the directory. If omitted, the primary group remains unchanged. |
| /permissions:`<permissions>` | Sets permissions on the directory for the owner, primary group, and world (everyone). This must be an 11-digit number, where the number 1 grants permission and 0 revokes permission (for example, 11111011000). If this parameter is omitted, permissions remain unchanged. |
| /? | Displays help at the command prompt. |

##### Position of permissions digit

The position of the permissions digit determines which permission is set, including:

| Position | Sets Permission |
| -------- | --------------- |
| First | OwnerSeeFiles |
| Second | OwnerSeeFolders |
| Third | OwnerMakechanges |
| Fourth | GroupSeeFiles |
| Fifth | GroupSeeFolders |
| Sixth | GroupMakechanges |
| Seventh | WorldSeeFiles |
| Eighth | WorldSeeFolders |
| Ninth | WorldMakechanges |
| Tenth | The directory can't be renamed, moved, or deleted. |
| Eleventh | The changes apply to the current directory and all subdirectories. |

##### Remarks

- If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, "`<computer name>`").

- Use **macfile directory** to make an existing directory in a Macintosh-accessible volume available to Macintosh users. The **macfile directory** command doesn't create directories.

- Use File Manager, the command prompt, or the **macintosh new folder** command to create a directory in a Macintosh-accessible volume before you use the **macfile directory** command.

#### Examples

To assign *See Files*, *See Folders*, and *Make changes* permissions to the owner, to set *See Folder* permissions to all other users, and to prevent the directory from being renamed, moved, or deleted, type:

```
macfile directory /path:e:\statistics\may sales /permissions:11111011000
```

Where the subdirectory is *May sales*, located in the Macintosh-accessible volume *Statistics*, on the E:\ drive of the local server.

## Join a Macintosh file's data and resource forks

To specify the server on which to join files, who created the file, the type of file, where the data fork is located, where the resource fork is located, and where the output file should be located.

### Syntax

```
macfile forkize[/server:\\<computername>] [/creator:<creatorname>] [/type:<typename>]  [/datafork:<filepath>] [/resourcefork:<filepath>] /targetfile:<filepath>
```

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| /server:`\\<computername>` | Specifies the server on which to join files. If omitted, the operation is performed on the local computer. |
| /creator:`<creatorname>` | Specifies the creator of the file. The Macintosh finder uses the **/creator** command-line option to determine the application that created the file. |
| /type:`<typename>` | Specifies the type of file. The Macintosh finder uses the **/type** command-line option to determine the file type within the application that created the file. |
| /datafork:`<filepath>` | Specifies the location of the data fork that is to be joined. You can specify a remote path. |
| /resourcefork:`<filepath>` | Specifies the location of the resource fork that is to be joined. You can specify a remote path. |
| /targetfile:`<filepath>` | Specifies the location of the file that's created by joining a data fork and a resource fork, or specifies the location of the file whose type or creator you are changing. The file must be on the specified server. This parameter is required. |
| /? | Displays help at the command prompt. |

##### Remarks

- If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, "`<computer name>`").

#### Examples

To create the file *tree_app* on the Macintosh-accessible volume *D:\Release*, using the resource fork *C:\Cross\Mac\Appcode*, and to make this new file appear to Macintosh clients as an application (Macintosh applications use the type *APPL*) with the creator (signature) set to *MAGNOLIA*, type:

```
macfile forkize /resourcefork:c:\cross\mac\appcode /type:APPL /creator:MAGNOLIA /targetfile:D:\Release\tree_app
```

To change the file creator to *Microsoft Word 5.1*, for the file *Word.txt* in the directory *D:\Word documents\Group files*, on the server *\\ServerA*, type:

```
macfile forkize /server:\\ServerA /creator:MSWD /type:TEXT /targetfile:d:\Word documents\Group files\Word.txt
```

## Change the sign-in message and limit sessions

To change the sign on message that appears when a user signs in to the File Server for Macintosh server and to limit the number of users who can simultaneously use File and print Servers for Macintosh.

### Syntax

```
macfile server [/server:\\<computername>] [/maxsessions:{number | unlimited}] [/loginmessage:<message>]
```

#### Parameters

| Parameter | Description |
| --------- |------------ |
| /server:`\\<computername>` | Specifies the server on which to change parameters. If omitted, the operation is performed on the local computer. |
| /maxsessions:`{number | unlimited}` | Specifies the maximum number of users who can simultaneously use File and print Servers for Macintosh. If omitted, the **maxsessions** setting for the server remains unchanged. |
| /loginmessage:`<message>` | Changes the message Macintosh users see when signing in to the File Server for Macintosh server. The maximum number of characters for the sign-in message is 199. If omitted, the **loginmessage** message for the server remains unchanged. To remove an existing sign-in message, include the **/loginmessage** parameter, but leave the *message* variable blank. |
| /? | Displays help at the command prompt. |

##### Remarks

- If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, "`<computer name>`").

#### Examples

To change the number of permitted File and print Server for Macintosh sessions on the local server to five sessions, and to add the sign-in message "Sign off from Server for Macintosh when you are finished", type:

```
macfile server /maxsessions:5 /loginmessage:Sign off from Server for Macintosh when you are finished
```

## Add, change, or remove Macintosh-accessible volumes

To add, change, or remove a Macintosh-accessible volume.

### Syntax

```
macfile volume {/add|/set} [/server:\\<computername>] /name:<volumename>/path:<directory>[/readonly:{true | false}] [/guestsallowed:{true | false}] [/password:<password>] [/maxusers:{<number>>|unlimited}]
macfile volume /remove[/server:\\<computername>] /name:<volumename>
```

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| `{/add | /set}` | Required when adding or changing a Macintosh-accessible volume. Adds or changes the specified volume. |
| /server:`\\<computername>` | Specifies the server on which to add, change, or remove a volume. If omitted, the operation is performed on the local computer. |
| /name:`<volumename>` | Required. Specifies the volume name to be added, changed, or removed. |
| /path:`<directory>` | Required and valid only when you are adding a volume. Specifies the path to the root directory of the volume to be added. |
| /readonly:`{true | false}` | Specifies whether users can change files in the volume. Use **True** to specify that users can't change files in the volume. Use **False** to specify that users can change files in the volume. If omitted when adding a volume, changes to files are allowed. If omitted when changing a volume, the **readonly** setting for the volume remains unchanged. |
| /guestsallowed:`{true | false}` | Specifies whether users who log on as guests can use the volume. Use **True** to specify that guests can use the volume. Use **False** to specify that guests can't use the volume. If omitted when adding a volume, guests can use the volume. If omitted when changing a volume, the **guestsallowed** setting for the volume remains unchanged. |
| /password:`<password>` | Specifies a password that will be required to access the volume. If omitted when adding a volume, no password is created. If omitted when changing a volume, the password remains unchanged. |
| /maxusers:`{<number>> | unlimited}` | Specifies the maximum number of users who can simultaneously use the files on the volume. If omitted when adding a volume, an unlimited number of users can use the volume. If omitted when changing a volume, the **maxusers** value remains unchanged.                                                 |
| /remove | Required when you are removing a Macintosh-accessible volume. removes the specified volume. |
| /? | Displays help at the command prompt. |

##### Remarks

- If the information that you supply contains spaces or special characters, use quotation marks around the text (for example, "`<computer name>`").

#### Examples

To create a volume called *US Marketing Statistics* on the local server, using the *Stats* directory in the E drive, and to specify that the volume cannot be accessed by guests, type:

```
macfile volume /add /name:US Marketing Statistics /guestsallowed:false /path:e:\Stats
```

To change the volume created above to be read-only, to require a password, and to set the number of maximum users to five, type:

```
macfile volume /set /name:US Marketing Statistics /readonly:true /password:saturn /maxusers:5
```

To add a volume called *Landscape Design*, on the server *\\Magnolia*, using the *trees* directory in the E drive, and to specify that the volume can be accessed by guests, type:

```
macfile volume /add /server:\\Magnolia /name:Landscape Design /path:e:\trees
```

To remove the volume called *Sales Reports* on the local server, type:

```
macfile volume /remove /name:Sales Reports
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

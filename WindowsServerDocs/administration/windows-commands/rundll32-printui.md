---
title: rundll32 printui.dll,PrintUIEntry
description: Reference article for the rundll32 printui.dll,PrintUIEntry command, which automates many printer configuration tasks.
ms.topic: reference
ms.assetid: 12fb48b6-5dd8-4cc0-8808-e6a681aceb84
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 05/25/2018
---

# rundll32 printui.dll,PrintUIEntry

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Automates many printer configuration tasks. printui.dll is the executable file that contains the functions used by the printer configuration dialog boxes. These functions can also be called from within a script or a command-line batch file, or they can be run interactively from the command prompt.

## Syntax

```
rundll32 printui.dll PrintUIEntry [baseparameter] [modificationparameter1] [modificationparameter2] [modificationparameterN]
```

You can also use the following alternate syntaxes, although the examples in this topic use the previous syntax:

```
rundll32 printui.dll,PrintUIEntry [baseparameter] [modificationparameter1] [modificationparameter2] [ModificationParameterN]
```

```
rundll32 printui PrintUIEntry [baseparameter] [modificationparameter1] [modificationparameter2] [modificationparameterN]
```

```
rundll32 printui,PrintUIEntry [baseparameter] [modificationparameter1] [modificationparameter2] [modificationparameterN]
```

### Parameters

There are two types of parameters: base parameters and modification parameters. Base parameters specify the function that the command is to perform. Only one of these parameters can appear in a given command line. Then, you can modify the base parameter by using one or more of the modification parameters if they are applicable to the base parameter (not all modification parameters are supported by all base parameters).

| Base Parameters | Description |
|--|--|
| /dl | Deletes the local printer. |
| /dn | Deletes a network printer connection. |
| /dd | Deletes a printer driver. |
| /e | Displays the printing preferences for a given printer. |
| /ga | adds a per computer printer connection (the connection is available to any user on that computer when they log on). |
| /ge | Displays per computer printer connections on a computer. |
| /gd | Deletes a per computer printer connection (the connection is deleted the next time a user logs on). |
| /ia | Installs a printer driver by using an .inf file. |
| /id | Installs a printer driver by using the add printer Driver Wizard. |
| /if | Installs a printer by using an .inf file. |
| /ii | Installs a printer by using the add printer wizard with an .inf file. |
| /il | Installs a printer by using the add printer wizard. |
| /in | Connects to a remote network printer. |
| /ip | Installs a printer by using the Network printer Installation Wizard (available from the user interface from print Management). |
| /k | prints a test page on a printer. |
| /o | Displays the queue for a printer. |
| /p | Displays the properties of a printer. When you use this parameter, you must also specify a value for the modification parameter **/n[name]**. |
| /s | Displays the properties of a print server. If you want to view the local print server, you do not need to use a modification parameter. However, if you want to view a remote print server, you must specify the **/c[name]** modification parameter. |
| /Ss | Specifies what type of information for a printer will be stored. If none of the values for **/Ss** are specified, the default behavior is as if all of them were specified. Use this base parameter with the following values placed at the end of the command line:<ul><li>**2**: Stores the information contained in the printer s printER_INFO_2 structure. This structure contains the basic information about the printer such as its name, server name, port name, and share name.</li><li>**7**: Used to store the directory service information contained in the printER_INFO_7 structure.</li><li>**c**: Stores the color profile information for a printer.</li><li>**d**: Stores printer specific data such as the printer s hardware ID.</li><li>**s**: Stores the printer s security descriptor.</li><li>**g**: Stores the information in the printer s global DEVmode structure.</li><li>**m**: Stores the minimal settings for the printer. This is equivalent to specifying **2** **d**, and **g**.</li><li>**u**: Stores the information in the printer s per user DEVmode structure.</li></ul> |
| /Sr | Specifies what information about a printer is restored and how conflicts in settings are handled. Use with the following values placed at the end of the command line:<ul><li>**2**: Restores the information contained in the printer s printER_INFO_2 structure. This structure contains the basic information about the printer such as its name, server name, port name, and share name.</li><li>**7**: Restores the directory service information contained in the printER_INFO_7 structure.</li><li>**c**: Restores the color profile information for a printer.</li><li>**d**: Restores printer specific data, such as the printer s hardware ID.</li><li>**s**: Restores the printer s security descriptor.</li><li>**g**: Restores the information in the printer s global DEVmode structure.</li><li>**m**: Restores the minimal settings for the printer. This is equivalent to specifying **2**, **d**, and **g**.</li><li>**u** Restores the information in the printe s per user DEVmode structure.</li><li>**r**: If the printer name stored in the file is different from the name of the printer being restored to, then use the current printer name. This cannot be specified with **f**. If neither **r** nor **f** is specified and the names do not match, restoration of the settings fails.</li><li>**f**: If the printer name stored in the file is different from the name of the printer being restored to, then use the printer name in the file. This cannot be specified with **r**. If neither **f** nor **r** is specified and the names do not match, restoration of the settings fails.</li><li>**p**: If the port name in the file being restored from does not match the current port name of the printer being restored to, the printer s current port name is used.</li><li>**h**: If the printer being restored to could not be shared using the resource share name in the saved settings file, then attempt to share the printer with either the current share name or a new generated share name if neither **H** nor **h** is specified and the printer being restored to cannot be shared with the saved share name, then restoration fails.</li><li>**h**: If the printer being restored to cannot be shared with the saved share name, then do not share the printer. If neither **H** nor **h** is specified and the printer being restored to cannot be shared with the saved share name, then restoration fails.</li><li>**i**: If the driver in the saved settings file does not match the driver for the printer being restored to, then the restoration fails. |
| /Xg | Retrieves the settings for a printer. |
| /Xs | Sets the settings for a printer. |
| /y | Sets the printer being installed as the default printer. |
| /? | Displays the in-product help for the command and its associated parameters. |
| @[file] | Specifies a command-line argument file and directly inserts the text in that file into the command line. |

| Modification Parameters | Description |
|--|--|
| /a[file] | Specifies the binary file name. |
| /b[name] | Specifies the base printer name. |
| /c[name] | Specifies the computer name if the action to be performed is on a remote computer. |
| /f[file] | Species the Universal Naming Convention (UNC) path and name of the .inf file name or the output file name, depending on the task that you are performing. Use **/F[file]** to specify a dependent .inf file. |
| /F[file] | Specifies the UNC path and name of a .inf file that the .inf file specified with **/f[file]** depends on. |
| /h[architecture] | Specifies the driver architecture. Use one of the following: **x86**, **x64**, or **Itanium**. |
| /j[provider] | Specifies the print provider name. |
| /l[path] | Specifies the UNC path where the printer driver files that you are using are located. |
| /m[model] | Specifies the driver model name. (This value can be specified in the .inf file.) |
| /n[name] | Specifies the printer name. |
| /q | Runs the command with no notifications to the user. |
| /r[port] | Specifies the port name. |
| /u | Specifies to use the existing printer driver if it is already installed. |
| /t[#] | Specifies the zero-based index page to start on. |
| /v[version] | Specifies the driver version. If you do not also specify a value for **/K**, you must specify one of the following values: **type 2 - Kernel mode** or **type 3 - User mode**. |
| /w | prompts the user for a driver if the driver is not found in the .inf file that is specified by **/f**. |
| /Y | Specifies that printer names should not be automatically generated. |
| /z | Specifies to not automatically share the printer being installed. |
| /K | changes the meaning of the parameter **/h[architecture]** to accept **2** in place of **x86**, **3** in place of **x64**, or **4** in place of **Itanium**. It also changes the value of the parameter **/v[version]** to accept **2** in the place of **type 2 - Kernel mode** and **3** in place of **type 3 - User mode**. |
| /Z | Shares the printer that is being installed. Only use with the **/if** parameter. |
| /Mw[message] | Displays a warning message to the user before committing the changes specified in the command line. |
| /Mq[message] | Displays a confirmation message to the user before committing the changes specified in the command line. |
| /W[flags] | Specifies any parameters or options for the add printer wizard, the add printer Driver Wizard, and the Network printer Installation Wizard.<p>**r**: Enables the wizards to be restarted from the last page. |
| /G[flags] | Specifies global parameters and options that you want to use.<p>**w**: Suppresses setup driver warnings to the user. |

#### Remarks

- The **PrintUIEntry** keyword is case sensitive, and you must enter the syntax for this command with the exact capitalization shown in the examples in this topic.

- For more examples, at a command prompt type: **rundll32 printui.dll,PrintUIEntry /?**

## Examples

To add a new remote printer, printer1, for a computer, Client1, which is visible for the user account where this command is run, type:

```
rundll32 printui.dll PrintUIEntry /in /n\\client1\printer1
```

To add a printer using the add printer wizard and using an .inf file, InfFile.inf, located on drive c: at Infpath, type:

```
rundll32 printui.dll PrintUIEntry /ii /f c:\Infpath\InfFile.inf
```

To delete an existing printer, printer1, on a computer, Client1, type:

```
rundll32 printui.dll PrintUIEntry /dn /n\\client1\printer1
```

To add a per computer printer connection, printer2, for all users of a computer, Client2, type (the connection will be applied when a user logs on):

```
rundll32 printui.dll PrintUIEntry /ga /n\\client2\printer2
```

To delete a per computer printer connection, printer2, for all users of a computer, Client2, type (the connection will be deleted when a user logs on):

```
rundll32 printui.dll PrintUIEntry /gd /n\\client2\printer2
```

To view the properties of the print server, printServer1, type:

```
rundll32 printui.dll PrintUIEntry /s /t1 /c\\printserver1
```

To view the properties of a printer, printer3, type:
```
rundll32 printui.dll PrintUIEntry /p /n\\printer3
```

## Related links

- [rundll32](rundll32.md)

- [print Command Reference](print-command-reference.md)

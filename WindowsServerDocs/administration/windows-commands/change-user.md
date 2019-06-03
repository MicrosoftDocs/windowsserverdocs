---
title: change user
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6202f024-8cf5-411e-89b1-ee37ff46499d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# change user

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the install mode for the Remote Desktop Session Host (rd Session Host) server.
for examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
> ## Syntax
> ```
> change user {/execute | /install | /query}
> ```
> ## Parameters
> 
> | Parameter |                                                                                                 Description                                                                                                  |
> |-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
> | /execute  |                                                                Enables .ini file mapping to the home directory. This is the default setting.                                                                 |
> | /install  | Disables .ini file mapping to the home directory. All .ini files are read and written to the system directory. You must disable .ini file mapping when installing applications on an rd Session Host server. |
> |  /query   |                                                                             Displays the current setting for .ini file mapping.                                                                              |
> |    /?     |                                                                                     Displays help at the command prompt.                                                                                     |
> 
> ## Remarks
> - Use **change user /install** before installing an application to create .ini files for the application in the system directory. These files are used as the source when user-specific .ini files are created. After installing the application, use **change user /execute** to revert to standard .ini file mapping.
> - The first time that you run the application, it searches the home directory for its .ini files. If the .ini files are not found in the home directory, but are found in the system directory, Remote Desktop Services copies the .ini files to the home directory, ensuring that each user has a unique copy of the application .ini files. Any new .ini files are created in the home directory.
> - Each user should have a unique copy of the .ini files for an application. This prevents instances where different users might have incompatible application configurations (for example, different default directories or screen resolutions).
> - When the system is in install mode (that is, **change user /install**), several things occur. All registry entries that are created are shadowed under **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\Currentversion\Terminal Server\Install**, in either the **\SOFTWARE** subkey or the **\MACHINE** subkey. Subkeys added to **HKEY_CURrenT_USER** are copied under the **\SOFTWARE** subkey, and subkeys added to **HKEY_LOCAL_MACHINE** are copied under the **\MACHINE** subkey. If the application queries the Windows directory by using system calls, such as GetWindowsdirectory, the rd Session Host server returns the systemroot directory. If any .ini file entries are added by using system calls, such as WritePrivateProfileString, they are added to the .ini files under the systemroot directory.
> - When the system returns to execution mode (that is, **change user /execute**), and the application tries to read a registry entry under **HKEY_CURrenT_USER** that does not exist, Remote Desktop Services checks to see whether a copy of the key exists under the **\Terminal Server\Install** subkey. If it does, the subkeys are copied to the appropriate location under **HKEY_CURrenT_USER**. If the application tries to read from an .ini file that does not exist, Remote Desktop Services searches for that .ini file under the system root. If the .ini file is in the system root, it is copied to the \Windows subdirectory of the user's home directory. If the application queries the Windows directory, the rd Session Host server returns the \Windows subdirectory of the user's home directory.
> - When you log on, Remote Desktop Services checks whether its system .ini files are newer than the .ini files on your computer. If the system version is newer, your .ini file is either replaced or merged with the newer version. This depends on whether or not the INISYNC bit, 0x40, is set for this .ini file. Your previous version of the .ini file is renamed as Inifile.ctx. If the system registry values under the **\Terminal Server\Install** subkey are newer than your version under **HKEY_CURrenT_USER**, your version of the subkeys is deleted and replaced with the new subkeys from **\Terminal Server\Install**.
>   ## <a name="BKMK_examples"></a>Examples
> - To disable .ini file mapping in the home directory, type:
>   ```
>   change user /install
>   ```
> - To enable .ini file mapping in the home directory, type:
>   ```
>   change user /execute
>   ```
> - To display the current setting for .ini file mapping, type:
>   ```
>   change user /query
>   ```
>   #### additional references
>   [Command-Line Syntax Key](command-line-syntax-key.md)
>   [change](change.md)
>   [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)

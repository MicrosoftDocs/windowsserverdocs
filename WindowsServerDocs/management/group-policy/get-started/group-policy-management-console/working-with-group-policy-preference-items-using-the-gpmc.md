---
title: Working with Group Policy Preference Items Using the GPMC
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b068ca77-94d8-4e19-be5e-cbee5ac759f1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Working with Group Policy Preference Items Using the GPMC

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes Group Policy Preferences and explains some common configuration procedures. It also contains links to topics about working with Preferences using the GPMC for Windows settings and Control Panel settings as well as item-level targeting.

Group Policy Preferences, introduced in  Windows Server 2008 , provide more than twenty Group Policy extensions that expand the range of configurable preference settings in a Group Policy Object. Group Policy lets you manage drive mappings, registry settings, local users and groups, services, files, and folders without the need to learn a scripting language.

for procedural information about using Preferences for Windows settings, Control Panel settings, and item-level targeting, see:

-   [Working with Control Panel Settings Preference Items Using the GPMC](working-with-control-panel-settings-preference-items-using-the-gpmc.md)

-   [Preference item-level targeting](https://technet.microsoft.com/library/cc733022.aspx)

## Overview
Preferences let you manage all these additional settings by using the familiar Group Policy Management Console (GPMC). Within most preference items, the user interface mimics the relevant end-user interface for configuring these settings. This makes configuration more intuitive.

Within each GPO, you can create multiple preference items with each preference extension. Targeting options give you with more precise control over how Windows applies preference settings. By using item-level targeting, you can configure each GPO to be appropriate to more users and computers.

The GPMC lets you configure preferences when you edit any domain-based GPO. The **Preferences** node appears under **computer Configuration** and **User Configuration**.

Unlike policy settings, preference items do not exist until a Group Policy administrator creates them, and each preference item contains multiple properties. You can create and modify multiple preference items within each GPO, and you can filter each preference item to apply only to specific computers or users.

|Preference Extension|Effect of Preference Item|Scope of Preference Item|
|------------|---------------|--------------|
|**Applications**|Configures settings for a specific version of an application.|Users to whom the preference item applies|
|**Data Sources**|Configures an ODBC system or other user data source.|computers or users to whom the preference item applies|
|**Devices**|Enables or disables a class or type of hardware device.|computers or users to whom the preference item applies|
|**Drive Maps**|creates, configures, or deletes dynamic a drive mapping.|Users to whom the preference item applies|
|**Environment**|creates, modifies, or deletes a persistent user or system environment variable.|computers or users to whom the preference item applies|
|**Files**|Copies or replaces files and configures their attributes, or deletes files.|computers or users to whom the preference item applies|
|**Folder Options**|Modifies Folder Options in Windows Explorer, associates a file extension with a particular program, or associates a file extension with a particular class of files.|computers (File type items only) or users (Folder Options and Open With items only) to whom the preference item applies|
|**Folders**|creates folders and configures their attributes, or deletes folders and their contents.|computers or users to whom the preference item applies|
|**Ini Files**|creates or changes a property/value pair in an .ini file, or deletes part or all of an .ini file.|computers or users to whom the preference item applies|
|**Internet Settings**|Modifies Internet settings.|computers or users to whom the preference item applies|
|**Local Users and Groups**|creates, modifies or deletes local users (performing tasks such as setting passwords) or local security groups (performing tasks such as creating restricted groups and modifying the list of members).|computers or users to whom the preference item applies|
|**Network Options**|creates, modifies, or deletes a virtual private network (VPN) or dial-up network (DUN) connection.|computers or users to whom the preference item applies|
|**Network Shares**|creates, modifies, or deletes a share. Can configure Access-Based Enumeration.|computers to which the preference item applies|
|**Power Options**|Configures power management options, either modifying power options or creating, modifying, or deleting a power scheme.|computers or users to whom the preference item applies|
|**printers**|creates, modifies, or deletes a local, shared, or TCP/IP printer connection.|computers (local or TCP/IP printers only) or users to whom the preference item applies|
|**regional Options**|Configures how most programs format numbers, currencies, dates, and times for end users.|Users to whom the preference item applies|
|**registry**|creates, modifies, or deletes a setting in the Windows registry.|computers or users to whom the preference item applies|
|**Scheduled Tasks**|creates, modifies, or deletes a scheduled task in the Control Panel.|computers or users to whom the preference item applies|
|**Services**|Modifies an operating system service.|computers to which the preference item applies|
|**Shortcuts**|creates, modifies, or deletes a shortcut to a file system object (such as a file, folder, drive, share, or computer), a shell object (such as a printer, desktop item, or control panel item), or a URL (such as a Web page or an ftp site).|computers or users to whom the preference item applies|
|**start Menu**|Modifies the look and feel of the start menu.|Users to whom the preference item applies|

You can apply targeting to each preference item, restricting the creation, modification, or deletion of settings to selected users and computers. You can apply the following targeting items to preference items:

-   Battery Present

-   Collection

-   computer Name

-   CPU Speed

-   Dial-Up Connection

-   Disk Space

-   Domain

-   Environment Variable

-   File Match

-   IP address Range

-   Language

-   LDAP query

-   MAC address Range

-   MSI query

-   Operating System

-   Organizational Unit

-   PCMCIA Present

-   Portable computer

-   Processing mode

-   RAM

-   Recur Every

-   registry Match

-   Security Group

-   Site

-   Terminal Session

-   time Range

-   User

-   WMI query

## Configuring common options
Many Group Policy preference items share common options. Each preference item displays these options on the **Common** tab. The common options are consistent among the preference extensions and allow you to control the error handling for a particular extension, the security context the extension uses when processing user configuration settings, the scope and application of preference items, and item-level targeting, which provides filtering at the preference item level, in addition to Group Policy filtering.

Common options include:

-   [Stop processing items in this extension if an error occurs on this item](#BKMK_Stop)

-   [Run in logged-on user's security context (user policy option)](#BKMK_Run)

-   [remove this item when it is no longer applied](#BKMK_remove)

-   [Apply once and do not reapply](#BKMK_Apply)

-   [Item-level targeting](#BKMK_Item)

#### <a name="BKMK_Stop"></a>Stop processing items in this extension if an error occurs on this item
Each preference extension can contain one or more preference items.

-   By default, a failing preference item does not prevent other preference items in the same extension from processing.

-   if the **Stop processing items in this extension if an error occurs on this item** option is selected, a failing preference item prevents remaining preference items within the extension from processing. This change in behavior is limited to the hosting Group Policy object (GPO) and does not extend to other GPOs.

    > [!IMPORTANT]
    > Preference extensions start processing preference items from the bottom of the list and work their way to the top. Preference items successfully applied prior to the failing preference item are applied. The preference extension only stops processing preference items that follow the failing preference item.

#### <a name="BKMK_Run"></a>Run in logged-on user's security context (user policy option)
There are two security contexts in which Group Policy applies user preferences: the SYSTEM account and the logged-on user.

-   By default, Group Policy processes user preferences using the security context of the SYSTEM account. In this security context, the preference extension is limited to environment variables and system resources available only to the computer.

-   if the **Run in logged-on user's security context** option is selected, it changes the security context under which the preference item is processed. The preference extension processes preference items in the security context of the logged-on user. This allows the preference extension to access resources as the user rather than the computer. This can be especially IMPORTANT when using drive maps or other preferences in which the computer may not have permissions to resources or when using environment variables. The value of many environment variables differs when evaluated in a security context other than the logged-on user.

#### <a name="BKMK_remove"></a>remove this item when it is no longer applied
Group Policy applies policy settings and preference items to users and computers. You determine which users and computers receive these items by linking one or more Group Policy objects (GPOs) to active directory sites, domains, or organizational units. User and computer objects that reside in these containers receive policy settings and preference items defined in the linked GPOs because they are within the scope of the GPO.

-   Unlike policy settings, by default preference items are not removed when the hosting GPO becomes out of scope for the user or computer.

-   if the **remove this item when it is no longer applied** option is selected, it changes this behavior. After selecting this option, the preference extension determines if the preference item should not apply to targeted users or computers (out of scope). If the preference extension determines the preference item is out of scope, it removes the settings associated with the preference item.

    > [!IMPORTANT]
    > selecting this option changes the action to **replace**. During Group Policy application, the preference extension recreates (deletes and creates) the results of the preference item. When the preference item is out of scope for the user or computer, the results of the preference item are deleted, but not created. Preference items can become out of scope by using item-level targeting or by higher-level Group Policy filters such as WMI and security group filters.

    > [!NOTE]
    > The **remove this item when it is no longer applied** option is not available when the preference item action is set to **delete**.

#### <a name="BKMK_Apply"></a>Apply once and do not reapply
Preference items are applied when Group Policy refreshes.

-   By default, the results of preference items are rewritten each time Group Policy refreshes. This ensures that the results of the preference items are consistent with what the administrator designated in the Group Policy object.

-   if the **Apply once and do not reapply** option is selected, it changes this behavior, so the preference extension applies the results of the preference item to the user or computer only once. This option is useful when you do not want the results of a preference item to reapply.

#### <a name="BKMK_Item"></a>Item-level targeting
Group Policy provides filters to control which policy settings and preference items apply to users and computers. Preferences provide an additional layer of filtering called targeting. Item-level targeting allows you to control if a preference item applies to a group of users or computers. For more information, see [Preference item-level targeting](https://technet.microsoft.com/library/cc733022.aspx).

## Enable and disable settings in a Preference item
In addition to enabling and disabling preference items within a Group Policy object (GPO), you can individually enable and disable underlined settings or settings preceded by a circle within a preference item.

The underlining or circle of the setting indicates whether it is currently enabled or disabled:

||||
|-|-|-|
|||A setting with a solid green underline or a green circle is enabled. The preference extension applies this setting's value to the user or computer.|
|||A setting with a dashed red underline or red circle with a slash is disabled. The preference extension does not apply this setting's value to the user or computer.|

## Variables in Preference items
Preference extensions support Windows environment variables and generate a number of additional process environment variables. Any variable may be used in a configuration parameter value. Each help document states whether variables are supported in a specific field.

> [!NOTE]
> By using [registry Matching](https://technet.microsoft.com/library/cc733051.aspx) targeting items, you can define variables at client run-time, and have these control behavior by using the [Environment Variable](https://technet.microsoft.com/library/cc731487.aspx) targeting items or as values in a preference item setting.

### Windows environment variables
The Windows environment is a list of variables saved as name/value pairs. To see the current list of variables, type **SET** at the command prompt. Each process, including the desktop, has a list of variables unique to the process. When one process starts another, normally a copy of the environment of the starting process is passed to the started process. Typically, environment variable names are enclosed between two percent signs (for example, %ProgramFiles%). Windows resolves the environment variable when an application requests the value associated to the name.

### Preference process variables
Preference extensions implement the process variables that are listed here.

> [!NOTE]
> Variables are not case-sensitive.

|||
|-|-|
|**%AppDatadir%**|The current user's Application Data directory.|
|**%BinarycomputerSid%**|The SID of the computer in hexadecimal format.|
|**%BinaryUserSid%**|The SID of the current user in hexadecimal format.|
|**%CommonAppdatadir%**|The "all users" Application Data directory.|
|**%CommonDesktopdir%**|The "all users" Desktop directory.|
|**%CommonFavoritesdir%**|The "all users" Explorer Favorites directory.|
|**%CommonProgramsdir%**|The "all users" Programs directory.|
|**%CommonstartMenudir%**|The "all users" start Menu directory.|
|**%CommonstartUpdir%**|The "all users" startup directory.|
|**%computerName%**|The NetBIOS name of the computer.|
|**%CurrentProcessId%**|The numeric identity of the main client process.|
|**%CurrentThreadId%**|The numeric identity of the main client thread.|
|**%datetime%**|The current time (UTC).|
|**%datetimeEx%**|The current time (UTC) with milliseconds.|
|**%Desktopdir%**|The current user's desktop directory.|
|**%DomainName%**|The domain name or workgroup of the computer.|
|**%Favoritesdir%**|The current user's Explorer Favorites directory.|
|**%LastError%**|The last error code encountered during configuration.|
|**%LastErrorText%**|The last error code text description.|
|**%LdapcomputerSid%**|The SID of the computer in LDAP escaped binary format.|
|**%LdapUserSid%**|The SID of the current user in LDAP escaped binary format.|
|**%Localtime%**|The current local time.|
|**%LocaltimeEx%**|The current local time with milliseconds.|
|**%LogonDomain%**|The domain of the current user.|
|**%LogonServer%**|The domain controller that authenticated the current user.|
|**%LogonUser%**|The user name of the current user.|
|**%LogonUserSid%**|The SID of the current user.|
|**%Macaddress%**|The first detected MAC address on the computer.|
|**%NetPlacesdir%**|The current user's My Network Places directory.|
|**%Osversion%**|The operating system:  Windows Server 2008 R2 ,  Windows 7 ,  Windows Server 2008 , Windows Vista, Windows Server 2003, Windows XP, or Unknown.|
|**%ProgramFilesdir%**|The Windows Program Files directory.|
|**%Programsdir%**|The current user's Programs directory.|
|**%RecentDocumentsdir%**|The current user's Recent Documents directory.|
|**%ResultCode%**|The client's exit code.|
|**%ResultText%**|The client's exit code text description.|
|**%ReversedcomputerSid%**|The SID of the computer in reversed byte order hexadecimal format.|
|**%ReversedUserSid%**|The SID of the current user in reversed byte order hexadecimal format.|
|**%SendTodir%**|The current user's Send to directory.|
|**%startMenudir%**|The current user's start Menu directory.|
|**%startUpdir%**|The current user's startup directory.|
|**%Systemdir%**|The Windows system directory.|
|**%SystemDrive%**|The name of the drive from which the operating system is running.|
|**%Tempdir%**|The current user's Temp directory as determined by Windows API.|
|**%timeStamp%**|The time stamp of the configurations being implemented.|
|**%TraceFile%**|The path/name of the trace file.|
|**%Windowsdir%**|The Windows directory.|

Preference extensions provide a list of variables from which you can choose to insert into text boxes. You can open the dialog box from any text box that is:

-   Not disabled.

-   Not read-only.

-   Not restricted to a numeric value.

##### To enter a variable

1.  Open the Group Policy Management Console. Right-click the Group Policy object (GPO) that contains the preference item that you want to configure, and then click **edit**.

2.  Position the cursor in the desired box.

    -   To enter a preference process variable, press **F3**, select a variable from the list, and then click **select** to insert the variable in the box.

    -   To enter an existing Windows environment variable, type the variable in the box.

        > [!NOTE]
        > You can prevent the resolution of a variable before it is applied to client computers (so that the variable instead of the resolved value appears in the preference setting on client computers). To do this for a preference process variable, clear the **Resolve Variable** check box. This inserts **<>** between the **%%** delimiters and the variable name (for example, %<ProgramFiles>%). Preference extensions remove **< >** characters from the text and leave the unresolved variable. You can also use this syntax with a Windows environment variable.



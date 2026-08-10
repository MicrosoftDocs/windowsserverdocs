---
title: Group Policy preferences in Windows
description: Group Policy Preferences allow administrators to configure, deploy, and manage user and computer settings in Active Directory with greater flexibility in Windows.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 06/16/2025
---

# Group Policy preferences

Group Policy preferences enhance Group Policy by allowing administrators to configure additional settings beyond standard policy options. While both preferences and policy settings are stored in the Windows registry, policy settings take precedence and can override preferences when conflicts occur.

Windows allows you to configure settings through its user interface, where you select your preferred options and confirm your choices. These selections are stored in the registry as preferences (with a lowercase **"p"**), which are settings that users can change according to their needs. For example, mapping a network drive or setting a default home page are considered preferences. When you set a home page in your web browser, Windows remembers your choice for future sessions. In contrast, policy settings are enforced by administrators and prevent users from changing those settings. While preferences are typically managed by users, policies are used to ensure specific configurations remain unchanged.

Group Policy preferences allow administrators to deploy preferred configurations to computers and users, but don't prevent users from changing those settings. Unlike enforced Group Policy settings, preferences are applied through client-side extensions and are refreshed each time Group Policy updates. If a user modifies a setting managed by Group Policy Preferences, their change will persist only until the next Group Policy refresh, at which point the preference will revert to the value specified by the administrator. This differs from standard Group Policy, which enforces settings and blocks user changes entirely.

## Client-side extensions

Group Policy preferences consist of 20 client-side extensions that provide a wide range of configuration options for administrators. These extensions include:

| Client-side extension | Description |
|--|--|
| Group Policy Applications | Configure settings for applications. |
| Group Policy Data Sources | Create, modify, or delete Open Database Connectivity (ODBC) data source names. |
| Group Policy Device Settings | Enable or disable hardware devices or classes of devices. |
| Group Policy Drive Maps | Create, modify, or delete mapped drives, and configure the visibility of all drives. |
| Group Policy Environment | Create, modify, or delete environment variables. |
| Group Policy Files | Copy, modify the attributes of, replace, or delete files. |
| Group Policy Folder Options | Create, modify, or delete folders. |
| Group Policy Folders | Create, modify, or delete folders. |
| Group Policy INI Files | Add, replace, or delete sections or properties in configuration settings (`.ini`) or (`.inf`) files. |
| Group Policy Internet Settings | Modify user-configurable Internet settings. |
| Group Policy Local Users and Groups | Create, modify, or delete local users and groups. |
| Group Policy Network Options | Create, modify, or delete VPN or dial-up networking (DUN) connections. |
| Group Policy Network Shares | Create, modify, or delete network shares. |
| Group Policy Power Options | Modify power options and create, modify, or delete power schemes. |
| Group Policy Printers | Create, modify, or delete TCP/IP, shared, and local printer connections. |
| Group Policy Regional Options | Modify regional options. |
| Group Policy Registry | Copy registry settings and apply them to other computers. Create, replace, or delete registry settings. |
| Group Policy Schedule Tasks | Create, modify, or delete scheduled or immediate tasks. |
| Group Policy Shortcuts | Create, modify, or delete shortcuts. |
| Group Policy Start Menu Settings | Modify Start menu options. (Not applicable for Windows 8 and Windows Server 2012) |

## Common configurations

Most Group Policy preference items include common configuration options that let you control how and when each preference item is processed. Each client-side extension can have multiple preference items. By default, if one preference item fails, it doesn't stop the processing of other items within the same extension.

| Option | Description |
|--------|-------------|
| **Stop processing items in this extension if an error occurs on this item** | When selected, if this preference item fails, the extension doesn't process any subsequent preference items within the same extension in the current Group Policy object (GPO). This behavior affects only the current GPO and extension, not others. Preference items are processed in order from top to bottom, so only items listed after the failed item are skipped. |
| **Run in logged-on user's security context (user policy option)** | Group Policy can apply user preference items using either the SYSTEM account or the logged-on user's account. By default, user preference items are processed under the SYSTEM account, which limits access to only system-level environment variables and resources. Selecting the **Run in logged-on user's security context** option causes the preference item to be processed using the permissions and environment of the logged-on user. <br><br> This is useful when the preference item needs access to user-specific resources, such as network drives or user environment variables, that aren't available to the SYSTEM account. Some preference extensions, like Drive Maps and Printers, automatically use the user's security context and don't require this option to be set manually. |
| **Remove this item when it is no longer applied** | By default, Group Policy Preferences don't remove settings when a Group Policy Object (GPO) no longer applies to a user or computer. Selecting **Remove this item when it is no longer applied** changes this behavior: if the preference item falls out of scope, due to item-level targeting or GPO changes, the settings previously applied by that item are removed. <br><br> This option automatically sets the action to **Replace**, so the preference extension deletes and recreates the item as needed. If the item is out of scope, its settings are deleted and not reapplied. This option isn't available if the action is set to **Delete**. |
| **Apply once and do not reapply** | By default, preference items are reapplied every time Group Policy refreshes, ensuring settings remain as configured in the Group Policy object. When you select **Apply once and do not reapply**, the preference item is applied only a single time to the user or computer. <br><br> After the initial application, Group Policy won't reapply or update the setting during future refreshes. This option is useful when you want a preference item to set a value only once and allow users or computers to modify it without it being overwritten by subsequent Group Policy updates. |

## Item-level targeting

Group Policy lets you filter which policy settings and preference items apply to users and computers. Preferences add another layer of filtering called targeting. With item-level targeting, you control whether a preference item applies to certain users or computers. You can use it to narrow the scope of individual preference items, so they only apply to the users or computers you choose. Inside a single GPO, you can have multiple preference items—each tailored and targeted to specific users or computers.

Each targeting item evaluates to either true or false. You can add several targeting items to a preference item and pick whether to combine them with **AND** or **OR** logic. If the combined result for a preference item is false, its settings aren't applied. You can also use targeting collections to create parenthetical expressions for more complex logic.

| Item | Description |
|------|-------------|
| **Battery Present** | Allows a preference item to be applied if one or more batteries are present in the processing computer. If **Is Not** is selected, applies only if no batteries are present. May detect a connected UPS as a battery. |
| **Computer Name** | Applies if the computer's name matches the specified value. If **Is Not** is selected, applies only if the name doesn't match. |
| **CPU Speed** | Applies if the CPU speed is greater than or equal to the specified value. If **Is Not** is selected, applies only if the CPU speed is less than or equal to the specified value. |
| **Date Match** | Applies if the day or date matches the specified value. If **Is Not** is selected, applies only if the day, or date doesn't match. |
| **Dial-up Connection** | Applies to users if a network connection of the specified type is connected. If **Is Not** is selected, applies only if no such connection is present. Detects connection type, not logon method. |
| **Disk Space** | Applies if available disk space is greater than or equal to the specified amount. If **Is Not** is selected, applies only if available disk space is less than or equal to the specified amount. |
| **Domain** | Applies if the user is logged on to or the computer is a member of the specified domain or workgroup. If **Is Not** is selected, applies only if not a member. |
| **Environment Variables** | Applies if the specified environment variable and value are equal. If **Is Not** is selected, applies only if not equal or variable doesn't exist. Useful for complex targeting by setting and referencing variables. |
| **File Match** | Applies if the specified file or folder exists, or if the file version is within the specified range. If **Is Not** is selected, applies only if not present or version is outside the range. |
| **IP Address Match** | Applies if the computer's IP address is within the specified range. If **Is Not** is selected, applies only if not within the range. |
| **Language** | Applies if the specified locale is installed. Additional options restrict to user or computer locale. If **Is Not** is selected, applies only if the locale doesn't match. |
| **LDAP Query** | Applies if the Lightweight Directory Access Protocol (LDAP) query returns a value for the specified attribute. If **Is Not** is selected, applies only if no value is returned. |
| **MAC Address Range** | Applies if any MAC address is within the specified range. If **Is Not** is selected, applies only if none are within the range. Range endpoints are inclusive. |
| **MSI Query** | Applies if aspects of a Microsoft Software Installer (MSI) installed product, update, or component match the specified criteria. If **Is Not** is selected, applies only if they don't match. |
| **Operating System** | Applies if the OS product name, release, edition, or computer role matches the specified values. If **Is Not** is selected, applies only if they don't match. |
| **Organizational Unit** | Applies if the user or computer is a member of the specified OU. If **Is Not** is selected, applies only if not a member. |
| **PCMCIA Present** | Applies if at least one PCMCIA slot is present and functioning. If **Is Not** is selected, applies only if no slots are present. |
| **Portable Computer** | Applies if the computer is identified as portable or matches the specified docking state. If **Is Not** is selected, applies only if not portable or docking state differs. |
| **Processing Mode** | Applies if the Group Policy processing mode or conditions match any specified. If **Is Not** is selected, applies only if none match. |
| **RAM** | Applies if total physical memory is greater than or equal to the specified amount (in MB). If **Is Not** is selected, applies only if less. |
| **Registry Match** | Applies if the specified registry key or value exists, contains the specified data, or version is within range. Can save value data to an environment variable. If **Is Not** is selected, applies only if not matched. |
| **Security Group** | Applies if the computer or user is a member of the specified group, and optionally if it's the primary group. If **Is Not** is selected, applies only if not a member or not the primary group. Supports: <br><br><li> Domain groups (domain local, global, universal) <li> Local groups (including built-in groups) <li> Well-known groups </li> |
| **Site** | Applies if the processing computer is in the specified Active Directory (AD) site. If **Is Not** is selected, applies only if the computer isn't in the specified site. |
| **Targeting Collection** | Allows you to group targeting items into parenthetical expressions for complex logic. The preference item applies only if the collection evaluates to true. If **Is Not** is selected, applies only if the collection evaluates to false. Collections can be nested. |
| **Terminal Session** | Applies to users only if they're logged on to a terminal services session with the specified settings. If **Is Not** is selected, applies only if the user isn't logged on to such a session, or the session settings don't match. |
| **Time Range** | Applies if the current time on the user's computer is within the specified range. If **Is Not** is selected, applies only if the current time is outside the specified range. |
| **User** | Applies if the processing user matches the specified user. If **Is Not** is selected, applies only if the processing user doesn't match. |
| **WMI Query** | Applies if the processing computer evaluates the specified Windows Management Instrumentation (WMI) query as true. If **Is Not** is selected, applies only if the WMI query evaluates as false. |


---
title: Working with Control Panel Settings Preference Items Using the GPMC
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: efaa8001-67d6-4e4d-804f-220c1092e5a3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Working with Control Panel Settings Preference Items Using the GPMC

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to configure Control Panel settings preferences when you edit any domain-based Group Policy Object using the GPMC. The preferences node appears under **Computer Configuration** and **User Configuration**.  
  
The Group Policy Management Console allows you to configure preferences when you edit any domain-based Group Policy object. Group Policy Preferences let you manage drive mappings, registry settings, local users and groups, services, files, and folders without the need to learn a scripting language. You can use preference items to reduce scripting and the number of custom system images needed, standardize management, and help secure your networks. By using preference item-level targeting, you can streamline desktop management by reducing the number of Group Policy objects needed.  
  
Additionally, you can manage Preferences using Windows PowerShell. For information how to do this, see Windows PowerShell Cmdlets for Group Policy.  
  
## Data Sources extension  
Group Policy includes the Data Sources preference extension. This extension allows you to centrally configure Open Database Connectivity (ODBC) data source names for user or computers.  
  
You can create and configure Data Source preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Data Sources**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Data Source item  
Data source preference items allow you to create, update, replace, and delete user and system data sources. Data sources store information about how to connect to a data provider. Before you create a Data Source preference item, you should review the behavior of each type of action possible with this extension.  
  
##### To create a new Data Source preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Data Sources** node, point to **New**, and select **Data Source**.  
  
4.  In the **New Data Source Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter data source settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether a data source with the same name exists.  
  
|||  
|-|-|  
|**Create**|Create a new data source name for the user or computer. If the data source exists, then do not modify it.|  
|**Delete**|Remove a data source name from the user or computer. The extension performs no action if the data source does not exist.|  
|**Replace**|Delete and recreate a data source name for the user or computer. The net result of the **Replace** action overwrites all existing settings associated with the data source name. If the data source name does not exist, then the **Replace** action creates the new data source name.|  
|**Update**|Modify settings of an existing data source name. This action differs from replace in that it only updates settings defined within the preference item. All other settings remain as they were previously configured. If the data source name does not exist, then the **Update** action creates a new data source name.|  
  
### Data source settings  
  
|||  
|-|-|  
|**User Data Source** or **System Data Source**|Select the visibility of the data source name. User data sources are available to users receiving the preference item. System data sources are available to all the users of the computer (including the Local System).|  
|**Data Source Name**|Type the name used to identify the data source. This field accepts preference processing variables. Press F3 to display a list of variables from which you can select. You can import a local data source name into the Data Source preference item. Click Browse **(Ã¢â‚¬Â¦)** to display a list of the data sources names on the current computer. **Important:** Attributes are automatically populated when importing an existing data source name into a Data Source preference item.|  
|**Driver**|Type the name of the ODBC driver used to connect to the data provider. Click Browse **(Ã¢â‚¬Â¦)** to choose from a list of ODBC drivers.|  
|**Description**|Provide text used to describe the data source. This field accepts preference processing variables. Press F3 to display a list of variables from which you can select.|  
|**User Name**|Type the user name used to connect to the indicated data provider.|  
|**Password**|Type the password used to connect to the indicated data provider. Type the same password in the **Confirm Password** box. **Security Note:** This password is protected by 256-bit Advanced Encryption Standard (AES) encryption and stored as part of the GPO in SYSVOL. This password should be changed on a regular basis and should not be relied on as the sole method of protecting confidential data.|  
|**Attributes**|Data Source item attributes allow you to supply additional information for the data provider. Each attribute consists of an attribute name and its associated value.<br /><br />-   Click **Add** to create new attributes in the Data Source item.<br />-   Click **Remove** to delete existing attributes.<br />-   Click **Change** to alter the attribute name or value. **Important:** Attributes are automatically populated when importing an existing data source name into a Data Source preference item.|  
  
#### Additional considerations  
  
-   Use the **Update** action to add or overwrite attributes of existing data source names.  
  
-   Use the **Replace** action to remove attributes from existing data source names.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Devices extension  
You can create and configure Device preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Devices**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
Device preference items allow you to enable or disable classes of or types of hardware devices. Device classes allow you to enable or disable a broader ranger of device types. Device types allow you to enable or disable a specific type of hardware device. For example, disabling the device class **DVD/CD-ROM drives** disables all hardware devices within the selected class. Disabling the device type **MS CD/DVD-ROM ATA Device** only disables hardware devices of that type, not the entire class. Before you create a Device preference item, you should review the behavior of each type of action possible with this extension.  
  
> [!IMPORTANT]  
> Make certain to test Device preference items before deploying them to a production environment. Disabling devices has the potential to render Windows inoperable.  
  
### How to create a Device item  
  
##### To create a new Device preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Devices** node, point to **New**, and select **Device**.  
  
4.  In the **New Device Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter device settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
### Actions  
  
|||  
|-|-|  
|**Use this device (enable)**|Enable a matching device class or device type.|  
|**Do not use this device (disable)**|Disable a matching device class or device type.|  
  
### Device settings  
  
|||  
|-|-|  
|**Device class**|This setting contains the name of the enabled or disabled device class. **DVD/CD-ROM drives** is an example of a device class. Click Browse **(Ã¢â‚¬Â¦)** to choose from a list of the device classes available on your computer.|  
|**Device type**|This setting contains the name of the enabled or disabled device type. **MS CD/DVD-ROM ATA Device** is an example of a device type. To select a Device type, click Browse **(Ã¢â‚¬Â¦)** next to the **Device class** box. Expand a device class to show the list of device types available on your computer.|  
  
#### Additional considerations  
  
-   Device preference items applied to computers affect all users of the targeted computer. Apply preference items to users if you want controls which users have device class or types enabled or disabled.  
  
-   Some devices appearing in Device Manager cannot be disabled.  
  
-   Disabling a device takes effect immediately. However, there may be some delays with Device Manager showing the device class or item as disabled. Check the properties of the device for the current status.  
  
-   The **Remove this item when it is no longer applied** is available only when the item action is set to **Do not use this device (disabled)**. Removing the preference item enables the device.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Folder Options extension  
Group Policy includes the Folder Options extension. This extension allows you to configure various Windows Explorer settings such as file type and application start-up associations, and folder view options.  
  
You can create and configure File Type, Open With, and Folder Options preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Folder Options**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Folder Options (at least Windows Vista) item  
  
##### To create a new Folder Options preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Folder Options** node, point to **New**, and select **Folder Options (Windows Vista and later)**.  
  
4.  In the **New Folder Options Properties** dialog box, enter folder options settings for Group Policy to configure.  
  
5.  Click the **Common** tab and configure any options desired.  
  
6.  Click **OK**. The new preference item appears in the results pane.  
  
### How to create an Open With item  
The Open With preference item allows you to create, configure, and delete an Open With association with a specific file name extension. Before you create an Open With preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new Open With preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Folder Options** node, point to **New**, and select **Open With**.  
  
4.  In the **New Open With Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter Open With settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the Open With association already exists.  
  
|||  
|-|-|  
|**Create**|Create a new Open With association. If a file name extension in the Open With item exists within the user's profile, then the new association is not created.|  
|**Delete**|Remove an existing Open With association. An association exists when the file name extension in the Open With item exists within the user's profile. No action is performed if the association does not exist.|  
|**Replace**|Delete and recreate an Open With association. The net result of the **Replace** action overwrites all existing settings associated with the Open With association. If the Open With association does not exist, then the **Replace** action creates a new Open With association.|  
|**Update**|Modify an Open With association. The action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the Open With association does not exist, then the **Update** action creates a new Open With association.|  
  
#### Open With settings  
  
|||  
|-|-|  
|**File name extension**|Type the extension of the file to associate with the specified application. Press F3 to display a list of variables from which you can select. **Note:** You do not need to insert the period before the file name extension.|  
|**Associated Program**|Type the path and name of the application you want to associate with the file name extension. Alternatively, you can click Browse **(Ã¢â‚¬Â¦)** and select the application. Press F3 to display a list of variables from which you can select.|  
|**Set as default**|Select this check box to make the associated application the default application Windows uses to open the file name extension.|  
  
##### Additional considerations  
  
-   Open With appears on the Windows Explorer's shortcut menu when there is more than one Open With association.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
### How to create a File Type item  
The File Type preference item allows you to create, configure, and delete file name extensions associated with a particular class of files (such as text documents). Additionally, the preference item allows you to associate applications for opening, editing, and other actions as well as icons to file specific file types. Before you create a File Type preference item, you should review the behavior of each type of action possible with the item.  
  
##### To create a new File Type preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Folder Options** node, point to **New**, and select **File Type**.  
  
4.  In the **New File Type Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter file type settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the file type association already exists.  
  
|||  
|-|-|  
|**Create**|Create a new file type association. If the file name extension in the file type item is registered on the computer, then the new file type association is not created.|  
|**Delete**|Remove an existing file type association. An association exists when the file name extension in the file type item is registered on the computer. No action is performed if the association does not exist.|  
|**Replace**|Delete and recreate the file type association. The net result of the **Replace** action overwrites all existing settings associated with the file type association. If the file type association does not exist, then the **Replace** action creates a new file type association.|  
|**Update**|Modify a file type association. The action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the file type association does not exist, then the **Update** action creates a new file type association.|  
  
#### File type settings  
  
|||  
|-|-|  
|**File extension**|Type the extension of the file to associate with the specified application. Press F3 to display a list of variables from which you can select. **Note:** You do not need to insert the period before the file name extension.|  
|**Associated class**|Choose from the list of registered classes the one you want to associate with the file type. Press F3 to display a list of variables from which you can select.|  
  
#### Configure class settings  
Select **Configure class settings** to configure advanced class settings.  
  
-   To associate a file icon with the file name extension, type the full path in the **Icon file path**. Alternatively, you can Browse **(Ã¢â‚¬Â¦)** to the file location. Browsing to the file location automatically populates the **Icon Index** box.  
  
-   To associate applications for opening, editing, and other actions upon this specific file type, click **New**. Type the name of the command Windows displays on the shortcut menu and the program Windows launches along with any required specifications. Click **OK**.  
  
##### Additional considerations  
  
-   Each subaction configured replaces in full any subaction of the same name that was previously registered under the **Associated** class. Apart from overwriting a subaction, this item does not support removing subactions, or other items in the **Actions** list.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Internet Settings extension  
Group Policy includes the Internet Settings preference extension. For users, this extension allows you to:  
  
-   Require a specific configuration of Internet settings.  
  
-   Configure an initial configuration of Internet settings, but allow end users to make changes.  
  
-   Configure several Internet settings while leaving others to the discretion of each end user. (For example, you can specify proxy server settings while allowing users to modify accessibility options.)  
  
You can create and configure Internet Explorer preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Internet Settings**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
## Local Users and Groups extension  
Group Policy includes the Local Users and Groups preference extension. This extension allows you to centrally manage local users and groups on domain member computers.  
  
You can create and configure Local User and Local Group preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Local Users and Groups**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Local Group item  
Local Group preference items allow you to centrally create, delete, and rename local groups. Also, you can use these preference items to change local group memberships. Before you create a local group preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new Local Group preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Local Users and Groups** node, point to **New**, and select **Local Group**.  
  
4.  In the **New Local Group Properties** dialog box, select an **Action** for Group Policy to perform  
  
5.  Enter local group settings for Group Policy to configure or remove  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether a group with the same name exists.  
  
|||  
|-|-|  
|**Create**|Create a new local group on the local computer. If the local group exists, then do not modify it.|  
|**Delete**|Remove a local group with the matching name from the local computer. The extension performs no action if the group does not exist.|  
|**Replace**|Delete and recreate a local group with the matching name for the local computer. The net result of the **Replace** action overwrites all existing settings associated with the local group. If the local group does not exist, then the **Replace** action creates a new local group. **Important:** Windows assigns each group a security identifier (SID). Windows uses this information to determine if a group is allowed to access a particular resource. Use caution when using the **Replace** action as the newly created group has a new SID. This may prevent groups from having access to resources.|  
|**Update**|Rename or modify settings, including group membership, of an existing group. This action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the local group does not exist, then the **Update** action creates a new local group. **Important:** The **Update** action does not change the SID of the group.|  
  
#### Local Group settings  
  
|||  
|-|-|  
|**Group Name**|Type the name of the targeted local group. The preference extension creates a new group with this name if the group does not exist. If the group exists, the preference extension uses the group with this name as the target of the requested action.|  
|**Rename to:**|Type in the new name of the local group. This option is only available when using the **Update** action. The preference extension renames the group with the name that matches in the **Group Name** box to the name provided in the **Rename to** box.|  
|**Description**|Text used to describe the purpose or use of the local group. Press F3 to display a list of variables from which you can select.|  
|**Add the current user**|Use this setting to include the currently logged on user as a member of the local group. **Note:** This setting is available only when editing the preference item under **User Configuration**.|  
|**Remove the current user**|Use this setting to delete the currently logged on user's membership in the local group. **Note:** This setting is available only when editing the preference item under **User Configuration**.|  
|**Do not configure for the current user**|Use this setting if you do not want the currently logged-on user added to or removed from the local group. **Note:** This setting is available only when editing the preference item under **User Configuration**.|  
|**Delete all member users**|Use this setting to remove all the user accounts that are members of the local group. The preference extension performs this work prior to processing the members list defined in the preference item.|  
|**Delete all member groups**|Use this setting to remove all the group accounts that are members of the local group. The preference extension performs this work prior to processing the members list defined in the preference item.|  
|**Add**|Click **Add** to enter a new member item to the members list.<br /><br /><ul><li>Type the name of the user or group you want to include in the member item, or click Browse **(Ã¢â‚¬Â¦)** to select a user or group.</li><li>Choose from the **Action** list the desired action for the member item:<br /><br /><ul><li>**Add to this group**: Adds the named member to the local group.</li><li>**Remove from this group**: Removes the named member from the local group.</li></ul></li></ul>|  
|**Remove**|Click **Remove** to delete the currently selected member item from the member list.|  
|**Change**|Click **Change** to modify the currently selected member item.<br /><br /><ul><li>Type the name of the user or group you want to include in the member item, or click Browse **(Ã¢â‚¬Â¦)** to select a user or group.</li><li>Choose from the **Action** list the desired action for the member item:<br /><br /><ul><li>**Add to this group**: Adds the named member to the local group.</li><li>**Remove from this group**: Removes the named member from the local group.</li></ul></li></ul>|  
  
##### Additional considerations  
  
-   Group memberships for the current user take effect during the next user logon.  
  
-   The Local Group item action **Replace** deletes the existing local group and creates a new local group, which includes a new security identifier.  
  
-   The Local Group item action **Update** modifies the settings of a local group, but does not change the security identifier of the local group.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
### How to create a Local User item  
Local User preference items allow you to centrally create, delete, and rename local users. Also, you can use this preference item to change local user passwords. Before you create a local user preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new Local User preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Local Users and Groups** node, point to **New**, and select **Local User**.  
  
4.  In the **New Local User** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter local user settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether a user with the same name (or, for built-in accounts, security identifier [SID]) exists.  
  
|||  
|-|-|  
|**Create**|Create a new local user on the local computer. If the local user exists, then do not modify it.|  
|**Delete**|Remove a local user with the matching name from the local computer. The extension performs no action if the local user does not exist.|  
|**Replace**|Delete and recreate a local user with the matching name for the local computer. The net result of the **Replace** action overwrites all existing settings associated with the local user. If the local user does not exist, then the **Replace** action creates a new local user. **Important:** Windows assigns each user a SID. Windows uses this information to determine if a user is allowed to access a particular resource. Use caution when using the **Replace** action as the newly created user has a new SID. This may prevent users from having access to resources.|  
|**Update**|Rename a user or modify user settings. This action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the local user does not exist, then the **Update** action creates a new local user. **Important:** The **Update** action does not change the SID of the user.|  
  
#### Local User settings  
  
|||  
|-|-|  
|**User Name**|Type the name of the targeted local user. The preference extension creates a new user with this name if the user does not exist. If the user exists, the preference extension uses the user with this name as the target of the requested action.|  
|**Rename to:**|Type the new name of the local user. This option is only available when using the **Update** action. The preference extension renames the user with the name that matches in the **User Name** box to the name provided in the **Rename to** box.|  
|**Full name**|Text used to display the full name of the local user. Press F3 to display a list of variables from which you can select.|  
|**Description**|Text used to describe the purpose or use of the local user. Press F3 to display a list of variables from which you can select.|  
|**Password**|Type the password used when creating, replacing, or updating a local user. Type the same password in the **Confirm Password** box **Security Note:** This password is protected by 256-bit Advanced Encryption Standard (AES) encryption and stored as part of the GPO in SYSVOL. This password should be changed on a regular basis and should not be relied on as the sole method of protecting confidential data.|  
|**User must change password at next logon**|Use this setting if you want to force the newly created or updated local user to change their password at their next logon.|  
|**Account is disabled**|Use this setting if you want to disable the newly created or updated local user.|  
|**Account never expires**|Use this setting if you do not want the newly created or updated local user account to expire. Deselect the setting to force the newly created or updated local user account to expire. Then, choose an expiration date from the **Account expires** list.|  
  
##### Additional considerations  
  
-   The Local User item action **Replace** deletes the existing local user and creates a new local user, which includes a new security identifier  
  
-   The Local User item action **Update** modifies the settings of a local user, but does not change the security identifier of the local user.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Network Options extension  
You can create and configure VPN connection and dial-up networking connection preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Network Options**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Dial-Up Connection item  
The Network Options extension allows you to centrally create, modify, and delete dial-up networking and virtual private network (VPN) connections. Before you create a network option preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new Dial-Up Connection preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Network Options** node, point to **New**, and select **Dial-Up Connection**.  
  
4.  On the **Dial-Up Connection** tab, select an **Action** for Group Policy to perform.  
  
5.  Enter dial-up networking connection settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the dial-up networking connection already exists.  
  
|||  
|-|-|  
|**Create**|Create a new network connection. If a connection with the same name exists, then do not modify it.|  
|**Delete**|Remove a network connection with the same name. The extension performs no action if the connection does not exist.|  
|**Replace**|Delete and recreate the network connection. The net result of the **Replace** action overwrites all existing settings associated with the connection. If the connection does not exist, then the **Replace** action creates a new connection.|  
|**Update**|Rename or modify a network connection. The action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the connection does not exist, then the **Update** action creates a new connection.|  
  
#### Dial-up networking connection settings  
  
|||  
|-|-|  
|**User connection**|Use this setting to make the newly created or updated connection visible only to the applied user.|  
|**All users connection**|Use this setting to make the newly created or updated connection visible to all users on the computer.|  
|**Connection Name**|Text used to name the connection. Press F3 to display a list of variables from which you can select. You can import a dial-up networking connection into the Dial-Up Connection preference item. Click Browse **(Ã¢â‚¬Â¦)** to display a list of dial-up connections for the current computer.|  
|**Phone Number**|Text used to indicate the phone number the connection uses. Press F3 to display a list of variables from which you can select.|  
  
##### Additional considerations  
  
-   Dial-Up Connection preference items and VPN Connection preference items are not supported in a Server Core installation of the  Windows ServerÃ‚Â® 2008 R2  or  Windows Server 2008  operating systems.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
### How to create a VPN Connection item  
The Network Options extension allows you to centrally create, modify, and delete dial-up networking and virtual private network (VPN) connections. Before you create a network option preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new VPN Connection preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Network Options** node, point to **New**, and select **VPN Connection**.  
  
4.  In the **New VPN Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter VPN connection settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the VPN connection already exists.  
  
|||  
|-|-|  
|**Create**|Create a new network connection. If the connection with the same name exists, then do not modify it.|  
|**Delete**|Remove a network connection with the same name. The extension performs no action if the connection does not exist.|  
|**Replace**|Delete and recreate the network connection. The net result of the **Replace** action overwrites all existing settings associated with the connection. If the connection does not exist, then the **Replace** action creates a new connection.|  
|**Update**|Rename or modify a network connection. The action differs from **Replace** because it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the connection does not exist, then the **Update** action creates a new connection.|  
  
#### Virtual private network connection settings  
  
|||  
|-|-|  
|**User connection**|Use this setting to make the newly created or updated connection visible only to the applied user.|  
|**All users connection**|Use this setting to make the newly created or updated connection visible to all users on the computer.|  
|**Connection Name**|Text used to name the connection. Press F3 to display a list of variables from which you can select. You can import a virtual private network connection into a virtual private network preference item. Click Browse **(Ã¢â‚¬Â¦)** to display a list of virtual private network connections from the current computer.|  
|**IP Address** or **DNS name**|Type the IP address of the remote computer. Or, select the **Use DNS name** box and type the fully qualified domain name of the remote computer. **Note:** IPv6 addresses are not supported.|  
|**Dial another connection first**|Type the name of the dial-up network connection that this connection established prior to connecting to the virtual private network.|  
|**Show icon in notification area when connected**|Displays an animated icon in the notification area when connected.|  
  
#### Options tab  
Use the **Options** tab to choose dialing and redialing options for the VPN Connection preference item.  
  
#### Security tab  
The **Security** tab provides **Typical** and **Advanced** security settings associated for the VPN Connection preference item. Use these settings to determine password security, data encryption, and authentication protocols.  
  
#### Networking tab  
Use the **Network** tab to choose the type of VPN connection for the preference item.  
  
##### Additional considerations  
  
-   Dial-Up Connection preference items and VPN Connection preference items are not supported in a Server Core installation of the  Windows ServerÃ‚Â® 2008 R2  or  Windows Server 2008  operating systems.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Power Options extension  
You can create and configure Power Plan, Power Options, and Power Scheme preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Power Options**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Power Plan item  
Power Plan preference items configure sleep and display options for managing power consumption.  
  
You configure Power Plan items just as you would configure advanced power settings in **Power Options** in **Control Panel**.  
  
##### To create a new Power Plan preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Power Options** node, point to **New**, and select **Power Plan (Windows Vista and later)**.  
  
4.  In the **New Power Plan (Windows Vista and later) Properties** dialog box, enter power options settings for Group Policy to configure.  
  
5.  Click the **Common** tab and configure any options desired.  
  
6.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the power plan already exists.  
  
|||  
|-|-|  
|**Create**|Create a newly configured power plan. If a power plan with the same name as the Power Plan item exists, then the existing power plan is not changed.|  
|**Delete**|Remove a power plan with the same name as the Power Plan preference item. The extension performs no action if the power plan does not exist. Built-in power plans cannot be deleted.|  
|**Replace**|Delete and re-create the named power plan. The net result of the **Replace** action overwrites all existing settings associated with the power plan. If the power plan does not exist, then the **Replace** action creates a newly configured power plan. Built-in power plans cannot be replaced.|  
|**Update**|Modify a power plan. The action differs from **Replace** because it updates the settings that are defined within the preference item. All other settings remain as they were previously configured. If the power plan does not exist, then the **Update** action creates a new power plan.|  
  
##### Additional considerations  
  
-   If a user Power Plan item processes after a computer Power Plan item, user settings replace the active settings, which may have been made active previously by a computer or user Power Plan item.  
  
-   The local administrator and Power Users administrative group can manually change their power settings by using Control Panel; other users cannot. Regardless, the settings configured for users become active when they log on and remain so even after they log off.  
  
-   Settings that are applied to the computer become active when the computer is started without a logged-on user. However, Power Plan preference items, which support Group Policy background updates, can reset power settings when computer policy is applied without a logged-on user.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Printers extension  
Group Policy includes the Printers preference extension. This extension allows you to create, configure, and delete local, shared, and TCP/IP printers. You can create and configure Printer preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Printers**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Local Printer item  
The Printers preference extension allows you to create, configure, and delete local printers by using the Local Printer preference item. Before you create a Local Printer preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new Local Printer preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Printers** node, point to **New**, and select **Local Printer**.  
  
4.  In the **New Local Printer Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter local printer settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the printer connection already exists.  
  
|||  
|-|-|  
|**Create**|Create a new local printer. If a local printer with the same name exists, then it does not modify it.|  
|**Delete**|Remove a local printer with the same name. The extension performs no action if the local printer does not exist. **Important:** This action does not remove the printer driver. It only removes the local printer.|  
|**Replace**|Delete and recreate the local printer. The net result of the **Replace** action overwrites all existing settings associated with the local printer. If the local printer does not exist, then the **Replace** action creates a new local printer.|  
|**Update**|Rename or modify a local printer. The action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the local printer does not exist, then the **Update** action creates a new local printer.|  
  
#### Local Printer settings  
  
|||  
|-|-|  
|**Connection Name**|Type the name of the targeted local printer. The preference extension creates a new local printer with this name if the local printer does not exist. If the printer exists, the preference extension uses the local printer with this name as the target of the requested action. Press F3 to display a list of variables from which you can select.|  
|**Port**|Choose a local port from the supplied list or type the name of the local port.|  
|**Printer path**|Type or click Browse **(Ã¢â‚¬Â¦)** to choose a fully qualified UNC path of a shared printer connection. The preference extension uses this shared connection as an installation source for the printer driver. The actual printer should be physically connected to the workstation.|  
|**Set this printer as the default printer**|Select this check box to make the local printer the default Windows printer for the current user.|  
|**Location**|Type text to describe where the printer is located. This information appears in the printer's **Location** box. Press F3 to display a list of variables from which you can select.|  
|**Comment**|Type text that provides additional comments about the printer. This information appears in the printer's **Comments** box. Press F3 to display a list of variables from which you can select.|  
  
##### Additional considerations  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
### How to create a Shared Printer item  
  
##### To create a new Shared Printer preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Printers** node, point to **New**, and select **Shared Printer**.  
  
4.  In the **New Shared Printer Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter shared printer settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the printer connection already exists.  
  
|||  
|-|-|  
|**Create**|Create a new shared printer connection. If a local printer with the same name exists, then it does not modify it.|  
|**Delete**|Remove a shared printer connection with the same share path. The extension performs no action if the shared printer connection does not exist. **Important:** This action does not remove the printer driver. It only removes the shared printer connection.|  
|**Replace**|Delete and recreate the shared printer connection. The net result of the **Replace** action overwrites all existing settings associated with the shared printer connection. If the shared printer connection does not exist, then the **Replace** action creates a new shared printer connection.|  
|**Update**|Modify a shared printer connection. The action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the shared printer connection does not exist, then the **Update** action creates a new shared printer connection.|  
  
#### Shared Printer settings  
  
|||  
|-|-|  
|**Share path**|Type or click Browse **(Ã¢â‚¬Â¦)** to choose a fully qualified UNC path of a shared printer.|  
|**Set this printer as the default printer**|Select this check box to make the shared printer connection the default Windows printer for the current user.|  
|**Only if a local printer is not present**|Select this check box to bypass changing the default printer if there is a local printer configured on the computer. This setting is unavailable until you select the **Set this printer as the default printer** check box. **Important:** A local printer is any printer that is not connected to a shared network printer. This includes physical printers connected to parallel, serial, and USB ports, TCP/IP printers, and virtual printers installed through software.|  
|**Delete all shared printer connections**|Select this check box if you want to delete all shared printer connections for the current user. This setting is available only when the preference item's action is set to **Delete**|  
|**Local Port**|Choose a local port to which you want the shared connection mapped. This setting is optional. **Important:** When the **Local Port** box contains a value and the preference item action is set to **Delete**, the preference extension deletes the shared printer connection associated with that local port.|  
|**Reconnect**|Select this check box if you want the shared printer connection persistent. This option is unavailable until you choose a value from the **Local Port** list.|  
|**Unmap all local ports**|Select this check box if you want shared printer connections from all local ports. This setting is available only when the preference item's action is set to **Delete**.|  
  
##### Additional considerations  
  
-   When processing shared printer items, the Printers extension always installs the printer driver in the security context specified on the **Common** tab.  
  
-   Shared Printer items always use the security context of the current user to map printer connections and set the default printer status.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
### How to create a TCP/IP Printer item  
The Printers preference extension allows you to create, configure, and delete TCP/IP printers by using the TCP/IP Printer preference item. Before you create a TCP/IP Printer preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new TCP/IP Printer preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Printers** node, point to **New**, and select **TCP/IP Printer**.  
  
4.  In the **New TCP/IP Printer Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter TCP/IP printer settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the printer connection already exists.  
  
|||  
|-|-|  
|**Create**|Create a new TCP/IP printer connection. If a TCP/IP printer connection with the same IP address exists, then it does not modify it.|  
|**Delete**|Remove a TCP/IP printer connection with the same IP address. The extension performs no action if the TCP/IP printer connection does not exist. **Important:** This action does not remove the printer driver or port. It only removes the TCP/IP printer connection.|  
|**Replace**|Delete and recreate the TCP/IP printer connection. The net result of the **Replace** action overwrites all existing settings associated with the TCP/IP printer connection. If the TCP/IP printer connection does not exist, then the **Replace** action creates a new TCP/IP printer connection.|  
|**Update**|Modify a TCP/IP printer connection. The action differs from **Replace** in that it updates the settings defined within the preference item. All other settings remain as they were previously configured. If the TCP/IP printer connection does not exist, then the **Update** action creates a new TCP/IP printer connection.|  
  
#### TCP/IP Printer settings  
  
|||  
|-|-|  
|**IP Address** or **DNS name**|Type the IP address of the remote printer. Or select the **Use DNS name** check box and type the fully qualified domain name of the remote printer. **Important:** The Printers preference extension uses the TCP/IP address or the DNS Name to determine if a TCP/IP printer exists when a Local Name is not provided. **Note:** IPv6 addresses are not supported.|  
|**Local Name**|Type the local name of the targeted TCP/IP printer connection. The preference extension creates a new TCP/IP printer connection with this name if one does not exist. If a TCP/IP printer connection with this name exists, the preference extension uses the TCP/IP printer with this name as the target of the requested action. Press F3 to display a list of variables from which you can select. **Important:** The Printers preference extension uses Local Name to determine if a TCP/IP printer exists when a Local Name is provided. Otherwise, the preference extension uses the TCP/IP address or the DNS Name to determine if the TCP/IP connection exits.|  
|**Printer path**|Type a fully qualified UNC path or click Browse **(Ã¢â‚¬Â¦)** to choose a fully qualified UNC path of a shared printer connection. The preference extension uses this shared connection as an installation source for the printer driver.|  
|**Set this printer as the default printer**|Select this check box to make the local printer the default Windows printer for the current user.|  
|**Only if a local printer is not present**|Select this check box to bypass changing the default printer if there is a local printer configured on the computer. This setting is unavailable until you select the **Set this printer as the default printer** check box. **Important:** A local printer is any printer that is not connected to a shared network printer. This includes physical printers connected to parallel, serial, and USB ports, TCP/IP printers, and virtual printers installed through software.|  
|**Delete all IP printer connections**|Select this check box if you want to delete all TCP/IP printer connections for the current user. This setting is available only when the preference item's action is set to **Delete**|  
|**Location**|Type text to describe where the printer is located. This information appears in the printer's **Location** box. Press F3 to display a list of variables from which you can select.|  
|**Comment**|Type text that provides additional comments about the printer. This information appears in the printer's **Comments** box. Press F3 to display a list of variables from which you can select.|  
  
#### Port Settings  
Use the **Port Settings** to configure the port settings beyond the standard default settings. The available settings include **Protocol**, **Raw Settings**, **LPR Settings**, and **SNMP Status**.  
  
##### Additional considerations  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Regional Options extension  
You can create and configure Regional Options preference items in any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Regional Options**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Regional Options item  
You configure **Regional Options** just as you would in **Regional and Language Options** in **Control Panel**. Select the **User Locale** on the **Regional Options** tab. This selection resets the values on the remaining tabs; however, you can then modify the remaining values.  
  
> [!NOTE]  
> Unlike other preference extensions, you can only update **Regional Options** preference items. For this reason, the preference item does not provide a choice of actions.  
  
##### To create a new Regional Options preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Regional Options** node, point to **New**, and select **Regional Options**.  
  
4.  In the **New Regional Options Properties** dialog box, enter regional options settings for Group Policy to configure or remove.  
  
5.  Click the **Common** tab and configure any options desired.  
  
6.  Click **OK**. The new preference item appears in the results pane.  
  
#### Additional considerations  
  
-   Settings that are unavailable cannot be enabled or disabled. You cannot configure these settings using a **Regional Options** preference item.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Scheduled Tasks extension  
You can create and configure Scheduled Task or Immediate Task preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
For computers and users, this extension allows you to:  
  
-   Create, modify, or delete a scheduled task.  
  
-   Run a command immediately upon the next refresh of Group Policy or upon every refresh of Group Policy.  
  
-   Automate periodic maintenance, such as virus scans, backups, synchronization, and disk cleanup.  
  
-   Wake computers from standby, and refresh Group Policy to update settings.  
  
-   Launch a process at user logon without running it from a logon script.  
  
**Computer Configuration** or **User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Scheduled Tasks**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to configure a Scheduled Task item  
Scheduled Task preference items let you create, replace, update, and delete tasks and their associated properties. Before you create a Scheduled Task preference item, you should review the behavior of action possible with this extension.  
  
##### To create a new Scheduled Task preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Scheduled Tasks** node, point to **New**, and select **Scheduled Task (Windows Vista and later)**.  
  
4.  In the **New Task (Windows Vista and later) Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter a **Name** for the task to be configured or deleted.  
  
6.  If creating, updating, or replacing a task:  
  
    1.  On the **General** tab, and configure security options for the task.  
  
    2.  Click the **Triggers** tab, and configure when the task begins and with what frequency it runs.  
  
    3.  Click the **Actions** tab, and configure one or more actions for the task to perform, such as starting a program, sending an e-mail, or displaying a message.  
  
    4.  Click the **Conditions** tab, and configure the conditions required for the task to run other than those specified on the **Triggers** tab.  
  
    5.  Click the **Settings** tab, and enter any additional task settings for Group Policy to configure.  
  
7.  Click the **Common** tab and configure any options desired.  
  
8.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the task already exists.  
  
|||  
|-|-|  
|**Create**|Create a new scheduled task for users or computers.|  
|**Delete**|Remove a scheduled task for users or computers.|  
|**Replace**|Delete and re-create scheduled tasks for users or computers. The net result of the **Replace** action is to overwrite all existing settings associated with the task. If the task does not exist, then the **Replace** action creates a new scheduled task.|  
|**Update**|Modify the settings of an existing scheduled task for users or computers. This action differs from **Replace** because it only updates settings that are defined within the preference item. All other settings remain as configured in the task. If the task does not exist, then the **Update** action creates a new scheduled task.|  
  
#### General task settings  
  
> [!NOTE]  
> All text fields accept preference processing variables. Press F3 to display a list of variables from which you can select.  
  
|||  
|-|-|  
|**Name**|Type a name for the task. This name will appear in the list of tasks in **Task Scheduler** under **Administrative Tools**. To change or delete a task, this name must match the name of the existing task as it appears in **Task Scheduler**. Preference items that configure tasks with the same task name can conflict.|  
|**Description**|Type a description of the task. This description is visible for users or computers to which this preference item is applied.|  
|**Security options**|Configure the security context under which the task is run.<br /><br />-   If the preference item is part of **Computer Configuration**, by default the task is run in the security context of the SYSTEM account.<br />-   If the preference item is part of **User Configuration**, by default the task is run in the security context of the logged-on user. Unless you provide credentials, the task is run only if the user is logged on to the computer, but can continue after the user logs off.<br />-   To run a task under the security context of a specified account (regardless of whether that account is logged on), click **Change User or Group**, enter credentials for the account, and then click **Run whether user is logged on or not**. **Security Note:** This password is protected by 256-bit Advanced Encryption Standard (AES) encryption and stored as part of the GPO in SYSVOL. This password should be changed on a regular basis and should not be relied on as the sole method of protecting confidential data.|  
|**Hidden**|Configure whether the task is hidden by default. In **Task Scheduler**, end-users can click **View** and **Show Hidden Tasks** to display hidden tasks.|  
|**Configure for**|You can restrict the options displayed to those that are also available in previous operating systems. Doing this does not configure the task or the preference item to run on earlier operating systems.|  
  
#### Triggers  
If creating, updating, or replacing a task, configure when the task begins and the frequency with which to run the task on the **Triggers** tab. For a task scheduled to run daily, weekly, monthly, or one time only, select the start time at which to begin the task.  
  
Configure any optional scheduling settings desired:  
  
-   To configure a daily, weekly, or monthly task to run only during a specific range of dates, click the **New** button, specify the frequency, enter a **Start** date, select the **Expire** check box, and enter an **End** date.  
  
-   To run the task more frequently than daily, click the **New** button, select **Repeat task every**, and configure the frequency and end time or duration.  
  
-   Select the **Enabled** check box so that the task can run. To configure a trigger without letting it run, clear this check box.  
  
#### Task actions  
  
> [!NOTE]  
> All text fields accept preference processing variables. Press F3 to display a list of variables from which you can select.  
  
A task can start a program, send an e-mail, or display a message. If configuring a task to start a program, on the **Actions** tab click **New**, select **Start a program**, and configure the following options:  
  
|||  
|-|-|  
|**Program/script**|Enter the command to be run, excluding any arguments.|  
|**Add arguments (optional)**|Type any command-line arguments required.|  
|**Start in (optional)**|To specify the working directory for the command being run (typically to ensure the correct resolution of any relative file names), type the working directory used when the task is run. Do not include quotation marks or a trailing slash.|  
  
#### Other task settings  
By configuring options on the **Conditions** tab, you can restrict the conditions under which a task can run or wake the computer to run a task. On the **Settings** tab, you can configure options to manage the behavior of the task upon completion, to manage the behavior of the task if a problem occurs, or to manage the behavior of the task if an instance of the task is already running.  
  
##### Additional considerations  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
### How to configure an Immediate Task (Windows Vista and later) item  
Immediate Task preference items allow you to create tasks to be run immediately upon the refresh of Group Policy that are then removed. Immediate Task preference items do not provide a selection of actions or triggers because they always create a task and then delete it after it has run.  
  
##### To create a new Immediate Task preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Scheduled Tasks** node, point to **New**, and select **Immediate Task (Windows Vista and later)**.  
  
4.  In the **New Task (Windows Vista and later) Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter task settings for Group Policy to configure:  
  
    1.  On the **General** tab, enter a **Name** for the task to be configured, and configure security options for the task.  
  
    2.  Click the **Conditions** tab, and configure the conditions required for the task to run.  
  
    3.  Click the **Settings** tab, and enter any additional task settings for Group Policy to configure.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### General task settings  
  
> [!NOTE]  
> All text fields accept preference processing variables. Press F3 to display a list of variables from which you can select.  
  
|||  
|-|-|  
|**Name**|Type a name for the task. This name will appear in the list of tasks in **Task Scheduler** under **Administrative Tools**. To modify or delete a task, this name must match the name of the existing task as it appears in **Task Scheduler**. Preference items configuring tasks with the same task name can conflict.|  
|**Description**|Type a description of the task. This description is visible for users or computers to which this preference item is applied.|  
|**Security options**|Configure the security context under which the task is run.<br /><br />-   If the preference item is part of **Computer Configuration**, by default the task is run in the security context of the SYSTEM account.<br />-   If the preference item is part of **User Configuration**, by default the task is run in the security context of the logged-on user. Unless you provide credentials, the task is run only if the user is logged on to the computer, but can continue after the user logs off.<br />-   To run a task under the security context of a specified account (regardless of whether that account is logged on), click **Change User or Group**, enter credentials for the account, and then click **Run whether user is logged on or not**. **Security Note:** This password is protected by 256-bit Advanced Encryption Standard (AES) encryption and stored as part of the GPO in SYSVOL. This password should be changed on a regular basis and should not be relied on as the sole method of protecting confidential data.|  
|**Hidden**|Configure whether the task is hidden by default. In **Task Scheduler**, end-users can click **View** and **Show Hidden Tasks** to display hidden tasks.|  
|**Configure for**|For computers that are running  Windows Server 2008 R2 ,  Windows 7 ,  Windows Server 2008 , or Windows Vista, you can restrict the options displayed to those that are also available in earlier operating systems. However, doing this does not configure the task or the preference item to run on earlier operating systems.|  
  
#### Task actions  
  
> [!NOTE]  
> All text fields accept preference processing variables. Press F3 to display a list of variables from which you can select.  
  
A task can start a program, send an e-mail, or display a message. If configuring a task to start a program, on the **Actions** tab click **New**, select **Start a program**, and configure the following options:  
  
|||  
|-|-|  
|**Program/script**|Enter the command to be run, excluding any arguments.|  
|**Add arguments (optional)**|Type any command-line arguments required.|  
|**Start in (optional)**|To specify the working directory for the command being run (typically to ensure the correct resolution of any relative file names), type the working directory used when the task is run. Do not include quotation marks or a trailing slash.|  
  
#### Other task settings  
By configuring options on the **Conditions** tab, you can restrict the conditions under which a task can run or wake the computer to run a task. On the **Settings** tab, you can configure options to manage the behavior of the task upon completion, to manage the behavior of the task if a problem occurs, or to manage the behavior of the task if an instance of the task is already running.  
  
##### Additional considerations  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
### How to configure a Scheduled Task item  
Scheduled Task preference items let you create, replace, update, and delete scheduled tasks and their associated properties. Before you create a Scheduled Task preference item, you should review the behavior of each type of action possible with this extension.  
  
##### To create a new Scheduled Task preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration** or **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Scheduled Tasks** node, point to **New**, and select **Scheduled Task**.  
  
4.  In the **New Scheduled Task Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  On the **Task** tab, enter task settings for Group Policy to configure or remove.  
  
6.  If creating, updating, or replacing a task:  
  
    1.  Click the **Schedule** tab, and configure one or more schedules for the task.  
  
    2.  Click the **Settings** tab, and enter any additional task settings for Group Policy to configure.  
  
7.  Click the **Common** tab and configure any options desired.  
  
8.  Click **OK**. The new preference item appears in the results pane.  
  
#### Actions  
This type of preference item provides a choice of four actions: **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the scheduled task already exists.  
  
|||  
|-|-|  
|**Create**|Create a new scheduled task for users or computers.|  
|**Delete**|Remove a scheduled task for users or computers.|  
|**Replace**|Delete and re-create scheduled tasks for users or computers. The net result of the **Replace** action is to overwrite all existing settings associated with the scheduled task. If the scheduled task does not exist, then the **Replace** action creates a new scheduled task.|  
|**Update**|Modify settings of an existing scheduled task for users or computers. This action differs from **Replace** because it only updates settings that are defined within the preference item. All other settings remain as configured in the scheduled task. If the scheduled task does not exist, then the **Update** action creates a new scheduled task.|  
  
#### Task settings  
  
> [!NOTE]  
> All text fields accept preference processing variables. Press F3 to display a list of variables from which you can select.  
  
|||  
|-|-|  
|**Name**|Type a name for the scheduled task. This name will appear in the list of scheduled tasks in **Control Panel** for users or computers. To modify or delete a task, this name must match the name of the existing task as it appears in **Control Panel** for computers or users. Preference items configuring tasks with the same task name can conflict.|  
|**Run**|Type the command to be run, excluding any arguments.<br /><br />This field is available only if the action selected is **Create**, **Replace**, or **Update**.|  
|**Arguments**|Type any command-line arguments required.<br /><br />This field is available only if the action selected is **Create**, **Replace**, or **Update**.|  
|**Start in**|To specify the working directory for the command being run (typically to ensure the correct resolution of any relative file names), type the working directory used when the task is run. Do not include quotation marks or a trailing slash.<br /><br />This field is available only if the action selected is **Create**, **Replace**, or **Update**.|  
|**Comments**|Type a description of the task. This description is visible for users or computers to which this preference item is applied.<br /><br />This field is available only if the action selected is **Create**, **Replace**, or **Update**.|  
|**Run as**|Configure the security context under which the task is run.<br /><br />-   If the preference item is part of **Computer Configuration**, by default the task is run in the security context of the SYSTEM account.<br />-   If the preference item is part of **User Configuration**, by default the task is run in the security context of the logged-on user. The task is run only if the user is logged on to the computer, but can continue after the user logs off.<br />-   To run a task under the security context of a specified account (enabling the task to run regardless of whether that account is logged on), select the **Run as** check box and enter credentials for the account. **Security Note:** This password is protected by 256-bit Advanced Encryption Standard (AES) encryption and stored as part of the GPO in SYSVOL. This password should be changed on a regular basis and should not be relied on as the sole method of protecting confidential data.<br /><br />These fields are available only if the action selected is **Create**, **Replace**, or **Update**.|  
|**Enabled**|Select this check box so that the task will run. To configure the task for users or computers without letting it run, clear this check box.<br /><br />This check box is available only if the action selected is **Create**, **Replace**, or **Update**.|  
  
#### Schedule settings  
If creating, updating, or replacing a task, configure the frequency with which to run the task on the **Schedule** tab. For a task scheduled to be run daily, weekly, monthly, or one time only, select the start time at which to begin the task.  
  
Configure any optional scheduling settings desired:  
  
-   To let a daily, weekly, or monthly task run only during a specific range of dates, click the **Advanced** button, and select a **Start Date** and **End Date**.  
  
-   To run the task repeatedly, click the **Advanced** button, select **Repeat task**, and configure the frequency and end time or duration.  
  
-   You can configure multiple schedules. To do this, select the **Show multiple schedules** check box. For the first schedule that you want to create, select a frequency, start time, and any advanced options for the task. Click **New** to add another schedule to the list, and then configure settings for it. Any schedule modifications are applied to the schedule currently viewed, but all the schedules are run.  
  
    > [!NOTE]  
    > To return to a single schedule display, delete all except one of the schedules in the list, and then clear the **Show multiple schedules** check box.  
  
#### Other scheduled task settings  
If creating, updating, or replacing a task, configure settings to manage the behavior of the task upon completion, if the computer is being used, or under specific power conditions on the **Settings** tab.  
  
##### Additional considerations  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Services extension  
Group Policy includes the Services preference extension. This extension allows you to configure services presently installed on computers  
  
You can create and configure Service preference items in any domain-based Group Policy Object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**Computer Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Services**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Service item  
The Services preference extension allows you to configure existing services on computers by using a Service preference item. Before you create a Service preference item, you should review the behavior of each type of action possible with the extension.  
  
##### To create a new Service preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **Computer Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Services** node, point to **New**, and select **Service**.  
  
4.  In the **New Service Properties** dialog box, select an **Action** for Group Policy to perform.  
  
5.  Enter service settings for Group Policy to configure or remove.  
  
6.  Click the **Common** tab and configure any options desired.  
  
7.  Click **OK**. The new preference item appears in the results pane.  
  
#### Service actions  
  
|||  
|-|-|  
|**No change**|Using this action does not change the running status of the named service.|  
|**Start service**|Use this action to start the named service. This action has no effect if the named service is running.|  
|**Stop service**|Use this action to stop the named service. This action has no effect if the named service is stopped.|  
|**Restart service**|Use this action to stop and restart the named service.|  
|**Restart service if required**|Use this action to stop and restart the named service if there is a configuration action that requires a restart.|  
  
> [!NOTE]  
> Starting and stopping a service occurs after the preference extension processes all other configuration settings. It is this reason that services cannot be started or restarted if the Startup mode is set to disabled.  
  
#### Service settings  
  
|||  
|-|-|  
|**Startup**|Choose the startup type for the service<br /><br />-   **No change**: Use this setting when you do not want to change the startup type.<br />-   **Automatic**: Use this setting to configure the service to automatically start during the boot and logon process.<br />-   **Disabled**: Use this setting to disable the service. Disabling the service prevents the service from starting.<br />-   **Automatic (Delayed Start)**: Use this setting to configure the service to automatically start during the boot and logon process. The startup of the service is briefly delayed during the logon process to increase logon performance.|  
|**Service name**|Type the unique name for the service, or click Browse **(Ã¢â‚¬Â¦)** to select a service from a list of installed services on the current computer. **Important:** A service's unique name does not always match its display name. For example, the unique name of the *Server* service is *LanmanServer*.|  
|**Wait timeout if service is locked**|Type a timeout value in seconds the preference extension waits to write configuration data, if the service is locked or transitioning from a stop, started, or restarted state,|  
|**Log on as: No change**|Use this setting to keep the service's logon credentials as previously configured.|  
|**Log on as: Local System account**|Use this setting to change the service's logon credentials to the Local System account.|  
|**Allow service to interact with desktop**|Select this check box to allow the service to interact with the desktop. This setting is unavailable until you click the **Local System account** option.|  
|**Log on as: This account**|Use this setting to change the service's logon credentials to a specific local or domain user. **This account** and **Password** settings become available once you click this option.|  
|**This account**|Type or click browse **(Ã¢â‚¬Â¦)** for the user name you are using for the service's logon credentials.|  
|**Password**|Type the password used to authenticate the user. Type the same password in the **Confirm Password** box. **Security Note:** This password is protected by 256-bit Advanced Encryption Standard (AES) encryption and stored as part of the GPO in SYSVOL. This password should be changed on a regular basis and should not be relied on as the sole method of protecting confidential data.|  
  
#### Recovery actions  
Configure how the computer responds if the service fails after one, two, or more attempts.  
  
|||  
|-|-|  
|**No Change**|Use this setting when you do not want to change the recovery action of a service failure. The preference extension does not modify the recovery action when this setting is selected.|  
|**Take No Action**|Use this setting to configure the service not to respond to a failing condition.|  
|**Restart the Service**|Use this setting to configure the service to restart under the failing condition.|  
|**Restart the Computer**|Use this setting to configure the service to restart the computer under the failing condition.|  
  
#### Recovery settings  
  
|||  
|-|-|  
|**Restart fail count after**|Type the number of days that must pass before the service fail count is reset. This setting is available when at least one of the recovery actions is set to any setting other than **No Change**.|  
|**Start service after**|Type the number of minutes that must pass before the failing service is restarted. This setting is available only when at least one of the recovery actions is set to **Restart the Service**.|  
|**Program**|Type the full path for the program you want launched in response to the recovery action **Run a Program**. Or, you can Browse **(Ã¢â‚¬Â¦)** for the application. Use the **Command line parameters** box to provide additional command line arguments for the program. This setting is available only when at least one of the recovery actions is set to **Run a Program**.|  
|**Restart Computer Options**|Click **Restart Computer Options** to set that wait time before restarting a service. Also, you can provide a message to broadcast to network computers to alert users of the pending computer restart.|  
  
##### Additional considerations  
  
-   Use the format **.\username** to specify a local user account on multiple computers.  
  
-   Use the format **domain\username** to specific a domain account.  
  
-   A password is required for all user account names except accounts for which the domain portion of the user credentials begins with NT AUTHORITY.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  
## Start Menu extension  
Group Policy includes the Start Menu preference extension. For users, this extension allows you to:  
  
-   Require a specific configuration of the **Start** menu.  
  
-   Configure an initial configuration of the **Start** menu, but allow end users to make changes.  
  
-   Configure several **Start** menu settings while leaving others to the discretion of each end user.  
  
To add a shortcut to, modify a shortcut on, or remove a shortcut from the **Start** menu, use a Shortcut preference item.  
  
You can create and configure Start Menu preference items for any domain-based Group Policy object (GPO). You configure the settings by editing a GPO using the Group Policy Management Console. When editing a GPO, you can find this preference extension at the following location:  
  
**User Configuration**  
  
**Ã¢â€?â€? Preferences**  
  
**Ã¢â€?â€? Control Panel Settings**  
  
**Ã¢â€?â€? Start Menu**  
  
For information about how to use this extension to create and configure a preference item, see the following topics:  
  
### How to create a Start Menu item  
Start Menu preference items let you update the **Start** menu. Start Menu preference items do not provide a selection of actions because the only possible action is **Update**.  
  
##### To create a new Start Menu preference item  
  
1.  Open the **Group Policy Management Console**. Right-click the Group Policy Object (GPO) that should contain the new preference item, and then click **Edit**.  
  
2.  In the console tree under **User Configuration**, expand the **Preferences** folder, and then expand the **Control Panel Settings** folder.  
  
3.  Right-click the **Start Menu** node, point to **New**, and select **Start Menu (Windows Vista and later)**.  
  
4.  In the **New Start Menu (Windows Vista and later) Properties** dialog box, enter **Start** menu options for Group Policy to configure  
  
5.  Click the **Common** tab and configure any options desired.  
  
6.  Click **OK**. The new preference item appears in the results pane.  
  
#### Additional considerations  
  
-   Settings that are unavailable cannot be enabled or disabled. You cannot configure these settings by using a Start Menu preference item.  
  
-   You can use item-level targeting to change the scope of preference items.  
  
-   Preference items are available only in domain-based GPOs.  
  


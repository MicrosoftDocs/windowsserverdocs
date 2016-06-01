---
title: Drive Map
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3061ddf8-8786-473b-811a-0dd77eb428c7
---
# Drive Map
File servers revolutionized centralized storage of user data.  However, it also introduced usability problems for end users attempting to remember long and complex paths to access their files and folders. IT Professionals resolved that problem by introducing users to Drive Mappings.  Drive maps enable users to simply associate a single drive letter to files and folders that reside on file servers.  Drive maps reduced returned usability back to the end user because it removed the requirement of users remembering long and complex paths to access centralized data.  Now, when a user needs access to their data, they can simply select the H drive from Windows Explorer, which represents the users HOME folder. Or, they can access the S drive for data that is shared among the department or organization.

While mapped drives returned usability to end users, it created complexity for IT professionals.   To facilitate mapped drives for users, IT Professionals created a large and complicated matrix of users who belongs to groups that correlated to specific mapped drives needed by the users.  And, this mess of user\-to\-group\-to\-mapped\-drives complexity was implemented in an elaborate logon script.  This limited the number of IT Professionals that could support and update the script to only those that had scripting knowledge.  Additionally, complex scripts are difficult to troubleshoot and support.  Group Policy Preferences Drive Maps resolve this problem.

## Overview
The Group Policy Preference Drive Map extension enables you to configure mapped drives for an enterprise environment without the need of complicated and cumbersome logon scripts.  The Drive Map preference extensions is configured using the same tools to configure Group Policy; thereby simplifying management to using the Group Policy Management Editor.

## Capabilities
The Group Policy Drive Map extensions provides you with basic drive map needs such as creating, deleting, or replacing drive mappings.  In addition, the drive map extension enables updating labels, and the visibility status of existing drive mappings.  Other capabilities provided by the Group Policy Drive Map extension includes enabling persistent drive mappings and   creating drive mappings using alternate credentials.

You can combine Drive Map preference items with Group Policy Preferences Item\-level targeting to achieve granular and complex drive map scenarios that remain simple, easy to manage, and do not use or require knowledge of scripting languages.

## Configurable Options
![](media/GP_PREF_FIG8.png)

The Group Policy Drive Map preference item user interface provides several choices to help achieve most drive map scenarios that exist in enterprise environments.

## Action \(1\)
The preference item provides a choice of four actions:  **Create**, **Replace**, **Update**, and **Delete**. The behavior of the preference item varies with the action selected and whether the drive letter exists.

1.  **Create**

    Create a new mapped drive for users.

2.  **Delete**

    Remove a mapped drive for users.

3.  **Replace**

    **Delete** and **Create** mapped drives for users. The result of the **Replace** action is to overwrite all existing settings associated with the mapped drive. If the drive mapping does not exist, then the **Replace** action creates a new drive mapping.

4.  **Update**

    Modify settings of an existing mapped drive for users. This action differs from **Replace** in that it only updates settings defined within the preference item. All other settings remain as configured on the mapped drive. If the drive mapping does not exist, then the **Update** action creates a new drive mapping.

## Location \(2\)
To configure a new drive mapping or recreate a drive mapping, type a fully qualified UNC path for the network share \(such as \\\\server\\sharename, \\\\server\\hiddenshare$, or \\\\server\\sharename\\foldername\).  Alternatively, you can use built\-in Group Policy Preference variables by pressing F3 and selecting a variable from the Variable browser.

To modify an existing drive mapping, which are matched by drive letter, leave this field blank.

This option is available only if the action selected is **Create**, **Replace**, or **Update**.

## Reconnect \(3\)
To save this mapped drive in the user's settings and attempt to restore it at each subsequent logon, select this check box. Otherwise, the drive is mapped, but not saved in the user's settings.

This option is available only if the action selected is **Create**, **Replace**, or **Update**.

## Label as \(4\)
To provide a descriptive label that appears next to the drive letter, type the label in this field.  Alternatively, you can use built\-in Group Policy Preference variables by pressing F3 and selecting a variable from the Variable browser.

This option is available only if the action selected is **Create**, **Replace**, or **Update**.

## Drive Letter \(5\)
Select the mapped drives, identified by drive letter, to configure:

To assign the first available drive letter to the mapped drive, select Use first available, starting at, and then select a drive letter at which to begin checking for availability. This option is available only if the action selected is **Create**, **Replace**, or **Update**.

To assign a specific drive letter to the mapped drive, select Use, and then select a drive letter. This option is available only if the action selected is **Create**, **Replace**, or **Update**, and if you have typed a location.

To modify an existing drive mapping \(identified by drive letter\), select **Existing**, and then select a drive letter. This option is available only if the **Location** field is blank, and the action selected is **Update**.

To delete all drive mappings from a particular drive letter onward, select **Delete all, starting at**, and then select a drive letter at which to begin deleting drive mappings. Physical drives are skipped without error. This option is available only if the action selected is **Delete**.

To delete a specific mapped drive, select **Delete**, and then select the drive letter. This option is available only if the action selected is **Delete**.

## Connect as \(6\)
To implement a drive mapping using credentials other than those of the currently logged on user, type the credentials to be used. This option is available only if the action selected is **Create**, **Replace**, or **Update**.

The Group Policy Drive Map management extension stores alternative credentials in the configuration XML file, which is designed to be read by all domain users.  To mitigate storing of passwords in clear text, the management extensions obfuscates the password using a derived Advanced Encryption Standards \(AES\) key.

## Hide\/Show this drive \(7\)
Configure the visibility of the mapped drive:

To keep mapped drive visibility as it is currently configured, select **No change**. This does not take precedence over the **Hide\/Show all drives** setting.

To prevent the drive from being displayed in Windows Explorer, select **Hide this drive**. This takes precedence over the **Hide\/Show all drives** setting.

To allow this drive to be displayed in Windows Explorer, select **Show this drive**. This takes precedence over the **Hide\/Show all drives** setting.

This option is available only if the action selected is **Create**, **Replace**, or **Update**.

You can use a Drive Map preference item to configure the visibility of a physical drive rather than a mapped drive. To do so, select the **Update** action, leave the **Location** field blank, select the drive letter of the physical drive, and then configure the **Hide\/Show this drive** and **Hide\/Show all drives** options.

## Hide\/Show all drives \(8\)
Configure the visibility of all mapped and physical drives in Windows Explorer. The options are comparable to those for **Hide\/Show this drive**, but apply globally to all drives.

Hide\/Show this drive options have precedence over **Hide\/Show all drives**. For example, if a Drive Map preference item has the **Hide\/Show this drive** option set to **Hide this drive** and the **Hide\/Show all drives** option set to **Show all drives**, then all drives are visible except the drive designated as hidden.

## How does it work?
The Group Policy Drive Map preference extension is a Group Policy client side extension that is hosted in the gpprefcl.dll dynamic linked library.  As part of the Group Policy specification, each component of data stored in a Group Policy object must be have two 128\-bit unique identifiers in string format.

### Client\-side and Tool identifiers
The first identifier associates the portion of data stored in the Group Policy object with the entity responsible for consuming, or processing the data. This identifier is known as the client\-side extension identifier.

The second identifier associates the portion of the data stored in the Group Policy object with the entity responsible for authoring, or managing it.  This identifier is known as the snap\-in identifier, or tool identifier.

The client\-side extension unique identifier for the Group Policy Drive Map preference extension is {5794DAFD\-BE60\-433f\-88A2\-1A31939AC01F}.  The snap\-in unique identifier for the Group Policy Drive Map preference extension is {2EA1A81B\-48E5\-45E9\-8BB7\-A6E3AC170006}.

Group Policy uses the client\-side identifier in many locations.  First, the client side identifier is stored in the registry of the local computer.  The Group Policy infrastructure requires registration of all client\-side extensions.  The registry location is

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions

```

The Group Policy infrastructure reads the preceding registry location to discover all Group Policy client\-side extensions on the computer.  Client\-side extensions not listed at this location do not process during the application of Group Policy.  The registration information includes a sub\-key with the client\-side extensions unique identifier as the name.  Several registry values reside beneath the identifier key.   These values are used by the Group Policy infrastructure, but also provide valuable information such as the name of the client side extension \(in the **Default** registry value\), the binary file that hosts the client\-side extension code \(in the **DLLName** registry value\), and the event source and event log the extension uses to report information, warnings, and errors \(in the **EventSources** registry value, separated by a comma, respectively\).

![](media/GP_PREF_FIG9.png)

When a Group Policy object is configured to include data from a specific client side extension, the editor must include the client\-side extension and snap\-in unique identifiers as part of the data saved in the Group Policy object.

Extensions specific data configured to apply to computers is saved to the **gPCMachineExtensionNames** attribute of the Group Policy container object.  Extension specific data configured to apply to users is saved to the **gPCUserExtensionNames** attribute.  If extension specific data is configured to apply to both user and computer, then the editor saves the extension identifier and the snap\-in identifier to both attributes of the Group Policy container object

The **gPCMachineExtensionNames** and the **gPCUserExtensionNames** attribute can hold one or more groups of unique identifiers.  Each identifier group is comprised of an extension identifier followed by one or more snap\-in identifiers.  The group of identifiers are bracketed accordingly by surrounding both identifiers within square brackets \(\[ \]\).

```
extensionID1snapinID1snapinID2…… [ extensionIDnsnapinIDn…]

```

The unique identifier grouping must be listed in ascending alphanumeric order.  Saving these in any other order prevents Group Policy from correctly applying or prevents you from editing existing extensions specific data within the Group Policy object.

Storing the extension identifier and the snap\-in identifiers in the Group Policy object provides hints that optimize Group Policy processing and management.  Processing is optimal because the Group Policy infrastructure knows prior to processing which extensions are required to apply the data hosted in the Group Policy object.  Authoring is optimal because the editor has hints to determine what specific snap\-ins are needed to edit the data.

### XML File Configuration
The Group Policy Drive Map preference extension stores all configuration data associated with the Group Policy object in an XML\-formatted file.  The **Drives.xml** file resides in the **Drives** folder in the Group Policy template that is hosted and shared on all domain controllers’ SYSVOL share.  The Group Policy template location varies for each Group Policy object and is the string value stored in the **gPCFileSysPath** attribute on the Group Policy container object.

```
\\dns_domain_name\Sysvol\dns_domain_name\Policies\group_policy_id

```

### Elements
Group Policy Preference configuration files use two XML elements to describe the configuration data: an outer element and an inner element.  The outer element serves as a logical container of the inner XML elements.  The inner elements represent the configuration of one or more preference items belonging to the container \(outer XML element\).

### Outer Element
The Group Policy Drive Map configuration file uses an outer XML element named **Drives**.  This element serves as a collection of inner elements where each inner element represents a drive map preference item.  The **Drives** outer element supports two attributes:  **clsid** and **disabled**.

### Attributes
The **Drives** outer element of the Group Policy Drive Map configuration file contains one required and one optional attribute.

***Clsid***

The **clsid** attribute is a 128\-bit unique identifier represented as global unique identifier \(GUID\).  The **clsid** value identifies the type of outer element.  The Group Policy Drive Map client\-side extension expects the outer element’s **clsid** value to equal {8FDDCC1A\-0C3C\-43cd\-A6B4\-71A6DF20DA8C}.  This is how the client\-side extension identifies and validates the outer\-element is of type **Drives**.

***Disabled***

The disabled attribute is an optional attribute for the Drives outer element.  The attribute uses a numeric string to represent a Boolean value.  A value of 1 indicates true and a value of 0 indicated false.

A Drives outer element with a disabled attribute equaling true indicates the configuration for all inner elements is disabled.  This prevents the Group Policy Drive Map extension from processing any of the inner elements of the configuration file.   A disabled attribute equaling false indicates the configuration for all inner elements is enabled and that processing continues as normal.

A **Drives** outer element without a **disabled** attribute indicates that the outer element has never been disabled.  In this configuration, the default value for the **disabled** attribute is false, which means the outer element is enabled and processing continues normally.  The **disabled** attribute appears in the configuration the first time the outer element is disabled and remains in the configuration for the remainder configuration files lifetime.  Once in the configuration, the value of the attribute is changed with the respective configuration, but never removed.

### Inner Element
The Drive outer element accepts one type of inner element.  The **Drive** \(non\-plural\) inner element represents a single Drive Map preference item. There can be one or more **Drive** inner elements within the **Drives** outer element.

Each **Drive** inner element contains attributes that describe the inner element.  These attributes are jointly used by management editors and client side extensions as a way to identify one **Drive** inner element from the next.  **Drive** inner element attributes do not contain configuration data.

### Attributes
***ByPassErrors***

The **byPassErrors** attribute is an optional attribute for the **Drive** inner element.  The attribute uses a numeric string to represent a Boolean value.  A value of 1 indicates true and a value of 0 indicates false.

One or more Drive inner element are contained within a single **Drives** outer element, which enables the client\-side extension to process one or more preference items.  A Drive inner element with a byPassErrors attribute equally true indicates the Group Policy Drive Map extension should continue processing the next Drive inner element regardless if the result of the current **Drives** inner element is a failure.  A byPassErrors attribute equaling false indicates the extension should stop processing subsequent **Drive** inner elements if the result of the current **Drive** inner element is a failure.

A **Drive** inner element without a *byPassErrors* attribute indicates that the inner element has never been configured to halt on errors.  In this configuration, the default value for the **byPassErrors** attribute is true, which means the any inner element failure does not halt the processing of subsequent inner elements.  The **byPassErrors** attribute appears in the configuration the first time the inner element is configured to stop on errors.  Once in this configuration, the value of the attribute changes with each respective configuration, but never removed.

***Changed***

The **changed** attribute is an optional attribute for the **Drives** inner element.  The attribute uses a string value to represent the date and time of when the inner element was last modified in UTC.  The string value uses the format of YYYY\-MM\-DD HH:MM:SS.

***Changed***

The **changed** attribute is an optional attribute for the **Drives** inner element.  The attribute uses a string value to represent the date and time of when the inner element was last modified in UTC.  The string value uses the format of YYYY\-MM\-DD HH:MM:SS.

***Clsid***

The **clsid** attribute is a 128\-bit unique identifier represented as global unique identifier \(GUID\).  The **clsid** value identifies the type of inner element.  The Group Policy Drive Map client\-side extension expects each inner element’s **clsid** value to equal {935D1B74\-9CB8\-4e3c\-9914\-7DD559B7A417}.  This is how the client\-side extension identifies and validates the inner element is of type **Drive**

***Disabled***

The **disabled** attribute is an optional attribute for the **Drive** inner element.  The attribute uses a numeric string to represent a Boolean value.  A value of 1 indicates true and a value of 0 indicated false.

A **Drive** inner element with a **disabled** attribute equaling true indicates the configuration for that inner element is disabled.  This prevents the Group Policy Drive Map extension from processing that inner element in the configuration file.   A **disabled** attribute equaling false indicates the configuration for that inner element is enabled and that processing continues as normal.

A **Drive** inner element without a **disabled** attribute indicates that the inner element has never been disabled.  In this configuration, the default value for the **disabled** attribute is false, which means the inner element is enabled and processing continues normally.  The **disabled** attribute appears in the configuration the first time the inner element is disabled and remains in the configuration for the remainder configuration files lifetime.  Once in the configuration, the value of the attribute is changed with the respective configuration, but never removed.

***Image***

The **image** attribute is a numeric string value that represents the index of a bitmap resource used by the Group Policy Management editor as the icon image used to display the preference item in the editor.   The value of the numeric string typically corresponds to the value of the **action** attribute in the **properties** element.

|||
|-|-|
|**Image Value**|**Action Value**|
|0|C|
|1|R|
|2|U|
|3|D|

**Name**

The name attribute is a string value that represents the display name of the preference item. The name attribute has no impact on the processing of the preference item and is strictly used for management and reporting.

***removePolicy***

The **removePolicy** attribute is an optional attribute for the **Drive** inner element.  The attribute uses a numeric string to represent a Boolean value.  A value of 1 indicates true and a value of 0 indicates false.

A **Drive** inner element with a **removePolicy** attribute equaling true indicates the Group Policy Drive Map extension should remove the drive map if the Group Policy object hosting the Drive Map preference item is not within scope of the user.  Once the Group Policy object hosting the Drive map preference item no longer applies to the user, the Group Policy Drive map extension deletes the drive map based on the drive letter criterion.

The **removePolicy** attribute correlates to the value of the **action** attribute in the **Properties** element. A **Drive** inner element with a **removePolicy** attribute equals true requires the value of the **action** attribute of **Properties** element to equal an uppercase R.

A **Drive** inner element with a **removePolicy** attribute equaling false indicates the extension should leave existing mapped drives resulting from a Drive Map preference item configured.

A **Drive** inner element without a **removePolicy** attribute indicates the inner element has been configured to remove when it no longer applies.  In this configuration, the default value for the **removePolicy** attribute is false, which means all map drives resulting from a Drive Map preference item remain configured.  The **removePolicy** attribute appears in the configuration the first time the inner element is configured to remove items when it no longer applies. Once in this configuration, the value of the attribute changes with each respective configuration, but is never removed.

***Status***

The **status** attribute is string value that represents a message that the Group Policy Preference editor can display in the status area of the Microsoft Management Console.  The **status** attribute remains as part of the configuration; however, is no longer being actively implemented.

***Uid***

The **uid** attribute is a 128\-bit identifier represented as global unique identifier \(GUID\).  The **uid** value uniquely identifies each inner element.  This is how the client\-side extension identifies and differentiates each **Drive** inner element.

***UserContext***

The **userContext** attribute is an optional attribute for the **Drive** inner element.  The attribute uses a numeric string to represent a Boolean value.  A value of 1 indicates true and a value of 0 indicates false.

A Drive inner element with a **userContext** attribute equaling true indicates the Group Policy Drive Map extension should create the mapped drive using the security context of the current user.  A **Drive** inner element with a **removePolicy** attribute equaling false indicates the extension should create the mapped drive using the security context of the local system.

A **Drive** inner element without a **userContext** attribute indicates the inner element has been manually configured to apply in the security context of the current user.  In this configuration, the default value varies on a per\-policy basis using the simple guidelines of computer preference items run in the security context of the local system and user preference items run in the security context of the current user.

The **userContext** attribute appears in the configuration the first time the inner element is manually configured to apply using the security context of the current user. Once in this configuration, the value of the attribute changes with each respective configuration, but is never removed.

The **userContext** attribute remains as part of the configuration; however, is no longer being actively implemented.  Most of the Group Policy Preference extensions programmatically switch between the current user and system security contexts as needed, irrespective of the **userContext** attribute value present in the inner element configuration. The recommended configuration is to leave each preference item to the defaults and to not manually configure the security context of any preference item.

```
<Drive clsid="{935D1B74-9CB8-4e3c-9914-7DD559B7A417}" name="Map Drive F:" status="F:" image="2" changed="2013-03-26 14:56:38" uid="{CABDD26A-E1E7-412F-A6B5-CE20F9A8E1D4}">

```

## Properties Element
Each inner element requires a Properties element in the configuration file.  Group Policy Preference extensions read the Properties element for the preference item configuration.

## Attributes
The **Properties** element shares unique and common attributes among all the Group Policy Preferences inner element classes. The common attributes characterize abstract functionality provided by the inner element classes \(preference items\) such as create, delete, or update.  However, the implementation of these actions varies across each inner element.

***Action***

The **action** attribute is an optional, string attribute in the **Properties** element used to describe the action the Group Policy Drive Map extension performs for the associated inner element.  That **action** attribute value is a single, uppercase letter of C, R, U, or D.  If the **action** attribute’s is not present in the **Properties** element then the default value is U.

**Create**

An **action** attribute value equaling an upper case C instructs the Group Policy Drive Map extension to create a new drive mapping using the settings in the current **Drive** inner element.

The create action has two behaviors based on the value in the **useLetter** attribute.  When the **useLetter** value equals 1, the create action creates a new drive mapping only when the current user does not have an active drive letter mapped with a value that matches the value configured in the **letter** attribute.  The newly created drive mapping uses the drive letter value configured in the **letter** attribute.

If the current user has an existing drive mapping using the value configured in the letter attribute then the extension ignores the instruction and does not report error.

When the **useLetter** value equals 0, the create action creates a new drive mapping only when the current user does not have an active drive letter mapped to a file share that matches the value of the **path** attribute.  The newly created drive mapping uses the first available drive letter starting with letter value configured in the **letter** attribute.

If the current user has an existing drive mapping to a file share that matches the value in the path attribute then the extension ignores the instruction and does not report an error.

The create action, after successfully creating the newly mapped drive letter, also sets the drive letters visibility based on the value configured in the **thisDrive** attribute.

**Delete**

An **action** attribute value equaling an upper case D instructs the Group Policy Drive Map extension to remove an existing drive mapping using the settings in the current **Drive** inner element.

The delete action has two behaviors based on the value in the **useLetter** attribute.  When the **useLetter** attribute value equals 1, the delete action removes the mapped drive only when the current user has an active drive letter mapped with a value that matches the value configured in the **letter** attribute.

If the current user does not have an existing drive mapping using the value configured in the letter attribute then the extension ignores the instruction and does not report an error.

When the **useLetter** attribute value equals 0, the delete action removes all existing mapped drives starting with the drive letter that equals the value in the **letter** attribute \(inclusive\) all the way through the letter Z.

The extension skips any drive letter that is not currently mapped to a shared location and does not report errors for these drive letters.  The extension skips drive letters mapped to physical devices, but reports an error when attempting to remove drive letters associated with physical devices.

**Replace**

An **action** attribute value equaling an upper case R instructs the Group Policy Drive Map extension to replace an existing drive mapping with the settings in the current **Drive** inner element.  The replace action instructs the extension to perform the delete action first, and then the create action.  The delete instruction removes an existing mapped drive using the criteria identified in the Delete section of this document.  The create instruction creates a new mapped drive using the criteria identified in the Create section of this document.  The results of the replace action give the perception that the extension overwrote all settings associated with the mapped drive.

**Update**

The **action** attribute value equaling an upper case U instructs the Group Policy Drive Map extension to update an existing drive mapping with the settings configured in the current **Drive** inner element.

The update action has two behaviors based on the value in the **useLetter** attribute.  When the **useLetter** value equals 1, the update action updates the an existing drive mapping only when the current user has an active drive letter mapped with a value that matches the value configured in the **letter** attribute.

If the current user does not have an existing drive mapping using the value configured in the letter attribute then the extension invokes the create action to create a new mapped drive using the settings configured in the current **Drive** inner element.

An empty **path** attribute value causes the extension to report an error when attempting to create a new mapped drive.

A **useLetter** attribute value equaling 0 causes the extension to perform one of two behaviors.  An empty **path** attribute value instructs the extension to perform the update on all existing drive letters starting with the drive letter that equals the value in the **letter** attribute \(inclusive\) and ending with the drive letter Z.

This aspect of the update portion does not skip physical drive letters.  As a result, the update action can change visibly and label options for physical as well as mapped drive letters.

The second possible action from this configuration occurs when the **useLetter** attribute value equals 0 and the **path** attribute value contains a UNC path of remote file share.  This configuration instructs the extension to search through the existing drive letters starting with the drive letter that equals the value in the **letter** attribute \(inclusive\) and perform the update on the drive letter where the drive letter's mapped network location matches the value configured in the **path** attribute.

It is important to understand that the Group Policy Drive Map extension cannot update the Location, Reconnect, or Connect as \(optional\) settings.  Configure the preference item action to Replace to modify these drive map settings.

```
<Properties action="C" path="\\server\share" useLetter="1" letter="F"/>

```

***allDrives***

The **allDrives** attribute is an optional attribute for the **Properties** element used to configure the visibility of all physical and mapped drive letters as they appear in Windows Explorer through the Group Policy Drive Map extension.  The **allDrives** attribute value is string value represented using all upper case characters.  Acceptable values for the **allDrives** attribute include NOCHANGE, HIDE, and SHOW.

The NOCHANGE value instructs the extension not to change drive letter visibility for all the drives of the current user.  Therefore, drive letters visible before the extensions processes remain visible after the extension complete.  The same behavior is observed for hidden drive letters.

The HIDE value instructs the extension to hide all the drive letters for all the drives of the current user.  The results of this configuration hides all drive letters, physical and mapped, from view in Windows Explorer.

The SHOW value instructs the extension to show all the drive letters for all the drivers of the current user.  The results of this configuration displays all drive letters, physical and mapped, in Windows Explorer.

Remember, drive visibility and labels extend beyond mapped drive letters and include physical drive letters.

The **allDrives** attribute when combined with the **thisDrive** attribute by provides varying configuration permutations.  It is important to remember that the **thisDrive** attribute value has precedence over the **allDrives** attribute value, but only for the drive letter configured in the **letter** attribute’s value of the **Properties** element.

The default value for the **allDrives** attribute is NOCHANGE.

***Cpassword***

The cpassword attribute is an optional string attribute in the Properties element used to store a password needed to successfully connect the configured mapped drive.  The attribute value is a string representation of the password that is obfuscated using an AES\-derived encryption key.  The default value for the cpassword attribute is an empty string, or blank.

***Label***

The label attribute is an optional string attribute in the Properties element used to configure a description on the designated mapped drive, which is viewable in Windows Explorer and Windows utilities such as NET.EXE.  The attribute value accepts any alphanumeric or printable symbol characters in either upper or lower case.

***Letter***

The letter attribute is a required attribute in the Properties element that accepts a single upper case alphabetic character value. The extension uses the letter attribute as a reference to a specific drive letter or the beginning point of a range of drive letters. How the extension interprets the letter attribute value depends on the value of the useLetter attribute.

A useLetter attribute value equaling 0 causes the extension to treat the letter attribute value as the beginning letter in a range of upper case letters that stops with the letter Z.  A useLetter attribute value equaling 1 causes the extension to treat the letter attribute value as a single, specific drive letter.

***Path***

The path attribute is a required attribute in the Properties element that accepts a string value Universal Naming Convention \(UNC\) path to a shared network folder.

The create, replace, and update actions use this value as the target network location to which the extension should map the drive letter.

Also, the extension uses the path attribute value as an alternative criterion for the update action when the value of the useLetter attribute equals 0.  Additionally, the value of the path attribute can equal and empty string \(blank\) when the action value equals U.  An empty path attribute value during the update action causes the extension to report an error when the value of useLetter attribute does not equal 1.

***Persistent***

The path attribute is a required attribute in the Properties element that accepts a string value Universal Naming Convention \(UNC\) path to a shared network folder.

The create, replace, and update actions use this value as the target network location to which the extension should map the drive letter.

Also, the extension uses the path attribute value as an alternative criterion for the update action when the value of the useLetter attribute equals 0.  Additionally, the value of the path attribute can equal and empty string \(blank\) when the action value equals U.  An empty path attribute value during the update action causes the extension to report an error when the value of useLetter attribute does not equal 1.

***Persistent***

The persistent attribute is an optional attribute in the Properties element.  The attribute uses a numeric string to represent a Boolean value.  A value equaling 1 indicates true and a value of 0 indicates false.

A Properties element within a Drive inner element with a persistent attribute equaling true indicates the Group Policy Drive Map extension creates the drive mapping to remain persistent between user logons and computer reboots.  Windows remembers the mapped drive and reestablishes the drive mapping on subsequent user logons.

A Properties element within a Drive inner element with a persistent attribute equaling false indicates the Group Policy Drive Map extension creates the drive mapping not to persist between user logons and computer reboots.  Windows does not remember the mapped drive and does not reestablish the drive mapping on subsequent reboots.

It’s important to understand that Windows configures drive persistency at the time it creates the mapped drive.  Therefore, if you want need to use the Replace action if you need to change a mapped drive persistent state.

***Useletter***

The useLetter attribute value is a required attribute for the **Properties** element.  The attribute uses a numeric string to represent a Boolean value.  A value equaling 1 indicates true and a value equaling 0 represents false.

A **useLetter** attribute value equaling false causes the extension to treat the **letter** attribute value as the beginning letter in a range of upper case letters that stops with the letter Z.  A **useLetter** attribute value equaling true causes the extension to treat the letter attribute value as a single, specific drive letter.

***Username***

The username attribute is an optional string attribute in the **Properties** element used to store the domain and username needed to successfully connect the configured mapped drive.

***thisDrive***

The **thisdrive** attribute is an optional attribute for the **Properties** element used to configure the Windows Explorer visibility for the **letter** attribute’s value in the **Properties** element.  The **thisDrives** attribute value is a string value represented using all upper case characters.  Acceptable values for the **thisDrives** attribute included NOCHANGE, HIDE, and SHOW.

The NOCHANGE value instructs the extension not to change configured drive letter’s visibility for the current user.  Therefore, a drive letter visible before the extensions processes and remains visible after the extension completes.  The same behavior is observed for hidden drive letters.

The HIDE value instructs the extension to hide the configured drive letter for the current user.  The results of this configuration hides the configured drive letter, physical or mapped, from view in Windows Explorer.

The SHOW value instructs the extension to show the configured drive letter for current user.  The results of this configuration displays the configured drive letter, physical or mapped, in Windows Explorer.

Remember, drive visibility and labels extend beyond mapped drive letters and include physical drive letters.

The **allDrives** attribute when combined with the **thisDrive** attribute by provides varying configuration permutations.  It is important to remember that the **thisDrive** attribute value has precedence over the **allDrives** attribute value, but only for the drive letter configured in the **letter** attribute’s value of the **Properties** element.

The default value for the **thisDrives** attribute is NOCHANGE.

```
<Drives clsid="{8FDDCC1A-0C3C-43cd-A6B4-71A6DF20DA8C}" disabled="0">
<Drive clsid="{935D1B74-9CB8-4e3c-9914-7DD559B7A417}" name="F:" status="F:" image="0" changed="2013-04-04 16:48:16" uid="{B225E3B9-C639-4AA3-AB79-CB65D626CF9A}">
 <Properties action="C" thisDrive="NOCHANGE" allDrives="NOCHANGE" userName="" path="\\server\share" label="" persistent="0" useLetter="1" letter="F"/>
 </Drive>
<Drive clsid="{935D1B74-9CB8-4e3c-9914-7DD559B7A417}" name="G:" status="G:" image="2" changed="2013-03-26 14:56:38" uid="{CABDD26A-E1E7-412F-A6B5-CE20F9A8E1D4}">
 <Properties action="U" thisDrive="NOCHANGE" allDrives="NOCHANGE" userName="" path="\\server\share" label="" persistent="0" useLetter="1" letter="G"/>
 </Drive>
<Drive clsid="{935D1B74-9CB8-4e3c-9914-7DD559B7A417}" name="H:" status="H:" image="1" changed="2013-04-04 16:48:40" uid="{94BCBDAE-E11C-4C3A-9E05-CE1B416C1759}" disabled="0">
 <Properties action="R" thisDrive="NOCHANGE" allDrives="NOCHANGE" userName="" path="\\server\share" label="" persistent="0" useLetter="1" letter="H"/>
 </Drives>

```

Evaluation of XML

The extension reads the entire XML file into memory subsequently processes each element in the XML file starting with the outer element.  The outer element defines the overarching class of preference items that appear in the inner elements of the file.  Additionally, the outer element may contain the disabled attribute.  A disabled attribute value equaling 1 in the outer element stop any further evaluation of the XML, effectively preventing all of the Drive inner elements from processing \(applying to the user\).

After reading the Drives element, the extension focuses its attention to the next element in the XML file—one of possibly many Drive inner element.  As noted in the attribute section of this document, the Drive inner element contains metadata and processing control information used be the Group Policy management snap\-ins and the client\-side extensions.

The extension reads the attributes and values from the entire Drive inner element, which includes the attributes and values of the Drive element, the attributes and values of the Properties element and the attributes and values of an optional Filters element along with all its child elements and their attributes and values.

A Drive inner element containing a disabled attribute equaling 1 stops the extension from processing this element \(applying to the user\) and the extension moves its focus to the next Drive inner element.

The extension continues processing the current Drive inner element when it does not contain a disabled attribute or when it contains a disabled attribute with a value equaling 0.

Next, the extension moves its focus on the Filter element of the Drive inner element.

The Filters element holds Item\-level targeting information that the extension uses as additional criteria to determine if the associated preference items \(Mapped Drives\) should apply to the user or computer.

The Filters element contains attributes, values and child elements that represent of sophisticated set of Boolean rules.  The details of the Filters element are beyond the scope of this portion of the document.  In this context, all that is needed to know is a Filter element, when evaluated by an extension, only returns true or false.

When present, the extension reads the entire Filters element and evaluates each Boolean expression included in the section.   The evaluation of the Filters element can only result in a true or false response.  A filter evaluation result equaling false means the one or more Boolean expressions in the Filters element evaluated to false.  The false evaluation forces the extension to stop any further processing of the current Drive inner element and moves focus to the next Drive inner element.

A Drive inner element that does not contains a Filters inner element or an inner element containing a Filters inner element that evaluates to true moves its focus to the Properties element, which is the next element within the Drive inner element.

The Properties element within a Drive inner element contains all the Drive Map configuration information the extension needs to create, replace, update, or delete a mapped drive.  The Group Policy Drive Map extension reads the attributes and values and performs the requested instructions and determines if the actions performed were successful.

If the actions performed were unsuccessful \(an error occurred\), the extension checks the bypassErrors attribute value read from the current Drive inner element.  A false value \(zero \[0\]\) instructs the extension to discontinue further processing of all Drive inner elements while a true value \(one \[1\]\) instructs the extension to ignore the unsuccessful result and continue processing additional Drive inner elements.

The extension then moves its focus to the next Drive inner element and the process repeats until the XML file reaches the Drives closing outer element.

![](media/GP_PREF_FIG10.png)

## Xml to User Interface mapping
The Group Policy Drive Map management snap\-in determines the values and attributes stored in the XML configuration. The following figures correlate which components of the user interface control or shows the various elements and attributes in the XML file.

![](media/GP_PREF_FIG11.png)

![](media/GP_PREF_FIG12.png)

![](media/GP_PREF_FIG13.png)

## CSE Processing
Group Policy client side extensions enable Group Policy to process a variety of different tasks because each client side extension is responsible for processing its portion of data stored in a Group Policy object.

The Group Policy Drive Maps client side extension is one of many extensions included in the gpprefcl.dll file that is included in the Windows operating system starting with Windows Server 2008 and Windows Vista Service Pack 1.

Group Policy’s modular design enables each extension to process the data that is relevant to them.  Therefore, the implementation of each Group Policy client side extension may be different.

The Group Policy Drive Map extension is one CSE in a family of Group Policy client side extensions known as Group Policy Preferences.  The goal of this extension is to manage drive letters associated with network specific shared folders and visibility properties of driver letters \(remotely mapped drives or physical\).   The extension comes registered on the Windows operating system by virtue of CSE specific metadata stored in the following registry location

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{5794DAFD-BE60-433f-88A2-1A31939AC01F}

```

The information stored in this location is consistent on all computers.  Therefore, restoring the information on a computer where it is missing is relatively easy using the export and import feature of the Registry editor.

## Startup
The Group Policy service invokes this client side extension when it encounters a Group Policy object configured with Group Policy Drive maps.  When activated, the extension must locate its configuration file.

### Prerequisite information
When Group Policy invokes the client side extension, it provides to the extension information that enables it to process its portion of Group Policy.  This information includes operational information that describes the current processing context such as if the processing is background or foreground, is the processing occurring over a slow link, or is the processing for the computer rather than the user.   Also included in this information is a list of the Group Policy objects that were removed from the scope of application and the list of Group Policy objects that were changed.

Each entry in the list of Group Policy objects provides to the client side extension provides information about the Group Policy object in question.  The entry includes the information in  REF \_Ref355711892 \\h Table 2.

|||
|-|-|
|**Field**|**Description**|
|Options|Client side extensions use the options field to determine if the Group Policy object is disabled or if the Group Policy object is|
|Version|The Group Policy object version number increments with saved changes to the computer and user portions of a GPO, respectively.  Client side extensions can use the version number to determine if any changes were made to the computer or user portion of a GPO.|
|DSPath|The DS path provides the LDAP path, which provides the location and common name of the Group Policy object in Active Directory.  Remember, the common name of a GPO is its unique identifier; not its display name.|
|File system path|The file system path provides the root location of the files associated with the Group Policy object.  These collection of files typically are used by one or more client side extensions as the data store for group policy settings.|
|Link Path|The link path field provides an LDAP path of the container to which the Group Policy is linked|
|Link Type|The link type field provides information about the container to which the GPO is linked such as computer, site, domain, or organizational unit.|
|Extensions|The extension field provides a list of the extensions that are configured in the Group Policy object.|
|Display name|The display name is the name of the GPO that is displayed in user interfaces and reporting tools.|

The information in  REF \_Ref355711892 \\h Table 2 is present for each GPO in both lists.  The out\-of\-scope list contains a list of GPOs that applied to the user or computer on the last application of Group Policy but no longer apply on this application of Group Policy.  The list of changed list contains a list of GPOs that include changes for one or more aspects of the Group Policy object.

The extension reads the operational information to understand what type of Group Policy processing Windows is performing: user or computer.  How the processing is occurring: foreground or background. This enables the client side extensions to make operational decisions based on this processing characteristics.

The extension uses the lists of Group Policy objects to complete its portion of Group Policy processing.  The Group Policy Drive Maps extension starts by processing each of the GPOs in the out\-of\-scope list.

## Out\-of\-Scope Group Policy objects
The Group Policy Drives Maps processes the entire list of out\-of\-scope GPOs sequentially.  The extension logs any errors reading the Group Policy objects and continues processing until it reaches the end of the list.

The extension cycles through the list of Group Policy objects in the list starting with the first entry in the list.  The extension collects the prerequisite information about the current GPO.  From this information and its own information, the extension builds file path location to the configuration file.  The configuration file location path begins with the extensions history path.

### Group Policy Preference History
The history path is a local data store of the last successfully applied data configuration files for each Group Policy object.  The extension saves the last applied configuration files in the user’s local application folder, which holds a value equivalent to the environment variable %LOCALAPPDATA% on Windows 8 and Windows Server 2012.  The root of the history folder looks similar to

```
C:\users\[username]\AppData\Local\Microsoft\Group Policy\History

```

Windows protects the history folder with the hidden attribute; therefore, by default, it is not visible from Windows Explorer or from the command line.  The history folder contains sub folders, where each folder is named to the globally unique identifier \(GUID\) of a corresponding Group Policy object.

![](media/GP_PREF_FIG14.png)

Each Group Policy object folder within the history folder contains sub folders where each folder is named to a corresponding security identifier \(SID\) of a user who has logged on to the current computer.  The complete path to the history file for the Group Policy Drive Maps extension is

```
C:\users\[username]\AppData\Local\Microsoft\Group Policy\History\[GUID]\SID\Preferences\Drives\Drives.xml

```

The extension then concatenates the string \\User\\Preferences\\Drives\\Drives.xml to the end of the GPO’s file system path.  This creates a full path, including file name, to the configuration file.

> [!NOTE]
> Windows only allows the configuration and application of Group Policy Drives Map to users.

The extensions opens this file and reads the entire contents of the file into memory and then closes the file.  The CSE logs any errors occurring that may occur with the file operations and moves to the next GPO in the list.

## Configuration File
The configuration file contains an outer element with multiple inner elements where each inner element represents a separate drive map preference item.  Each inner element includes a Properties element that holds the respective elements configuration information.

The extension begins by settings its focus on the first inner element.  The extension scans the current inner element for the removePolicy attribute.  An inner element without a removePolicy attribute or an inner element with a removePolicy attribute value equaling false \(zero \[0\]\) causes the extension to move to the next inner element.

An inner element with a removePolicy attribute equaling true \(one \[1\]\) indicates to the extension that it must remove the settings in the current inner element.  The extension uses the settings from the current inner element and its associated Properties element to undo, or remove the settings.  The extension accomplish this by forcing the processing to use the Remove action regardless of the action configured in the current inner element and continues this cycle until it has processed all inner elements in the configuration file.  Once processing of all inner elements is complete, the extension deletes the \\Drives\\Drives.xml folder and file for the specific user and GPO from the local history.

The extension then moves to the next Group Policy object in the list and processes it in the same fashion until it has processed all GPOs in the out\-of\-scope list.  The extension begins processing the new and changed GPO list.

## New and Changed Group Policy objects
The Group Policy Drives Maps processes the entire list of new and changed GPOs sequentially.  The extension logs any errors reading the Group Policy objects and continues processing until it reaches the end of the list.

The extension cycles through the list of Group Policy objects in the list starting with the first entry in the list.  The extension collects the prerequisite information about the current GPO.  From this information, the extension builds file path location to the configuration file.  The configuration file location path begins with the GPO’s file system path.  The extension then concatenates the string \\User\\Preferences\\Drives\\Drives.xml to the end of the GPO’s file system path.  This creates a full path, including file name, to the configuration file.

> [!NOTE]
> Windows only allows the configuration and application of Group Policy Drives Map to users.

### Configuration File
The extension reads the entire configuration file into memory.  The configuration file contains an outer element with multiple inner elements where each inner element represents a separate drive map preference item.  Each inner element includes a Properties element that holds the respective elements configuration information.

### Outer Element Processing
The extension evaluates the outer element for the disabled attribute.  An outer element with a disabled attribute equaling true \(one \[1\]\) indicates the all inner elements are considered disabled. The extension discontinues processing any part of the current configuration and moves to the next Group Policy object in the list.  An outer element without a disabled attribute or with a disabled attribute value equaling false \(zero \[0\]\) continues processing by evaluating the inner elements,

### Inner Element Processing
The extension begins by settings its focus on the first inner element. The extension evaluates the current inner element for the disabled attribute.  An inner element with a disabled attribute equaling true \(one \[1\]\) indicates the inner element is disabled.  The extension discontinues processing the current inner element and move to the next inner element.  An inner element without a disabled attribute or inner element with a disabled attribute value equaling false \(zero \[0\]\) continues evaluating the inner element for item\-level targeting information.

***Item\-level Targeting Processing***

The extension scans the current inner element for a Filters element.  The Filters element is an optional element that holds the item\-level targeting configuration information for each inner element.  A Filters element existing within the inner element indicates the extension must evaluate one or more Boolean criteria before processing the inner element configuration.  A false result from a Filters evaluation forces the extension to ignore the current inner element and move to the next inner element.  A true result from a Filters evaluation indicates the extension should continue processing the inner element and action configured within the current element.

## Action Processing
Action processing occurs once the client side extension has evaluated all other criteria that would instruct it to bypass processing outer or the current inner element.  Action processing correlates to the action configured in each inner element \(reminder an inner element represents a single preference item\).  The four actions the Group Policy Drive Map extension can process are create, replace, update, and delete.

### Create
The create actions represents a configuration where the extension creates a new mapped drive based on the configuration in the current inner element.

***Prologue***

The extension extracts the values for the <path>, <letter>, <persistent>, <username>, and <cPassword> attributes from the configuration information. If the <cPassword> attribute contains a value, then the extension reverse\-obfuscates the password into its clear text equivalent.   The extension continues extracting the values for the <allDrives>, <thisDrive>, and <useLetter> attributes.  The extension completes the prologue portion of the processing by impersonating the user logging on the computer using the user’s full authentication token.  Any failure attempting the impersonation results in the extension aborting its processing and to return the underlying error code that resulted in the impersonation failure.

***Core***

The core phase of create action processing is to use the configuration information read during the prologue phase to create a mapped network drive for the current user.

**Specific Drive Letter**

The extension checks if the value of the <useLetter> attribute equals true \(one \[1\]\).  A true value determines the desired configuration is for a specific drive letter.

The extensions starts by ensure the drive letter is normalized in all lower case and that its syntax matches \[driveLetter:\].  Any failures encountered during normalization cause the extension to abort and to return an invalid argument error.

The extension then uses the Windows API WNetGetConnection to determine if the value <letter> is currently used by an existing mapped network drive or by a physical device such as a hard drive, CD\-ROM\/DVD\-ROM, ram disk or removable drive.

A <letter> value that currently exists for the user but is not a mapped drive or not considered a physical device causes the extension to abort its process and to return unexpected error.  A <letter> value that currently exists for the user that is either mapped to a shared network folder or associated with a physical device causes the extension to abort its processing and to return an object name exists error.

*Create Mapped Network Drive*

The extension determines if the current user’s token is not a restricted token and the <persistent> attribute value equals false \(zero \[0\]\). Upon validating these factors, the extension uses the WNetUseConnection API to create a newly mapped drive using the value of the <letter> attribute as the drive letter.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response from the Windows API instructs the extension to abort its processing and to return the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log.

If the extension determines the current user’s token is a restricted token \(User Account Control is enabled\) then the extension must create the mapped drive under the restricted token rather than the full token.  This explains why mapped drives for administrators and some users are not always visible in Windows Explorer.

The extension stops impersonating the current user with the user’s full token and requests Windows to provide a restricted token for the user.  Any failure in the cessation of impersonation instructs the extension to abort its processing, write “Failed to revert from the user’s full token” to the trace log, and return the underlying error code that is the result of failure to cease impersonation.  Any failure in requesting a restricted token for the current user instructs the extension to abort its processing, write “Failed to impersonate with user’s restricted token” to the trace log, and return the underlying error code that is the result of the failure to impersonate using the restricted token.

While impersonating the user using the restricted token, the extension use the WNetUseConnnection API to create a new mapped drive where the drive letter used is the value of the <letter> attribute.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response instructs the extension to abort its processing, write “Failed to connect drive with restricted token” along with the underlying error code it received from the Windows API to the trace log.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log. Then, the extension discontinues impersonating the current user under the restricted token and returns impersonating the user using the full token.

A failure reverting from impersonating the user with a restricted token causes the extension to write “Failed to revert user from restricted context” to the trace log.  A failure impersonating the user with their full token causes the extension to write “Failed to impersonate with user’s full token” to the trace log.  The extension continues processing by applying the configured label to the newly created mapped drive.

**First Available Drive Letter, Starting at**

A <useletter> attribute value equaling false \(zero \[0\]\) determines the desired configuration is to create a map drive using the first available letter starting with the <letter> attribute value.

*Determine the First Available Drive Letter*

The extension needs to determine the first available drive letter before it can map any network location.  To accomplish this, the extensions creates a list of lower case letters starting with the <letter> attribute’s value and ending with the letter ‘z’.  The extension then iterates through each letter in the list of letter to determine the first available drive letter, starting with the <letter> attribute’s value.

The extension determines a letter qualifies as available first by using the WNetGetConnection API to determine if the current letter in the list of letters is mapped to a network drive or associated with a physical device.

*Drive Letter not in use*

A drive letter not mapped to a shared folder instructs the extension to check if a previously available drive letter was already saved.  If the extension already knows of the first available drive letter, than it performs no other actions on the current drive letter and starts the evaluation over again using the next letter in the list.  If the extension is unaware of any previously saved available drive letter, then ensures the current letter is not associated with a physical device.  A drive letter associated with a physical device is not eligible as an available drive letter.  The extension performs no other actions on the current drive letter and starts the evaluation over again using the next letter in the list.  A drive letter making to this part of the process has passed all the criteria needed to become the first available drive letter.

*Drive Letter in use by a Mapped Drive*

A drive letter mapped to a shared folder instructs the extension to evaluate the shared folder location of the existing mapped drive to the <path> attribute’s value in the inner element configuration.

If the shared folder path matches the <path> attribute value, then the extension considers the mapped drive already successfully created.  The extension writes “Path is connected already on letter” along with the current drive letter to the trace log, discontinues iterating the drive letters, and proceeds to the Drive Label portion of the core processing phase.

If the shared folder path does not match the <path> attribute value, then the extension considers the current drive letter unavailable.  The extension performs no other actions on the current drive letter and starts the evaluation over again using the next letter in the list.

The extension completes its iteration through the drive letter list and validates a free drive letter exits.  If the extension remains unaware of an available drive letter and it did not locate an existing drive letter mapped to the network path identical to the <path> attribute value, then the extension aborts its processing, and returns a not connected error.  Otherwise, the extension is aware of an available drive letter and must now connect the shared network folder to the available drive letter.

*Connecting to First Available Drive*

The extension must create a new mapped drive using the discovered first available drive letter and the <path> attribute’s value.  To do this, the extension determines the type of token used by the current user and the value of the <persistent> attribute.

If the user has a full token or if the <persistent> attribute equals false \(zero \[1\]\), then the extension use the WNetUseConnection API to create a new mapped drive where the drive letter used is the discovered first available drive letter.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value, which is false, is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

If the user has a full token or if the <persistent> attribute equals false \(zero \[1\]\), then the extension use the WNetUseConnection API to create a new mapped drive where the drive letter used is the discovered first available drive letter.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value, which is false, is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response from the Windows API instructs the extension to abort its processing and return the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log.

A user with a restricted token \(User Account Control enabled\) indicates to the extension that it must also create the new drive mapping while impersonating the user using the user’s restricted token.

The extension stops impersonating the current user with the user’s full token and requests Windows to provide a restricted token for the user.  Any failure in the cessation of impersonation instructs the extension to abort its processing, write “Failed to revert from the user’s full token” to the trace log, and return the underlying error code that is the result of failure to cease impersonation.

Any failure in requesting a restricted token for the current user instructs the extension to abort its processing and to return the underlying error code that is the result of the failure to when requesting the restricted token.

A failure occurring when extension impersonates the user using the restricted token cause the extension to abort its processing, write “Failed to impersonate with user’s restricted token” to the trace log, and return the underlying error code that is the result of the failure to impersonate using the restricted token.

While impersonating the user using the restricted token, the extension use the WNetUseConnnection API to create a new mapped drive where the drive letter used is the value of the <letter> attribute.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response instructs the extension to abort its processing, write “Failed to connect drive with restricted token” to the trace log along with the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log. Then, the extension discontinues impersonating the current user under the restricted token and returns impersonating the user using the full token.

A failure reverting from impersonating the user with a restricted token cases the extension to write “Failed to revert user from restricted context” to the trace log.  A failure impersonating the user with their full token causes the extension to write “Failed to impersonate with user’s full token” to the trace log.  The extension continues processing by applying the configured label to the newly created mapped drive.

**Drive Label**

To this point in the process, the extension has successfully created a mapped network drive using either a specific drive letter or a first available drive letter.   And, the extension has mapped the drive using the user’s full token and restricted token, if needed.

The extension needs to apply the <label> attribute value to the newly created drive letter.  The extension ensures a value is present for the <label> attribute and that the mapped drive was newly created and not an existing local or remote drive letter.  Once the extensions confirms these conditions, it replaces any backslash \(\\\) characters in the <path> attribute’s value with pounds \(\#\) characters.  Next, the extension creates a registry key using the modified <path> value under

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Mountpoints2

```

The extension creates a new registry value named \_LabelFromReg.  The value assigned to \_LabelFromReg is original, unmodified <path> attribute value.  The extension ignores any failures that may occurs during drive label processing.

**Hide or Show Drives**

The Group Policy Drive Map extension can show or hide drives using two configurations.  It can hide or show a single, specified drive letter and it can hide or show all drive letters.  The extension processes all drives first and specified drive last.  Thus, the outcome of configuring both results in the specified drive configuration have precedence over the all drives configuration.

The extension determines if it needs to show or hide any drive letters by checking the <thisDrive> and <AllDrives> attribute values.  If both attribute values equal “NOCHANGE’ then the extension performs no other actions and processes the epilog portion of core processing. Otherwise, the extension begins the hide or show drives process by changing to the security context to System.   Any failure in changing to System security context causes the extension to abort its processing and return the underlying error responsible for the failure.

*All Drives*

The extension determines if it needs to hide or show all drive letters by evaluating the value of the <AllDrives> attribute.  If the attribute’s value equals “SHOW” then the extension deletes the NoDrives registry value from the following registry hive of the current user.

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

```

If the attribute’s value equals “HIDE” then the extension writes the hexadecimal value 0x03FFFFFF to the NoDrives registry value of the previously mentioned registry hive of the current user \(the extension creates the NoDrives registry value if it does not exist\).  The extension then processes hide or show settings for a specific drive letter.

*Specified Drive*

The extension validates that the <thisDrive> attribute equals “SHOW” or “HIDE”.  Next, the extension validates the <letter> attribute value is not blank.  If the <letter> attribute value is blank, then the extension aborts its processing and returns an invalid argument error.

The extension retrieves the NoDrives registry value from the following registry hive of the current user

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

```

The extension uses an algorithm based on information in Microsoft Knowledgebase article 231289, Using Group Policy Objects to hide specified drives, to determine equivalent bit value of the <letter> attribute value.

If the <thisDrive> attribute value equals “HIDE” then the extension enables that bit in the NoDrives registry value.  If the <thisDrive> attribute value equals “SHOW” then the extension disabled the bit in the NoDrives registry value.

After modifying the NoDrives registry value, the extension checks its value to ensure it does not equal zero \(0\).  If the newly calculated NoDrives registry value equals zero, then the extension deletes the NoDrives registry value.  Otherwise, the extension saves the newly calculated NoDrives registry value to the registry.

***Epilogue***

The extension completes the processing by updating its %LastDriveMapped% environment variable and by securely deleting the clear text instance of the <cPassword> attribute value.  Additionally, if the <persistent> attribute value equals true \(one \[1\]\), then the extension signals to the Group Policy infrastructure that the next foreground processing must be synchronous.

Create action processing is complete.  The extension moves to the next inner element \(preference item\) and begins inner element processing on the new, current inner element.

### Delete
The delete action represents a configuration where the extension deletes all mapped   drives or a specific mapped drive based on the configuration in the current inner element.

***Prologue***

The extension extracts the values for the <path>, <letter>, <persistent>, <username>, and <cPassword> attributes from the configuration information. If the <cPassword> attribute contains a value, then the extension reverse\-obfuscates the password into its clear text equivalent.   The extension continues extracting the values for the <allDrives>, <thisDrive>, and <useLetter> attributes.  The extension completes the prologue portion of the processing by impersonating the user logging on the computer using the user’s full authentication token.  Any failure attempting the impersonation results in the extension aborting its processing and to return the underlying error code that resulted in the impersonation failure.

***Core***

The core phase of delete action processing is to use the configuration information read during the prologue phase to identify and delete a specific mapped drive, or to delete all mapped drives starting with a specific drive letter for the current user.

*Specific Drive Letter*

The extension checks if the value of the <useLetter> attribute equals true \(one \[1\]\).  A true value determines the desired configuration is for a specific drive letter.

The extensions starts by ensure the drive letter is normalized in all lower case and that its syntax matches \[driveLetter:\].  Any failures encountered during normalization cause the extension to abort and to return an invalid argument error.

A <letter> value that currently exists for the user but is not a mapped drive or not considered a physical device causes the extension to abort its process and to return unexpected error.

A <letter> value that currently exists for the user and is associated with a physical device cause the extension to abort its processing and return an already assigned error.

*Delete Mapped Drive*

A <letter> value that currently exists for the user and is remotely connected to a network share causes the extension to use the Windows API WNetCancelConnection2 to remove the connection and its persistent state from the user’s session.

If the Windows API failed to delete the mapped drive, then the extension aborts its processing and returns the underlying error it received from the Windows API.  A successful response from the Windows API causes the extension to proceed to the epilog phase.

*Delete All, Starting at*

A <useletter> attribute value equaling false \(zero \[0\]\) determines the desired configuration is to delete all mapped drives starting with starting with the <letter> attribute value.

The extensions creates a list of lower case letters starting with the <letter> attribute value and ending with the letter ‘z’.  The extension iterates through each letter in the list to determine if the drive is mapped to a shared network folder using the WNetGetConnection Windows API.

If the extension determines the current drive letter is not mapped to a shared network folder, then it completes the current iteration and begins a new integration using the next drive letter in the list as the current drive letter.

If the extension determines the current drive letter is mapped to a shared network folder, then it uses the Windows API WNetCancelConnection2 to delete the connection and its persistent state from the user session.  The extension then completes the current iteration and begins a new iteration using the next drive letter in the list as the current drive letter.

This cycles completes until the extension has evaluated all drive letters starting with the <letter> attribute value through the letter ‘z’. The extension then proceeds to the epilogue phase.

***Epilogue***

The extension completes the processing by securely deleting the clear text instance of the <cPassword> attribute value.  Additionally, if the <persistent> attribute value equals true \(one \[1\]\), then the extension signals to the Group Policy infrastructure that the next foreground processing must be synchronous.

Delete action processing is complete.  The extension moves to the next inner element \(preference item\) and begins inner element processing on the new, current inner element.

### Replace
The replace action represents a configuration where the extension replaces a new mapped drive with a new mapped drive based on the configuration in the current inner element.

It is important to understand the difference between replace and update.  The replace action typically deletes the existing mapped drive and creates a new one—essentially changing all configurations elements of the mapped drive.  The update action only updates a portion of configuration elements in an existing mapped drive.

***Prologue***

The extension extracts the values for the <path>, <letter>, <persistent>, <username>, and <cPassword> attributes from the configuration information. If the <cPassword> attribute contains a value, then the extension reverse\-obfuscates the password into its clear text equivalent.   The extension continues extracting the values for the <allDrives>, <thisDrive>, and <useLetter> attributes.  The extension completes the prologue portion of the processing by impersonating the user logging on the computer using the user’s full authentication token.  Any failure attempting the impersonation results in the extension aborting its processing and to return the underlying error code that resulted in the impersonation failure.

***Core***

The core phase of replace action processing is to use the configuration information read during the prologue phase to identify an existing mapped network drive, delete the specified network drive, if found, and to create a newly mapped network drive for the current user.

*Specific Drive Letter*

The extension checks if the value of the <useLetter> attribute equals true \(one \[1\]\).  A true value determines the desired configuration is for a specific drive letter.

The extensions starts by ensure the drive letter is normalized in all lower case and that its syntax matches \[driveLetter:\].  Any failures encountered during normalization cause the extension to abort and to return an invalid argument error.

The extension then uses the Windows API WNetGetConnection to determine if the value <letter> is currently used by an existing mapped network drive or by a physical device such as a hard drive, CD\-ROM\/DVD\-ROM, ram disk or removable drive.

A <letter> value that currently exists for the user but is not a mapped drive or not considered a physical device causes the extension to abort its process and to return unexpected error.

*Delete Mapped Drive*

A <letter> value that currently exists for the user and is remotely connected to a network share causes the extension to use the Windows API WNetCancelConnection2 to remove the connection and its persistent state from the user’s session.  A <letter> value that currently exists for the user and is associated with a physical device cause the extension to abort its processing and return an already assigned error.

*Create Mapped Network Drive*

The extension determines if the current user’s token is not a restricted token and the <persistent> attribute value equals false \(zero \[0\]\). Upon validating these factors, the extension uses the WNetUseConnection API to create a newly mapped drive using the value of the <letter> attribute as the drive letter.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response from the Windows API instructs the extension to abort its processing and to return the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log.

If the extension determines the current user’s token is a restricted token \(User Account Control is enabled\) then the extension must create the mapped drive under the restricted token rather than the full token.  This explains why mapped drives for administrators and some users are not always visible in Windows Explorer.

The extension stops impersonating the current user with the user’s full token and requests Windows to provide a restricted token for the user.  Any failure in the cessation of impersonation instructs the extension to abort its processing, write “Failed to revert from the user’s full token” to the trace log and to return the underlying error code that is the result of failure to cease impersonation.  Any failure in requesting a restricted token for the current user instructs the extension to abort its processing, write “Failed to impersonate with user’s restricted token”, and to return the underlying error code that is the result of the failure to impersonate using the restricted token.

While impersonating the user using the restricted token, the extension use the WNetUseConnnection API to create a new mapped drive where the drive letter used is the value of the <letter> attribute.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response instructs the extension to abort its processing, write “Failed to connect drive with restricted token” along with the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log. Then, the extension discontinues impersonating the current user under the restricted token and returns impersonating the user using the full token.

A failure reverting from impersonating the user with a restricted token causes the extension to write “Failed to revert user from restricted context” to the trace log.  A failure impersonating the user with their full token causes the extension to write “Failed to impersonate with user’s full token” to the trace log.  The extension continues processing by apply the configured label to the newly created mapped drive.

*First Available Drive Letter, Starting at*

A <useletter> attribute value equaling false \(zero \[0\]\) determines the desired configuration is to replace a mapped drive using the first available letter starting with the <letter> attribute value.

In this configuration, the extension uses the <letter> attribute value as the starting point of the drive letters through which it searches for an existing mapped drive.  The <path> attribute value becomes the matching criterion that determines if the mapped drive exists.

*Determine the First Available Drive Letter*

The extension needs to determine the first available drive letter before it can map any network location.  To accomplish this, the extensions creates a list of lower case letters starting with the <letter> attribute value and ending with the letter ‘z’.  The extension iterates through each letter in the list to determine the first available drive letter, starting with the <letter> attribute value.

The extension determines a letter qualifies as available by using the WNetGetConnection API to determine if the current letter in the list of letters is mapped to a network drive or associated with a physical device.

*Drive Letter not in use*

A drive letter not mapped to a shared folder instructs the extension to check if it previously saved an available drive letter.  If the extension already knows of the first available drive letter, then it performs no other actions on the current drive letter and starts the evaluation over again using the next letter in the list.  The extension purposely cycles through the entire list to ensure no other drive letter within the range of drive letters is mapped to the specified location.

If the extension is unaware of any previously saved available drive letter, then it ensures the current letter is not associated with a physical device.  A drive letter associated with a physical device is not eligible as an available drive letter.  The extension performs no other actions on the current drive letter and starts the evaluation over again using the next letter in the list.  A drive letter making it to this part of the process has passed all the criteria needed to become the first available drive letter.  The extension saves this drive letter and continues the evaluation over again using the next letter in the list.

*Drive Letter in use by a Mapped Drive*

A drive letter mapped to a shared folder instructs the extension to evaluate the shared folder location of the existing mapped drive to the <path> attribute value in the inner element configuration.

If the shared folder path matches the <path> attribute value, then the extension considers the mapped drive already connected.  The extension writes “Path is connected already on letter” along with the current drive letter to the trace log, discontinues iterating the drive letters, and proceeds to the Drive Label portion of the core processing phase.

The extension completes its iteration through the drive letter list and validates a free drive letter exits.  If the extension remains unaware of an available drive letter and it did not locate an existing drive letter mapped to the network path identical to the <path> attribute value, then the extension aborts its processing, and returns a not connected error.  Otherwise, the extension is aware of an available drive letter and must now connect the shared network folder to the available drive letter.

*Connecting to First Available Drive*

The extension must create a new mapped drive using the discovered first available drive letter and the <path> attribute value.  To do this, the extension determines the type of token used by the current user and the value of the <persistent> attribute.

If the user has a full token or if the <persistent> attribute equals false \(zero \[1\]\), then the extension use the WNetUseConnection API to create a new mapped drive where the drive letter used is the discovered first available drive letter.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value, which is false, is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response from the Windows API instructs the extension to abort its processing and return the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log.

A user with a restricted token \(User Account Control enabled\) indicates to the extension that it must also create the new drive mapping while impersonating the user using the user’s restricted token.

The extension stops impersonating the current user with the user’s full token and requests Windows to provide a restricted token for the user.  Any failure in the cessation of impersonation instructs the extension to abort its processing, write “Failed to revert from the user’s full token” to the trace log, and to return the underlying error code that is the result of failure to cease impersonation.

Any failure in requesting a restricted token for the current user instructs the extension to abort its processing and to return the underlying error code that is the result of the failure to when requesting the restricted token.

A failure occurring when extension impersonates the user using the restricted token cause the extension to abort its processing, write “Failed to impersonate with user’s restricted token” to the trace log,  and return the underlying error code that is the result of the failure to impersonate using the restricted token.

While impersonating the user using the restricted token, the extension use the WNetUseConnnection API to create a new mapped drive where the drive letter used is the value of the <letter> attribute.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response instructs the extension to abort its processing, write “Failed to connect drive with restricted token” to the trace log along with the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log. Then, the extension discontinues impersonating the current user under the restricted token and returns impersonating the user using the full token.

A failure reverting from impersonating the user with a restricted token cases the extension to write “Failed to revert user from restricted context” to the trace log.  A failure impersonating the user with their full token causes the extension to write “Failed to impersonate with user’s full token” to the trace log.  The extension continues processing by apply the configured label to the newly created mapped drive.

*Drive Label*

To this point in the process, the extension has successfully deleted a mapped drive, if discovered and created a mapped network drive using either a specific drive letter or a first available drive letter.   Also, the extension has mapped the drive using the user’s full token and restricted token, if needed.

The extension needs to apply the <label> attribute value to the newly created drive letter.  The extension ensures a value is present for the <label> attribute and that the mapped drive was newly created and not an existing local or remote drive letter.  Once the extensions confirms these conditions, it replaces any backslash \(\\\) characters in the <path> attribute’s value with pound \(\#\) characters.  Next, the extension creates a registry key using the modified <path> value under

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Mountpoints2

```

The extension creates a new registry value named \_LabelFromReg.  The value assigned to \_LabelFromReg is the original, unmodified <path> attribute value.  The extension ignores any failures that may occurs during drive label processing.

*Hide or Show Drives*

The Group Policy Drive Map extension can show or hide drives using two configurations during the replace, create, and update actions.  It can hide or show a single, specified drive letter and it can hide or show all drive letters.  The extension processes all drives first and specified drive last.  Thus, the outcome of configuring both results in the specified drive configuration have precedence over the all drives configuration.

The extension determines if it needs to show or hide any drive letters by checking the <thisDrive> and <AllDrives> attribute values.  If both attribute values equal “NOCHANGE’ then the extension performs no other actions and processes the epilog portion of core processing. Otherwise, the extension begins the hide or show drives process by changing to the security context to System.   Any failure in changing to System security context causes the extension to abort its processing and return the underlying error responsible for the failure.

*All Drives*

The extension determines if it needs to hide or show all drive letters by evaluating the value of the <AllDrives> attribute.  If the attribute’s value equals “SHOW” then the extension deletes the NoDrives registry value from the following registry hive of the current user.

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

```

If the attribute’s value equals “HIDE” then the extension writes the hexadecimal value 0x03FFFFFF to the NoDrives registry value of the previously mentioned registry hive of the current user \(the extension creates the NoDrives registry value if it does not exist\).  The extension then processes hide or show settings for a specific drive letter.

*Specified Drive*

The extension validates that the <thisDrive> attribute equals “SHOW” or “HIDE”.  Next, the extension validates the <letter> attribute value is not blank.  If the <letter> attribute value is blank, then the extension aborts its processing and returns an invalid argument error.

The extension retrieves the NoDrives registry value from the following registry hive of the current user

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

```

The extension uses an algorithm based on information in Microsoft Knowledgebase article 231289, Using Group Policy Objects to hide specified drives, to determine equivalent bit value of the <letter> attribute value.

If the <thisDrive> attribute value equals “HIDE” then the extension enables that bit in the NoDrives registry value.  If the <thisDrive> attribute value equals “SHOW” then the extension disabled the bit in the NoDrives registry value.

After modifying the NoDrives registry value, the extension checks its value to ensure it does not equal zero \(0\).  If the newly calculated NoDrives registry value equals zero, then the extension deletes the NoDrives registry value.  Otherwise, the extension saves the newly calculated NoDrives registry value to the registry.

***Epilogue***

The extension completes the processing by updating its %LastDriveMapped% environment variable and by securely deleting the clear text instance of the <cPassword> attribute value.  Additionally, if the <persistent> attribute value equals true \(one \[1\]\), then the extension signals to the Group Policy infrastructure that the next foreground processing must be synchronous.

Replace action processing is complete.  The extension moves to the next inner element \(preference item\) and begins inner element processing on the new, current inner element.

## Update
The update action represents a configuration where the extension refreshes an existing mapped drive based on the configuration in the current inner element.  It is important to understand the difference between replace and update.

The replace action typically deletes the existing mapped drive and creates a new one—essentially changing all configurations elements of the mapped drive.  The update action only updates a portion of configuration elements in an existing mapped drive.

***Prologue***

The extension extracts the values for the <path>, <letter>, <persistent>, <username>, and <cPassword> attributes from the configuration information. If the <cPassword> attribute contains a value, then the extension reverse\-obfuscates the password into its clear text equivalent.   The extension continues extracting the values for the <allDrives>, <thisDrive>, and <useLetter> attributes.  The extension completes the prologue portion of the processing by impersonating the user logging on the computer using the user’s full authentication token.  Any failure attempting the impersonation results in the extension aborting its processing and to return the underlying error code that resulted in the impersonation failure.

***Core***

The core phase of update action processing is to use the configuration information read during the prologue phase to identify an existing mapped network drive and, if found, update drive label and visibility settings, or create a newly mapped network drive for the current user.

*Specified Drive Exists*

A <letter> value that currently exists for the user and is mapped to a shared network folder or a physical device causes the extension to continue processing by applying the configured label portion of the preference item to the existing drive letter.

*Non\-existent Specified Drive*

A <letter> value that does not exists for the user causes the extension to create a new mapped network drive.

*Create Mapped Network Drive*

The extension determines if the current user’s token is not a restricted token and the <persistent> attribute value equals false \(zero \[0\]\). Upon validating these factors, the extension uses the WNetUseConnection API to create a newly mapped drive using the value of the <letter> attribute as the drive letter.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response from the Windows API instructs the extension to abort its processing and to return the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log.

If the extension determines the current user’s token is a restricted token \(User Account Control is enabled\) then the extension must create the mapped drive under the restricted token rather than the full token.  This explains why mapped drives for administrators and some users are not always visible in Windows Explorer.

The extension stops impersonating the current user with the user’s full token and requests Windows to provide a restricted token for the user.  Any failure in the cessation of impersonation instructs the extension to abort its processing, write “Failed to revert from the user’s full token” to the trace log, and return the underlying error code that is the result of failure to cease impersonation.  Any failure in requesting a restricted token for the current user instructs the extension to abort its processing, write “Failed to impersonate with user’s restricted token” to the trace log, and return the underlying error code that is the result of the failure to impersonate using the restricted token.

While impersonating the user using the restricted token, the extension use the WNetUseConnnection API to create a new mapped drive where the drive letter used is the value of the <letter> attribute.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response instructs the extension to abort its processing, write “Failed to connect drive with restricted token” along with the underlying error code it received from the Windows API to the trace log.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log. Then, the extension discontinues impersonating the current user under the restricted token and returns impersonating the user using the full token.

A failure reverting from impersonating the user with a restricted token causes the extension to write “Failed to revert user from restricted context” to the trace log.  A failure impersonating the user with their full token causes the extension to write “Failed to impersonate with user’s full token” to the trace log.  The extension continues processing by applying the configured label to the newly created mapped drive.

*First Available Drive Letter, Starting at*

A <useletter> attribute value equaling false \(zero \[0\]\) determines the desired configuration is to update an existing mapped drive using the first available letter starting with the <letter> attribute value.

In this configuration, the extension uses the <letter> attribute value as the starting point of the drive letters through which it searches for an existing mapped drive.  The <path> attribute value becomes the matching criterion that determines if the mapped drive exists.

*Determine the First Available Drive Letter*

The extension needs to determine the first available drive letter before it can map any network location.  To accomplish this, the extension creates a list of lower case letters starting with the <letter> attribute value and ending with the letter ‘z’.  The extension iterates through each letter in the list to determine the first available drive letter, starting with the <letter> attribute value.

The extension determines a letter qualifies as available by using the WNetGetConnection API to determine if the current letter in the list of letters is mapped to a network drive or associated with a physical device.

*Drive Letter not in use*

A drive letter not mapped to a shared folder instructs the extension to check if it previously saved an available drive letter.  If the extension already knows of the first available drive letter, then it performs no other actions on the current drive letter and starts the evaluation over again using the next letter in the list.  The extension purposely cycles through the entire list to ensure no other drive letter within the range of drive letters is mapped to the specified location.

If the extension is unaware of any previously saved available drive letter, then it ensures the current letter is not associated with a physical device.  A drive letter associated with a physical device is not eligible as an available drive letter.  The extension performs no other actions on the current drive letter and starts the evaluation over again using the next letter in the list.  A drive letter making it to this part of the process has passed all the criteria needed to become the first available drive letter.  The extension saves this drive letter and continues the evaluation over again using the next letter in the list.

*Drive Letter in use by a Mapped Drive*

A drive letter mapped to a shared folder instructs the extension to evaluate the shared folder location of the existing mapped drive to the <path> attribute value in the inner element configuration.

If the shared folder path matches the <path> attribute value, then the extension considers the mapped drive already connected.  The extension writes “Path is connected already on letter” along with the current drive letter to the trace log, discontinues iterating the drive letters, and proceeds to the Drive Label portion of the core processing phase.

The extension completes its iteration through the drive letter list and validates a free drive letter exits.  If the extension remains unaware of an available drive letter and it did not locate an existing drive letter mapped to the network path identical to the <path> attribute value, then the extension aborts its processing, and returns a not connected error.  Otherwise, the extension is aware of an available drive letter and must now connect the shared network folder to the available drive letter.

*Connecting to First Available Drive*

The extension must create a new mapped drive using the discovered first available drive letter and the <path> attribute value.  To do this, the extension determines the type of token used by the current user and the value of the <persistent> attribute.

If the user has a full token or if the <persistent> attribute equals false \(zero \[1\]\), then the extension use the WNetUseConnection API to create a new mapped drive where the drive letter used is the discovered first available drive letter.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value, which is false, is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response from the Windows API instructs the extension to abort its processing and return the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log.

A user with a restricted token \(User Account Control enabled\) indicates to the extension that it must also create the new drive mapping while impersonating the user using the user’s restricted token.

The extension stops impersonating the current user with the user’s full token and requests Windows to provide a restricted token for the user.  Any failure in the cessation of impersonation instructs the extension to abort its processing, write “Failed to revert from the user’s full token” to the trace log, and to return the underlying error code that is the result of failure to cease impersonation.

Any failure in requesting a restricted token for the current user instructs the extension to abort its processing and to return the underlying error code that is the result of the failure to when requesting the restricted token.

A failure occurring when extension impersonates the user using the restricted token cause the extension to abort its processing, write “Failed to impersonate with user’s restricted token” to the trace log,  and return the underlying error code that is the result of the failure to impersonate using the restricted token.

While impersonating the user using the restricted token, the extension use the WNetUseConnnection API to create a new mapped drive where the drive letter used is the value of the <letter> attribute.  The shared folder used for the mapped drive is the value of the <path> attribute.  If the <username> and <cPassword> attributes contains values, then their respective values are the credentials used to authenticate and authorize the connection to the shared folder.  Additionally, the <persistent> attribute value is passed to the Windows API to indicate if the newly created mapped drive should persist between logons and reboots.

An unsuccessful response instructs the extension to abort its processing, write “Failed to connect drive with restricted token” to the trace log along with the underlying error code it received from the Windows API.  A successful response from Windows API instructs the extension to write “Connected with access name…” to the trace log. Then, the extension discontinues impersonating the current user under the restricted token and returns impersonating the user using the full token.

A failure reverting from impersonating the user with a restricted token cases the extension to write “Failed to revert user from restricted context” to the trace log.  A failure impersonating the user with their full token causes the extension to write “Failed to impersonate with user’s full token” to the trace log.  The extension continues processing by apply the configured label to the newly created mapped drive.

*Drive Label*

To this point in the process, the extension has successfully deleted a mapped drive, if discovered and created a mapped network drive using either a specific drive letter or a first available drive letter.   Also, the extension has mapped the drive using the user’s full token and restricted token, if needed.

The extension needs to apply the <label> attribute value to the newly created drive letter.  The extension ensures a value is present for the <label> attribute and that the mapped drive was newly created and not an existing local or remote drive letter.  Once the extensions confirms these conditions, it replaces any backslash \(\\\) characters in the <path> attribute’s value with pound \(\#\) characters.  Next, the extension creates a registry key using the modified <path> value under

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Mountpoints2

```

The extension creates a new registry value named \_LabelFromReg.  The value assigned to \_LabelFromReg is the original, unmodified <path> attribute value.  The extension ignores any failures that may occurs during drive label processing.

*Hide or Show Drives*

The Group Policy Drive Map extension can show or hide drives using two configurations during the replace, create, and update actions.  It can hide or show a single, specified drive letter and it can hide or show all drive letters.  The extension processes all drives first and specified drive last.  Thus, the outcome of configuring both results in the specified drive configuration have precedence over the all drives configuration.

The extension determines if it needs to show or hide any drive letters by checking the <thisDrive> and <AllDrives> attribute values.  If both attribute values equal “NOCHANGE’ then the extension performs no other actions and processes the epilog portion of core processing. Otherwise, the extension begins the hide or show drives process by changing to the security context to System.   Any failure in changing to System security context causes the extension to abort its processing and return the underlying error responsible for the failure.

*All Drives*

The extension determines if it needs to hide or show all drive letters by evaluating the value of the <AllDrives> attribute.  If the attribute’s value equals “SHOW” then the extension deletes the NoDrives registry value from the following registry hive of the current user.

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

```

If the attribute’s value equals “HIDE” then the extension writes the hexadecimal value 0x03FFFFFF to the NoDrives registry value of the previously mentioned registry hive of the current user \(the extension creates the NoDrives registry value if it does not exist\).  The extension then processes hide or show settings for a specific drive letter.

*Specified Drive*

The extension validates that the <thisDrive> attribute equals “SHOW” or “HIDE”.  Next, the extension validates the <letter> attribute value is not blank.  If the <letter> attribute value is blank, then the extension aborts its processing and returns an invalid argument error.

The extension retrieves the NoDrives registry value from the following registry hive of the current user

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

```

The extension uses an algorithm based on information in Microsoft Knowledgebase article 231289, Using Group Policy Objects to hide specified drives, to determine equivalent bit value of the <letter> attribute value.

If the <thisDrive> attribute value equals “HIDE” then the extension enables that bit in the NoDrives registry value.  If the <thisDrive> attribute value equals “SHOW” then the extension disabled the bit in the NoDrives registry value.

After modifying the NoDrives registry value, the extension checks its value to ensure it does not equal zero \(0\).  If the newly calculated NoDrives registry value equals zero, then the extension deletes the NoDrives registry value.  Otherwise, the extension saves the newly calculated NoDrives registry value to the registry.

***Epilogue***

The extension completes the processing by updating its %LastDriveMapped% environment variable and by securely deleting the clear text instance of the <cPassword> attribute value.  Additionally, if the <persistent> attribute value equals true \(one \[1\]\), then the extension signals to the Group Policy infrastructure that the next foreground processing must be synchronous.

Update action processing is complete.  The extension moves to the next inner element \(preference item\) and begins inner element processing on the new, current inner element.

## Dependencies
The Group Policy Drive Maps extension is one of many extensions provided in a single dynamic linked library, gpprecl.dll.  This extension has one or more dependencies on the following dynamic linked libraries that are included in the Windows operating system.

1.  ACTIVEDS.DLL

2.  ADVAPI32.DLL

3.  IPHLPAPI.DLL

4.  KERNEL32.DLL

5.  MPR.DLL

6.  MSI.DLL

7.  MSVCRT.DLL

8.  NETAPI32.DLL

9. NTDLL.DLL

10. OLE32.DLL

11. OLEAUT32.DLL

12. POWRPROF.DLL

13. RPCRT4.DLL

14. SECUR32.DLL

15. SETUPAPI.DLL

16. SHELL32.DLL

17. SHLWAPI.DLL

18. USER32.DLL

19. USERENV.DLL

20. VERSION.DLL

21. WINSPOOL.DRV

22. WINSTA.DLL

23. WLDAP32.DLL

24. WS2\_32.DLL

25. WTSAPI32.DLL

26. XMLLITE.DLL

## Interaction with other components
The Windows operating system enables many different configurations to accomplish a single task.  Mapping shared network folders to local drive letters is one of those tasks.

The most common configuration for mapping network drives occurs during the user logon. Historically, IT departments have accomplished this configuration using network logon scripts—scripts that process as part of the user logon.  Another configuration for mapping Home drives is to configure the shared network folder on the user’s object in Active Directory.  Windows clients looking for this configuration and automatically connect the shared network folder to the configured drive letter. Users can map network drives using Windows Explorer and make them persistent between computer reboots.  Lastly, you can use the Group Policy Drive Map extension to map drives during logon.

Flexible configurations are important; however, understanding that incorporating the one or more of the configurations into one solution needs to be thoroughly tested for each specific environment as many of these technologies can encroach on the other thereby creating unpredictable results.  A suggested best practice is to pick one configuration and use it exclusively in your environment, especially when mapping network drives during logon.  Each configuration maps the drive during different stages of the logon process.  Incorporating multiple configurations could be counterproductive and cause conflict between the two configurations.  This conflict is likely to produce unwanted results, increases the complexity of the solution, increases administrative overhead of the solution, and increase the difficulty of troubleshooting the cause of the problem.

## Logging
In addition to the event messages recorded in the application log, the Group Policy Drive Map extension has trace logging to help diagnose preference items that are not applying or undesired or unexpected results from preference items that are applying.

![](media/GP_PREF_FIG15.png)

You enable Group Policy Drive Map logging using Computer\\Policies namespace of the Group Policy Management Editor.  The **Configure Drive Maps preference logging and tracing** policy setting resides under the **Administrative Templates\\System\\Group Policy\\Logging and tracing node**.  The policy setting enables a variety of configuration options that affect the types of events the extension reports to the event log, trace logging, and the filename and location of the trace logs.

The best configuration for capturing Group Policy Drive Map information for troubleshooting is to configure **Event Logging** using the **Informational, Warnings, and Errors** option and configure **Tracing** to **On**.

Trace logging file name and locations are configurable to any name and location to where the user or computer has read and write permissions.  The default paths for these files use a Group Policy Preference **variable %COMMONAPPDATA%\\GroupPolicy\\Preference\\Trace\\<filename>**.  The Group Policy Preference %COMMONAPPDATA% variable equates to the All Users’ application data folder.

Starting with Windows Vista, the All Users’ folder was deprecated with the introduction of the version 2 user profile structure.  To ensure compatibility among applications, Windows creates a symbolic link named All Users in the file system under the %SYSTEMDRIVE%\\Users folder.  The symbolic link redirects file system requests to the All Users folder to the **C:\\ProgramData** folder.  Therefore, the default location for Group Policy Preference trace logs is **C:\\ProgramData\\GroupPolicy\\Preference\\Trace\\<filename>**.



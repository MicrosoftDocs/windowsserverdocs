---
title: Working with the Administrative Template policy settings using the Local Group Policy Editor
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 18a19f90-c524-438a-b84c-376014a5bec9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Working with the Administrative Template policy settings using the Local Group Policy Editor

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to use the Local Group Policy Editor (gpedit) to manage Administrative Template policy settings.

## Introduction and common procedures
Administrative Templates are registry-based policy settings that appear in the Local Group Policy Editor under the Administrative Templates node of both the Computer and User Configuration nodes. This hierarchy is created when the Local Group Policy Editor reads XML-based Administrative Template files (.admx).

#### To edit Administrative Templates policy settings

1.  Using the Local Group Policy Editor, open the Local Group Policy object you want to edit.

2.  In the console tree, click the folder under **Administrative Templates** that contains the policy settings you want to configure.

3.  In the **Setting** column, click the name for a policy setting to read a description of the policy setting.

4.  To change that policy setting from its current state, double-click the name of the policy setting.

5.  In the policy setting dialog box, click one of the following:

    -   **Not Configured**: The registry is not modified.

    -   **Enabled**: The registry reflects that the policy setting is selected.

    -   **Disabled**: The registry reflects that the policy setting is not selected.

6.  Select any other options that you want, and then click **OK**.

### Additional considerations

-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.

-   In the Local Group Policy Editor, there are two Administrative Templates branches. Settings for **HKEY_LOCAL_MACHINE** are under **Computer Configuration**, and settings for **HKEY_CURRENT_USER** are under **User Configuration**.

-   If computer policy conflicts with user policy, computer policy generally takes precedence. However, if application authors disregard this convention, Group Policy cannot enforce it.

-   Administrative Template policy settings are also known as registry-based policy settings.

-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).

## How to filter Administrative Template policy settings
The Local Group Policy Editor provides the option to filter Administrative Template policy settings based on:

-   Managed, Configured, or Commented policy settings.

-   Keywords within the title, Help text, or comment of policy settings.

-   Platform or application requirements of policy settings.

Apply filters on Administrative Template policy settings when you want to find a specific policy setting or when you want to limit the number of policy settings displayed in the Local Group Policy Editor.

### How to filter with Property Filters
The Local Group Policy Editor allows you to change the criteria for displaying Administrative Template policy settings. By default, the editor displays all policy settings, including unmanaged policy settings. However, you can use property filters to change how the Local Group Policy Editor displays Administrative Template policy settings.

There are three inclusive property filters that you can use to filter Administrative Templates. These property filters include:

-   [Managed](#BKMK_MANAGED)

-   [Configured](#BKMK_CONFIGURED)

-   [Commented](#BKMK_COMMENTED)

### <a name="BKMK_MANAGED"></a>Managed
There are two kinds of Administrative Template policy settings: **Managed** and **Unmanaged**. The Group Policy Client service governs Managed policy settings and removes a policy setting when it is no longer within scope of the user or computer.

The Group Policy Client service does not govern unmanaged policy settings. These policy settings are persistent. The Group Policy Client service does not remove unmanaged policy settings, even if the policy setting is not within scope of the user or computer. Typically, you use these types of policy settings to configure options for operating system components that are not policy enabled. You can also use unmanaged policy settings for application settings.

The Managed property filter has three states: **Any**, **Yes**, and **No**. Setting this property filter to **Any** causes the Local Group Policy Editor to display all Administrative Template policy settings. Setting this property filter to **Yes** causes the editor to show only managed Administrative Template policy settings, hiding all unmanaged Administrative Template policy settings. Setting this property filter to **No** causes the editor to show only unmanaged Administrative Template policy settings, hiding all managed Administrative Template policy settings.

##### To set the Administrative Templates Managed property filter

1.  Open the **Local Group Policy Editor**.

2.  Right-click **Administrative Templates** located under **Computer Configuration\Policies** or **User Configuration\Policies**. Click **Filter Options**.

3.  In the **Managed** list, click the appropriate filter.

4.  Click **OK** to apply the new filter settings, and close the **Filter Options** dialog box.

### <a name="BKMK_CONFIGURED"></a>Configured
You can configure Administrative Template policy settings to one of three states: **Not Configured**, **Enabled**, and **Disabled**. **Not Configured** is the default state for all policy settings. Policy settings set to **Not Configured** do not affect users or computers. Enabling an Administrative Template policy setting activates the policy setting. When **Enabled**, the action described in the title of the policy setting applies to the user or computer. When **Disabled**, the opposite action described in the title of the policy setting applies to the user or computer. Usually **Not Configured** and **Disabled** policy settings produce the same results. The difference is that **Not Configured** policy settings do not apply to the user, but **Disabled** policy settings apply to a user.

Each Administrative Template policy setting provides detailed information about its **Enabled**, **Disabled**, and **Not Configured** states. You can view this information in the **Help** pane of each Administrative Template policy setting. Or, you can view this information for the selected policy setting in the Extended View of the editor.

The Configured property filter has three states: **Any**, **Yes**, and **No**. Setting this property filter to **Any** causes the Local Group Policy Editor to display all Administrative Template policy settings and is the default setting for this filter. Setting this property filter to **Yes** causes the editor to show only configured Administrative Template policy settings, hiding not configured policy settings. Setting this property filter to **No** causes the editor to show only not configured Administrative Template policy settings, hiding configured policy settings.

##### To set the Administrative Templates Configured property filter

1.  Open the **Local Group Policy Editor**.

2.  Right-click **Administrative Templates** located under **Computer Configuration\Policies** or **User Configuration\Policies**. Click **Filter Options**.

3.  In the **Configured** list, click the appropriate filter.

4.  Click **OK** to apply the new filter settings, and close the **Filter Options** dialog box.

### <a name="BKMK_COMMENTED"></a>Commented
Each Administrative Template policy setting has a comment property. The Commented property allows you to enter text associated with a specific policy setting.

The Commented property filter has three states: **Any**, **Yes**, and **No**. Setting this property filter to **Any** causes the Local Group Policy Editor to display all Administrative Template policy settings and is the default setting for this filter. Setting this proper filter to **Yes** causes the editor to show only commented Administrative Template policy settings, hiding policy settings without comments. Setting this property filter to **No** causes the editor to show only Administrative Template policy settings without comments, hiding commented policy settings.

##### To set the Administrative Templates Commented property filter

1.  Open the **Local Group Policy Editor**.

2.  Right-click **Administrative Templates** located under **Computer Configuration\Policies** or **User Configuration\Policies**. Click **Filter Options**.

3.  In the **Commented** list, click the appropriate filter.

4.  Click **OK** to apply the new filter settings and close the **Filter Options** dialog box.

### Additional considerations

-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.

-   Filters are inclusive, so select items you want to display rather than items you want to be removed.

-   Filters do not work with Classic Administrative Templates.

-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).

## How to filter with Keyword filters
The Local Group Policy Editor allows you to change the criteria for displaying Administrative Template policy settings. By default, the editor displays all policy settings. However, you can use keyword filters to change how the Local Group Policy Editor displays Administrative Template policy settings.

#### To set the Administrative Templates Keyword filter

1.  Open the **Local Group Policy Editor**.

2.  Right-click **Administrative Templates** located under **Computer Configuration** or **User Configuration**. Click **Filter Options**.

3.  Select the **Enable Keyword Filters** check box.

4.  Type one or more keywords in the **Filter for word(s)** box, and click the appropriate filter:

    -   **Any**: The filter includes any of the words in the **Filter for word(s)** box.

    -   **All**: The filter includes all of the words in the **Filter for word(s)** box.

    -   **Exact**: The filter includes exact matches of the words in the **Filter for word(s)** box.

5.  Select the appropriate check boxes next to **Within**.

    -   **Policy Setting Title**: The filter includes searching the title of the policy setting.

    -   **Help Text**: The filter includes searching the Help text of the policy setting.

    -   **Comment**: The filter includes searching the comment of the policy setting

6.  Click **OK** to apply the new filter settings and close the **Filter Options** dialog box.

### Additional considerations

-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.

-   Filters are inclusive, so select items you want to display rather than items you want to be removed.

-   Filters do not work with Classic Administrative Templates.

-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).

## How to filter with Requirement Filters
The Local Group Policy Editor allows you to change the criteria for displaying Administrative Template policy settings. By default, the editor displays all policy settings. However, you can use requirement filters to change how the Local Group Policy Editor displays Administrative Template policy settings.

#### To set the Administrative Templates Requirement filter

1.  Open the **Local Group Policy Editor**.

2.  Right-click **Administrative Templates** located under **Computer Configuration** or **User Configuration**. Click **Filter Options**.

3.  Select the **Enable Requirements Filters** check box.

4.  Type one or more keywords in the **Filter for word(s)** box.

5.  In the **Select the desired platform and application filter(s)** list, click the appropriate filter:

    -   **Include settings that match any of the selected platforms**.

    -   **Include settings that match all of the selected platforms**.

        > [!NOTE]
        > You can click **Select All** to select all of the items in the list, or you can click **Clear All** to clear all of the items in the list.

6.  Click **OK** to apply the new filter settings and close the **Filter Options** dialog box.

### Additional considerations

-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.

-   Filters are inclusive, so select items you want to display rather than items you want to be removed.

-   Filters do not work with Classic Administrative Templates.

-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).

## How to comment an Administrative Templates policy setting
You can include comments on each Administrative Template policy setting. You can use this space to further document the policy setting and why its implementation is important to your environment. Commenting policy settings allows you to use keyword filters to help you quickly find policy settings with matching keywords.

#### To comment an Administrative Templates policy setting

1.  Open the **Local Group Policy Editor**.

2.  In the console tree, click the folder under **Administrative Templates** that contains the policy setting you want to configure.

3.  In the **Setting** column, double-click the name for the policy setting.

4.  Type your comments in the **Comment** box.

5.  Click **OK**.

### Additional considerations

-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.

-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).

## How to add or remove classic Administrative Templates
Classic Administrative Template files (also known as ADM files) are not authored using XML. Earlier versions of the Local Group Policy Editor displayed these settings under the **Administrative Templates** node.

The current version of Administrative Template files are authored using XML (known as ADMX files). The Local Group Policy Editor displays these settings under the **Administrative Templates** node. However, the Local Group Policy Editor still recognizes ADM files and displays these settings under the **Classic Administrative Templates** node, which is a child node to **Administrative Templates**.

#### To add or remove a classic Administrative Template file (.adm file)

1.  Using the Local Group Policy Editor, open the Local Group Policy object you want to edit.

2.  In the console tree, under either **Computer Configuration** or **User Configuration**, right-click **Administrative Templates**.

3.  Click **Add/Remove Templates**.

4.  Do one of the following:

    -   To add a template, click **Add**. In the **Policy Templates** dialog box, click the template you want to add, and then click **Open**.

    -   To remove a template, in the **Current Policy Templates** list, click the template, and then click **Remove**.

### Additional considerations

-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.

-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).



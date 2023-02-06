---
title: Step 4 - Configure Group Policy Settings for Automatic Updates
description: This article is step four in a four-step process for deploying Windows Server Update Services (WSUS).
ms.topic: article
ms.assetid: 62177d05-d832-4ea8-bca4-47a8cd34a19c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# Step 4: Configure Group Policy settings for automatic updates

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In an Active Directory environment, you can use Group Policy to define how computers and users can interact with Windows Update to obtain automatic updates from Windows Server Update Services (WSUS). This article refers to these computers and users as *WSUS clients*.

This article contains two main sections:

- [Group Policy settings for WSUS client updates](#group-policy-settings-for-wsus-client-updates) provides prescriptive guidance and behavioral details about the Windows Update and Maintenance Scheduler settings of Group Policy that control how WSUS clients can interact with Windows Update to obtain automatic updates.

- [Supplemental information](#supplemental-information) has the following subsections:

  - [Accessing the Windows Update settings in Group Policy](#accessing-the-windows-update-settings-in-group-policy) provides general guidance about using the Group Policy Management Editor (GPME). It also has information about accessing the policy extensions and Maintenance Scheduler settings in Group Policy for update services.

  - [Changes to WSUS relevant to this guide](#changes-to-wsus) gives a brief summary of key differences between the current and past versions of WSUS relevant to this guide. It's for administrators familiar with WSUS 3.2 and previous versions.

  - [Terms and definitions](#terms-and-definitions) defines terms that pertain to WSUS and update services.

## Group Policy settings for WSUS client updates
This section provides information about the following three extensions of Group Policy. In these extensions, you'll find the settings that you can use to configure how WSUS clients interact with Windows Update to receive automatic updates.

-   [Computer Configuration &gt; Windows Update policy settings](#computer-configuration--windows-update-policy-settings)

-   [Computer Configuration &gt; Maintenance Scheduler policy settings](#computer-configuration--maintenance-scheduler-policy-settings)

-   [User Configuration &gt; Windows Update policy settings](#user-configuration--windows-update-policy-settings)

> [!NOTE]
> This article assumes that you already use and are familiar with Group Policy. If you're not familiar with Group Policy, we advise that you review the information in the [Supplemental information](#supplemental-information) section of this article before you try to configure policy settings for WSUS.

### Computer Configuration > Windows Update policy settings
This section provides details about the following computer-based policy settings:

-   [Allow Automatic Updates immediate installation](#allow-automatic-updates-immediate-installation)

-   [Allow non-administrators to receive update notifications](#allow-non-administrators-to-receive-update-notifications)

-   [Allow signed updates from an intranet Microsoft update service location](#allow-signed-updates-from-an-intranet-microsoft-update-service-location)

-   [Automatic Updates detection frequency](#automatic-updates-detection-frequency)

-   [Configure Automatic Updates](#configure-automatic-updates)

-   [Delay restart for scheduled installations](#delay-restart-for-scheduled-installations)

-   [Do not adjust default option to Install Updates and Shut Down in Shut Down Windows dialog](#do-not-adjust-default-option-to-install-updates-and-shut-down-in-shut-down-windows-dialog)

-   [Do not display Install updates and Shut Down option in Shut Down Windows dialog](#do-not-display-install-updates-and-shut-down-option-in-shut-down-windows-dialog)

-   [Enable client-side targeting](#enable-client-side-targeting)

-   [Enabling Windows Update Power Management to automatically wake up the computer to install scheduled updates](#enabling-windows-update-power-management-to-automatically-wake-up-the-computer-to-install-scheduled-updates)

-   [No auto-restart with logged on users for scheduled automatic updates installations](#no-auto-restart-with-logged-on-users-for-scheduled-automatic-updates-installations)

-   [Re-prompt for restart with scheduled installations](#re-prompt-for-restart-with-scheduled-installations)

-   [Reschedule Automatic Updates scheduled installations](#reschedule-automatic-updates-scheduled-installations)

-   [Specify intranet Microsoft update service location](#specify-intranet-microsoft-update-service-location)

-   [Turn on recommended updates via Automatic Updates](#turn-on-recommended-updates-via-automatic-updates)

-   [Turn on Software Notifications](#turn-on-software-notifications)

In the Group Policy Management Editor, Windows Update policies for computer-based configuration are located in the path *PolicyName* > **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Windows Update**.

> [!NOTE]
> By default, these settings are not configured.

#### Allow Automatic Updates immediate installation
Specifies whether Automatic Updates will automatically install updates that don't interrupt Windows services or restart Windows.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> If the **Configure Automatic Updates** policy setting is set to **Disabled**, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that updates are not immediately installed. Local administrators can change this setting by using the Local Group Policy Editor.|
|**Enabled**|Specifies that Automatic Updates immediately installs updates after they're downloaded and ready to install.|
|**Disabled**|Specifies that updates are not immediately installed.|

**Options:** There are no options for this setting.

#### Allow non-administrators to receive update notifications
Specifies whether non-administrative users will receive update notifications based on the **Configure Automatic Updates** policy setting.

|Supported on|Excluding|
|---------|-------|
|Windows Server 2012 R2, Windows 8.1, and earlier versions|null|

> [!NOTE]
> If the **Configure Automatic Updates** policy setting is disabled or is not configured, this policy setting has no effect.

> [!IMPORTANT]
> Starting in Windows 8 and Windows RT, this policy setting is enabled by default. In all prior versions of Windows, it's disabled by default.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that users will always see an Account Control window and require elevated permissions to do these tasks. A local administrator can change this setting by using the Local Group Policy Editor.|
|**Enabled**|Specifies that Windows Automatic Update and Microsoft Update will include non-administrators when determining which signed-in user will receive update notifications. Non-administrative users will be able to install all optional, recommended, and important update content for which they received a notification. Users won't see a User Account Control window. Users don't need elevated permissions to install these updates, except in the case of updates that contain changes to the user interface, Microsoft Software License Terms, or Windows Update settings.<p>In two situations, the effect of this setting depends on the operating computer:<p>-  **Hide** or **Restore** updates<br />-  **Cancel** an update installation<p>In Windows Vista or Windows XP, if this policy setting is enabled, users won't see a User Account Control window. These users don't need elevated permissions to hide, restore, or cancel updates.<p>In Windows Vista, if this policy setting is enabled, users won't see a User Account Control window. These users don't need elevated permissions to hide, restore, or cancel updates. If this policy setting is not enabled, users will always see a User Account Control window, and they require elevated permissions to hide, restore, or cancel updates.<p>In  Windows 7, this policy setting has no effect. Users will always see an Account Control window, and they require elevated permissions to do these tasks.<p>In Windows 8 and Windows RT, this policy setting has no effect.|
|**Disabled**|Specifies that only logged-on administrators receive update notifications. Note that in Windows 8 and Windows RT, this policy setting is enabled by default. In all prior versions of Windows, it's disabled by default.|

**Options:** There are no options for this setting.

#### Allow signed updates from an intranet Microsoft update service location
Specifies whether Automatic Updates accepts updates that are signed by entities other than Microsoft when the update is found on an intranet Microsoft update service location.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!NOTE]
> Updates from a service other than an intranet Microsoft update service must always be signed by Microsoft. This policy setting doesn't affect them.

> [!NOTE]
> This policy is not supported on Windows RT. Enabling this policy won't have any effect on computers running Windows RT.

**Options:** There are no options for this setting.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that updates from an intranet Microsoft update service location must be signed by Microsoft.|
|**Enabled**|Specifies that Automatic Updates accepts updates received through an intranet Microsoft update service location if they're signed by a certificate found in the local computer's Trusted Publishers certificate store.|
|**Disabled**|Specifies that updates from an intranet Microsoft update service location must be signed by Microsoft.|

**Options:** There are no options for this setting.

#### Always automatically restart at the scheduled time
Specifies whether a restart timer will always begin immediately after Windows Update installs important updates, instead of first notifying users on the sign-in screen for at least two days.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> If the **No auto-restart with logged on users for scheduled automatic updates installations** policy setting is enabled, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that Windows Update won't alter the computer's restart behavior.|
|**Enabled**|Specifies that a restart timer will always begin immediately after Windows Update installs important updates, instead of first notifying users on the sign-in screen for at least two days.<p>The restart timer can be configured to start with any value from 15 to 180 minutes. When the timer runs out, the restart will proceed even if the computer has signed-in users.|
|**Disabled**|Specifies that Windows Update won't alter the computer's restart behavior.|

**Options:** If this setting is enabled, you can specify the amount of time that will elapse after updates are installed before a forced computer restart occurs.

#### Automatic Updates detection frequency
Specifies the hours that Windows will use to determine how long to wait before checking for available updates. The exact wait time is determined by using the hours specified here minus 0 to 20 percent of the hours specified. For example, if this policy is used to specify a 20-hour detection frequency, all clients to which this policy is applied will check for updates anywhere between 16 and 20 hours.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!NOTE]
> The **Specify intranet Microsoft update service location** setting must be enabled for this policy to have effect.
>
> If the **Configure Automatic Updates policy** setting is disabled, this policy has no effect.

> [!NOTE]
> This policy is not supported on Windows RT. Enabling this policy won't have any effect on computers running Windows RT.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that Windows will check for available updates at the default interval of 22 hours.|
|**Enabled**|Specifies that Windows will check for available updates at the specified interval.|
|**Disabled**|Specifies that Windows will check for available updates at the default interval of 22 hours.|

**Options:** If this setting is enabled, you can specify the time interval (in hours) that Windows Update waits before checking for updates.

#### Configure Automatic Updates
Specifies whether automatic updates are enabled on this computer.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

If this Group Policy setting is enabled, you must select one of the four options that the setting provides.

To use this setting, select **Enabled**. Then in **Options** under **Configure automatic updating**, select one of the options (**2**, **3**, **4**, or **5**).

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that the use of automatic updates is not specified at the Group Policy level. However, a computer administrator can still configure automatic updates in Control Panel.|
|**Enabled**|Specifies that Windows recognizes when the computer is online and uses its internet connection to search Windows Update for available updates.<p>When this setting is enabled, local administrators will be allowed to use the Windows Update control panel item to select a configuration option of their choice. However, local administrators won't be allowed to disable the configuration for Automatic Updates.<p>-   **2 - Notify for download and notify for install**<br />    When Windows Update finds updates that apply to the computer, users will be notified that updates are ready for download. Users can then run Windows Update to download and install any available updates.<p>-   **3 - Auto download and notify for install** (default setting)<br />    Windows Update finds applicable updates and downloads them in the background. The user is not notified or interrupted during the process. When the downloads are complete, users are notified that updates are ready to install. Users can then run Windows Update to install the downloaded updates.<p>-   **4 - Auto download and schedule the install**<br />    You can specify the schedule by using the options in this Group Policy setting. If no schedule is specified, the default schedule for all installations will be every day at 3:00 AM. If any updates require a restart to complete the installation, Windows will restart the computer automatically. (If a user is signed in to the computer when Windows is ready to restart, the user will be notified and given the option to delay the restart.) <p>Note that starting Windows 8, you can set updates to install during automatic maintenance instead of using a specific schedule tied to Windows Update. Automatic maintenance will install updates when the computer is not in use, and will avoid installing updates when the computer is running on battery power. If automatic maintenance can't install updates within days, Windows Update will install updates right away. Users will then be notified about a pending restart. A pending restart will happen only if there's no potential for accidental data loss. <p>   You can specify schedule options in the GPME Maintenance Scheduler settings. These settings are located in the path *PolicyName* > **computer Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Maintenance Scheduler** > **Automatic Maintenance Activation Boundary**. For setting details, see the [Maintenance Scheduler settings](#computer-configuration--maintenance-scheduler-policy-settings) section of this article.<p>-    **5 - Allow local admin to choose setting**<br />  Specifies whether local administrators are allowed to use the Automatic Updates control panel item to select a configuration option of their choice. For example, a configuration option might be whether local administrators can choose a scheduled installation time.<p>    Local administrators won't be allowed to disable the configuration for Automatic Updates.|
|**Disabled**|Specifies that any client updates that are available from the public Windows Update service must be manually downloaded from the internet and installed.|

#### Delay restart for scheduled installations
Specifies the amount of time Automatic Updates will wait before proceeding with a scheduled restart.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> This policy applies only when Automatic Updates is configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is disabled, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that after updates are installed, the default wait time of 15 minutes will elapse before any scheduled restart occurs.|
|**Enabled**|Specifies that when the installation is finished, a scheduled restart will occur after the specified number of minutes has expired.|
|**Disabled**|Specifies that after updates are installed, the default wait time of 15 minutes will elapse before any scheduled restart occurs.|

**Options:** If this setting is enabled, you can specify the amount of time (in minutes) Automatic Updates waits before proceeding with a scheduled restart.

#### Do not adjust default option to Install Updates and Shut Down in Shut Down Windows dialog
This policy setting enables you to specify whether the **Install Updates and Shut Down** option is permitted as the default choice in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> This policy setting has no impact if the *PolicyName* > **computer Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Windows Update** > **Do not display Install Updates and Shut Down option in Shut Down Windows dialog** policy setting is enabled.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that **Install Updates and Shut Down** will be the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|
|**Enabled**|If you enable this policy setting, the user's last shutdown choice (for example, **Hibernate** or **Restart**) is the default option in the **Shut Down Windows** dialog, regardless of whether the **Install Updates and Shut Down** option is available on the **What do you want the computer to do?** menu.|
|**Disabled**|Specifies that **Install Updates and Shut Down** will be the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Do not connect to any Windows Update Internet locations
Even when Windows Update is configured to receive updates from an intranet update service, it will periodically retrieve information from the public Windows Update service. This information will enable future connections to Windows Update and other services, such as Microsoft Update or Microsoft Store.

> [!NOTE]
> This policy applies only when the computer is configured to connect to an intranet update service by using the **Specify intranet Microsoft update service location** policy setting.

|Supported on|Excluding|
|---------|-------|
|Starting with  Windows Server 2012 R2, Windows 8.1, or Windows RT 8.1, Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that computers can retrieve information from public update services such as Windows Update and the Microsoft Store.|
|**Enabled**|Specifies that Windows will no longer connect to public update services such as Windows Update or the Microsoft Store. This will cause most functionality of the Microsoft Store app to stop working.<p>Users who search for updates by using the **Settings** app or Control Panel will only see updates from the intranet update service. They won't be presented with the **Check online for updates from Windows Update** option.<p>Programs that use the Windows Update Agent APIs will be unable to search for updates against any service other than the intranet update service.|
|**Disabled**|Specifies that computers can retrieve information from public update services.|

**Options:** There are no options for this setting.

#### Do not display Install updates and Shut Down option in Shut Down Windows dialog
Specifies whether the **Install Updates and Shut Down** option is displayed in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that the **Install Updates and Shut Down** option is available in the **Shut Down Windows** dialog if updates are available when the user selects the **Shut Down** option to shut down the computer. A local administrator can change this setting by using a local policy.|
|**Enabled**|Specifies that **Install Updates and Shut Down** won't appear as a choice in the **Shut Down Windows** dialog, even if updates are available for installation when the user selects the **Shut Down** option to shut down the computer.|
|**Disabled**|Specifies that the **Install Updates and Shut Down** option will be the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Enable client-side targeting
Specifies the target group name or names that are configured in the WSUS console that will receive updates from WSUS.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!NOTE]
> This policy applies only when this computer is configured to support the specified target group names in WSUS. If the target group name doesn't exist in WSUS, it will be ignored until it's created. If the **Specify intranet Microsoft update service location** policy setting is disabled or not configured, this policy has no effect.

> [!NOTE]
> This policy is not supported on Windows RT. Enabling this policy won't have any effect on computers running Windows RT.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that no target group information is sent to WSUS. A local administrator can change this setting by using a local policy.|
|**Enabled**|Specifies that the specified target group information is sent to WSUS, which uses it to determine which updates should be deployed to this computer. If WSUS supports multiple target groups, you can use this policy to specify multiple group names, separated by semicolons, if you've added the target group names in the computer group list in WSUS. Otherwise, a single group must be specified.|
|**Disabled**|Specifies that no target group information is sent to WSUS.|

**Options:** Use this space to specify one or more target group names.

#### Enabling Windows Update Power Management to automatically wake up the computer to install scheduled updates
Specifies whether Windows Update will use the Windows Power Management or Power Options features to automatically wake up the computer from hibernation if updates are scheduled for installation.

The computer will automatically wake only if Windows Update is configured to install updates automatically. If the computer is in hibernation when the scheduled installation time occurs and there are updates to be applied, Windows Update will use the Windows Power Management or Power Options features to automatically wake the computer to install the updates. Windows Update will also wake the computer and install an update if an installation deadline occurs.

The computer won't wake unless there are updates to be installed. If the computer is on battery power, when Windows Update wakes it, it won't install updates. The computer will automatically return to hibernation in two minutes.

|Supported on|Excluding|
|---------|-------|
|Starting with Windows Vista and Windows Server 2008 (Windows 7), Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Windows Update does not wake the computer from hibernation to install updates. A local administrator can change this setting by using a local policy.|
|**Enabled**|Windows Update wakes the computer from hibernation to install updates under the previously listed conditions.|
|**Disabled**|Windows Update does not wake the computer from hibernation to install updates.|

**Options:** There are no options for this setting.

#### No auto-restart with logged on users for scheduled automatic updates installations
Specifies that to complete a scheduled installation, Automatic Updates will wait for the computer to be restarted by any user who is signed in, instead of causing the computer to restart automatically.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> This policy applies only when Automatic Updates is configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is disabled, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that Automatic Updates will notify the user that the computer will automatically restart in five minutes to complete the installation.|
|**Enabled**|Some updates require the computer to be restarted before the updates will take effect. If the status is set to **Enabled**, Automatic Updates won't restart a computer automatically during a scheduled installation if a user is signed in to the computer. Instead, Automatic Updates will notify the user to restart the computer.|
|**Disabled**|Specifies that Automatic Updates will notify the user that the computer will automatically restart in five minutes to complete the installation.|

**Options:** There are no options for this setting.

#### Re-prompt for restart with scheduled installations
Specifies the amount of time for Automatic Updates to wait before prompting again with a scheduled restart.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

> [!IMPORTANT]
> This policy applies only when Automatic Updates is configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is disabled, this policy has no effect.

> [!NOTE]
> This policy has no effect on computers running Windows RT.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|A scheduled restart occurs 10 minutes after the prompt-for-restart message is dismissed. A local administrator can change this setting by using a local policy.|
|**Enabled**|Specifies that after a prompt for restart is postponed, a scheduled restart will occur after the specified number of minutes elapses.|
|**Disabled**|A scheduled restart occurs 10 minutes after the prompt-for-restart message is dismissed.|

**Options:** When this setting is enabled, you can specify the amount of time (in minutes) that will elapse before users are prompted again about a scheduled restart.

#### Reschedule Automatic Updates scheduled installations
Specifies the amount of time for Automatic Updates to wait after a computer startup, before proceeding with a scheduled installation that was previously missed.

If the status is set to **Not Configured**, a missed scheduled installation will occur one minute after the computer is next started.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> This policy applies only when Automatic Updates is configured to perform scheduled installations of updates. If the **Configure Automatic Updates** policy setting is disabled, this policy has no effect.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that a missed scheduled installation will occur one minute after the computer is next started.|
|**Enabled**|Specifies that a scheduled installation that did not happen earlier will occur the specified number of minutes after the computer is next started.|
|**Disabled**|Specifies that a missed scheduled installation will occur with the next scheduled installation.|

**Options:** When this policy setting is enabled, you can specify a number of minutes after the computer is next started that a scheduled installation that did not happen earlier will occur.

#### Specify intranet Microsoft update service location
Specifies an intranet server to host updates from Microsoft Update. You can then use WSUS to automatically update computers on your network.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|Windows RT|

This setting enables you to specify a WSUS server on your network that will function as an internal update service. Instead of using the public Windows Update and Microsoft Update services on the internet, WSUS clients will search this service for updates that apply. Enabling this setting means that users in your organization don't have to go through a firewall to get updates. It also gives you the opportunity to test updates before deploying them.

To use this setting, you must set two server name values: the server from which the client detects and downloads updates, and the server to which updated workstations upload statistics. The values don't need to be different if both services are configured on the same server. 

> [!NOTE]
> This policy is not supported on Windows RT. Enabling this policy won't have any effect on computers running Windows RT.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that clients connect directly to the Windows Update site on the internet.|
|**Enabled**|Specifies that the client connects to the specified WSUS server, instead of Windows Update, to search for and download updates.<p>If Automatic Updates is not disabled by policy or user preference, Automatic Updates will search for, download, and/or install updates from the specified WSUS server, instead of from Windows Update.<p>Users of the **Windows Update Settings** page (or the **Windows Update** Control Panel page on older versions of Windows) will normally see updates from the specified WSUS server, instead of from Windows Update. Users will also see a **Check online for updates from Windows Update** option that enables them to use the public update services on the internet. You can remove this option by using the **Do not connect to any Windows Update Internet locations** policy.<p>Applications that use the Windows Update Agent APIs to search for, download, and/or install updates will normally operate against the specified WSUS server. Applications can specifically request to use the public update services on the internet. You can remove this option by using the **Do not connect to any Windows Update Internet locations** policy. |
|**Disabled**|Specifies that clients connect directly to the Windows Update site on the internet.|

**Options:** When this policy setting is enabled, you must specify the intranet update service that WSUS clients will use when detecting updates, and the internet statistics server to which updated WSUS clients will upload statistics. Example values:


|                    Setting option:                    |    Example value:    |
|-------------------------------------------------------|----------------------|
| Set the intranet update service for detecting updates |  http://wsus01:8530  |
|          Set the intranet statistics server           | http://IntranetUpd01 |

#### Turn on recommended updates via Automatic Updates
Specifies whether Automatic Updates will deliver important and recommended updates from WSUS.

|Supported on|Excluding|
|---------|-------|
|Starting with Windows Vista, Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that Automatic Updates will continue to deliver important updates if it's already configured to do so.|
|**Enabled**|Specifies that Automatic Updates will install recommended updates and important updates from WSUS.|
|**Disabled**|Specifies that Automatic Updates will continue to deliver important updates if it's already configured to do so.|

**Options:** There are no options for this setting.

#### Turn on Software Notifications
This policy setting enables you to control whether users see detailed enhanced notification messages about featured software from the Microsoft Update service. Enhanced notification messages convey the value and promote the installation and use of optional software. This policy setting is intended for loosely managed environments in which you allow the user access to the Microsoft Update service.

If you're not using the Microsoft Update service, the **Software Notifications** policy setting has no effect.

If the **Configure Automatic Updates** policy setting is disabled or is not configured, the **Software Notifications** policy setting has no effect.

|Supported on|Excluding|
|---------|-------|
|Starting with  Windows Server 2008 (Windows Vista) and Windows 7, Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> By default, this policy setting is disabled.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Users on computers that are running Windows 7 are not offered messages for optional applications. Users on computers that are running Windows Vista are not offered messages for optional applications or updates. A local administrator can change this setting by using Control Panel or a local policy.|
|**Enabled**|If you enable this policy setting, a notification message will appear on the user's computer when featured software is available. The user can select the notification to open Windows Update and get more information about the software or install it. The user can also select **Close this message** or **Show me later** to defer the notification as appropriate.<p>In Windows 7, this policy setting controls only detailed notifications for optional applications. In Windows Vista, this policy setting controls detailed notifications for optional applications and updates.|
|**Disabled**|Specifies that users running Windows 7 won't be offered detailed notification messages for optional applications. It also specifies that users running Windows Vista won't be offered detailed notification messages for optional applications or optional updates.|

**Options:** There are no options for this setting.

### Computer Configuration > Maintenance Scheduler policy settings
In the **Configure Automatic Updates** setting, if you selected the option **4 - Auto download and schedule the install**, you can specify Maintenance Scheduler settings in the Group Policy Management Console (GPMC) for computers running Windows 8 and Windows RT. If you did not select option 4 in the **Configure Automatic Updates** setting, you don't need to configure these settings for the purpose of automatic updates. 

Maintenance Scheduler settings are located in the path *PolicyName* > **computer Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Maintenance Scheduler**. The Maintenance Scheduler extension of Group Policy contains the following settings:

-   [Automatic Maintenance Activation Boundary](#automatic-maintenance-activation-boundary)

-   [Automatic Maintenance Random delay](#automatic-maintenance-random-delay)

-   [Automatic WakeUp Policy](#automatic-wakeup-policy)

#### Automatic Maintenance Activation Boundary
This policy enables you to configure the Automatic Maintenance activation boundary. 

The activation boundary is the daily scheduled time at which Automatic Maintenance starts.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> This setting is related to option 4 in **Configure Automatic Updates**. If you did not select option 4 in **Configure Automatic Updates**, you don't need to configure this setting.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|If this policy setting is not configured, the daily scheduled time as specified on client computers in Control Panel > **Action Center** > **Automatic Maintenance** will apply.|
|**Enabled**|Enabling this policy setting overrides any default or modified settings configured on client computers in Control Panel > **Action Center** > **Automatic Maintenance** (or in some client versions, **Maintenance**).|
|**Disabled**|If you set this policy setting to **Disabled**, the daily scheduled time as specified in Control Panel > **Action Center** > **Automatic Maintenance** will apply.|

#### Automatic Maintenance Random delay
This policy setting allows you to configure the random delay for Automatic Maintenance activation.

The maintenance random delay is the amount of time up to which Automatic Maintenance will delay starting from its activation boundary. This setting is useful for virtual machines where random maintenance might be a performance requirement.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> This setting is related to option 4 in **Configure Automatic Updates**. If you did not select option 4 in **Configure Automatic Updates**, you don't need to configure this setting.

By default, when this setting is enabled, the regular maintenance random delay is **PT4H**.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|A four-hour random delay is applied to **Automatic**.|
|**Enabled**|Automatic Maintenance will delay starting from its activation boundary by up to the specified amount of time.|
|**Disabled**|No random delay is applied to Automatic Maintenance.|

#### Automatic WakeUp Policy
This policy setting allows you to configure the wake-up policy for Automatic Maintenance.

The wake-up policy specifies whether Automatic Maintenance should make a wake-up request to the operating computer for daily scheduled maintenance.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> If the operating computer's power-wake policy is explicitly disabled, this setting has no effect.

> [!NOTE]
> This setting is related to option 4 in **Configure Automatic Updates**. If you did not select option 4 in **Configure Automatic Updates**, you don't need to configure this setting.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|If you don't configure this policy setting, the wake-up setting as specified in Control Panel > **Action Center** > **Automatic Maintenance** will apply.|
|**Enabled**|If you enable this policy setting, Automatic Maintenance will attempt to set an operating system wake-up policy and make a wake-up request for the daily scheduled time, if required.|
|**Disabled**|If you disable this policy setting, the wake-up setting as specified in Control Panel > **Action Center** > **Automatic Maintenance** will apply.|

### User Configuration > Windows Update policy settings
This section provides details about the following user-based policy settings:

-   [Do not display Install Updates and Shut Down option in Shut Down Windows dialog box](#do-not-display-install-updates-and-shut-down-option-in-shut-down-windows-dialog)

-   [Do not adjust default option to Install Updates and Shut Down in Shut Down Windows dialog box](#do-not-adjust-default-option-to-install-updates-and-shut-down-in-shut-down-windows-dialog)

-   [Remove access to use all Windows Update features](#remove-access-to-use-all-windows-update-features)

In GPMC, the user settings for automatic computer updates are located in the path *PolicyName* > **User Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Windows Update**. The settings are listed in the same order as they appear in the Computer Configuration and User Configuration extensions in Group Policy, when the **Settings** tab of the Windows Update policy is selected to sort the settings alphabetically.

> [!NOTE]
> By default, unless otherwise noted, these settings are not configured.

For each of these settings, you can use the following steps to enable, disable, or move between settings.

#### Do not display 'Install Updates and Shut Down' option in Shut Down Windows dialog box
Specifies whether the **Install Updates and Shut Down** option is displayed in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies that the **Install Updates and Shut Down** option will appear in the **Shut Down Windows** dialog if updates are available when the user selects the **Shut Down** option to shut down the computer.|
|**Enabled**|Specifies that **Install Updates and Shut Down** won't appear as a choice in the **Shut Down Windows** dialog, even if updates are available for installation when the user selects the **Shut Down** option to shut down the computer.|
|**Disabled**|Specifies that the **Install Updates and Shut Down** option will appear in the **Shut Down Windows** dialog if updates are available when the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Do not adjust default option to Install Updates and Shut Down in Shut Down Windows dialog box
Specifies whether the **Install Updates and Shut Down** option is allowed as the default choice in the **Shut Down Windows** dialog.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

> [!NOTE]
> This policy setting has no impact if the *PolicyName* > **User Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Windows Update** > **Do not display Install Updates and Shut Down option in Shut Down Windows** dialog is enabled.

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Specifies whether the **Install Updates and Shut Down** option will be the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|
|**Enabled**|Specifies whether the user's last shutdown choice (for example, **Hibernate** or **Restart**) is the default option in the **Shut Down Windows** dialog, regardless of whether the **Install Updates and Shut Down** option is available on the **What do you want the computer to do?** menu.|
|**Disabled**|Specifies whether the **Install Updates and Shut Down** option will be the default option in the **Shut Down Windows** dialog if updates are available for installation at the time the user selects the **Shut Down** option to shut down the computer.|

**Options:** There are no options for this setting.

#### Remove access to use all Windows Update features
This setting enables you to remove WSUS client access to Windows Update.

|Supported on|Excluding|
|---------|-------|
|Windows operating systems that are still within their [Microsoft Product Support Lifecycle](/lifecycle/)|null|

|Policy setting state|Behavior|
|-|-|
|**Not Configured**|Users can connect to the Windows Update website.|
|**Enabled**|All Windows Update features are removed. This includes blocking access to the [Windows Update website](https://windowsupdate.microsoft.com) from the Windows Update hyperlink on the Start menu or startup screen, and on the **Tools** menu in Internet Explorer. <p>Windows automatic updates are also disabled. The user will neither be notified about nor receive critical updates from Windows Update. This setting also prevents Device Manager from automatically installing driver updates from the Windows Update website.<p>You can configure one of the following notification options:<p>-   **0 - Do not show any notifications**<br />    This setting will remove all access to Windows Update features, and no notifications will be shown.<p>-   **1 - Show restart required notifications**<br />    This setting will show notifications about restarts that are required to complete an installation. Note that on computers running Windows 8 and Windows RT, only notifications related to restarts and the inability to detect updates will be shown. The notification options are not supported. Notifications on the sign-in screen are always displayed.|
|**Disabled**|Users can connect to the Windows Update website.|

**Options:** See **Enabled** in the table for this setting.

## Supplemental information
This section provides more information about using, opening, and saving WSUS settings in Group Policy, and definitions for terms used in this article. For administrators who are familiar with past versions of WSUS (WSUS 3.2 and previous versions), a table summarizes differences between WSUS versions.

### Accessing the Windows Update settings in Group Policy
The following procedures describe how to work with Group Policy objects (GPOs) and other Group Policy settings.

> [!NOTE]
> To perform these procedures, you must be a member of the **Domain Admins** group or its equivalent.

#### To open a Group Policy object

1.  On your domain controller, go to **Server Manager** > **Tools** > **Group Policy Management**. The Group Policy Management Console opens.

2.  On the left pane, expand your forest. For example, double-click **forest: example.com**.

3.  On the left pane, double-click **Domains**, and then double-click the domain for which you want to manage a Group Policy object. For example, double-click **example.com**.

4.  Do one of the following:

    -  To open an existing domain-level GPO for editing:
       1. Double-click the domain that contains the Group Policy object that you want to manage. 
       
       2. Right-click the domain policy that you want to manage, and then select **edit**. The Group Policy Management Editor (GPME) opens.

    -  To create a new Group Policy object and open it for editing:
        1.  Right-click the domain for which you want to create a new Group Policy object, and then select **Create a GPO in this domain, and link it here**.

        2.  In **New GPO**, in **Name**, enter a name for the new Group Policy object, and then select **OK**.

        3.  Right-click your new Group Policy object, and then select **edit**. GPME opens.

#### To open the Windows Update or Maintenance Scheduler extensions of Group Policy

In the Group Policy Management Editor, do one of the following:

-   Open **Computer Configuration** > **Windows Update extension of Group Policy**. Then go to *PolicyName* > **computer Configuration** > **Policies** / **Administrative Templates** > **Windows components** > **Windows Update**.

-   Open **User Configuration** > **Windows Update extension of Group Policy**. Then go to *PolicyName* > **User Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Windows Update**.

-   Open **Computer Configuration** > **Maintenance Scheduler extension of Group Policy**. Then go to *PolicyName* > **computer Configuration** > **Policies** > **Administrative Templates** > **Windows components** > **Maintenance Scheduler**.

For more information about Group Policy, see [Group Policy Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831791(v=ws.11)).

#### To configure Group Policy settings

After you've opened the extension of Group Policy that you want, you can use the following steps to enable, disable, or move between settings:

1.  In *ExtensionOfGroupPolicy*, double-click the setting that you want to view or modify.

2.  Do one of the following:

    -   To retain the default unspecified state of the setting, select **Not Configured**.

    -   To enable the setting, select **Enabled**.

    -   To disable the setting, select **Disabled**.

3.  In **Options**, if any options are listed, retain the default values or modify them as needed.

4.  Do one of the following:

    -   To save your changes and proceed to the next setting, select **Apply**, and then select **Next Setting**.

    -   To save your changes and close the dialog, select **OK**.

    -   To discard all unsaved changes and close the dialog, select **Cancel**.

### Changes to WSUS
The following table summarizes key differences between the current and past versions of WSUS that are relevant to this article.

|Windows Server and WSUS versions|Description|
|------------------|--------|
| Windows Server 2012 R2 with WSUS 6.0, and subsequent versions|Starting in Windows Server 2012, the WSUS server role is integrated with the operating system. The associated Group Policy settings for WSUS clients are, by default, included in Group Policy.|
| Windows Server 2008 (and earlier versions of Windows Server) with WSUS 3.2 and earlier|In Windows Server 2008 (and earlier versions of Windows Server) using WSUS versions 3.2 (and earlier), the Group Policy settings that govern WSUS clients are not included in the operating system. The policy settings are in the WSUS administrative template *wuau.adm*. In these server versions, the WSUS administrative template must be added into the Group Policy Management Console before the WSUS client settings can be configured.|

### Terms and definitions
This article used the following terms:

|Term|Definition|
|----|-------|
|Automatic Updates and automatic updates|*Automatic Updates*: The client computer component built into the Microsoft Windows Vista, Windows Server 2003, Windows XP, and Windows 2000 with SP3 operating systems to get updates from Microsoft Update or Windows Update.<p>*automatic updates*: The casual term used to describe when the Windows Update Agent automatically schedules and downloads updates.|
|autonomous server|A downstream WSUS server on which administrators can manage WSUS components.|
|downstream server|A WSUS server that gets updates from another WSUS server rather than from Microsoft Update or Windows Update.|
|Group Policy extension or extension of Group Policy|A collection of settings in Group Policy that control how users and computers (to whom the policies apply) can configure and use various Windows services and features. Administrators can use WSUS with Group Policy for client-side configuration of the Automatic Updates client, to help ensure that users can't disable or circumvent corporate update policies.<p>WSUS does not require the use of Active Directory or Group Policy. Client configuration can also be applied by using a local group policy or by modifying the Windows registry.|
|internal update service|A casual reference to a network infrastructure that uses one or more WSUS servers to distribute updates.|
|replica server|A downstream WSUS server that mirrors the approvals and settings on the upstream server to which it's connected. You can't manage WSUS on a replica server.|
|Microsoft Update|A Microsoft internet site that stores and distributes updates for Windows computers (device drivers), Windows operating systems, and other Microsoft software products.|
|Software Update Services (SUS)|The predecessor product for WSUS.|
|updates|Any of a collection of software revisions, hotfixes, service packs, feature packs, and device drivers that can be installed on a computer to extend functionality, or to improve performance and security.|
|update files|The files required to install an update on a computer.|
|update information or update metadata|The information about an update, as opposed to the binary files in an update package. For example, metadata supplies information for the properties of an update so you can find out what the update is useful for. Metadata also includes Microsoft Software License Terms. The metadata package downloaded for an update is typically much smaller than the update file package.|
|update source|The location to which a WSUS server synchronizes to get update files. This location can be either Microsoft Update or an upstream WSUS server.|
|upstream server|A WSUS server that provides update files to another WSUS server (a downstream server).|
|Windows Server Update Services (WSUS)|A server role program that runs on one or more Windows Server computers on a corporate network. A WSUS infrastructure enables you to manage updates for computers on your network to install.<p>You can use WSUS to approve or decline updates before release, to force updates to install by a certain date, and to obtain extensive reports on what updates each computer on your network requires. You can configure WSUS to approve certain classes of updates automatically (including critical updates, security updates, service packs, and drivers). WSUS also enables you to approve updates for detection only, so that you can see what computers will require a particular update without having to install the update.<p>In a WSUS implementation, at least one WSUS server in the network must be able to connect to Microsoft Update to get available updates. Based on network security and configuration, the administrator can determine how many other servers connect directly to Microsoft Update.<p>You can configure a WSUS server to get updates over the internet from:<p>-   Microsoft Update<br />-   Windows Update<br />-   Microsoft Store|
|Windows Update|A Microsoft internet site that stores and distributes updates for Windows computers (device drivers) and Windows operating systems.<p>Windows Update is also the name of a service that runs on Windows computers and detects, downloads, and installs updates.<p>Depending on computer and policy configurations, the Windows Update Agent can download updates from:<p>-   Microsoft Update<br />-   Windows Update<br />-   Microsoft Store<br />-   An internet (network) update service (WSUS)<p>Computers that are not managed in a WSUS-based environment typically use Windows Update to connect directly (over the internet) to Windows Update, Microsoft Update, or Microsoft Store to obtain updates.|
|WSUS client|A computer that receives updates from a WSUS intranet update service.<p>In the case of Group Policy settings that control user interaction with Automatic Updates, it refers to a user of a computer in a WSUS environment.|

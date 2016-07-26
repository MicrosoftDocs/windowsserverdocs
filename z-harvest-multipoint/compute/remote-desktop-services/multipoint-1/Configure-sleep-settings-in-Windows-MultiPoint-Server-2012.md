---
title: Configure sleep settings in Windows MultiPoint Server 2012
ms.custom: na
ms.date: 07/22/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0279767e-2657-41f3-9e24-6ec2e4cbaa38
author: lizap
manager: jwhit
---
# Configure sleep settings in Windows MultiPoint Server 2012
To save energy on your [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)] system, you can configure the server to hibernate or enter sleep mode when user sessions time out. You will need to configure several sleep settings on the MultiPoint Server computer, and update the Registry to configure the session timeout.  
  
## Configure sleep settings on the [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)] computer  
Update settings in power management to allow sleep mode:  
  
-   [Allow the computer to enter sleep mode when idle](#BKMK_AllowComputerToEnterSleepMode)  
  
-   [Turn off the logon requirement when the computer wakes up](#BKMK_TurnOffLoggingRequirement)  
  
-   [Enable the computer to hibernate](#BKMK_EnableComputerToHibernate)  
  
### <a name="BKMK_AllowComputerToEnterSleepMode"></a>Allow the computer to enter sleep mode when idle  
If you want the MultiPoint Server to go into sleep mode after it has been idle for a certain length of time, turn on the power management setting, as described in the following procedure.  
  
##### To allow the computer to go to sleep  
  
1.  Log on to the MultiPoint Server computer as an administrator.  
  
2.  From the **Start** screen, open Control Panel.  
  
3.  In Control Panel, display **Power Options**. \(Type **power** in the search box.\)  
  
4.  In Power Options, click **Change when the computer sleeps**.  
  
5.  Under **Put the computer to sleep**, select the amount of time to allow the computer to remain idle before entering sleep mode, and then click **Save Changes**.  
  
    If this setting is not available, click **Change settings that are currently unavailable**, and then update the setting. This overrides the current setting in your preferred power plan.  
  
### <a name="BKMK_TurnOffLoggingRequirement"></a>Turn off the logon requirement when the computer wakes up  
If you turn on the power management setting to allow the computer to go to sleep, and the computer requires a password to wake it from sleep, your computer might not work and you might lose unsaved data. If this happens, you must restart the computer. To avoid this issue, turn off the requirement for a password when the computer wakes from sleep by completing the following procedure. If you have configured a screen saver, you might need to update the screen saver settings also.  
  
##### To turn off the password requirement to wake the computer from sleep  
  
1.  In Control Panel, display **Power Options**, and then click **Require a password on wakeup**.  
  
2.  On the **Define power buttons and turn on password protection** page, in the **Password protection on wakeup** section, select **Don’t require a password**, and then click **Save changes**.  
  
    If this option is not available, click **Change settings that are currently unavailable**, and then change the setting. This overrides the default setting in your preferred power plan.  
  
If you have configured a screen saver for the computer, use the following procedure to verify that the screen saver will not require a logon when the computer wakes from sleep.  
  
##### To turn off the password\-on\-wakeup for a screen saver  
  
1.  In Control Panel, click **Appearance and Personalization**.  
  
2.  Under **Personalization**, click **Change screen saver**.  
  
3.  In the Screen Saver Settings dialog box, ensure that the **On resume, display logon screen** check box is not selected. Then click **OK**.  
  
### <a name="BKMK_EnableComputerToHibernate"></a>Enable the computer to hibernate  
By default, hibernate is disabled in [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)]. If you want to be able to turn on hibernation using the power button, after you enable hibernation, configure the power button to hibernate the computer when pressed.  
  
##### To enable hibernation  
  
1.  Log on to the MultiPoint Server computer as an administrator.  
  
2.  Open a command prompt. \(Hold down the Windows key, and press R to open the Run dialog box. Then type **cmd**, and press ENTER.\)  
  
3.  At the command prompt, type: **powercfg.exe –h on**  
  
##### To configure the power button on the computer to go to hibernate when pressed  
  
1.  In Control Panel, display **Power Options**, and then click **Choose what the power buttons do**.  
  
2.  Beside **When I press the power button**, select **Hibernate**.  
  
    > [!NOTE]  
    > On some computers, you might see different options. For example, some computers allow different Hibernate settings when a computer is plugged in and when it is running off a battery.  
  
3.  Click **Save changes**.  
  
## Configure a session time\-out for idle user sessions  
By default, the MultiPoint Server computer does not go to sleep if a user is logged on to any station, even if the user’s session has been idle for a while. MultiPoint Server does not automatically disconnect an idle session, which prevents the computer from entering sleep mode.  
  
To enable sleep mode on a MultiPoint Server computer, update the registry to set a session idle time out interval.  
  
> [!IMPORTANT]  
> Directly editing the registry could make your MultiPoint Server computer inoperable. We strongly recommend that you back up the registry before you make any changes to it. You should only change values in the registry that you understand or are instructed to change by a source that you trust.  
  
#### To set the SessionIdleTimeout registry key  
  
1.  To open the Registry Editor with elevated permissions:  
  
    1.  On the **Start** screen, type **cmd**.  
  
    2.  In the results, right click **Command Prompt**, and then click **Run as an administrator** at the bottom of the screen.  
  
    3.  At the User Account Control prompt, click **Yes**.  
  
    4.  At the command prompt, type **Regedit**, and press ENTER.  
  
2.  In the Registry Editor, navigate to HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Windows MultiPoint Server, and select the SessionIdleTimeout registry key.  
  
    If you do not see a **SessionIdleTimeout** registry key, add the registry key:  
  
    1.  In the left pane, right\-click **Windows MultiPoint Server**, click **New**, and then **click DWORD \(32\-bit\) Value**.  
  
    2.  In the key name, type **SessionIdleTimeout**, and then press ENTER.  
  
3.  Right\-click the **SessionIdleTimeout** registry key, and then click **Modify**.  
  
4.  In the Edit dialog box, enter the amount of time, in milliseconds, to allow a user session to remain idle before the session is disconnected by MultiPoint Server, and then click **OK**.  
  
5.  Restart the computer to apply the changes.  
  

---
title: Interactive logon: Smart card removal behavior
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 936f00c2-c079-4269-8cf4-43c4253e1180
---
# Interactive logon: Smart card removal behavior
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines what happens when the smart card for a logged\-on user is removed from the smart card reader.  
  
If smart cards are used for authentication, the computer should automatically lock itself when the card is removed—that way, if users forget to manually lock their workstations when they are away from them, malicious users cannot gain access.  
  
If you select **Force Logoff** in the property sheet for this policy setting, the user is automatically logged off when the smart card is removed. Users will have to reinsert their smart cards and reenter their PINs when they return to their workstations.  
  
> [!NOTE]  
> Beginning with [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] or [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], the Smart Card Removal Policy service must be started for this setting to work.  
  
### Possible values  
  
-   No Action  
  
-   Lock Workstation  
  
    If you select this, the workstation is locked when the smart card is removed, allowing users to leave the area, take their smart card with them, and still maintain a protected session.  
  
-   Force Logoff  
  
    If you select this, the user is automatically logged off when the smart card is removed.  
  
-   Disconnect if a remote Remote Desktop Services session  
  
    If you select this, removal of the smart card disconnects the session without logging the user off. This allows the user to insert the smart card and resume the session later, or at another smart card reader\-equipped computer, without having to log on again. If the session is local, this policy functions identically to Lock Workstation.  
  
-   Not Defined  
  
### Best practices  
  
1.  Set **Interactive logon: Smart card removal behavior** to **Lock Workstation**. If you select **Lock Workstation** in the property sheet for this policy setting, the workstation is locked when the smart card is removed. This allows users to leave the area, take their smart card with them, and still maintain a protected session.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|No Action|  
|DC Effective Default Settings|No Action|  
|Member Server Effective Default Settings|No Action|  
|Client Computer Effective Default Settings|No Action|  
  
### Operating system version differences  
In [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], the option **Disconnect if a remote Terminal Services session** was added, and in [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], it was changed to **Disconnect if a remote Remote Desktop Services session** to accommodate the renaming of that feature.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Policy conflict considerations  
None.  
  
### Group Policy  
This policy setting can be configured by using the Group Policy Management Console \(GPMC\) to be distributed through Group Policy Objects \(GPOs\). If this policy is not contained in a distributed GPO, this policy can be configured on the local computer by using the Local Security Policy snap\-in.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Users sometimes forget to lock their workstations when they are away from them, allowing the possibility for malicious users to access their computers. If smart cards are used for authentication, the computer should automatically lock itself when the card is removed to ensure that only the user with the smart card is accessing resources by using those credentials.  
  
### Countermeasure  
Configure the **Interactive logon: Smart card removal behavior** setting to **Lock Workstation**.  
  
If you select **Lock Workstation** for this policy setting, the workstation locks when the smart card is removed. Users can leave the area, take their smart card with them, and still maintain a protected session. This behavior is similar to the setting that requires users to log on when resuming work on the computer after the screen saver has started.  
  
If you select **Force Logoff** for this policy setting, the user is automatically logged off when the smart card is removed. This setting is useful when a computer is deployed as a public access point, such as a kiosk or other type of shared computer.  
  
### Potential impact  
If you select **Force Logoff**, users must insert their smart cards and enter their PINs when they return to their workstations.  
  


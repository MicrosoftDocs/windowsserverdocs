---
title: User Account Control: Only elevate UIAccess applications that are installed in secure locations
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a512d056-0ba3-446a-ad1b-c52b675dcac8
---
# User Account Control: Only elevate UIAccess applications that are installed in secure locations
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.

## Reference
This policy setting enforces the requirement that applications that request running with a UIAccess integrity level \(by means of a marking of UIAccess\=true in their application manifest\), must reside in a secure location on the file system. Relatively secure locations are limited to the following directories:

-   \\Program Files\\ including subdirectories

-   \\Windows\\system32\\

-   \\Program Files \(x86\)\\ including subdirectories for 64\-bit versions of Windows

> [!NOTE]
> Windows enforces a PKI signature check on any interactive application that requests running with a UIAccess integrity level, regardless of the state of this security setting.

**Background**

User Interface Privilege Isolation \(UIPI\) implements restrictions in the Windows subsystem that prevent lower\-privilege applications from sending messages or installing hooks in higher\-privilege processes. Higher\-privilege applications are permitted to send messages to lower\-privilege processes. UIPI does not interfere with or change the behavior of messages between applications at the same privilege \(or integrity\) level.

Microsoft UI Automation is the current model to support accessibility requirements in the Windows operating systems. Applications that are designed to support an accessible user experience control the behavior of other Windows applications on behalf of the user. When all applications on the automation client computer and server are running as a standard user \(that is, at a medium integrity level\), the UIPI restrictions do not interfere with the Microsoft UI automation model.

However, there might be times when an administrative user runs an application with elevated privilege based on UAC in Admin Approval Mode. Microsoft UI Automation cannot drive the UI graphics of elevated applications on the desktop without the ability to bypass the restrictions that UIPI implements. The ability to bypass UIPI restrictions across privilege levels is available for UI automation programs by using UIAccess.

If an application presents a UIAccess attribute when it requests privileges, the application is stating a requirement to bypass UIPI restrictions for sending messages across privilege levels. Computers running at least the Windows Vista operating system implement the following policy checks before starting an application with UIAccess privilege.

1.  The application must have a digital signature that can be verified by using a digital certificate that is associated with the Trusted Root Certification Authorities store on the local computer.

2.  The application must be installed in a local folder that is writeable only by administrators, such as the Program Files directory. The allowed directories for UI automation applications are:

    1.  %ProgramFiles% and its subdirectories.

    2.  %WinDir% and its subdirectories, except a few subdirectories that are excluded because standard users have write access.

### Possible values

-   **Enabled**

    An application can start with UIAccess integrity only if it resides in a secure location in the file system.

-   **Disabled**

    An application can start with UIAccess integrity even if it does not reside in a secure location in the file system.

### Best practices

1.  Set this policy to **Enabled** to permit applications that are located in one of the designated secure directories to run with UIAccess integrity.

### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand\-Alone Server Default Settings|Enabled|
|DC Effective Default Settings|Enabled|
|Member Server Effective Default Settings|Enabled|
|Client Computer Effective Default Settings|Enabled|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Vista and Windows Server 2008.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they aresaved locally or distributed through Group Policy.

### Group Policy
This policy has no impact in Windows operating systems earlier than Windows Vista.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
UIAccess integrity allows an application to bypass User Interface Privilege Isolation \(UIPI\) restrictions when an application is elevated in privilege from a standard user to an administrator. When this setting is enabled, an application that has the UIAccess flag set to true in its manifest can interchange information with applications that are running at a higher privilege level, such as logon prompts and privilege elevation prompts. This ability is required to support accessibility features such as screen readers that are transmitting user interfaces to alternative forms, but it is not required by most applications. A process that is started with UIAccess rights has the following abilities:

-   Set the foreground window.

-   Drive any application window by using the SendInput function.

-   Use read input for all integrity levels by using low\-level hooks, raw input, GetKeyState, GetAsyncKeyState, and GetKeyboardInput.

-   Set journal hooks.

-   Use AttachThreadInput to attach a thread to a higher integrity input queue.

### Countermeasure
Enable the **User Account Control: Only elevate UIAccess applications that are installed in secure locations** setting.

### Potential impact
If the application that requests UIAccess meets the UIAccess setting requirements, computers running at least the Windows Vista operating system start the application with the ability to bypass most of the UIPI restrictions. If the application does not meet the security restrictions, the application is started without UIAccess rights, and it can interact only with applications at the same or lower privilege level.



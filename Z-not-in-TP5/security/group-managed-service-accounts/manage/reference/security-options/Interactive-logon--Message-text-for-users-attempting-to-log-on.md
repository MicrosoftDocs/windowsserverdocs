---
title: Interactive logon: Message text for users attempting to log on
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5a297979-d65f-4168-8bb3-3dc3e4437d0e
---
# Interactive logon: Message text for users attempting to log on
This security policy reference topic for the IT professional describes the best practices, location, values, management, and security considerations for this policy setting.

## Reference
The **Interactive logon: Message text for users attempting to log on** and **Interactive logon: Message title for users attempting to log on** policy settings are closely related. **Interactive logon: Message text for users attempting to log on** specifies a text message to be displayed to users when they log on. **Interactive logon: Message title for users attempting to log on** specifies a title to appear in the title bar of the window that contains the text message. This text is often used for legal reasons—for example, to warn users about the ramifications of misusing company information, or to warn them that their actions might be audited.

Not using this warning-message policy setting leaves your organization legally vulnerable to trespassers who unlawfully penetrate your network. Legal precedents have established that organizations that display warnings to users who connect to their servers over a network have a higher rate of successfully prosecuting trespassers.

When these policy settings are configured, users will see a dialog box before they can log on to the server console.

### Possible values
The possible values for this Group Policy setting are:

-   User-defined text

-   Not defined

### Best practices

1.  It is advisable to set **Interactive logon: Message text for users attempting to log on** to a value similar to one of the following:

    1.  IT IS AN OFFENSE TO CONTINUE WITHOUT PROPER AUTHORIZATION.

    2.  This system is restricted to authorized users. Individuals who attempt unauthorized access will be prosecuted. If you are unauthorized, terminate access now. Click OK to indicate your acceptance of this information.

> [!IMPORTANT]
> Any warning that you display in the title or text should be approved by representatives from your organization's legal and human resources departments.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Not defined|
|DC Effective Default Settings|Not defined|
|Member Server Effective Default Settings|Not defined|
|Client Computer Effective Default Settings|Not defined|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2003.

## Policy management
This section describes different requirements to help you manage this policy.

### Restart requirement
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.

### Effect on Windows 2000 operating systems
In  Windows 7 , Windows Vista, and Windows XP Professional, configuring logon banners that exceed 512 characters in length and contain carriage–return, line-feed sequences is supported. However, client computers running Windows 2000 cannot interpret and display message text that is created by computers running Windows XP Professional or later. You must use a Windows 2000-based computer to create a logon message that applies to Windows 2000-based computers. If you inadvertently create a logon message by using a Windows XP Professional or later operating system, and you discover that it is not displayed properly on Windows 2000-based computers, do the following:

-   Undefine the setting.

-   Redefine the setting by using a computer running Windows 2000.

> [!NOTE]
> Simply changing a logon message that is defined by a computer running  Windows 7 , Windows Vista, or Windows XP Professional by using a Windows 2000-based computer does not work. The setting must be undefined first.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

There are two policy settings that relate to logon displays:

-   **Interactive logon: Message text for users attempting to log on**

-   **Interactive logon: Message title for users attempting to log on**

The first policy setting specifies a text message that displays to users when they log on, and the second policy setting specifies a title for the title bar of the text message window. Many organizations use this text for legal purposes; for example, to warn users about the ramifications of misuse of company information, or to warn them that their actions may be audited.

### Vulnerability
Users often do not understand the importance of security practices. However, the display of a warning message before logon may help prevent an attack by warning malicious or uninformed users about the consequences of their misconduct before it happens. It may also help reinforce corporate policies by notifying employees of appropriate policies during the logon process.

### Countermeasure
Configure the **Interactive logon: Message text for users attempting to log on** and **Interactive logon: Message title for users attempting to log on** settings to an appropriate value for your organization.

> [!NOTE]
> Any warning message that displays should be approved by your organization's legal and human resources representatives.

### Potential impact
Users see a message in a dialog box before they can log on to the server console.

> [!NOTE]
> Client computers running Windows 2000 cannot interpret and display messages that exceed 512 characters in length and contain carriage-return, line-feed sequences. You must use a Windows 2000-based computer to create a logon message policy that applies to Windows 2000-based computers. If you do not create a logon message policy on a Windows 2000-based computer, and you discover that it does not display properly on Windows 2000-based computers, you must first change the policy setting to **Not Defined** and then reconfigure the setting by using a Windows 2000-based computer. If you do not do this, the changes do not take effect properly.



---
title: Audit: Audit the access of global system objects
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9127487d-7527-44f6-bb4f-49817ea94e87
---
# Audit: Audit the access of global system objects
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
If you enable this policy setting, a default system access control list \(SACL\) is applied when the computer creates system objects such as mutexes, events, semaphores, and MS\-DOS® devices. If you also enable the **Audit object access** audit setting, access to these system objects is audited.

Global system objects, also known as "base system objects" or "base named objects," are temporary kernel objects that have had names assigned to them by the application or system component that created them. These objects are most commonly used to synchronize multiple applications or multiple parts of a complex application. Because they have names, these objects are global in scope and, therefore, visible to all processes on the computer. These objects all have a security descriptor; but typically, they do not have a NULL SACL. If you enable this policy setting and it takes effect at startup time, the kernel assigns a SACL to these objects when they are created.

The threat is that a globally visible named object, if incorrectly secured, might be acted on by a malicious program that knows the name of the object. For instance, if a synchronization object such as a mutex has a poorly constructed discretionary access control list \(DACL\), a malicious program can access that mutex by name and cause the program that created it to malfunction. However, the risk of this occurring is very low.

Enabling this policy setting can generate a large number of security events, especially on busy domain controllers and application servers. This might cause servers to respond slowly and force the security log to record numerous events of little significance. Auditing for access to global system objects is an all\-or\-nothing affair; there is no way to filter which events get recorded and which do not. Even if an organization has the resources to analyze events generated when this policy setting is enabled, it is unlikely to have the source code or a description of what each named object is used for; therefore, it is unlikely that many organizations could benefit from enabling this policy setting.

### Possible values

-   Enabled

-   Disabled

-   Not defined

### Best practices

1.  Use the advanced security audit policy option, **Audit Kernel Object** in Advanced Security Audit Policy Settings\\Object Access, to reduce the number of unrelated audit events that you generate.

### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options

### Default values
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not Defined|
|Default Domain Controller Policy|Not Defined|
|Stand\-Alone Server Default Settings|Disabled|
|DC Effective Default Settings|Disabled|
|Member Server Effective Default Settings|Disabled|
|Client Computer Effective Default Settings|Disabled|

### Operating system version differences
There are no differences in this policy between operating systems beginning with Windows Server 2008 and Windows Vista.

## Policy management
This section describes features and tools that are available to help you manage this policy.

### Restart requirement
A restart of the computer is required before this policy will be effective when changes to this policy are saved locally or distributed through Group Policy.

### Group Policy
This policy can be applied to Windows beginning with Windows Server 2003 and Windows XP.

### Auditing
To audit attempts to access global system objects, you can use one of two security audit policy settings:

-   **Audit Kernel Object** in Advanced Security Audit Policy Settings\\Object Access

-   **Audit Object Access** under Security Settings\\Local Policies\\Audit Policy

If possible, use the Advanced Security Audit Policy option to reduce the number of unrelated audit events that you generate. For more information, see [Which Versions of Windows Support Advanced Audit Policy Configuration?](https://technet.microsoft.com/library/dd692792.aspx)

If the **Audit Kernel Object** setting is configured, the following events are generated. The events appear on computers running  Windows Server 2008 R2 , Windows Server 2008,  Windows 7 , or Windows Vista.

|Event ID|Event Message|
|------------|-----------------|
|4659|A handle to an object was requested with intent to delete.|
|4660|An object was deleted.|
|4661|A handle to an object was requested.|
|4663|An attempt was made to access an object.|

If the **Audit Object Access** setting is configured, the following events are generated.

|Event ID|Event Message|
|------------|-----------------|
|560|Access was granted to an already existing object.|
|562|A handle to an object was closed.|
|563|An attempt was made to open an object with the intent to delete it. **Note:** This is used by file systems when the FILE\_DELETE\_ON\_CLOSE flag is specified in Createfile\(\).|
|564|A protected object was deleted.|
|565|Access was granted to an already existing object type.|
|567|A permission associated with a handle was used. **Note:** A handle is created with certain granted permissions \(Read, Write, and so on\). When the handle is used, up to one audit is generated for each of the permissions that was used.|
|569|The resource manager in Authorization Manager attempted to create a client context.|
|570|A client attempted to access an object. **Note:** An event will be generated for every attempted operation on the object.|

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
A globally visible named object, if incorrectly secured, could be acted upon by malicious software by using the name of the object. For instance, if a synchronization object such as a mutex had a poorly chosen discretionary access control list \(DACL\), malicious software could access that mutex by name and cause the program that created it to malfunction. However, the risk of such an occurrence is very low.

### Countermeasure
Enable the **Audit: Audit the access of global system objects** setting.

### Potential impact
If you enable the **Audit: Audit the access of global system objects** setting, a large number of security events could be generated, especially on busy domain controllers and application servers. Such an occurrence could cause servers to respond slowly and force the Security log to record numerous events of little significance. This policy setting can only be enabled or disabled, and there is no way to choose which events are recorded from this setting. Even organizations that have the resources to analyze events that are generated by this policy setting are not likely to have the source code or a description of what each named object is used for. Therefore, it is unlikely that most organizations would benefit by enabling this policy setting.

To reduce the number of audit events generated, use the advanced audit policy. There are some restrictions that apply. For more information, see [Which Versions of Windows Support Advanced Audit Policy Configuration?](https://technet.microsoft.com/library/dd692792.aspx)

## Additional resources
For the advanced audit policy options, see [Audit Kernel Object](assetId:///d67051ac-67fc-4325-8257-3311b41b5e08).

For basic audit policy, see [Audit object access](https://technet.microsoft.com/library/cc776774.aspx).



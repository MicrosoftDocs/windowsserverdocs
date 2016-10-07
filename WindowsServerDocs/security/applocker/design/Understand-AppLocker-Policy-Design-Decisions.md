---
title: Understand AppLocker Policy Design Decisions
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c7314c80-5c18-4385-bc83-98014c5ecc0c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Understand AppLocker Policy Design Decisions

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional lists the design questions, possible answers, and ramifications of the decisions when you plan a deployment of application control policies by using AppLocker within a Windows operating system environment.

When you begin the design and planning process, you should consider the ramifications of your design choices. The resulting decisions will affect your policy deployment scheme and subsequent application control policy maintenance.

You should consider using AppLocker as part of your organization's application control policies if all the following are true:

-   You have deployed or plan to deploy the supported versions of Windows in your organization. For specific operating system version requirements, see [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md).

-   You need improved control over the access to your organization's applications and the data your users access.

-   The number of applications in your organization is known and manageable.

-   You have resources to test policies against the organization's requirements.

-   You have resources to involve Help Desk or to build a self-help process for end-user application access issues.

-   The group's requirements for productivity, manageability, and security can be controlled by restrictive policies.

The following questions are not in priority or sequential order. They should be considered when you deploy application control policies (as appropriate for your targeted environment).

### Which applications do you need to control in your organization?
You might need to control a limited number of applications because they access sensitive data, or you might have to exclude all applications except those that are sanctioned for business purposes. There might be certain business groups that require strict control, and others that promote independent application usage.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Control all applications|AppLocker policies control applications by creating an allowed list of applications by file type. Exceptions are also possible. AppLocker policies can only be applied to applications installed on computers running one of the supported versions of Windows. For specific operating system version requirements, see [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md). If versions of Windows operating systems earlier than  Windows Server 2008 R2  or  Windows 7  are also deployed, you can use Software Restriction Policies (SRP) with AppLocker.|
|Control specific applications|When you create AppLocker rules, a list of allowed applications is created. All applications on that list will be allowed to run (except those on the exception list). Applications that are not on the list will be prevented from running. AppLocker policies can only be applied to applications installed on computers running any of the supported versions of Windows. For specific operating system version requirements, see [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md).|
|Control only classic apps, only Windows Store apps, or both|AppLocker policies control applications by creating an allowed list of applications by file type. Because Windows Store apps are categorized under the Publisher condition, desktop apps and Windows Store apps can be controlled together. AppLocker policies for Windows Store apps can be applied only to applications that are installed on computers that support the Windows Store, but desktop applications can be controlled with AppLocker on all supported versions of Windows. The rules you currently have configured for classic desktop applications can remain, and you can create new ones for Windows Store apps.<br /><br />For a comparison of desktop applications and Windows Store apps, see [Comparing classic desktop applications and Windows Store apps for AppLocker policy design decisions](#BKMK_CompareClassicMetro) in this topic.|
|Control applications by business group and user|Similar to SRP, AppLocker policies can be applied through a Group Policy Object (GPO) to computer objects within an organizational unit (OU). Individual AppLocker rules can be applied to individual users or to groups of users. SRP policies can be used without modification for Windows operating systems earlier than  Windows Server 2008 R2  and  Windows 7 , but there are special considerations when they are used in the same GPO as AppLocker policies.|
|Control applications by computer, not user|AppLocker is a computer-based policy implementation. If your domain or site organizational structure is not based on a logical user structure, such as an OU, you might want to set up that structure before you begin your AppLocker planning. Otherwise, you will have to identify users, their computers, and their application access requirements.|
|Understand application usage, but there is no need to control any applications yet|AppLocker policies can be set to audit application usage to help you track which applications are used in your organization. You can then use the AppLocker event log to create AppLocker policies.|

> [!IMPORTANT]
> The following list contains files or types of files that cannot be managed by AppLocker:
> 
> -   AppLocker does not protect against running 16-bit DOS binaries in a NT Virtual DOS Machine (NTVDM). This technology allows running legacy DOS and 16-bit Windows programs on computers that are using Intel 80386 or higher when there is already another operating system running and controlling the hardware. The result is that 16-bit binaries can still run on  Windows Server 2008 R2  and  Windows 7  when AppLocker is configured to otherwise block binaries and libraries. If it is a requirement to prevent 16-bit applications from running, you must configure the Deny rule in the Executable rule collection for NTVDM.exe.
> -   You cannot use AppLocker (or Software Restriction Policies) to prevent code from running outside the Win32 subsystem. In particular, this applies to the (POSIX) subsystem in Windows NT. If it is a requirement to prevent applications from running in the POSIX subsystem, you must disable the subsystem. For more information, see [Disabling the POSIX Subsystem](http://go.microsoft.com/fwlink/?LinkId=209767).
> -   AppLocker can only control VBScript, JScript, .bat files, .cmd files and Windows PowerShell scripts. It does not control all interpreted code that runs within a host process, for example Perl scripts and macros. Interpreted code is a form of executable code that runs within a host process. For example, Windows batch files (*.bat) run within the context of the Windows Command Host (cmd.exe). To use AppLocker to control interpreted code, the host process must call AppLocker before it runs the interpreted code, and then enforce the decision that is returned by AppLocker. Not all host processes call into AppLocker. Therefore, AppLocker cannot control every kind of interpreted code, for example Microsoft Office macros.
> 
>     > [!IMPORTANT]
>     > You should configure the appropriate security settings of these host processes if you must allow them to run. For example, configure the security settings in Microsoft Office to ensure that only signed and trusted macros are loaded.
> -   AppLocker rules allow or prevent an application from launching. AppLocker does not control the behavior of applications after they are launched. Applications could contain flags that are passed to functions that signal AppLocker to circumvent the rules and allow another .exe or .dll file to be loaded. In practice, an application that is allowed by AppLocker could use these flags to bypass AppLocker rules and launch child processes. You must follow a process that best suits your needs to thoroughly vet each application before allowing them to run using AppLocker rules.
> 
>     For more information, see [Security Considerations for AppLocker](../get-started/Security-Considerations-for-AppLocker.md).

### <a name="BKMK_CompareClassicMetro"></a>Comparing classic desktop applications and Windows Store apps for AppLocker policy design decisions
AppLocker policies for Windows Store apps can only be applied to applications that are installed on computers running Windows operating systems that support Windows Store apps. However, desktop applications can be controlled in Windows Server 2008 R2 and Windows 7, in addition to those computers that support Windows Store apps. The rules for desktop applications and Windows Store apps can be enforced together. The differences you should consider for Windows Store apps are:

-   All Windows Store apps can be installed by a standard user, whereas a number of classic desktop applications require administrative credentials to install. So in an environment where most of the users are standard users, you might not need numerous Exe rules, but you might want more explicit policies for packaged apps.

-   Desktop applications can be written to change the system state if they run with administrative credentials. Most Windows Store apps cannot change the system state because they run with limited permissions. When you design your AppLocker policies, it is important to understand whether an app that you are allowing can make system-wide changes.

-   Windows Store apps can be acquired through the Microsoft AppStore, or they can be side-loaded by using Windows PowerShell cmdlets. If you use Windows PowerShell cmdlets, a special Enterprise license is required to acquire Windows Store apps. Desktop applications can be acquired through traditional means, such as through software vendors or retail distribution.

AppLocker controls Windows Store apps and desktop applications by using different rule collections. You have the choice to control the Windows Store app, the desktop applications, or both.

For more information, see [Packaged Apps and Packaged App Installer Rules in AppLocker](../../access-control/Packaged-Apps-and-Packaged-App-Installer-Rules-in-AppLocker.md).

### How do you currently control application usage in your organization?
Most organizations have evolved application control policies and methods over time. With heightened security concerns and an emphasis on tighter IT control over desktop use, your organization might decide to consolidate application control practices or design a comprehensive application control scheme. AppLocker includes improvements over SRP in the architecture and management of application control policies.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Security polices (locally set or through Group Policy)|Using AppLocker requires increased effort in planning to create correct policies, but this results in a simpler distribution method.|
|Specific SRP polices|Using AppLocker does not require rewriting SRP rules for computers running versions of Windows operating systems earlier than  Windows Server 2008 R2  or  Windows 7 . However, you must evaluate existing SRP rules if you use AppLocker with SRP in the supported versions of Windows.  For specific operating system version requirements, see [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md).|
|Non-Microsoft application control software|Using AppLocker requires a complete application control policy evaluation and implementation.|
|Managed usage by group or OU|Using AppLocker requires a complete application control policy evaluation and implementation.|
|Authorization Manager or other role-based access technologies|Using AppLocker requires a complete application control policy evaluation and implementation.|
|Other|Using AppLocker requires a complete application control policy evaluation and implementation.|

### Which Windows desktop and server operating systems are running in your organization?
If your organization supports multiple Windows operating systems, application control policy planning becomes more complex. Your initial design decisions should consider the security and management priorities of applications that are installed on each version of the operating system.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Your organization's computers are running a combination of the following operating systems:<br /><br />-   Windows 8<br />-    Windows 7 <br />-   Windows Vista<br />-   Windows XP<br />-    Windows Server 2012 <br />-    Windows Server 2008 R2 <br />-   Windows Server 2008<br />-   Windows Server 2003|AppLocker rules are only applied to computers running the supported versions of Windows, but SRP rules can be applied to all versions of Windows beginning with Windows XP and Windows Server 2003. For specific operating system version requirements, see [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md). **Note:** If you are using the Basic User security level as assigned in SRP, those privileges are not supported on computers running that support AppLocker.<br /><br />AppLocker policies as applied through a GPO take precedence over SRP policies in the same or linked GPO. SRP policies can be created and maintained the same way.|
|Your organization's computers are running only the following operating systems:<br /><br />-    Windows Server 2012 R2 <br />-    Windows Server 2012 <br />-    Windows Server 2008 R2 <br />-   Windows 8.1<br />-   Windows 8<br />-    Windows 7 |Use AppLocker to create your application control policies.|

### Are there specific groups in your organization that need customized application control policies?
Most business groups or departments have specific security requirements that pertain to data access and the applications used to access that data. You should consider the scope of the project for each group and the group’s priorities before you deploy application control policies for the entire organization.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Yes|For each group, you need to create a list that includes their application control requirements. Although this may increase the planning time, it will most likely result in a more effective deployment.<br /><br />If your GPO structure is not currently configured so that you can apply different policies to specific groups, you can alternatively apply AppLocker rules in a GPO to specific user groups.|
|No|AppLocker policies can be applied globally to applications that are installed on computers running the supported versions of Windows as listed in [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md). Depending on the number of applications you need to control, managing all the rules and exceptions might be challenging.|

### Does your IT department have resources to analyze application usage, and to design and manage the policies?
The time and resources that are available to you to perform the research and analysis can affect the detail of your plan and processes for continuing policy management and maintenance.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Yes|Invest the time to analyze your organization's application control requirements, and plan a complete deployment that uses rules that are as simply constructed as possible.|
|No|Consider a focused and phased deployment for specific groups by using a small number of rules. As you apply controls to applications in a specific group, learn from that deployment to plan your next deployment.|

### Does your organization have Help Desk support?
Preventing your users from accessing known, deployed, or personal applications will initially cause an increase in end-user support. It will be necessary to address the various support issues in your organization so security policies are followed and business workflow is not hampered.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Yes|Involve the support department early in the planning phase because your users may inadvertently be blocked from using their applications, or they may seek exceptions to use specific applications.|
|No|Invest time in developing online support processes and documentation before deployment.|

### Do you know what applications require restrictive policies?
Any successful application control policy implementation is based on your knowledge and understanding of application usage within the organization or business group. In addition, the application control design is dependent on the security requirements for data and the applications that access that data.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Yes|You should determine the application control priorities for a business group and then attempt to design the simplest scheme for their application control policies.|
|No|You will have to perform an audit and requirements gathering project to discover the application usage. AppLocker provides the means to deploy policies in **Audit only** mode, and tools to view the event logs.|

### How do you deploy or sanction applications (upgraded or new) in your organization?
Implementing a successful application control policy is based on your knowledge and understanding of application usage within the organization or business group. In addition, the application control design is dependent on the security requirements for data and the applications that access that data. Understanding the upgrade and deployment policy will help shape the construction of the application control policies.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Ad hoc|You need to gather requirements from each group. Some groups might want unrestricted access or installation, while other groups might want strict controls.|
|Strict written policy or guidelines to follow|You need to develop AppLocker rules that reflect those policies, and then test and maintain the rules.|
|No process in place|You need to determine if you have the resources to develop an application control policy, and for which groups.|

### Does your organization already have SRP deployed?
Although SRP and AppLocker have the same goal, AppLocker is a major revision of SRP.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Yes|You cannot use AppLocker to manage SRP settings, but you can use SRP to manage application control policies on computers running on any of the supported operating systems listed in [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md). In addition, if AppLocker and SRP settings are configured in the same GPO, only the AppLocker settings will be enforced on computers running those supported operating systems. **Note:** If you are using the Basic User security level as assigned in SRP, those permissions are not supported on computers running the supported operating systems.|
|No|Policies that are configured for AppLocker can only be applied to computers running the supported operating systems, but SRP is also available on those operating systems.|

### What are your organization's priorities when implementing application control policies?
Some organizations will benefit from application control policies as shown by an increase in productivity or conformance, while others will be hindered in performing their duties. Prioritize these aspects for each group to allow you to evaluate the effectiveness of AppLocker.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Productivity: The organization assures that tools work and required applications can be installed.|To meet innovation and productivity goals, some groups require the ability to install and run a variety of software from different sources, including software that they developed. Therefore, if innovation and productivity is a high priority, managing application control policies through an allowed list might be time consuming and an impediment to progress.|
|Management: The organization is aware of and controls the applications it supports.|In some business groups, application usage can be managed from a central point of control. AppLocker policies can be built into a GPO for that purpose. This shifts the burden of application access to the IT department, but it also has the benefit of controlling the number of applications that can be run and controlling the versions of those applications.|
|Security: The organization must protect data in part by ensuring that only approved applications are used.|AppLocker can help protect data by allowing a defined set of users access to applications that access the data. If security is the top priority, the application control policies will be the most restrictive.|

### How are applications currently accessed in your organization?
AppLocker is very effective for organizations that have application restriction requirements if they have environments with a simple topography and  application control policy goals that are straightforward. For example, AppLocker can benefit an environment where non-employees have access to computers that are connected to the organizational network, such as a school or library. Large organizations also benefit from AppLocker policy deployment when the goal is to achieve a detailed level of control on the desktop computers with a relatively small number of applications to manage, or when the applications are manageable with a small number of rules.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Users run without administrative rights.<br /><br />Applications are installed by using an installation deployment technology.|AppLocker can help reduce the total cost of ownership for business groups that typically use a finite set of applications, such as human resources and finance departments. At the same time, these departments access highly sensitive information, much of which contains confidential and proprietary information. By using AppLocker to create rules for specific applications that are allowed to run, you can help limit unauthorized applications from accessing this information. **Note:** AppLocker can also be effective in helping create standardized desktops in organizations where users run as administrators. However, it is important to note that users with administrativecredentials can add new rules to the local AppLocker policy.|
|Users must be able to install applications as needed.<br /><br />Users currently have administrator access, and it would be difficult to change this.|Enforcing AppLocker rules is not suited for business groups that must be able to install applications as needed and without approval from the IT department. If one or more OUs in your organization has this requirement, you can choose not to enforce application rules in those OUs by using AppLocker or to implement the **Audit only** enforcement setting through AppLocker.|

### Is the structure in Active Directory Domain Services based on the organization's hierarchy?
Designing application control policies based on an organizational structure that is already built into Active Directory Domain Services (AD DS) is easier than converting the existing structure to an organizational structure. Because the effectiveness of application control policies is dependent on the ability to update policies, consider what organizational work needs to be accomplished before deployment begins.

|Possible answers|Design considerations|
|--------------------|-------------------------|
|Yes|AppLocker rules can be developed and implemented through Group Policy, based on your AD DS structure.|
|No|The IT department must create a scheme to identify how application control policies can be applied to the correct user or computer.|

## Record your findings
The next step in the process is to record and analyze your answers to the preceding questions. If AppLocker is the right solution for your goals, tyou can set your application control policy objectives and plan your AppLocker rules. This process culminates in creating your planning document.

-   For information about setting your policy goals, see [Determine Your Application Control Objectives](Determine-Your-Application-Control-Objectives.md).

-   For information about creating your planning document, see [Create Your AppLocker Planning Document](Create-Your-AppLocker-Planning-Document.md).



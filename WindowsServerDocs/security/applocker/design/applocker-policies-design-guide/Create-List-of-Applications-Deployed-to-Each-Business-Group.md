---
title: Create List of Applications Deployed to Each Business Group
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bf13e40c-2ca3-448d-bba7-e14575cab2b9
---
# Create List of Applications Deployed to Each Business Group
This topic describes the process of gathering application usage requirements from each business group in order to implement application control policies by using AppLocker.

## Determining application usage
For each business group, determine the following:

-   The complete list of applications used, including different versions of an application.

-   The full installation path of the application.

-   The publisher and signed status of each application.

-   The type of requirement the business groups set for each application, such as business critical, business productivity, optional, or personal. It might also be helpful during this effort to identify which applications are supported or unsupported by your IT department, or supported by others outside your control.

-   A list of files or applications that require administrative credentials to install or run. If the file requires administrative credentials to install or run, users who cannot provide administrative credentials will be prevented from running the file even if the file is explicitly allowed by an AppLocker policy. Even with AppLocker policies enforced, only members of the Administrators group can install or run files that require administrative credentials.

### How to perform the application usage assessment
Although you might already have a method in place to understand application usage for each business group, you will need to use this information to help create your AppLocker rule collection. AppLocker includes the Automatically Generate Rules wizard and the **Audit only** enforcement configuration to assist you with planning and creating your rule collection.

**Application inventory methods**

Using the Automatically Generate Rules wizard quickly creates rules for the applications you specify. The wizard is designed specifically to build a rule collection. You can use the Local Security Policy snap\-in to view and edit the rules. This method is very useful when creating rules from a reference computer, and when creating and evaluating AppLocker policies in a testing environment. However, it does require that the files be accessible on the reference computer or through a network drive. This might mean additional work in setting up the reference computer and determining a maintenance policy for that computer.

Using the **Audit only** enforcement method permits you to view the logs because it collects information about every process on the computers receiving the Group Policy Object \(GPO\). Therefore, you can see what the enforcement will be on the computers in a business group. AppLocker includes Windows PowerShell cmdlets that you can use to analyze the events from the event log and cmdlets to create rules. However, when you use Group Policy to deploy to several computers, a means to collect events in a central location is very important for manageability. Because AppLocker logs information about files that users or other processes start on a computer, you could miss creating some rules initially. Therefore, you should continue your evaluation until you can verify that all required applications that are allowed to run are accessed successfully.

> [!TIP]
> If you run Application Verifier against a custom application with any AppLocker policies enabled, it might prevent the application from running. You should either disable Application Verifier or AppLocker.
> 
> You can create an inventory of Windows 8 apps on a computer by using two methods: the **Get\-AppxPackage** Windows PowerShell cmdlet or the AppLocker UI.

The following topics in the [AppLocker Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkId=160261) describe how to perform each method:

-   [Automatically Generating Executable Rules from a Reference Computer](http://go.microsoft.com/fwlink/?LinkId=160264)

-   [Using Auditing to Track Which Applications Are Used](http://go.microsoft.com/fwlink/?LinkId=160281)

### Prerequisites to completing the inventory
Identify the business group and each organizational unit \(OU\) within that group to which you will apply application control policies. In addition, you should have identified whether or not AppLocker is the most appropriate solution for these policies. For information about these steps, see the following topics:

-   [Understand AppLocker Policy Design Decisions](Understand-AppLocker-Policy-Design-Decisions.md)

-   [Determine Your Application Control Objectives](Determine-Your-Application-Control-Objectives.md)

## Next steps
Identify and develop the list of applications. Record the name of the application, whether it is signed or not as indicated by the publisher's name, and whether or not it is a mission critical, business productivity, optional, or personal application. Record the installation path of the applications. For information about how to do this, see [Document Your Application List]().

After you have created the list of applications, the next step is to identify the rule collections, which will become the policies. This information can be added to the table under columns labeled:

-   Use default rule or define new rule condition

-   Allow or deny

-   GPO name

To do this, see the following topics:

-   [Select Types of Rules to Create](Select-Types-of-Rules-to-Create.md)

-   [Determine Group Policy Structure and Rule Enforcement](Determine-Group-Policy-Structure-and-Rule-Enforcement.md)



---
title: Document Group Policy Structure and AppLocker Rule Enforcement
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 85ae8698-043e-4f8d-9359-fe58495adbc1
---
# Document Group Policy Structure and AppLocker Rule Enforcement
This planning topic describes what you need to investigate, determine, and record in your application control policies plan when you use AppLocker.

## Record your findings
To complete this AppLocker planning document, you should first complete the following steps:

1.  [Determine Your Application Control Objectives](Determine-Your-Application-Control-Objectives.md)

2.  [Create List of Applications Deployed to Each Business Group](Create-List-of-Applications-Deployed-to-Each-Business-Group.md)

3.  [Select Types of Rules to Create](Select-Types-of-Rules-to-Create.md)

4.  [Determine Group Policy Structure and Rule Enforcement](Determine-Group-Policy-Structure-and-Rule-Enforcement.md)

After you determine how to structure your Group Policy Objects (GPOs) so that you can apply AppLocker policies, you should record your findings. You can use the following table to determine how many GPOs to create (or edit) and which objects they are linked to. If you decided to create custom rules to allow system files to run, note the high-level rule configuration in the **Use default rule or define new rule condition** column.

The following table includes the sample data that was collected when you determined your enforcement settings and the GPO structure for your AppLocker policies.

|Business group|Organizational unit|Implement AppLocker?|Applications|Installation path|Use default rule or define new rule condition|Allow or deny|GPO name|
|------------------|-----------------------|------------------------|----------------|---------------------|-------------------------------------------------|-----------------|------------|
|Bank Tellers|Teller-East and Teller-West|Yes|Teller Software|C:\Program Files\Woodgrove\Teller.exe|File is signed; create a publisher condition|Allow|Tellers-AppLockerTellerRules|
||||Windows files|C:\Windows|Create a path exception to the default rule to exclude \Windows\Temp|Allow||
|Human Resources|HR-All|Yes|Check Payout|C:\Program Files\Woodgrove\HR\Checkcut.exe|File is signed; create a publisher condition|Allow|HR-AppLockerHRRules|
||||Time Sheet Organizer|C:\Program Files\Woodgrove\HR\Timesheet.exe|File is not signed; create a file hash condition|Allow||
||||Internet Explorer 7|C:\Program Files\Internet Explorer\|File is signed; create a publisher condition|Deny||
||||Windows files|C:\Windows|Use a default rule for the Windows path|Allow||

> [!NOTE]
> Excluding  Windows Server 2008 R2  and  Windows 7 , AppLocker can manage Windows Store apps. For information about how to add rules for these apps to your existing GPO, see [Add Rules for Packaged Apps to Existing AppLocker Rule-set](Add-Rules-for-Packaged-Apps-to-Existing-AppLocker-Rule-set.md).

## Next steps
After you have determined the Group Policy structure and rule enforcement strategy for each business group's applications, the following tasks remain:

-   [Plan for AppLocker Policy Management](Plan-for-AppLocker-Policy-Management.md)

-   [Create Your AppLocker Planning Document](Create-Your-AppLocker-Planning-Document.md)



---
title: Document Your applocker Rules
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f1e7631-38b9-4520-b178-7100b84dd617
---
# Document Your applocker Rules
This topic describes what rule conditions to associate with each file, how to associate the rule conditions with each file, the source of the rule, and whether the file should be included or excluded.

## Record your findings
To complete this applocker planning document, you should first complete the following steps:

1.  [Determine Your Application Control Objectives]()

2.  [Create List of Applications Deployed to Each Business Group]()

3.  [Select Types of Rules to Create]()

Document the following items for each business group or organizational unit:

-   Whether your organization will use the built\-in default applocker rules to allow system files to run.

-   The types of rule conditions that you will use to create rules, stated in order of preference.

The following table details sample data for documenting rule type and rule condition findings. In addition, you should now consider whether to allow an application to run or deny permission for it to run. For information about these settings, see [Understanding applocker Allow and Deny Actions on Rules]().

|Business group|Organizational unit|Implement applocker?|Applications|Installation path|Use default rule or define new rule condition|Allow or deny|
|------------------|-----------------------|------------------------|----------------|---------------------|-------------------------------------------------|-----------------|
|Bank Tellers|Teller\-East and Teller\-West|Yes|Teller Software|C:\\Program Files\\Woodgrove\\Teller.exe|File is signed; create a publisher condition||
||||Windows files|C:\\Windows|Create a path exception to the default rule to exclude \\Windows\\Temp||
|Human Resources|HR\-All|Yes|Check Payout|C:\\Program Files\\Woodgrove\\HR\\Checkcut.exe|File is signed; create a publisher condition||
||||Time Sheet Organizer|C:\\Program Files\\Woodgrove\\HR\\Timesheet.exe|File is not signed; create a file hash condition||
||||Internet Explorer 7|C:\\Program Files\\Internet Explorer\\|File is signed; create a publisher condition||
||||Windows files|C:\\Windows|Use the default rule for the Windows path||

## Next steps
For each rule, determine whether to use the allow or deny option. Then, three tasks remain:

-   [Determine Group Policy Structure and Rule Enforcement]()

-   [Plan for applocker Policy Management]()

-   [Create Your applocker Planning Document]()



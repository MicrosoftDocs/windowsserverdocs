---
title: Document Your Application Control Management Processes
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: af11f3a3-0bbe-4352-8470-e48d0c320da2
---
# Document Your Application Control Management Processes
This planning topic describes the AppLocker policy maintenance information to record for your design document.  
  
## Record your findings  
To complete this AppLocker planning document, you should first complete the following steps:  
  
1.  [Determine Your Application Control Objectives](../Topic/Determine-Your-Application-Control-Objectives.md)  
  
2.  [Create List of Applications Deployed to Each Business Group](../Topic/Create-List-of-Applications-Deployed-to-Each-Business-Group.md)  
  
3.  [Select Types of Rules to Create](../Topic/Select-Types-of-Rules-to-Create.md)  
  
4.  [Determine Group Policy Structure and Rule Enforcement](../Topic/Determine-Group-Policy-Structure-and-Rule-Enforcement.md)  
  
5.  [Plan for AppLocker Policy Management](../Topic/Plan-for-AppLocker-Policy-Management.md)  
  
The three key areas to determine for AppLocker policy management are:  
  
1.  Support policy  
  
    Document the process that you will use for handling calls from users who have attempted to run a blocked application, and ensure that support personnel know recommended troubleshooting steps and escalation points for your policy.  
  
2.  Event processing  
  
    Document whether events will be collected in a central location, how that store will be archived, and whether the events will be processed for analysis.  
  
3.  Policy maintenance  
  
    Detail how rules will be added to the policy, in which Group Policy Object \(GPO\) the rules should be defined, and how to modify rules when applications are retired, updated, or added.  
  
The following table contains the added sample data that was collected when determining how to maintain and manage AppLocker policies.  
  
|Business group|Organizational unit|Implement AppLocker?|Applications|Installation path|Use default rule or define new rule condition|Allow or deny|GPO name|Support policy|  
|------------------|-----------------------|------------------------|----------------|---------------------|-------------------------------------------------|-----------------|------------|------------------|  
|Bank Tellers|Teller\-East and Teller\-West|Yes|Teller Software|C:\\Program Files\\Woodgrove\\Teller.exe|File is signed; create a publisher condition|Allow|Tellers\-AppLockerTellerRules|Web help|  
||||Windows files|C:\\Windows|Create a path exception to the default rule to exclude \\Windows\\Temp|Allow||Help desk|  
|Human Resources|HR\-All|Yes|Check Payout|C:\\Program Files\\Woodgrove\\HR\\Checkcut.exe|File is signed; create a publisher condition|Allow|HR\-AppLockerHRRules|Web help|  
||||Time Sheet Organizer|C:\\Program Files\\Woodgrove\\HR\\Timesheet.exe|File is not signed; create a file hash condition|Allow||Web help|  
||||Internet Explorer 7|C:\\Program Files\\Internet Explorer\\|File is signed; create a publisher condition|Deny||Web help|  
||||Windows files|C:\\Windows|Use the default rule for the Windows path|Allow||Help desk|  
  
The following two tables illustrate examples of documenting considerations to maintain and manage AppLocker policies.  
  
**Event processing policy**  
  
One discovery method for application usage is to set the AppLocker enforcement mode to **Audit only**. This will write events to the AppLocker logs, which can be managed and analyzed like other Windows logs. After applications have been identified, you can begin to develop policies regarding the processing and access to AppLocker events.  
  
The following table is an example of what to consider and record.  
  
|Business group|AppLocker event collection location|Archival policy|Analyzed?|Security policy|  
|------------------|---------------------------------------|-------------------|-------------|-------------------|  
|Bank Tellers|Forwarded to: AppLocker Event Repository on srvBT093|Standard|None|Standard|  
|Human Resources|DO NOT FORWARD. srvHR004|60 months|Yes, summary reports monthly to managers|Standard|  
  
**Policy maintenance policy**  
  
When applications are identified and policies are created for application control, then you can begin documenting how you intend to update those policies.  
  
The following table is an example of what to consider and record.  
  
|Business group|Rule update policy|Application decommission policy|Application version policy|Application deployment policy|  
|------------------|----------------------|-----------------------------------|------------------------------|---------------------------------|  
|Bank Tellers|Planned: Monthly through business office triage<br /><br />Emergency: Request through help desk|Through business office triage<br /><br />30\-day notice required|General policy: Keep past versions for 12 months<br /><br />List policies for each application|Coordinated through business office<br /><br />30\-day notice required|  
|Human Resources|Planned: Monthly through HR triage<br /><br />Emergency: Request through help desk|Through HR triage<br /><br />30\-day notice required|General policy: Keep past versions for 60 months<br /><br />List policies for each application|Coordinated through HR<br /><br />30\-day notice required|  
  
## Next steps  
After you have determined your application control management strategy for each of the business group's applications, the following task remains:  
  
-   [Create Your AppLocker Planning Document](../Topic/Create-Your-AppLocker-Planning-Document.md)  
  

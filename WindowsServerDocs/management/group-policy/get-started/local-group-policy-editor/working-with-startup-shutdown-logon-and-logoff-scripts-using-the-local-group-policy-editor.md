---
title: Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy editor
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5079255a-674b-4c8c-b890-184c8b7b32a4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy editor

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to use the Local Group Policy editor (gpedit) to manage four types of event-driven scripting files.  
  
## Introduction  
Group Policy allows you to associate one or more scripting files with four triggered events:  
  
-   computer startup  
  
-   computer shutdown  
  
-   User logon  
  
-   User logoff  
  
You can use Windows PowerShell scripts, or author scripts in any other language supported by the client computer. Windows Script Host (WSH) supported languages are also used, including VBScript and Jscript. For more information about the editor, see [Local Group Policy editor](../local-group-policy-editor.md).  
  
### additional considerations  
  
-   for more information about scripting, see the Group Policy Script Center ([http://go.microsoft.com/fwlink/?LinkID=66013](http://go.microsoft.com/fwlink/?LinkID=66013)).  
  
-   Local Group Policy editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign computer startup scripts  
  
#### To assign computer startup scripts  
  
1.  Open the Local Group Policy editor.  
  
2.  In the console tree, click **Scripts (startup/shutdown)**. The path is **computer Configuration\Windows Settings\Scripts (startup/shutdown)**.  
  
3.  In the results pane, double-click **startup**.  
  
4.  In the **startup Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In the **Script Name** box, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In the **Script Parameters** box, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **startup Properties** dialog box, specify the options that you want:  
  
    -   **startup Scripts for <Group Policy object>**: lists all the scripts that currently are assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **startup Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### additional considerations  
  
-   To complete this procedure, you must have edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have edit setting permission to edit a GPO.  
  
-   startup scripts are run under the Local System account, and they have the full rights that are associated with being able to run under the Local System account.  
  
-   Beginning in Windows Vista, startup scripts are run asynchronously, by default. This is a different behavior from earlier operating systems.  
  
-   Setting startup scripts to run synchronously may cause the boot process to run slowly.  
  
-   In  Windows 7  and Windows Vista, startup scripts that are run asynchronously will not be visible. Enabling the **Run startup Scripts Visible** policy setting will have no effect when running startup scripts asynchronously.  
  
-   Local Group Policy editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign computer shutdown scripts  
  
#### To assign computer shutdown scripts  
  
1.  Open the Local Group Policy editor.  
  
2.  In the console tree, click **Scripts (startup/shutdown)**. The path is **computer Configuration\Windows Settings\Scripts (startup/shutdown)**.  
  
3.  In the results pane, double-click **shutdown**.  
  
4.  In the **shutdown Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **shutdown Properties** dialog box, specify the options that you want:  
  
    -   **shutdown Scripts for <Group Policy object>**: lists all the scripts that are currently assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **shutdown Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### additional considerations  
  
-   To complete this procedure, you must have edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have edit setting permission to edit a GPO.  
  
-   shutdown scripts are run as Local System, and they have the full rights that are associated with being able to run as Local System.  
  
-   Setting shutdown scripts to run synchronously may cause the shutdown process to run slowly.  
  
-   Local Group Policy editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign user logon scripts  
  
#### To assign user logon scripts  
  
1.  Open the Local Group Policy editor.  
  
2.  In the console tree, click **Scripts (Logon/logoff)**. The path is **User Configuration\Windows Settings\Scripts (Logon/logoff)**.  
  
3.  In the results pane, double-click **Logon**.  
  
4.  In the **Logon Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **Logon Properties** dialog box, specify the options that you want:  
  
    -   **Logon Scripts for <Group Policy object>**: lists all the scripts that currently are assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **Logon Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### additional considerations  
  
-   To complete this procedure, you must have edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have edit setting permission to edit a GPO.  
  
-   Setting logon scripts to run synchronously may cause the logon process to run slowly.  
  
-   Logon scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
-   Local Group Policy editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign user logoff scripts  
  
#### To assign user logoff scripts  
  
1.  Open the Local Group Policy editor.  
  
2.  In the console tree, click **Scripts (Logon/logoff)**. The path is **User Configuration\Windows Settings\Scripts (Logon/logoff)**.  
  
3.  In the results pane, double-click **logoff**.  
  
4.  In the **logoff Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **logoff Properties** dialog box, specify the options the you want:  
  
    -   **logoff Scripts for <Group Policy object>**: lists all the scripts that currently are assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **logoff Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### additional considerations  
  
-   To complete this procedure, you must have edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have edit setting permission to edit a GPO.  
  
-   logoff scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
-   Setting logoff scripts to run synchronously may cause the logoff process to run slowly.  
  
-   Local Group Policy editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  


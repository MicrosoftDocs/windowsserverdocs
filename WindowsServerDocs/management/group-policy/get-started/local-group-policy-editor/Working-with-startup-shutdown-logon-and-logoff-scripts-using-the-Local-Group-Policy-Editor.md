---
title: Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy Editor
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
# Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy Editor

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes how to use the Local Group Policy Editor (gpedit) to manage four types of event-driven scripting files.  
  
## Introduction  
Group Policy allows you to associate one or more scripting files with four triggered events:  
  
-   Computer startup  
  
-   Computer shutdown  
  
-   User logon  
  
-   User logoff  
  
You can use Windows PowerShell scripts, or author scripts in any other language supported by the client computer. Windows Script Host (WSH) supported languages are also used, including VBScript and Jscript. For more information about the editor, see [Local Group Policy Editor](../Local-Group-Policy-Editor.md).  
  
### Additional considerations  
  
-   For more information about scripting, see the Group Policy Script Center ([http://go.microsoft.com/fwlink/?LinkID=66013](http://go.microsoft.com/fwlink/?LinkID=66013)).  
  
-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign computer startup scripts  
  
#### To assign computer startup scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts (Startup/Shutdown)**. The path is **Computer Configuration\Windows Settings\Scripts (Startup/Shutdown)**.  
  
3.  In the results pane, double-click **Startup**.  
  
4.  In the **Startup Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In the **Script Name** box, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In the **Script Parameters** box, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **Startup Properties** dialog box, specify the options that you want:  
  
    -   **Startup Scripts for <Group Policy object>**: Lists all the scripts that currently are assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Startup Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.  
  
-   Startup scripts are run under the Local System account, and they have the full rights that are associated with being able to run under the Local System account.  
  
-   Beginning in Windows Vista, startup scripts are run asynchronously, by default. This is a different behavior from earlier operating systems.  
  
-   Setting startup scripts to run synchronously may cause the boot process to run slowly.  
  
-   In  Windows 7  and Windows Vista, startup scripts that are run asynchronously will not be visible. Enabling the **Run Startup Scripts Visible** policy setting will have no effect when running startup scripts asynchronously.  
  
-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign computer shutdown scripts  
  
#### To assign computer shutdown scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts (Startup/Shutdown)**. The path is **Computer Configuration\Windows Settings\Scripts (Startup/Shutdown)**.  
  
3.  In the results pane, double-click **Shutdown**.  
  
4.  In the **Shutdown Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **Shutdown Properties** dialog box, specify the options that you want:  
  
    -   **Shutdown Scripts for <Group Policy object>**: Lists all the scripts that are currently assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Shutdown Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.  
  
-   Shutdown scripts are run as Local System, and they have the full rights that are associated with being able to run as Local System.  
  
-   Setting shutdown scripts to run synchronously may cause the shutdown process to run slowly.  
  
-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign user logon scripts  
  
#### To assign user logon scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts (Logon/Logoff)**. The path is **User Configuration\Windows Settings\Scripts (Logon/Logoff)**.  
  
3.  In the results pane, double-click **Logon**.  
  
4.  In the **Logon Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **Logon Properties** dialog box, specify the options that you want:  
  
    -   **Logon Scripts for <Group Policy object>**: Lists all the scripts that currently are assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Logon Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.  
  
-   Setting logon scripts to run synchronously may cause the logon process to run slowly.  
  
-   Logon scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  
## How to assign user logoff scripts  
  
#### To assign user logoff scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts (Logon/Logoff)**. The path is **User Configuration\Windows Settings\Scripts (Logon/Logoff)**.  
  
3.  In the results pane, double-click **Logoff**.  
  
4.  In the **Logoff Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called //logo (display banner) and //I (interactive mode), type **//logo //I**.  
  
6.  In the **Logoff Properties** dialog box, specify the options the you want:  
  
    -   **Logoff Scripts for <Group Policy object>**: Lists all the scripts that currently are assigned to the selected Group Policy object (GPO). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Logoff Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   To complete this procedure, you must have Edit setting permission to edit a GPO. By default, members of the Domain Administrators security group, the Enterprise Administrators security group, or the Group Policy Creator Owners security group have Edit setting permission to edit a GPO.  
  
-   Logoff scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
-   Setting logoff scripts to run synchronously may cause the logoff process to run slowly.  
  
-   Local Group Policy Editor and the Resultant Set of Policy snap-in are available in Windows Server 2008 R2 and Windows 7 Professional, Windows 7 Ultimate, and Windows 7 Enterprise. For more information, see [http://go.microsoft.com/fwlink/?LinkId=139815](http://go.microsoft.com/fwlink/?LinkId=139815).  
  


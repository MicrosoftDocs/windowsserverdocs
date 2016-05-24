---
title: Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy Editor
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5079255a-674b-4c8c-b890-184c8b7b32a4
author: coreyp
---
# Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy Editor
This topic describes how to use the Local Group Policy Editor \(gpedit\) to manage four types of event\-driven scripting files.  
  
## Introduction  
Group Policy allows you to associate one or more scripting files with four triggered events:  
  
-   Computer startup  
  
-   Computer shutdown  
  
-   User logon  
  
-   User logoff  
  
You can use Windows PowerShell scripts, or author scripts in any other language supported by the client computer. Windows Script Host \(WSH\) supported languages are also used, including VBScript and Jscript. For more information about the editor, see [Local Group Policy Editor](assetId:///0408ec90-e65b-4e50-9e0d-dfd2bd2b4dcb).  
  
### Additional considerations  
  
-   For more information about scripting, see the Group Policy Script Center \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=66013](http://go.microsoft.com/fwlink/?LinkID=66013)\).  
  
-   [!INCLUDE[gpedit_skus](../Token/gpedit_skus_md.md)]  
  
## How to assign computer startup scripts  
  
#### To assign computer startup scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts \(Startup\/Shutdown\)**. The path is **Computer Configuration\\Windows Settings\\Scripts \(Startup\/Shutdown\)**.  
  
3.  In the results pane, double\-click **Startup**.  
  
4.  In the **Startup Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In the **Script Name** box, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In the **Script Parameters** box, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **Startup Properties** dialog box, specify the options that you want:  
  
    -   **Startup Scripts for <Group Policy object>**: Lists all the scripts that currently are assigned to the selected Group Policy object \(GPO\). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Startup Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   [!INCLUDE[gpolicysec](../Token/gpolicysec_md.md)]  
  
-   Startup scripts are run under the Local System account, and they have the full rights that are associated with being able to run under the Local System account.  
  
-   Beginning in [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], startup scripts are run asynchronously, by default. This is a different behavior from earlier operating systems.  
  
-   Setting startup scripts to run synchronously may cause the boot process to run slowly.  
  
-   In [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], startup scripts that are run asynchronously will not be visible. Enabling the **Run Startup Scripts Visible** policy setting will have no effect when running startup scripts asynchronously.  
  
-   [!INCLUDE[gpedit_skus](../Token/gpedit_skus_md.md)]  
  
## How to assign computer shutdown scripts  
  
#### To assign computer shutdown scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts \(Startup\/Shutdown\)**. The path is **Computer Configuration\\Windows Settings\\Scripts \(Startup\/Shutdown\)**.  
  
3.  In the results pane, double\-click **Shutdown**.  
  
4.  In the **Shutdown Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **Shutdown Properties** dialog box, specify the options that you want:  
  
    -   **Shutdown Scripts for <Group Policy object>**: Lists all the scripts that are currently assigned to the selected Group Policy object \(GPO\). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Shutdown Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   [!INCLUDE[gpolicysec](../Token/gpolicysec_md.md)]  
  
-   Shutdown scripts are run as Local System, and they have the full rights that are associated with being able to run as Local System.  
  
-   Setting shutdown scripts to run synchronously may cause the shutdown process to run slowly.  
  
-   [!INCLUDE[gpedit_skus](../Token/gpedit_skus_md.md)]  
  
## How to assign user logon scripts  
  
#### To assign user logon scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts \(Logon\/Logoff\)**. The path is **User Configuration\\Windows Settings\\Scripts \(Logon\/Logoff\)**.  
  
3.  In the results pane, double\-click **Logon**.  
  
4.  In the **Logon Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **Logon Properties** dialog box, specify the options that you want:  
  
    -   **Logon Scripts for <Group Policy object>**: Lists all the scripts that currently are assigned to the selected Group Policy object \(GPO\). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Logon Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   [!INCLUDE[gpolicysec](../Token/gpolicysec_md.md)]  
  
-   Setting logon scripts to run synchronously may cause the logon process to run slowly.  
  
-   Logon scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
-   [!INCLUDE[gpedit_skus](../Token/gpedit_skus_md.md)]  
  
## How to assign user logoff scripts  
  
#### To assign user logoff scripts  
  
1.  Open the Local Group Policy Editor.  
  
2.  In the console tree, click **Scripts \(Logon\/Logoff\)**. The path is **User Configuration\\Windows Settings\\Scripts \(Logon\/Logoff\)**.  
  
3.  In the results pane, double\-click **Logoff**.  
  
4.  In the **Logoff Properties** dialog box, click **Add**.  
  
5.  In the **Add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path to the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, the same way as you would type them on the command line. For example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **Logoff Properties** dialog box, specify the options the you want:  
  
    -   **Logoff Scripts for <Group Policy object>**: Lists all the scripts that currently are assigned to the selected Group Policy object \(GPO\). If you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it and then click **Up**. To move a script down in the list, click it and then click **Down**.  
  
    -   **Add**: Opens the **Add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **Edit**: Opens the **Edit Script** dialog box, where you can modify script information, such as name and parameters.  
  
    -   **Remove**: Removes the selected script from the **Logoff Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
### Additional considerations  
  
-   [!INCLUDE[gpolicysec](../Token/gpolicysec_md.md)]  
  
-   Logoff scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
-   Setting logoff scripts to run synchronously may cause the logoff process to run slowly.  
  
-   [!INCLUDE[gpedit_skus](../Token/gpedit_skus_md.md)]  
  

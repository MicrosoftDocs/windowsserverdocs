---
title: Using startup, shutdown, Logon, and logoff Scripts in Group Policy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b478ee48-6122-40f4-890c-6386d5e2963b
author: coreyp
---
# Using startup, shutdown, Logon, and logoff Scripts in Group Policy
This topic contains procedures for using the GPMC tool to configure and run four types of Group Policy.  
  
This topic describes how to install and use scripts on a domain controller. if you want information about script use for the local computer, see [Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy editor]().  
  
Group Policy allows you to associate one or more scripting files to four triggered events:  
  
-   computer startup  
  
-   computer shutdown  
  
-   User logon  
  
-   User logoff  
  
-   You can use Windows powershell scripts, or author scripts in any other language supported by the client computer. Windows Script Host \(WSH\) supported languages and command files are also used, including VBScript and Jscript.  
  
## How to set up scripts on the domain controller  
  
#### To set up scripts on the domain controller  
  
1.  copy the script and dependent files to the **Netlogon** shared folder on the domain controller.  
  
**additional considerations**  
  
You must be a member of the Domain Administrators security group to configure scripts on a domain controller.  
  
## How to assign computer startup scripts  
  
#### To assign computer startup scripts  
  
1.  Open the Group Policy management Console \(GPMC\). Right\-click the Group Policy Object you want to edit, and then click **edit**.  
  
2.  In the console tree, click **Scripts \(startup\/shutdown\)**. The path is **computer Configuration\\Policies\\Windows Settings\\Scripts \(startup\/shutdown\)**.  
  
3.  In the results pane, double\-click **startup**.  
  
4.  In the **startup Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path of the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, exactly as you would type them on the command line. for example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **startup Properties** dialog box, specify the options that you want:  
  
    -   **startup Scripts for <Group Policy object>**: lists all the scripts that currently are assigned to the selected GPO. if you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it, and then click **Up**. To move a script down in the list, click it, and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can change script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **startup Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
**additional considerations**  
  
-   startup scripts are run under the Local System account, and they have the full rights that are associated with being able to run under the Local System account.  
  
-   startup scripts are run asynchronously, by default.  
  
-   Setting startup scripts to run synchronously may cause the boot process to run slowly.  
  
-   startup scripts that run asynchronously will not be visible. Enabling the **Run startup Scripts Visible Group Policy** setting has no effect when you are running startup scripts asynchronously.  
  
## How to assign computer shutdown scripts  
  
#### To assign computer shutdown scripts  
  
1.  Open the **Group Policy management Console**. Right\-click the Group Policy object you want to edit, and then click **edit**.  
  
2.  In the console tree, click **Scripts \(startup\/shutdown\)**. The path is **computer Configuration\\Policies\\Windows Settings\\Scripts \(startup\/shutdown\)**.  
  
3.  In the results pane, expand **shutdown**.  
  
4.  In the **shutdown Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path of the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, exactly as you would type them on the command line. for example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **shutdown Properties** dialog box, specify the options that you want:  
  
    -   **shutdown Scripts for <Group Policy object>**: lists all the scripts that are currently assigned to the selected Group Policy object \(GPO\). if you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it, and then click **Up**. To move a script down in the list, click it, and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can change script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **shutdown Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
    **additional considerations**  
  
    -   shutdown scripts are run as Local System, and they have the full rights that are associated with being able to run as Local System.  
  
    -   Setting shutdown scripts to run synchronously may cause the shutdown process to run slowly.  
  
## How to assign user logon scripts  
  
#### To assign user logon scripts  
  
1.  Open the **Group Policy management Console**. Right\-click the Group Policy object you want to edit, and then click **edit**.  
  
2.  In the console tree, click **Scripts \(Logon\/logoff\)**. The path is **User Configuration\\Policies\\Windows Settings\\Scripts \(Logon\/logoff\)**.  
  
3.  In the results pane, expand **Logon**.  
  
4.  In the **Logon Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path of the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, exactly as you would type them on the command line. for example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **Logon Properties** dialog box, specify the options that you want:  
  
    -   **Logon Scripts for <Group Policy object>**: lists all the scripts that currently are assigned to the selected Group Policy object \(GPO\). if you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it, and then click **Up**. To move a script down in the list, click it, and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can change script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **Logon Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
**additional considerations**  
  
-   Setting logon scripts to run synchronously may cause the logon process to run slowly.  
  
-   Logon scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
## How to assign user logoff scripts  
  
#### To assign user logoff scripts  
  
1.  Open the **Group Policy management Console**. Right\-click the Group Policy object you want to edit, and then click **edit**.  
  
2.  In the console tree, click **Scripts \(Logon\/logoff\)**. The path is **User Configuration\\Policies\\Windows Settings\\Scripts \(Logon\/logoff\)**.  
  
3.  In the results pane, expand **logoff**.  
  
4.  In the **logoff Properties** dialog box, click **add**.  
  
5.  In the **add a Script** dialog box, do the following:  
  
    -   In **Script Name**, type the path of the script, or click **Browse** to search for the script file in the Netlogon shared folder on the domain controller.  
  
    -   In **Script Parameters**, type any parameters that you want, exactly as you would type them on the command line. for example, if your script includes parameters called \/\/logo \(display banner\) and \/\/I \(interactive mode\), type **\/\/logo \/\/I**.  
  
6.  In the **logoff Properties** dialog box, specify the options the you want:  
  
    -   **logoff Scripts for <Group Policy object>**: lists all the scripts that currently are assigned to the selected Group Policy object \(GPO\). if you assign multiple scripts, the scripts are processed in the order that you specify. To move a script up in the list, click it, and then click **Up**. To move a script down in the list, click it, and then click **Down**.  
  
    -   **add**: Opens the **add a Script** dialog box, where you can specify any additional scripts to use.  
  
    -   **edit**: Opens the **edit Script** dialog box, where you can change script information, such as name and parameters.  
  
    -   **remove**: removes the selected script from the **logoff Scripts** list.  
  
    -   **Show Files**: Displays the script files that are stored in the selected GPO.  
  
    **additional considerations**  
  
    -   logoff scripts are run as User, not Administrator, and their rights are limited accordingly.  
  
    -   Setting logoff scripts to run synchronously may cause the logoff process to run slowly.  
  


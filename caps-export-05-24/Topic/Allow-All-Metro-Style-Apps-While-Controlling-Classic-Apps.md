---
title: Allow All Metro Style Apps While Controlling Classic Apps
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1bd60f4f-c3c3-4e2e-9833-1a3e96df32e6
---
# Allow All Metro Style Apps While Controlling Classic Apps
This topic for the IT professional describes the steps to control your existing applications with AppLocker while allowing all Windows Metro style apps to run on computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
Commonly known as Metro style apps, Packaged apps run on a user’s desktop. They can be installed by a standard user, unlike some Win32 apps that sometimes require administrative privileges for installation. In this topic, “classic apps” refers to those applications that run on the classic user desktop that is available in Windows Server 2008 R2 and Windows 7 and earlier Windows operating systems.  
  
Typically, an app consists of multiple components, including the installer that is used to install the app and one or more .exe files, . dll files, or script files. With classic apps, not all these components consistently share common attributes such as the publisher name, product name, and product version. Therefore, AppLocker has to control each of these components separately through the following rule collections: Executable, DLL, Script, and Windows Installer. In contrast, all the components of a Packaged app share the same attributes: Publisher name, Package name, and Package version. Therefore, it is possible to control an entire app with a single rule.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], AppLocker can enforce rules for Packaged apps. It does this separately from classic apps.  
  
This scenario assumes that you already have rules for classic apps in place: Executable, DLL, Scripts, and Windows Installer. If not, see [Working with AppLocker Rules](../Topic/Working-with-AppLocker-Rules.md) for more information. This scenario also assumes that you are familiar managing the AppLocker features, snap\-ins, and the management of Group Policy Objects \(GPOs\).  
  
This scenario contains the following steps:  
  
-   [Step 1: Inventory your application usage \(optional\)](#BKMK_InventoryStep)  
  
-   [Step 2: Export the AppLocker policy from the GPO](#BKMK_ExportGPOstep)  
  
-   [Step 3: Import the policy retrieved from the GPO into AppLocker](#BKMK_ImportPolicyStep)  
  
-   [Step 4: Create the default rule for Packaged apps](#BKMK_CreateRuleStep)  
  
-   [Step 5: Test and update the AppLocker policy](#BKMK_TestStep)  
  
-   [Step 6: Import the AppLocker policy into the GPO](#BKMK_Import2GPOStep)  
  
## <a name="BKMK_InventoryStep"></a>Step 1: Inventory your application usage \(optional\)  
Using the Automatically Generate Rules Wizard quickly creates rules for the applications that you specify. The wizard is designed specifically to build a rule collection. You can use the Local Security Policy snap\-in to view and edit the rules. This method is very useful when creating rules from a reference computer, and when creating and evaluating AppLocker policies in a testing environment.  
  
Using the **Audit only** enforcement method permits you to view the logs because it collects information about every process on the computers that are receiving the GPO. Therefore, you can see what the enforcement will be on the computers in a business group. AppLocker includes Windows PowerShell cmdlets that you can use to analyze the events from the event log and cmdlets to create rules.  
  
For more information about how to determine your application usage or inventory, see [Monitor Application Usage with AppLocker](../Topic/Monitor-Application-Usage-with-AppLocker.md) and [Creating the List of Applications Deployed to Each Business Group](http://technet.microsoft.com/library/ee449494(WS.10).aspx).  
  
## <a name="BKMK_ExportGPOstep"></a>Step 2: Export the AppLocker policy from the GPO  
AppLocker policies can be created as local security policies and modified like any other local security policy, or they can be created as part of a GPO and managed by using Group Policy.  
  
> [!NOTE]  
> Updating an AppLocker policy that is currently enforced in your production environment can have unintended results. Therefore, export the policy from the GPO and update the rule or rules by using your AppLocker reference or test computer.  
  
To complete this procedure, you must have Edit Setting permissions to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission.  
  
#### Export the policy from the GPO  
  
1.  In the Group Policy Management Console \(GPMC\), open the GPO that you want to edit.  
  
2.  In the console tree under **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Application Control Policies**, right\-click **AppLocker**, and then click **Export Policy**.  
  
3.  In the **Export Policy** dialog box, type a name for the exported policy \(for example, the name of the GPO\), select a location to save the policy, and then click **Save**.  
  
4.  The **AppLocker** dialog box will notify you about how many rules were exported. Click **OK**.  
  
The rules now can be edited by using AppLocker on the local computer.  
  
## <a name="BKMK_ImportPolicyStep"></a>Step 3: Import the policy retrieved from the GPO into AppLocker  
  
#### To import an AppLocker policy into a GPO  
  
1.  In the console tree under **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Application Control Policies**, right\-click **AppLocker**, and then click **Import Policy**.  
  
2.  In the **Import Policy** dialog box, locate the XML policy file or create a new one, and then click **Open**.  
  
3.  The **AppLocker** dialog box will notify you about how many rules were imported into the GPO. Click **OK**.  
  
## <a name="BKMK_CreateRuleStep"></a>Step 4: Create the default rule for Packaged apps  
You can use AppLocker to create default rules.  
  
#### To create default rules for Packaged apps  
  
1.  In the console tree, right\-click **Packaged app Rules**.  
  
2.  Click **Create Default Rules**.  
  
    The new default rule appears in the Action pane as **\(Default Rule\) All signed packaged apps**.  
  
For more information about these default rules, see Packaged Apps Default Rules in AppLocker.  
  
For general procedural information, see [Create AppLocker Default Rules](../Topic/Create-AppLocker-Default-Rules.md).  
  
## <a name="BKMK_TestStep"></a>Step 5: Test and update the AppLocker policy  
You should test each set of rules to ensure that the rules perform as intended. If you use Group Policy to manage AppLocker policies, enable the **Audit only** enforcement setting, test the policy, and then analyze the AppLocker events. Because AppLocker rules are inherited from linked GPOs, you should deploy all of the rules for simultaneous testing in all of your test GPOs.  
  
For procedures about how to do this, see [Test and Update an AppLocker Policy](../Topic/Test-and-Update-an-AppLocker-Policy.md) and [Test an AppLocker Policy by Using Test-AppLockerPolicy](../Topic/Test-an-AppLocker-Policy-by-Using-Test-AppLockerPolicy.md).  
  
## <a name="BKMK_Import2GPOStep"></a>Step 6: Import the AppLocker policy into the GPO  
To complete this procedure, you must have Edit Setting permissions to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission.  
  
#### To import an AppLocker policy into a GPO  
  
1.  In the Group Policy Management Console \(GPMC\), open the GPO that you want to edit.  
  
2.  In the console tree under **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Application Control Policies**, right\-click **AppLocker**, and then click **Import Policy**.  
  
3.  In the **Import Policy** dialog box, locate the XML policy file, and then click **Open**.  
  
4.  The **AppLocker** dialog box will notify you about how many rules were imported into the GPO. Click **OK**.  
  
## See Also  
[Working with AppLocker Policies](../Topic/Working-with-AppLocker-Policies.md)  
  

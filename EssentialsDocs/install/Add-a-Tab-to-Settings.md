---
title: "Add a Tab to Settings"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aac6b7f3-9020-46c3-a83f-b81542300385
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add a Tab to Settings

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can add a tab to Settings on the Dashboard by creating and installing a code assembly that is used by the Settings Manager in operating system.  
  
## Add a tab to Settings  
 You add a tab to Settings by performing the following tasks:  
  
-   [Add an implementation of the ISettingsData interface to the assembly](Add-a-Tab-to-Settings.md#BKMK_ISettingsData).  
  
-   [Sign the assembly with an Authenticode signature](Add-a-Tab-to-Settings.md#BKMK_SignAssembly).  
  
-   [Install the assembly on the reference computer](Add-a-Tab-to-Settings.md#BKMK_InstallAssembly).  
  
###  <a name="BKMK_ISettingsData"></a> Add an implementation of the ISettingsData interface to the assembly  
 The ISettingsData interface is included in the Microsoft.WindowsServerSolutions.Settings namespace of the AdminCommon.dll assembly which is located in \Program Files\Windows Server\Bin.  
  
##### To add the ISettingsData code to the assembly  
  
1.  Open Visual Studio 2010 as an administrator by right-clicking the program in the **Start** menu and selecting **Run as administrator**.  
  
2.  Click **File**, click **New**, and then click **Project**.  
  
3.  In the **New Project** dialog box, click **Visual C#**, click **Class Library**, enter **DashboardSettingsPage** for the name for the solution, and then click **OK**.  
  
    > [!IMPORTANT]
    >  The assembly that is installed on the server must be named DashboardSettingsPage.dll and then copy the dll to %ProgramFiles%\Windows Server\Bin\OEM.  
  
4.  Create the control that you want to be used in the tab. In this example the settings control is named MySettingsControl.  
  
5.  Rename the Class1.cs file. For example, MySettingTab.cs.  
  
6.  Add a reference to the AdminCommon.dll file.  
  
7.  Add the following using statement:  
  
    ```c#  
    using Microsoft.WindowsServerSolutions.Settings;  
    ```  
  
8.  Change the namespace and the class header to match the following example:  
  
    ```  
  
    namespace DashboardSettingsPage  
    {  
        public class MySettingTab : ISettingsData  
        {  
        }  
    }  
  
    ```  
  
9. Instantiate an instance of the control that you created for the tab. For example:  
  
    ```c#  
    private MySettingsControl tab;  
    ```  
  
10. Add the constructor for the class. The following code example shows the constructor:  
  
    ```  
  
    public MySettingTab()  
    {  
       tab = new MySettingsControl();  
    }  
    ```  
  
11. Add the Commit method, which submits the setting changes. The following code example shows the Commit method:  
  
    ```  
  
    void ISettingsData.Commit(bool dismissed)  
    {  
       // Implement the code that is required to submit your setting changes  
    }  
    ```  
  
12. Add the TabControl method, which identifies the control for the tab. The following code example shows the TabControl method:  
  
    ```  
  
    System.Windows.Forms.Control ISettingsData.TabControl  
    {  
       get { return tab; }  
    }  
    ```  
  
13. Add the TabId method, which provides a unique identifier for the tab. The following code example shows the TabId method:  
  
    ```  
  
    private Guid id = Guid.NewGuid();  
  
    Guid ISettingsData.TabId  
    {  
       get { return id; }  
    }  
    ```  
  
14. Add the TabOrder method, which returns the order of the tab. The following code example shows the TabOrder method:  
  
    ```  
  
    int ISettingsData.TabOrder  
    {  
       get { return 0; }  
    }  
    ```  
  
    > [!NOTE]
    >  The tab order is defined by using numbers starting at 0. The Microsoft built-in settings tabs are displayed first and then your tabs are displayed based on the tab order that you define. For example, if you have three settings tabs, you specify the tab order as 0, 1, and 2 based on the order that you want the tabs to be displayed.  
  
15. Add the TabTitle method, which provides the title of the tab. The following code example shows the TabTitle method:  
  
    ```  
  
    string ISettingsData.TabTitle  
    {  
      get { return "My Settings Tab"; }  
    }  
    ```  
  
    > [!NOTE]
    >  The title text can also come from a resource file to accommodate localization needs.  
  
16. Save and build the solution.  
  
###  <a name="BKMK_SignAssembly"></a> Sign the assembly with an Authenticode signature  
 You must Authenticode sign the assembly for it to be used in the operating system. For more information about signing the assembly, see [Signing and Checking Code with Authenticode](https://msdn.microsoft.com/library/ms537364\(VS.85\).aspx#SignCode).  
  
###  <a name="BKMK_InstallAssembly"></a> Install the assembly on the reference computer  
 After you successfully build the solution, place a copy of the DashboardSettingsPage.dll file in the following folder on the reference computer:  
  
 **%Programfiles%\Windows Server\Bin\OEM**  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)
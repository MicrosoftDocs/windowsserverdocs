---
title: "Add Entries to SETUP, ADD-INS, QUICK STATUS, and HELP Links"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0a8f10d-fd85-4c8d-b9bb-176cb1db1f46
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add Entries to SETUP, ADD-INS, QUICK STATUS, and HELP Links

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can add tasks to the **SETUP**, **ADD-INS**, **QUICK STATUS** task lists, and you can add links to the Community Links section in the home page of the Dashboard. Tasks and links are added to these lists and section by placing an XML file named OEMHomePageContent.home file or an embedded resource file named OEMHomePageContent.dll in %ProgramFiles%\Windows Server\Bin\Addins\Home. The embedded resource file can be used to localize the text in the tasks and links that you add. The .home file contains the XML definitions of the tasks and links.  
  
## Adding tasks to the SETUP, ADD-INS, QUICK STATUS task lists and adding links to HELP task  
 You can add tasks to the **SETUP**, **ADD-INS**, **QUICK STATUS** task lists, and links to the **HELP** task by defining the tasks and links using XML, optionally creating the embedded resource file, and installing the file on the server. If the XML file is being installed on the server without a resource file, it must be named OEMHomePageContent.home. If an assembly is being used to install both an XML file and a resource file, it must be named OEMHomePageContent.dll and it must be Authenticode signed.  
  
### Define the tasks and links  
 You can use a text editor such as Notepad to create the .home file, or if you are also creating an embedded resource file you can use Visual Studio 2010 or higher to define the files. The following procedure shows how to use Visual Studio 2010 or higher to create the files.  
  
##### To define the tasks and links  
  
1. Open Visual Studio 2010 or higher as an administrator by right-clicking the program in the Start menu and selecting **Run as administrator**.  
  
2. Click **File**, click **New**, and then click **Project**.  
  
3. In the **Templates** pane, click **Class Library**, type **OEMHomePageContent** in the **Name** box, and then click **OK**.  
  
4. Delete the Class1.cs file.  
  
5. Right-click the new project, click **Add**, and then click **New Item**.  
  
6. In the **Templates** pane, click **XML File**, type **OEMHomePageContent.home** in the **Name** box, and then click **Add**.  
  
   > [!NOTE]
   >  If the XML file is being installed without a resource file, it must be named OEMHomePageContent.home. If it is included in an assembly, it can be given any name as long as it has a .home extension.  
  
7. Add the following XML code to the OEMHomePageContent.home file:  
  
   ```  
  
   <Tasks version=?2.0? xmlns=?https://schemas.microsoft.com/WindowsServerSolutions/2010/01/Dashboard>  
      <SetupMyServerTasks>  
         <Task name="MyTask"  
            description="MyTaskDescription"  
            id="GUID">  
                 <Action   
                 name=?MyAction1Name?   
                 image=?IconForAction1?  
                 type=?TaskType?  
                 exelocation=?ActionExeLocation? />  
                 <Action   
                 name=?MyAction2Name?   
                 image=?IconForAction2?  
                 type=?TaskType?  
                 exelocation=?ActionExeLocation? />  
                  ¦  
          </Task>  
                  ¦  
       </SetupMyServerTasks>  
   <MailServiceTasks>  
        <!-- Same schema as in œSetupMyServerTasks? but the tasks are shown in œConnect to Email Service? category. -->  
   </MailServiceTasks>  
   <LineOfBusinessTasks>  
        <!-- Same schema as in œSetupMyServerTasks? but the tasks are shown in œAdd-ins? category. -->  
  
   <GetQuickStatusTasks>  
         <Task name="MyQuickStatusTask1"  
            description="MyQuickStatusTask1Desc   "  
            id="GUID"  
            assembly="AssemblyName of quick status query implementation"  
            class="ClassName of quick status query implementation"           
            replaceid="GUID"/>  
              <!--  Same schema as Actions in œSetupMyServerTasks? -->   
            </Task>  
   </GetQuickStatusTasks>  
      <Links>  
         <Link  
            ID=?GUID?  
            Title="Displayed text of the link"  
            Description="A very short description"  
            ShellExecPath="Path to the application or URL"/>  
      </Links>  
   </Tasks>  
   ```  
  
    Where:  
  
   |Attribute|Description|  
   |---------------|-----------------|  
   |Name (Task)|The name that is displayed for the task in the list. If you create an embedded resource file, the value of this attribute is the string resource.|  
   |description (Task)|The description of the task. If you create an embedded resource file, the value of this attribute is the string resource.|  
   |id (Task)|The identifier of the task. This identifier must be a GUID. You create a new GUID for an **exe** task, but for a **global** task, you use the GUID that you created when you defined the task for the task pane of the sub-tab. For more information about creating a GUID, see [Create Guid (guidgen.exe)](https://go.microsoft.com/fwlink/?LinkId=116098).|  
   |image|This field will be ignored.|  
   |Name (Action)|Displays the name of the task.|  
   |Type (Action)|Describes the type of task. The task can one of the following:- **global** task, **exe**, or a url task. A **global** task is the same global task that you created when defining the tasks for the task pane in the sub-tab. For more information about creating a global task that can be used in both the tasks pane of the sub-tab and the Getting Started Tasks or Common Tasks lists of the home page, see œCreating the support classes? in œHow to: Create a Sub-Tab? of the [Windows Server Solutions SDK](https://go.microsoft.com/fwlink/?LinkID=248648). An **exe** task can be used to run applications from the Getting Started Tasks or Common Tasks lists.|  
   |exelocation|The path to the application that is associated with the task. This attribute is only used for **exe** tasks.|  
   |replaceid|The identifier of the task that is replaced with this task.|  
   |assembly|The AssemblyName of the assembly which provides the class to implement quick status query. The assembly needs to be located in Program files\ windows server\bin\\.|  
   |class|The name of the class implements quick status query. The class needs to implement **ITaskStatusQuery** interface.|  
   |Title (link)|The text that is displayed for the link. If you create an embedded resource file, the value of this attribute is the string resource.|  
   |Description (link)|The description of the link destination. If you create an embedded resource file, the value of this attribute is the string resource.|  
   |ShellExecPath|The path to the application or the URL.<br /><br /> **Note:** Environment variables are supported in the ShellExecPath attribute.|  
  
    The following code example shows how to define a link to an application:  
  
   ```  
   <Links>  
      <Link Title="Calc" Description="Launches Calc" ShellExecPath="%windir%\system32\calc.exe" />  
   </Links>  
   ```  
  
    The following code example shows how to define a link to a Web page:  
  
   ```  
   <Links>  
      <Link Title="Browser" Description="Open browser" ShellExecPath="http://www.adventureworks.com/" />  
   </Links>  
   ```  
  
8. Change the attribute values to represent your task or link.  
  
9. In **Solution Explorer**, right-click **OEMHomePageContent.home**, and then click **Properties**.  In the **Properties** pane, under **Build Action**, select **Embedded Resource**.  
  
10. Save the OEMHomePageContent.home file.  
  
    For how to implement a quick status query, please refer to documents and samples in the [Windows Server Solutions SDK](https://go.microsoft.com/fwlink/?LinkID=248648).  
  
#### Change the status of a SETUP/ADD-INS task  
 The tasks that are listed in SETUP and ADD-INS can be toggled in states of completed (configured for Add-ins) and not completed (not configured for Add-ins).  
  
 When you define the application that is associated with your new task, you can use the SetTaskStatus method of the Microsoft.WindowsServerSolutions.Administration.ObjectModel.TaskStatusHelper namespace (included, but not documented in the Windows Server Solutions SDK) to change the status of the task. For example, you could change the check mark from grey to green by calling the SetTaskStatus method with the TaskStatus.Complete enumeration value (SetTaskStatus(id, TaskStatus.Complete), where **id** is the identifier of the task). The enumeration values that can be used are TaskStatus.Complete, TaskStatus.Incomplete, or TaskStatus.Hidden.  
  
##### Replace tasks  
 You can replace the tasks that are pre-defined in the Getting Started Tasks or the Common Tasks lists by adding the GUID for the task to the replaceid attribute of the task definition. The following table lists the tasks and the corresponding identifiers that can be replaced in the Dashboard:  
  
|Task name|Identifier|  
|---------------|----------------|  
|Get updates for other Microsoft products|8412D35A-13EE-4112-AE0B-F7DBC83EA83D|  
|Set up Server Backup|F68B3F3F-19DE-499D-9ACB-4BB41B8FF420|  
|Set up Anywhere Access|8991302D-676A-4A7C-B244-D1E08AE0EFEA|  
|Setup email alert notification|DE6F2B36-F19C-4FAF-998B-9772300E3530|  
|Add a user accounts|6D5B5D5F-2EC7-4B1F-9580-4DB084B278B1|  
|Add server folders|03F1F438-D94E-439B-A9F7-0C817C37D625|  
|Anywhere Access - Quick Status|6093B462-1F04-4212-8804-9BC823070FAD|  
|Server Backup - Quick Status|156947D8-21DC-45FE-A9A8-2F80AE304191|  
|Server Folders - Quick Status|C657E8AB-AC1F-4AA1-8E80-5AF6BB27C314|  
|Active user accounts - Quick Status|68BCB125-CE8F-467F-B65B-56AD45A614B5|  
|Email alert notification - Quick Status|75AB06E7-A679-4D62-A5EC-65362FE4F9DB|  
|Computers - Quick Status|7966A974-D52D-4F5D-B37F-05C1B73CEEF3|  
  
##### (Optional) Create the resource file  
 If you want to localize the text in the tasks that you add to Getting Started Tasks, Common Tasks, and Community Links you must create an assembly that contains the .home file and a .home.resx file that defines the text strings.  
  
###### To create the resource file  
  
1.  Right-click the project that you created for your tasks, click **Add**, and then click **New Item**.  
  
2.  In the **Templates** pane, click **Resources File**, type **OEMHomePageContent.home.resx** in the **Name** box, and then click **Add**.  
  
    > [!NOTE]
    >  The resource file can be given any name as long as it has a .home.resx extension.  
  
3.  For each task or link that you add, you must add strings and values to the OEMHomePageContent.home.resx file that match the Task and Link elements that are defined in the OEMHomePageContent.home file. The following code example shows an example of a Tasks.xml file that is structured for the resource file:  
  
    ```  
  
    <Tasks version=?2.0? xmlns=?https://schemas.microsoft.com/WindowsServerSolutions/2010/01/Dashboard>  
       <SetupMyServerTasks>  
          <Task name="MyTask"  
             description="MyDescription"  
             id="GUID">  
             <Action  
             name="MyActionname"  
             image="IconForAction"  
             type="TaskType"  
             exelocation="ActionExeLocation" />  
          </Task>  
       </SetupMyServerTasks>  
    </Tasks>  
  
    ```  
  
    > [!NOTE]
    >  Identifiers in attributes that are used for localization cannot contain spaces.  
  
4.  Add the MyTask, MyTaskDescription, MyActionName, and IconForAction resource names to the .resx file with the appropriate values.  
  
5.  Save the OEMHomePageContent.home.resx file, and then build the solution.  
  
#####  <a name="BKMK_SignAssembly"></a> Sign the assembly with an Authenticode signature  
 You must Authenticode sign the assembly for it to be used in the operating system. For more information about signing the assembly, see [Signing and Checking Code with Authenticode](https://msdn.microsoft.com/library/ms537364\(VS.85\).aspx#SignCode).  
  
##### Install the task files  
 After you create the .home and .home.resx files, you must install them on the server.  
  
###### To install the task files  
  
1.  Ensure that your solution builds without errors.  
  
2.  If you did not create an embedded resource file, copy the OEMHomePageContent.home file to **%ProgramFiles%\Windows Server\Bin\Addins\Home** on the server. If you created an embedded resource file, copy the OEMHomePageContent.dll file to **%ProgramFiles%\Windows Server\Bin\Addins\Home** on the server.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)
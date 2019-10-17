---
ms.assetid: f643099e-f9c6-476f-9378-5a9228c39b33
title: Appendix E - Securing Enterprise Admins Groups in Active Directory
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Appendix E: Securing Enterprise Admins Groups in Active Directory

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


## Appendix E: Securing Enterprise Admins Groups in Active Directory  
The Enterprise Admins (EA) group, which is housed in the forest root domain, should contain no users on a day-to-day basis, with the possible exception of the root domain's Administrator account, provided it is secured as described in [Appendix D: Securing Built-In Administrator Accounts in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory.md).  

Enterprise Admins are, by default, members of the Administrators group in each domain in the forest. You should not remove the EA group from the Administrators groups in each domain because in the event of a forest disaster recovery scenario, EA rights will likely be required. The forest's Enterprise Admins group should be secured as detailed in the step-by-step instructions that follow.  

For the Enterprise Admins group in the forest:  

1.  In GPOs linked to OUs containing member servers and workstations in each domain, the Enterprise Admins group should be added to the following user rights in **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignments**:  

    -   Deny access to this computer from the network  

    -   Deny log on as a batch job  

    -   Deny log on as a service  

    -   Deny log on locally  

    -   Deny log on through Remote Desktop Services  

2.  Configure auditing to send alerts if any modifications are made to the properties or membership of the Enterprise Admins group.  

### Step-by-Step Instructions for Removing All Members from the Enterprise Admins Group  

1.  In **Server Manager**, click **Tools**, and click **Active Directory Users and Computers**.  

2.  If you are not managing the root domain for the forest, in the console tree, right-click <Domain>, and then click **Change Domain** (where <Domain> is the name of the domain you're currently administering).  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_43.gif)  

3.  In the **Change domain** dialog box, click **Browse**, select the root domain for the forest, and click **OK**.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_44.gif)  

4.  To remove all members from the EA group:  

    1.  Double-click the **Enterprise Admins** group and then click the **Members** tab.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_45.gif)  

    2.  Select a member of the group, click **Remove**, click **Yes**, and click **OK**.  

5.  Repeat step 2 until all members of the EA group have been removed.  

### Step-by-Step Instructions to Secure Enterprise Admins in Active Directory  

1.  In **Server Manager**, click **Tools**, and click **Group Policy Management**.  

2.  In the console tree, expand <Forest>\Domains\\<Domain>, and then **Group Policy Objects** (where <Forest> is the name of the forest and <Domain> is the name of the domain where you want to set the Group Policy).  

    > [!NOTE]  
    > In a forest that contains multiple domains, a similar GPO should be created in each domain that requires that the Enterprise Admins group be secured.  

3.  In the console tree, right-click **Group Policy Objects**, and click **New**.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_46.gif)  

4.  In the **New GPO** dialog box, type <GPO Name>, and click **OK** (where <GPO Name> is the name of this GPO).  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_47.gif)  

5.  In the details pane, right-click <GPO Name>, and click **Edit**.  

6.  Navigate to **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies**, and click **User Rights Assignment**.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_48.gif)  

7.  Configure the user rights to prevent members of the Enterprise Admins group from accessing member servers and workstations over the network by doing the following:  

    1.  Double-click **Deny access to this computer from the network** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and click **Browse**.  

    3.  Type **Enterprise Admins**, click **Check Names**, and click **OK**.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_49.gif)  

    4.  Click **OK**, and **OK** again.  

8.  Configure the user rights to prevent members of the Enterprise Admins group from logging on as a batch job by doing the following:  

    1.  Double-click **Deny log on as a batch job** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and click **Browse**.  

        > [!NOTE]  
        > In a forest that contains multiple domains, click **Locations** and select the root domain of the forest.  

    3.  Type **Enterprise Admins**, click **Check Names**, and click **OK**.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_50.gif)  

    4.  Click **OK**, and **OK** again.  

9. Configure the user rights to prevent members of the EA group from logging on as a service by doing the following:  

    1.  Double-click **Deny log as a service** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and then click **Browse**.  

        > [!NOTE]  
        > In a forest that contains multiple domains, click **Locations** and select the root domain of the forest.  

    3.  Type **Enterprise Admins**, click **Check Names**, and click **OK**.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_51.gif)  

    4.  Click **OK**, and **OK** again.  

10. Configure user rights to prevent members of the Enterprise Admins group from logging on locally to member servers and workstations by doing the following:  

    1.  Double-click **Deny log on locally** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and then click **Browse**.  

        > [!NOTE]  
        > In a forest that contains multiple domains, click **Locations** and select the root domain of the forest.  

    3.  Type **Enterprise Admins**, click **Check Names**, and click **OK**.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_52.gif)  

    4.  Click **OK**, and **OK** again.  

11. Configure the user rights to prevent members of the Enterprise Admins group from accessing member servers and workstations via Remote Desktop Services by doing the following:  

    1.  Double-click **Deny log on through Remote Desktop Services** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and then click **Browse**.  

        > [!NOTE]  
        > In a forest that contains multiple domains, click **Locations** and select the root domain of the forest.  

    3.  Type **Enterprise Admins**, click **Check Names**, and click **OK**.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_53.gif)  

    4.  Click **OK**, and **OK** again.  

12. To exit **Group Policy Management Editor**, click **File**, and click **Exit**.  

13. In **Group Policy Management**, link the GPO to the member server and workstation OUs by doing the following:  

    1.  Navigate to the <Forest>\Domains\\<Domain> (where <Forest> is the name of the forest and <Domain> is the name of the domain where you want to set the Group Policy).  

    2.  Right-click the OU that the GPO will be applied to and click **Link an existing GPO**.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_54.gif)  

    3.  Select the GPO that you just created and click **OK**.  

        ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_55.gif)  

    4.  Create links to all other OUs that contain workstations.  

    5.  Create links to all other OUs that contain member servers.  

    6.  In a forest that contains multiple domains, a similar GPO should be created in each domain that requires that the Enterprise Admins group be secured.  

> [!IMPORTANT]  
> If jump servers are used to administer domain controllers and Active Directory, ensure that jump servers are located in an OU to which this GPOs is not linked.  

### Verification Steps  

#### Verify "Deny access to this computer from the network" GPO Settings  
From any member server or workstation that is not affected by the GPO changes (such as a "jump server"), attempt to access a member server or workstation over the network that is affected by the GPO changes. To verify the GPO settings, attempt to map the system drive by using the **NET USE** command by performing the following steps:  

1.  Log on locally using an account that is a member of the EA group.  

2.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

3.  In the **Search** box, type **command prompt**, right-click **Command Prompt**, and then click **Run as administrator** to open an elevated command prompt.  

4.  When prompted to approve the elevation, click **Yes**.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_56.gif)  

5.  In the **Command Prompt** window, type **net use \\\\\<Server Name\>\c$**, where \<Server Name\> is the name of the member server or workstation you're attempting to access over the network.  

6.  The following screen shot shows the error message that should appear.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_57.gif)  

#### Verify "Deny log on as a batch job" GPO Settings  

From any member server or workstation affected by the GPO changes, log on locally.  

##### Create a Batch File  

1.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

2.  In the **Search** box, type **notepad**, and click **Notepad**.  

3.  In **Notepad**, type **dir c:**.  

4.  Click **File**, and click **Save As**.  

5.  In the **File** name box, type **<Filename>.bat** (where <Filename> is the name of the new batch file).  

##### Schedule a Task  

1.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

2.  In the **Search** box, type **task scheduler**, and click **Task Scheduler**.  

    > [!NOTE]  
    > On computers running Windows 8, in the **Search** box, type **schedule tasks**, and click **Schedule tasks**.  

3.  Click **Action**, and click **Create Task**.  

4.  In the **Create Task** dialog box, type **<Task Name>** (where <Task Name> is the name of the new task).  

5.  Click the **Actions** tab, and click **New**.  

6.  In the **Action** field, select **Start a program**.  

7.  Under **Program/script**, click **Browse**, locate and select the batch file created in the **Create a Batch File** section, and click **Open**.  

8.  Click **OK**.  

9. Click the **General** tab.  

10. In the **Security options** field, click **Change User or Group**.  

11. Type the name of an account that is a member of the EAs group, click **Check Names**, and click **OK**.  

12. Select **Run whether the user is logged on or not** and select **Do not store password**. The task will only have access to local computer resources.  

13. Click **OK**.  

14. A dialog box should appear, requesting user account credentials to run the task.  

15. After entering the credentials, click **OK**.  

16. A dialog box similar to the following should appear.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_58.gif)  

#### Verify "Deny log on as a service" GPO Settings  

1.  From any member server or workstation affected by the GPO changes, log on locally.  

2.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

3.  In the **Search** box, type **services**, and click **Services**.  

4.  Locate and double-click **Print Spooler**.  

5.  Click the **Log On** tab.  

6.  Under **Log on as**, select **This account**.  

7.  Click **Browse**, type the name of an account that is a member of the EAs group, click **Check Names**, and click **OK**.  

8.  Under **Password:** and **Confirm password**, type the selected account's password, and click **OK**.  

9. Click **OK** three more times.  

10. Right-click the **Print Spooler** service and select **Restart**.  

11. When the service is restarted, a dialog box similar to the following should appear.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_59.gif)  

#### Revert Changes to the Printer Spooler Service  

1.  From any member server or workstation affected by the GPO changes, log on locally.  

2.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

3.  In the **Search** box, type **services**, and click **Services**.  

4.  Locate and double-click **Print Spooler**.  

5.  Click the **Log On** tab.  

6.  Under **Log on as**, select the **Local System** account, and click **OK**.  

#### Verify "Deny log on locally" GPO Settings  

1.  From any member server or workstation affected by the GPO changes, attempt to log on locally using an account that is a member of the EA group. A dialog box similar to the following should appear.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_60.gif)  

#### Verify "Deny log on through Remote Desktop Services" GPO Settings  

1.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

2.  In the **Search** box, type **remote desktop connection**, and then click **Remote Desktop Connection**.  

3.  In the **Computer** field, type the name of the computer that you want to connect to, and then click **Connect**. (You can also type the IP address instead of the computer name.)  

4.  When prompted, provide credentials for an account that is a member of the EA group.  

5.  A dialog box similar to the following should appear.  

    ![secure enterprise admin groups](media/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory/SAD_61.gif)  

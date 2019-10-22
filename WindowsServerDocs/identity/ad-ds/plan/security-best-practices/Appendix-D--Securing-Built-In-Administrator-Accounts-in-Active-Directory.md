---
ms.assetid: 11f36f2b-9981-4da0-9e7c-4eca78035f37
title: Appendix D - Securing Built-In Administrator Accounts in Active Directory
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Appendix D: Securing Built-In Administrator Accounts in Active Directory

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


## Appendix D: Securing Built-In Administrator Accounts in Active Directory  
In each domain in Active Directory, an Administrator account is created as part of the creation of the domain. This account is by default a member of the Domain Admins and Administrators groups in the domain, and if the domain is the forest root domain, the account is also a member of the Enterprise Admins group.

Use of a domain's Administrator account should be reserved only for initial build activities, and possibly, disaster-recovery scenarios. To ensure that an Administrator account can be used to effect repairs in the event that no other accounts can be used, you should not change the default membership of the Administrator account in any domain in the forest. Instead, you should secure the Administrator account in each domain in the forest as described in the following section and detailed in the step-by-step instructions that follow. 

> [!NOTE]
> This guide used to recommend disabling the account. This was removed as the forest recovery white paper makes use of the default administrator account. The reason is, this is the only account that allows logon without a Global Catalog Server.


#### Controls for Built-in Administrator Accounts  
For the built-in Administrator account in each domain in your forest, you should configure the following settings:  

-   Enable the **Account is sensitive and cannot be delegated** flag on the account.  

-   Enable the **Smart card is required for interactive logon** flag on the account.  

-   Configure GPOs to restrict the Administrator account's use on domain-joined systems:  

    -   In one or more GPOs that you create and link to workstation and member server OUs in each domain, add each domain's Administrator account to the following user rights in **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignments**:  

        -   Deny access to this computer from the network  

        -   Deny log on as a batch job  

        -   Deny log on as a service  

        -   Deny log on through Remote Desktop Services  

> [!NOTE]  
> When you add accounts to this setting, you must specify whether you are configuring local Administrator accounts or domain Administrator accounts. For example, to add the NWTRADERS domain's Administrator account to these deny rights, you must type the account as NWTRADERS\Administrator, or browse to the Administrator account for the NWTRADERS domain. If you type "Administrator" in these user rights settings in the Group Policy Object Editor, you will restrict the local Administrator account on each computer to which the GPO is applied.
>   
> We recommend restricting local Administrator accounts on member servers and workstations in the same manner as domain-based Administrator accounts. Therefore, you should generally add the Administrator account for each domain in the forest and the Administrator account for the local computers to these user rights settings. The following screenshot shows an example of configuring these user rights to block local Administrator accounts and a domain's Administrator account from performing logons that should not be needed for these accounts.  


![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_23.gif)  

-   Configure GPOs to restrict Administrator accounts on domain controllers  
    -   In each domain in the forest, the Default Domain Controllers GPO or a policy linked to the domain controllers OU should be modified to add each domain's Administrator account to the following user rights in **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignments**:   
        -   Deny access to this computer from the network  

        -   Deny log on as a batch job  

        -   Deny log on as a service  

        -   Deny log on through Remote Desktop Services  

> [!NOTE]  
> These settings will ensure that the domain's built-in Administrator account cannot be used to connect to a domain controller, although the account, if enabled, can log on locally to domain controllers. Because this account should only be enabled and used in disaster-recovery scenarios, it is anticipated that physical access to at least one domain controller will be available, or that other accounts with permissions to access domain controllers remotely can be used.  

-   Configure Auditing of Administrator Accounts  

    When you have secured each domain's Administrator account and disabled it, you should configure auditing to monitor for changes to the account. If the account is enabled, its password is reset, or any other modifications are made to the account, alerts should be sent to the users or teams responsible for administration of Active Directory, in addition to incident response teams in your organization.  

#### Step-by-Step Instructions to Secure Built-in Administrator Accounts in Active Directory  

1.  In **Server Manager**, click **Tools**, and click **Active Directory Users and Computers**.  

2.  To prevent attacks that leverage delegation to use the account's credentials on other systems, perform the following steps:  

    1.  Right-click the **Administrator** account and click **Properties**.  

    2.  Click the **Account** tab.  

    3.  Under **Account options**, select **Account is sensitive and cannot be delegated** flag as indicated in the following screenshot, and click **OK**.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_24.gif)  

3.  To enable the **Smart card is required for interactive logon** flag on the account, perform the following steps:  

    1.  Right-click the **Administrator** account and select **Properties**.  

    2.  Click the **Account** tab.  

    3.  Under **Account** options, select the **Smart card is required for interactive logon** flag as indicated in the following screenshot, and click **OK**.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_25.gif) 

##### Configuring GPOs to Restrict Administrator Accounts at the Domain-Level  

> [!WARNING]  
> This GPO should never be linked at the domain-level because it can make the built-in Administrator account unusable, even in disaster recovery scenarios.  

1.  In **Server Manager**, click **Tools**, and click **Group Policy Management**.  

2.  In the console tree, expand <Forest>\Domains\\<Domain>, and then **Group Policy Objects** (where <Forest> is the name of the forest and <Domain> is the name of the domain where you want to create the Group Policy).  

3.  In the console tree, right-click **Group Policy Objects**, and click **New**.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_27.gif)  

4.  In the **New GPO** dialog box, type <GPO Name>, and click **OK** (where <GPO Name> is the name of this GPO) as indicated in the following screenshot.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_28.gif)  

5.  In the details pane, right-click <GPO Name>, and click **Edit**.  

6.  Navigate to **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies**, and click **User Rights Assignment**.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_29.gif)  

7.  Configure the user rights to prevent the Administrator account from accessing members servers and workstations over the network by doing the following:  

    1.  Double-click **Deny access to this computer from the network** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and click **Browse**.  

    3.  Type **Administrator**, click **Check Names**, and click **OK**. Verify that the account is displayed in <DomainName>\Username format as indicated in the following screenshot.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_30.gif)  

    4.  Click **OK**, and **OK** again.  

8.  Configure the user rights to prevent the Administrator account from logging on as a batch job by doing the following:  

    1.  Double-click **Deny log on as a batch job** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and click **Browse**.  

    3.  Type **Administrator**, click **Check Names**, and click **OK**. Verify that the account is displayed in <DomainName>\Username format as indicated in the following screenshot.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_31.gif)  

    4.  Click **OK**, and **OK** again.  

9. Configure the user rights to prevent the Administrator account from logging on as a service by doing the following:  

    1.  Double-click **Deny log on as a service** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and click **Browse**.  

    3.  Type **Administrator**, click **Check Names**, and click **OK**. Verify that the account is displayed in <DomainName>\Username format as indicated in the following screenshot.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_32.gif)  

    4.  Click **OK**, and **OK** again.  

10. Configure the user rights to prevent the BA account from accessing member servers and workstations via Remote Desktop Services by doing the following:  

    1.  Double-click **Deny log on through Remote Desktop Services** and select **Define these policy settings**.  

    2.  Click **Add User or Group** and click **Browse**.  

    3.  Type **Administrator**, click **Check Names**, and click **OK**. Verify that the account is displayed in <DomainName>\Username format as indicated in the following screenshot.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_33.gif)  

    4.  Click **OK**, and **OK** again.  

11. To exit **Group Policy Management Editor**, click **File**, and click **Exit**.  

12. In **Group Policy Management**, link the GPO to the member server and workstation OUs by doing the following:  

    1.  Navigate to the <Forest>\Domains\\<Domain> (where <Forest> is the name of the forest and <Domain> is the name of the domain where you want to set the Group Policy).  

    2.  Right-click the OU that the GPO will be applied to and click **Link an existing GPO**.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_34.gif)  

    3.  Select the GPO that you created and click **OK**.  

        ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_35.gif)  

    4.  Create links to all other OUs that contain workstations.  

    5.  Create links to all other OUs that contain member servers.  

> [!IMPORTANT]  
> When you add the Administrator account to these settings, you specify whether you are configuring a local Administrator account or a domain Administrator account by how you label the accounts. For example, to add the TAILSPINTOYS domain's Administrator account to these deny rights, you would browse to the Administrator account for the TAILSPINTOYS domain, which would appear as TAILSPINTOYS\Administrator. If you type "Administrator" in these user rights settings in the Group Policy Object Editor, you will restrict the local Administrator account on each computer to which the GPO is applied, as described earlier.  

#### Verification Steps  
The verification steps outlined here are specific to Windows 8 and Windows Server 2012.  

##### Verify "Smart card is required for interactive logon" Account Option  

1.  From any member server or workstation affected by the GPO changes, attempt to log on interactively to the domain by using the domain's built-in Administrator account. After attempting to log on, a dialog box similar to the following should appear.  

![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_36.gif)  

##### Verify "Account is disabled" Account Option  

1.  From any member server or workstation affected by the GPO changes, attempt to log on interactively to the domain by using the domain's built-in Administrator account. After attempting to log on, a dialog box similar to the following should appear.  

![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_37.gif)  

##### Verify "Deny access to this computer from the network" GPO Settings  
From any member server or workstation that is not affected by the GPO changes (such as a jump server), attempt to access a member server or workstation over the network that is affected by the GPO changes. To verify the GPO settings, attempt to map the system drive by using the **NET USE** command by performing the following steps:  

1.  Log on to the domain using the domain's built-in Administrator account.  

2.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

3.  In the **Search** box, type **command prompt**, right-click **Command Prompt**, and then click **Run as administrator** to open an elevated command prompt.  

4.  When prompted to approve the elevation, click **Yes**.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_38.gif)  

5.  In the **Command Prompt** window, type **net use \\\\\<Server Name\>\c$**, where \<Server Name\> is the name of the member server or workstation you are attempting to access over the network.  

6.  The following screenshot shows the error message that should appear.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_39.gif)  

##### Verify "Deny log on as a batch job" GPO Settings  

From any member server or workstation affected by the GPO changes, log on locally.  

###### Create a Batch File  

1.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

2.  In the **Search** box, type **notepad**, and click **Notepad**.  

3.  In **Notepad**, type **dir c:**.  

4.  Click **File** and click **Save As**.  

5.  In the **Filename** field, type **<Filename>.bat** (where <Filename> is the name of the new batch file).  

###### Schedule a Task  

1.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

2.  In the **Search** box, type **task scheduler**, and click **Task Scheduler**.  

    > [!NOTE]  
    > On computers running Windows 8, in the Search box, type **schedule tasks**, and click **Schedule tasks**.  

3.  On **Task Scheduler**, click **Action**, and click **Create Task**.  

4.  In the **Create Task** dialog box, type **<Task Name>** (where **<Task Name>** is the name of the new task).  

5.  Click the **Actions** tab, and click **New**.  

6.  Under **Action:**, select **Start a program**.  

7.  Under **Program/script:**, click **Browse**, locate and select the batch file created in the "Create a Batch File" section, and click **Open**.  

8.  Click **OK**.  

9. Click the **General** tab.  

10. Under **Security** options, click **Change User or Group**.  

11. Type the name of the BA account at the domain-level, click **Check Names**, and click **OK**.  

12. Select **Run whether the user is logged on or not** and **Do not store password**. The task will only have access to local computer resources.  

13. Click **OK**.  

14. A dialog box should appear, requesting user account credentials to run the task.  

15. After entering the credentials, click **OK**.  

16. A dialog box similar to the following should appear.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_40.gif)  

##### Verify "Deny log on as a service" GPO Settings  

1.  From any member server or workstation affected by the GPO changes, log on locally.  

2.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

3.  In the **Search** box, type **services**, and click **Services**.  

4.  Locate and double-click **Print Spooler**.  

5.  Click the **Log On** tab.  

6.  Under **Log on as:**, select **This account**.  

7.  Click **Browse**, type the name of the BA account at the domain-level, click **Check Names**, and click **OK**.  

8.  Under **Password:** and **Confirm password:**, type the Administrator account's password, and click **OK**.  

9. Click **OK** three more times.  

10. Right-click the **Print Spooler service** and select **Restart**.  

11. When the service is restarted, a dialog box similar to the following should appear.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_41.gif)  

##### Revert Changes to the Printer Spooler Service  

1.  From any member server or workstation affected by the GPO changes, log on locally.  

2.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

3.  In the **Search** box, type **services**, and click **Services**.  

4.  Locate and double-click **Print Spooler**.  

5.  Click the **Log On** tab.  

6.  Under **Log on as:**, select the **Local System** account, and click **OK**.  

##### Verify "Deny log on through Remote Desktop Services" GPO Settings

1.  With the mouse, move the pointer into the upper-right or lower-right corner of the screen. When the **Charms** bar appears, click **Search**.  

2.  In the **Search** box, type **remote desktop connection**, and click **Remote Desktop Connection**.  

3.  In the **Computer** field, type the name of the computer that you want to connect to, and click **Connect**. (You can also type the IP address instead of the computer name.)  

4.  When prompted, provide credentials for the name of the BA account at the domain-level.  

5.  A dialog box similar to the following should appear.  

    ![securing built-in admin accounts](media/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory/SAD_42.gif)  

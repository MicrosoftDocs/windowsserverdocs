---
title: Advanced Security Auditing Walkthrough
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d4e93e5d-c65d-4a95-a54f-6d7ef3e33b3e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Advanced Security Auditing Walkthrough

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This procedural topic for the IT professional describes the process of setting up an advanced security auditing policy infrastructure in a test environment.

## About this guide
The security auditing enhancements introduced in  Windows Server 2008 R2  and  Windows 7  can help your organization audit compliance with important business-related and security-related rules by tracking precisely defined activities, for example:

-   A group administrator has modified settings or data on servers that contain finance information.

-   An employee within a defined group has accessed an important file.

-   The correct system access control list (SACL) is applied to every file and folder or registry key on a computer or file share as a verifiable safeguard against undetected access.

The advanced security auditing settings allow you to select only the behaviors that you want to monitor and exclude audit results for behaviors that are of little or no concern to you, or behaviors that create an excessive number of log entries. Security audit policies can be applied by using domain Group Policy Objects, and audit policy settings can be modified, tested, and deployed to selected users and groups with relative simplicity.

This walkthrough demonstrates the process of setting up an advanced security auditing policy infrastructure in a test environment. It also guides you through the process of configuring some representative advanced security audit policy settings. When you have completed these initial tasks, you are encouraged to use the procedures in this guide to choose, configure, apply, and assess additional security audit policy settings.

During this process, you will create an Active Directory domain, install a supported version of the Windows server operating system on a member server, install a supported version of the Windows client operating system on a client computer, and configure new advanced security audit policy settings, including global object access auditing. In addition, this document examines the "reason for access" data that is available by using a number of audit policy settings.

> [!NOTE]
> Because this topic applies to the supported Windows operating systems designated in the **Applies To** list at the beginning of this topic, combinations of operating systems can be configured to complete these walkthrough procedures. However, in this example, procedures relating to  Windows Server 2008 R2  and  Windows 7  are used.

After you complete the settings for this text environment, you can apply different sets of advanced security audit policy settings and assess how they might be used to enhance security in your organization.

As you complete the steps in this guide, you will be able to:

-   Create and apply advanced audit policy settings to a defined group of computers in your organization.

-   Verify that the audit policy settings are applied to a defined group of client computer in your organization.

-   Use the "reason for access" security event data to identify the permissions that were used to determine whether a particular security event was triggered.

-   Configure, apply, and analyze the impact of different audit policy settings to identify the settings that are important to your organization.

-   Manage per-user auditing.

## Deploying advanced audit policy settings in a test environment
After you complete this guide, you will have a working advanced security auditing infrastructure. You can then test it and learn about additional advanced security audit policy settings by logging on to CONTOSO-CLNT and ensuring that the correct audit policy is being applied on the computer.

> [!IMPORTANT]
> We recommend that you first use the procedures in this guide in a test lab environment. Walkthroughs are not meant to be used to deploy Windows features without additional deployment planning and documentation.

The test environment that is described in this guide includes three computers that are connected to a private network and use the following operating systems, applications, and services.

> [!NOTE]
> The supported Windows operating systems are designated in the **Applies To** list at the beginning of this topic.

|Computer name|Operating system|Applications and services|
|---------|----------|---------------|
|CONTOSO-DC|Supported versions of the Windows client operating system **Note:** Supported versions of the Windows server operating system or Windows Server 2003 with Service Pack 2 (SP2) can also be used for the domain controller.|Active Directory Domain Services (AD DS) and Domain Name System (DNS)|
|CONTOSO-SRV|Supported versions of Windows server|Group Policy Management Console (GPMC)|
|CONTOSO-CLNT|Supported versions of Windows client **Note:** Supported versions of Windows server  can also be used as the client computer.||

> [!NOTE]
> For more information about operating system compatibility and requirements, see [Which Editions of Windows Support Advanced Audit Policy Configuration](which-editions-of-windows-support-advanced-audit-policy-configuration.md).

The computers form a private intranet and are connected through a common hub or Layer 2 switch. This configuration can be emulated in a virtual machine environment, if desired. This walkthrough uses private addresses throughout the test lab configuration. The private network ID 10.0.0.0/24 is used for the intranet. The domain controller for the domain named contoso.com is named CONTOSO-DC. The following figure shows the configuration of the test environment.

![Figure showing the configuration of the test environment](../media/advanced-security-auditing-walkthrough/audit_sxs_network_diagram.gif)

## Steps for deploying advanced audit policies in a test environment
Complete the following steps to deploy advanced audit policy settings in a test environment.

[Step 1: Set up the infrastructure](#BKMK_Step1)

[Step 2: Create and verify an advanced audit policy](#BKMK_step2)

[Step 3: Create and verify an audit policy that provides the reason for object access](#BKMK_step3)

[Step 4: Create and verify a global object access policy](#BKMK_step4)

[Step 5: Create and verify additional advanced audit policies](#BKMK_step5)

[Optional section: Roll back security audit policy from advanced audit policy to basic audit policy](#BKMK_step6)

## <a name="BKMK_Step1"></a>Step 1: Set up the infrastructure
To prepare your test environment in the CONTOSO domain, you must complete the following tasks:

-   Configure the domain controller (CONTOSO-DC)

-   Configure the member server (CONTOSO-SRV)

-   Configure the client computer (CONTOSO-CLNT)

Use the following table as a reference when you set up the appropriate computer names, operating systems, and network settings that are required to complete the steps in this guide.

> [!IMPORTANT]
> Before you configure your computers with static IP addresses, we recommend that you first complete two important tasks that require Internet connectivity: Complete Windows product activation and use Windows Update to obtain and install any available critical security updates.

|Computer name|Operating system requirement|IP settings|DNS settings|
|---------|----------------|--------|--------|
|CONTOSO-DC|Any supported Windows server operating systems, or,  Windows Server 2008 , or Windows Server 2003 with Service Pack 2 (SP2)|IP address: 10.0.0.1<br /><br />Subnet mask: 255.255.255.0|Configured by DNS server role|
|CONTOSO-SRV| Windows Server 2008 R2 |IP address: 10.0.0.2<br /><br />Subnet mask: 255.255.255.0|Preferred: 10.0.0.1|
|CONTOSO-CLNT|Any of the supported Windows operating systems|IP address: 10.0.0.3<br /><br />Subnet mask: 255.255.255.0|Preferred: 10.0.0.1|

### Configure the domain controller (CONTOSO-DC)
Depending on your environment, you may evaluate advanced audit policy settings in a domain running supported Windows server operating systems,  Windows Server 2008 , or Windows Server 2003. For this guide, the domain is running  Windows Server 2008 R2 .

To configure the domain controller, CONTOSO-DC, running  Windows Server 2008 R2 , you must:

-   Install  Windows Server 2008 R2 

-   Configure TCP/IP properties

-   Install AD DS

-   Create a Finance organizational unit (OU)

First, install  Windows Server 2008 R2  on a stand-alone server.

##### To install Windows Server 2008 R2

1.  Start your computer by using the  Windows Server 2008 R2  product CD.

2.  When prompted for a computer name, type **CONTOSO-DC**.

3.  Follow the rest of the instructions that appear on your screen to finish the installation.

Next, configure TCP/IP properties so that CONTOSO-DC has an IPv4 static IP address of 10.0.0.1.

##### To configure TCP/IP properties

1.  Log on to CONTOSO-DC with the CONTOSO-DC\Administrator account.

2.  Click **Start**, click **Control Panel**, click **Network and Internet**, click **Network and Sharing Center**, click **Change Adapter Settings**, right-click **Local Area Connection**, and then click **Properties**.

3.  On the **Networking** tab, click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.

4.  Click **Use the following IP address**.

    -   In the **IP address** box, type **10.0.0.1**.

    -   In the **Subnet mask** box, type **255.255.255.0**.

    -   In the **Default gateway** box, type **10.0.0.1**.

5.  In the **Preferred DNS server** box, type **10.0.0.1**, and then click **OK**.

6.  On the **Networking** tab, clear the **Internet Protocol Version 6 (TCP/IPv6)** check box, and then click **Close**.

Next, configure the computer as a domain controller running  Windows Server 2008 R2  and create a Finance OU.

##### To configure CONTOSO-DC as a domain controller

1.  Click **Start**, and then click **Run**. In the **Open** box, type **dcpromo**, and then click **OK**.

2.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**, and then click **Next** again.

3.  Click **Create a new domain in a new forest**, and then click **Next**.

4.  In the **FQDN of the forest root domain** box, type **contoso.com**, and then click **Next**.

5.  Leave the default value in the **Domain NetBIOS name** box, and then click **Next**.

6.  In the **Forest functional level** list, click **Windows Server 2008 R2**, and then click **Next**.

7.  In the **Domain functional level** list, click **Windows Server 2008 R2**, and then click **Next**.

8.  Ensure that the **DNS server** check box is selected, and then click **Next**.

9. Click **Yes**, confirming that you want to create a delegation for this DNS server.

10. On the **Location for Database, Log Files, and SYSVOL** page, click **Next**.

11. In the **Password** and **Confirm password** boxes, type a strong password, and then click **Next**.

12. On the **Summary** page, click **Next** to start the installation.

13. When the installation is complete, click **Finish**, and then click **Restart Now**.

    > [!NOTE]
    > You must restart the computer after you complete this procedure.

##### To create a Finance OU in contoso.com

1.  Log on to CONTOSO-DC with the CONTOSO-DC\Administrator account.

2.  Click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Active Directory Users and Computers**.

3.  In the console tree, right-click **contoso.com**, point to **New**, and then click **Organizational Unit**.

4.  Type the name of the new OU, **Finance**, and then click **OK**.

### Configure the member server (CONTOSO-SRV) running Windows Server 2008 R2
To configure the member server, CONTOSO-SRV, you must:

-   Install  Windows Server 2008 R2 

-   Configure TCP/IP properties

-   Join CONTOSO-SRV to the domain contoso.com

-   Add CONTOSO-SRV to the Finance OU

-   Install the GPMC

First, install  Windows Server 2008 R2  as a stand-alone server.

##### To install Windows Server 2008 R2

1.  Start your computer by using the  Windows Server 2008 R2  product CD.

2.  When prompted for a computer name, type **CONTOSO-SRV**.

3.  Follow the remaining instructions that appear on your screen to finish the installation.

Next, configure TCP/IP properties so that CONTOSO-SRV has a static IP address of 10.0.0.2. In addition, configure the DNS server by using the IP address of CONTOSO-DC (10.0.0.1).

##### To configure TCP/IP properties

1.  Log on to CONTOSO-SRV with the CONTOSO-SRV\Administrator account or another user account in the local **Administrators** group.

2.  Click **Start**, click **Control Panel**, double-click **Network and Sharing Center**, click **Manage Network Connections**, right-click **Local Area Connection**, and then click **Properties**.

3.  On the **Networking** tab, click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.

4.  Click **Use the following IP address**.

    -   In the **IP address** box, type **10.0.0.2**.

    -   In the **Subnet mask** box, type **255.255.255.0**.

    -   In the **Default gateway** box, type **10.0.0.1**.

5.  Click **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.0.0.1**.

6.  Click **OK**, and then click **Close** to close the **Local Area Connection Properties** dialog box.

Next, join CONTOSO-SRV to the contoso.com domain.

##### To join CONTOSO-SRV to the contoso.com domain

1.  Click **Start**, right-click **Computer**, and then click **Properties**.

2.  Click **Change settings** (in the right pane under **Computer name, domain, and workgroup settings**), and then click **Change**.

3.  In the **Computer Name/Domain Changes** dialog box, click **Domain**, and then type **contoso.com**.

4.  Click **More**, and in the **Primary DNS suffix of this computer** box, type **contoso.com**.

5.  Click **OK**, and then click **OK** again.

6.  When a **Computer Name/Domain Changes** dialog box appears prompting you for administrative credentials, provide the credentials for CONTOSO\Administrator, and then click **OK**.

7.  When a **Computer Name/Domain Changes** dialog box appears welcoming you to the contoso.com domain, click **OK**.

8.  When a **Computer Name/Domain Changes** dialog box appears telling you that the computer must be restarted, click **OK**, and then click **Close**.

9. Click **Restart Now**.

After the computer restarts, add CONTOSO-SRV to the Finance OU.

##### To add a server to the Finance OU

1.  Log on to CONTOSO-DC with the CONTOSO-DC\Administrator account.

2.  Click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Active Directory Users and Computers**.

3.  In the console tree, right-click **contoso.com**.

4.  In the console tree, right-click the **Finance** OU, point to **New**, and then click **Group**.

5.  Type the name of the new group, **Computers**, and then in **Group scope**, click **Domain local**, and in **Group type**, click **Security group**.

6.  Right-click **Computers**, and then click **Properties**. On the **Members** tab, click **Add**.

7.  In **Enter the object names to select**, type **CONTOSO-SRV**, and then click **OK**.

Finally, use Server Manager to install the GPMC on CONTOSO-SRV. This will be used to configure the advanced security audit policy settings.

##### To install the GPMC

1.  Log on to CONTOSO-SRV as a member of the local **Administrators** group.

2.  Click **Start**, point to **Administrative Tools**, and then click **Server Manager**.

3.  Under **Feature Summary**, click **Add Features**.

4.  Select the **Group Policy Management** check box, and then click **Install**.

5.  Close Server Manager.

### Configure the client computer (CONTOSO-CLNT)
To configure CONTOSO-CLNT, you must:

-   Install  Windows 7 

-   Configure TCP/IP properties

-   Join CONTOSO-CLNT to the domain contoso.com

##### To install Windows 7

1.  Start your computer by using the  Windows 7  product CD.

2.  Follow the instructions that appear on your screen, and when prompted for a computer name, type **CONTOSO-CLNT**.

Next, configure TCP/IP properties so that CONTOSO-CLNT has a static IP address of 10.0.0.3. In addition, configure the DNS server of CONTOSO-DC (10.0.0.1).

##### To configure TCP/IP properties

1.  Log on to CONTOSO-CLNT with the CONTOSO-CLNT\Administrator account or another user account in the local **Administrators** group.

2.  Click **Start**, click **Control Panel**, click **Network and Internet**, and then click **Network and Sharing Center**.

3.  Click **Change adapter settings**, right-click **Local Area Connection**, and then click **Properties**.

4.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

5.  On the **Networking** tab, click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.

6.  Click **Use the following IP address**. In **IP address**, type **10.0.0.3**. In **Subnet mask**, type **255.255.255.0**.

7.  Click **Use the following DNS server addresses**. In **Preferred DNS server**, type **10.0.0.1**.

8.  Click **OK**, and then click **Close** to close the **Local Area Connection Properties** dialog box.

Next, join CONTOSO-CLNT to the contoso.com domain.

##### To join CONTOSO-CLNT to the contoso.com domain

1.  Click **Start**, right-click **Computer**, and then click **Properties**.

2.  Under **Computer name, domain, and workgroup settings**, click **Change settings**.

3.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

4.  On the **Computer Name** tab, click **Change**.

5.  In the **Computer Name/Domain Changes** dialog box, click **Domain**, and then type **contoso.com**.

6.  Click **More**, and in the **Primary DNS suffix of this computer** box, type **contoso.com**.

7.  Click **OK**, and then click **OK** again.

8.  When a **Computer Name/Domain Changes** dialog box appears prompting you for administrative credentials, provide the credentials, and then click **OK**.

9. When a **Computer Name/Domain Changes** dialog box appears welcoming you to the contoso.com domain, click **OK**.

10. When a **Computer Name/Domain Changes** dialog box appears telling you that the computer must be restarted, click **OK**, and then click **Close**.

11. In the **System Settings Change** dialog box, click **Yes** to restart the computer.

## <a name="BKMK_step2"></a>Step 2: Create and verify an advanced audit policy
The nine basic audit policies under **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\Audit Policy** allow you to configure security audit policy settings for broad sets of behaviors, some of which generate many audit events. An administrator has to review all events that are generated, whether they are of interest.

In any of the supported versions of the Windows operating systems, administrators can audit more specific aspects of client behavior on the computer or network, thus making it easier to identify the behaviors that are of greatest interest. For example, in **Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\Audit Policy**, there is only one policy setting for logon events, **Audit logon events**. In **Computer Configuration\Policies\Windows Settings\Security Settings\Advanced Audit Policy Configuration\System Audit Policies**, you can choose from eight policy settings in the **Logon/Logoff** category. This provides you with more detailed control of what aspects of logon and logoff you can track.

A default domain policy is automatically generated when a new domain is created. In this section, we will edit the default domain policy and add an advanced security audit policy setting that audits when a user successfully or unsuccessfully logs on to a computer in the CONTOSO domain.

To configure, apply, and validate an advanced domain logon audit policy setting, you must:

-   Configure an advanced domain logon policy setting

-   Ensure that Advanced Audit Policy Configuration settings are not overwritten

-   Update Group Policy settings

-   Verify that the advanced logon security audit policy settings were applied correctly

#### To configure an advanced domain logon audit policy setting

1.  Log on to CONTOSO-SRV as a member of the local **Administrators** group.

2.  Click **Start**, point to **Administrative Tools**, and then click **Group Policy Management**.

3.  In the console tree, double-click **Forest: contoso.com**, double-click **Domains**, and then double-click **contoso.com**.

4.  Right-click **Default Domain Policy**, and then click **Edit**.

5.  Double-click **Computer Configuration**, double-click **Policies**, and then double-click **Windows Settings**.

6.  Double-click **Security Settings**, double-click **Advanced Audit Policy Configuration**, and then double-click **System Audit Policies**.

7.  Double-click **Logon/Logoff**, and then double-click **Logon**.

8.  Select the **Configure the following audit events** check box, select the **Success** check box, select the **Failure** check box, and then click **OK**.

When you use **Advanced Audit Policy Configuration** settings, you need to confirm that these settings are not overwritten by basic audit policy settings. The following procedure shows how to prevent conflicts by blocking the application of any basic audit policy settings.

#### To ensure that Advanced Audit Policy Configuration settings are not overwritten

1.  On CONTOSO-SRV, click **Start**, point to **Administrative Tools**, and then click **Group Policy Management**.

2.  In the console tree, double-click **Forest: contoso.com**, double-click **Domains**, and then double-click **contoso.com**.

3.  Right-click **Default Domain Policy**, and then click **Edit**.

4.  Double-click **Computer Configuration**, double-click **Policies**, and then double-click **Windows Settings**.

5.  Double-click **Security Settings**, and then click **Security Options**.

6.  Double-click **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings**, and then click **Define this policy setting**.

7.  Click **Enabled**, and then click **OK**.

Before you can verify the functionality of advanced security audit policy settings in the contoso.com domain, you will log on to CONTOSO-CLNT as the domain administrator of the contoso.com domain and ensure that the Group Policy settings have been applied.

#### To update Group Policy settings

1.  Log on to CONTOSO-CLNT as CONTOSO\Administrator.

2.  Click **Start**, point to **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.

3.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

4.  Type **gpupdate**, and then press ENTER.

After the Group Policy settings have been applied, you can verify that the audit policy settings were applied correctly.

#### To verify that the advanced logon security audit policy settings were applied correctly

1.  Log on to CONTOSO-CLNT as CONTOSO\Administrator.

2.  Click **Start**, point to **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.

3.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

4.  Type **auditpol.exe /get /category:\***, and then press ENTER.

5.  Verify that **Success**, **Failure**, or **Success and Failure** are shown to the right of **Logon**.

## <a name="BKMK_step3"></a>Step 3: Create and verify an audit policy that provides the reason for object access
One of the most common auditing needs is to track access to a particular file or folder. For example, you might need to identify an activity such as users writing to files that they should not have had access to. By enabling "reason for access" auditing, not only will you be able to track this type of activity, but you will also be able to identify the exact access control entry that allowed the undesired access, which can significantly simplify the task of modifying access control settings to prevent similar undesired object access in the future.

To configure, apply, and validate a reason for object access policy, you must:

-   Configure the file system audit policy

-   Enable auditing for a file or folder

-   Enable the handle manipulation audit policy

-   Ensure that Advanced Audit Policy Configuration settings are not overwritten

-   Update Group Policy settings

-   Review and verify the reason for access auditing data

#### To configure the file system audit policy

1.  Log on to CONTOSO-SRV as a member of the local **Administrators** group.

2.  Click **Start**, point to **Administrative Tools**, and then click **Group Policy Management**.

3.  In the console tree, double-click **Forest: contoso.com**, double-click **Domains**, and then double-click **contoso.com**.

4.  Right-click **Default Domain Policy**, and then click **Edit**.

5.  Double-click **Computer Configuration**, double-click **Policies**, and then double-click **Windows Settings**.

6.  Double-click **Security Settings**, double-click **Advanced Audit Policy Configuration**, and then double-click **System Audit Policies**.

7.  Double-click **Object Access**, and then double-click **File System**.

8.  Select the **Configure the following events** check box, and then select the **Success**, **Failure**, or both **Success** and **Failure** check boxes.

9. Click **OK**.

The file system audit policy is only used to monitor objects for which auditing SACLs have been configured. The following procedure shows how to configure auditing for a file or folder.

### <a name="BKMK_Enable"></a>To enable auditing for a file or folder

1.  Log on to CONTOSO-CLNT as a member of the local **Administrators** group.

2.  Create a new folder or .txt document.

3.  Right-click the new object, click **Properties**, and click the **Security** tab.

4.  Click **Advanced**, and then click the **Auditing** tab.

5.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

6.  Click **Add**, type a user name or computer name in the format **contoso\user1**, and then click **OK**.

7.  In the **Auditing Entries for** dialog box, select the permissions that you want to audit, such as **Full Control** or **Delete**.

8.  Click **OK** four times to complete configuration of the object SACL.

In  Windows 7  and  Windows Server 2008 R2 , the reason that someone is granted or denied access is added to the open handle event. This makes it possible for administrators to understand why someone was able to open a file, folder, or file share for a specific access. To enable this functionality, the handle manipulation audit policy also needs to be enabled to show **Success** access attempts that were allowed and **Failure** access attempts that were denied.

#### To enable the handle manipulation audit policy

1.  Log on to CONTOSO-SRV as a member of the local **Administrators** group.

2.  Click **Start**, point to **Administrative Tools**, and then click **Group Policy Management**.

3.  In the console tree, double-click **Forest: contoso.com**, double-click **Domains**, and then double-click **contoso.com**.

4.  Double-click the **Finance** OU, right-click **Finance Audit Policy**, and click **Edit**.

5.  Double-click **Computer Configuration**, double-click **Policies**, and then double-click **Windows Settings**.

6.  Double-click **Security Settings**, double-click **Advanced Audit Policy Configuration**, and then double-click **System Audit Policies**.

7.  Double-click **Object Access**, right-click **Handle Manipulation**, and click **Properties**.

8.  Select the **Configure the following audit events** check box, select the **Success** and **Failure** check boxes, and then click **OK**.

After you have created this audit policy, confirm that these advanced audit policy settings cannot be overwritten. For more information, see the "To ensure that Advanced Audit Policy Configuration settings are not overwritten" procedure in the [Step 2: Create and verify an advanced audit policy](#BKMK_step2) section.

Then apply the Group Policy updates by using the "To update Group Policy settings" procedure in the [Step 2: Create and verify an advanced audit policy](#BKMK_step2) section.

After the updated Group Policy settings have been applied, be sure to log on to and log off from CONTOSO-CLNT and complete some tasks that will generate reason for object access events. After you have completed these steps, you can review the auditing data that provides the reason for access.

#### To review reason for access auditing data

1.  On CONTOSO-CLNT, click **Start**, point to **Administrative Tools**, and then click **Event Viewer**.

2.  Click **Windows Logs**, and then click **Security**.

3.  In the **Actions** pane, click **Clear Log**.

4.  Find the file or folder that you configured in the domain-level object access procedure, and modify the file or folder by using the permissions that you configured for the user account.

5.  Go back to **Event Viewer**, and in the **Actions** pane, click **Refresh**.

6.  In the **Event ID** column, click the event or events titled **4656**, scroll down to the **Access Request Information** section, and confirm the permissions that were used to perform the task.

## <a name="BKMK_step4"></a>Step 4: Create and verify a global object access policy
A global object access audit policy can be used to enforce object access audit policy for a computer, file share, or registry without having to configure and propagate conventional SACLs. Configuring and propagating SACLs is a more complex administrative task and is difficult to verify, particularly if you need to verify to an auditor that the security policy is being enforced. By using a global object access audit policy, you can enforce a security policy such as "Log all administrative Write activity on servers containing Finance information," and verify that critical assets are being protected.

In this case, you will be auditing any changes made to registry keys by members of a specified group rather than changes made to file system objects.

To configure, apply, and validate a global object access audit policy, you must:

-   Configure a domain global object access audit policy

-   Ensure that Advanced Audit Policy Configuration settings are not overwritten

-   Update Group Policy settings

-   Confirm that global object access auditing is taking place

#### To configure a domain global object access audit policy

1.  Log on to CONTOSO-SRV as a member of the local **Administrators** group.

2.  Click **Start**, point to **Administrative Tools**, and then click **Group Policy Management**.

3.  In the console tree, double-click **Forest: contoso.com**, double-click **Domains**, and then double-click **contoso.com**.

4.  Right-click **Default Domain Policy**, and then click **Edit**.

5.  Double-click **Computer Configuration**, double-click **Policies**, and then double-click **Windows Settings**.

6.  Double-click **Security Settings**, double-click **Advanced Audit Policy Configuration**, and then double-click **System Audit Policies**.

7.  Double-click **Object Access**, and then double-click **Registry**.

8.  Select the **Configure the following events** check box, select the **Success** and **Failure** check boxes, and then click **OK**.

9. Double-click **Global Object Access Policies**, and then double-click **Registry**.

10. Select the **Define this policy setting** check box, and click **Configure**.

11. In the **Advanced Security Settings for Registry SACL** box, click **Add**.

12. Type a user name or computer name in the format **contoso\user1**, **user1@contoso.com**, or **CONTOSO-CLNT**, and click **OK**.

13. In the **Auditing Entry for Global Registry SACL** box, select the **Successful** or **Failed** activities for which you want to log audit entries???for example, **Create Subkey**, **Delete**, or **Read**.

14. Click **OK** three times to complete the audit policy configuration.

After you have created the audit policy, confirm that these advanced audit policy settings cannot be overwritten. For more information, see the "To ensure that Advanced Audit Policy Configuration settings are not overwritten" procedure in the [Step 2: Create and verify an advanced audit policy](#BKMK_step2) section.

Then apply the Group Policy updates by using the "To update Group Policy settings" procedure in the [Step 2: Create and verify an advanced audit policy](#BKMK_step2) section. After the updated Group Policy settings have been applied, log on to and log off from CONTOSO-CLNT.

#### To verify that the global object access policy has been applied

1.  Open Registry Editor, and create and modify one or more registry settings.

2.  Delete one or more of the registry settings that you created.

3.  Open Event Viewer, and confirm that your activities resulted in audit events, even though you did not set explicit auditing SACLs on the registry settings that you created, modified, and deleted.

## <a name="BKMK_step5"></a>Step 5: Create and verify additional advanced audit policies
Now that you have created, applied, and validated the three basic types of advanced security audit policy settings, you can continue to identify and test additional advanced security audit policy settings by using the basic procedures outlined in the previous sections.

Additional information is available in **Computer Configuration\Policies\Windows Settings\Security Settings\Advanced Audit Policy Configuration\System Audit Policies** by right-clicking individual settings, clicking **Properties**, and clicking the **Explain** tab.

As you apply and test additional settings, consider how the audit event data that is generated can help you create a more secure network. In particular, consider the following:

-   Is the information provided by these audit events useful?

-   Is sufficient information provided by the audit data?

-   Is too much information provided by the audit data?

-   How can I adjust these audit policy settings to get only the information that I need?

Security auditing is a critical and essential tool to help you ensure that your network assets are secure. You should spend as much time as necessary to explore and understand the new advanced security audit policy settings in the supported Windows operating systems.

## Managing per-user auditing
Security audit policy settings in the supported Windows operating systems can be configured and used only on a per-computer basis, not on a per-user basis. However, there are several ways to apply audit settings to specific users, including:

-   Where available, configure the advanced security permissions on the object being audited so that the audit policy applies only to a specific group. For example, if you want the **Object Access** policy setting to apply to a file or folder, you can configure permissions on the file or folder so that object access is only tracked for the individuals or groups you specify. The procedure titled [To enable auditing for a file or folder](#BKMK_Enable) earlier in this document describes how to complete this task.

-   Define and deploy per-user audit settings by using an audit policy text file, a logon script, and the Auditpol.exe command-line tool.

    > [!IMPORTANT]
    > Per-user auditing based on logon scripts can only be applied to individual users, not groups. You cannot use logon scripts to exclude subcategories or categories of audit policy settings for administrators.

The following procedure describes how to create an audit policy text file that can be deployed by using a logon script. For more information about using logon scripts to deploy an audit policy, see [article 921469](http://go.microsoft.com/fwlink/?LinkID=82447) in the Microsoft Knowledge Base.

#### To create an audit policy text file

1.  At a command prompt, type **auditpol /set /user:***securityprincipalname***/category:"***subcategoryname***" /include /***Success or Failure***:enable** to add a per-user audit setting. Repeat this step for each audit policy subcategory and user or group that you want to add to your audit policy text file.

    > [!NOTE]
    > To obtain a list of possible audit settings in report format, open a Command Prompt window, type **auditpol /list /subcategory:\* /r**, and press ENTER. For more information about using Auditpol, see Auditpol set and Auditpol list.

2.  At a command prompt, type **auditpol /backup /file:** *auditpolicyfilename***.txt** to export the policy.

3.  Format your policy by opening *auditpolicyfilename.txt* and removing all lines except the first line of text and the per-user audit lines of text.

    > [!NOTE]
    > Per-user audit policy text will be in the form: *ComputerName,S-1-XXXX,SubcategoryName,GUID,TextIncludeSettings,TextExcludeSettings,#*. System settings will be in the form: *ComputerName,System,SubcategoryName,GUID,TextAuditSettings,#*. Also, be sure to remove the last six lines, which contain audit option settings.

4.  When you have finished creating your file, on the **File** menu, click **Save As**, confirm that **ANSI** is selected in the **Encoding** list, and then click **OK**.

5.  At a command prompt, type **auditpol /restore /file:** *auditpolicyfilename***.txt**, and press ENTER to confirm that the desired audit settings are configured. Type **auditpol /list /user**, and press ENTER to list any users with per-user audit settings.

6.  Copy the *auditpolicyfilename.txt* file to the Netlogon share of the domain controller that holds the primary domain controller (PDC) emulator role in the domain.

    > [!IMPORTANT]
    > Do not import audit policies that contain per-user auditing settings directly into a Group Policy Object (GPO). When per-user audit settings are deployed through Group Policy and not through logon scripts as described in this procedure, unexpected levels of failure events can appear in your security audit logs.

## <a name="BKMK_step6"></a>Optional section: Roll back security audit policy from advanced audit policy to basic audit policy
When you apply advanced audit policy settings, any comparable basic security audit policy settings are replaced. If you subsequently change the advanced audit policy setting to **Not configured**, you need to complete the following steps to restore the original basic security audit policy settings:

1.  Set all Advanced Audit Policy sub-categories to **Not configured**.

2.  Delete all audit.csv files from the %SYSVOL% folder on the domain controller.

3.  Reconfigure and apply the basic audit policy settings.

Unless you complete each of these three steps, the basic audit policy settings will not be restored.



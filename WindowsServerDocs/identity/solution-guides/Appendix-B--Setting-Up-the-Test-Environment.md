---
ms.assetid: 82918181-525d-4e93-af96-957dac6aedb6
title: Appendix B Setting Up the Test Environment
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Appendix B: Setting Up the Test Environment

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic outlines the steps to build a hands-on lab to test Dynamic Access Control. The instructions are meant to be followed sequentially because there are many components that have dependencies.  

## Prerequisites  
**Hardware and software requirements**  

Requirements for setting up the test lab:  

-   A host server running Windows Server 2008 R2 with SP1 and Hyper-V  

-   A copy of the  Windows Server 2012  ISO  

-   A copy of the Windows 8 ISO  

-   Microsoft Office 2010  

-   A server running Microsoft Exchange Server 2003 or later  

You need to build the following virtual machines to test the Dynamic Access Control scenarios:  

-   DC1 (domain controller)  

-   DC2 (domain controller)  

-   FILE1 (file server and Active Directory Rights Management Services)  

-   SRV1 (POP3 and SMTP server)  

-   CLIENT1 (client computer with Microsoft Outlook)  

The passwords for the virtual machines should be as follows:  

-   BUILTIN\Administrator: pass@word1  

-   Contoso\Administrator: pass@word1  

-   All other accounts: pass@word1  

## Build the test lab virtual machines  

### Install the Hyper-V role  
You need to install the Hyper-V role on a computer running Windows Server 2008 R2 with SP1.  

##### To install the Hyper-V Role  

1.  Click **Start**, and then click Server Manager.  

2.  In the Roles Summary area of the Server Manager main window, click **Add Roles**.  

3.  On the **Select Server Roles** page, click **Hyper-V**.  

4.  On the **Create Virtual Networks** page, click one or more network adapters if you want to make their network connection available to virtual machines.  

5.  On the **Confirm Installation Selections** page, click **Install**.  

6.  The computer must be restarted to complete the installation. Click **Close** to finish the wizard, and then click **Yes** to restart the computer.  

7.  After you restart the computer, sign in with the same account you used to install the role. After the Resume Configuration Wizard completes the installation, click **Close** to finish the wizard.  

### Create an internal virtual network  
Now you will create an internal virtual network called ID_AD_Network.  

##### To create a virtual network  

1.  Open Hyper-V Manager.  

2.  From the **Actions** menu, click **Virtual Network Manager**.  

3.  Under **Create virtual network**, select the **Internal**.  

4.  Click **Add**. The **New Virtual Network** page appears.  

5.  Type **ID_AD_Network** as the name for the new network. Review the other properties and modify them if necessary.  

6.  Click **OK** to create the virtual network and close Virtual Network Manager, or click **Apply** to create the virtual network and continue using Virtual Network Manager.  

### <a name="BKMK_Build"></a>Build the domain controller  
Build a virtual machine to be used as the domain controller (DC1). Install the virtual machine using  Windows Server 2012  ISO, and name it DC1.  

##### To install Active Directory Domain Services  

1. Connect the virtual machine to the ID_AD_Network. Sign in to the DC1 as Administrator with the password <strong>pass@word1</strong>.  

2. In Server Manager, click **Manage**, and then click **Add Roles and Features**.  

3. On the **Before you begin** page, click **Next**.  

4. On the **Select installation type** page, click **Role-based or Feature-based Install**, and then click **Next**.  

5. On the **Select destination server** page, click **Next**.  

6. On the **Select server roles** page, click **Active Directory Domain Services**. In the **Add Roles and Features Wizard** dialog box, click **Add Features**, and then click **Next**.  

7. On the **Select features** page, click **Next**.  

8. On the **Active Directory Domain Services** page, review the information, and then click **Next**.  

9. On the **Confirm installation selections** page, click **Install**. The Feature installation progress bar on the Results page indicates that the role is being installed.  

10. On the **Results** page, verify that the installation succeeded, and click **Close**. In Server Manager, click the warning icon with an exclamation mark on top right corner of the screen, next to **Manage**. In the Tasks list, click the **Promote this server to a domain controller** link.  

11. On the **Deployment Configuration** page, click **Add a new forest**, type the name of the root domain, **contoso.com**, and then click **Next**.  

12. On the **Domain Controller Options** page, select the domain and forest functional levels as Windows Server 2012, specify the DSRM password <strong>pass@word1</strong>, and then click **Next**.  

13. On the **DNS Options** page, click **Next**.  

14. On the **Additional Options** page, click **Next**.  

15. On the **Paths** page, type the locations for the Active Directory database, log files, and SYSVOL folder (or accept default locations), and then click **Next**.  

16. On the **Review Options** page, confirm your selections, and then click **Next**.  

17. On the **Prerequisites Check** page, confirm that the prerequisites validation is completed, and then click **Install**.  

18. On the **Results** page, verify that the server was successfully configured as a domain controller, and then click **Close**.  

19. Restart the server to complete the AD DS installation. (By default, this happens automatically.)  

Create the following users by using Active Directory Administrative Center.  

##### Create users and groups on DC1  

1. Sign in to contoso.com as Administrator. Launch Active Directory Administrative Center.  

2. Create the following security groups:  


   |    Group Name    |        Email Address         |
   |------------------|------------------------------|
   |   FinanceAdmin   |   financeadmin@contoso.com   |
   | FinanceException | financeexception@contoso.com |


3. Create the following organizational unit (OU):  


   |   OU Name    | Computers |
   |--------------|-----------|
   | FileServerOU |   FILE1   |


4. Create the following users with the attributes indicated:  


   |       User       |  Username  |     Email address      | Department |      Group       | Country/Region |
   |------------------|------------|------------------------|------------|------------------|----------------|
   | Myriam Delesalle | MDelesalle | MDelesalle@contoso.com |  Finance   |                  |       US       |
   |    Miles Reid    |   MReid    |   MReid@contoso.com    |  Finance   |   FinanceAdmin   |       US       |
   |   Esther Valle   |   EValle   |   EValle@contoso.com   | Operations | FinanceException |       US       |
   |   Maira Wenzel   |  MWenzel   |  MWenzel@contoso.com   |     HR     |                  |       US       |
   |     Jeff Low     |    JLow    |    JLow@contoso.com    |     HR     |                  |       US       |
   |    RMS Server    |    rms     |    rms@contoso.com     |            |                  |                |

   For more information about creating security groups, see [Create a New Group](https://technet.microsoft.com/library/dd861305.aspx) on the Windows Server website.  

##### To create a Group Policy Object  

1.  Hover the cursor on the upper right corner of screen and click the search icon. In the Search box, type **group policy management**, and click **Group Policy Management**.  

2.  Expand **Forest: contoso.com**, and then expand **Domains**, navigate to **contoso.com**, expand **(contoso.com)**, and then select **FileServerOU**. Right-click **Create a GPO in this domain and Link it here**

3.  Type a descriptive name for the GPO, such as **FlexibleAccessGPO**, and then click **OK**.  

##### To enable Dynamic Access Control for contoso.com  

1.  Open the Group Policy Management Console, click **contoso.com**, and then double-click **Domain Controllers**.  

2.  Right-click **Default Domain Controllers Policy**, and select **Edit**.  

3.  In the Group Policy Management Editor window, double-click **Computer Configuration**, double-click **Policies**, double-click **Administrative Templates**, double-click **System**, and then double-click **KDC**.  

4.  Double-click **KDC support for claims, compound authentication, and Kerberos armoring** and select the option next to **Enabled**. You need to enable this setting to use Central Access Policies.  

5.  Open an elevated command prompt, and run the following command:  

    ```  
    gpupdate /force  
    ```  

### <a name="BKMK_FS1"></a>Build the file server and AD RMS server (FILE1)  

1. Build a virtual machine with the name FILE1 from the  Windows Server 2012  ISO.  

2. Connect the virtual machine to the ID_AD_Network.  

3. Join the virtual machine to the contoso.com domain, and then sign in to FILE1 as contoso\administrator using the password <strong>pass@word1</strong>.  

#### Install File Services Resource Manager  

###### To install the File Services role and the File Server Resource Manager  

1.  In Server Manager, click **Add Roles and Features**.  

2.  On the **Before you begin** page, click **Next**.  

3.  On the **Select installation type** page, click **Next**.  

4.  On the **Select destination server** page, click **Next**.  

5.  On the **Select Server Roles** page, expand **File and Storage Services**, select the check-box next to **File and iSCSI Services**, expand, and select **File Server Resource Manager**.  

    In the Add Roles and Features Wizard, click **Add Features**, and then click **Next**.  

6.  On the **Select features** page, click **Next**.  

7.  On the **Confirm installation selections** page, click **Install**.  

8.  On the **Installation progress** page, click **Close**.  

#### Install the Microsoft Office Filter Packs on the file server  
You should install the Microsoft Office Filter Packs on  Windows Server 2012  to enable IFilters for a wider array of Office files than are provided by default.  Windows Server 2012  does not have any IFilters for Microsoft Office Files installed by default, and the file classification infrastructure uses IFilters to perform content analysis.  

To download and install the IFilters, see [Microsoft Office 2010 Filter Packs](https://go.microsoft.com/fwlink/?LinkID=234122).  

#### Configure email notifications on FILE1  
When you create quotas and file screens, you have the option of sending email notifications to users when their quota limit is approaching or after they have attempted to save files that have been blocked. If you want to routinely notify certain administrators of quota and file screening events, you can configure one or more default recipients. To send these notifications, you must specify the SMTP server to be used for forwarding the email messages.  

###### To configure email options in File Server Resource Manager  

1. Open File Server Resource Manager. To open File Server Resource Manager, click **Start**, type **file server resource manager**, and then click **File Server Resource Manager**.  

2. In the File Server Resource Manager interface, right-click **File Server Resource Manager**, and then click **Configure options**. The **File Server Resource Manager Options** dialog box opens.  

3. On the **E-mail Notifications** tab, under SMTP server name or IP address, type the host name or the IP address of the SMTP server that will forward email notifications.  

4. If you want to routinely notify certain administrators of quota or file screening events, under **Default administrator recipients**, type each email address such as fileadmin@contoso.com. Use the format account@domain, and use semicolons to separate multiple accounts.  

#### Create groups on FILE1  

###### To create security groups on FILE1  

1. Sign in to FILE1 as contoso\administrator, with the password: <strong>pass@word1</strong>.  

2. Add NT AUTHORITY\Authenticated Users to the **WinRMRemoteWMIUsers__** group.  

#### Create files and folders on FILE1  

1.  Create a new NTFS volume on FILE1 and then create the following folder: D:\Finance Documents.  

2.  Create the following files with the details specified:  

    -   **Finance Memo.docx**: Add some finance related text in the document. For example, 'The business rules about who can access finance documents have changed. Finance documents are now only accessed by members of the FinanceExpert group. No other departments or groups have access.' You need to evaluate the impact of this change before implementing it in the environment. Ensure that this document has CONTOSO CONFIDENTIAL as the footer on every page.  

    -   **Request for Approval to Hire.docx**: Create a form in this document that collects applicant information. You must have the following fields in the document: **Applicant Name, Social Security number, Job Title, Proposed Salary, Starting Date, Supervisor name, Department**. Add an additional section in the document that has a form for **Supervisor Signature, Approved Salary, Conformation of Offer**, and **Status of Offer**.   
        Make the document rights-management enabled.  

    -   **Word Document1.docx**: Add some test content to this document.  

    -   **Word Document2.docx**: Add test content to this document.  

    -   **Workbook1.xlsx**  

    -   **Workbook2.xlsx**  

    -   Create a folder on the desktop called Regular Expressions. Create a text document under the folder called **RegEx-SSN**. Type the following content in the file, and then save and close the file:   
        ^(?!000)([0-7]\d{2}|7([0-7]\d|7[012]))([ -]?)(?!00)\d\d\3(?!0000)\d{4}$  

3.  Share the folder D:\Finance Documents as Finance Documents and allow everyone to have Read and Write access to the share.  

> [!NOTE]  
> Central access policies are not enabled by default on the system or boot volume C:.  

#### <a name="BKMK_CS1"></a>Install Active Directory Rights Management Services  
Add the Active Directory Rights Management Services (AD RMS) and all required features through Server Manager. Choose all the defaults.  

###### To install Active Directory Rights Management Services  

1. Sign in to the FILE1 as CONTOSO\Administrator or as a member of the Domain Admins group.  

   > [!IMPORTANT]  
   > In order to install the AD RMS server role the installer account (in this case, CONTOSO\Administrator) will have to be given membership in both the local Administrators group on the server computer where AD RMS is to be installed as well as membership in the Enterprise Admins group in Active Directory.  

2. In Server Manager, click **Add Roles and Features**. The Add Roles and Features Wizard appears.  

3. On the **Before you Begin** screen, click **Next**.  

4. On the **Select Installation Type** screen, click **Role/Feature Based Install**, and then click **Next**.  

5. On the **Select Server Targets** screen, click **Next**.  

6. On the **Select Server Roles** screen, select the box next to **Active Directory Rights Management Services**, and then click **Next**.  

7. In the **Add features that are required for Active Directory Rights Management Services?** dialog box, click **Add Features**.  

8. On the **Select Server Roles** screen, click **Next**.  

9. On the **Select Features to Install** screen, click **Next**.  

10. On the **Active Directory Rights Management Services** screen, click Next.  

11. On the **Select Role Services** screen, click **Next**.  

12. On the **Web Server Role (IIS)** screen, click **Next**.  

13. On the **Select Role Services** screen, click **Next**.  

14. On the **Confirm Installation Selections** screen, click **Install**.  

15. After the installation has completed, on the **Installation Progress** screen, click **Perform additional configuration**. The AD RMS Configuration Wizard appears.  

16. On the **AD RMS** screen, click **Next**.  

17. On the **AD RMS Cluster** screen, select **Create a new AD RMS root cluster** and then click **Next**.  

18. On the **Configuration Database** screen, click **Use Windows Internal Database on this server**, and then click **Next**.  

    > [!NOTE]  
    > Using the Windows Internal Database is recommended for test environments only because it does not support more than one server in the AD RMS cluster. Production deployments should use a separate database server.  

19. On the **Service Account** screen, in **Domain User Account**, click **Specify** and then specify the user name (**contoso\rms**), and Password (<strong>pass@word1</strong>) and click **OK**, and then click **Next**.  

20. On the **Cryptographic Mode** screen, click **Cryptographic Mode 2**.  

21. On the **Cluster Key Storage** screen, click **Next**.  

22. On the **Cluster Key Password** screen, in the **Password** and **Confirm password** boxes, type <strong>pass@word1</strong>, and then click **Next**.  

23. On the **Cluster Web Site** screen, make sure that **Default Web Site** is selected, and then click **Next**.  

24. On the **Cluster Address** screen, select the **Use an unencrypted connection** option, in the **Fully Qualified Domain Name** box, type **FILE1.contoso.com**, and then click **Next**.  

25. On the **Licensor Certificate Name** screen, accept the default name (**FILE1**) in the text box and click **Next**.  

26. On the **SCP Registration** screen, select **Register SCP now**, and then click **Next**.  

27. On the **Confirmation** screen, click **Install**.  

28. On the **Results** screen, click **Close**, and then click **Close** on **Installation Progress** screen. When complete, log off and log on as contoso\rms using the password provided (<strong>pass@word1</strong>).  

29. Launch the AD RMS console and navigate to **Rights Policy Templates**.  

    To open the AD RMS console, in Server Manager, click **Local Server** in the console tree, then click **Tools**, and then click **Active Directory Rights Management Services**.  

30. Click the **Create Distributed Rights Policy** template located on the right panel, click **Add**, and select the following information:  

    -   Language: US English  

    -   Name: Contoso Finance Admin Only  

    -   Description: Contoso Finance Admin Only  

    Click **Add**, and then click **Next**.  

31. Under the Users and Rights section, click **Users and rights**, click **Add**, type <strong>financeadmin@contoso.com</strong>, and click **OK**.  

32. Select **Full Control**, and leave **Grant owner (author) full control right with no expiration** selected.  

33. Click though the remaining tabs with no changes, and then click **Finish**. Sign in as CONTOSO\Administrator.  

34. Browse to the folder, C:\inetpub\wwwroot\\_wmcs\certification, select the ServerCertification.asmx file, and add Authenticated Users to have Read and Write permissions to the file.  

35. Open Windows PowerShell and run `Get-FsrmRmsTemplate`. Verify that you are able to see the RMS template you created in the previous steps in this procedure with this command.  

> [!IMPORTANT]  
> If you want your file servers to immediately change so you can test them, you need to do the following:  
>   
> 1.  On the file server, FILE1, open an elevated command prompt, and run the following commands:  
>   
>     -   gpupdate /force.  
>     -   NLTEST /SC_RESET:contoso.com  
> 2.  On the domain controller (DC1), replicate Active Directory.  
>   
>     For more information about steps to force the replication of Active Directory, see [Active Directory Replication](https://technet.microsoft.com/library/cc794809(WS.10).aspx)  

Optionally, instead of using the Add Roles and Features Wizard in Server Manager, you can use Windows PowerShell to install and configure the AD RMS server role as show in the following procedure.  

###### To install and configure an AD RMS cluster in Windows Server 2012 using Windows PowerShell  

1. Logon on as CONTOSO\Administrator with the password: <strong>pass@word1</strong>.  

   > [!IMPORTANT]  
   > In order to install the AD RMS server role the installer account (in this case, CONTOSO\Administrator) will have to be given membership in both the local Administrators group on the server computer where AD RMS is to be installed as well as membership in the Enterprise Admins group in Active Directory.  

2. On the Server desktop, right-click the Windows PowerShell icon on the taskbar and select **Run as Administrator** to open a Windows PowerShell prompt with administrative privileges.  

3. To use Server Manager cmdlets to install the AD RMS server role, type:  

   ```  
   Add-WindowsFeature ADRMS '"IncludeAllSubFeature '"IncludeManagementTools  
   ```  

4. Create the Windows PowerShell drive to represent the AD RMS server you are installing.  

   For example, to create a Windows PowerShell drive named RC to install and configure the first server in an AD RMS root cluster, type:  

   ```  
   Import-Module ADRMS  
   New-PSDrive -PSProvider ADRMSInstall -Name RC -Root RootCluster  
   ```  

5. Set properties on objects in the drive namespace that represent required configuration settings.  

   For example, to set the AD RMS service account, at the Windows PowerShell command prompt, type:  

   ```  
   $svcacct = Get-Credential  
   ```  

   When the Windows security dialog box appears, type the AD RMS service account domain user name CONTOSO\RMS and the assigned password.  

   Next, to assign the AD RMS service account to the AD RMS cluster settings, type the following:  

   ```  
   Set-ItemProperty -Path RC:\ -Name ServiceAccount -Value $svcacct  
   ```  

   Next, to set the AD RMS server to use the Windows Internal Database, at the Windows PowerShell command prompt, type:  

   ```  
   Set-ItemProperty -Path RC:\ClusterDatabase -Name UseWindowsInternalDatabase -Value $true  
   ```  

   Next, to securely store the cluster key password in a variable, at the Windows PowerShell command prompt, type:  

   ```  
   $password = Read-Host -AsSecureString -Prompt "Password:"  
   ```  

   Type the cluster key password, and then press the ENTER key.  

   Next, to assign the password to your AD RMS installation, at the Windows PowerShell command prompt, type:  

   ```  
   Set-ItemProperty -Path RC:\ClusterKey -Name CentrallyManagedPassword -Value $password  
   ```  

   Next, to set the AD RMS cluster address, at the Windows PowerShell command prompt, type:  

   ```  
   Set-ItemProperty -Path RC:\ -Name ClusterURL -Value "http://file1.contoso.com:80"  
   ```  

   Next, to assign the SLC name for your AD RMS installation, at the Windows PowerShell command prompt, type:  

   ```  
   Set-ItemProperty -Path RC:\ -Name SLCName -Value "FILE1"  
   ```  

   Next, to set the service connection point (SCP) for the AD RMS cluster, at the Windows PowerShell command prompt, type:  

   ```  
   Set-ItemProperty -Path RC:\ -Name RegisterSCP -Value $true  
   ```  

6. Run the **Install-ADRMS** cmdlet. In addition to installing the AD RMS server role and configuring the server, this cmdlet also installs other features required by AD RMS if necessary.  

   For example, to change to the Windows PowerShell drive named RC and install and configure AD RMS, type:  

   ```  
   Set-Location RC:\  
   Install-ADRMS -Path.  
   ```  

   Type "Y" when the cmdlet prompts you to confirm you want to start the installation.  

7. Log out as CONTOSO\Administrator and log on as CONTOSO\RMS using the provided password ("pass@word1").  

   > [!IMPORTANT]  
   > In order to manage the AD RMS server the account you are logged on to and using to manage the server (in this case, CONTOSO\RMS) will have to be given membership in both the local Administrators group on the AD RMS server computer as well as membership in the Enterprise Admins group in Active Directory.  

8. On the Server desktop, right-click the Windows PowerShell icon on the taskbar and select **Run as Administrator** to open a Windows PowerShell prompt with administrative privileges.  

9. Create the Windows PowerShell drive to represent the AD RMS server you are configuring.  

    For example, to create a Windows PowerShell drive named RC to configure the AD RMS root cluster, type:  

    ```  
    Import-Module ADRMSAdmin `  
    New-PSDrive -PSProvider ADRMSAdmin -Name RC -Root http://localhost -Force -Scope Global  
    ```  

10. To create new rights template for the Contoso finance administrator and assign it user rights with full control in your AD RMS installation, at the Windows PowerShell command prompt, type:  

    ```  
    New-Item -Path RC:\RightsPolicyTemplate '"LocaleName en-us -DisplayName "Contoso Finance Admin Only" -Description "Contoso Finance Admin Only" -UserGroup financeadmin@contoso.com  -Right ('FullControl')  
    ```  

11. To verify that you can see the new rights template for the Contoso finance administrator, at the Windows PowerShell command prompt:  

    ```  
    Get-FsrmRmsTemplate  
    ```  

    Review the output of this cmdlet to confirm the RMS template you created in the previous step is present.  

### Build the mail server (SRV1)  
SRV1 is the SMTP/POP3 mail server. You need to set it up so that you can send email notifications as part of the Access-Denied assistance scenario.  

Configure Microsoft Exchange Server on this computer. For more information, see [How to Install Exchange Server](https://go.microsoft.com/fwlink/?prd=12364).  

### Build the client virtual machine (CLIENT1)  

##### To build the client virtual machine  

1. Connect the CLIENT1 to the ID_AD_Network.  

2. Install Microsoft Office 2010.  

3. Sign in as Contoso\Administrator, and use the following information to configure Microsoft Outlook.  

   - Your name: File Administrator  

   - Email address: fileadmin@contoso.com  

   - Account type: POP3  

   - Incoming mail server: Static IP address of SRV1  

   - Outgoing mail server: Static IP address of SRV1  

   - User name: fileadmin@contoso.com  

   - Remember password: Select  

4. Create a shortcut to Outlook on the contoso\administrator desktop.  

5. Open Outlook and address all the 'first time launched' messages.  

6. Delete any test messages that were generated.  

7. Create a new short cut on desktop for all users on the client virtual machine that points to \\\FILE1\Finance Documents.  

8. Reboot as needed.  

##### Enable Access-Denied assistance on the client virtual machine  

1.  Open Registry Editor, and navigate to **HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer**.  

    -   Set **EnableShellExecuteFileStreamCheck** to **1**.  

    -   Value: DWORD  

## <a name="BKMK_CF"></a>Lab setup for deploying claims across forests scenario  

### <a name="BKMK_2.1"></a>Build a virtual machine for DC2  

-   Build a virtual machine from the  Windows Server 2012  ISO.  

-   Create the virtual machine name as DC2.  

-   Connect the virtual machine to the ID_AD_Network.  

> [!IMPORTANT]  
> Joining virtual machines to a domain and deploying claim types across forests require that the virtual machines be able to resolve the FQDNs of the relevant domains. You may have to manually configure the DNS settings on the virtual machines to accomplish this. For more information, see [Configuring a virtual network](https://technet.microsoft.com/library/cc732470%28v=ws.10%29.aspx).  
>   
> All the virtual machine images (servers and clients) must be reconfigured to use a static IP version 4 (IPv4) address and Domain Name System (DNS) client settings. For more information, see [Configure a DNS Client for Static IP Address](https://go.microsoft.com/fwlink/?LinkId=150952).  

### <a name="BKMK_2.2"></a>Set up a new forest called adatum.com  

##### To install Active Directory Domain Services  

1. Connect the virtual machine to the ID_AD_Network. Sign in to the DC2 as Administrator with the password <strong>Pass@word1</strong>.  

2. In Server Manager, click **Manage**, and then click **Add Roles and Features**.  

3. On the **Before you begin** page, click **Next**.  

4. On the **Select Installation Type** page, click **Role-based or Feature-based Install**, and then click **Next**.  

5. On the **Select destination server** page, click **Select a server from the server pool**, click the names of the server where you want to install Active Directory Domain Services (AD DS), and then click **Next**.  

6. On the **Select Server Roles** page, click **Active Directory Domain Services**. In the **Add Roles and Features Wizard** dialog box, click **Add Features**, and then click **Next**.  

7. On the **Select Features** page, click **Next**.  

8. On the **AD DS** page, review the information, and then click **Next**.  

9. On the **Confirmation** page, click **Install**. The Feature installation progress bar on the Results page indicates that the role is being installed.  

10. On the **Results** page, verify that the installation succeeded, and then click the warning icon with an exclamation mark on top right corner of the screen, next to **Manage**. In the Tasks list, click the **Promote this server to a domain controller** link.  

    > [!IMPORTANT]  
    > If you close the installation wizard at this point rather than click **Promote this server to a domain controller**, you can continue the AD DS installation by clicking **Tasks** in Server Manager.  

11. On the **Deployment Configuration** page, click **Add a new forest**, type the name of the root domain, **adatum.com**, and then click **Next**.  

12. On the **Domain Controller Options** page, select the domain and forest functional levels as Windows Server 2012, specify the DSRM password <strong>pass@word1</strong>, and then click **Next**.  

13. On the **DNS Options** page, click **Next**.  

14. On the **Additional Options** page, click **Next**.  

15. On the **Paths** page, type the locations for the Active Directory database, log files, and SYSVOL folder (or accept default locations), and then click **Next**.  

16. On the **Review Options** page, confirm your selections, and then click **Next**.  

17. On the **Prerequisites Check** page, confirm that the prerequisites validation is completed, and then click **Install**.  

18. On the **Results** page, verify that the server was successfully configured as a domain controller, and then click **Close**.  

19. Restart the server to complete the AD DS installation. (By default, this happens automatically.)  

> [!IMPORTANT]  
> To ensure that the network is configured properly, after you have set up both the forests, you must do the following:  
>   
> -   Sign in to adatum.com as adatum\administrator. Open a Command Prompt window, type **nslookup contoso.com**, and then press ENTER.  
> -   Sign in to contoso.com as contoso\administrator. Open a Command Prompt window, type **nslookup adatum.com**, and then press ENTER.  
>   
> If these commands execute without errors, the forests can communicate with each other. For more information on nslookup errors, see the troubleshooting section in the topic [Using NSlookup.exe](https://support.microsoft.com/kb/200525)  

### <a name="BKMK_2.22"></a>Set contoso.com as a trusting forest to adatum.com  
In this step, you create a trust relationship between the Adatum Corporation site and the Contoso, Ltd. site.  

##### To set Contoso as a trusting forest to Adatum  

1.  Sign in to DC2 as administrator. On the **Start** screen, type domain.msc.  

2.  In the console tree, right-click adatum.com, and then click Properties.  

3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  

4.  On the **Trust Name** page, type **contoso.com**, in the Domain Name System (DNS) name field, and then click **Next**.  

5.  On the **Trust Type** page, click **Forest Trust**, and then click **Next**.  

6.  On the **Direction of Trust** page, click **Two-way**.  

7.  On the **Sides of Trust** page, click **Both this domain and the specified domain**, and then click **Next**.  

8.  Continue to follow the instructions in the wizard.  

### <a name="BKMK_2.4"></a>Create additional users in the Adatum forest  
Create the user Jeff Low with the password <strong>pass@word1</strong>, and assign the company attribute with the value **Adatum**.  

##### To create a user with the Company attribute  

1.  Open an elevated command prompt in Windows PowerShell, and paste the following code:  

    ```  
    New-ADUser `  
    -SamAccountName jlow `  
    -Name "Jeff Low" `  
    -UserPrincipalName jlow@adatum.com `  
    -AccountPassword (ConvertTo-SecureString `  
    -AsPlainText "pass@word1" -Force) `  
    -Enabled $true `  
    -PasswordNeverExpires $true `  
    -Path 'CN=Users,DC=adatum,DC=com' `  
    -Company Adatum`  

    ```  

### <a name="BKMK_2.5"></a>Create the Company claim type on adataum.com  

##### To create a claim type by using Windows PowerShell  

1.  Sign in to adatum.com as an administrator.  

2.  Open an elevated command prompt in Windows PowerShell, and type the following code:  

    ```  
    New-ADClaimType `  
    -AppliesToClasses:@('user') `  
    -Description:"Company" `  
    -DisplayName:"Company" `  
    -ID:"ad://ext/Company:ContosoAdatum" `  
    -IsSingleValued:$true `  
    -Server:"adatum.com" `  
    -SourceAttribute:Company `  
    -SuggestedValues:@((New-Object Microsoft.ActiveDirectory.Management.ADSuggestedValueEntry("Contoso", "Contoso", "")), (New-Object Microsoft.ActiveDirectory.Management.ADSuggestedValueEntry("Adatum", "Adatum", ""))) `  

    ```  

### <a name="BKMK_2.55"></a>Enable the Company resource property on contoso.com  

##### To enable the Company resource property on contoso.com  

1.  Sign in to contoso.com as an administrator.  

2.  In Server Manager, click **Tools**, and then click **Active Directory Administrative Center**.  

3.  In the left pane of Active Directory Administrative Center, click **Tree View**. In the left pane, click **Dynamic Access Control**, and then double-click **Resource Properties**.  

4.  Select **Company** from the **Resource Properties** list, right-click and select **Properties**. In the **Suggested Values** section, click **Add** to add the suggested values: Contoso and Adatum, and then click **OK** twice.  

5.  Select **Company** from the **Resource Properties** list, right-click and select **Enable**.  

### <a name="BKMK_2.6"></a>Enable Dynamic Access Control on adatum.com  

##### To enable Dynamic Access Control for adatum.com  

1.  Sign in to adatum.com as an administrator.  

2.  Open the Group Policy Management Console, click **adatum.com**, and then double-click **Domain Controllers**.  

3.  Right-click **Default Domain Controllers Policy**, and select **Edit**.  

4.  In the Group Policy Management Editor window, double-click **Computer Configuration**, double-click **Policies**, double-click **Administrative Templates**, double-click **System**, and then double-click **KDC**.  

5.  Double-click **KDC support for claims, compound authentication, and Kerberos armoring** and select the option next to **Enabled**. You need to enable this setting to use Central Access Policies.  

6.  Open an elevated command prompt, and run the following command:  

    ```  
    gpupdate /force  
    ```  

### <a name="BKMK_2.8"></a>Create the Company claim type on contoso.com  

##### To create a claim type by using Windows PowerShell  

1.  Sign in to contoso.com as an administrator.  

2.  Open an elevated command prompt in Windows PowerShell, then type the following code:  

    ```  
    New-ADClaimType '"SourceTransformPolicy `  
    '"DisplayName 'Company' `  
    '"ID 'ad://ext/Company:ContosoAdatum' `  
    '"IsSingleValued $true `  
    '"ValueType 'string' `  

    ```  

### <a name="BKMK_2.9"></a>Create the central access rule  

##### To create a central access rule  

1. In the left pane of Active Directory Administrative Center, click **Tree View**. In the left pane, click **Dynamic Access Control**, and then click **Central Access Rules**.  

2. Right-click **Central Access Rules**, click **New**, and then **Central Access Rule**.  

3. In the **Name** field, type **AdatumEmployeeAccessRule**.  

4. In the **Permissions** section, select the **Use following permissions as current permissions** option, click **Edit**, and then click **Add**. Click the **Select a principal** link, type **Authenticated Users**, and then click **OK**.  

5. In the **Permission Entry for Permissions** dialog box, click **Add a condition**, and enter the following conditions:  [**User**] [**Company**] [**Equals**] [**Value**] [**Adatum**]. Permissions should be **Modify, Read and Execute, Read, Write**.  

6. Click **OK**.  

7. Click **OK** three times to finish and return to Active Directory Administrative Center.  

   ![solution guides](media/Appendix-B--Setting-Up-the-Test-Environment/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

   The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  

   ```  
   New-ADCentralAccessRule `  
   -CurrentAcl:"O:SYG:SYD:AR(A;;FA;;;OW)(A;;FA;;;BA)(A;;FA;;;SY)(XA;;0x1301bf;;;AU;(@USER.ad://ext/Company:ContosoAdatum == `"Adatum`"))" `  
   -Name:"AdatumEmployeeAccessRule" `  
   -ProposedAcl:$null `  
   -ProtectedFromAccidentalDeletion:$true `  
   -Server:"contoso.com" `  
   ```  

### <a name="BKMK_2.10"></a>Create the central access policy  

##### To create a central access policy  

1.  Sign in to contoso.com as an administrator.  

2.  Open an elevated command prompt in Windows PowerShell, and then paste the following code:  

    ```  
    New-ADCentralAccessPolicy "Adatum Only Access Policy"   
    Add-ADCentralAccessPolicyMember "Adatum Only Access Policy" `  
    -Member "AdatumEmployeeAccessRule" `  
    ```  

### <a name="BKMK_2.11"></a>Publish the new policy through Group Policy  

##### To apply the central access policy across file servers through Group Policy  

1.  On the **Start** screen, type **Administrative Tools**, and in the **Search** bar, click **Settings**. In the **Settings** results, click **Administrative Tools**. Open the Group Policy Management Console from the **Administrative Tools** folder.  

    > [!TIP]  
    > If the **Show Administrative tools** setting is disabled, the Administrative Tools folder and its contents will not appear in the **Settings** results.  

2.  Right-click the contoso.com domain, click **Create a GPO in this domain and Link it here**  

3.  Type a descriptive name for the GPO, such as **AdatumAccessGPO**, and then click **OK**.  

##### To apply the central access policy to the file server through Group Policy  

1.  On the **Start** screen, type **Group Policy Management**, in the **Search** box. Open **Group Policy Management** from the Administrative Tools folder.  

    > [!TIP]  
    > If the **Show Administrative tools** setting is disabled, the Administrative Tools folder and its contents will not appear in the Settings results.  

2.  Navigate to and select Contoso as follows: Group Policy Management\Forest: contoso.com\Domains\contoso.com.  

3.  Right-click the **AdatumAccessGPO** policy, and select **Edit**.  

4.  In Group Policy Management Editor, click **Computer Configuration**, expand **Policies**, expand **Windows Settings**, and then click **Security Settings**.  

5.  Expand **File System**, right-click **Central Access Policy**, and then click **Manage Central access policies**.  

6.  In the **Central Access Policies Configuration** dialog box, click **Add**, select **Adatum Only Access Policy**, and then click **OK**.  

7.  Close the Group Policy Management Editor. You have now added the central access policy to Group Policy.  

### <a name="BKMK_2.12"></a>Create the Earnings folder on the file server  
Create a new NTFS volume on FILE1, and create the following folder: D:\Earnings.  

> [!NOTE]  
> Central access policies are not enabled by default on the system or boot volume C:.  

### <a name="BKMK_2.13"></a>Set classification and apply the central access policy on the Earnings folder  

##### To assign the central access policy on the file server  

1. In Hyper-V Manager, connect to server FILE1. Sign in to the server by using Contoso\Administrator, with the password <strong>pass@word1</strong>.  

2. Open an elevated command prompt and type: **gpupdate /force**. This will ensure that your Group Policy changes will take effect on your server.  

3. You also need to refresh the Global Resource Properties from Active Directory. Open Windows PowerShell, type `Update-FSRMClassificationpropertyDefinition`, and then press ENTER. Close Windows PowerShell.  

4. Open Windows Explorer, and navigate to D:\EARNINGS. Right-click the **Earnings** folder, and click **Properties**.  

5. Click the **Classification** tab. Select **Company**, and then select **Adatum** in the **Value** field.  

6. Click **Change**, select **Adatum Only Access Policy** from the drop-down menu, and then click **Apply**.  

7. Click the **Security** tab, click **Advanced**, and then click the **Central Policy** tab. You should see the **AdatumEmployeeAccessRule** listed. You can expand the item to view all of the permissions that you set when you created the rule in Active Directory.  

8. Click **OK** to return to Windows Explorer.  




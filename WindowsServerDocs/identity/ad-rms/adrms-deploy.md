---
ms.assetid: e6fa9069-ec9c-4615-b266-957194b49e11
title: Upgrading AD RMS to Windows Server 2016
description:
author: msmbaldwin
ms.author: esaggese
ms.date: 05/30/2019
ms.topic: article

---

# Upgrading AD RMS to Windows Server 2016

## Introduction

Active Directory Rights Management Services (AD RMS) is a Microsoft service that protects sensitive documents and emails. Unlike traditional protection methods, such as firewalls and ACLs, AD RMS encryption and protection are persistent no matter where a file goes or how it is transported. 

This document provides guidance for migrating from Windows Server 2012 R2 with SQL Server 2012 to Windows Server 2016 and SQL Server 2016. The same process can be used to migrate from older but supported versions of AD RMS.
Please note that Active Directory Rights Management Services is no longer in active development, and for the latest capabilities customers should consider migrating to [Azure Information Protection](https://azure.microsoft.com/services/information-protection/), which offers a much more comprehensive set of features with more complete device and application support. 

For information on migrating to Azure Information Protection from AD RMS without having to re-protect your content see [the Azure Information Protection migration documentation](https://docs.microsoft.com/azure/information-protection/migrate-from-ad-rms-to-azure-rms).

## About the environment used in this guide

AD FS is an optional component of an AD RMS installation. In this guide, the use of ADFS is assumed. If ADFS hasn't been used in your environment for supporting AD RMS users, you can skip all steps that refer to ADFS.

In this guide, SQL Server is upgraded to SQL Server 2016 by performing a parallel install and moving the databases over via a backup. 
Alternatively, if you can upgrade your AD RMS and ADFS database servers to SQL Server 2016 in-place, you can move to the next section in this document after having done that without having to follow the steps in this section.  

## Installation

### Configuring SQL Server 2016

The following section details implementation tasks related directly to the SQL Server 2016 configuration. This guide focuses on using the Server Manager and the SQL Server Management Studio to complete these tasks.

These steps must be completed on a SQL Server 2016 installation. Install SQL Server 2016 on suitable hardware as per your organization's standard practices and policies. 

#### Preparing the SQL Server

The following section details how to prepare the SQL Server so that it can be upgraded to SQL Server 2016 before upgrading other services in the AD RMS platform to use Windows Server 2016.

##### Adding CNAME for SQL Server 2016 to DNS

The CNAME is used to help ensure that the Windows Server 2016 setup will be getting the appropriate data since it will be pointed at the new SQL Server 2016. **Note: If already using a CNAME for the ADFS and AD RMS service, you can move on to the next steps.**


**To add a CNAME for SQL Server 2016 to DNS**

1.  Log on to the Windows Server 2012 R2 Domain Controller with Domain admin credentials.

2.  Open Server Manager.

3.  Click **Tools** and select **DNS** to open the DNS Manager.

4.  From the left navigation pane, expand the DC and open up **Forward Lookup Zones**.

5.  Open the appropriate domain resources then right click in the right view pane and select **New Alias (CNAME)** to begin creating the CNAME.

6.  For the alias name enter in a logical name to differentiate it from other that may be present (Ex. SQLADRMS or SQLADFS)

7.  After entering the name, provide the FQDN for the target host which will be the new SQL Server 2016 server. (ex. SQL2016.contoso.com)

8.  Once all the information has been entered, click **OK**.

##### Backup the AD RMS and ADFS Databases

The AD RMS and ADFS databases hold critical information necessary to AD RMS, such as the public key of the Server Licensor Certificate, rights policy templates, ADFS configuration data, and logging information. Without these databases, clients cannot issue licenses to consume protected content, among other issues.

Of the databases, the AD RMS configuration database is considered the most important, as it stores the SLC, rights policy templates, users' keys, and configuration information. Therefore, though you should take care to back up all of the AD RMS and ADFS databases, you should plan to back up the configuration database regularly.

The logging database stores information about user requests to the AD RMS cluster for certificates and use licenses. Your backup strategy of this database should be based on company policy for retaining this type of information.

The directory services database is not critical to AD RMS functionality and, if the latest data is lost, the database will repopulate with information as the AD RMS server receives requests for certificates and use licenses. You do not need to backup this database regularly, but you do need to have at least a copy of the database as it was originally configured after deploying AD RMS.

**To backup an AD RMS and/or ADFS database with Microsoft SQL Server**

1.  Log on to the Windows Server 2012 R2 AD RMS database server with SQL 2012.

2.  Click **Start**, click **All Programs**, click **Microsoft SQL Server**, and click **SQL Server Management Studio**.

3.  In the **Connect to Server** window, confirm the server hosting the AD RMS databases is in the **Server Name** box and click **Connect**.

4.  Expand **Databases**. Right click the appropriate database (**DRMS** and **Adfs**), point to **Tasks**, and select **Backup**.

5.  Repeat step 4 for the remaining databases.

6.  Ensure that the backup of the databases can be accessed by other machines on the network or using a storage device as they will be needed for later steps during the migration.

Now you can store the database copies in a secure location. Remember to back up your databases frequently.

##### Adding Domain Admin, SQL, AD RMS, and/or ADFS Service Account to SQL Server 2016

The following steps will showcase how to add the various Service Accounts to SQL Server 2016 to assist with migrating the data from the Windows Server 2012 R2 environment. This will give the proper permissions when trying to access the content and handle the data.

**To add the Domain Admin, SQL, AD RMS, and/or ADFS Service Account to SQL Server**

1.  Log on to the server with SQL Server 2016 as the Local Admin account.

2.  Click **Start**, click **All Programs**, click **Microsoft SQL Server**, and click **SQL Server Management Studio**.

3.  In the **Connect to Server** window, confirm the server hosting the AD RMS databases is in the **Server Name** box then for Authentication click the drop-down menu and select **SQL Server Authentication**.

4.  In the **Login** field enter the name of the Local Admin account (Ex. localadmin) and then provide the appropriate password and click **Connect**.

5.  Expand **Security** and then right-click **Logins** and select **New Login** from the context menu that appears.

6.  Once the window appears enter in the Domain Admin account in the **Login name** field (Ex. Contoso\\ContosoAdmin)

7.  From the left navigation pane, choose **Server Roles**.

8.  Then mark the checkbox for **sysadmin** under the server roles and click **OK**.

9.  Restart **SQL Server Management**.

10. In the **Connect to Server** window, confirm the server hosting the AD RMS databases is in the **Server Name** box then for Authentication click the drop-down menu and select **Windows Authentication** and click **Connect**.

##### Restoring the AD RMS and ADFS Databases to SQL Server 2016

The following steps will showcase how to restore the data from the previous SQL Server instance to the new 2016 instance. This will allow the new SQL to utilize the relevant configuration data from the previous AD RMS and ADFS databases.

**To restore the data from the previous SQL Server to the new SQL Server**

1.  Log on to the server with SQL Server 2016 with the appropriate account.

2.  From the left navigation pane, right-click **Databases** and select **Restore Database** to begin the restoration process.

3.  Under **Source** choose **Device** and then browse for the location where the database files were stored in the earlier steps.

4.  Once the files have been selected, click **OK**.

5.  Ensure that all the database files have been added and complete the process by clicking **OK**.

### Configuring Windows Server 2016 Active Directory Federation Services (AD FS)

AD FS has been deployed to provide single sign-on (SSO) access to AD RMS as an application. It has also been configured with the AD RMS Mobile Device Extension (MDE), which enables Mac and mobile device support for end users.

The following sections provide guidance on operational tasks you may need to perform on your AD FS deployment.

#### Adding a 2016 AD FS Server to the Farm

You can deploy additional AD FS servers to support the AD RMS deployment. You may choose to perform this action in the event of increased traffic to the AD RMS servers, or additional applications, or if you need to retire one of the servers currently being used for AD FS.

**To add the 2016 AD FS server to the farm**

1.  From the Azure AD Connect server, double click the **Azure AD Connect** icon to launch the Azure AD Connect wizard.

2.  In the Welcome page, click **Configure**.

3.  In the Additional Tasks page, click **Deploy an additional Federation Server** and then click **Next**.

4.  In the Connect to Azure AD page, enter the user name and password of an account with Global Administrative permissions and then click **Next**.

5.  In the Domain Administrator credentials page, enter the user name and password of an account with Domain Admin permissions and click **Next**.

6.  Click **Browse** and select the certificate file used when configuring the AD FS farm using the Azure AD Connect.

7.  Click **Enter Password** to open the Certificate Password dialog box.

8.  Enter the password of the certificate in the Password field and then click **OK**.

9.  Click **Next**.

10. In the AD FS Servers page, enter the name or the IP address of the new AD FS server and click **Add**.

11. In the Ready to Configure page, click **Install**.

12. In the Installation Complete page, click **Exit**.

#### Raising the ADFS Farm Behavior Level

When deploying an ADFs server that exceeds the current environment level such as, having an ADFS on Windows Server 2012 R2 and then adding an ADFS Windows Server 2016, the Farm Behavior Level will need to be increased. This is needed to ensure that the environment is using the most up to date information and functions.

**To raise the ADFS Farm Behavior Level**

1.  Navigate to the Windows Server 2016 ADFS.

2.  Open an admin PowerShell session.

3.  Enter the following command: **\$cred = Get-Credential**

4.  A window will appear asking for credentials, enter in the domain admin credentials.

5.  Then enter this command: **Invoke-AdfsFarmBehaviorLevelRaise -Credential \$cred**

6.  A prompt will appear asking, **Do you want to continue with this operation?** Then enter **a** to accept the prompt.

7.  After the command has completed, the Farm Behavior Level will be setup and ready.

#### Enabling Mobile Device Extension Logging

The Mobile Device Extension can log requests it receives from end user devices. Logging is disabled by default and we recommend only enabling logging in a troubleshooting scenario. All requests, from mobile devices and desktop machines, to bootstrap or acquire an end use license are logged in the AD RMS logging database or Azure storage account. MDE logging will create two additional tables to the SQL Server used by AD RMS: the client debug log table and the client performance log table.

**To enable Mobile Device Extension logging**

1.  From an AD RMS server, open Windows PowerShell as an administrator.

2.  Type the following command and press **Enter**: **Import-Module AdRmsAdmin**

3.  Type the following command and press **Enter**: **New-PSDrive -Name AdrmsCluster -PsProvider AdRmsAdmin -Root https://localhost**

4.  Type the following command and press **Enter**: **Set-ItemProperty -Path AdrmsCluster:\\ -Name IsLoggingEnabled -Value \$true**

If you are using MDE logging for troubleshooting, we recommend disabling it after addressing the issue.

**To disable Mobile Device Extension logging**

1.  From an AD RMS server, open Windows PowerShell as an administrator.

2.  Type the following command and press **Enter**: **Import-Module AdRmsAdmin**

3.  Type the following command and press **Enter**: **New-PSDrive -Name AdrmsCluster -PsProvider AdRmsAdmin -Root https://localhost**

4.  Type the following command and press **Enter**: **Set-ItemProperty -Path AdrmsCluster:\\ -Name IsLoggingEnabled -Value \$false**

### Upgrading AD RMS to Windows Server 2016

The following sections provide guidance on how to add a Windows Server 2016-based AD RMS Server into the current Windows Server 2012 R2 cluster. The server will be added into the cluster and the information will be replicated to it so that the previous AD RMS server can be deprecated to free up resources.

After you add one Windows Server 2016-based AD RMS server has been added to yuour AD RMS cluster, all nodes based on older versions of Windows will become inactive. After this is done you can deprovision those servers (e.g. shut down, repurpose or reinstall with Windows Server 2016 to join the AD RMS cluster). 

You can deploy additional AD RMS servers to the cluster to support the load on your AD RMS deployment. You may also choose to perform this action in the event of increased traffic to the AD RMS servers.

This guide doesn't cover the steps required to alter the load balancing mechanisms you might be using in your environment to exclude the servers you are deprecating and to include the ones you are adding to the cluster. 

#### Adding a 2016 AD RMS Server

If your AD RMS cluster is using a Hardware Security Module instead of a Centrally Managed key for its Server Licensor Certificate, you will need to install the software and other HSM artifacts (e.g. key and configuragtion files) on the server before installing AD RMS. You will also need to connect the HSM to the server, either physically or through the relevant network configurations. Follow your HSM guidance for these steps. 

**To add a 2016 AD RMS Server**

1.  Install the AD RMS Role on the desired Windows Server 2016 deployment.

2.  After installation completes, select the link to **Perform additional configuration**.

3.  Select **Join an existing AD RMS cluster** and click **Next**.

4.  On the **Select Configuration Database** page, enter the CNAME specified in the DNS for the 2016 SQL server (FQDN).

5.  Click **List** on the second line and select the **DefaultInstance** from the drop-down.

6.  Under **Configuration Database Name**, select the drop-down menu and choose the DRMS configuration that appears. Then click **Next**.

7.  On the **Database Information** page, enter the cluster key password in the field provided. After that, click **Next**.

8.  In the next page of the wizard, specify the AD RMS service account and provide the password for it and click **Next** once it has been verified.

9.  Once the **Cluster Web Site** page appears, simply ensure that the appropriate web site has been selected and click **Next**.

10. On the **Choose a Server Authentication Certificate** page, select the imported SSL certificate and click **Next**.

11. Click **Install** to begin the installation.

12. After configuration completes, you will need to log off and back on to administer AD RMS.

13. Once logged back on, open **Server Manager** select **Tools** and then **Active Directory Rights Management**. The management window should appear and indicate that the cluster has the additional server in the cluster.

At this point, you can repurpose all the preexisting nodes or upgrade them to Windows Server 2016 and re-join them to the AD RMS cluster using the same process outlined above. 

### Configuring Windows Server 2016 Web Application Proxy (WAP)

The following sections provide guidance on operational tasks you may need to perform on your Web Application Proxy deployment. This is an optional step, not required if you are publishing AD RMS to the Internet through other mechanisms. 

#### Adding a Windows Server 2016 WAP Server

You can deploy additional Web Application Proxy servers to support the AD RMS deployment. You may choose to perform this action in the event of increased traffic to the AD RMS servers or if you need to retire one of the servers currently being used for the Web Application Proxy.

**To add a 2016 Web Application Proxy server**

1.  From the server you wish to setup as a Web Application Proxy, navigate to the Server Manager console and click **Add roles and features**.

2.  In the **Add Roles and Features Wizard**, click **Next** until you get to the Server Role selection screen.

3.  On the Select Server Roles screen, select **Remote Access**, and then click **Next** until you are back at the Select Server Roles screen.

4.  On the Select Server Roles screen, select **Web Application Proxy**, click **Add Features**, and then click **Next**.

5.  On the Confirm Installation Selections screen, click **Install**.

6.  Once the installation has completed, click **Close**.

7.  Now it is time to configure the server. To do this, open the Remote Access Management console on the Web Application Proxy server. Open the **Start** menu, type **RAMgmtUI.exe**, and then select the application.

8.  In the navigation pane, click **Web Application Proxy**.

9.  In the Remote Access Management console click **Run the Web Application Proxy Configuration Wizard**. Once in the wizard, click **Next**.

10. On the Federation Server screen enter the fully qualified domain name of the AD FS server (Ex. adfs.contoso.com) and then enter credentials for an administrator on the AD FS server.

11. On the AD FS Proxy Certificate screen, in the list of certificates currently installed on the Web Application Proxy server, select a certificate to be used by Web Application Proxy for AD FS proxy, and then click **Next**.

12. On the Confirmation screen, review the settings then click **Configure**.

13. Once the configuration is complete, click **Close**.

#### DNS Configuration for 2016 WAP Server

Once the Windows Server 2016 Web Application Proxy server has been put in place, some DNS changes will need to be made. This will require using a service such as GoDaddy to point the ADFS and AD RMS services at the 2016 WAP server.

**To point the DNS at the WAP server**

1.  Navigate to your provider's website (ex. GoDaddy).

2.  Go into Domain Management and then DNS Management.

3.  Locate the ADFS and AD RMS service and replace the **Points to** portion with the Public IP Address of the 2016 WAP server and **Save**.

4.  The changes may take time to propagate, but once they do this setup will be complete.

#### Enabling Debugging Logs

Detailed logging information is available on the Web Application Proxy servers. You can configure advanced debugging logging using the Event Viewer. Additional settings can also be selected for the size of the logs to help ensure that the analytics are useful to the viewer.

**Enabling Debugging Logs for the Web Application Proxy**

1.  Open the **Event Viewer** console on the Web Application Proxy.

2.  Expand the **Microsoft** node.

3.  Expand the **Windows** node.

4.  Open the **Web Application Proxy** logs.

5.  You will then be able to open the **Admin** logs.

6.  Open the **Action** menu, located in the top left, and select **Properties**.

7.  Under the **General** tab, choose the option to **Enable Logging**.

8.  Finally, you are able to customize maximum log size and what happens when the maximum event log size is reached.

### Configuring High Availability for Windows Server 2016 Services

The following sections provide guidance on operational tasks you may need to setup your Windows Server 2016 environment in High Availability.

#### Adding a 2016 AD RMS Server for High Availability

You can deploy additional AD RMS servers to setup High Availability. You may choose to perform this action in the event of increased traffic to the AD RMS servers.

**To add a 2016 AD RMS server for High Availability**

1.  Install the AD RMS Role on the desired Windows Server 2016 deployment.

2.  After installation completes, select the link to **Perform additional configuration**.

3.  Select **Join an existing AD RMS cluster** and click **Next**.

4.  On the **Select Configuration Database** page, enter the CNAME specified in the DNS for the 2016 SQL server (FQDN).

5.  Click **List** on the second line and select the **DefaultInstance** from the drop-down.

6.  Under **Configuration Database Name**, select the drop-down menu and choose the DRMS configuration that appears. Then click **Next**.

7.  On the **Database Information** page, enter the cluster key password in the field provided. After that, click **Next**.

8.  In the next page of the wizard, specify the AD RMS service account and provide the password for it and click **Next** once it has been verified.

9.  Once the **Cluster Web Site** page appears, simply ensure that the appropriate web site has been selected and click **Next**.

10. On the **Choose a Server Authentication Certificate** page, select the imported SSL certificate and click **Next**.

11. Click **Install** to begin the installation.

12. After configuration completes, you will need to log off and back on to administer AD RMS.

13. Once logged back on, open **Server Manager** select **Tools** and then **Active Directory Rights Management**. The management window should appear and indicate that the cluster has the additional server in the cluster.

14. After confirming the server setup, configure your Load Balancing service to balance the load between the different AD RMS servers in the cluster.

#### Adding a Windows Server 2016 AD FS Server for High Availability

You can deploy additional AD FS servers to setup High Availability. You may choose to perform this action in the event of increased traffic to the AD FS servers. **Note: after raising the farm behavior level, a new database entry will be entered into the  SQL Server 2016(Adfs Configv3) and the old configuration database must be deleted before continuing with these steps.**

**To add the Windows Server 2016 AD FS server for High Availability**

1.  Install the AD RMS Role on the desired Windows Server 2016 deployment.

2.  After installation completes, select the link to **Configure the federation service on this server**.

3.  In the welcome section of the wizard, choose the option to **Add a federation server to a federation server farm** and then click **Next**.

4.  Specify the proper admin account and click **Next**.

5.  On the **Specify Farm** page, pick the **Specify database location for an existing farm using SQL Server** then enter the CNAME for the SQL service for the Database Host Name and click **Next**.

6.  Under the **Specify Service Account** area of the wizard, enter the credentials for the AD FS service account and then click **Next**.

7.  In **Review Options**, click **Next**.

8.  Click **Configure** when the button becomes available.

9.  After the configuration, restart the machine.

10. After confirming the server setup, Load Balance the AD FS servers as required.

#### Adding a Windows Server 2016 WAP Server for High Availability

You can deploy additional WAP servers to setup High Availability. You may choose to perform this action in the event of increased traffic to the AD RMS servers.

**To add a Windows Server 2016 Web Application Proxy server for High Availability**

1.  From the server you wish to setup as a Web Application Proxy, navigate to the Server Manager console and click **Add roles and features**.

2.  In the **Add Roles and Features Wizard**, click **Next** until you get to the Server Role selection screen.

3.  On the Select Server Roles screen, select **Remote Access**, and then click **Next** until you are back at the Select Server Roles screen.

4.  On the Select Server Roles screen, select **Web Application Proxy**, click **Add Features**, and then click **Next**.

5.  On the Confirm Installation Selections screen, click **Install**.

6.  Once the installation has completed, click **Close**.

7.  Now it is time to configure the server. To do this, open the Remote Access Management console on the Web Application Proxy server. Open the **Start** menu, type **RAMgmtUI.exe**, and then select the application.

8.  In the navigation pane, click **Web Application Proxy**.

9.  In the Remote Access Management console click **Run the Web Application Proxy Configuration Wizard**. Once in the wizard, click **Next**.

10. On the Federation Server screen enter the fully qualified domain name of the AD FS server (Ex. adfs.contoso.com) and then enter credentials for an administrator on the AD FS server.

11. On the AD FS Proxy Certificate screen, in the list of certificates currently installed on the Web Application Proxy server, select a certificate to be used by Web Application Proxy for AD FS proxy, and then click **Next**.

12. On the Confirmation screen, review the settings then click **Configure**.

13. Once the configuration is complete, click **Close**.

14. After confirming the server setup, Load Balance the WAP servers in the DMZ.

#### Adding a SQL Server 2016 node for Always On High Availability

You can deploy additional SQL servers to setup Always On High Availability. You may choose to perform this action in the event of increased traffic to the AD RMS servers. **Note: ensure that both SQL Servers have the Inbound port 5022 open.**

**To add a SQL server 2016 server for Always On High Availability**

1.  From the server you wish to setup as an additional  SQL Server 2016 server, navigate to the Server Manager console and click **Add roles and features**.

2.  Click **Next** till the **Select Features** dialog box.

3.  Select the **Failover Clustering** checkbox. **Note: follow this step for the original SQL server 2016 server as well so that both SQL Servers have the Failover Clustering feature.**

4.  Click **Install** to install the Failover Clustering feature.

5.  Now, open **Server Manager** and select **Tools** then **Failover Cluster Manager**.

6.  From the left menu pane, right-click **Failover Cluster Manager** and select **Create Cluster**

7.  This will open the **Create Cluster Wizard**.

8.  Browse for the SQL server 2016 servers which will be used for Always On High Availability and enter them in then click **Next**.

9.  You will receive a validation warning. Select **Yes** to Validate the Cluster nodes and then click **Next**.

10. Under the **Testing Options** page, select the option **Run all tests** and click **Next.**

11. **Note: The Cluster Validation Wizard is expected to return several Warning messages, especially if you will not be using shared storage. Other than that, if you find any error messages you need to fix them prior to creating the Windows Server Failover Cluster**.

12. In the **Access Point for Administering the Cluster** dialog box, enter the cluster name and virtual IP address for the Windows Server Failover Cluster, then click **Next**.

13. Verify that the configuration is successful in **Summary** and click **Finish**.

14. Back in the **Failover Cluster Manager,** right-click on your cluster and select **More Actions** then choose **Configure Cluster Quorum Settings**

15. Click **Next** and then pick the option for **Select the quorum witness** and hit **Next** again.

16. In the **Select Quorum Witness** page, select the **Configure a file share witness** option. Then click **Next**.

17. Select **Browse** and locate the path of the file share that you want to use in the File Share Path dialogue box. Click **Next**.

18. On the Confirmation page, click **Next**.

19. On the Summary page, click **Finish**.

20. Now, open the **Start** menu and search for **SQL Server Configuration Manager**.

21. Right-click the SQL Server name and pick **Properties**.

22. In the Properties dialog box, select the **AlwaysOn High Availability** tab. Check the **Enable AlwaysOn Availability Groups** check box. Click **OK**. **Note: do this on both SQL server 2016 servers.**

23. Then restart the SQL Server service.

24. Now, open the **Start** menu and search for **SQL Server Management Studio** and from the left navigation pane, right-click **Availability Groups** and click **New Availability Group Wizard** then click **Next**.

25. In the **Specify Availability Group Name** page pick a group name (Ex.SQLAvailabilityGroup2016). Then click **Next**.

26. Under the **Select Databases** section, specify the databases. Then click Next. **Note: some database may need to be backed up again or put into Full Recovery mode**.

27. Once on the **Specify Replicas** page, click the **Add Replica** button and pick your other 2016 SQL Server.

28. After adding the other server, click the check boxes and set the secondary server to be a readable secondary.

29. Navigate to the **Endpoints** tab and click the **Refresh** option. While also here, scroll across and ensure that the same service account is on the primary and secondary node.

30. Now, choose the **Backup Preferences** tab and select the **Prefer Secondary** option.

31. Move on to the **Listener** tab.

32. Specify a name (Ex. SQLListener) and ensure that the port is **1433** and then click **Next**.

33. In the **Select Initial Data Synchronization** page of the wizard, choose the **Full** option and specify network location accessible by all the SQL servers and then click **Next**.

34. Finally, click **Finish** and the process will complete.

### Decommission Windows Server 2012 R2 nodes

The following sections provide guidance on operational tasks you may need to remove your Windows Server 2012 R2 servers after successfully upgrading the AD RMS cluster to Windows Server 2016.

#### Removing a Windows Server 2012 R2 AD RMS Server

You can remove unnecessary AD RMS servers after an upgrade. You may choose to perform this action when it becomes needed to decommission AD RMS servers.

**To remove a** **Windows Server 2012 R2 AD RMS server**

1.  On the Windows Server 2012 R2 AD RMS server in Server Manager, select **Manage** from the top right menus and then choose **Remove Roles and Features**.

2.  The **Remove Roles and Features Wizard** will open up and on the **Before you Begin** screen, click **Next**.

3.  On the **Server Selection** Screen, click **Next**.

4.  On the **Server Roles** screen, remove the check next to **Active Directory Rights Management Services** and click **Next**.

5.  On the **Features** Screen, click **Next**.

6.  On the **Confirmation** Screen, click **Remove**.

7.  Once this completes, restart the server.

8.  You can now shut down this server and reallocate the resources as needed.



## Troubleshooting

The following sections provide troubleshooting information that may be helpful if you encounter issues with your AD RMS infrastructure or supporting components.


### AD RMS Core Dependencies

This section focuses on troubleshooting issues with the core dependencies of the AD RMS cluster.

#### DNS

AD RMS relies on DNS to identify the correct IP address for the AD RMS certification and licensing clusters. Therefore, DNS is one of the first places to check when troubleshooting AD RMS.

**To troubleshoot DNS**

1.  On a machine in your organization, open Internet Explorer.

2.  Confirm that you can navigate to the certification pipeline by accessing the appropriate URL, for example, [**https://*adrmsfqdn*/\_wmcs/certification/certification.asmx**](https://adrmsfqdn/_wmcs/certification/certification.asmx). The **CertificationWebService** page should appear.

3.  Confirm that you can navigate to the licensing pipeline by accessing the appropriate URL, for example, [**https://*adrmsfqdn*/\_wmcs/licensing/licensing.asmx**](https://adrmsfqdn/_wmcs/licensing/licensing.asmx).

4.  Log on to the AD RMS server.

5.  Open a command prompt and enter the following command: **ipconfig /all**. Confirm that the AD RMS server has a valid IP address and that it does not have an APIPA address.

6.  In the command prompt, enter the command **ping localhost** to confirm that TCP/IP is installed and correctly configured.

7.  Attempt to ping the DNS servers. If you are unable to ping a DNS server there may be an issue with the DNS servers or the connection between the AD RMS server and the DNS server.

8.  Attempt to ping the AD RMS cluster DNS name. If you are using a network load balancer and the ping is unsuccessful, the network load balancer may be the source of the problem.

9.  In the command prompt, enter the command **nslookup** *adrms cluster url*. If the command succeeds, restart the AD RMS servers. If the command fails, run the **ipconfig /flushdns** command and retry the **nslookup** *adrms cluster url* command. If the command continues to fail, restart the **DNS Server** service on the DNS server.

### Certificates

The following certificates must be valid and trusted, or clients will be unable to access the AD RMS service. Additionally, the CRLs must be accessible.

**AD RMS Pipeline SSL certificate**: This is the certificate configured for AD RMS during installation. The Root CA must be trusted by the client. Additionally, the issuance CA (and the entire CA Certificate Chain) CDP CRL/AIA must be accessible and the certificate must be valid.

The following tools and sites may be helpful when troubleshooting issues related to certificates:

-   [Certutil](http://technet.microsoft.com/en-us/library/cc732443(WS.10).aspx) is a command line tool and is a component in Active Directory Certificate Services. You can use the Certutil tool to verify certificates, key pairs, and more.

-   The [Windows PKI blog](http://blogs.technet.com/b/pki/) contains many helpful articles relating to AD CS.

-   The [Events and Errors in Active Directory Certificate Services TechNet](http://technet.microsoft.com/en-us/library/cc731523(WS.10).aspx) article explains the causes and resolution steps for common AD CS errors.

The following sections detail how to perform some common certificate checks using the Certutil tool:

**To review the AD RMS SSL certificate**

1.  Log on to an AD RMS server with local administrator credentials.

2.  Click **Start**, click **Administrative Tools**, and click **Internet Information Services (IIS) Manager** to open the IIS console.

3.  Expand the server name, expand **Sites**, and click **Default Web Site**.

4.  In the Actions pane, click **Bindings** to open the Site Bindings dialog box.

5.  Select **https** and click **Edit** to open the Edit Site Binding dialog box.

6.  In the Edit Site Binding dialog box, in the SSL certificate section, click **View** to open the Certificate dialog box.

7.  Review the information presented. Click the **Details** tab for more information.

8.  Click the **Certificate Path** tab to verify the status of the certificate.

**To check the validity of the AD RMS SSL certificate**

1.  Log on to an AD RMS server with local administrator credentials.

2.  Open an elevated command prompt.

3.  Enter the following command in the command prompt windows and click **Enter**: **certutil -f -urlfetch -verify** *certificate file name*

4.  Review the results. Any dwErrorStatus unequal to 0 is a real error.

### Active Directory 

AD RMS relies on Active Directory to establish a user's identity and determine what, if any, rights an end user has over protected content. If AD RMS cannot contact Active Directory, AD RMS will be unable to help users create and consume protected content. To troubleshoot Active Directory issues with AD RMS, perform the following tasks:

**Email** **Address**: End users and groups must have email addresses configured in Active Directory; AD RMS uses the email attribute to authenticate end users. If a user is unable to open protected documents, confirm that the user has an email address configured in Active Directory

**AD RMS Service Account**: Verify that the AD RMS Service Account has **Read** access to Active Directory by confirming that the AD RMS Service Account is a member of the **Domain Users** Active Directory group. If the AD RMS Service Account is not a member of the **Domain Users** Active Directory group, add the account. Then run the **iisreset** command from a command prompt on each AD RMS server in the cluster.

**Global Catalog Server**: AD RMS must be able to communicate with a Global Catalog server. To ensure connectivity, first confirm that the AD RMS server has an IP address in the correct IP address range and does not have an APIPA address. Ping the AD DS Global Catalog servers and confirm that you receive a response. Finally, confirm that TCP port 3268 is open on the AD DS Global Catalog servers.

**AD RMS Service Connection Point**: In an AD RMS deployment, the AD RMS Service Connection Point (SCP) directs users to their AD RMS server and it must be registered in Active Directory by a member in the AD RMS Enterprise Administrators Group. To view the AD RMS SCP, open ADSI Edit and navigate the following nodes: CN=Configuration \[server name\], CN=Services, CN=RightsManagementServices, CN=SCP.

**Lightweight Directory Address Protocol**: Confirm that the Lightweight Directory Address Protocol (LDAP) connection pool registry overrides are correct on the AD RMS server. To check the settings, open the Registry Editor on an AD RMS server and navigate the following registry entries. If a **MinGC** entry exists, confirm that the value is not **Null** and confirm that you have deployed enough Global Catalog servers to meet the minimum threshold defined by the **MinGC** entry. Check for a **ThreshHoldAlive** entry in the same registry path and if it exists, confirm that the value is greater or equal to **1**. If you edit these values, run the **iisreset** command from a command prompt.

Type    Key ------- ------------------------------------------------------- Path    HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\MSDRM\\2.0 Name    MinGC Value   Integer (should not be set to **Null**)

Type    Key ------- ------------------------------------------------------- Path    HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\MSDRM\\2.0 Name    ThreshHoldAlive Value   1 or greater

Note that errors in the registry editor can cause significant damage to the server. We recommend making a backup of the relevant data before editing any registry settings.

**Restart the AD RMS server**: If the above steps do not resolve the issue, restart the servers in the AD RMS cluster.

#### AD RMS Role Delegation

AD RMS offers three administrative roles to better delegate control over your AD RMS implementation. These roles are created as local security groups per AD RMS server. To ease administration across multiple AD RMS servers you can create corresponding Active Directory security groups for the administrative roles.

Note that members of these groups do not, by default, have access to manage the AD RMS configuration. For more information about roles within AD RMS, see the AD RMS Role Delegation section of this document.

The roles are as follows:

-   **AD RMS Enterprise Administrators**: Members of this group have full control over the AD RMS configuration. By default, the account that installed AD RMS is added to this group.

-   **AD RMS Template Administrators**: Members of this group can create, manage, and delete rights policy templates. By default, this group contains no users.

-   **AD RMS Auditors**: Members of this group can only access reports and logs from the AD RMS console. By default, this group contains no users.

By default, the user account used to install AD RMS is added to the AD RMS Enterprise Administrators local group the AD RMS server. No other users are added to the other groups.

**To add a user to an AD RMS group**

1.  Log on to the AD RMS server with local Administrative or equivalent permissions.

2.  Open Server Manager.

3.  Click **Tools** and select **Computer Management** to open the Computer Management console.

4.  Expand **Configuration**, expand **Local Users and Groups**, and select **Groups**.

5.  Open the desired AD RMS group, click **Add**, and enter the name of the user or group to add. Click **OK** twice to close the **Select Users, Computers, Service Accounts, or Groups** and **Properties** windows.

6.  Repeat step 5 to add additional users.

#### AD FS 

When troubleshooting AD FS, one of the first things you should check is DNS name resolution to verify that the client computers can resolve the AD FS URL. Clients inside the network should resolve the AD FS URL to the AD FS servers, while clients outside the network should resolve the AD FS URL to the WAP servers.

**To troubleshoot DNS**

1.  Log on to the AD FS server.

2.  Open a command prompt and enter the following command: **ipconfig /all**. Confirm that the AD FS server has a valid IP address and that it does not have an APIPA address.

3.  In the command prompt, enter the command **ping localhost** to confirm that TCP/IP is installed and correctly configured.

4.  Attempt to ping the DNS servers. If you are unable to ping a DNS server there may be an issue with the DNS servers or the connection between the AD FS server and the DNS server.

5.  Attempt to ping the AD FS server farm DNS name. If you are using a network load balancer and the ping is unsuccessful, the network load balancer may be the source of the problem.

6.  In the command prompt, enter the command **nslookup** *ad fs server farm url*. If the command succeeds, restart the AD FS servers. If the command fails, run the **ipconfig /flushdns** command and retry the **nslookup** *ad fs server farm url* command. If the command continues to fail, restart the **DNS Server** service on the DNS server.

The Azure AD Connect Health Tool, as described in the Azure AD Connect section of this document, also has an option to report on the health of the AD FS deployment. The Azure AD Connect Health tool requires Azure Active Directory Premium, which is included in the Enterprise Mobility + Security E5 license.

Unlike the Azure AD Connect Health Report for Sync tool, the Azure AD Connect Health Report repot for AD FS requires you to install an agent on your AD FS servers.

**To install the Azure AD Connect Health Agent for AD FS**

1.  Open an internet browser and navigate to <http://go.microsoft.com/fwlink/?LinkID=518973>.

2.  Save the file to the AD FS server.

3.  From the AD FS server, double click the setup file you downloaded in the previous step to open the Azure Active Directory Connect Health AD FS Agent installation wizard.

4.  Click **Install**.

5.  Verify that you receive a page that states that the set up was successful. Click **Configure Now** to open a PowerShell window.

6.  Enter the user name of an account with Global Administrator permissions in the Sign in to Azure AD Connect Health Agent dialog box and click **Continue**.

7.  Verify that the setup completes successfully and then close Windows PowerShell.

8.  To verify that the agent has been installed, open the Services console and verify that the following services are listed and are running: **Azure AD Connect Health AD FS Diagnostics Service**, **Azure AD Connect Health AD FS Insights Service**, and **Azure AD Connect Health AD FS Monitoring Service**.

9.  Close the Services console.

**To view the Azure Active Directory Connect Health report for AD FS**

1.  Open an internet browser and navigate to [**https://aka.ms/aadconnecthealth**](https://aka.ms/aadconnecthealth).

2.  Log in to the Azure portal with Global Administrative permissions or equivalent.

3.  Review the information provided in the Active Directory Federation Services section. Review any errors or alerts that you see.

4.  Click the **Active Directory Federation Services** section to open the Active Directory Federation Services blade. Here you can see more information about the health of your AD FS farm and WAP deployments, the number of token requests received over the past 24 hours, and any alerts that are open.

5.  If you see an alert, click through the **Alerts** section to open the Alerts blade. Click through any error message to see more information about the error message as well as proposed methods to fix the error.

6.  Return to the Active Directory Federations Services blade. Click the **Usage Analytics** section to open the Usage Analytics blade. Here you can see performance information, including the total number of requests by application over the past 24 hours.

7.  Close the Azure portal.

You can easily check to see if the AD FS servers in the farm are responding to web requests by navigating to the AD FS federation metadata endpoint using an Internet browser. A successful resolution of this test implies that at least one AD FS server is operational and responding to web requests.

**To test the AD FS metadata endpoint**

1.  From a client computer, open an internet browser and navigate to the following url: **https://sts.Microsoftsecurity.com/FederationMetadata/2007-06/FederationMetadata.xml**.

2.  An XML file will download to the local machine and open in the internet browser.

3.  The file should render similarly to the screenshot below:

![](media/image1.png){width="6.252777777777778in" height="2.2375in"}

AD FS collects event logs on the local servers. You can review this logging information in the local Event Viewer in the Applications node. The Applications node contains an Admin log.

You can also use Fiddler to help troubleshoot complex AD FS issues. Fiddler is a tool that captures HTTP/S web traffic, providing you with an output you can review to help locate the root cause of an issue. Fiddler is available as a free download from Telerik: <https://www.telerik.com/download/fiddler>. To use Fiddler, download and install the tool to the AD FS server. Then configure it using the following steps.

**To configure Fiddler for use with AD FS**

1.  From the AD FS server on which you have installed Fiddler, open the application.

2.  Click **Tools** and then click **Fiddler Options** to open the Options dialog box.

3.  Select the **HTTPS** tab.

4.  Select the **Capture HTTPS CONNECTs** option.

5.  Select the **Decrypt HTTPS Traffic** option and then select the **From browsers only** option in the corresponding drop-down menu.

6.  Select the **Ignore server certificate errors (unsafe)** option.

7.  Click **OK**.

AD FS servers also contain performance counters to measure the health of the server. AD FS collects the following counters:

-   Token requests

-   Token requests per second

-   Federation Metadata requests

-   Federation Metadata requests per second

-   Artifact Resolution requests

-   Artifact Resolution requests per second

-   Proxy requests

-   Proxy requests per second

-   Proxy MEX requests

-   Proxy MEX requests per second

### AD RMS Server Troubleshooting

The following sections provide information that may be helpful in troubleshooting issues with the AD RMS servers in the cluster.

#### AD RMS Server

If you receive an error message that the AD RMS operation has failed due to insufficient memory, add performance counters on the AD RMS server to measure the state of the AD RMS server and examine the memory usage on the AD RMS server. This section also explains how to check the network proxy settings on the AD RMS server.

**To add performance counters to the AD RMS server**

1.  Log on to the AD RMS server with local administrative permissions.

2.  Click **Start**, click **Administrative Tools**, and select **Performance Manager** to open the Performance Monitor console.

3.  Expand **Monitoring Tools** and select **Performance Monitor**.

4.  In the Performance Monitor details window, select the green plus button to open the **Add Counters** window.

5.  Select the appropriate performance counters from the available list. Note that AD RMS performance counters can be found in the following categories:

-   **AD RMS Certification**

-   **AD RMS Directory Services**

-   **AD RMS Group Expansion**

-   **AD RMS Licensing**

-   **AD RMS Logging**

-   **AD RMS Service Discovery**

1.  Click **OK**.

Also, note that the **Available Bytes**, **Committed Bytes**, and **Pages/Sec** performance counters may be helpful in troubleshooting an issue related to memory. These counters are located under the **Memory** node.

**To examine memory usage on the AD RMS server**

1.  Log on to the AD RMS server with local administrative permissions.

2.  Open the **Task Manager**.

3.  Click the **Applications** tab and verify that all tasks have a status marked **Running**. If any task has a **Not Responding** status, you may need to end the task.

4.  Click the **Processes** tab and look for any processes that seem to be consuming a lot of memory. Investigate any issues you may find.

**To check the network proxy settings on the AD RMS server**

1.  Log on to the AD RMS server with AD RMS Enterprise Admin credentials.

2.  Click **Start**, click **Administrative Tools**, and click **Active Directory Rights Management Services** to open the AD RMS console.

3.  Select and right click the AD RMS cluster. Select **Properties**.

4.  Click the **Proxy Settings** tab and select the **This cluster uses a proxy server to access external networks (such as another forest or the Internet)** option.

5.  Enter the proxy server address in the **Address** field and enter the port number in the **Port** field.

6.  Optionally, select the **Bypass proxy server for local addresses** option to prevent the proxy server from connecting to local resources.

7.  Optionally, enter any addresses that should not use the proxy server in the **Do not use proxy server for addresses beginning with** field.

8.  To require authentication, select the **This proxy server requires authentication** option and enter the **Authentication** type, **User name**, **Password**, and **Domain**.

9.  Click **OK**.

#### Debug View

Debug View is an application that monitors the debug output on your local computer or any computer on the network that you can reach via TCP/IP. Debug View can capture and return kernel-mode and Win32 debug output. When troubleshooting AD RMS, this tool can be helpful to trace information to and from the AD RMS server and the AD RMS client. Using the tool does not require any special permissions, unless you are running the tool on a machine with a Windows 2000 or Windows XP operating system; then the tool requires administrative privilege to view kernel-mode debug output. To use the Debug View tool, download it from the link below, and execute the dbgview.exe file. Debug View will immediately begin capturing debug output.

Debug View is available as a free download from [Microsoft.com](http://technet.microsoft.com/en-us/sysinternals/bb896647.aspx). To enable application logging for AD RMS, configure the following registry setting:

----------------------------------------------------------------------------------- Type    REG\_DWORD ------- --------------------------------------------------------------------------- Path    AD RMS Client 2.0: HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\MSIPC\\

AD RMS Client 1.0 SP2: HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\MSDRM\\

Name    Trace

Value   1 to enable tracing, 0 to disable tracing -----------------------------------------------------------------------------------

**To Capture Debug View traffic**

1.  Log onto the computer that you wish to troubleshoot.

2.  Download and install the Debug View tool from the link provided above.

3.  Confirm the above registry key is set on the local machine.

4.  Navigate to the folder where Debug View is installed and double click the **Debug Tool**.

5.  In the Debug window, click **Capture** and select **Capture Global Win32**.

6.  Start the Microsoft Office application and reproduce the issue.

7.  Stop the Debug View capture and save the output to a text file.

8.  Review the text file for an error code related to AD RMS that can provide more information.

For more information about error codes in AD RMS, see the AD RMS Function Error Codes Microsoft MSDN article: <https://msdn.microsoft.com/en-us/library/bb204613(v=vs.85).aspx>.

#### Logging

The AD RMS Logging Service sends logging information from the message queues of the various AD RMS servers to the AD RMS database. This section explains some of the common steps to troubleshoot issues with the AD RMS Logging Service.

**Connectivity**: First, ensure that the AD RMS server has an IP address in the correct IP address range, rather than an APIPA address. Use the **ping localhost** command to verify that TCP/IP is installed and configured on the AD RMS server. Then attempt to ping the IP address of the AD RMS server and the IP addresses of the DNS servers. Confirm that you receive the appropriate responses from each DNS server.

**Logging Service**: On the AD RMS server, using the Services window, confirm that the **AD RMS Logging Service** is **Started** and its **Startup** type is set to **Automatic**.

**Message Queuing**: On the AD RMS server, using the Services window, confirm that **Message Queuing** is **Started** and its **Startup** type is set to **Automatic**.

**AD RMS Service Account**: Confirm that the AD RMS Service Account has access to the AD RMS logging database. Log on to the database server and open the AD RMS Logging Database from SQL Server Management Studio. Under **Security**, check to see if the AD RMS Service Account is listed under **Users** and if it does not appear, add the AD RMS Service Account. Open the user account's Properties and select the **rms\_service** checkbox under **Database role membership**.

The AD RMS Service Group should be added to the AD RMS message queue.

**To add the AD RMS Service Group to the message queue: **

1.  Log on to the AD RMS server with local administrative credentials.

2.  Open **Server Manager**.

3.  Expand **Features**, expand **Message Queuing**, and select **Private Queues**.

4.  Select and right click the AD RMS logging database and select **Properties**. Note that the database should appear **drms\_logging\_***(clustername)***\_***(port number)*.

5.  Click the **Security** tab and click **Add**.

6.  Enter the AD RMS Service Account in the **Enter the object names to select** field and click **OK**.

7.  Give the AD RMS Service Account **Full Control** permissions and click **OK**.

**Restart the AD RMS server**: If the above steps do not solve the issue, restart the AD RMS server.

**Reinstall AD RMS**: If you receive an error that states that the AD RMS logging service does not exist or is not registered on this computer, you may have to remove the AD RMS role from the server and reinstall AD RMS.

#### IIS

Internet Information Services is a crucial component to AD RMS. If you are experiencing issues related to IIS, first attempt to run the **iisreset** command from a command prompt. If you continue to experience issues, restart the **World Wide Web Publishing Service** from the Services console.

If you still experience issues you may need to restore the AD RMS configuration database from a backup. In severe cases, you may need to remove the AD RMS role from the server and reinstall AD RMS.

#### Connection to SQL Server

AD RMS must be able to connect to the database server to create and consume protected content. To troubleshoot issues with the AD RMS database server, check the following common issues:

**Connectivity**: First, ensure that the AD RMS server has an IP address in the correct IP address range, rather than an APIPA address. Use the **ping localhost** command to verify that TCP/IP is installed and configured on the AD RMS server. Then attempt to ping the IP address of the AD RMS server, the IP addresses of each DNS server, and the IP address of the database server. Confirm that you receive the appropriate responses from each.

**AD RMS Service Account**: Confirm that the AD RMS Service Account has access to the AD RMS logging database. Log on to the database server and open the AD RMS Logging Database from the SQL Server Management Studio. Under **Security**, check to see if the AD RMS Service Account is listed under **Users** and if it does not appear, add the AD RMS Service Account. Open the user account's Properties and select the **rms\_service** checkbox under **Database role membership**.

**Disk space**: Confirm that the partition space hosting the AD RMS configuration database files has enough free space available.

**Restart the AD RMS server**: If the above steps do not solve the issue, restart the AD RMS server.

#### Extranet Access

End users who are outside of the corporate network can still access the AD RMS service through Extranet URLs.

**To check the AD RMS Extranet URLs**

1.  Log on to the AD RMS server with AD RMS Enterprise Admin credentials.

2.  Click **Start**, click **Administrative Tools**, and click **Active Directory Rights Management Services** to open the AD RMS console.

3.  Select and right click the AD RMS cluster and select **Properties**.

4.  Navigate to the **Cluster URLs** tab and confirm the **Extranet URLs** option is selected and the URLs are configured correctly.

We recommend configuring extranet URLs when you install AD RMS, even if you do not intend to initially use them. When content is protected, AD RMS embeds the intranet and extranet cluster URLs into each protected document. Therefore, if you configure extranet URLs after you protect a piece of content, that content will not contain the correct extranet URLs and therefore users will not be able to open it outside the corporate network. To provide external access to the document in this example, you must remove the protection, remove the DRM folder on the end user machines, configure extranet access, and then re-protect the document.

Both the certification and licensing AD RMS pipelines must be published to the Internet to provide users with access to AD RMS beyond the network.

Note that in the Microsoft deployment, the extranet URLs have been enabled in the AD RMS cluster and have been published externally using the Azure AD App Proxy.

#### AD RMS Connectivity Requirements

The following ports are used in the AD RMS cluster for incoming and outgoing communication between the AD RMS servers, SQL Server, and Active Directory. This information may help you troubleshoot connectivity requirements:

**Inbound traffic to the AD RMS Web Server:**

-   443 TCP - allows AD RMS clients to connect to the AD RMS Web Service using SSL

**Outbound traffic from the AD RMS Web Server and AD RMS Database to the Domain Controller**

-   ICMP (Ping)

-   ICMP Code 0

-   ICMP Type 8

-   53 UDP/TCP - required for Domain Name System Protocol

-   88 UDP - required for Kerberos V authentication protocol

-   135 - allows for communication to domain controllers to authenticate users and groups

-   123 UDP - required for Network Time Protocol

-   137 UDP - required for NetBIOS Name Service protocol

-   138 UDP - required for NetBIOS Datagram protocol

-   139 UDP - required for NetBIOS Session protocol

-   389 UDP/TCP - required for Lightweight Directory Access Protocol

-   445 TCP - required for Microsoft CIFS

-   3268 TCP - required for Lightweight Directory Access Protocol global catalog protocol

**Outbound traffic to the AD RMS database server**

-   1433 TCP - required for Microsoft SQL Server protocol for connectivity with SQL Server

-   1434 UDP - Microsoft SQL Server listening port

-   445 TCP - required for SQL Server Named Pipes

### Removing AD RMS cluster nodes

The following procedure walks you through the process of removing a single AD RMS server from a cluster. If you plan to remove every AD RMS server from the cluster, first follow the steps in the Decommissioning AD RMS section. They walk you through the process of exporting the AD RMS public and private keys, which will allow you to still provide access to protected content. Then follow the steps outlined below.

1.  Log on to the server that you wish to remove AD RMS from with local Administrator credentials, or equivalent.

2.  Open **Server Manager**.

3.  Click **Manage Roles** and under **Roles Summary**, click **Remove Roles**.

4.  Read the information in the **Before You Begin** page and click **Next**.

5.  Clear the **Active Directory Rights Management Services** box. Note that you can also clear the **Web Server (IIS)** box, provided you are not using the IIS role for other server roles or applications.

6.  Click **Remove**.

7.  When the process is complete, click **Finish**.

### Disaster Recovery

This topic will cover the steps to recover from a scenario where you lose one or all of your AD RMS servers in the cluster. These steps assume you have a copy of your AD RMS Configuration Database and AD RMS Private Key, which is contained in the configuration database.

##### Recovering from a single AD RMS node failure

If one of your AD RMS servers becomes unavailable but you still have at least one other AD RMS server available, first identify the reason the AD RMS server is unavailable. Once you have solved the issue you can reinstall the Windows Server operating system on the machine and rejoin it to the AD RMS cluster using the steps below. Alternatively, perform the following steps on a new server in the organization:

**To add an AD RMS node to the cluster**

1.  Log on to the server on which you wish to install AD RMS with local administrative credentials.

2.  Open Server Manager.

3.  Click **Add Roles** to begin the process to install AD RMS.

4.  Read the information in the **Before You Begin** page and click **Next**.

5.  On the **Select Server Roles** page, select **Active Directory Rights Management Services**. If a pop up window appears, click **Add Required Role Services**. Click **Next**.

6.  Read the information in the **Active Directory Rights Management Services** page and click **Next**.

7.  Confirm the **Active Directory Rights Management Server** option is selected and click **Next**.

8.  On the **Create or Join an AD RMS Cluster** page, select **Join an existing AD RMS cluster** and click **Next**.

9.  Enter the name of the database server or locate it using the **Select** option.

10. Click **Get Database Instances**, select the appropriate database instance, select the appropriate configuration database, and click **Validate**. Once the name is confirmed, click **Next**.

11. Specify the AD RMS Service Account and click **Next**.

12. Read the information in the **Introduction to Web Server (IIS)** page and click **Next**.

13. In the **Confirm Installation Selections** page, confirm the settings. Click **Install**.

14. When the installation is finished, confirm it was successful, and click **Close**.

15. Log off of the AD RMS server and log back in using the same credentials. The account used to install AD RMS is automatically added to the AD RMS Enterprise Administrators local group once the account is used to log in.

16. Click **Start**, click **Administrative Tools**, and select **Active Directory Rights Management Services** to open the AD RMS console. You can now begin administering AD RMS.

##### Recovering from an AD RMS cluster failure 

In the event that all AD RMS servers are unavailable, you can recreate the cluster, provided you have access to the AD RMS private key and the AD RMS Configuration Database. First identify the reason the AD RMS cluster is unavailable. Once you have solved the issue you can reinstall the Windows Server operating system on the first AD RMS server machine and rejoin it to the AD RMS cluster using the steps below. Alternatively, perform the following steps on a new server in the organization. Note that you can still join to a cluster even if no AD RMS server nodes currently exist. Then repeat these steps for additional servers you wish to add.

**To add an AD RMS node to the cluster**

1.  Log on to the server on which you wish to install AD RMS with local administrative credentials.

2.  Open Server Manager.

3.  Click **Add Roles** to begin the process to install AD RMS.

4.  Read the information in the **Before You Begin** page and click **Next**.

5.  On the **Select Server Roles** page, select **Active Directory Rights Management Services**. If a pop up window appears, click **Add Required Role Services**. Click **Next**.

6.  Read the information in the **Active Directory Rights Management Services** page and click **Next**.

7.  Confirm the **Active Directory Rights Management Server** option is selected and click **Next**.

8.  On the **Create or Join an AD RMS Cluster** page, select **Join an existing AD RMS cluster** and click **Next**.

9.  Enter the name of the database server or locate it using the **Select** option.

10. Click **Get Database Instances**, select the appropriate database instance, select the appropriate configuration database, and click **Validate**. Once the name is confirmed, click **Next**.

11. Specify the AD RMS Service Account and click **Next**.

12. Read the information in the **Introduction to Web Server (IIS)** page and click **Next**.

13. In the **Confirm Installation Selections** page, confirm the settings. Click **Install**.

14. When the installation is finished, confirm it was successful, and click **Close**.

15. Log off of the AD RMS server and log back in using the same credentials. The account used to install AD RMS is automatically added to the AD RMS Enterprise Administrators local group once the account is used to log in.

16. Click **Start**, click **Administrative Tools**, and select **Active Directory Rights Management Services** to open the AD RMS console. You can now begin administering AD RMS.

### WAP Server Troubleshooting

This section focuses on troubleshooting issues with the WAP server.

#### Managing the SSL Certificate

When configuring the default certificate authentication binding or alternate client TLS binding mode on the WAP server you can use the **Set-WebApplicationProxySslCertificate** cmdlet in PowerShell. To replace the Web Application Proxy SSL certificate, on each Web Application Proxy server use the cmdlet, according to the steps presented below.

**Replacing the SSL certificate for the Web Application Proxy**

1.  Open an elevated PowerShell session on the Web Application Proxy.

2.  Run the command, **Set-WebApplicationProxySslCertificate '***&lt;thumbprint of new cert&gt;***'** (be sure to replace **&lt;thumbprint of new cert&gt;** with the thumbprint of the new certificate).

3.  If the old certificate has already expired, you can reconfigure the proxy by running the following command: **\$cred = Get-Credential** and then entering the credentials of the local administrator account for the AD FS server.

4.  Run the command, **Install-WebApplicationProxy -FederationServiceTrustCredential \$cred -CertificateThumbprint '***&lt;thumbprint of new cert&gt;***' -FederationServiceName** *&lt;adfs url&gt;* (be sure to replace *&lt;thumbprint of new cert&gt;* with the thumbprint of the new certificate and to replace *adfs url* with the fully qualified domain name of the AD FS farm at Microsoft).

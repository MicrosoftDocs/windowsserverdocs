---
title: Step 2 Configure the Multisite Infrastructure
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: faec70ac-88c0-4b0a-85c7-f0fe21e28257
ms.author: pashort
author: shortpatti
---
# Step 2 Configure the Multisite Infrastructure

>Applies To: Windows Server 2012 R2, Windows Server 2012

To configure a multisite deployment, there are a number of steps required to modify network infrastructure settings including: configuring additional Active Directory sites and domain controllers, configuring additional security groups, and configuring Group Policy Objects (GPOs) if you are not using automatically configured GPOs.  
  
|Task|Description|  
|----|--------|  
|2.1. Configure additional Active Directory sites|Configure additional Active Directory sites for the deployment.|  
|2.2. Configure additional domain controllers|Configure additional Active Directory domain controllers as required.|  
|2.3. Configure security groups|Configure security groups for any Windows 7 client computers.|  
|2.4. Configure GPOs|Configure additional Group Policy Objects as required.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_ConfigAD"></a>2.1. Configure additional Active Directory sites  
All entry points can reside in a single Active Directory site. Therefore, at least one Active Directory site is required for the implementation of Remote Access servers in a multisite configuration. Use this procedure if you need to create the first Active Directory site, or if you desire to use additional Active Directory sites for the multisite deployment. Use the Active Directory Sites and Services snap-in to create new sites in your organization"s network.  

Membership in the **Enterprise Admins** group in the forest or the **Domain Admins** group in the forest root domain, or equivalent, at a minimum is required to complete this procedure. Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).  

For more information, see [Adding a Site to the Forest](https://technet.microsoft.com/library/cc732761.aspx).  

### To configure additional Active Directory sites  
  
1.  On the primary domain controller, click **Start**, and then click **Active Directory Sites and Services**.  
  
2.  In the Active Directory Sites and Services console, in the console tree, right-click **Sites**, and then click **New Site**.  
  
3.  On the **New Object - Site** dialog box, in the **Name** box, enter a name for the new site.  
  
4.  In **Link Name**, click a site link object, and then click **OK** twice.  
  
5.  In the console tree, expand **Sites**, right-click **Subnets**, and then click **New Subnet**.  
  
6.  On the **New Object - Subnet** dialog box, under **Prefix**, type the IPv4 or IPv6 subnet prefix, in the **Select a site object for this prefix** list, click the site to associate with this subnet, and then click **OK**.  
  
7.  Repeat steps 5 and 6 until you have created all the subnets required in your deployment.  
  
8.  Close Active Directory Sites and Services.  
  
![Windows PowerShell](../../../../media/Step-2-Configure-the-Multisite-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
To install the Windows Feature "Active Directory module for Windows PowerShell":  
  
```  
Install-WindowsFeature "Name RSAT-AD-PowerShell  
```  
  
or add the "Active Directory PowerShell Snap-In" via OptionalFeatures.  
  
If running the following cmdlets on  Windows 7"  or  Windows Server 2008 R2 , then the Active Directory PowerShell module must be imported:  
  
```  
Import-Module ActiveDirectory  
```  
  
To configure an Active Directory site named "Second-Site" using the built-in DEFAULTIPSITELINK:  
  
```  
New-ADReplicationSite -Name "Second-Site"  
Set-ADReplicationSiteLink -Identity "DEFAULTIPSITELINK" -sitesIncluded @{Add="Second-Site"}  
```  
  
To configure IPv4 and IPv6 subnets for the Second-Site:  
  
```  
New-ADReplicationSubnet -Name "10.2.0.0/24" -Site "Second-Site"  
New-ADReplicationSubnet -Name "2001:db8:2::/64" -Site "Second-Site"  
```  
  
## <a name="BKMK_AddDC"></a>2.2. Configure additional domain controllers  
To configure a multisite deployment in a single domain, it is recommended that you have at least one writeable domain controller for each site in your deployment.  
  
To perform this procedure, at a minimum you must be a member of the Domain Admins group in the domain in which the domain controller is being installed.  
  
For more information, see [Installing an Additional Domain Controller](https://technet.microsoft.com/library/cc733027.aspx).
  
### To configure additional domain controllers  
  
1.  On the server that will act as a domain controller, in **Server Manager**, on the **Dashboard**, click **add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen  
  
3.  On the **Select Server Roles** page, select **Active Directory Domain Services**. Click **Add Features** when prompted, and then click **Next** three times.  
  
4.  On the **Confirmation** page, click **Install**.  
  
5.  When the installation completes successfully, click **Promote this server to a domain controller**.  
  
6.  In the Active Directory Domain Services Configuration Wizard, on the **Deployment Configuration** page, click **Add a domain controller to an existing domain**.  
  
7.  In **Domain**, enter the domain name; for example, corp.contoso.com.  
  
8.  Under **Supply the credentials to perform this operation**, click **Change**. On the **Windows Security** dialog box, provide the user name and password for an account that can install the additional domain controller. To install an additional domain controller, you must be a member of the Enterprise Admins group or the Domain Admins group. When you are finished providing credentials, click **Next**.  
  
9. On the **Domain Controller Options** page, do the following:  
  
    1.  Make the following selections:  
  
        -   **Domain Name System (DNS) server**"This option is selected by default so that your domain controller can function as a Domain Name System (DNS) server. If you do not want the domain controller to be a DNS server, clear this option.  
  
            If the DNS server role is not installed on the Primary Domain Controller (PDC) emulator in the forest root domain, then the option to install DNS server on an additional domain controller is not available. As a workaround in this situation, you can install the DNS server role before or after the AD DS installation.  
  
            > [!NOTE]  
            > If you select the option to install DNS server, you might receive a message that indicates that a DNS delegation for the DNS server could not be created and that you should manually create a DNS delegation to the DNS server to ensure reliable name resolution. If you are installing an additional domain controller in either the forest root domain or a tree root domain, you do not have to create the DNS delegation. In this case, click **Yes** and disregard the message.  
  
        -   **Global Catalog (GC)**"This option is selected by default. It adds the global catalog, read-only directory partitions to the domain controller, and it enables global catalog search functionality.  
  
        -   **Read-only domain controller (RODC)**"This option is not selected by default. It makes the additional domain controller read only; that is, it makes the domain controller an RODC.  
  
    2.  In **Site name**, select a site from the list.  
  
    3.  Under **Type the Directory Services Restore Mode (DSRM) password**, in **Password** and **Confirm password**, type a strong password twice, and then click **Next**. This password must be used to start AD DS in DSRM for tasks that must be performed offline.  
  
10. On the **DNS Options** page, select the **Update DNS delegation** check box if you want to update DNS delegation during role installation, and then click **Next**.  
  
11. On the **Additional Options** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the system volume (SYSVOL) files. Specify replication options as required, and then click **Next**.  
  
12. On the **Review Options** page, review the installation options, and then click **Next**.  
  
13. On the **Prerequisites Check** page, after the prerequisites are validated, click **Install**.  
  
14. Wait until the wizard completes the configuration, and then click **Close**.  
  
15. Restart the computer if it did not restart automatically.  
  
## <a name="BKMK_ConfigSG"></a>2.3. Configure security groups  
A multisite deployment requires an additional security group for  Windows 7  client computers for every entry point in the deployment that allows access to  Windows 7  client computers. If there are multiple domains containing  Windows 7  client computers, then it is recommended to create a security group in each domain for the same entry point. Alternatively, one universal security group containing the client computers from both domains can be used. For example, in an environment with two domains, if you want to allow access to  Windows 7  client computers in entry points 1 and 3, but not in entry point 2, then create two new security groups to contain the  Windows 7  client computers for each entry point in each of the domains.  
  
### To configure additional security groups  
  
1.  On the primary domain controller, click **Start**, and then click **Active Directory Users and Computers**.  
  
2.  In the console tree, right-click the folder in which you want to add a new group, for example, corp.contoso.com/Users. Point to **New**, and then click **Group**.  
  
3.  On the **New Object - Group** dialog box, under **Group name**, type the name of the new group, for example, Win7_Clients_Entrypoint1.  
  
4.  Under **Group scope**, click **Universal**, under **Group type**, click **Security**, and then click **OK**.  
  
5.  To add computers to the new security group, double-click the security group, and on the **<Group_Name> Properties** dialog box, click the **Members** tab.  
  
6.  On the **Members** tab, click **Add**.  
  
7.  Select the  Windows 7  computers to add to this security group, and then click **OK**.  
  
8.  Repeat this procedure to create a security group for every entry point as required.  
  
![Windows PowerShell](../../../../media/Step-2-Configure-the-Multisite-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
To install the Windows Feature "Active Directory module for Windows PowerShell":  
  
```  
Install-WindowsFeature "Name RSAT-AD-PowerShell  
```  
  
or add the "Active Directory PowerShell Snap-In" via OptionalFeatures.  
  
If running the following cmdlets on  Windows 7"  or  Windows Server 2008 R2 , then the Active Directory PowerShell module must be imported:  
  
```  
Import-Module ActiveDirectory  
```  
  
To configure a security group named Win7_Clients_Entrypoint1 and to add a client computer named CLIENT2:  
  
```  
New-ADGroup -GroupScope universal -Name Win7_Clients_Entrypoint1  
Add-ADGroupMember -Identity Win7_Clients_Entrypoint1 -Members CLIENT2$  
```  
  
## <a name="ConfigGPOs"></a>2.4. Configure GPOs  
A multisite Remote Access deployment requires the following Group Policy Objects:  
  
-   A GPO for every entry point for the Remote Access server.  
  
-   A GPO for any Windows 8 client computers for each domain.  
  
-   A GPO in each domain that contains Windows 7 client computers for each entry point configured to support Windows 7 clients.  
  
    > [!NOTE]  
    > If you do not have any Windows 7 client computers, you do not need to create GPOs for  Windows 7  computers.  
  
When you configure Remote Access, the wizard automatically creates the required Group Policy Objects if they don"t already exist. If you do not have the required permissions to create Group Policy Objects, they must be created prior to configuring Remote Access. The DirectAccess administrator must have full permissions on the GPOs (Edit + modify security + delete).  
  
> [!IMPORTANT]  
> After manually creating the GPOs for Remote Access you must allow sufficient time for Active Directory and DFS replication to the domain controller in the Active Directory site that is associated with the Remote Access server. If Remote Access automatically created the Group Policy Objects, then no wait time is required.  
  
To create Group Policy Objects, see [Create and Edit a Group Policy Object](https://technet.microsoft.com/library/cc754740.aspx).  
  
### <a name="DCMaintandDowntime"></a>Domain controller maintenance and downtime  
When a domain controller running as the PDC emulator, or domain controllers managing server GPOs experience downtime, it is not possible to load or modify the Remote Access configuration. This does not affect client connectivity if other domain controllers are available.  
  
To load or modify the Remote Access configuration, you can transfer the PDC emulator role to a different domain controller for the client or application server GPOs; for server GPOs, change the domain controllers that manage the server GPOs.  
  
> [!IMPORTANT]  
> This operation can be performed only by a domain administrator. The impact of changing the primary domain controller is not confined to Remote Access; therefore, use caution when transferring the PDC emulator role.  
  
> [!NOTE]  
> Before modifying domain controller association, make sure that all of the GPOs in the Remote Access deployment have been replicated to all of the domain controllers in the domain. If the GPO is not synchronized, recent configuration changes may be lost after modifying domain controller association, which may lead to a corrupt configuration. To verify GPO synchronization, see [Check Group Policy Infrastructure Status](https://technet.microsoft.com/library/jj134176.aspx).  
  
#### <a name="TransferPDC"></a>To transfer the PDC emulator role  
  
1.  On the **Start** screen, type**dsa.msc**, and then press ENTER.  
  
2.  In the left pane of the Active Directory Users and Computers console, right-click **Active Directory Users and Computers**, and then click **Change Domain Controller**. On the Change Directory Server dialog box, click **This Domain Controller or AD LDS instance**, in the list click the domain controller that will be the new role holder, and then click **OK**.  
  
    > [!NOTE]  
    > You must perform this step if you are not on the domain controller to which you want to transfer the role. Do not perform this step if you are already connected to the domain controller to which you want to transfer the role.  
  
3.  In the console tree, right-click **Active Directory Users and Computers**, point to **All Tasks**, and then click **Operations Masters**.  
  
4.  On the Operations Masters dialog box, click the **PDC** tab, and then click **Change**.  
  
5.  Click **Yes** to confirm that you want to transfer the role, and then click **Close**.  
  
#### <a name="ChangeDC"></a>To change the domain controller that manages server GPOs  
  
-   Run the Windows PowerShell cmdlet  `HYPERLINK "https://technet.microsoft.com/library/hh918412.aspx" Set-DAEntryPointDC` on the Remote Access server and specify the unreachable domain controller name for the *ExistingDC* parameter. This command modifies the domain controller association for the server GPOs of the entry points that are currently managed by that domain controller.  
  
    -   To replace the unreachable domain controller "dc1.corp.contoso.com" with the domain controller "dc2.corp.contoso.com", do the following:  
  
        ```  
        Set-DAEntryPointDC "ExistingDC 'dc1.corp.contoso.com' "NewDC 'dc2.corp.contoso.com' "ErrorAction Inquire  
        ```  
  
    -   To replace the unreachable domain controller "dc1.corp.contoso.com" with a domain controller in the closest Active Directory site to the Remote Access server "DA1.corp.contoso.com", do the following:  
  
        ```  
        Set-DAEntryPointDC "ExistingDC 'dc1.corp.contoso.com' "ComputerName 'DA1.corp.contoso.com' "ErrorAction Inquire  
        ```  
  
### <a name="ChangeTwoDCs"></a>Change two or more domain controllers that manage server GPOs  
In a minimal number of cases, two or more domain controllers that manage server GPOs are unavailable. If this occurs, more steps are required to change the domain controller association for the server GPOs.  
  
Domain controller association information is stored both in the registry of the Remote Access servers and in all server GPOs. In the following example, there are two entry points with two Remote Access servers, "DA1" in "Entry point 1" and "DA2" in "Entry point 2". The server GPO of "Entry point 1" is managed in the domain controller "DC1", while the server GPO of "Entry point 2" is managed in the domain controller "DC2". Both "DC1" and "DC2" are unavailable. A third domain controller is still available in the domain, "DC3", and the data from "DC1" and "DC2" was already replicated to "DC3".  
  
![Configure Multisite Infrastructure](../../../../media/Step-2-Configure-the-Multisite-Infrastructure/DCAssoc1.png)  
  
##### To change two or more domain controllers that manage server GPOs  
  
1.  To replace the unavailable domain controller "DC2" with the domain controller "DC3", run the following command:  
  
    ```  
    Set-DAEntryPointDC "ExistingDC 'DC2' "NewDC 'DC3' "ComputerName 'DA2' "ErrorAction Continue  
    ```  
  
    This command updates the domain controller association for the "Entry point 2" server GPO in the registry of DA2 and in the "Entry point 2" server GPO itself; however, it does not update the "Entry point 1" server GPO because the domain controller that manages it is unavailable.  
  
    > [!TIP]  
    > This command uses the Continue value for the *ErrorAction* parameter, which updates the "Entry point 2" server GPO despite the failure to update "Entry point 1" server GPO.  
  
    The resulting configuration is shown in the following diagram.  
  
    ![Windows PowerShell](../../../../media/Step-2-Configure-the-Multisite-Infrastructure/DCAssoc2.png)  
  
2.  To replace the unavailable domain controller "DC1" with the domain controller "DC3", run the following command:  
  
    ```  
    Set-DAEntryPointDC "ExistingDC 'DC1' "NewDC 'DC3' "ComputerName 'DA2' "ErrorAction Continue  
    ```  
  
    This command updates the domain controller association for the "Entry point 1" server GPO in the registry of DA1 and in the "Entry point 1" and "Entry point 2" server GPOs. The resulting configuration is shown in the following diagram.  
  
    ![Windows PowerShell](../../../../media/Step-2-Configure-the-Multisite-Infrastructure/DCAssoc3.png)  
  
3.  To synchronize the domain controller association for the "Entry point 2" server GPO in the "Entry point 1" server GPO, run the command to replace "DC2" with "DC3", and specify the Remote Access server whose server GPO is not synchronized, in this case "DA1", for the *ComputerName* parameter.  
  
    ```  
    Set-DAEntryPointDC "ExistingDC 'DC2' "NewDC 'DC3' "ComputerName 'DA1' "ErrorAction Continue  
    ```  
  
    The final configuration is shown in the following diagram.  
  
    ![Windows PowerShell](../../../../media/Step-2-Configure-the-Multisite-Infrastructure/DCAssocFinal.png)  
  
### <a name="ConfigDistOptimization"></a>Optimization of configuration distribution  
When making configuration changes, the changes are applied only after the server GPOs propagate to the Remote Access servers. To reduce the configuration distribution time, Remote Access automatically selects a writable domain controller which is  HYPERLINK "<https://technet.microsoft.com/library/cc978016.aspx>" closest to the Remote Access server when creating its server GPO.  
  
In some scenarios, it may be required to manually modify the domain controller that manages a server GPO in order to optimize configuration distribution time:  
  
-   There were no writable domain controllers in the Active Directory site of a Remote Access server at the time of adding it as an entry point. A writable domain controller is now being added to the Active Directory site of the Remote Access server.  
  
-   An IP address change, or an Active Directory Sites and Subnets change may have moved the Remote Access server to a different Active Directory site.  
  
-   The domain controller association for an entry point was manually modified due to maintenance work on a domain controller, and now the domain controller is back online.  
  
In these scenarios, run the PowerShell cmdlet `Set-DAEntryPointDC` on the Remote Access server and specify the name of the entry point you want to optimize using the parameter *EntryPointName*. You should do this only after the GPO data from the domain controller currently storing the server GPO was already fully replicated to the desired new domain controller.  
  
> [!NOTE]  
> Before modifying domain controller association, make sure that all of the GPOs in the Remote Access deployment have been replicated to all of the domain controllers in the domain. If the GPO is not synchronized, recent configuration changes may be lost after modifying domain controller association, which may lead to a corrupt configuration. To verify GPO synchronization, see [Check Group Policy Infrastructure Status](https://technet.microsoft.com/library/jj134176.aspx).  
  
To optimize the configuration distribution time, do one of the following:  
  
-   To manage the server GPO of entry point "Entry point 1" on a domain controller in the closest Active Directory site to the Remote Access server "DA1.corp.contoso.com", run the following command:  
  
    ```  
    Set-DAEntryPointDC "EntryPointName 'Entry point 1' "ComputerName 'DA1.corp.contoso.com' "ErrorAction Inquire  
    ```  
  
-   To manage the server GPO of entry point "Entry point 1" on the domain controller "dc2.corp.contoso.com", run the following command:  
  
    ```  
    Set-DAEntryPointDC "EntryPointName 'Entry point 1' "NewDC 'dc2.corp.contoso.com' "ComputerName 'DA1.corp.contoso.com' "ErrorAction Inquire  
    ```  
  
    > [!NOTE]  
    > When modifying the domain controller associated with a specific entry point, you must specify a Remote Access server that is a member of that entry point for the *ComputerName* parameter.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Configure the multisite deployment](Step-3-Configure-the-Multisite-Deployment.md)  
-   [Step 1: Implement a single server Remote Access deployment](Step-1-Implement-a-Single-Server-Remote-Access-Deployment.md)  


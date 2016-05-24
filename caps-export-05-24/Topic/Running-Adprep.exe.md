---
title: Running Adprep.exe
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: bce74f86-fbbf-405c-8d83-395f17a6ac8a
author: Femila
---
# Running Adprep.exe
  This topic explains what Adprep.exe is. It also provides links to step\-by\-step instructions for running Adprep.exe.  
  
-   [What is Adprep.exe?](../Topic/Running-Adprep.exe.md#BKMK_WhatsADPrep)  
  
-   [Considerations for using Adprep.exe in Windows Server 2012 R2 and Windows Server 2012](../Topic/Running-Adprep.exe.md#BKMK_WS2012)  
  
-   [Considerations for using Adprep.exe in Windows Server 2008 R2 and Windows Server 2008](../Topic/Running-Adprep.exe.md#BKMK_R2Adprep)  
  
-   [Running Adprep.exe](../Topic/Running-Adprep.exe.md#BKMK_RunAdprep)  
  
-   [Troubleshooting errors with Adprep.exe](../Topic/Running-Adprep.exe.md#BKMK_TshootAdprep)  
  
##  <a name="BKMK_WhatsADPrep"></a> What is Adprep.exe?  
 Adprep.exe is a command\-line tool that is included on the installation disk of each version of Windows Server. Adprep.exe performs operations that must be completed on the domain controllers that run in an existing Active Directory environment before you can add a domain controller that runs that version of Windows Server.  
  
 Adprep.exe commands run automatically as needed as part of the AD DS installation process on servers that run Windows Server 2012 or later. The commands need to run in the following cases:  
  
-   Before you add the first domain controller that runs a version of Windows Server that is later than the latest version that is running in your existing domain.  
  
-   Before you upgrade an existing domain controller to a later version of Windows Server, if that domain controller will be the first domain controller in the domain or forest to run that version of Windows Server.  
  
 For example, if your organization has domain controllers that run Windows 2000 Server or Windows Server 2003, before you can add a new domain controller that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or upgrade one of the existing domain controllers to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must run Adprep.exe from the \\Support\\Adprep folder of the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installation DVD on your existing domain controllers.  
  
 Adprep.exe is a rollup of all previous versions of this tool. In other words, if you currently have domain controllers that run Windows Server 2003 and you want to add domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you only have to run Adprep.exe from the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system disk. It is not necessary to run the version from [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] because the version in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes all the changes from previous versions.  
  
### What does Adprep.exe do?  
 Adprep.exe has parameters that perform a variety of operations that help prepare an existing Active Directory environment for a domain controller that runs a later version of Windows Server. Not all versions of Adprep.exe perform the same operations, but generally the different types of operations that Adprep.exe can perform include the following:  
  
-   Updating the Active Directory schema  
  
-   Updating security descriptors  
  
-   Modifying access control lists \(ACLs\) on Active Directory objects and on files in the SYSVOL shared folder  
  
-   Creating new objects, as needed  
  
-   Creating new containers, as needed  
  
 For more information about the changes that Adprep.exe performs, see the following resources:  
  
-   For Windows Server 2012 and later, see [Changes Made by Adprep.exe](http://technet.microsoft.com/library/hh994609.aspx).  
  
-   For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Windows Server 2008 R2: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008-R2--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md).  
  
-   For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md).  
  
-   For Windows Server 2003 R2, see Extending Your Active Directory Schema in Windows Server 2003 R2 \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=138879](http://go.microsoft.com/fwlink/?LinkId=138879)\).  
  
-   For Windows Server 2003, see Prepare Your Infrastructure for Upgrade \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=138878](http://go.microsoft.com/fwlink/?LinkId=138878)\).  
  
##  <a name="BKMK_WS2012"></a> Considerations for using Adprep.exe in Windows Server 2012 R2 and Windows Server 2012  
 Beginning with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Adprep.exe is integrated into the AD DS installation process and runs automatically as needed. For example, when you install the first domain controller that runs [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] into an existing domain and forest, then adprep \/forestprep and adprep \/domainprep automatically run and report the results of the operations.  
  
 Some organizations may prefer to run Adprep.exe separately, either in advance of an AD DS installation or simply to extend an existing AD DS schema to support new features such as the Device Registration Service in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For this reason, Adprep.exe is also included in the \\Support\\Adprep folder of the operating system disk.  
  
 Also beginning with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], there is only one 64\-bit version of Adprep.exe. It can be run remotely from any server that runs a 64\-bit version of Windows Server 2008 or later. The computer where you run it can be either domain\-joined or in a workgroup. It includes [new syntax and parameter options](http://technet.microsoft.com/library/cc731728.aspx) in order to run it remotely.  
  
 For more information about the objects and containers that are created when the schema is extended to support [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [Changes to Adprep.exe](http://technet.microsoft.com/library/hh994609.aspx).  
  
###  <a name="BKMK_DeferredIndexImpact"></a> Mitigating performance impact of deferred index creation  
 The execution of ADPREP and other applications that add indexed attributes to Active Directory databases greater than 100 GB may cause high CPU utilization by LSASS and high disk utilization from the writing of indexes. Then new indexes also trigger a replication event that must be processed by other DCs in the forest.  
  
 The addition of indexes in large Active Directory databases can prevent DCs from responding to clients and application server requests and cause desktop user or application performance degradation or operational failures. Windows Server 2008 R2 added indexes to improve LDAP query performance for certain queries. Windows Server 2012 and Windows Server 2012 R2 include those same indexes.  
  
 By installing [hotfix 2846725](http://support.microsoft.com/kb/2846725) and enabling the DSheuristic attribute on DCs that run Windows Server 2008 R2, index creation is deferred and the time when indexing takes place is staggered across all DCs in the forest.  
  
 Beginning in Windows Server 2012, the introduction of schema changes occurs independently from the indexing of the attributes. See [Deferred Index Creation](http://technet.microsoft.com/library/hh831477.aspx).  
  
 In addition to applying the hotfix, you can take these steps to help prepare for the schema update:  
  
-   Check the AD database size. See [Determine the Database Size and Location Online](http://technet.microsoft.com/library/cc794802(v=WS.10).aspx).  
  
-   Check the number of deleted objects.  
  
-   Check the number of DCs that will get indexing.  
  
-   Check the link speeds to those DCs  
  
-   Use a test bed that reflects the production environment so that potential replication problems will be reproduced by testing \(e.g. don’t test in a single domain forest if the production environment really has multiple domains\).  
  
##  <a name="BKMK_R2Adprep"></a> Considerations for using Adprep.exe in Windows Server 2008 R2 and Windows Server 2008  
 In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Adprep.exe is located in the \\Support\\Adprep folder of the operating system disk. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is located in the \\Sources\\Adprep folder.  
  
 [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes a 32\-bit version and a 64\-bit version of Adprep.exe. The 64\-bit version runs by default. If you want to run one of the Adprep.exe commands on a 32\-bit computer, use the 32\-bit version of Adprep.exe \(Adprep32.exe\).  
  
##  <a name="BKMK_RunAdprep"></a> Running Adprep.exe  
 To complete the required operations, you must run the Adprep.exe commands that are listed in the following table. You must run **adprep \/forestprep** before you run other commands. Some commands must be run on specific domain controllers, as indicated in the table. None of the commands requires a restart of the server after the operation is complete. The remaining sections in this topic contain more details about each command.  
  
||||  
|-|-|-|  
|Command|Domain controller|Number of times to run the command|  
|**adprep \/forestprep**|Must be run on the schema operations master for the forest.|Once for the entire forest|  
|**adprep \/domainprep**|Must be run on the infrastructure operations master for the domain.|Once in each domain where you plan to install an additional domain controller that runs a later version of Windows Server than the latest version that is running in the domain. **Note:**  Domains where you will not add a new domain controller will be affected by **adprep \/forestprep**, but they do not require you to run **adprep \/domainprep**.|  
|**adprep \/domainprep \/gpprep**|Must be run on the infrastructure operations master for the domain.<br /><br /> If you already ran the **\/gpprep** parameter for Windows Server 2003, you do not have to run it again for later versions of Windows Server.|Once in each domain within the forest|  
|**adprep \/rodcprep** **Note:**  This command is optional. Run it only if you want to install a read\-only domain controller \(RODC\).|Can be run from any computer. This command performs operations remotely. For the operations to complete successfully, the domain naming operations master for the forest and the infrastructure operations master for each application directory partition and each domain partition must be accessible.<br /><br /> If you already ran this command for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you do not have to run it again for later versions of Windows Server.|Once for the entire forest|  
  
> [!NOTE]  
>  If you plan to add an RODC to the forest, you can run **adprep \/rodcprep** right after you run **adprep \/forestprep** and then verify that both operations have replicated throughout the forest. Both commands require Enterprise Admin credentials; therefore, you might prefer to run them consecutively.  
  
 If you are not sure which computer holds the operations master \(also known as flexible single master operations or FSMO\) role that you need, type the following command at a command prompt on a computer on which you have Netdom.exe installed, and then press ENTER:  
  
 `netdom query FSMO`  
  
 Netdom.exe is installed by default on domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or later. You can also install Netdom.exe on an administrative workstation. For more information, see Microsoft Remote Server Administration Tools for Windows Vista \(KB941314\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=89361](http://go.microsoft.com/fwlink/?LinkID=89361)\) or Windows Server 2003 Service Pack 2 32\-bit Support Tools \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=100114](http://go.microsoft.com/fwlink/?LinkID=100114)\).  
  
### Running adprep \/forestprep  
 Run the **adprep \/forestprep** command to update the Active Directory schema and perform other forest\-wide updates. The schema updates are required to support new object types. Other forest\-wide updates are required to update permissions and default security descriptors. The following sections include more details about running **adprep \/forestprep**:  
  
-   [Preparing to run adprep /forestprep](../Topic/Running-Adprep.exe.md#BKMK_PrepFP)  
  
-   [Running adprep /forestprep](../Topic/Running-Adprep.exe.md#BKMK_RunFP)  
  
-   [Verifying that adprep /forestprep completed successfully](../Topic/Running-Adprep.exe.md#BKMK_VerifyForestPrep)  
  
####  <a name="BKMK_PrepFP"></a> Preparing to run adprep \/forestprep  
 Organizations should review and understand the schema updates and other changes that Adprep.exe makes as part of the schema management process in Active Directory Domain Services \(AD DS\). Test the Adprep.exe schema updates in a lab environment to ensure that they will not conflict with any applications that run in your environment. There should not be any conflicts if your applications use Request for Comments \(RFC\)\-compliant object and attribute definitions. For more information about the updates that Adprep.exe performs for different versions of Windows Server, see [Changes Made by Adprep.exe](http://technet.microsoft.com/library/hh994609.aspx), [Windows Server 2008 R2: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008-R2--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md), and [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md).  
  
 Adprep.exe has built\-in fail\-safes that prevent potential problems that can arise from a schema update. The fail\-safes handle conflicting updates, such as the introduction of duplicate object identifiers, and cause Adprep.exe to stop until an administrator reconciles the conflicts. An administrator can also manually stop and restart Adprep.exe. Adprep.exe skips redundant updates and it resumes at the point where it was stopped.  
  
 Because of these fail\-safes, we do not recommend that you disable replication on the schema master as an additional precaution before you run Adprep.exe as it should not be necessary. If you nonetheless choose to disable replication on the schema master or isolate it physically from the production network, be aware of the following issues that you might encounter:  
  
-   Monitoring software may detect that replication is disabled and initiate recovery activity that re\-enables replication.  
  
-   If you boot the schema master on a private network, it will fail initial synchronization unless you also place a second domain controller on the same private network.  
  
-   If you boot the schema master on a private network and it is not a DNS server, place a DNS server on the same private network and have the schema master point to it as the preferred DNS server.  
  
-   If you boot the schema master on a private network and it is a DNS server and additional domain controllers are in the forest, you could wait several minutes for the operating system to start.  
  
 To help ensure that the **adprep \/forestprep** command runs successfully, complete these additional steps before you run the command on the schema operations master role holder in the forest:  
  
1.  Make a system state backup for your domain controllers, including the schema master and at least one other domain controller from each domain in the forest. After the changes that **adprep \/forestprep** makes replicate throughout the forest, they can be reversed only by forest recovery. You can implement forest recovery more effectively if you have recent and trusted system state backups. For more information about backing up a domain controller, see Performing an Unscheduled Backup of a Domain Controller \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=132632](http://go.microsoft.com/fwlink/?LinkID=132632)\). For more information about planning for forest recovery, see Planning for Active Directory Forest Recovery \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140265](http://go.microsoft.com/fwlink/?LinkId=140265)\).  
  
2.  Make sure that you can log on to the schema master with an account that has sufficient credentials to run **adprep \/forestprep**. You must be a member of the Schema Admins group, the Enterprise Admins group, and the Domain Admins group of the domain that hosts the schema master, which is, by default, the forest root domain.  
  
    > [!NOTE]  
    >  The built\-in Administrator account in the forest root domain is a member of the Schema Admins group by default.  
  
3.  If any domain controllers in the forest are running Windows 2000 Server, they must be running Service Pack 4 \(SP4\). To obtain Windows 2000 Server SP4, see Windows 2000 Service Pack 4 Network Install for IT Professionals \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140267](http://go.microsoft.com/fwlink/?LinkId=140267)\).  
  
4.  If you are running Exchange 2000, see article 325379 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140269](http://go.microsoft.com/fwlink/?LinkId=140269)\) for more information about preventing potential schema conflicts.  
  
5.  Run the following Repadmin.exe command to ensure that replication is working throughout the forest:  
  
     `repadmin /replsum /bysrc /bydest /sort:delta`  
  
     All domain controllers should show **0** in the **Fails** column, and the largest deltas \(which indicate the time that has elapsed since the last successful replication\) should be less than or roughly equal to the replication frequency of the site link that the domain controller uses for replication. The default replication frequency is 180 minutes.  
  
6.  Antivirus software that is running on a schema master can interfere with running **adprep \/forestprep**. The introduction of display specifiers during the **adprep \/forestprep** operation calls an external function that can cause locks on files or folders that are used by antivirus software utilities.  
  
     In this case, the following error can appear when you run **adprep \/forestprep**:  
  
     “Adprep was unable to complete because the call back function failed.”  
  
     If you are running antivirus software on the schema master and receive this error when you run **adprep \/forestprep**, temporarily disable the antivirus software until the command completes. For more information, see [Adprep was unable to complete because the call back function failed](../Topic/Running-Adprep.exe.md#BKMK_CallBack).  
  
 For more information about completing these preparatory steps, see So You Want to Upgrade to Windows 2008 Domain Controllers \(ADPREP\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=138880](http://go.microsoft.com/fwlink/?LinkId=138880)\).  
  
####  <a name="BKMK_RunFP"></a> Running adprep \/forestprep  
 You can run the **adprep \/forestprep** command from the Windows Server DVD, or you can copy the contents of the folder that includes Adprep.exe to your schema master and run Adprep.exe from that location. If you copy Adprep.exe to the schema master, be sure to copy the entire contents of the folder.  
  
 For more information about how to run the **adprep \/forestprep** command, see [Prepare a Windows 2000 or Windows Server 2003 Forest Schema for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Forest-Schema-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md).  
  
####  <a name="BKMK_VerifyForestPrep"></a> Verifying that adprep \/forestprep completed successfully  
 When the **adprep \/forestprep** command completes, a message appears in the Command Prompt window to indicate that Adprep has successfully updated the forest\-wide information. You can also use the following procedure to verify that **adprep \/forestprep** completed successfully.  
  
###### To verify that adprep \/forestprep completed successfully  
  
1.  Log on to an administrative workstation that has ADSIEdit installed. ADSIEdit is installed by default on domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
2.  Click **Start**, click **Run**, type **ADSIEdit.msc**, and then click **OK**.  
  
3.  Click **Action**, and then click **Connect to**.  
  
4.  Click **Select a well known Naming Context**, select **Configuration** in the list of available naming contexts, and then click **OK**.  
  
5.  Double\-click **Configuration**, and then double\-click **CN\=Configuration,DC\=***forest\_root\_domain*  
  
     where *forest\_root\_domain* is the distinguished name of your forest root domain.  
  
6.  Double\-click **CN\=ForestUpdates**.  
  
7.  Right\-click **CN\=ActiveDirectoryUpdate**, and then click **Properties**.  
  
8.  Confirm that the **revision** attribute value is correct for the version of **adprep \/forestprep**, and then click **OK**.  
  
    -   For [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the value is **15**.  
  
    -   For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the value is **11**.  
  
    -   For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the value is **5**.  
  
    -   For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the value is **2**.  
  
9. Click **ADSI Edit**, click **Action**, and then click **Connect to**.  
  
10. Click **Select a Well known naming context**, select **Schema** in the list of available naming contexts, and then click **OK**.  
  
11. Double\-click **Schema**.  
  
12. Right\-click **CN\=Schema,CN\=Configuration,DC\=***forest\_root\_domain*, and then click **Properties**.  
  
     where *forest\_root\_domain* is the distinguished name of your forest root domain.  
  
13. Confirm that the **objectVersion** attribute value is correct for the version of **adprep \/forestprep**, and then click **OK**.  
  
    -   For [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the value is **69**.  
  
    -   For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the value is **56**.  
  
    -   For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the value is **47**.  
  
    -   For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the value is **44**.  
  
### Running adprep \/domainprep  
 After the **adprep \/forestprep** operations are complete, you are ready to run the **adprep \/domainprep** command to prepare your domains. The following sections include more details about running **adprep \/domainprep**:  
  
-   [Preparing to run adprep /domainprep](../Topic/Running-Adprep.exe.md#BKMK_PrepDomainPrep)  
  
-   [Running adprep /domainprep](../Topic/Running-Adprep.exe.md#BKMK_RunDomainPrep)  
  
-   [Verifying adprep /domainprep](../Topic/Running-Adprep.exe.md#BKMK_VerifyDomainPrep)  
  
####  <a name="BKMK_PrepDomainPrep"></a> Preparing to run adprep \/domainprep  
 To help ensure that the **adprep \/domainprep** command runs successfully, complete these steps before you run the command on the infrastructure operations master role holder in each domain:  
  
1.  Make sure that the schema updates that **adprep \/forestprep** performs replicated throughout the forest or that they at least replicated to the infrastructure master for the domain where you plan to run **adprep \/domainprep**. For more information, see [Verifying that adprep /forestprep completed successfully](../Topic/Running-Adprep.exe.md#BKMK_VerifyForestPrep).  
  
2.  Make sure that you can log on to the infrastructure master with an account that is a member of the Domain Admins group.  
  
3.  Verify that the domain functional level is at least Windows 2000 native.  
  
####  <a name="BKMK_RunDomainPrep"></a> Running adprep \/domainprep  
 When you are ready to run **adprep \/domainprep**, insert the Windows Server operating system DVD into the DVD drive of the infrastructure master. Then, change directories to the folder that contains Adprep.exe and run the command. For more information, see [Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Domain-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md).  
  
####  <a name="BKMK_VerifyDomainPrep"></a> Verifying adprep \/domainprep  
 When **adprep \/domainprep** completes, a message appears in the Command Prompt window to indicate that Adprep successfully updated the domain\-wide information. You can also use the following procedure to verify that **adprep \/domainprep** completed successfully.  
  
###### To verify that adprep \/domainprep completed successfully  
  
1.  Log on to an administrative workstation that has ADSIEdit installed. ADSIEdit is installed by default on domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
2.  Click **Start**, click **Run**, type **ADSIEdit.msc**, and then click **OK**.  
  
3.  Click **Action**, and then click **Connect to**.  
  
4.  Click **Select a well known Naming Context**, select **Default naming context** in the list of available naming contexts, and then click **OK**.  
  
5.  Double\-click **Default naming context**, double\-click the container that is the distinguished name of the domain, and then double\-click **CN\=System**.  
  
6.  Double\-click **CN\=DomainUpdates**, right\-click **CN\=ActiveDirectoryUpdate**, and then click **Properties**.  
  
7.  Confirm that the **revision** attribute value is correct for the version of **adprep \/domainprep**, and then click **OK**.  
  
    -   For [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the value is **10**.  
  
    -   For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the value is **9**.  
  
    -   For [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the value is **5**.  
  
    -   For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the value is **3**.  
  
### Running adprep \/domainprep \/gpprep  
 If you ran the version of the **adprep \/domainprep** command that is included in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or later, the **adprep \/domainprep \/gpprep** command adds only the inheritable access control entries \(ACEs\) on Group Policy objects \(GPOs\) in the SYSVOL shared folder. The additional ACEs give enterprise domain controllers read access permissions on GPOs. These permissions are required to support Resultant Set of Policy \(RSOP\) functionality for site\-based policy.  
  
> [!NOTE]  
>  Although other adprep.exe commands are run automatically as part of the AD DS installation process beginning with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the **adprep \/domainprep \/gpprep** command is not run automatically. If the command has never been run in your environment, you may need to run it separately. For more information, see KB article [2737129](http://support.microsoft.com/kb/2737129).  
  
 Running **adprep \/domainprep \/gpprep** can create a lot of replication traffic because every GPO is updated. Therefore, you might want to run this command during off\-peak hours to minimize the impact of the additional replication.  
  
 If you run **adprep \/domainprep \/gpprep** before you run **adprep \/domainprep**, Adprep.exe runs both commands sequentially. First, it performs the **\/domainprep** operations, and then it performs the **\/gpprep** operations.  
  
 If you are running an earlier version of Adprep.exe, see article 324392 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140283](http://go.microsoft.com/fwlink/?LinkId=140283)\).  
  
 The following sections include more details about running **adprep \/domainprep \/gpprep**:  
  
-   [Preparing to run adprep /domainprep /gpprep](../Topic/Running-Adprep.exe.md#BKMK_PrepGPPrep)  
  
-   [Running adprep /domainprep /gpprep](../Topic/Running-Adprep.exe.md#BKMK_RunGPPrep)  
  
-   [Verifying adprep /domainprep /gpprep](../Topic/Running-Adprep.exe.md#BKMK_VerifyGPPrep)  
  
####  <a name="BKMK_PrepGPPrep"></a> Preparing to run adprep \/domainprep \/gpprep  
 To help ensure that **adprep \/domainprep \/gpprep** runs successfully, complete these steps before you run the command on the infrastructure operations master role holder in each domain.  
  
1.  Make sure that you have completed the preparatory steps for running **adprep \/domainprep**. For more information, see [Preparing to run adprep /domainprep](../Topic/Running-Adprep.exe.md#BKMK_PrepDomainPrep).  
  
2.  Make sure that the **Default Domain Policy** and the **Default Domain Controllers Policy** are located on the infrastructure master. To do this, use Windows Explorer to navigate to the %windir%\\SYSVOL\\sysvol\\*domain\_name*\\Policies folder. Confirm that the following globally unique identifiers \(GUIDs\) appear in the **Policies** folder:  
  
    -   {31B2F340\-016D\-11D2\-945F\-00C04FB984F9}  
  
    -   {6AC1786C\-016F\-11D2\-945F\-00C04fB984F9}  
  
3.  Antivirus software that is running on an infrastructure master can interfere with running **adprep \/domainprep \/gpprep**. In this case, the following error message can appear when you run **adprep \/domainprep \/gpprep**:  
  
     “Adprep was unable to complete because the call back function failed.”  
  
     If you are running antivirus software on the infrastructure master and receive this error message when you run **adprep \/domainprep \/gpprep**, temporarily disable the antivirus software until the command completes. For more information, see [Adprep was unable to complete because the call back function failed](../Topic/Running-Adprep.exe.md#BKMK_CallBack).  
  
####  <a name="BKMK_RunGPPrep"></a> Running adprep \/domainprep \/gpprep  
 When you are ready to run the **adprep \/domainprep \/gpprep** command, insert the Windows Server operating system DVD into the DVD drive of the infrastructure master. Then, change directories to the folder that contains Adprep.exe and run the command. For more information, see [Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Domain-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md).  
  
####  <a name="BKMK_VerifyGPPrep"></a> Verifying adprep \/domainprep \/gpprep  
 If you have not yet run **adprep \/domainprep**, when you run **adprep \/domainprep \/gpprep** you see a message that indicates that **adprep \/domainprep** successfully updated the domain\-wide information, followed by a message that indicates that Adprep successfully updated the GPO information. If you have already run **adprep \/domainprep**, the message indicates that the domain\-wide information has already been updated and that the operation will not be repeated, followed by the message that indicates that Adprep successfully updated the GPO information.  
  
 You can also verify that this command is complete by using the steps for verifying that **adprep \/domainprep** completed successfully, or you can verify that the operation added the Read permission for the Enterprise Domain Controllers group on all GPOs. For more information, see [Verifying adprep /domainprep](../Topic/Running-Adprep.exe.md#BKMK_VerifyDomainPrep).  
  
### Running adprep \/rodcprep  
 Running the **adprep \/rodcprep** command is optional. It is required only if you want to install an RODC in the forest. This command updates the security descriptors for domain and application directory partitions to give RODCs permission to replicate updates to the partitions.  
  
 Each application directory partition has an infrastructure master. The **adprep \/rodcprep** command must update the security descriptor for each application directory partition on the infrastructure master for that partition.  
  
 There are two application directory partitions that are created by default for Domain Name System \(DNS\) data: DomainDNSZones and ForestDNSZones. If the infrastructure master for either of these partitions is offline or if it has been forcefully removed from the forest, **adprep \/rodcprep** fails with an error. For more information, see article 949257 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140285](http://go.microsoft.com/fwlink/?LinkId=140285)\). In addition, this command must contact the domain naming operations master to obtain a list of the application and domain directory partitions that are in the forest. Therefore, the domain naming master must be accessible when you run this command.  
  
 The command also updates the “defaultSecurityDescriptor” of the domainDNS classSchema object \(CN\=Domain\-DNS,CN\=Schema,CN\=Configuration,\<Forest Root Domain DN\>\) to grant the “Replicating Directory Changes” control access right to the **Enterprise Read\-Only Domain Controllers** security group. When you create a new domain or application partition, the new object inherits the default permissions from the schema object. For more information, see [When To Use ForestPrep, DomainPrep And RODCPrep](http://jorgequestforknowledge.wordpress.com/category/active-directory-domain-services-adds/rodcprep/).  
  
 The following sections include more details about running **adprep \/rodcprep**:  
  
-   [Preparing to run adprep /rodcprep](../Topic/Running-Adprep.exe.md#BKMK_PrepRODCprep)  
  
-   [Running adprep /rodcprep](../Topic/Running-Adprep.exe.md#BKMK_RunRODCPrep)  
  
-   [Verifying adprep /rodcprep](../Topic/Running-Adprep.exe.md#BKMK_VerifyRODCPrep)  
  
####  <a name="BKMK_PrepRODCprep"></a> Preparing to run adprep \/rodcprep  
 To help ensure that the **adprep \/rodcprep** command runs successfully, complete these steps before you run the command:  
  
1.  Make sure you can log on to a computer with an account that is a member of the Enterprise Admins group.  
  
2.  Make sure that the domain naming master and the infrastructure master for each application directory partition are accessible.  
  
####  <a name="BKMK_RunRODCPrep"></a> Running adprep \/rodcprep  
 When you are ready to run the **adprep \/rodcprep** command, insert the Windows Server operating system DVD into the DVD drive of the computer. Then, change directories to the folder that contains Adprep.exe and run the command. For more information, see [Prepare a Forest for a Read-Only Domain Controller](../Topic/Prepare-a-Forest-for-a-Read-Only-Domain-Controller.md).  
  
###  <a name="BKMK_VerifyRODCPrep"></a> Verifying adprep \/rodcprep  
 When the **adprep \/rodcprep** command completes, a message appears in the Command Prompt window to indicate that all partitions are updated. You can also use the following procedure to verify that **adprep \/rodcprep** completed successfully.  
  
##### To verify that adprep \/rodcprep completed successfully  
  
1.  Log on to an administrative workstation that has ADSIEdit installed. ADSIEdit is installed by default on domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
2.  Click **Start**, click **Run**, type **ADSIEdit.msc**, and then click **OK**.  
  
3.  Click **Action**, and then click **Connect to**.  
  
4.  Click **Select a well known Naming Context**, select **Configuration** in the list of available naming contexts, and then click **OK**.  
  
5.  Double\-click **Configuration**, and then double\-click **CN\=Configuration,DC\=***forest\_root\_domain*  
  
     where *forest\_root\_domain* is the distinguished name of your forest root domain.  
  
6.  Double\-click **CN\=ForestUpdates**.  
  
7.  Right\-click **CN\=ActivedirectoryRodcUpdate**, and then click **Properties**.  
  
8.  Confirm that the **Revision** attribute value is **2**, and then click **OK**.  
  
##  <a name="BKMK_TshootAdprep"></a> Troubleshooting errors with Adprep.exe  
 This section explains how to correct problems when Adprep.exe fails. Adprep.exe errors are logged in the %windir%\\Debug\\Adprep\\Logs folder. There will be a separate file each time that you run ADPREP. At the bottom of the file, you can see what the problem is. Some common causes for Adprep.exe errors include the following:  
  
-   [Insufficient credentials to run the command](../Topic/Running-Adprep.exe.md#BKMK_Creds)  
  
-   [Operations master role holders are not accessible](../Topic/Running-Adprep.exe.md#BKMK_FSMO)  
  
-   [Schema conflicts](../Topic/Running-Adprep.exe.md#BKMK_OID)  
  
-   [Adprep was unable to complete because the call back function failed](../Topic/Running-Adprep.exe.md#BKMK_CallBack)  
  
-   [You receive an error when you run adprep /forestprep that says “Adprep is valid, but is for a machine type other than the current machine”](../Topic/Running-Adprep.exe.md#BKMK_VersionError)  
  
 For more information, see Troubleshooting ADPREP Errors \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=138881](http://go.microsoft.com/fwlink/?LinkId=138881)\).  
  
###  <a name="BKMK_Creds"></a> Insufficient credentials to run the command  
 Each Adprep.exe command requires a different set of credentials. The following table lists the credential requirements for each command.  
  
|||  
|-|-|  
|Adprep.exe command|Credentials that are required to run the command|  
|**adprep \/forestprep**|-   Schema Admins<br />-   Enterprise Admins<br />-   Domain Admins of the domain that hosts the schema master|  
|**adprep \/domainprep**|Domain Admins|  
|**adprep \/domainprep \/gpprep**|Domain Admins|  
|**adprep \/rodcprep**|Enterprise Admins|  
  
###  <a name="BKMK_FSMO"></a> Operations master role holders are not accessible  
 If Adprep.exe cannot contact the operations master role holders that are required to complete the command, the command fails with an error. Because the **adprep \/forestprep** and **adprep \/domainprep \/gpprep** commands must be run directly on the schema master and the infrastructure master, respectively, these commands are less likely to generate this type of error.  
  
 The **adprep \/rodcprep** command, however, can be run from any computer. This command runs remotely, and it must contact the domain naming master for the forest to obtain a list of application directory partitions that are in the forest. It then must contact the infrastructure master for each of the application directory partitions. If an infrastructure master is offline or if it has been forcefully removed from the domain, the **adprep \/rodcprep** command fails. For more information, see article 949257 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=140285](http://go.microsoft.com/fwlink/?LinkID=140285)\).  
  
###  <a name="BKMK_OID"></a> Schema conflicts  
 Schema conflicts can cause the following Adprep errors:  
  
-   “OID will not be changed resulting in probable failure to add a new class”  
  
     This error occurs when custom schema changes have been made or when non\-Microsoft software makes schema changes that conflict with a schema change from Microsoft.  
  
     To resolve this issue, open the ADPREP log to see what the failed object is. If you know the non\-Microsoft software that is using the attribute, contact the makers of that software and determine if there is a fix. Otherwise, contact Microsoft Customer Support Services.  
  
-   “Schema update failed: An attribute with the same link identifier already exists”  
  
     This error occurs when you are trying to update or add an object in the schema and the link identifier already exists for another attribute. Some non\-Microsoft applications modify the schema with a link identifier set that is owned by the operating system. For more information about resolving this error, see Troubleshooting ADPREP Errors \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=138881](http://go.microsoft.com/fwlink/?LinkId=138881)\).  
  
###  <a name="BKMK_CallBack"></a> Adprep was unable to complete because the call back function failed  
 This error message can appear when an external function called by `adprep /forestprep` or `adprep /domainprep /gpprep` causes locks on files or folders that are used by antivirus software utilities running on the schema master or the infrastructure master.  
  
 If you see this error message when you run `adprep /forestprep`, try disabling the antivirus software and running the command again. After the `adprep /forestprep` command completes, you can enable the antivirus software again.  
  
 If you see this error message when you run `adprep /domainprep /gpprep`, investigate and resolve the following possible causes:  
  
-   The \\SCRIPTS folder is absent from the SYSVOL shared folder.  
  
-   The Default Domain Policy and the Default Domain Controller Policy are absent from SYSVOL.  
  
-   The Default Domain Policy and the Default Domain Controller Policy do not have the default globally unique identifiers \(GUIDs\). The Default Domain Policy GUID is {31B2F340\-016D\-11D2\-945F\-00C04FB984F9}. The default Default Domain Controller Policy GUID is {6AC1786C\-016F\-11D2\-945F\-00C04fB984F9}.  
  
-   The registry entry **HKLM\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters\\SysVol** does not exist or does not point to a valid SYSVOL path, such as %SystemRoot%\\SYSVOL\\sysvol.  
  
-   There are problems with file system junction points between %SystemRoot%\\SYSVOL\\sysvol\\domain and %SystemRoot%\\SYSVOL\\. Running a DIR command of the SYSVOL folder tree structure is not sufficient to validate the junction points. Instead, use LinkD to verify existence of junction points and validate linked folders. For more information about using LinkD, see Gather the SYSVOL path information \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=158003](http://go.microsoft.com/fwlink/?LinkId=158003)\).  
  
###  <a name="BKMK_VersionError"></a> You receive an error when you run adprep \/forestprep that says “Adprep is valid, but is for a machine type other than the current machine”  
 You can receive this error if you try to run Adprep.exe from the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installation DVD on a schema master that runs a 32\-bit version of Windows Server. By default, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] runs the 64\-bit version of Adprep.exe. To resolve this error, open an elevated command prompt on the schema master and run the 32\-bit version of the command:  
  
 **Adprep32.exe \/forestprep**  
  
 The Adprep32.exe tool is in the support\\adprep folder of the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installation DVD.  
  
  
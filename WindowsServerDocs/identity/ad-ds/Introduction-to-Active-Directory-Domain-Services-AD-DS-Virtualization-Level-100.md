---
ms.assetid: 7a3114c8-bda8-49bb-83a8-4e04340ab221
title: Introduction to Active Directory Domain Services (AD DS) Virtualization (Level 100)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Introduction to Active Directory Domain Services (AD DS) Virtualization (Level 100)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Virtualization of Active Directory Domain Services (AD DS) environments has been ongoing for a number of years. Beginning with Windows Server 2012, AD DS provides greater support for virtualizing domain controllers by introducing virtualization-safe capabilities and enabling rapid deployment of virtual domain controllers through cloning. These new virtualization features provide greater support for public and private clouds, hybrid environments where portions of AD DS exist on-premises and in the cloud, and AD DS infrastructures that reside completely on-premises.

**In this document**

-   [Safe virtualization of domain controllers](../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#safe_virt_dc)

-   [Virtualized domain controller cloning](../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#virtualized_dc_cloning)

-   [Steps for deploying a clone virtualized domain controller](../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#steps_deploy_vdc)

-   [Troubleshooting](../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#troubleshooting)

## <a name="safe_virt_dc"></a>Safe virtualization of domain controllers
Virtual environments present unique challenges to distributed workloads that depend upon a logical clock-based replication scheme. AD DS replication, for example, uses a monotonically increasing value (known as a USN or Update Sequence Number) assigned to transactions on each domain controller. Each domain controller's database instance is also given an identity, known as an InvocationID. The InvocationID of a domain controller and its USN together serve as a unique identifier associated with every write-transaction performed on each domain controller and must be unique within the forest.

AD DS replication uses InvocationID and USNs on each domain controller to determine what changes need to be replicated to other domain controllers. If a domain controller is rolled back in time outside of the domain controller's awareness and a USN is reused for an entirely different transaction, replication will not converge because other domain controllers will believe they have already received the updates associated with the re-used USN under the context of that InvocationID.

For example, the following illustration shows the sequence of events that occurs in Windows Server 2008 R2 and earlier operating systems when USN rollback is detected on VDC2, the destination domain controller that is running on a virtual machine. In this illustration, the detection of USN rollback occurs on VDC2 when a replication partner detects that VDC2 has sent an up-to-dateness USN value that was seen previously by the replication partner, which indicates that VDC2's database has rolled back in time improperly.

![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/ADDS_Exampleofhowreplicationcanbecomeinconsistent.png)

A virtual machine (VM) makes it easy for hypervisor administrators to roll back a domain controller's USNs (its logical clock) by, for example, applying a snapshot outside of the domain controller's awareness. For more information about USN and USN rollback, including another illustration to demonstrate undetected instances of USN rollback, see [USN and USN Rollback](http://technet.microsoft.com/library/virtual_active_directory_domain_controller_virtualization_hyperv(WS.10).aspx#usn_and_usn_rollback).

Beginning with  Windows Server 2012 , AD DS virtual domain controllers hosted on hypervisor platforms that expose an identifier called VM-Generation ID can detect and employ necessary safety measures to protect the AD DS environment if the virtual machine is rolled back in time by the application of a VM snapshot. The VM-GenerationID design uses a hypervisor-vendor independent mechanism to expose this identifier in the address space of the guest virtual machine, so the safe virtualization experience is consistently available of any hypervisor that supports VM-GenerationID. This identifier can be sampled by services and applications running inside the virtual machine to detect if a virtual machine has been rolled back in time.

### <a name="BKMK_HowSafeguardsWork"></a>How do these virtualization safeguards work?
During domain controller installation, AD DS initially stores the VM GenerationID identifier as part of the msDS-GenerationID attribute on the domain controller's computer object in its database (often referred to as the directory information tree, or DIT). The VM GenerationID is independently tracked by a Windows driver inside the virtual machine.

When an administrator restores the virtual machine from a previous snapshot, the current value of the VM GenerationID from the virtual machine driver is compared against a value in the DIT.

If the two values are different, the invocationID is reset and the RID pool discarded thereby preventing USN re-use. If the values are the same, the transaction is committed as normal.

AD DS also compares the current value of the VM GenerationID from the virtual machine against the value in the DIT each time the domain controller is rebooted and, if different, it resets the invocationID, discards the RID pool and updates the DIT with the new value. It also non-authoritatively synchronizes the SYSVOL folder in order to complete safe restoration. This enables the safeguards to extend to the application of snapshots on VMs that were shutdown. These safeguards introduced in  Windows Server 2012  enable AD DS administrators to benefit from the unique advantages of deploying and managing domain controllers in a virtualized environment.

The following illustration shows how virtualization safeguards are applied when the same USN rollback is detected on a virtualized domain controller that runs  Windows Server 2012  on a hypervisor that supports VM-GenerationID.

![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/ADDS_VDC_Exampleofhowsafeguardswork.gif)

In this case, when the hypervisor detects a change to VM-GenerationID value, virtualization safeguards are triggered, including the reset of the InvocationID for the virtualized DC (from A to B in the preceding example) and updating the VM-GenerationID value saved on the VM to match the new value (G2) stored by the hypervisor. The safeguards ensure that replication converges for both domain controllers.

With  Windows Server 2012 , AD DS employs safeguards on virtual domain controllers hosted on VM-GenerationID aware hypervisors and ensures that the accidental application of snapshots or other such hypervisor-enabled mechanisms that could rollback a virtual machine's state does not disrupt the AD DS environment (by preventing replication problems such as a USN bubble or lingering objects). However, restoring a domain controller by applying a virtual machine snapshot is not recommended as an alternative mechanism to backing up a domain controller. It is recommended that you continue to use Windows Server Backup or other VSS-writer based backup solutions.

> [!CAUTION]
> If a domain controller in a production environment is accidentally reverted to a snapshot, it's advised that you consult the vendors for the applications, and services hosted on that virtual machine, for guidance on verifying the state of these programs after snapshot restore.

For more information, see [Virtualized domain controller safe restore architecture](../ad-ds/get-started/virtual-dc/Virtualized-Domain-Controller-Architecture.md#BKMK_SafeRestoreArch).

## <a name="virtualized_dc_cloning"></a>Virtualized domain controller cloning
Beginning with  Windows Server 2012 , administrators can easily and safely deploy replica domain controllers by copying an existing virtual domain controller. In a virtual environment, administrators no longer have to repeatedly deploy a server image prepared by using sysprep.exe, promote the server to a domain controller and then complete additional configuration requirements for deploying each replica domain controller.

> [!NOTE]
> Administrators need to follow existing processes to deploy the first domain controller in a domain, such as using a sysprep.exe to prepare a server virtual hard disk (VHD), promote the server to a domain controller and then complete any additional configuration requirements. In a disaster recovery scenario, use the latest server backup to restore the first domain controller in a domain.

### Scenarios that benefit from virtual domain controller cloning

-   Rapid deployment of additional domain controllers in a new domain

-   Quickly restore business continuity during disaster recovery by restoring AD DS capacity via rapid deployment of domain controllers using cloning

-   Optimize private cloud deployments by leveraging elastic provisioning of domain controllers to accommodate increased scale requirements

-   Rapid provisioning of test environments enabling deployment and testing of new features and capabilities before production rollout

-   Quickly meet increased capacity needs in branch offices by cloning existing domain controllers in branch offices

When rapidly deploying a large number of domain controllers, continue to follow your existing procedures for validating the health of each domain controller after installation finishes. Deploy domain controllers in reasonably sized batches so you can validate their health after each batch of installations is complete. The recommended batch size is 10. For more information, see [Steps for deploying a clone virtualized domain controller](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#steps_deploy_vdc).

### Clear separation of responsibilities
The authorization to clone virtualized domain controllers is under the control of the AD DS administrator. In order for hypervisor administrators to deploy additional domain controllers by copying virtual domain controllers, the AD DS administrator has to select and authorize a domain controller and then run preparatory steps to enable it as a source for cloning.

With the virtual machine provisioning typically under the purview of the hypervisor administrator, hypervisor administrators can provision replica domain controller virtual machines by copying virtualized domain controllers that are authorized and prepared for cloning by the AD DS administrator.

> [!WARNING]
> Anyone allowed to administer the hypervisor that hosts a virtual domain controller must be highly trusted and audited in the environment.

### How does virtual domain controller cloning work?
The process of cloning involves making a copy of an existing virtual domain controller's VHD (or, for more complex configurations, the domain controller VM), authorizing it for cloning in AD DS and creating a clone configuration file. This reduces the number of steps and time involved in deploying a replica virtual domain controller by eliminating otherwise repetitive deployment tasks.

The clone domain controller uses the following criteria to detect that it is a copy of another domain controller:

1.  The value of the VM-Generation ID supplied by the virtual machine is different than the value of the VM-Generation ID stored in the DIT.

    > [!NOTE]
    > The hypervisor platform must support VM-Generation ID ( Windows Server 2012  Hyper-V supports VM-Generation ID).

2.  Presence of a file called DCCloneConfig.xml in one of the following locations:

    -   The directory where the DIT resides

    -   %windir%\NTDS

    -   The root of a removable media drive

Once the criteria are met, it goes through the process of cloning to provision itself as a replica domain controller.

The clone domain controller uses the security context of the source domain controller (the domain controller whose copy it represents) to contact the  Windows Server 2012  Primary Domain Controller (PDC) emulator operations master role holder (also known as flexible single master operations, or FSMO). The PDC emulator must be running  Windows Server 2012 , but it does not have to be running on a hypervisor.

> [!NOTE]
> If you have a schema extension with attributes that reference the source domain controller and the attribute is on one of the objects copied (computer object, NTDS settings object) to create the clone, that attribute will not be copied or updated to reference the clone domain controller.

After verifying that the requesting domain controller is authorized for cloning, the PDC emulator will create a new machine identity including new account, SID, name, and password that identifies this machine as a replica domain controller and send this information back to the clone. The clone domain controller will then prepare the AD DS database files to serve as a replica and it will also clean up the machine state.

For more information, see [Virtualized domain controller cloning architecture](../ad-ds/get-started/virtual-dc/Virtualized-Domain-Controller-Architecture.md#BKMK_CloneArch).

### Cloning components
The cloning components include new cmdlets in the Active Directory module for Windows PowerShell and associated XML files:

-   **New-ADDCCloneConfigFile** " This cmdlet creates and places DCCloneConfig.xml at the right location to ensure it is available to trigger cloning. It also performs prerequisite checks to ensure successful cloning. It is included in the Active Directory module for Windows PowerShell. You can run it locally on a virtualized domain controller that is being prepared for cloning, or you can run it remotely using the -offline option. You can specify settings for the clone domain controller, such as its name, site, and IP address.

    The prerequisite checks that it performs are:

    > [!NOTE]
    > The prerequisite checks are not performed when the "offline option is used. For more information, see [Running New-ADDCCloneConfigFile in offline mode](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#BKMK_OfflineMode).

    -   The DC being prepared is authorized for cloning (is a member of the **Cloneable Domain Controllers** group)

    -   The PDC emulator runs  Windows Server 2012 .

    -   Any programs or services listed from running **Get-ADDCCloningExcludedApplicationList** are included in CustomDCCloneAllowList.xml (explained in more detail at the end of this list of cloning components).

-   **DCCloneConfig.xml** " To successfully clone a virtualized domain controller, this file must be present in the directory where the DIT resides, *%windir%\NTDS*, or the root of a removable media drive. Besides being used as one of the triggers to detect and initiate cloning, it also provides a means to specify configuration settings for the clone domain controller.

    The schema and a sample file for the DCCloneConfig.xml file are stored on all  Windows Server 2012  computers at:

    -   %windir%\system32\DCCloneConfigSchema.xsd

    -   %windir%\system32\SampleDCCloneConfig.xml

    It is recommended that you use the New-ADDCCloneConfigFile cmdlet to create the DCCloneConfig.xml file. Although you could also use the schema file with an XML-aware editor to create this file, manually editing the file increases the likelihood of errors. If you edit the file, it must be done by using XML-aware editors, such as Visual Studio, [XML Notepad](http://www.microsoft.com/download/details.aspx?displaylang=en&id=7973), or third-party applications (do not use Notepad).

-   **Get-ADDCCloningExcludedApplicationList** " This cmdlet is run on the source domain controller before beginning the cloning process to determine which services or installed programs are not on the default supported list, DefaultDCCloneAllowList.xml, or a user-defined inclusion list named CustomDCCloneAllowList.xml file, and thereby have not been evaluated for cloning impact.

    This cmdlet searches the source domain controller for services in the Services Control Manager, and installed programs listed under **HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall** that are not specified in the default list (DefaultDCCloneAllowList.xml) or, if one is provided, the user-defined inclusion list (CustomDCCloneAllowList.xml file). The list of applications and services that is returned by running the cmdlet is the difference between what has already been provided in the DefaultDCCloneAllowList.xml or the CustomDCCloneAllowList.xml file and the list that is constructed at run time, based on what is installed on the source DC. The services and programs output from Get-ADDCCloningExcludedApplicationList can be added to the CustomDCCloneAllowList.xml file if you determine that the services and programs can be safely cloned. To determine if a service or installed program can be safely cloned, evaluate the following conditions:

    -   Is the service or installed program affected by the machine identity, such as name, SID, password, and so on?

    -   Does the service or installed program store any state locally on the computer that might affect its functionality on the clone?

    You must work with the software vendor of the application to determine if the service or program can be safely cloned.

    > [!NOTE]
    > Before provisioning additional services or programs in the CustomDCCloneAllowList.xml file, verify whether you have the necessary license to copy that software contained on that virtual machine.

    If the applications are not cloneable, remove them from the source domain controller before you create the clone media. If an application appears in the cmdlet output, but is not included in the CustomDCCloneAllowList.xml file, cloning will fail. For cloning to succeed, the cmdlet output should not list any services or programs. In other words, an application should either be included in the CustomDCCloneAllowList.xml file or removed from the source domain controller.

    The following table explains the options for running Get-ADDCCloningExcludedApplicationList.

    |||
    |-|-|
    |Argument|Explanation|
    |*<no argument specified>*|Displays a list of services or programs on the console that have not been accounted for cloning. If there is already a CustomDCCloneAllowList.XML in any of the permissible locations, it uses that file to displays the remaining services and programs (which may be nothing if the lists match).|
    |-GenerateXml|Creates the CustomDCCloneAllowList.XML file populated with the services and programs listed on the console.|
    |-Force|Overwrites an existing CustomDCCloneAllowList.XML file.|
    |-Path|Folder path to create the CustomDCCloneAllowList.XML.|

-   **DefaultDCCloneAllowList.xml** " This file is present by default on every  Windows Server 2012  domain controller in the *%windir%\system32*. It lists the services and installed programs that can be safely cloned by default. You must not change the location or contents of this file or cloning will fail.

-   **CustomDCCloneAllowList.xml** " If you have services or installed programs that reside on your source domain controller that are outside of those listed in the DefaultDCCloneAllowList.xml file, those services and programs must be included in this file. To find the services or installed programs that are not listed in the in the DefaultDCCloneAllowList.xml file, run the **Get-ADDCCloningExcludedApplicationList** cmdlet. You should use the **"GenerateXml** argument to generate the XML file.

    The cloning process checks the following locations in order for this file and uses the first XML file found, regardless of the other folder's contents:

    1.  The following registry key:

        ```
        HKey_Local_Machine\System\CurrentControlSet\Services\NTDS\Parameters
        AllowListFolder (REG_SZ)
        ```

    2.  DSA Working Directory

    3.  %systemroot%\NTDS

    4.  Removable read/write media, in order of drive letter, at the root of the drive

### Deployment scenarios
The following deployment scenarios are supported for virtual domain controller cloning:

-   Deploy a clone domain controller by making a copy of a source domain controller's virtual hard disk (vhd) file.

-   Deploy a clone domain controller by copying the virtual machine of a source domain controller using the export/import semantics exposed by the hypervisor.

> [!NOTE]
> The steps in the section [Steps for deploying a clone virtualized domain controller](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#steps_deploy_vdc) demonstrate copying a virtual machine using the export/import feature of  Windows Server 2012  Hyper-V.

## <a name="steps_deploy_vdc"></a>Steps for deploying a clone virtualized domain controller

-   [Prerequisites](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#prerequisites)

-   [Step 1: Grant the source virtualized domain controller the permission to be cloned](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#bkmk4_grant_source)

-   [Step 2: Run Get-ADDCCloningExcludedApplicationList cmdlet](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#bkmk6_run_get-addccloningexcludedapplicationlist_cmdlet)

-   [Step 3: Run New-ADDCCloneConfigFile](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#bkmk5_create_insert_dccloneconfig)

-   [Step 4: Export and then import the virtual machine of the source domain controller](../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md#bkmk7_export_import_vm_sourcedc)

### <a name="prerequisites"></a>Prerequisites

-   To complete the steps in the following procedures, you must be a member of the Domain Admins group or have the equivalent permissions assigned to it.

-   The Windows PowerShell commands used in this guide must be run from an elevated command prompt. To do this, right click the **Windows PowerShell** icon, and then click **Run as administrator**.

-   A  Windows Server 2012  server with the Hyper-V server role installed (**HyperV1**).

-   A second  Windows Server 2012  server with the Hyper-V server role installed (**HyperV2**).

    > [!NOTE]
    > -   If you are using another hypervisor, you should contact the vendor of that hypervisor to verify if the hypervisor supports VM-Generation ID. If the hypervisor does not support VM-Generation ID and you have provided a DCCloneConfig.xml, the new VM will boot into Directory Services Restore Mode (DSRM).
    > -   To increase the availability of the AD DS service, this guide recommends and provides instructions using two different Hyper-V hosts, which helps prevent a potentially single point of failure. However, you do not need two Hyper-V hosts to perform virtual domain controller cloning.
    > -   You need to be a member of the local Administrators group on each Hyper-V server (**HyperV1** and **HyperV2**).
    > -   In order to successfully import and export a VHD file using Hyper-V, the virtual network switches on both Hyper-V hosts should have the same name. For example, if you have a virtual network switch on **HyperV1** named VNet then there needs to be a virtual network switch on **HyperV2** named VNet.
    > -   If the two Hyper-V hosts (**HyperV1** and **HyperV2**) have different processors, shut down the virtual machine (**VirtualDC1**) that you plan to export, right-click the VM, click **Settings**, click **Processor**, and under **Processor compatibility** select **Migrate to a physical computer with a different processor version** and click **OK**.

-   A deployed  Windows Server 2012  domain controller (virtualized or physical) that hosts the PDC emulator role (**DC1**). To verify whether the PDC emulator role is hosted on a  Windows Server 2012  domain controller, run the following Windows PowerShell command:

    ```
    Get-ADComputer (Get-ADDomainController "Discover "Service "PrimaryDC").name "Property operatingsystemversion | fl
    ```

    The OperatingSystemVersion value should return as a version 6.2. If necessary, you can transfer the PDC emulator role to a domain controller that runs  Windows Server 2012 . For more information, see [Using Ntdsutil.exe to transfer or seize FSMO roles to a domain controller](http://support.microsoft.com/kb/255504).

-   A deployed  Windows Server 2012  guest virtualized domain controller (**VirtualDC1**) that is in the same domain as the  Windows Server 2012  domain controller hosting the PDC emulator role (**DC1**). This will be the source domain controller used for cloning. The guest virtual domain controller will be hosted on a  Windows Server 2012  Hyper-V server (**HyperV1**).

    > [!NOTE]
    > -   For cloning to succeed, the source domain controller that is used to create the clone cannot be from a DC that has been demoted since the source VHD media was created.
    > -   Shut down the source domain controller prior to copying the VM or its VHD.
    > -   You should not clone a VHD or restore a snapshot that is older than the tombstone lifetime value (or the deleted object lifetime value if Active Directory Recycle Bin is enabled). If you are copying a VHD of an existing domain controller, be sure the VHD file is not older that the tombstone lifetime value (by default, 60 days). You should not copy a VHD of a running domain controller to create clone media.

    Eject any virtual floppy drive (VFD) the source DC may have. This can cause a sharing problem when trying to import the new VM.

    Only  Windows Server 2012  domain controllers hosted on a VM-GenerationID hypervisor can be used as a source for cloning. The source  Windows Server 2012  domain controller used for cloning should be in a healthy state. To determine the state of the source domain controller run [dcdiag](http://technet.microsoft.com/library/cc731968(WS.10).aspx). To gain a better understanding of the output returned by dcdiag, see [What does DCDIAG actually...do?](http://blogs.technet.com/b/askds/archive/2011/03/22/what-does-dcdiag-actually-do.aspx).

    If the source domain controller is a DNS server, the cloned domain controller will also be a DNS server. You should choose a DNS server that hosts only Active Directory-integrated zones.

    DNS client settings are not cloned but are instead specified in the DCCloneConfig.xml file. If they are not specified, the cloned domain controller will point to itself as Preferred DNS server by default. The cloned domain controller will not have a DNS delegation. The administrator of the parent DNS zone should update the DNS delegation for the cloned domain controller as needed.

    > [!WARNING]
    > The virtualization safeguards do not extend to Active Directory Lightweight Directory Services (AD LDS). Therefore you should not attempt to clone an AD DS domain controller that hosts an AD LDS instance by adding this AD LDS instance to the CustomDCCloneAllowList.xml. Because AD LDS is not VM-Generation ID aware, cloning a domain controller with AD LDS can cause USN rollback-induced divergence on that AD LDS configuration set.

    The following server roles are not supported for cloning:

    -   Dynamic Host Configuration Protocol (DHCP)

    -   Active Directory Certificate Services (AD CS)

    -   Active Directory Lightweight Directory Services (AD LDS)

### <a name="bkmk4_grant_source"></a>Step 1: Grant the source virtualized domain controller the permission to be cloned
In this procedure, you grant the source domain controller the permission to be cloned by using **Active Directory Administrative Center** to add the source domain controller to the **Cloneable Domain Controllers** group.

##### To grant the source virtualized domain controller the permission to be cloned

1.  On any domain controller in the same domain as the domain controller being prepared for cloning (**VirtualDC1**), open **Active Directory Administrative Center** (ADAC), locate the virtualized domain controller object (domain controllers are usually located under the **Domain Controllers** container in ADAC), right click it, choose **Add to group** and under **Enter the object name to select** type **Cloneable Domain Controllers** and then click **OK**.

    The group membership update performed in this step must replicate to PDC emulator before cloning can be performed. If the **Cloneable Domain Controllers** group is not found, the PDC emulator role might not be hosted on a domain controller that runs  Windows Server 2012 .

    > [!NOTE]
    > To open ADAC on a  Windows Server 2012  domain controller, open Windows PowerShell and type **dsac.exe**.

![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

The following Windows PowerShell cmdlet performs the same function as the preceding procedure:


    Add-ADGroupMember "Identity "CN=Cloneable Domain Controllers,CN=Users, DC=Fabrikam,DC=Com" "Member "CN=VirtualDC1,OU=Domain Controllers,DC=Fabrikam,DC=com"


### <a name="bkmk6_run_get-addccloningexcludedapplicationlist_cmdlet"></a>Step 2: Run Get-ADDCCloningExcludedApplicationList cmdlet
In this procedure, run the `Get-ADDCCloningExcludedApplicationList` cmdlet on the source virtualized domain controller to identify any programs or services that are not evaluated for cloning. You need to run the Get-ADDCCloningExcludedApplicationList cmdlet before the New-ADDCCloneConfigFile cmdlet because if the New-ADDCCloneConfigFile cmdlet detects an excluded application, it will not create a DCCloneConfig.xml file.

##### To identify applications or services that run on a source domain controller which have not been evaluated for cloning

1.  On the source domain controller (**VirtualDC1**), click **Server Manager**, click **Tools**, click **Active Directory Module for Windows PowerShell** and then type the following command:


    Get-ADDCCloningExcludedApplicationList


2.  Vet the list of the returned services and installed programs with the software vendor to determine whether they can be safely cloned. If applications or services in the list cannot be safely cloned, you must remove them from the source domain controller or cloning will fail.

3.  For the set of services and installed programs that were determined to be safely cloned, run the command again with the **"GenerateXML** switch to provision these services and programs in the **CustomDCCloneAllowList.xml** file.


    Get-ADDCCloningExcludedApplicationList -GenerateXml


### <a name="bkmk5_create_insert_dccloneconfig"></a>Step 3: Run New-ADDCCloneConfigFile
Run New-ADDCCloneConfigFile on the source domain controller, and optionally specify configuration settings for the clone domain controller, such as the name, the IP address, and DNS resolver.

For example, to create a clone domain controller named VirtualDC2 with a static IPv4 address, type:


    New-ADDCCloneConfigFile "Static -IPv4Address "10.0.0.2" -IPv4DNSResolver "10.0.0.1" -IPv4SubnetMask "255.255.255.0" -CloneComputerName "VirtualDC2" -IPv4DefaultGateway "10.0.0.3" -SiteName "REDMOND"

> [!NOTE]
> The clone domain controller will be located in the same site as the source domain controller unless a different site is specified in the DCCloneConfig.xml file. It is recommended that you specify a suitable site in the DCCloneConfig.xml file for the clone domain controller based on its IP address.

The computer name is optional. If you do not specify one, a unique name will be generated based on the following algorithm:

-   The prefix is the first 8 characters of the source domain controller computer name. For example, a source computer name of SourceComputer is truncated to a prefix string of SourceCo.

-   A unique naming suffix of the format ""CL*nnnn*" is appended to the prefix string where *nnnn* is the next available value from 0001-9999 that the PDC determines is not currently in use. For example, if 0047 is the next available number in the allowed range, using the preceding example of the computer name prefix SourceCo, the derived name to use for the clone computer will be set as SourceCo-CL0047.

> [!NOTE]
> A global catalog server (GC) is required for the New-ADDCCloneConfigFile cmdlet to work successfully. The source domain controller's membership in the **Cloneable Domain Controllers** group must be reflected on the GC. The GC does not need to be the same domain controller as the PDC emulator, but preferably it should be in the same site. If a GC is not available, the command fails with the error "The server is not operational." For more information, see [Virtualized Domain Controller Troubleshooting](../ad-ds/manage/virtual-dc/Virtualized-Domain-Controller-Troubleshooting.md).

To create a clone domain controller named Clone1 with static IPv4 settings and specify preferred and alternate WINS servers, type:


    New-ADDCCloneConfigFile "CloneComputerName "Clone1" "Static -IPv4Address "10.0.0.5" "IPv4DNSResolver "10.0.0.1" "IPv4SubnetMask "255.255.0.0" "PreferredWinsServer "10.0.0.1" "AlternateWinsServer "10.0.0.2"


> [!NOTE]
> If you specify WINS servers, you must specify both **"PreferredWINSServer** and **"AlternateWINSServer**. If you specify only of those arguments, cloning fails with error code 0x80041005 appearing in the dcpromo.log.

To create a clone domain controller named Clone2 with dynamic IPv4 settings, type:


    New-ADDCCloneConfigFile -CloneComputerName "Clone2" -IPv4DNSResolver "10.0.0.1" 


> [!NOTE]
> In this case, there should be a DHCP server in the environment that the clone can reach and obtain IP address and other relevant network settings.

To create a clone domain controller named Clone2 with dynamic IPv4 settings and specify preferred and alternate WINS servers, type:


    New-ADDCCloneConfigFile -CloneComputerName "Clone2" -IPv4DNSResolver "10.0.0.1" -SiteName "REDMOND" "PreferredWinsServer "10.0.0.1" "AlternateWinsServer "10.0.0.2"


To create a clone domain controller with dynamic IPv6 settings, type:


    New-ADDCCloneConfigFile -IPv6DNSResolver "2002:4898:e0:31fc:d61:2b0a:c9c9:2ccc"


To create a clone domain controller with static IPv6 settings, type:


    New-ADDCCloneConfigFile "Static -IPv6DNSResolver "2002:4898:e0:31fc:d61:2b0a:c9c9:2ccc"


> [!NOTE]
> When specifying IPv6 settings, the only difference between the static and dynamic settings is the inclusion of **-Static** switch. The inclusion of the **-Static** switch makes it mandatory to specify at least one **IPv6DNSResolver**.The static IPv6 address is expected to be configured via stateless address auto configuration (SLAAC) with router assigned prefixes. With dynamic IPv6, the DNS resolvers are optional, but it's expected that the clone can reach an IPv6-enabled DHCP server on the subnet to obtain IPv6 address and DNS configuration information.

#### <a name="BKMK_OfflineMode"></a>Running New-ADDCCloneConfigFile in offline mode
If you have multiple copies of source domain controller media that have been prepared for cloning (meaning the source domain controller is authorized for cloning, the Get-ADDCCloningExcludedApplicationList cmdlet has been run, and so on) and you want to specify different settings for each copy of the media, you can run New-ADDCCloneConfigFile in offline mode. This can be more efficient than individually preparing each VM, for example, by importing each copy.

In this case, domain administrators can mount the offline disk and use Remote Server Administration Tools (RSAT) to run the New-ADDCCloneConfigFile cmdlet with the -offline argument in order to add the XML files, which allows for factory-like automation using new Windows PowerShell options included in Windows Server 2012. For more information about how to mount the offline disk in order to run the New-ADDCCloneConfigFile cmdlet in offline mode, see [Adding XML to the Offline System Disk](../ad-ds/get-started/virtual-dc/Virtualized-Domain-Controller-Deployment-and-Configuration.md#BKMK_Offline).

You should first run the cmdlet locally on the source media to ensure that prerequisite checks pass. The prerequisite checks are not performed in offline mode because the cmdlet could be run from a machine that may not be from the same domain or from a domain-joined computer. After you run the cmdlet locally, it will create a DCCloneConfig.xml file. You may delete the DCCloneConfig.xml that is created locally if you plan to use the offline mode subsequently.

To create a clone domain controller named CloneDC1 in offline mode, in a site called REDMOND" with static IPv4 address, type:


    New-ADDCCloneConfigFile -Offline -CloneComputerName CloneDC1 -SiteName REDMOND -IPv4Address "10.0.0.2" -IPv4DNSResolver "10.0.0.1" -IPv4SubnetMask "255.255.0.0" -IPv4DefaultGateway "10.0.0.1" -Static -Path F:\Windows\NTDS


To create a clone domain controller named Clone2 in offline mode with static IPv4 and static IPv6 settings, type:


    New-ADDCCloneConfigFile -Offline -IPv4Address "10.0.0.2" -IPv4DNSResolver "10.0.0.1" -IPv4SubnetMask "255.255.0.0" -Static -IPv6DNSResolver "2002:4898:e0:31fc:d61:2b0a:c9c9:2ccc" -CloneComputerName "Clone2" -PreferredWINSServer "10.0.0.1" -AlternateWINSServer "10.0.0.3" -Path F:\Windows\NTDS


To create a clone domain controller in offline mode with static IPv4 and dynamic IPv6 settings and specify multiple DNS servers for the DNS resolver settings, type:


    New-ADDCCloneConfigFile -Offline -IPv4Address "10.0.0.10" -IPv4SubnetMask "255.255.0.0" -IPv4DefaultGateway "10.0.0.1" -IPv4DNSResolver @( "10.0.0.1","10.0.0.2" ) -Static -IPv6DNSResolver "2002:4898:e0:31fc:d61:2b0a:c9c9:2ccc" -Path F:\Windows\NTDS 


To create a clone domain controller named Clone1 in offline mode with dynamic IPv4 and static IPv6 settings, type:


    New-ADDCCloneConfigFile -Offline -Static -IPv6DNSResolver "2002:4898:e0:31fc:d61:2b0a:c9c9:2ccc" -CloneComputerName "Clone1" -PreferredWINSServer "10.0.0.1" -AlternateWINSServer "10.0.0.3" -SiteName "REDMOND" -Path F:\Windows\NTDS


To create a clone domain controller in offline mode with dynamic IPv4 and dynamic IPv6 settings, type:


    New-ADDCCloneConfigFile -Offline -IPv4DNSResolver "10.0.0.1" -IPv6DNSResolver "2002:4898:e0:31fc:d61:2b0a:c9c9:2ccc" -Path F:\Windows\NTDS


### <a name="bkmk7_export_import_vm_sourcedc"></a>Step 4: Export and then import the virtual machine of the source domain controller
In this procedure, export the virtual machine of the source virtualized domain controller and then import the virtual machine. This action creates a clone virtualized domain controller in your domain.

You need to be a member of the local Administrators group on each Hyper-V host. If you use different credentials for each server, run the Windows PowerShell cmdlets to export and import the VM in different Windows PowerShell sessions.

If there are snapshots on the source domain controller, they should be deleted before the source domain controller is exported because the VM will not import if a snapshot has processor settings that are incompatible with the target hyper-v host. If the processor settings are compatible between the source and target hyper-v hosts, you may export and copy the source without deleting snapshots beforehand. After import, however, the snapshots must be deleted from the clone VM before it starts.

##### To copy a virtual domain controller by exporting and then importing the virtualized source domain controller

1.  On **HyperV1**, shutdown the source domain controller (**VirtualDC1**).

    ![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

    Stop-VM -Name VirtualDC1 -ComputerName HyperV1


2.  On **HyperV1**, delete snapshots and then export the source domain controller (VirtualDC1) to the c:\CloneDCs directory.

> [!NOTE]
> You should delete all the associated snapshots because each time a snapshot is taken, a new AVHD file is created that acts as differencing disk. This creates a chain affect. If you have taken snapshots and insert the DCCLoneConfig.xml file into the VHD, you may end up creating a clone from an older DIT version or inserting the configuration file into the wrong VHD file. Deleting the snapshot merges all these AVHDs into the base VHD.

![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****


    Get-VMSnapshot VirtualDC1 | Remove-VMSnapshot -IncludeAllChildSnapshots
    Export-VM -Name VirtualDC1 -ComputerName HyperV1 -Path c:\CloneDCs\VirtualDC1


3.  Copy the folder **virtualdc1** to the c:\Import directory of **HyperV2**.

4.  On **HyperV2**, using **Hyper-V Manager**, import the virtual machine (using the **Import Virtual Machine** wizard in **Hyper-V Manager**) from the folder **c:\Import\virtualdc1** and delete all associated **Snapshots**.

Use the **Copy the virtual machine (create new unique ID)** option when importing the virtual machine.

![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

    $path = Get-ChildItem "C:\CloneDCs\VirtualDC1\VirtualDC1\Virtual Machines"
    $vm = Import-VM -Path $path.fullname -Copy -GenerateNewId
    Rename-VM $vm VirtualDC2


To create multiple clone domain controllers from the same source domain controller:

  -   UI: in the **Import Virtual Machine** wizard, specify new locations for **Virtual machine configuration folder**, **Snapshot store**, **Smart Paging folder**, and a different **Location** for the virtual hard disks for the virtual machine.

  -   Windows PowerShell: specify new locations for the virtual machine by using the following parameters for the `Import-VM` cmdlet:

        $path = Get-ChildItem "C:\CloneDCs\VirtualDC1\VirtualDC1\Virtual Machines" 
        Import-VM -Path $path.fullname -Copy -GenerateNewId -ComputerName HyperV2 -VhdDestinationPath "path" -SnapshotFilePath "path" -SmartPagingFilePath "path" -VirtualMachinePath "path"


> [!NOTE]
> The recommended batch size for creating multiple clone domain controllers simultaneously is 10. The maximum number is restricted by the maximum number of outbound replication connections, which by default is 16 for Distributed File System Replication (DFSR) and 10 for File Replication Service (FRS). You should not deploy more than the recommended number of clone domain controllers simultaneously unless you have thoroughly tested that number for your environment.

5.  On **HyperV1**, restart the source domain controller (**(VirtualDC1**) to bring it back online.

![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****

    Start-VM -Name VirtualDC1 -ComputerName HyperV1


6.  On **HyperV2**, start the virtual machine (**VirtualDC2**) to bring it online as a clone domain controller in the domain.

![Intro to AD DS](../media/Introduction-to-Active-Directory-Domain-Services--AD-DS--Virtualization--Level-100-/PowerShellLogoSmall.gif)****Windows PowerShell equivalent commands****


    Start-VM -Name VirtualDC2 -ComputerName HyperV2

> [!NOTE]
> The PDC emulator must be running for cloning to succeed. If it was shutdown, make sure it has started and performed initial synchronization so it is aware that is holds the PDC emulator role. For more information, see Microsoft [KB article 305476](http://support.microsoft.com/kb/305476).

After cloning completes, verify the name of the clone computer to ensure the cloning operation succeeded. Verify that the VM did not start in Directory Services Restore Mode (DSRM). If you try to log on and receive an error indicating no logon servers are available, try logging on in DSRM. If the DC did not clone successfully and it is booted in DSRM, check the logs in Event Viewer and dcpromo logs in the %systemroot%/debug folder.

The cloned domain controller will be a member of the **Cloneable Domain Controllers** group because it copies the membership from the source domain controller. As a best practice, you should leave the **Cloneable Domain Controllers** group empty until you are ready to perform cloning operations, and you should remove members after cloning operations are complete.

If the source domain controller stores a backup media, the cloned domain controller will also store the backup media. You can run `wbadmin get versions` to show the backup media on the cloned domain controller. A member of the Domain Admins group should delete the backup media on the cloned domain controller to prevent it from being accidentally restored. For more information about how to delete a system state backup using wbadmin.exe, see [Wbadmin delete systemstatebackup](http://technet.microsoft.com/library/cc742081(v=WS.10).aspx).

## <a name="troubleshooting"></a>Troubleshooting
If the clone domain controller (**VirtualDC2**) starts in Directory Services Restore Mode (DSRM), it does not return to a normal mode on its own on the next reboot. To log on to a domain controller that is started in DSRM, use **.\Administrator** and specify the DSRM password.

Correct the cause for cloning failure and verify that the dcpromo.log does not indicate that cloning cannot be re-tried. If cloning cannot be re-tried, safely discard the media. If cloning can be re-tried, you must remove the DS Restore Mode boot flag in order to try cloning again.

1.  Open  Windows Server 2012  with an elevated command (right click  Windows Server 2012  and choose Run as Administrator), and then type **msconfig**.

2.  On the **Boot** tab, under **Boot Options**, clear **Safe boot** (it is already selected with the option **Active Directory repair enabled**).

3.  Click **OK** and restart when prompted.

For more troubleshooting information about virtualized domain controllers, see [Virtualized Domain Controller Troubleshooting](../ad-ds/manage/virtual-dc/Virtualized-Domain-Controller-Troubleshooting.md).



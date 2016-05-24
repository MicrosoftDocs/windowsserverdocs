---
title: Validate Hardware for a Failover Cluster in Windows Server Threshold
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 49bf5312-d376-498c-b6f2-d95a95a7f4c0
---
# Validate Hardware for a Failover Cluster in Windows Server Threshold
You can use the Validate a Configuration Wizard, which is integrated in Failover Cluster Manager, or the [Test-Cluster](http://technet.microsoft.com/library/hh847274)[!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet, to run a set of focused validation tests. You can run this process on a collection of servers that you intend to use as nodes in a cluster. This tests the underlying hardware and software, directly and individually, to obtain an accurate assessment of how well Failover Clustering can be supported in a given configuration.  
  
> [!IMPORTANT]  
> A cluster validation report is required by Microsoft as a condition of Microsoft support for a given configuration.  
  
This topic provides steps to validate the hardware for a failover cluster.  
  
|Task|Description|  
|--------|---------------|  
|[Step 1: Prepare to validate hardware for a failover cluster](#BKMK_PREPARE)|Learn about cluster validation and Microsoft support for a cluster configuration, and prepare your hardware for the validation tests.|  
|[Step 2: Validate a new or existing failover cluster](#BKMK_RUN_TESTS)|Run the Validate a Configuration Wizard or the [Test-Cluster](http://technet.microsoft.com/library/hh847274)[!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet.|  
|[Step 3: Analyze validation results](#BKMK_VALIDATION_RESULTS)|Review the Summary Report that is created when validation completes. If there are failures and you need support, prepare a validation report for Microsoft Customer Service and Support.|  
|[Advanced validation scenarios](#BKMK_CHOOSE_TESTS)|Review these advanced scenarios if you need to validate an existing cluster and choose to test only certain aspects of cluster functionality.|  
|[Frequently asked questions](#BKMK_FAQ)|Get answers to your questions about the cluster validation process.|  
  
## <a name="BKMK_PREPARE"></a>Step 1: Prepare to validate hardware for a failover cluster  
  
### What is cluster validation?  
The Validate a Configuration Wizard or the [Test-Cluster](http://technet.microsoft.com/library/hh847274)[!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet enables you to run a set of focused tests on a collection of servers, networks, and associated storage that are planned for use as a failover cluster. The cluster validation process tests the underlying hardware and software to obtain an accurate assessment of how well Failover Clustering can be supported in a given configuration.  
  
Before you create a failover cluster, we strongly recommend that you run all the cluster validation tests.  
  
Cluster validation is intended to do the following:  
  
-   Find hardware or configuration issues before a failover cluster goes into production.  
  
-   Help ensure that the clustering solution you deploy is dependable.  
  
-   Provide a way to validate changes to the hardware of an existing cluster.  
  
-   Perform diagnostic tests on an existing cluster.  
  
### <a name="BKMK_SUPPORT"></a>Supported cluster configurations  
For Microsoft Customer Service and Support to officially support a failover cluster in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the cluster solution must meet the following criteria:  
  
-   All hardware and software components must meet the qualifications for the appropriate logo. For [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], this is the "Certified for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]" logo. For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], this is the "Certified for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]" logo. For more information, see [Logo Program Requirements and Policies](http://go.microsoft.com/fwlink/p/?LinkId=111561) on the Microsoft website. The following are descriptions of the logos.  
  
    -   **Certified [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Systems**  
  
        The Certified for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] logo demonstrates that a server system meets Microsoft’s highest technical bar for security, reliability and manageability; and with other certified devices and drivers, it can support the roles, features and interfaces for Cloud and Enterprise workloads, as well as business critical applications.  
  
    -   **Certified [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Devices**  
  
        The Certified for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] logo demonstrates that a server system meets Microsoft’s highest technical bar for security, reliability and manageability; and with other certified devices and drivers, it can support the roles, features and interfaces for Cloud and Enterprise workloads, as well as business critical applications.  
  
    -   **Certified for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Devices**  
  
        Designed for line\-of\-business and mission\-critical applications, the Certified for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] logo demonstrates that your solution meets Microsoft’s highest technical bar for Windows fundamentals and platform compatibility.  
  
    -   **Certified [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Systems**  
  
        Designed for cloud and infrastructure workloads, as well as business critical applications, the Microsoft Certified for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] logo demonstrates that a server system meets Microsoft’s highest technical bar for security, reliability, and manageability, and with any required hardware components, can support all the roles, features, and interfaces that are supported by [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The fully configured system \(servers, network, and storage\) must pass all the required tests in the Validate a Configuration Wizard, which you can run from Failover Cluster Manager. Alternatively, you can run the validation tests using the [Test-Cluster](http://technet.microsoft.com/library/hh847274)[!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet.  
  
Microsoft support policies are also described at the [Microsoft Support](http://support.microsoft.com/kb/2775067) website.  
  
### <a name="BKMK_validation_scenarios"></a>Common validation scenarios  
The following lists describe scenarios in which hardware validation is required or is useful. In general, you need to run all the validation tests \(some exceptions are noted\).  
  
-   **Validation before the cluster is configured**  
  
    -   **A set of servers ready to become a failover cluster**  
  
        This is the most straightforward validation scenario. The hardware components \(systems, networks, and storage\) are connected, but the systems are not functioning as a cluster. Running tests in this situation has no impact on availability.  
  
    -   **Cloned or imaged systems**  
  
        With systems that you have cloned or imaged to different hardware, you must run the Validate a Configuration Wizard as you would with any new cluster. We recommend that you run the wizard just after you connect the hardware components and install the Failover Clustering feature, before the cluster is used by clients.  
  
    -   **Virtualized servers**  
  
        With virtualized servers in a cluster, run the Validate a Configuration Wizard as you would with any new cluster. The requirement for running the wizard is the same whether you have a "host cluster" \(failover occurs between two physical computers\), a "guest cluster" \(failover occurs between guest operating systems on the same physical computer\), or some other configuration that includes one or more virtualized servers.  
  
-   **Validation when the cluster has only one node**  
  
    You might want to run a limited number of validation tests on a single server that you intend to use in a cluster. Some tests cannot be run in this situation; for example, tests that confirm the software and software updates match between servers, and storage tests that simulate failover between nodes. You must have at least two nodes in a cluster before you can complete the cluster validation process. So if you bring more servers into the configuration, you must run the Cluster Validation Wizard again so that all the tests can be complete.  
  
-   **Validation after the cluster is configured and in use**  
  
    -   **To confirm validation for Microsoft support, or to rule out configuration problems**  
  
        If you need support from Microsoft, you may be required to you provide the validation report from the wizard. If you have not already run the wizard and saved the report, you might need to take the cluster offline to run the wizard. The report shows whether your configuration is supported, and it can help Microsoft customer support troubleshoot configuration issues with hardware, drivers, and the basic system configuration.  
  
    -   **Before adding a node**  
  
        When you add a server to a cluster, we strongly recommend that you start by connecting the server to the cluster networks and storage and then run the Validate a Configuration Wizard, specifying the existing cluster nodes and the new node.  
  
    -   **When attaching new storage**  
  
        When you attach new storage to the cluster \(which is different than exposing a new logical unit number \(LUN\) in existing storage\), you must run the Validate a Configuration Wizard to confirm that the new storage will function correctly. To minimize the impacts to availability, we recommend that you run the wizard after you attach the storage, and before you begin to use the new LUNs in clustered services or applications.  
  
    -   **When making changes that affect firmware or drivers**  
  
        If you want to upgrade or make other changes to the cluster that would require changing the firmware or drivers, you must run the Validate a Configuration Wizard to confirm that the new combination of hardware, firmware, drivers, and software supports your failover cluster functionality. If the change affects the firmware or drivers for storage, we recommend that you keep a small LUN available \(unused by clustered roles\) so that you can run the storage validation tests without taking your clustered roles offline.  
  
    -   **After restoring a system from backup**  
  
        After you restore a system from backup, run the Validate a Configuration Wizard to confirm that the system can function properly as part of a cluster. The system is not considered a supported system until the validation tests are completed.  
  
When you validate hardware changes to an existing cluster \(as an advanced scenario\), you might decide to omit certain storage tests. For more information and considerations, see [Advanced Validation Scenarios](#BKMK_CHOOSE_TESTS).  
  
### Categories of validation tests  
The following table lists the categories of validation tests. The tests in each category are listed at the time you run the Validate a Configuration Wizard. A description of each test in each category is provided in the validation report that is saved after validation completes.  
  
|Category|Description|  
|------------|---------------|  
|Cluster configuration|Lists and validates the resources that are configured for use in a cluster, including clustered roles and cluster volumes.|  
|Hyper\-V configuration|Validates the Hyper\-V configuration for use in a failover cluster. **Note:** Hyper\-V configuration tests are only required if you use or plan to use clustered virtual machines.|  
|Inventory|Lists host bus adapters \(HBAs\), devices, processes, and drivers that are in use on the computers in the cluster.|  
|Network|Validates the configuration of the cluster networks, IP addresses, and Windows Firewall.|  
|Storage|Validates storage disks and file systems that are available for use in a failover cluster.|  
|System configuration|Validates operating systems, update levels, and service settings on the computers in the cluster.|  
  
## <a name="BKMK_RUN_TESTS"></a>Step 2: Validate a new or existing failover cluster  
This step provides procedures for running the Validate a Configuration Wizard or the [Test-Cluster](http://technet.microsoft.com/library/hh847274)[!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet to validate a new or existing failover cluster.  
  
> [!IMPORTANT]  
> To begin the process of adding hardware \(such as an additional server\) to a failover cluster, connect the hardware to the failover cluster. Then run the Validate a Configuration Wizard, and specify all servers that you want to include in the cluster. The wizard tests cluster connectivity and failover, not only isolated components \(such as individual servers\).  
  
#### To run the Validate a Configuration Wizard  
  
1.  Identify the server or servers that you want to test.  
  
    -   If the cluster does not yet exist, choose the servers that you want to include in the cluster, and make sure that you have installed the Failover Clustering feature on those servers. If the feature is not installed, see the [installation instructions](http://go.microsoft.com/fwlink/p/?LinkId=253342).  
  
    -   If the cluster already exists, make sure that you know the name of the cluster or a node in the cluster.  
  
2.  Review the cluster requirements for the hardware for the network or the storage that you want to validate, and confirm that it is connected to the servers.  
  
3.  Decide whether you want to run all or only some of the available validation tests. In general, we recommend that you run all the tests, but the follow general guidelines can help you decide.  
  
    |Type of cluster|Validation tests|  
    |-------------------|--------------------|  
    |New or planned cluster with all hardware connected|All tests|  
    |New or planned cluster with parts of the hardware connected|System Configuration tests, Inventory tests, and tests that apply to the hardware that is connected \(that is, network tests if the network is connected or storage tests if the storage is connected\)|  
    |Existing cluster to which you plan to add a server|All tests **Note:** Before you run the tests, be sure to connect the networks and storage for all servers that you plan to have in the cluster.|  
    |Troubleshooting an existing cluster|All tests, although you could run only the tests that relate to the apparent issue.|  
  
    > [!IMPORTANT]  
    > If a clustered role is using a disk when you start the wizard, the wizard will prompt you about whether to take that clustered role offline for the purposes of testing. If you choose to take a clustered role offline, it will remain offline until the tests finish.  
  
4.  To open the wizard, in Failover Cluster Manager, under **Actions**, click **Validate Configuration**.  
  
5.  Follow the instructions in the wizard to specify the servers \(in a planned cluster\) and the tests. For example, if you do not plan to use cluster features that require Hyper\-V, you can omit the Hyper\-V Configuration tests. The wizard then guides you to run the tests.  
  
    > [!NOTE]  
    > When you run the wizard on unclustered servers, you must enter the names of all the servers that you want to test, not only one.  
  
6.  The **Summary** page appears after the tests run. On the **Summary** page, click **View Report** to view the test results.  
  
    To view the results of the tests after you close the wizard, under **Actions** in Failover Cluster Manager, click **View Validation Report**. You can see %SystemRoot%\\Cluster\\Reports\\Validation Report *date and time***.html** where %SystemRoot% is the folder in which the operating system is installed \(for example, C:\\Windows\).  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following example runs all cluster validation tests on the nodes named *node1* and *node2*. If *node1* or *node2* is already a member of a cluster, the tests will include all nodes in that cluster.  
  
```powershell  
Test-Cluster -Node node1,node2  
```  
  
## <a name="BKMK_VALIDATION_RESULTS"></a>Step 3: Analyze validation results  
After the Validate a Configuration Wizard has completed, the Failover Cluster Validation Report displays the results. All tests must pass with a green check mark, or in some cases, a yellow triangle \(warning\). The following table shows the symbols in the summary and explains what they mean:  
  
|Symbol|Explanation|  
|----------|---------------|  
|![](../Image/FOCVal_suc.gif)|The corresponding validation test passed, indicating that this aspect of the cluster can be supported.|  
|![](../Image/FOCVal_Warn.gif)|The corresponding validation test produced a warning, indicating that this aspect of the cluster can be supported, but it might not meet the recommended best practices, and it should be reviewed. Microsoft customer support might ask you to investigate or address the issue if it appears to be directly linked to something that you are troubleshooting.|  
|![](../Image/FOCVal_Fail.gif)|The corresponding validation test failed, and this aspect of the cluster is not supported. You must correct the issue before you can create a failover cluster that is supported.|  
|![](../Image/FOCVal_NR.gif)|The corresponding validation test was canceled. This can occur when the test depended on another test that did not complete successfully.|  
  
When you look for problem areas \(warning or failures\), in the test results summary, click an individual test to review the details. Also review the summary statement for information about whether the cluster is a supported configuration.  
  
After you take action to correct the problem, you can rerun the wizard as needed to confirm that the configuration passes the tests.  
  
### <a name="BKMK_if_fail"></a>What to do if a validation test fails  
In most cases, if any tests in the Validate a Configuration Wizard fail, Microsoft does not consider the configuration to be supported.  
  
If any of the Hyper\-V Configuration tests fail, Hyper\-V on the cluster is not configured correctly. The problem must be corrected before the virtual machines in the cluster can be supported. However, failures in this category of tests do not mean that the cluster is not supported for workloads other than clustered virtual machines.  
  
The type of test that fails is a guideline to the corrective action to take. For example, if the **List All Disks** storage test fails, and subsequent storage tests do not run \(because they would also fail\), you should contact the storage vendor to troubleshoot this issue. Similarly, if a network test that is related to IP addresses fails, consult your network infrastructure team. Not all warnings or errors indicate a need to call Microsoft customer support. Most of the warnings or errors should result in working with internal teams or with a specific hardware vendor.  
  
For information about correcting failures that are listed in a validation report, see the previous section, [Understanding validation results](#BKMK_VALIDATION_RESULTS).  
  
After the issues have been addressed and resolved, it is necessary to rerun the Validate a Configuration Wizard. To be considered a supported configuration, all tests are required to run and complete without failures.  
  
### <a name="BKMK_PROVIDE_REPORT"></a>Provide a validation report when you request support from Microsoft  
If you need to contact Microsoft customer support about a validation problem, the support team will help you collect the validation report and other relevant configuration files by using the Microsoft Support Diagnostic Tool \(MSDT\). \(This feature replaces the MPSReports data collection utility.\) If needed, Microsoft will send instructions about how to capture the data. In some situations, Microsoft may request that the contents of the C:\\Windows\\Cluster\\Reports folder be zipped and sent for analysis. Either method will collect the required cluster validation report.  
  
### Updates to validation tests  
The Validate a Configuration Wizard provides an accurate picture of how well failover clustering can be supported for a given configuration. If an update to the Validate a Configuration Wizard becomes available, you may need to rerun the wizard and pass all tests for your configuration to continue to be supported. This may result in some solutions that previously passed to fail. The issues that are reported in the updated tests will need to be addressed in the same manner as outlined in this guide.  
  
## <a name="BKMK_CHOOSE_TESTS"></a>Advanced validation scenarios  
When you make a change to an existing cluster, you might not need to run all the cluster validation tests. The following tables in this section list the kinds of changes you might make to a cluster and the corresponding tests to run.  
  
**Key for the required validation tests shown in the following tables**  
  
-   **Full**: Run the complete set of tests. This requires some cluster downtime.  
  
-   **Single LUN**: Run the complete set of tests, and run the storage tests on only one LUN. The LUN might be a small LUN that you set aside for testing purposes or the witness disk \(if your cluster uses a witness disk\). This validates the storage subsystem, but not specifically each individual LUN or disk. You can run these validation tests without causing downtime to your clustered services or applications.  
  
-   **Omit storage tests**: Run the system configuration, inventory, and network tests, but not the storage tests. You can run these validation tests without causing downtime to your clustered roles.  
  
-   **None**: No validation tests are needed.  
  
### Server changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Physically replacing or changing a server that is used in the cluster|Full|  
|Adding or removing CPUs|None|  
|Adding or removing RAM on a server|None|  
|Adding, removing, or replacing a network adapter|Omit storage tests|  
|Updating firmware or an existing network driver|Omit storage tests|  
|Changing the BIOS settings or firmware version|None|  
|Adding or changing peripheral devices other than network or storage components, such as CD\-ROM or DVD drives, tape drives, video cards, sound devices, and USB devices|None|  
  
### Operating system changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Applying operating system service pack, software updates, or hotfixes that affect the storage stack|Single LUN|  
|Applying software updates or hotfixes that do not affect the storage stack|Omit storage tests|  
|Installing an application that has no kernel mode or filter drivers|None|  
|Changing or adding new kernel mode drivers|Single LUN|  
  
### Cluster configuration changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Adding a new node to the cluster|Full|  
|Adding a new node that uses dissimilar hardware|Full|  
|Removing a node from the cluster|None|  
|Changing the quorum configuration|None|  
  
### Shared storage changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Changing or adding a storage array|Full|  
|Adding another SCSI hardware RAID unit of the same type, and that unit uses an HBA that is already in the configuration|Single LUN|  
|Making a minor \(0.x\) revision to the storage firmware|Single LUN|  
|Making a major \(X.0\) revision to the storage firmware|Single LUN|  
|Presenting a new disk or LUN to a cluster|Full, but test new LUNs only|  
  
### SAN \(switch\/hub\) changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Adding or replacing a Fibre Channel switch or hub|Full|  
|Changing the number of ports within a switch block|None|  
|Making a minor \(0.x\) revision to the Fibre Channel switch firmware|Single LUN|  
|Making a major \(X.0\) revision to the Fibre Channel switch firmware|Single LUN|  
|Changing a switch configuration or zoning|Full, but test changed LUNs only|  
  
### Host bus adapter \(HBA\) changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Replacing an HBA \(same or different type\)|Full|  
|Adding a new HBA \(same or different type\)|Single LUN|  
|Changing the HBA firmware or BIOS|Single LUN|  
|Changing the HBA driver version|Single LUN|  
  
### Multipath software changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Changing from single path to multipath or multipath to single path|Full|  
|Adding a path|Single LUN|  
|Removing a path|Single LUN|  
|Updating the device specific module \(DSM\) version|Single LUN|  
|Changing to a DSM of a different type, for example, a DSM from a different provider|Single LUN|  
  
### Multisite cluster changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Modifying the networks that connect the nodes|Omit storage tests|  
|Making a minor \(0.x\) version change in the data replication software|Single LUN|  
|Making a major \(X.0\) version change in the data replication software, or changing to a different type of replication software|Full|  
  
### Networking changes  
  
|Change|Validation tests required|  
|----------|-----------------------------|  
|Modifying network firmware, software, or hardware|Omit storage tests|  
  
### Including storage tests  
When you perform cluster validation tests on a configured cluster, you might not always run all storage tests. This section explains what to consider if you include storage tests or do not include storage tests.  
  
#### Considerations when you include storage tests  
The Validate a Configuration Wizard runs all storage tests by default. All or some of the storage tests can be unselected by choosing the **Run only tests I select** option on the **Testing Options** page of the wizard. When storage tests are included, the **Review Storage Status** page of the wizard shows all of the disks and storage pools in the cluster and allows you to select the disks and storage pools to include in the storage tests. Storage tests require that a disk or storage pool that is assigned to a clustered role or Cluster Shared Volume be taken offline first. Therefore, anything using the storage will not have access to it during the storage tests. We recommend that any clustered role or other process that may be using the disk or storage pool is taken offline before the storage is included in the storage validation tests.  
  
The [Test-Cluster](http://technet.microsoft.com/library/hh847274)[!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet runs all storage tests by default. You can specify the **–Include** parameter to only run storage tests or to run a specific storage test. You can use the **–Disk** and **\-Pool** parameters to enable targeted storage validation. The **–Disk** parameter or the **–Pool** parameter allows specifying, respectively, one or more disks or one or more storage pools to include in the storage validation testing. If the **–Disk** parameter or the **–Pool** parameter is used to specify a disk or storage pool that is currently online and is assigned to a clustered role or Cluster Shared Volume, you must also specify the **–Force** parameter to validate the corresponding disk or storage pool; otherwise, you must ensure that the clustered disk or storage pool is offline before running the tests. If the **–Disk** parameter or the **–Pool** parameter is not specified, **Test\-Cluster** runs storage tests on all disks and storage pools that are available for cluster use or that are in the cluster resource offline or failed state. We recommend that any clustered role or other process that may be using the disk or storage pool is taken offline before the storage is included in the validation testing.  
  
**Storage that is not directly connected to all nodes in the cluster**  
  
There may be cases where the cluster design includes storage that is not connected to all nodes in the cluster. A common example is in multisite clusters where cluster nodes in *SiteA* are connected to one set of storage, the nodes in *SiteB* are connected to a different set of storage, and a non\-Microsoft replication solution is used to ensure that both sets of storage have the same data. Failover cluster detects this asymmetric storage configuration, so the disks in *SiteA* only validate with the *SiteA* nodes, and the disks in *SiteB* only validate with nodes in *SiteB*.  
  
One scenario where Microsoft customer support may request that you run validation tests on production clusters is when there is a cluster storage failure that could be caused by some underlying storage configuration change or problem. It may not be advisable to take a disk that is in use offline due to the availability impact it might have on the clustered roles that use it. In this situation, you can run validation tests \(including storage tests\) by creating or choosing a new LUN from the same shared storage device and presenting it to all nodes in the cluster. By testing this LUN, you can avoid disruption to clustered roles that are already online within the cluster and still test the underlying storage subsystem.  
  
If a failover cluster passed the full set of validation tests and has no future hardware or software changes, it will continue to be a supported configuration. However, when you perform routine updates to software components such as drivers and firmware, it may be necessary to rerun the Configuration Wizard to ensure that the current configuration of the failover cluster is supported. The following guidelines can help you decide when this is necessary:  
  
-   All components of the storage stack should be identical across all nodes in the cluster. It is required that multipath I\/O \(MPIO\) software and Device Specific Module \(DSM\) software components be identical. We recommend that the mass\-storage device controllers \(that is, the host bus adapter \(HBA\), HBA drivers, and HBA firmware\) that are attached to cluster storage be identical. If you use dissimilar HBAs, you should verify with the storage vendor that you are following their supported or recommended configurations.  
  
-   A best practice is to keep a small LUN available to allow the Validate a Configuration Wizard to run tests on available storage without negatively impacting clustered roles. If Microsoft customer support requests that you run a full set of cluster validation tests, the wizard allows you to select that disk for the storage tests to verify that the storage is working properly.  
  
#### Considerations when you do not include storage tests  
System configuration tests, inventory tests, and network tests have very low overhead, and they can be performed without significant effect on servers in a cluster.  
  
Microsoft customer support might request that you validate a production cluster as part of normal troubleshooting procedures \(not focused on storage\). In this scenario, you will use the wizard to inventory hardware and software, perform network testing, and validate system configuration. There may be certain scenarios in which only a subset of the full tests are needed. For example, if you are troubleshooting a network issue on a production cluster, Microsoft customer support might request that you run only the hardware and software inventory and the network tests.  
  
## <a name="BKMK_FAQ"></a>Frequently asked questions  
  
### If a cluster passes all tests in the Validate a Configuration Wizard, is it supported?  
If all the hardware and software components in the cluster meet the qualifications for the "Certified for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]" or "Certified for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]" logo, and the cluster passes the validation tests, it is considered to be supported by Microsoft Customer Service and Support for Failover Clustering. For more information, see [Supported cluster configurations](#BKMK_SUPPORT) earlier in this guide.  
  
### Will failover cluster solutions be listed in the Windows Server Catalog?  
No, Microsoft will not maintain a list of vendor solutions for failover clusters. However, many vendors list recommended failover cluster solutions and components on their websites.  
  
### How does Microsoft customer support check if the solution has been validated?  
The Validate a Configuration Wizard generates a simple HTML report that clearly displays whether a solution has passed all tests. This report is collected as part of the standard diagnostics tool, MSDT.  
  
### What if I make a change to the cluster configuration, like add a node? Do I have to run the Validate a Configuration Wizard again?  
Yes, the Validate a Configuration Wizard should be run any time a change is made to an existing failover cluster. For more information, see [Common validation scenarios](#BKMK_validation_scenarios) earlier in this guide.  
  
## See also  
  
-   [Failover Clustering Overview](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)  
  
-   [Failover Clustering Hardware Requirements and Storage Options](assetId:///c72342a0-7bf8-4e42-b8d2-b4a48659ba7c)  
  

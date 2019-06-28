---
ms.assetid: 75cc1d24-fa2f-45bd-8f3b-1bbd4a1aead0
title: Cluster-Aware Updating requirements and best practices
ms.prod: windows-server-threshold
ms.topic: article
ms.manager: dongill
author: JasonGerend
ms.author: jgerend
ms.technology: storage-failover-clustering
ms.date: 08/06/2018
description: Requirements for using Cluster-Aware Updating to install updates on clusters running Windows Server.
---
# Cluster-Aware Updating requirements and best practices

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This section describes the requirements and dependencies that are needed to use [Cluster-Aware Updating](cluster-aware-updating.md) (CAU) to apply updates to a failover cluster running Windows Server.

> [!NOTE]  
> You may need to independently validate that your cluster environment is ready to apply updates if you use a plug\-in other than **Microsoft.WindowsUpdatePlugin**. If you are using a non\-Microsoft plug\-in, contact the publisher for more information. For more information about plug\-ins, see [How Plug\-ins Work](cluster-aware-updating-plug-ins.md).   

## <a name="BKMK_REQ_CLUS"></a>Install the Failover Clustering feature and the Failover Clustering Tools  
CAU requires an installation of the Failover Clustering feature and the Failover Clustering Tools. The Failover Clustering Tools include the CAU tools \(clusterawareupdating.dll\), the Failover Clustering  cmdlets, and other components needed for CAU operations. For steps to install the Failover Clustering feature, see [Installing the Failover Clustering Feature and Tools](create-failover-cluster.md#install-the-failover-clustering-feature).  

The exact installation requirements for the Failover Clustering Tools depend on whether CAU coordinates updates as a clustered role on the failover cluster \(by using self\-updating mode\) or from a remote computer. The self\-updating mode of CAU additionally requires the installation of the CAU clustered role on the failover cluster by using the CAU tools.    

The following table summarizes the CAU feature installation requirements for the two CAU updating modes.  

|Installed component|Self\-updating mode|Remote\-updating mode|  
|-----------------------|-----------------------|-------------------------|  
|Failover Clustering feature|Required on all cluster nodes|Required on all cluster nodes|  
|Failover Clustering Tools|Required on all cluster nodes|-   Required on remote\-updating computer<br />-   Required on all cluster nodes to run the [Save-CauDebugTrace](https://docs.microsoft.com/powershell/module/clusterawareupdating/Save-CauDebugTrace?view=win10-ps) cmdlet|  
|CAU clustered role|Required|Not required|  

## Obtain an administrator account  
The following administrator requirements are necessary to use CAU features.  

-   To preview or apply update actions by using the CAU user interface \(UI\) or the Cluster-Aware Updating cmdlets, you must use a domain account that has local administrator rights and permissions on all the cluster nodes. If the account doesn't have sufficient privileges on every node, you are prompted in the Cluster-Aware Updating window to supply the necessary credentials when you perform these actions. To use the [Cluster-Aware Updating](https://docs.microsoft.com/powershell/module/clusterawareupdating/?view=win10-ps) cmdlets, you can supply the necessary credentials as a cmdlet parameter.  

-   If you use CAU in remote\-updating mode when you are signed in with an account that doesn't have local administrator rights and permissions on the cluster nodes, you must run the CAU tools as an administrator by using a local administrator account on the Update Coordinator computer, or by using an account that has the **Impersonate a client after authentication** user right. 

-   To run the CAU Best Practices Analyzer, you must use an account that has administrative privileges on the cluster nodes and local administrative privileges on the computer that is used to run the [Test-CauSetup](https://docs.microsoft.com/powershell/module/clusterawareupdating/Test-CauSetup?view=win10-ps) cmdlet or to analyze cluster updating readiness using the Cluster-Aware Updating window. For more information, see [Test cluster updating readiness](#BKMK_BPA).  

## Verify the cluster configuration  
The following are general requirements for a failover cluster to support updates by using CAU. Additional configuration requirements for remote management on the nodes are listed in [Configure the nodes for remote management](#BKMK_NODE_CONFIG) later in this topic.  

-   Sufficient cluster nodes must be online so that the cluster has quorum.  

-   All cluster nodes must be in the same Active Directory domain.  

-   The cluster name must be resolved on the network using DNS.  

-   If CAU is used in remote\-updating mode, the Update Coordinator computer must have network connectivity to the failover cluster nodes, and it must be in the same Active Directory domain as the failover cluster.  

-   The Cluster service should be running on all cluster nodes. By default this service is installed on all cluster nodes and is configured to start automatically.  

-   To use PowerShell pre\-update or post\-update scripts during a CAU Updating Run, ensure that the scripts are installed on all cluster nodes or that they are accessible to all nodes, for example, on a highly available network file share. If scripts are saved to a network file share, configure the folder for Read permission for the Everyone group.  

## <a name="BKMK_NODE_CONFIG"></a>Configure the nodes for remote management  
To use Cluster-Aware Updating, all nodes of the cluster must be configured for remote management. By default, the only task you must perform to configure the nodes for remote management is to [Enable a firewall rule to allow automatic restarts](#BKMK_FW). 

The following table lists the complete remote managment requirements, in case your environment diverges from the defaults.

These requirements are in addition to the installation requirements for the [Install the Failover Clustering feature and the Failover Clustering Tools](#BKMK_REQ_CLUS) and the general clustering requirements that are described in previous sections in this topic.  

|Requirement|Default state|Self\-updating mode|Remote\-updating mode|  
|---------------|---|-----------------------|-------------------------|  
|[Enable a firewall rule to allow automatic restarts](#BKMK_FW)|Disabled|Required on all cluster nodes if a firewall is in use|Required on all cluster nodes if a firewall is in use|  
|[Enable Windows Management Instrumentation](#BKMK_WMI)|Enabled|Required on all cluster nodes|Required on all cluster nodes|  
|[Enable Windows PowerShell 3.0 or 4.0 and Windows PowerShell remoting](#BKMK_PS)|Enabled|Required on all cluster nodes|Required on all cluster nodes to run the following:<br /><br />-   The [Save-CauDebugTrace](https://docs.microsoft.com/powershell/module/clusterawareupdating/Save-CauDebugTrace?view=win10-ps) cmdlet<br />-    PowerShell pre\-update and post\-update scripts during an Updating Run<br />-   Tests of cluster updating readiness using the Cluster-Aware Updating window or the [Test\-CauSetup](https://docs.microsoft.com/powershell/module/clusterawareupdating/Test-CauSetup?view=win10-ps) Windows PowerShell cmdlet|  
|[Install .NET Framework 4.6 or 4.5](#BKMK_NET)|Enabled|Required on all cluster nodes|Required on all cluster nodes to run the following:<br /><br />-   The [Save-CauDebugTrace](https://docs.microsoft.com/powershell/module/clusterawareupdating/Save-CauDebugTrace?view=win10-ps) cmdlet<br />-   PowerShell pre\-update and post\-update scripts during an Updating Run<br />-   Tests of cluster updating readiness using the Cluster-Aware Updating window or the [Test\-CauSetup](https://docs.microsoft.com/powershell/module/clusterawareupdating/Test-CauSetup?view=win10-ps) Windows PowerShell cmdlet|  

### <a name="BKMK_FW"></a>Enable a firewall rule to allow automatic restarts  
To allow automatic restarts after updates are applied \(if the installation of an update requires a restart\), if Windows Firewall or a non\-Microsoft firewall is in use on the cluster nodes, a firewall rule must be enabled on each node that allows the following traffic:  

-   Protocol: TCP  

-   Direction: inbound  

-   Program: wininit.exe  

-   Ports: RPC Dynamic Ports  

-   Profile: Domain  

If Windows Firewall is used on the cluster nodes, you can do this by enabling the **Remote Shutdown** Windows Firewall rule group on each cluster node. When you use the Cluster-Aware Updating window to apply updates and to configure self\-updating options, the **Remote Shutdown** Windows Firewall rule group is automatically enabled on each cluster node.  

> [!NOTE]  
> The **Remote Shutdown** Windows Firewall rule group cannot be enabled when it will conflict with Group Policy settings that are configured for Windows Firewall.    

The **Remote Shutdown** firewall rule group is also enabled by specifying the **–EnableFirewallRules** parameter when running the following CAU cmdlets: [Add-CauClusterRole](https://docs.microsoft.com/powershell/module/clusterawareupdating/Add-CauClusterRole?view=win10-ps), [Invoke-CauRun](https://docs.microsoft.com/powershell/module/clusterawareupdating/Invoke-CauRun?view=win10-ps), and [SetCauClusterRole](https://docs.microsoft.com/powershell/module/clusterawareupdating/Set-CauClusterRole?view=win10-ps).  

The following PowerShell example shows an additional method to enable automatic restarts on a cluster node.  

```PowerShell  
Set-NetFirewallRule -Group "@firewallapi.dll,-36751" -Profile Domain -Enabled true  
```  

### <a name="BKMK_WMI"></a>Enable Windows Management Instrumentation (WMI) 
All cluster nodes must be configured for remote management using Windows Management Instrumentation \(WMI\). This is enabled by default.  

To manually enable remote management, do the following:  

1.  In the Services console, start the **Windows Remote Management** service and set the startup type to **Automatic**.  

2.  Run the [Set-WSManQuickConfig](https://docs.microsoft.com/powershell/module/Microsoft.WsMan.Management/Set-WSManQuickConfig?view=powershell-6) cmdlet, or run the following command from an elevated command prompt:  

    ```PowerShell  
    winrm quickconfig -q  
    ```  

To support WMI remoting, if Windows Firewall is in use on the cluster nodes, the inbound firewall rule for **Windows Remote Management \(HTTP\-In\)** must be enabled on each node.  By default, this rule is enabled.  

### <a name="BKMK_PS"></a>Enable Windows PowerShell and Windows PowerShell remoting  
To enable self\-updating mode and certain CAU features in remote\-updating mode, PowerShell must be installed and enabled to run remote commands on all cluster nodes. By default, PowerShell is installed and enabled for remoting.  

To enable PowerShell remoting, use one of the following methods:  

-   Run the [Enable-PSRemoting](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Core/Enable-PSRemoting) cmdlet.  

-   Configure a domain\-level Group Policy setting for Windows Remote Management \(WinRM\).  

For more information about enabling PowerShell remoting, see [About Remote Requirements](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_requirements?view=powershell-6).  

### <a name="BKMK_NET"></a>Install .NET Framework 4.6 or 4.5  
To enable self\-updating mode and certain CAU features in remote\-updating mode,.NET Framework 4.6, or .NET Framework 4.5 (on Windows Server 2012 R2) must be installed on all cluster nodes. By default, NET Framework is installed.  

To install .NET Framework 4.6 (or 4.5) using PowerShell if it's not already installed, use the following command:

```PowerShell
Install-WindowsFeature -Name NET-Framework-45-Core
```

## <a name="BKMK_BEST_PRAC"></a>Best practices recommendations for using Cluster-Aware Updating 

### <a name="BKMK_BP_WUA"></a>Recommendations for applying Microsoft updates

We recommend that when you begin to use CAU to apply updates with the default **Microsoft.WindowsUpdatePlugin** plug\-in on a cluster, you stop using other methods to install software updates from Microsoft on the cluster nodes.  

> [!CAUTION]  
> Combining CAU with methods that update individual nodes automatically \(on a fixed time schedule\) can cause unpredictable results, including interruptions in service and unplanned downtime.  

We recommend that you follow these guidelines:  

-   For optimal results, we recommend that you disable settings on the cluster nodes for automatic updating, for example, through the Automatic Updates settings in Control Panel, or in settings that are configured using Group Policy.  

    > [!CAUTION]  
    > Automatic installation of updates on the cluster nodes can interfere with installation of updates by CAU and can cause CAU failures.  

    If they are needed, the following Automatic Updates settings are compatible with CAU, because the administrator can control the timing of update installation:  

    -   Settings to notify before downloading updates and to notify before installation  

    -   Settings to automatically download updates and to notify before installation  

    However, if Automatic Updates is downloading updates at the same time as a CAU Updating Run, the Updating Run might take longer to complete.  

-   Do not configure an update system such as Windows Server Update Services \(WSUS\) to apply updates automatically \(on a fixed time schedule\) to cluster nodes.  

-   All cluster nodes should be uniformly configured to use the same update source, for example, a WSUS server, Windows Update, or Microsoft Update.  

-   If you use a configuration management system to apply software updates to computers on the network, exclude cluster nodes from all required or automatic updates. Examples of configuration management systems include Microsoft System Center Configuration Manager 2007 and Microsoft System Center Virtual Machine Manager 2008.  

-   If internal software distribution servers \(for example, WSUS servers\) are used to contain and deploy the updates, ensure that those servers correctly identify the approved updates for the cluster nodes.  

#### <a name="BKMK_PROXY"></a>Apply Microsoft updates in branch office scenarios  
To download Microsoft updates from Microsoft Update or Windows Update to cluster nodes in certain branch office scenarios, you may need to configure  proxy settings for the Local System account on each node. For example, you might need to do this if your branch office clusters access Microsoft Update or Windows Update to download updates by using a local proxy server.  

If necessary, configure WinHTTP proxy settings on each node to specify a local proxy server and configure local address exceptions \(that is, a bypass list for local addresses\). To do this, you can run the following command on each cluster node from an elevated command prompt:  

```  
netsh winhttp set proxy <ProxyServerFQDN >:<port> "<local>"  
```  

where <*ProxyServerFQDN*> is the fully qualified domain name for the proxy server and <*port*> is the port over which to communicate (usually port 443).  

For example, to configure WinHTTP proxy settings for the Local System account specifying the proxy server *MyProxy.CONTOSO.com*, with port 443 and local address exceptions, type the following command:  

```  
netsh winhttp set proxy MyProxy.CONTOSO.com:443 "<local>"  
```  

### <a name="BKMK_BP_HF"></a>Recommendations for using the Microsoft.HotfixPlugin  

-   We recommend that you configure permissions in the hotfix root folder and hotfix configuration file to restrict Write access to only local administrators on the computers that are used to store these files. This helps prevent tampering with these files by unauthorized users that could compromise the functionality of the failover cluster when hotfixes are applied.  

-   To help ensure data integrity for the server message block \(SMB\) connections that are used to access the hotfix root folder, you should configure SMB Encryption in the SMB shared folder, if it is possible to configure it. The **Microsoft.HotfixPlugin** requires that SMB signing or SMB Encryption is configured to help ensure data integrity for the SMB connections. 

    For more information, see [Restrict access to the hotfix root folder and hotfix configuration file](cluster-aware-updating-plug-ins.md#BKMK_ACL).

### Additional recommendations  

-   To avoid interfering with a CAU Updating Run that may be scheduled at the same time, do not schedule password changes for cluster name objects and virtual computer objects during scheduled maintenance windows.  

-   You should set appropriate permissions on pre\-update and post\-update scripts that are saved on network shared folders to prevent potential tampering with these files by unauthorized users.  

-   To configure CAU in self\-updating mode, a virtual computer object \(VCO\) for the CAU clustered role must be created in Active Directory. CAU can create this object automatically at the time that the CAU clustered role is added, if the failover cluster has sufficient permissions. However, because of the security policies in certain organizations, it may be necessary to prestage the object in Active Directory. For a procedure to do this, see [Steps for prestaging an account for a clustered role](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731002\(v=ws.10\)#steps-for-prestaging-the-cluster-name-account).  

-   To save and reuse Updating Run settings across failover clusters with similar updating needs in the IT organization, you can create Updating Run Profiles. Additionally, depending on the updating mode, you can save and manage the Updating Run Profiles on a file share that is accessible to all remote Update Coordinator computers or failover clusters. For more information, see [Advanced Options and Updating Run Profiles for CAU](cluster-aware-updating-options.md).  

## <a name="BKMK_BPA"></a>Test cluster updating readiness  
You can run the CAU Best Practices Analyzer \(BPA\) model to test whether a failover cluster and the network environment meet many of the requirements to have software updates applied by CAU. Many of the tests check the environment for readiness to apply Microsoft updates by using the default plug\-in, **Microsoft.WindowsUpdatePlugin**.  

> [!NOTE]  
> You might need to independently validate that your cluster environment is ready to apply software updates by using a plug\-in other than **Microsoft.WindowsUpdatePlugin**. If you are using a non\-Microsoft plug\-in, such as one provided by your hardware manufacturer, contact the publisher for more information.  

You can run the BPA in the following two ways:  

1.  Select **Analyze cluster updating readiness** in the CAU console. After the BPA completes the readiness tests, a test report appears. If issues are detected on cluster nodes, the specific issues and the nodes where the issues appear are identified so that you can take corrective action. The tests can take several minutes to complete.  

2.  Run the [Test-CauSetup](https://docs.microsoft.com/powershell/module/clusterawareupdating/Test-CauSetup) cmdlet. You can run the cmdlet on a local or remote computer on which the Failover Clustering Module for Windows PowerShell (part of the Failover Clustering Tools) is installed. You can also run the cmdlet on a node of the failover cluster.  

> [!NOTE]  
> -   You must use an account that has administrative privileges on the cluster nodes and local administrative privileges on the computer that is used to run the **Test\-CauSetup** cmdlet or to analyze cluster updating readiness using the Cluster-Aware Updating window. To run the tests using the Cluster-Aware Updating window, you must be logged on to the computer with the necessary credentials.  
> -   The tests assume that the CAU tools that are used to preview and apply software updates run from the same computer and with the same user credentials as are used to test cluster updating readiness.  

> [!IMPORTANT]  
> We highly recommend that you test the cluster for updating readiness in the following situations:  
>   
> -   Before you use CAU for the first time to apply software updates.  
> -   After you add a node to the cluster or perform other hardware changes in the cluster that require running the Validate a Cluster Wizard.  
> -   After you change an update source, or change update settings or configurations \(other than CAU\) that can affect the application of updates on the nodes.  

### Tests for cluster updating readiness  
The following table lists the cluster updating readiness tests, some common issues, and resolution steps.  


|                                                      Test                                                      |                                                                                                                                               Possible issues and impacts                                                                                                                                               |                                                                                                                                                                                         Resolution steps                                                                                                                                                                                         |
|----------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                                     The failover cluster must be available                                     |                                                                                       Cannot resolve the failover cluster name, or one or more cluster nodes cannot be accessed. The BPA cannot run the cluster readiness tests.                                                                                        |                                                                   -   Check the spelling of the name of the cluster specified during the BPA run.<br />-   Ensure that all nodes of the cluster are online and running.<br />-   Check that the Validate a Configuration Wizard can successfully run on the failover cluster.                                                                    |
|                    The failover cluster nodes must be enabled for remote management via WMI                    |                                                One or more failover cluster nodes are not enabled for remote management by using Windows Management Instrumentation \(WMI\). CAU cannot update the cluster nodes if the nodes are not configured for remote management.                                                 |                                                                                                  Ensure that all failover cluster nodes are enabled for remote management through WMI. For more information, see [Configure the nodes for remote management](#BKMK_NODE_CONFIG) in this topic.                                                                                                   |
|                      PowerShell remoting should be enabled on each failover cluster node                       |                                                           PowerShell isn't installed or isn't enabled for remoting on one or more failover cluster nodes. CAU cannot be configured for self\-updating mode or use certain features in remote\-updating mode.                                                            |                                                                                             Ensure that PowerShell is installed on all cluster nodes and is enabled for remoting.<br /><br />For more information, see [Configure the nodes for remote management](#BKMK_NODE_CONFIG) in this topic.                                                                                             |
|                                            Failover cluster version                                            |                                                                            One or more nodes in the failover cluster don't run Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012. CAU cannot update the failover cluster.                                                                             |                                                                   Verify that the failover cluster that is specified during the BPA run is running Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012.<br /><br />For more information, see [Verify the cluster configuration](#BKMK_REQ_CLUS) in this topic.                                                                   |
| The required versions of .NET Framework and Windows PowerShell must be installed on all failover cluster nodes |                                                                                              .NET Framework 4.6, 4.5 or Windows PowerShell isn't installed on one or more cluster nodes. Some CAU features might not work.                                                                                              |                                                                            Ensure that .NET Framework 4.6 or 4.5 and Windows PowerShell are installed on all cluster nodes, if they are required.<br /><br />For more information, see [Configure the nodes for remote management](#BKMK_NODE_CONFIG) in this topic.                                                                             |
|                           The Cluster service should be running on all cluster nodes                           |                                                                                                            The Cluster service is not running on one or more nodes. CAU cannot update the failover cluster.                                                                                                             |                        -   Ensure that the Cluster service \(clussvc\) is started on all nodes in the cluster, and it is configured to start automatically.<br />-   Check that the Validate a Configuration Wizard can successfully run on the failover cluster.<br /><br />For more information, see [Verify the cluster configuration](#BKMK_REQ_CLUS) in this topic.                         |
|     Automatic Updates must not be configured to automatically install updates on any failover cluster node     |                                           On at least one failover cluster node, Automatic Updates is configured to automatically install Microsoft updates on that node. Combining CAU with other update methods can result in unplanned downtime or unpredictable results.                                            |                                                     If Windows Update functionality is configured for Automatic Updates on one or more cluster nodes, ensure that Automatic Updates is not configured to automatically install updates.<br /><br />For more information, see [Recommendations for applying Microsoft updates](#BKMK_BP_WUA).                                                     |
|                          The failover cluster nodes should use the same update source                          |                                                    One or more failover cluster nodes are configured to use an update source for Microsoft updates that is different from the rest of the nodes. Updates might not be applied uniformly on the cluster nodes by CAU.                                                    |                                                                        Ensure that every cluster node is configured to use the same update source, for example, a WSUS server, Windows Update, or Microsoft Update.<br /><br />For more information, see [Recommendations for applying Microsoft updates](#BKMK_BP_WUA).                                                                         |
|       A firewall rule that allows remote shutdown should be enabled on each node in the failover cluster       |                 One or more failover cluster nodes do not have a firewall rule enabled that allows remote shutdown, or a Group Policy setting prevents this rule from being enabled. An Updating Run that applies updates that require restarting the nodes automatically might not complete properly.                  |                                                                    If Windows Firewall or a non\-Microsoft firewall is in use on the cluster nodes, configure a firewall rule that allows remote shutdown.<br /><br />For more information, see [Enable a firewall rule to allow automatic restarts](#BKMK_FW) in this topic.                                                                    |
|          The proxy server setting on each failover cluster node should be set to a local proxy server          |                             One or more failover cluster nodes have an incorrect proxy server configuration.<br /><br />If a local proxy server is in use, the proxy server setting on each node must be configured properly for the cluster to access Microsoft Update or Windows Update.                              |                                            Ensure that the WinHTTP proxy settings on each cluster node are set to a local proxy server if it is needed. If a proxy server is not in use in your environment, this warning can be ignored.<br /><br />For more information, see [Apply updates in branch office scenarios](#BKMK_PROXY) in this topic.                                            |
|        The CAU clustered role should be installed on the failover cluster to enable self\-updating mode        |                                                                                                   The CAU clustered role is not installed on this failover cluster. This role is required for cluster self\-updating.                                                                                                   |      To use CAU in self\-updating mode, add the CAU clustered role on the failover cluster in one of the following ways:<br /><br />-   Run the [Add-CauClusterRole](https://docs.microsoft.com/powershell/module/clusterawareupdating/Add-CauClusterRole) PowerShell cmdlet.<br />-   Select the **Configure cluster self\-updating options** action in the Cluster-Aware Updating window.      |
|         The CAU clustered role should be enabled on the failover cluster to enable self\-updating mode         | The CAU clustered role is disabled. For example, the CAU clustered role is not installed, or it has been disabled by using the [Disable\-CauClusterRole](https://docs.microsoft.com/powershell/module/clusterawareupdating/Disable-CauClusterRole) PowerShell cmdlet. This role is required for cluster self\-updating. | To use CAU in self\-updating mode, enable the CAU clustered role on this failover cluster in one of the following ways:<br /><br />-   Run the [Enable-CauClusterRole](https://docs.microsoft.com/powershell/module/clusterawareupdating/Enable-CauClusterRole) PowerShell cmdlet.<br />-   Select the **Configure cluster self\-updating options** action in the Cluster-Aware Updating window. |
|      The configured CAU plug\-in for self\-updating mode must be registered on all failover cluster nodes      |                                                              The CAU clustered role on one or more nodes of this failover cluster cannot access the CAU plug\-in module that is configured in the self\-updating options. A self\-updating run might fail.                                                              |           -   Ensure that the configured CAU plug\-in is installed on all cluster nodes by following the installation procedure for the product that supplies the CAU plug\-in.<br />-   Run the [Register\-CauPlugin](https://docs.microsoft.com/powershell/module/clusterawareupdating/Register-CauPlugin) PowerShell cmdlet to register the plug\-in on the required cluster nodes.           |
|                All failover cluster nodes should have the same set of registered CAU plug\-ins                 |                                                                             A self\-updating run might fail if the plug\-in that is configured to be used in an Updating Run is changed to one that is not available on all cluster nodes.                                                                              |           -   Ensure that the configured CAU plug\-in is installed on all cluster nodes by following the installation procedure for the product that supplies the CAU plug\-in.<br />-   Run the [Register\-CauPlugin](https://docs.microsoft.com/powershell/module/clusterawareupdating/Register-CauPlugin) PowerShell cmdlet to register the plug\-in on the required cluster nodes.           |
|                               The configured Updating Run options must be valid                                |                                                                          The self\-updating schedule and Updating Run options that are configured for this failover cluster are incomplete or are not valid. A self\-updating run might fail.                                                                           |                                                            Configure a valid self\-updating schedule and set of Updating Run options. For example, you can use the [Set\-CauClusterRole](https://docs.microsoft.com/powershell/module/clusterawareupdating/Set-CauClusterRole) PowerShell cmdlet to configure the CAU clustered role.                                                            |
|                  At least two failover cluster nodes must be owners of the CAU clustered role                  |                                                                                        An Updating Run launched in self\-updating mode will fail because the CAU clustered role does not have a possible owner node to move to.                                                                                         |                                                                                                                Use the Failover Clustering Tools to ensure that all cluster nodes are configured as possible owners of the CAU clustered role. This is the default configuration.                                                                                                                |
|                  All failover cluster nodes must be able to access Windows PowerShell scripts                  |                                                                        Not all possible owner nodes of the CAU clustered role can access the configured Windows PowerShell pre\-update and post\-update scripts. A self\-updating run will fail.                                                                        |                                                                                                                    Ensure that all possible owner nodes of the CAU clustered role have permissions to access the configured PowerShell pre\-update and post\-update scripts.                                                                                                                     |
|                   All failover cluster nodes should use identical Windows PowerShell scripts                   |                                                     Not all possible owner nodes of the CAU clustered role use the same copy of the specified Windows PowerShell pre\-update and post\-update scripts. A self\-updating run might fail or show unexpected behavior.                                                     |                                                                                                                                   Ensure that all possible owner nodes of the CAU clustered role use the same PowerShell pre\-update and post\-update scripts.                                                                                                                                   |
|         The WarnAfter setting specified for the Updating Run should be less than the StopAfter setting         |                                                                           The specified CAU Updating Run timeout values make the warning timeout ineffective. An Updating Run might be canceled before a warning event log can be generated.                                                                            |                                                                                                                                      In the Updating Run options, configure a **WarnAfter** option value that is less than the **StopAfter** option value.                                                                                                                                       |

## See also  

-   [Cluster-Aware Updating overview](cluster-aware-updating.md)
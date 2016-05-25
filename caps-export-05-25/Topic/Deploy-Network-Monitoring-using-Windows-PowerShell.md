---
title: Deploy Network Monitoring using Windows PowerShell
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: e2c09159-7074-4048-85db-2f0e14623264
author: vhorne
---
# Deploy Network Monitoring using Windows PowerShell
You can use this topic to deploy the Network Controller feature Network Monitoring in your Software Defined Networking\-capable datacenter.  
  
> [!NOTE]  
> In addition to this topic, the following Network Monitoring documentation is available.  
>   
> -   [Network Monitoring](../Topic/Network-Monitoring.md)  
> -   [Prerequisites for Deploying Network Monitoring](../Topic/Prerequisites-for-Deploying-Network-Monitoring.md)  
  
## Deployment Overview and Deployment Steps  
The following sections contain information about deploying Network Monitoring.  
  
### Network Monitoring Deployment Overview  
Following are the steps required to deploy Network Monitoring, including links to the sections in this document that describe how to perform the steps.  
  
-   [Configure Simple Network Management Protocol (SNMP) on Network Devices](#bkmk_snmp)  
  
-   [Define a Community String on Network Devices](#bkmk_string)  
  
-   [Configure Credentials in Network Controller](#bkmk_credentials)  
  
-   [Deploy Canary Agents for Network Monitoring](#bkmk_canary)  
  
-   [Configure Active Probe Tests](#bkmk_probe)  
  
-   [Configure External Network Tests](#bkmk_external)  
  
-   [Configure CPU and Memory OIDs Per Vendor](#bkmk_cpu)  
  
## <a name="bkmk_snmp"></a>Configure Simple Network Management Protocol \(SNMP\) on Network Devices  
Network Controller Network Monitoring collects information about the devices on your network by using SNMP. Because of this, you must configure SNMP on the following devices.  
  
-   All switches in your datacenter. While configuring SNMP on your switches, configure SNMP trap destinations that are the IP addresses of Network Controller nodes on your network.  
  
-   All routers in your datacenter. While configuring SNMP on your routers, configure SNMP trap destinations that are the IP addresses of Network Controller nodes on your network.  
  
For information about how to configure SNMP on your devices, see your device manufacturer documentation.  
  
## <a name="bkmk_string"></a>Define a Community String on Network Devices  
The community string allows Network Controller to communicate with your devices. Because of this, you must create a community string on the following devices.  
  
-   All switches in your datacenter.  
  
-   All routers in your datacenter.  
  
For information about how to configure a community string on your devices, see your device manufacturer documentation.  
  
## <a name="bkmk_credentials"></a>Configure Credentials in Network Controller  
You must configure two types of credentials in Network Controller \- network device access credentials for each device on your network, and the access credentials for all servers that are running [!INCLUDE[winthreshold_server_1](../Token/winthreshold_server_1_md.md)] and that you are planning to use as Canary Agents.  
  
To configure these credentials, perform the following steps.  
  
1.  On a computer or virtual machine \(VM\) that is running Network Controller, create credentials objects and associate the objects with either a Canary Agent server or a network device, such as a switch or a router.  Perform this step for every device and Canary Agent on your network.  
  
    To perform this step, you must use the Windows PowerShell command **New\-NetworkControllerCredential**. The **New\-NetworkControllerCredential** command adds a new device credential to Network Controller. If the credential is already present, this command will modify the properties of the credential. Network Controller uses the device credential to connect to a southbound device for managing the device. This command adds or modifies credentials based on username and password, Simple Network Management Protocol \(SNMP\)\-based credentials, and certificate\-based credentials.  
  
    For more information, see [New-NetworkControllerCredential](https://technet.microsoft.com/library/mt576396.aspx)  
  
2.  If the device for which you are adding a credential is a router or a switch, use the **New\-NetworkControllerSwitch** command to associate the credential object with the switch or router. The syntax for this command is:  
  
    ```  
    New-NetworkControllerSwitch [-ResourceId] <string> [-Properties] <PSwitchProperties> [[-ResourceMetadata] <ResourceMetadata>] [[-VersionId] <string>] [[-Force]] -ConnectionUri <string> [-CertificateThumbprint <string>] [-Credential <pscredential>] [-WhatIf] [-Confirm]  [<CommonParameters>]  
    ```  
  
3.  If the credential you are adding is for a server that is a Canary Agent, use the **New\-NetworkControllerServer** command to associate the credential object with the Canary Agent. The syntax for this command is:  
  
    ```  
    New-NetworkControllerServer [-ResourceId] <string> [-Properties] <ServerProperties> [[-ResourceMetadata] <ResourceMetadata>] [[-VersionId] <string>] [[-Force]] -ConnectionUri <string> [-CertificateThumbprint <string>] [-Credential <pscredential>] [-WhatIf] [-Confirm]  [<CommonParameters>]  
    ```  
  
## <a name="bkmk_canary"></a>Deploy Canary Agents for Network Monitoring  
On every server that you want to use as a Canary Agent for Network Monitoring, you must install the Canary Network Diagnostics feature and start the Network Performance and Diagnostic Service \(NPDS\).  In addition you can verify which Canary Agents are being used by Network Monitoring.  
  
> [!NOTE]  
> You can use the procedure below to install the Canary Network Diagnostics feature, or you can install the feature by running the following Windows PowerShell command on the target server.  
>   
> `Install-WindowsFeature -Name Canary-Network-Diagnostics`  
  
#### To install the Canary Network Diagnostics feature  
  
1.  On the computer that you want to configure as a Canary Agent, open Server Manager, click **Manage**, and then click **Add Roles and Features**.  
  
2.  The **Add Roles and Features Wizard** opens. Click **Next**.  
  
3.  In **Select installation type**, ensure that **Role\-based or feature\-based installation** is selected, and then click **Next**.  
  
4.  In **Select destination server**, ensure that the correct server is selected, and then click **Next**.  
  
5.  In **Select server roles**, click **Next**.  
  
6.  In **Select features**, click **Canary Network Diagnostics**, and then click **Next**.  
  
7.  In **Confirm installation selections**, click **Install**.  
  
After you install the Canary Network Diagnostics feature, the Network Performance and Diagnostic Service \(NPDS\) is installed with **Service status** in a **Stopped** state and the **Startup Type** of **Manual**.   
  
>[!NOTE]The Network Controller Canary Server automatically polls to locate Canary Agents. When the Canary Server locates a computer with the NPDS service installed, the Canary Server starts the NPDS service and sets the **Startup Type** to **Automatic**.  
  
You can verify which Canary Agents are being used by Network Monitoring by running the Windows PowerShell command **Get\-NetworkControllerCanaryConfiguration** on the host where Network Controller is installed. The syntax for this command is:  
  
`Get-NetworkControllerCanaryConfiguration [[-ResourceId] <string[]>] -ConnectionUri <string> [-CertificateThumbprint <string>] [-Credential <pscredential>]  [<CommonParameters>]`  
  
## <a name="bkmk_probe"></a>Configure Active Probe Tests  
You can specify which logical networks you want to probe by configuring active probe tests. By default, all networks are included in the list of networks to probe, so you do not need to configure active probe tests unless you want to exclude some networks from the tests.  
  
To configure the networks that are included in active probe tests, you must run the **New\-NetworkControllerMonitoredGroupsTestConfiguration** command on a Network Controller node. Following is the syntax for this command.  
  
`New-NetworkControllerMonitoredGroupsTestConfiguration [-ResourceId] <string> [-Properties] <MonitoredGroupTestProperties> [[-ResourceMetadata] <ResourceMetadata>] [[-VersionId] <string>] [[-Force]] -ConnectionUri <string> [-CertificateThumbprint <string>] [-Credential <pscredential>] [-WhatIf] [-Confirm] [<CommonParameters>]`  
  
## <a name="bkmk_external"></a>Configure External Network Tests  
If you want to test Canary Agent connectivity to external IP addresses, you can configure external network tests in Network Monitoring.  
  
> [!NOTE]  
> Before you configure external network tests, ensure that the Canary Agent has access to the external network where the test IP address is located.  
  
To configure a Canary Agent for external network tests, you can use the **New\-NetworkControllerExternalTestRule** command on a Network Controller node. Following is the syntax for this command.  
  
`New-NetworkControllerExternalTestRule [-ResourceId] <string> [-Properties] <ExternalTestRuleProperties> [[-ResourceMetadata] <ResourceMetadata>] [[-VersionId] <string>] [[-Force]] -ConnectionUri <string> [-CertificateThumbprint <string>] [-Credential <pscredential>] [-WhatIf] [-Confirm]  [<CommonParameters>]`  
  
## <a name="bkmk_cpu"></a>Configure CPU and Memory Object Identifiers \(OIDs\) Per Vendor  
Network Monitoring polls many standard OIDs to gather health and performance statistics for switches and routers. However, the standard management information bases \(MIBs\) do not cover data points to indicate the CPU and memory utilization of  devices. Many vendors support these data points as private OIDs, and you can configure Network Monitoring to poll for this information from your devices.  
  
You can use the **New\-NetworkControllerPhysicalSwitchCpuUtilizationParameter** to specify which OID to use per vendor to accomplish CPU monitoring.  
  
Following is the syntax for this command.  
  
`New-NetworkControllerPhysicalSwitchCpuUtilizationParameter [-ResourceId] <string> [-Properties] <CpuUtilizationProperties> [[-ResourceMetadata] <ResourceMetadata>] [[-VersionId] <string>] [[-Force]]-ConnectionUri <string> [-CertificateThumbprint <string>] [-Credential <pscredential>] [-WhatIf] [-Confirm] [<CommonParameters>]`  
  
You can use the **New\-NetworkControllerPhysicalSwitchMemoryUtilizationParameter**  to specify which OID to use per vendor to accomplish memory utilization monitoring.  
  
Following is the syntax for this command.  
  
`New-NetworkControllerPhysicalSwitchMemoryUtilizationParameter [-ResourceId] <string> [-Properties] <MemoryUtilizationProperties> [[-ResourceMetadata] <ResourceMetadata>] [[-VersionId] <string>] [[-Force]] -ConnectionUri <string> [-CertificateThumbprint <string>] [-Credential <pscredential>] [-WhatIf] [-Confirm] [<CommonParameters>]`  
  

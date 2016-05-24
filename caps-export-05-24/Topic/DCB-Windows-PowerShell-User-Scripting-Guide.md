---
title: DCB Windows PowerShell User Scripting Guide
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 029f2471-1b5a-4347-ac9e-dea41969486b
---
# DCB Windows PowerShell User Scripting Guide
The purpose of this document is to guide IT pros or datacenter administrator to configure Data Center Bridging \(DCB\) on a capable network adapter on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] using the Windows PowerShell management tool.  
  
## DCB Overview  
This guide contains the following sections:  
  
-   [Prerequisites](#BKMK_DCB_Prereqs)  
  
    -   [Windows Server 2012](#BKMK_DCB_Server)  
  
    -   [Enable Data Center Bridging](#BKMK_DCB_EnablDCB)  
  
    -   [Import DCB PowerShell modules](#BKMK_DCB_ImportModules)  
  
-   [Windows PowerShell tips](#BKMK_DCB_Tips)  
  
    -   [Find PowerShell commands](#BKMK_DCB_FindCommands)  
  
    -   [Learn command syntax](#BKMK_DCB_LearnSyntax)  
  
    -   [Learn more about command parameters](#BKMK_DCB_LearnParameters)  
  
-   [DCB configurations](#BKMK_DCB_Configurations)  
  
    -   [Traffic Class management](#BKMK_DCB_TrafficClassMgmnt)  
  
    -   [Priority Flow Control settings](#BKMK_DCB_PFCSettings)  
  
    -   [Application Priority assignment](#BKMK_DCB_AppPriAssign)  
  
-   [DCBX settings](#BKMK_DCBX_Settings)  
  
    -   [Set the Willing Bit](#BKMK_DCB_SetWillingBit)  
  
    -   [Display the Willing Bit](#BKMK_DCB_DisplayWillingBit)  
  
-   [DCB configuration on the network adapter](#BKMK_DCB_ConfigNetAdapter)  
  
    -   [Display DCB settings on the network adapter](#BKMK_DCB_DisplaySettingsOnAdapter)  
  
    -   [Display DCB on the network adapter](#BKMK_DCB_DisplayDCBOnAdapter)  
  
    -   [Enable DCB settings on the network adapter](#BKMK_DCB_EnableDCBSettingsOnAdapter)  
  
## <a name="BKMK_DCB_Prereqs"></a>Prerequisites  
Following are the prerequisites for configuring and managing DCB.  
  
### <a name="BKMK_DCB_Server"></a>Windows Server 2012  
DCB is a new feature introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. It is not available on Windows client operating systems. The PowerShell command output samples and the DCB configuration examples provided in this document are from an interim [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] build. The PowerShell commands, known as PowerShell cmdlets, as well as the user interface, are subject to change before the official release of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
### <a name="BKMK_DCB_EnablDCB"></a>Enable Data Center Bridging  
DCB includes a software control protocol called DCB Exchange Protocol \(DCBX\). This protocol allows network admin to configure DCB on a switch and propagates the configurations to an end device. If you prefer to manage DCB from a switch you don’t need to install DCB as a feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. You can still view the configurations in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] using PowerShell though. See DCB Configurations.  
  
> [!NOTE]  
> If you want to manage DCB on a server either because DCBX is not used or supported in your network, or because the traffic classification rules are too complicated to express in DCBX, you can use either of the following two procedures to install DCB as a feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
##### To install DCB using Windows PowerShell  
  
1.  In the Task Bar, right\-click the Windows PowerShell icon, and then click **Run as Administrator**. Windows PowerShell opens in elevated mode.  
  
2.  In the Windows PowerShell console, type: Install\-WindowsFeature “data\-center\-bridging”, and then press Enter.  
  
In Windows PowerShell the command and results appear as follows:  
  
**PS C:\\> Install\-WindowsFeature “data\-center\-bridging”Success  Restart  Needed Exit Code      Feature Result\-\-\-\-\-\-\-\-\-  \-\-\-\-\-\-\-\-  \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-      \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-True       No         Success                {Data Center Bridging}WARNING: Windows automatic updating is not enabled. To ensure that your newly installed role or feature is automatically updated, turn on Windows Update.PS C:\\>**  
##### To install DCB using the Add Roles and Features Wizard in Server Manager  
  
1.  Open Server Manager.  
  
2.  In the Server Manager Dashboard menu, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens.  
  
3.  In the Add Roles and Features Wizard, in **Before You Begin**, click **Next**.  
  
4.  In **Select installation type** ensure that **Role\-based or feature\-based installation** is selected, and then click **Next**.  
  
5.  In **Select destination server**, ensure that **Select a server from the server pool** is selected, and in Server Pool, select the server on which you want to install DCB, and then click **Next**.  
  
6.  On **Select server roles**, click **Next**.  
  
7.  In **Select features** select **Data Center Bridging**, and then click **Install**.  
  
### <a name="BKMK_DCB_ImportModules"></a>Import DCB PowerShell modules  
The commands to configure DCB are included in three PowerShell modules: netqos, dcbqos, and netadapter. You can import these modules as follows.  
  
```  
  
PS C:\> import-module netqos  
PS C:\> import-module dcbqos  
PS C:\> import-module netadapter  
PS C:\> get-module  
  
ModuleType       Name                                      ExportedCommands  
----------       ----                                      ----------------  
Manifest         dcbqos                                    {Disable-NetQosFlowControl, Enable-NetQosFlowControl, Get-NetQosDcbxS...  
Manifest         Microsoft.PowerShell.Management           {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Content...}  
Manifest         Microsoft.PowerShell.Utility              {Add-Member, Add-Type, Clear-Variable, Compare-Object...}  
Manifest         netadapter                                {Disable-NetAdapter, Disable-NetAdapterBinding, Disable-NetAdapterChe...  
Manifest         netqos                                    {Get-NetQosPolicy, New-NetQosPolicy, Remove-NetQosPolicy, Set-NetQosP...  
Script           ServerManager                             {Get-WindowsFeature, Install-WindowsFeature, Uninstall-WindowsFeature...  
  
PS C:\>  
  
```  
  
Importing the modules before any DCB configuration is optional. The only consideration is if you do not import them beforehand, you might experience a few seconds delay when invoking any command from a module for the first time.  
  
## <a name="BKMK_DCB_Tips"></a>Windows PowerShell tips  
If you are familiar with Windows PowerShell you can proceed to the next section, DCB configuration. If you are not already familiar with Windows PowerShell, this following section provides several useful tips.  
  
### <a name="BKMK_DCB_FindCommands"></a>Find Windows PowerShell commands  
There are a couple ways to find available PowerShell commands. The first one is to use the Help command.  
  
```  
  
PS C:\> help *qos*  
  
Set-NetQosPolicy                  Function  netqos                   ...  
Disable-NetQosFlowControl         Function  dcbqos                   ...  
Enable-NetQosFlowControl          Function  dcbqos                   ...  
Get-NetQosDcbxSetting             Function  dcbqos                   ...  
Get-NetQosFlowControl             Function  dcbqos                   ...  
Get-NetQosTrafficClass            Function  dcbqos                   ...  
New-NetQosTrafficClass            Function  dcbqos                   ...  
Remove-NetQosTrafficClass         Function  dcbqos                   ...  
Set-NetQosDcbxSetting             Function  dcbqos                   ...  
Set-NetQosFlowControl             Function  dcbqos                   ...  
Set-NetQosTrafficClass            Function  dcbqos                   ...  
Disable-NetAdapterQos             Function  netadapter               ...  
Enable-NetAdapterQos              Function  netadapter               ...  
Get-NetAdapterQos                 Function  netadapter               ...  
Set-NetAdapterQos                 Function  netadapter               ...  
  
PS C:\>  
  
```  
  
The use of keyword “QoS” and the wildcard “\*” returns all of the QoS commands from the netqos, dcbqos, and netadapter modules that were previously imported.  
  
You can use the Get\-Command to find all of the commands from a specific PowerShell module.  
  
```  
  
PS C:\> get-command -module netqos  
  
CommandType  Name                  ModuleName  
-----------  -----                 ----------  
Function     Get-NetQosPolicy      netqos  
Function     New-NetQosPolicy      netqos  
Function     Remove-NetQosPolicy   netqos  
Function     Set-NetQosPolicy      netqos  
  
PS C:\>  
  
```  
  
### <a name="BKMK_DCB_LearnSyntax"></a>Learn command syntax  
You can learn the syntax of a command by using the Man command.  
  
```  
  
PS C:\> man New-NetQoSTrafficClass  
  
NAME  
    New-NetQosTrafficClass  
  
SYNTAX  
    New-NetQosTrafficClass [-Name] <string> [-Algorithm] <Algorithm> {Strict | ETS} [-Priority] <byte[]>  
    [-BandwidthPercentage <byte>] [-CimSession <CimSession[]>] [-ThrottleLimit <int>] [-AsJob] [-WhatIf] [-Confirm]  
    [<CommonParameters>]  
  
ALIASES  
    None  
  
REMARKS  
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.  
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.  
  
PS C:\>  
  
```  
  
Alternately, you can add “\-?” after the command. For example, **New\-NetQosTrafficClass \-?** which will render the same command synopsis as the Man command.  
  
### <a name="BKMK_DCB_LearnParameters"></a>Learn more about command parameters  
You can use “get\-help” coupled with “\-full” to learn more about the command parameters:  
  
```  
  
PS C:\> get-help New-NetQoSTrafficClass -full | more  
  
NAME  
    New-NetQosTrafficClass  
  
SYNTAX  
    New-NetQosTrafficClass [-Name] <string> [-Algorithm] <Algorithm> {Strict | ETS} [-Priority] <byte[]>  
    [-BandwidthPercentage <byte>] [-CimSession <CimSession[]>] [-ThrottleLimit <int>] [-AsJob] [-WhatIf] [-Confirm]  
    [<CommonParameters>]  
  
PARAMETERS  
    -Algorithm <Algorithm>  
  
        Required?                    true  
        Position?                    1  
        Accept pipeline input?       false  
        Parameter set name           cim:CreateInstance0  
        Aliases                      tsa  
        Dynamic?                     false  
  
    -AsJob  
  
        Required?                    false  
        Position?                    Named  
        Accept pipeline input?       false  
        Parameter set name           cim:CreateInstance0  
        Aliases                      None  
        Dynamic?                     false  
  
    -BandwidthPercentage <byte>  
  
        Required?                    false  
        Position?                    Named  
        Accept pipeline input?       false  
        Parameter set name           cim:CreateInstance0  
        Aliases                      Bandwidth, bw  
        Dynamic?                     false  
  
    -CimSession <CimSession[]>  
  
        Required?                    false  
        Position?                    Named  
        Accept pipeline input?       false  
        Parameter set name           cim:CreateInstance0  
        Aliases                      Session  
        Dynamic?                     false  
  
    -Confirm  
  
        Required?                    false  
        Position?                    Named  
        Accept pipeline input?       false  
-- More  --  
  
```  
  
## <a name="BKMK_DCB_Configurations"></a>DCB configurations  
The configurations of traffic class, PFC and application priority assignment at the system level will not be applied on network adapters until you:  
  
1.  Turn the DCBX Willing bit to false \(zero\)  
  
2.  Enable DCB on the network adapters. See [DCB Configuration on Network Adapters](#BKMK_EnableDCB).  
  
> [!NOTE]  
> If you want to configure DCB from a switch through DCBX, see [DCBX Settings](#BKMK_DCBXSettings)  
  
The DCBX Willing bit is described in the DCB specification. If the Willing bit on a device is set to true, the device is willing to accept configurations from a remote device through DCBX. If the Willing bit on a device is set to false, the device will reject all configuration attempts from remote devices and enforce only the local configurations.  
  
If DCB is not installed in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] the value of the Willing bit is irrelevant as far as the operating system is concerned because the operating system has no local settings apply to network adapters. After DCB is installed, the default value of the Willing bit is true. This design allows network adapters to keep whatever configurations they may have received from their remote peers.  
  
If a network adapter doesn’t support DCBX it will never receive configurations from a remote device. It will receive configurations from the operating system, and only after the DCBX Willing bit is set to false.  
  
To enforce operating system configurations of traffic class, PFC and application priority assignment on network adapters, or to simply override the configurations from remote devices—if there are any—you can run the following command:  
  
```  
  
PS C:\> set-netQoSdcbxSetting -Willing 0  
  
Confirm  
Are you sure you want to perform this action?  
Set-NetQosDcbxSetting -Willing $false  
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y  
PS C:\>  
  
```  
  
**Set the Willing bit**@@  
  
To display the state of the Willing bit setting, you can use the following command:  
  
```  
  
PS C:\> get-NetQosDcbxSetting  
  
Willing  
-------  
False  
  
PS C:\>  
  
```  
  
DCB Configuration on Network Adapter: Enabling DCB on a network adapter will allow you to see the configuration propagated from a switch to the network adapter.  
  
DCB configurations in Windows Server 2012 involve a few steps:  
  
1.  Configure DCB settings at the system level, which includes:  
  
    1.  Traffic Class Management  
  
    2.  Priority Flow Control \(PFC\) Settings  
  
    3.  Application Priority Assignment  
  
    4.  DCBX settings  
  
2.  Configure DCB on the Network Adapter  
  
DCB PowerShell commands have “QoS” as opposed to “DCB” in the name string. This is by design because QoS and DCB are integrated in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to provide a seamless QoS management experience.  
  
### <a name="BKMK_DCB_TrafficClassMgmnt"></a>Traffic Class management  
Following are command examples for Traffic Class management:  
  
#### Create Traffic Class  
  
```  
  
PS C:\> New-NetQosTrafficClass -name "SMB class" -priority 4 -bandwidthPercentage 30 -Algorithm ETS  
  
Name                      Algorithm Bandwidth(%) Priority  
------                    --------- ------------ --------  
SMB class                 ETS       30           4  
  
PS C:\>  
  
```  
  
By default, all 802.1p values are mapped to a default traffic class, which has 100% of the bandwidth of the physical link. The above command just creates a new traffic class, to which any packet tagged with 8 Microsoft Confidential 802.1p value 4 will be mapped, and its Transmission Selection Algorithm \(TSA\) is ETS and has 30% of the bandwidth.  
  
You can create up to 7 new traffic classes. Plus the default traffic class, there will be 8 traffic classes in the system at most. However, a DCB capable network adapter may not support that many traffic classes in the hardware. If you create more traffic classes than can be accommodated on a network adapter and you enable DCB on that network adapter, the miniport driver should report to theoperating systeman error, which will be event\-logged.  
  
#### Display traffic class  
  
```  
  
PS C:\> Get-NetQoSTrafficClass  
  
Name                      Algorithm  Bandwidth(%)  Priority  
------                    ---------  ------------  --------  
[Default]                 ETS        70            0-3,5-7  
SMB class                 ETS        30            4  
  
PS C:\>  
  
```  
  
#### Modify Traffic Class  
  
```  
  
PS C:\> Set-NetQoSTrafficClass -Name "SMB class" -BandwidthPercentage 40  
PS C:\> get-NetQosTrafficClass  
  
Name            Algorithm  Bandwidth(%)  Priority  
----            ---------  ------------  --------  
[Default]       ETS        60            0-3,5-7  
SMB class       ETS        40            4  
  
PS C:\>  
  
```  
  
After you have a traffic class you can change its settings independently. The settings you can change include:  
  
1.  bandwidth allocation \(\-BandwidthPercentage\)  
  
2.  TSA \(\-Algorithm\)  
  
3.  priority mapping \(\-Priority\)  
  
#### Remove Traffic Class  
  
```  
  
PS C:\> Remove-NetQosTrafficClass -Name "SMB class"  
PS C:\> Get-NetQosTrafficClass  
  
Name             Algorithm  Bandwidth(%)  Priority  
----             ---------  ------------  --------  
[Default]        ETS        100           0-7  
  
PS C:\>  
  
```  
  
After you remove a traffic class, the 802.1p value mapped to that traffic class is remapped to the default traffic class. Bandwidth is also returned back to the default traffic class.  
  
You cannot remove the default traffic class  
  
### <a name="BKMK_DCB_PFCSettings"></a>Priority Flow Control settings:  
Following are command examples for Priority Flow Control settings:  
  
#### Enable Priority Flow Control  
  
```  
  
PS C:\> Enable-NetQosFlowControl -priority 4  
PS C:\> Get-NetQosFlowControl -priority 4  
  
Priority   Enabled  
--------   -------  
4           True  
  
PS C:\>  
  
```  
  
#### Display Priority Flow Control…  
  
```  
  
PS C:\> Get-NetQosFlowControl  
  
Priority   Enabled  
--------   -------  
0          False  
1          False  
2          False  
3          False  
4          True  
5          False  
6          False  
7          False  
  
PS C:\>  
  
```  
  
#### Disable Priority Flow Control  
  
```  
  
PS C:\> disable-NetQosflowControl -priority 4  
PS C:\> get-NetQosFlowControl -priority 4  
  
Priority    Enabled  
--------    -------  
4           False  
  
PS C:\>  
  
```  
  
### <a name="BKMK_DCB_AppPriAssign"></a>Application Priority assignment  
Following are examples of Priority assignment  
  
#### Create QoS Policy  
  
```  
  
PS C:\> New-NetQosPolicy -Name "SMB policy" -PriorityValue8021Action 4  
  
Name              : SMB policy  
Owner             : Group Policy (Machine)  
NetworkProfile    : All  
Precedence        : 127  
PriorityValue     : 4  
  
PS C:\>  
  
```  
  
The previous command creates a new policy for SMB. –SMB is an inbox filter that matches TCP port 445 \(reserved for SMB\). If a packet is sent to TCP port 445 it will be tagged by theoperating systemwith 802.1p value of 4 before the packet is passed to a network miniport driver.  
  
In addition to –SMB, other default filters include –iSCSI \(matching TCP port 3260\), \-NFS \(matching TCP port 2049\), \-LiveMigration \(matching TCP port 6600\), \-FCOE \(matching EtherType 0x8906\) and –NetworkDirect.  
  
NetworkDirect is an abstract layer we create on top of any RDMA implementation on a network adapter. –NetworkDirect must be followed by a Network Direct port.  
  
In addition to the default filters, you can classify traffic by application’s executable name \(as in the first example below\), or by IP address, port, or protocol \(as shown in the second example\):  
  
**By executable name**  
  
```  
  
PS C:\> New-NetQosPolicy "background" -AppPathNameMatchcondition "c:\Program files (x86)\backup.exe" -PriorityValue8021Action 1  
  
Name           : background  
Owner          : Group Policy (Machine)  
NetworkProfile : All  
Precedence     : 127  
AppPathName    : c:\Program files (x86)\backup.exe  
PriorityValue  : 1  
  
PS C:\>  
  
```  
  
**By IP address port or protocol**  
  
```  
  
PS C:\> New-NetQosPolicy "Network Management" -IPDstPrefixMatchCondition 10.240.1.0/24 -IPProtocolMatchCondition both -NetworkProfile all-PriorityValue8021Action 7  
  
Name :  Network Management  
Owner            :  Group Policy (Machine)  
Network Profile  :  All  
Precedence       :  127  
IPProtocol       :  Both  
IPDstPrefix      :  10.240.1.0/24  
PriorityValue    :  7  
  
```  
  
#### Display QoS Policy  
  
```  
  
Display QoS policy  
PS C:\> Get-NetQosPolicy  
  
Name            : Network Management  
Owner           : (382ACFAD-1E73-46BD-A0A-6-4EE0E587B95)  
NetworkProfile  : All  
Precedence      : 127  
IPProtocol      : Both  
IPDstPrefix     : 10.240.1.0/24  
PriorityValue   : 7  
  
Name            : SMB policy  
Owner           : (382AFAD-1E73-46BD-A0A-6-4EE0E587B95)  
NetworkProfile  : All  
Precedence      : 127  
Template        : SMB  
PriorityValue   : 4  
  
```  
  
#### Modify QoS Policy  
You can either modify QoS policies inline \(first screen shot below\) or in an object oriented fashion \(second screen shot below\).  
  
**Inline**  
  
```  
  
PS C:\> Set-NetqosPolicy -Name "Network Management" -IPSrcPrefixMatchCondition 10.235.2.0/24 -IPProtocolMatchCondition both -PriorityValue 802.1Action 7   
PS C:\> Get-NetQosPolicy -name "network management"  
  
Name            : Network Management  
Owner           : {382ACFD-1E73-46BD-A0A0-4EE0E587B95}  
NetworkProfile  : All  
Precedence      : 127  
IPProtocol      : Both  
IPSrcPrefix     : 10.235.2.0/24  
IPDstPrefix     : 10.240.1.0/24  
PriorityValue   : 7  
  
```  
  
**Object oriented**  
  
```  
  
PS C:\> $obj = Get-NetQosPolicy "Network Management"  
PS C:\> $obj  
  
Name           : Network Management  
Owner          : (382ACFAD-1E73-46BD-A0A0-64EE0E587B95)  
NetworkProfile : 127  
IPProtocol     : Both  
IPSrcPrefix    : 10.235.2.0/24  
IPDstPrefix    : 10.240.1.0/24  
PriorityValue  : 7  
  
PS C:\> $obj.NetworkProfile = "Domain"  
PS C:\> $obj.PriorityValue = 6  
PS C:\> $obj | Set-NetQosPolicy  
PS C:\> Get-NetQosPolicy "Network Management"  
  
Name           : Network Management  
Owner          : (382ACFAD-1E73-46BD-A0A0-64EE0E587B95)  
NetworkProfile : Domain  
Precedence     : 127  
IPProtocol     : Both  
IPSrcPrefix    : 10.235.2.0/24  
IPDstPrefix    : 10.240.1.0/24  
PriorityValue  : 6  
  
```  
  
#### Remove QoS Policy  
  
```  
  
PS C:\> Remove-NetQosPolicy -Name "Network Management"   
PS C:\>  
  
```  
  
### <a name="BKMK_DCBX_Settings"></a>DCBX settings  
You can either modify QoS policies inline \(first screen shot below\) or in an object oriented fashion \(second screen shot below\).  
  
-   Turn the DCBX Willing bit to false \(zero\)  
  
-   Enable DCB on the network adapters \(see DCB Configuration on Network Adapter\)  
  
The DCBX Willing bit is specified in the DCB specification. If the Willing bit on a device is true it means the device is willing to accept configurations from a remote device through DCBX. If the Willing bit on a device is false it means the device will reject any configuration from a remote device and enforce only the local configurations.  
  
If DCB is not installed in Windows Server 2012 the value of the Willing bit is irrelevant as far as theoperating systemis concerned because theoperating systemhas no local settings to push down to network adapters. After DCB is installed, the default value of this Willing bit is true – this design allows network adapters to keep whatever configurations they may have received from their remote peers.  
  
If a network adapter doesn’t support DCBX it will never receive configurations from a remote device. It will receive configurations from theoperating systemonly after the DCBX Willing bit is set to false in the operating system.  
  
#### <a name="BKMK_DCB_SetWillingBit"></a>Set the Willing bit  
To enforce theoperating systemconfigurations of traffic class, PFC and application priority assignment on network adapters – or simply override the configurations from remote devices, if there’s any, you should run the following command:  
  
```  
  
PS C:\Windows\system32> Set-NetQosDcbxSetting -Willing 0  
  
Confirm  
Are you sure you want to perform this action?  
Set-NetQosDcbxSetting -Willing $false  
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y  
PS C:\Windows\system32>cls  
  
```  
  
#### <a name="BKMK_DCB_DisplayWillingBit"></a>Display the Willing bit  
  
```  
  
PS C:\> Get-NetQoSDcbxSetting  
  
Willing  
-------  
False  
  
PS C:\>  
  
```  
  
### <a name="BKMK_DCB_ConfigNetAdapter"></a>DCB configuration on network adapters  
DCB configuration on network adapters is independent of DCB configuration at the system level described above. Regardless of whether DCB is installed in Windows Server 2012 or not, you can always run the following commands. If you configure DCB from a switch and rely on DCBX to propagate the configurations to network adapters, you can examine what configurations are received and enforced on the network adapters from theoperating systemside after you enable DCB on the network adapters.  
  
#### <a name="BKMK_DCB_DisplaySettingsOnAdapter"></a>Display DCB setting on network adapters  
  
```  
  
PS C:\> Get-NetAdapterQos  
  
Network Adapter Name     : Wired Ethernet Connection 4  
QoS Enabled              : True  
MACsec Bypass Supported  : False  
Traffic Classes (TCs)    : 8  
ETS-Capable TCs          : 8  
PFC-Enabled TCs          : 8  
Operational TC Mappings  : TC   TSA  Bandwidth  Priorities  
         --   ---  ---------  ----------  
          0   ETS       100%  0-7  
Operational PFC Enabled  : Priority 4  
Remote TC Mappings       : TCTSA  Bandwidth  Priorities  
         -----  --------   ----------  
          0ETS       12%   1  
          1ETS       13%   0  
          2ETS       12%   2  
          3ETS       13%   3  
          4ETS       12%   4  
          5ETS       13%   5  
          6ETS       12%   6  
          7ETS       13%   7  
Remote PFC Enabled      : All Priorities Disabled  
Remote Classifications  : Protocol   Port/Type  Priority  
        --------   ---------  --------  
                          Ethertype     0x8906  1  
                                TCP       3260  2  
  
```  
  
#### <a name="BKMK_DCB_DisplayDCBOnAdapter"></a>Disable DCB on network adapters  
  
```  
  
PS C:\> Disable-NetAdapterQos "Wired Ethernet Connection 4"  
PS C:\> Get-NetAdapterQos "Wired Ethernet Connection 4"  
  
Network Adapter Name    : Wired Ethernet Connection 4  
QoS Enabled             : False  
MACsec Bypass Supported : False  
Traffic Classes (TCs)   : 0  
ETS-Capable TCs         : 0  
PFC-Enabled TCs         : 0  
  
```  
  
#### <a name="BKMK_DCB_EnableDCBSettingsOnAdapter"></a>Enable DCB on network adapters  
  
```  
  
PS C:\> Enable-NetAdapterQos "Wired Ethernet Connection 4"  
PS C:\>  
  
```  
  
## More Information  
For more information about DCB, see: [Data Center Bridging \(DCB\) Overview](http://technet.microsoft.com/library/hh849179.aspx).  
  

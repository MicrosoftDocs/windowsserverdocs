---
title: Manage Data Center Bridging (DCB)
description: This topic provides you with instructions on how to use Windows PowerShell commands to manage Data Center Bridging in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 1575cc7c-62a7-4add-8f78-e5d93effe93f
manager: brianlic
ms.author: pashort
author: shortpatti
---

# Manage Data Center Bridging (DCB)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides you with instructions on how to use Windows PowerShell commands to configure Data Center Bridging \(DCB\) on a DCB\-compatible network adapter that is installed in a computer that is running either Windows Server 2016 or Windows 10.

## Install DCB in Windows Server 2016 or Windows 10

For information on prerequisites for using and how to install DCB, see [Install Data Center Bridging (DCB) in Windows Server 2016 or Windows 10](dcb-install.md).


## DCB configurations 

Prior to Windows Server 2016, all DCB configuration was applied universally to
all network adapters that supported DCB. 

In Windows Server 2016, you can apply DCB configurations either to the Global Policy Store or to individual Policy Store\(s\). When Individual Policies are applied they override all Global Policy settings.

The configurations of traffic class, PFC and application priority assignment at
the system level is not applied on network adapters until you do the following.

1. Turn the DCBX Willing bit to false

2. Enable DCB on the network adapters. See [Enable and Display DCB Settings on  Network Adapters](#bkmk_enabledcb).

>[!NOTE]
>If you want to configure DCB from a switch through DCBX, see [DCBX settings](#dcb-configuration-on-network-adapters).

The DCBX Willing bit is described in the DCB specification. If the Willing bit on a device is set to true, the device is willing to accept configurations from a remote device through DCBX. If the Willing bit on a device is set to false, the device will reject all configuration attempts from remote devices and enforce only the local configurations.

If DCB is not installed in Windows Server 2016 the value of the Willing bit is irrelevant as far as the operating system is concerned because the operating system has no local settings apply to network adapters. After DCB is installed, the default value of the Willing bit is true. This design allows network adapters to keep whatever configurations they may have received from their
remote peers.

If a network adapter doesn’t support DCBX, it will never receive configurations from a remote device. It does receive configurations from the operating system, but only after the DCBX Willing bit is set to false.

## Set the Willing bit

To enforce operating system configurations of traffic class, PFC, and application priority assignment on network adapters, or to simply override the configurations from remote devices \— if there are any \— you can run the following command.

>[!NOTE]
>DCB Windows PowerShell command names include “QoS” instead of “DCB” in the name string. This
is because QoS and DCB are integrated in Windows Server 2016 to provide a seamless QoS management experience.

    
    Set-NetQosDcbxSetting -Willing $FALSE
    
    Confirm
    Are you sure you want to perform this action?
    Set-NetQosDcbxSetting -Willing $false
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
    

To display the state of the Willing bit setting, you can use the following command:

    
    Get-NetQosDcbxSetting
    
    Willing PolicySetIfIndex IfAlias
    ------- ---------------- -------
    False   Global  
    

## DCB Configuration on Network Adapters

Enabling DCB on a network adapter allows you to see the configuration propagated from a switch to the network adapter.

DCB configurations include the following steps.

1.  Configure DCB settings at the system level, which includes:

	a. Traffic Class Management
	
	b. Priority Flow Control (PFC) Settings
	
	c. Application Priority Assignment
	
	d. DCBX settings

2. Configure DCB on the network adapter.



##  DCB Traffic Class management

Following are example Windows PowerShell commands for Traffic Class management.

### Create a Traffic Class

You can use the **New-NetQosTrafficClass** command to create a traffic class.

    
    New-NetQosTrafficClass -Name SMB -Priority 4 -BandwidthPercentage 30 -Algorithm ETS
    
    Name Algorithm Bandwidth(%) Priority PolicySetIfIndex IfAlias
    ---- --------- ------------ -------- ---------------- -------
    SMB  ETS   30   4Global
      

By default, all 802.1p values are mapped to a default traffic class, which has 100% of the bandwidth of the physical link. The **New-NetQosTrafficClass** command creates a new traffic class, to which any packet that is tagged with 802.1p priority value 4 is mapped. The Transmission Selection Algorithm \(TSA\) is ETS and has 30% of the bandwidth.

You can create up to 7 new traffic classes. Including the default traffic class, there can be at most 8 traffic classes in the system. However, a DCB capable network adapter might not support that many traffic classes in the hardware. If you create more traffic classes than can be accommodated on a network adapter and you enable DCB on that network adapter, the miniport driver reports an error to the operating system. The error is logged in the Event log.

The sum of the bandwidth reservations for all created traffic classes may not exceed 99% of the bandwidth. The default traffic class always has at least 1% of the bandwidth reserved for itself.

### Display Traffic Classes

You can use the **Get-NetQosTrafficClass** command to view traffic classes.

    Get-NetQosTrafficClass
    
    NameAlgorithm Bandwidth(%) Priority PolicySetIfIndex IfAlias
    ------------- ------------ -------- ---------------- -------
    [Default]   ETS   70   0-3,5-7  Global
    SMB ETS   30   4Global  
    
### Modify a Traffic Class

You can use the **Set-NetQosTrafficClass** command to create a traffic class. 

    Set-NetQosTrafficClass -Name SMB -BandwidthPercentage 50

You can then use the **Get-NetQosTrafficClass** command to view settings.

    Get-NetQosTrafficClass
    
    NameAlgorithm Bandwidth(%) Priority PolicySetIfIndex IfAlias
    ------------- ------------ -------- ---------------- -------
    [Default]   ETS   50   0-3,5-7  Global
    SMB ETS   50   4Global   
    

After you create a traffic class, you can change its settings independently. The
settings you can change include:

1. Bandwidth allocation \(-BandwidthPercentage\)

2. TSA (\-Algorithm\)

3. Priority mapping \(-Priority\)

### Remove a Traffic Class

You can use the **Remove-NetQosTrafficClass** command to delete a traffic class.

>[!IMPORTANT]
>You cannot remove the default traffic class.


    Remove-NetQosTrafficClass -Name SMB

You can then use the **Get-NetQosTrafficClass** command to view settings.
    
    Get-NetQosTrafficClass
    
    NameAlgorithm Bandwidth(%) Priority PolicySetIfIndex IfAlias
    ------------- ------------ -------- ---------------- -------
    [Default]   ETS   100  0-7  Global
    

After you remove a traffic class, the 802.1p value mapped to that traffic class is remapped to the default traffic class. Any bandwidth that was reserved for a traffic class is returned to the default traffic class allocation when the traffic class is removed.

## Per-Network Interface Policies

All of the above examples set Global policies. Following are examples of how you can set and get per-NIC policies. 

The “PolicySet” field changes from Global to AdapterSpecific. When AdapterSpecific policies are shown, the Interface Index \(ifIndex\) and Interface Name \(ifAlias\) are also displayed.

```
PS C:\> Get-NetQosTrafficClass

Name        Algorithm Bandwidth(%) Priority         PolicySet        IfIndex IfAlias
----        --------- ------------ --------         ---------        ------- -------
[Default]   ETS       100          0-7              Global


PS C:\> Get-NetQosTrafficClass -InterfaceAlias M1

Name        Algorithm Bandwidth(%) Priority         PolicySet        IfIndex IfAlias
----        --------- ------------ --------         ---------        ------- -------
[Default]   ETS       100          0-7              AdapterSpecific  4       M1


PS C:\> New-NetQosTrafficClass -Name SMBGlobal -BandwidthPercentage 30 -Priority 4 -Algorithm ETS

Name        Algorithm Bandwidth(%) Priority         PolicySet        IfIndex IfAlias
----        --------- ------------ --------         ---------        ------- -------
SMBGlobal   ETS       30           4                Global


PS C:\> New-NetQosTrafficClass -Name SMBforM1 -BandwidthPercentage 30 -Priority 4 -Algorithm ETS -Interfac


Name        Algorithm Bandwidth(%) Priority         PolicySet        IfIndex IfAlias
----        --------- ------------ --------         ---------        ------- -------
SMBforM1    ETS       30           4                AdapterSpecific  4       M1


PS C:\> Get-NetQosTrafficClass

Name        Algorithm Bandwidth(%) Priority         PolicySet        IfIndex IfAlias
----        --------- ------------ --------         ---------        ------- -------
[Default]   ETS       70           0-3,5-7          Global
SMBGlobal   ETS       30           4                Global


PS C:\> Get-NetQosTrafficClass -InterfaceAlias M1

Name        Algorithm Bandwidth(%) Priority         PolicySet        IfIndex IfAlias
----        --------- ------------ --------         ---------        ------- -------
[Default]   ETS       70           0-3,5-7          AdapterSpecific  4       M1
SMBforM1    ETS       30           4                AdapterSpecific  4       M1


```

## Priority Flow Control settings:

Following are command examples for Priority Flow Control settings. These settings can also be specified for individual adapters.

### Enable and Display Priority Flow Control for Global and Interface Specific use cases

```
PS C:\> Enable-NetQosFlowControl -Priority 4
PS C:\> Enable-NetQosFlowControl -Priority 3 -InterfaceAlias M1
PS C:\> Get-NetQosFlowControl

Priority   Enabled    PolicySet        IfIndex IfAlias
--------   -------    ---------        ------- -------
0          False      Global
1          False      Global
2          False      Global
3          False      Global
4          True       Global
5          False      Global
6          False      Global
7          False      Global

PS C:\> Get-NetQosFlowControl -InterfaceAlias M1

Priority   Enabled    PolicySet        IfIndex IfAlias
--------   -------    ---------        ------- -------
0          False      AdapterSpecific  4       M1
1          False      AdapterSpecific  4       M1
2          False      AdapterSpecific  4       M1
3          True       AdapterSpecific  4       M1
4          False      AdapterSpecific  4       M1
5          False      AdapterSpecific  4       M1
6          False      AdapterSpecific  4       M1
7          False      AdapterSpecific  4       M1  

```


### Disable Priority Flow Control (Global and Interface Specific)

```
PS C:\> Disable-NetQosFlowControl -Priority 4
PS C:\> Disable-NetQosFlowControl -Priority 3 -InterfaceAlias m1
PS C:\> Get-NetQosFlowControl

Priority   Enabled    PolicySet        IfIndex IfAlias
--------   -------    ---------        ------- -------
0          False      Global
1          False      Global
2          False      Global
3          False      Global
4          False      Global
5          False      Global
6          False      Global
7          False      Global


PS C:\> Get-NetQosFlowControl -InterfaceAlias M1

Priority   Enabled    PolicySet        IfIndex IfAlias
--------   -------    ---------        ------- -------
0          False      AdapterSpecific  4       M1
1          False      AdapterSpecific  4       M1
2          False      AdapterSpecific  4       M1
3          False      AdapterSpecific  4       M1
4          False      AdapterSpecific  4       M1
5          False      AdapterSpecific  4       M1
6          False      AdapterSpecific  4       M1
7          False      AdapterSpecific  4       M1  

```

##  Application Priority assignment

Following are examples of Priority assignment.

### Create QoS Policy

```
PS C:\> New-NetQosPolicy -Name "SMB Policy" -PriorityValue8021Action 4

Name           : SMB Policy
Owner          : Group Policy (Machine)
NetworkProfile : All
Precedence     : 127
JobObject      :
PriorityValue  : 4

```

The previous command creates a new policy for SMB. –SMB is an inbox filter that matches TCP port 445 (reserved for SMB). If a packet is sent to TCP port 445 it will be tagged by the operating system with 802.1p value of 4 before the packet is passed to a network miniport driver.

In addition to –SMB, other default filters include –iSCSI (matching TCP port 3260), -NFS (matching TCP port 2049), -LiveMigration (matching TCP port 6600), -FCOE (matching EtherType 0x8906) and –NetworkDirect.

NetworkDirect is an abstract layer we create on top of any RDMA implementation on a network adapter. –NetworkDirect must be followed by a Network Direct port.

In addition to the default filters, you can classify traffic by application’s executable name (as in the first example below), or by IP address, port, or protocol (as shown in the second example):

**By executable name**

```
PS C:\> New-NetQosPolicy -Name background -AppPathNameMatchCondition "C:\Program files (x86)\backup.exe" -PriorityValue8021Action 1

Name           : background
Owner          : Group Policy (Machine)
NetworkProfile : All
Precedence     : 127
AppPathName    : C:\Program files (x86)\backup.exe
JobObject      :
PriorityValue  : 1

```


**By IP address port or protocol**

```
PS C:\> New-NetQosPolicy -Name "Network Management" -IPDstPrefixMatchCondition 10.240.1.0/24 -IPProtocolMatchCondition both -NetworkProfile all -PriorityValue8021Action 7

Name           : Network Management
Owner          : Group Policy (Machine)
NetworkProfile : All
Precedence     : 127
JobObject      :
IPProtocol     : Both
IPDstPrefix    : 10.240.1.0/24
PriorityValue  : 7

```

### Display QoS Policy

```
PS C:\> Get-NetQosPolicy

Name           : background
Owner          : Group Policy (Machine)
NetworkProfile : All
Precedence     : 127
AppPathName    : C:\Program files (x86)\backup.exe
JobObject      :
PriorityValue  : 1

Name           : Network Management
Owner          : Group Policy (Machine)
NetworkProfile : All
Precedence     : 127
JobObject      :
IPProtocol     : Both
IPDstPrefix    : 10.240.1.0/24
PriorityValue  : 7

Name           : SMB Policy
Owner          : Group Policy (Machine)
NetworkProfile : All
Precedence     : 127
JobObject      :
PriorityValue  : 4

```

### Modify QoS Policy

You can modify QoS policies as shown below.


```
PS C:\> Set-NetQosPolicy -Name "Network Management" -IPSrcPrefixMatchCondition 10.235.2.0/24 -IPProtocolMatchCondition both -PriorityValue8021Action 7
PS C:\> Get-NetQosPolicy

Name           : Network Management
Owner          : Group Policy (Machine)
NetworkProfile : All
Precedence     : 127
JobObject      :
IPProtocol     : Both
IPSrcPrefix    : 10.235.2.0/24
IPDstPrefix    : 10.240.1.0/24
PriorityValue  : 7


```

### Remove QoS Policy

```
PS C:\> Remove-NetQosPolicy -Name "Network Management"

Confirm
Are you sure you want to perform this action?
Remove-NetQosPolicy -Name "Network Management" -Store GPO:localhost
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y  

```

## DCB configuration on network adapters

DCB configuration on network adapters is independent of DCB configuration at the system level described above. 

Regardless of whether DCB is installed in Windows Server 2016, you can always run the following commands. 

If you configure DCB from a switch and rely on DCBX to propagate the configurations to network adapters, you can examine what configurations are received and enforced on the network adapters from the operating system side after you enable DCB on the network adapters.

###  <a name="bkmk_enabledcb"></a>Enable and Display DCB Settings on  Network Adapters

```
PS C:\> Enable-NetAdapterQos M1
PS C:\> Get-NetAdapterQos

Name                       : M1
Enabled                    : True
Capabilities               :                       Hardware     Current
                                                   --------     -------
                             MacSecBypass        : NotSupported NotSupported
                             DcbxSupport         : None         None
                             NumTCs(Max/ETS/PFC) : 8/8/8        8/8/8

OperationalTrafficClasses  : TC TSA    Bandwidth Priorities
                             -- ---    --------- ----------
                              0 ETS    70%       0-3,5-7
                              1 ETS    30%       4

OperationalFlowControl     : All Priorities Disabled
OperationalClassifications : Protocol  Port/Type Priority
                             --------  --------- --------
                             Default             1


```

### Disable DCB on Network Adapters

```
PS C:\> Disable-NetAdapterQos M1
PS C:\> Get-NetAdapterQos M1

Name         : M1
Enabled      : False
Capabilities :                       Hardware     Current
                                     --------     -------
               MacSecBypass        : NotSupported NotSupported
               DcbxSupport         : None         None
               NumTCs(Max/ETS/PFC) : 8/8/8        0/0/0  

```
## <a name="bkmk_wps"></a>Windows PowerShell Commands for DCB

There are DCB Windows PowerShell commands for both Windows Server 2016 and Windows Server 2012 R2. You can use all of the commands for Windows Server 2012 R2 in Windows Server 2016.

### Windows Server 2016 Windows PowerShell Commands for DCB

The following topic for Windows Server 2016 provides Windows PowerShell cmdlet descriptions and syntax for all Data Center Bridging \(DCB\) Quality of Service \(QoS\)\-specific cmdlets. It lists the cmdlets in alphabetical order based on the verb at the beginning of the cmdlet.

- [DcbQoS Module](https://technet.microsoft.com/itpro/powershell/windows/dcbqos/dcbqos)

### Windows Server 2012 R2 Windows PowerShell Commands for DCB

The following topic for Windows Server 2012 R2 provides Windows PowerShell cmdlet descriptions and syntax for all Data Center Bridging \(DCB\) Quality of Service \(QoS\)\-specific cmdlets. It lists the cmdlets in alphabetical order based on the verb at the beginning of the cmdlet.

- [Data Center Bridging (DCB) Quality of Service (QoS) Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/hh967440.aspx)

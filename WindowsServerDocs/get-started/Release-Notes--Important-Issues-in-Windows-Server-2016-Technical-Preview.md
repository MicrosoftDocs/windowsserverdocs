---
title: Release Notes - Important Issues in Windows Server 2016 Technical Preview
description: critical issues requiring workaround to avoid crash, hang, installation failure, data loss
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 08/09/2016
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 134aab85-664f-4d44-87ef-9e5fd389071f
author: jaimeo
manager: dongill
---
# Release Notes: Important Issues in Windows Server 2016 Technical Preview

>Applies To: Windows Server Technical Preview

These release notes summarize the most critical issues in the Windows Server&reg; 2016 Technical Preview operating system, including ways to avoid or work around the issues, if known. For information about by-design changes, new features, and fixes in this release, see [What's New in the Windows Server Technical Preview](http://technet.microsoft.com/library/dn765472.aspx) and announcements from the specific feature teams. Unless otherwise specified, each reported issue applies to all editions and installation options of Windows Server 2016 Technical Preview.  

This document is continuously updated. As critical issues requiring a workaround are discovered, they are added.  

> [!IMPORTANT]  
> This preview release should not be used in production environments.  

> [!IMPORTANT]  
> Upgrades to this release are supported, but not all server roles can successfully be upgraded. See the documentation for specific server roles before attempting to upgrade.  
>   
> If you do attempt to upgrade to this release from Windows Server 2016 Technical Preview 4 (perhaps for testing purposes), you will have to re-do any custom configurations.  

## Server roles and features  
[comment]: # (ID: 362; Submitter: milanp; state: signed off)  
> [!IMPORTANT]  
> Install Cumulative Update for Windows Server 2016 Technical Preview 5 (KB3157663) before installing any server roles, features, or other products.  
>  
>If you install roles before installing the update, a variety of issues can occur. If this happens, reinstall the preview release and then immediately install the update.  

## Hyper-V  

[comment]: # (ID: 358; Submitter: donst; state: signed off)  

- If you delete a NIC team before deleting the virtual switch bound to it, the host will become unusable.  
To avoid this, delete the switch before deleting the team. If this has already occurred, restart the host.  

[comment]: # (ID: 361; Submitter: amason; state: signed off)  

- This issue affects the Nano Server installation option  
If you attempt to create a virtual machine checkpoint with `Checkpoint-VM`, the operation will fail.  
To avoid this, use the following WMI script to create a checkpoint:  


```  
param(  
    [Parameter(ParameterSetName='Name', Mandatory=$true)]  
    [ValidateNotNullOrEmpty()]  
    [string]  
    $VmName = $null,  

    [Parameter(ParameterSetName='Id', Mandatory=$true)]  
    [ValidateNotNullOrEmpty()]  
    [Guid]  
    $VmId = [guid]::Empty,  

    [string]  
    $SnapshotName = $null,  

    [switch]  
    $Passthru  
    )  

function SerializeObject()  
{  
    param(  
        [Microsoft.Management.Infrastructure.CimInstance]$Instance  
    )  

    $CimSerializer = [Microsoft.Management.Infrastructure.Serialization.CimSerializer]::Create()  
    $SerializedInstance = `  
                $CimSerializer.Serialize(  
                    $Instance,   
                    [Microsoft.Management.Infrastructure.Serialization.InstanceSerializationOptions]::None)  
    return [System.Text.Encoding]::Unicode.GetString($SerializedInstance)   
}  

$namespace = "root\virtualization\v2"  
$vm = $null  
if ([string]::IsNullOrEmpty($VmName))  
{  
    $vm = Get-CimInstance -Namespace $namespace -Query "SELECT * FROM Msvm_ComputerSystem WHERE Name = '$VmId'"  
}  
else  
{  
    $vm = Get-CimInstance -Namespace $namespace -Query "SELECT * FROM Msvm_ComputerSystem WHERE ElementName = '$VmName'"  
}  

$checkpointService = Get-CimInstance -Namespace $namespace -Class "Msvm_VirtualSystemSnapshotService"  

Write-Verbose "Checkpointing VM"  

$checkpointParameters = @{"AffectedSystem" = $vm; "SnapshotSettings" = ""; "SnapshotType" = [UInt16]2}  
$checkpointResult = Invoke-CimMethod -InputObject $checkpointService -MethodName "CreateSnapshot" -Arguments $checkpointParameters  

Write-Verbose "Result: $($checkpointResult.ReturnValue)"  
if ($checkpointResult.ReturnValue -eq 4096)  
{  
    $checkpointJob = Get-CimInstance -InputObject $checkpointResult.Job  
    while ($checkpointJob.PercentComplete -ne 100)  
    {  
        Write-Verbose "Waiting for job to complete. $($checkpointJob.PercentComplete)"  
        Start-Sleep -Seconds 1  
        $checkpointJob = Get-CimInstance -InputObject $checkpointResult.Job  
    }  

    $checkpoint = Get-CimAssociatedInstance -InputObject $checkpointJob -ResultClassName "Msvm_VirtualSystemSettingData" | %{return $_; break; }  
    if (![string]::IsNullOrEmpty($SnapshotName))  
    {  
        Write-Verbose "Updating the checkpoint name."  

        $checkpoint.ElementName = $SnapshotName  
        $vmms = Get-CimInstance -Namespace $namespace -Class "Msvm_VirtualSystemManagementService"  

        $updateParameters = @{"SystemSettings" = $(SerializeObject $checkpoint)}  
        $updateJob = Invoke-CimMethod -InputObject $vmms -MethodName "ModifySystemSettings" -Arguments $updateParameters  

        Write-Verbose "Rename Result: $($updateJob.ReturnValue)"  

        $checkpoint = Get-CimInstance -InputObject $checkpoint  
    }  

    if ($Passthru)  
    {  
        Write-Object $checkpoint  
    }  
}  
else  
{  
    if ($Passthru)  
    {  
        Write-Object $checkpointResult.ResultingSnapshot  
    }  
}  



```  
Examples:  

`Checkpoint.ps1 -VmName "Test" -SnapshotName "Test" -Verbose`  
`Checkpoint.ps1 -VmName "Test" -SnapshotName "Test2" -Passthru`  



## License terms  
[comment]: # (ID: 341; Submitter: staceycl; state: signed off)  
If you choose the Server Core installation option, the license terms are displayed only in English. You can view the license terms in other languages by choosing the Server with Desktop option or from [Windows Server 2016 Technical Preview 5 License Terms](http://download.microsoft.com/download/7/7/E/77E492F5-BC71-4CA5-9CF1-DD29535AA6B8/Windows_Server_2016_Technical_Preview_5_License_Terms.zip).  

## Login after upgrade  
[comment]: # (ID: 356; Submitter: amason; state: signed off)  
If you upgrade a server from Windows Server 2012 R2 to Windows Server 2016 Technical Preview that is not joined to a domain and is in Desktop Experience mode, you will need to set a new administrator password. On first logon, the  interface will prompt you to change the Administrator password without asking for the old password.  
If at that point you enter a new password and confirm it, that will become the password.  
If, however, you cancel out of the password prompt at that point and attempt to sign in later, you will receive a different password prompt that does ask for the old password. If this occurs, leave the old password box blank.  

## Nano Server Recovery Console  
[comment]: # (ID: 343; Submitter: amason; state: signed off)  
The Nano Server Recovery Console is available in English only. There is no workaround.  

## Remote Desktop Gateway  

[comment]: # (ID: 363; Submitter: chrimo; state: signed off)  
- If you have existing NAP policies and attempt to upgrade a Remote Desktop Gateway server to this release, the upgrade will fail.  
To avoid this, use the Network Policy Server tool to remove the NAP Policies found under NPS > Polices > Network Policies. If these NAP Policies were created with the default names, the policy names you should remove will start with "NAP". (If you encounter this error, you will also find an XML file on the desktop which lists the specific policies found.)  


[comment]: # (ID: 364; Submitter: chrimo; state: signed off)  
- Remote Desktop Gateway is not supported in Server Core installations of this release and will not install. If you need Remote Desktop Gateway, install this release using the Server with Desktop Experience option.  

## Shutdown and restart behavior  
[comment]: # (ID: 344; Submitter: amason; state: signed off)  
If you've installed in Windows Server with Desktop Experience mode and you then shut down or restart the server, you might get a notification that there are apps with changes to save. If there actually are apps with changes to save and you click **Cancel**, the operation cancels normally. If there are no apps with changes to save and you click **Cancel**, the server restarts. In either case, if you click **Reboot now**, the server restarts.  

## Uninstalling roles and features  
[comment]: # (ID: 345; Submitter: samli; state: out for review)  
You cannot uninstall certain roles and features by using Server Manager or PowerShell. If uninstallation fails with an error, you can work around this issue by using Dism.exe. The DISM feature name might be different from the standard role or feature name. You can use the following script to help identify the DISM feature name of the role or feature you want to uninstall:  


```  
 # Use this script to determine the equivalent DISM feature name for any server role or feature in Server Manager or Get-WindowsFeature  

$RoleOrFeatureName = "PLACEHOLDER-ROLEORFEATURENAME"  
$RoleOrFeatureExists = Get-WindowsFeature $RoleOrFeatureName  
if ($RoleOrFeatureExists) {  
    Write-Host "Role or Feature Name:        ", $RoleOrFeatureExists.Name  
    Write-Host "Role or Feature DisplayName: ", $RoleOrFeatureExists.DisplayName  
    Write-host "Equivalent DISM feature name:", $RoleOrFeatureExists.AdditionalInfo.Item("InstallName")  
} else {  
    Write-Host "No role or feature exists with the name", $RoleOrFeatureName, "-- Use Get-WindowsFeature to see the full list of names."  
}  
```  
Although this script will help identify which individual DISM features night need to be uninstalled, it is not intended to be a full replacement for the Uninstall-WindowsFeature cmdlet or Server Manager functionality. In some cases, you will need to manually uninstall multiple DISM features to fully uninstall a role or feature. For example, you might need to uninstall related features (parent-child relationships), and unrelated features (dependencies). For detailed instructions to list and disable features with Dism.exe see [Enable or Disable Windows Features Using DISM](http://aka.ms/tp5-dism).  

## Windows Server Update Services  
[comment]: # (ID: 360; Submitter: hkpammi; state: signed off)  
Windows Server Update Services (WSUS) servers running this preview release can cause computers obtaining their updates from it will fail to sync. For example, if you change configuration details such as MaxExtendedUpdatesPerRequest or the file download preference, syncs will begin to fail resulting in error codes in the Update UI and WindowsUpdate.log. Syncing might begin to fail eventually even if no configuration changes are made.  

To avoid this, set WSUS clients to use a WSUS server that is not running this preview release.    

## Windows Store  
[comment]: # (ID: 340; Submitter: dbenisch; state: signed off)  
The Windows Store app displays music and videos, but not apps. If you click the **Apps** link and choose any category, you will receive a "Try that again" message.  

There is no workaround at this time.  



## Copyright  
This document is provided "as-is". Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  

This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  

&copy; 2016 Microsoft Corporation. All rights reserved.  

Microsoft, Active Directory, Hyper-V, Windows, and Windows Server are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.  

This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  


2.0  

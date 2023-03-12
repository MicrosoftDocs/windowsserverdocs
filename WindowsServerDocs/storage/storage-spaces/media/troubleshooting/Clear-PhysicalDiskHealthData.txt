Function Clear-PhysicalDiskHealthData
{
    <#
        .SYNOPSIS
            Clear the Windows Server Health Service Data flags for Physical Disks.
 
        .DESCRIPTION
            Clear the Windows Server Health Service Data flags for the specified Physical Disk.
 
        .PARAMETER UniqueId
            The UniqueId of a physical disk (either from WMI MSFT_PhysicalDisk or Get-PhysicalDisk)
 
        .PARAMETER SerialNumber
            The SerialNumber of a physical disk (either from WMI MSFT_PhysicalDisk or Get-PhysicalDisk)
 
        .PARAMETER Intent
            Should clear Health Service intent data
 
        .PARAMETER Policy
            Should clear Health Service policy data
 
        .PARAMETER Force
            Skip the Should Process check
                
        .NOTES
            Name: Clear-PhysicalDiskIntent
            Author: Don MacGregor
            Created: 06 AUG 2018
 
        .EXAMPLE
                $pd = Get-PhysicalDisk -UniqueId 5000C5007952B6E8
                $pd | Clear-PhysicalDiskHealthData -Intent -Verbose -Force
                VERBOSE: Compiling code to create type
                VERBOSE: Attempting to get physical disk uniqueid 5000C5007952B6E8
                VERBOSE: Got Physical Disk(s) UniqueId 5000C5007952B6E8  SerialNumber Z1Z5L2SX Health ObjectId {0f4c8517-edac-4b80-95d8-a962f48386b3}:PD:{06cf36cc-d4e7-cd77-7a7f-4f3cae02d1e3}
 
            Description
            -----------
            Clears the intent flags for physical disk with uniqueid 5000C5007952B6E8
                
        .EXAMPLE
                Clear-PhysicalDiskIntent -UniqueId 5000C5008BD014DD -Policy -verbose
                VERBOSE: Compiling code to create type
                VERBOSE: Attempting to get physical disk uniqueid 5000C5008BD014DD
                VERBOSE: Found Physical Disk(s) UniqueId 5000C5008BD014DD  SerialNumber S1Z1AGBH Health ObjectId {0f4c8517-edac-4b80-95d8-a962f48386b3}:PD:{94b50dd9-c125-cf7e-8bb2-fe85423ef917}
 
                Confirm
                Are you sure you want to perform this action?
                Performing the operation "Clear Health Data Flags" on target
                "{0f4c8517-edac-4b80-95d8-a962f48386b3}:PD:{94b50dd9-c125-cf7e-8bb2-fe85423ef917}".
                [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
                True
 
            Description
            -----------
            Clears the policy flags for physical disk with uniqueid 5000C5008BD014DD
                
        .EXAMPLE
                Clear-PhysicalDiskHealthData -Intent -Policy -SerialNumber Z1Z5L2SX -Verbose -Force
                VERBOSE: Compiling code to create type
                VERBOSE: Attempting to get physical disk  serial number  Z1Z5L2SX
                VERBOSE: Got Physical Disk(s) UniqueId 5000C5007952B6E8  SerialNumber Z1Z5L2SX Health ObjectId {0f4c8517-edac-4b80-95d8-a962f48386b3}:PD:{06cf36cc-d4e7-cd77-7a7f-4f3cae02d1e3}
 
            Description
            -----------
            Clears both the intent and policy flags for physical disk with serial number  Z1Z5L2SX
 
    #>
    [cmdletbinding(
           DefaultParameterSetName = "ByUniqueId",
        SupportsShouldProcess,
        ConfirmImpact='High'
    )]
    Param (
        [parameter(ValueFromPipelineByPropertyName=$True,
                   Mandatory = $True,
                         ParameterSetName = "ByUniqueId")]
        [string]$UniqueId,  
           
        [parameter(ValueFromPipelineByPropertyName=$True,
                        ParameterSetName = "BySerial")]
        [string]$SerialNumber,
 
        [parameter()]
        [switch]$Intent, 
           
        [parameter()]
        [switch]$Policy, 
           
        [parameter()]
        [switch]$Force 
           )
    Begin
    {
        Write-Verbose 'Compiling code to create type'   
        Add-Type @"
        using System;
        using System.Collections.Generic;
        using System.Linq;
        using System.Text;
        using System.Runtime.InteropServices;
        
        public class HealthServiceUtil
        {
                public enum HealthDataFlags
            {
                      HealthDataFlagNone  = 0x00,
                      HealthDataFlagBitmask = 0x01,
                      HealthDataFlagPersist = 0x02,
                      HealthDataFlagErase   = 0x04,
                      HealthDataFlagPrivate = 0x08,
                      HealthDataFlagBitsetWithMask = 0x10,
                      HealthDataFlagReleaseLocalLock = 0x20
            }
                
                [UnmanagedFunctionPointer(CallingConvention.StdCall)]
                delegate void HealthOpenCallback(long filter, IntPtr context);
                
            [DllImport("healthapi.dll", SetLastError = true, CharSet = CharSet.Unicode)]
            static extern IntPtr HealthOpenConnection(HealthOpenCallback pCallback, IntPtr pContext, int flags);
 
            [DllImport("healthapi.dll", SetLastError = true, CharSet = CharSet.Unicode)]
            static extern  int HealthCloseConnection(IntPtr healthHandle);
 
            [DllImport("healthapi.dll", SetLastError = true, CharSet = CharSet.Unicode)]
                static extern  int HealthAddUInt64Data( IntPtr healthHandle, string name, string objectId, HealthDataFlags flags, ulong value );
 
                private static void HandleOpenCallback(long filter, IntPtr context) {}
                
                public static  int ClearIntentValue (string objectId)
            {
                      return ClearDataValue("Intent", objectId);
            }
 
                public static  int ClearPolicyValue (string objectId)
            {
                      return ClearDataValue("Policy", objectId);
            }
 
                public static  int ClearDataValue (string name, string objectId)
            {
                try
                {
                    int rc = 0;
                           HealthOpenCallback openCallback = new HealthOpenCallback(HandleOpenCallback);
                      
                    IntPtr healthHandle = HealthOpenConnection(openCallback,IntPtr.Zero,0);
                    if( healthHandle == IntPtr.Zero )
                        return 110; // ERROR_OPEN_FAILED
                           
                    if(rc == 0)
                        rc = HealthAddUInt64Data(healthHandle, name, objectId, HealthDataFlags.HealthDataFlagErase, 0);          
     
                    if(rc == 0)
                        rc = HealthAddUInt64Data(healthHandle, name, objectId, HealthDataFlags.HealthDataFlagPersist | HealthDataFlags.HealthDataFlagErase, 0);          
                    
 
                    HealthCloseConnection(healthHandle);
                    return rc;
                }
                catch
                {
                    return -1;
                }
            }
 
        }
"@
    }
    Process
    {
           if( (-not $Intent) -and (-not $Policy) )
           {
                Write-Warning ("No data type (Intent or Policy) specified to clear")
                return $false
           }
     
           $pd = $null
           if( $UniqueId -ne $null )
           {
                Write-Verbose ("Attempting to get physical disk uniqueid $UniqueId")
                $pd = Get-PhysicalDisk -uniqueid $UniqueId
 
            if( -NOT $pd )
            {
                Write-Error "Unable to find Physical Disk with UniqueId $UniqueId"
                return $false
            }
           }
           elseif( $SerialNumber -ne $null )
           {
                Write-Verbose ("Attempting to get physical disk serial number $SerialNumber" )
                $pd = Get-PhysicalDisk -serialnumber $SerialNumber
 
            if( -NOT $pd )
            {
                Write-Error "Unable to find Physical Disk with SerialNumber $SerialNumber"
                return $false
            }
           }
           
        $healthObjectIdOffset = $pd.ObjectId.IndexOf('="') + 2
        $healthObjectIdLength = $pd.ObjectId.Length - $healthObjectIdOffset - 1
        $healthObjectId = $pd.ObjectId.Substring($healthObjectIdOffset, $healthObjectIdLength)
 
           Write-Verbose ("Found Physical Disk(s) UniqueId $($pd.UniqueId)  SerialNumber $($pd.SerialNumber) Health ObjectId $healthObjectId" )
 
        if ($Force -or $PSCmdlet.ShouldProcess($healthObjectId,'Clear Health Data Flags'))
        {
                if( $Intent )
                {
                      $rc = [HealthServiceUtil]::ClearIntentValue($healthObjectId)
                      if( $rc -ne 0 )
                      {
                           Write-Error "Failed to clear health intent flags for health object id '$healthObjectId' with error code $rc"
                           return $false
                      }
                }
                
                if( $Policy )
                {
                      $rc = [HealthServiceUtil]::ClearPolicyValue($healthObjectId)
                      if( $rc -ne 0 )
                      {
                           Write-Error "Failed to clear health policy flags for health object id '$healthObjectId' with error code $rc"
                           return $false
                      }
                }
        }
 
           return $true
    }
}
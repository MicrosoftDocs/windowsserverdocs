---
title: Health Service settings
ms.prod: windows-server-threshold
manager: eldenc
ms.author: cosdar
ms.technology: storage-health-service
ms.topic: article
ms.assetid:
author: cosmosdarwin
ms.date: 08/14/2017
---
# Health Service settings
> Applies to: Windows Server 2019, Windows Server 2016

The Health Service is a new feature in Windows Server 2016 that improves the day-to-day monitoring and operational experience for clusters running Storage Spaces Direct.

Many of the parameters which govern the behavior of the Health Service are exposed as settings. You can modify these to tune the aggressiveness of faults or actions, turn certain behaviors on/off, and more.

Use the following PowerShell cmdlet to set or modify settings.

### Usage

```PowerShell
Get-StorageSubSystem Cluster* | Set-StorageHealthSetting -Name <SettingName> -Value <Value>  
```

#### Example

```PowerShell
Get-StorageSubSystem Cluster* | Set-StorageHealthSetting -Name "System.Storage.Volume.CapacityThreshold.Warning" -Value 70
```

### Common settings

Some commonly modified settings are listed below, along with their default values.

#### Volume Capacity Threshold

```
"System.Storage.Volume.CapacityThreshold.Enabled"  = True
"System.Storage.Volume.CapacityThreshold.Warning"  = 80
"System.Storage.Volume.CapacityThreshold.Critical" = 90
```

#### Pool Reserve Capacity Threshold

```
"System.Storage.StoragePool.CheckPoolReserveCapacity.Enabled" = True
```

#### Physical Disk Lifecycle

```
"System.Storage.PhysicalDisk.AutoPool.Enabled"                             = True
"System.Storage.PhysicalDisk.AutoRetire.OnLostCommunication.Enabled"       = True
"System.Storage.PhysicalDisk.AutoRetire.OnUnresponsive.Enabled"            = True
"System.Storage.PhysicalDisk.AutoRetire.DelayMs"                           = 900000 (i.e. 15 minutes)
"System.Storage.PhysicalDisk.Unresponsive.Reset.CountResetIntervalSeconds" = 360 (i.e. 60 minutes)
"System.Storage.PhysicalDisk.Unresponsive.Reset.CountAllowed"              = 3
```

#### Supported Components Document

See the previous section.

#### Firmware Rollout

```
"System.Storage.PhysicalDisk.AutoFirmwareUpdate.SingleDrive.Enabled"       = True
"System.Storage.PhysicalDisk.AutoFirmwareUpdate.RollOut.Enabled"           = True
"System.Storage.PhysicalDisk.AutoFirmwareUpdate.RollOut.LongDelaySeconds"  = 604800 (i.e. 7 days)
"System.Storage.PhysicalDisk.AutoFirmwareUpdate.RollOut.ShortDelaySeconds" = 86400 (i.e. 1 day)
"System.Storage.PhysicalDisk.AutoFirmwareUpdate.RollOut.LongDelayCount"    = 1
"System.Storage.PhysicalDisk.AutoFirmwareUpdate.RollOut.FailureTolerance"  = 3
```

#### Platform / Quiescence

```
"Platform.Quiescence.MinDelaySeconds" = 120 (i.e. 2 minutes)
"Platform.Quiescence.MaxDelaySeconds" = 420 (i.e. 7 minutes)
```

#### Metrics

```
"System.Reports.ReportingPeriodSeconds" = 1
```

#### Debugging

```
"System.LogLevel" = 4
```

## See also

- [Health Service in Windows Server 2016](health-service-overview.md)
- [Storage Spaces Direct in Windows Server 2016](../storage/storage-spaces/storage-spaces-direct-overview.md)

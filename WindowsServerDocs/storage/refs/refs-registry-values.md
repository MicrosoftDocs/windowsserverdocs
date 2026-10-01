---
description: "Look up supported ReFS registry values in Windows Server, including each value's type, default behavior, dependencies, and cautions to weigh before you change it."
title: ReFS Registry Values in Windows Server
ms.author: roharwoo
ms.topic: concept-article
author: robinharwood
ms.date: 10/01/2026
ai-usage: ai-assisted
#customer intent: As a Windows Server or storage administrator, I want to look up a specific ReFS registry value and understand its purpose, type, default behavior, and cautions so that I can make a safe configuration decision.
---

# Supported ReFS registry values in Windows Server

Resilient File System (ReFS) registry values are settings that adjust how the file system behaves for safety, space management, caching, tiering, and thin provisioning. Changing these values without understanding their effects might affect data integrity, performance, and supportability.

Use this article to look up a specific supported value and understand its purpose, type, default behavior, dependencies, and cautions. The article assumes that you already understand ReFS and are evaluating an individual value. It isn't a tuning workflow and doesn't recommend combinations, target settings, or an order in which to configure values.

## How ReFS registry configuration works

> [!WARNING]
> Changing file system registry values can affect data integrity, performance, and supportability. Only change a value when you understand its effect, and only change support-only values under direction from Microsoft support. Test changes in a nonproduction environment first.

ReFS reads most of its tunable behavior from values under the file system control key in the registry. Unless a value's entry says otherwise, every value in this article lives under the same key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`

Each supported value is one of two registry types:

- `REG_DWORD`: a 32-bit value. Holds Boolean-style switches (`0` or `1`) and smaller numeric settings.
- `REG_QWORD`: a 64-bit value. Holds larger numeric settings, such as sizes or counts that can exceed the 32-bit range.

For the Boolean values, only `0` and `1` are valid. ReFS ignores any other value and keeps the default.

Changes take effect after you restart the system, not immediately.

## How precedence works

You can set some behaviors in more than one place. When both a policy and the corresponding setting under the file system control key govern a behavior, the policy takes precedence over the `Control\FileSystem` value. When you don't configure a policy, ReFS uses the `Control\FileSystem` value. When neither is present, the value's absent-value behavior applies.

The **Dependencies and precedence** column in each category table records, per value, which policy (if any) overrides the setting and which other values it depends on or interacts with.

## How defaults and absent values behave

Not every value behaves the same way when it isn't present in the registry. A value follows one of these default or absent-value patterns:

- **Fixed default**: ReFS uses a constant built-in value when the setting is absent.
- **Calculated default**: ReFS derives the effective value at runtime, for example from volume size, available memory, or hardware characteristics.
- **Absent-value behavior**: the behavior applies only when the registry contains the value; otherwise, ReFS follows a specific documented behavior (for example, a feature stays enabled unless the value explicitly disables it).

Some numeric settings also have a **bounded-internal** supported range. For these settings, ReFS clamps a configured value outside the range to the nearest supported bound rather than use it as written. This rule describes how ReFS handles a configured value, not how ReFS determines a default.

The **Default or absent-value behavior** and **Supported values** columns in each table state which rules apply to each value.

## How to read a value entry

All values live under the registry key listed in [How ReFS registry configuration works](#how-refs-registry-configuration-works), so the tables don't repeat the path. Each category table describes its values with the same columns:

- **Value name**: the exact name of the value to create or edit.
- **Type**: `REG_DWORD` or `REG_QWORD`.
- **Default or absent-value behavior**: the effective behavior when the value isn't set, per the categories described earlier.
- **Supported values**: the accepted values, ranges, and units.
- **Behavior controlled**: what the value enables, disables, or adjusts.
- **Dependencies and precedence**: any policy that overrides the value and any related values it interacts with.
- **Cautions**: risks and safety considerations before changing the value, including whether the value is support-only.

## Support-only settings

Some ReFS registry values are intended for use only under direction from Microsoft support. These values appear only in [Advanced and support-only settings](#advanced-and-support-only-settings), where the **Cautions** column marks them as **Support-only**. Don't set a support-only value, even in a test environment, unless a support engineer directs you to set it.

## Safety and corruption response settings

Safety and corruption response settings control ReFS behaviors that protect data integrity and durability, such as write-through handling and self-healing of user-data corruption.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsDisableWriteThrough`** | `REG_DWORD` | Fixed default `0`. If absent, treated as `0`. | `0` or `1` | Controls whether ReFS honors write-through requests, such as `FILE_FLAG_WRITE_THROUGH`. `0` honors write-through and forces data to stable media. `1` ignores all write-through requests. | None. This value is independent of `RefsDisableLastAccessUpdate`. | Setting `1` can cause data loss for apps that depend on write-through, such as databases, during power loss or system failure. |
| **`RefsDisableUserDataTriage`** | `REG_DWORD` | Fixed default `0`. If absent, treated as `0`. | `0` or `1` | Controls whether ReFS self-heals corruption in user file and directory metadata. ReFS repairs internal file system metadata regardless of this value. `0` enables user-data self-healing. `1` disables it. | None. | Disabling self-healing leaves detected user-data corruption unrepaired. |

## Memory usage (working-set trim) settings

Memory usage settings control how aggressively ReFS trims its working set to reduce memory consumption.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsNumberOfChunksToTrim`** | `REG_DWORD` | Calculated default. If absent, ReFS uses an internal default of up to 512. | Number of chunks to trim per pass. | Overrides the number of chunks ReFS trims from the working set per pass. | None. | Increasing the value reclaims memory faster under pressure, at extra CPU cost. |
| **`RefsEnableLargeWorkingSetTrim`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` disables aggressive trimming. `1` trims large working sets more aggressively. | None. | None. |
| **`RefsEnableInlineTrim`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` disables inline trim, so ReFS reclaims memory in the background. `1` enables inline trim, so ReFS reclaims memory during operations, which reduces peak memory on metadata-intensive workloads. | None. | None. |

## Tiering and destage settings

Tiering and destage settings tune container rotation and destage behavior on mirror-accelerated parity volumes, which use 64-MB slabs (containers). Each fill-ratio threshold takes a percentage: `0` or an absent value uses the built-in default, and `1` through `100` sets the ratio explicitly.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsEnableParallelContainerRotation`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` disables parallel container rotation. `1` queues work items so container rotation runs in parallel. | Governs whether `RefsContainerRotationThreadCount` and `RefsContainerRotationQueueSizeLimit` apply. | None. |
| **`RefsContainerRotationThreadCount`** | `REG_DWORD` | Fixed default `0`, which uses an internal default of 4. | `0` (internal default of 4) or a positive thread count. | Maximum number of threads for container rotation. | Applies only when you enable parallel container rotation (`RefsEnableParallelContainerRotation` = `1`). | Higher values speed up rotation but use more CPU and memory. |
| **`RefsContainerRotationQueueSizeLimit`** | `REG_DWORD` | Fixed default `0`, which uses an internal default of 9. | `0` (internal default of 9) or a positive limit. | Overrides the container-rotation work-item queue limit that throttles the maximum number of queued work items. | Applies to parallel container rotation. | None. |
| **`DataDestageSsdFillRatioThreshold`** | `REG_DWORD` | Fixed default `85`. `0` or absent uses the built-in default. | `0` (built-in default) or `1` to `100` (percent). | Solid-state drive (SSD) data-tier fill ratio (%) that triggers destage from the SSD to the hard disk drive (HDD). | None. | None. |
| **`MetadataDestageSsdFillRatioThreshold`** | `REG_DWORD` | Fixed default `85`. `0` or absent uses the built-in default. | `0` (built-in default) or `1` to `100` (percent). | SSD metadata-tier fill ratio (%) that triggers destage from SSD to HDD. | None. | None. |
| **`DataDestageHddFillRatioThreshold`** | `REG_DWORD` | Fixed default `92`. `0` or absent uses the built-in default. | `0` (built-in default) or `1` to `100` (percent). | HDD data-tier fill ratio (%) that triggers reverse rotation from HDD to SSD when the HDD is too full. | None. | None. |
| **`MetadataDestageHddFillRatioThreshold`** | `REG_DWORD` | Fixed default `92`. `0` or absent uses the built-in default. | `0` (built-in default) or `1` to `100` (percent). | HDD metadata-tier fill ratio (%) that triggers reverse rotation from HDD to SSD. | None. | None. |
| **`DataDestageCompactionThreshold`** | `REG_DWORD` | Fixed default `85`. `0` or absent uses the built-in default. | `0` (built-in default) or `1` to `100` (percent). | Compaction trigger for data containers. When the HDD data-container fill ratio reaches this percentage, compaction reclaims fragmented space. | Set at least 5% below the HDD-to-SSD rotation threshold (`DataDestageHddFillRatioThreshold`). | None. |

## TRIM and space reclamation settings

TRIM and space reclamation settings control how ReFS notifies storage devices about deleted space and how it maps and unmaps thinly provisioned ranges.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsDisableDeleteNotification`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` sends delete/TRIM notifications to the storage device. `1` disables them. | None. | None. |
| **`RefsInvalidateOnFileLevelTrim`** | `REG_DWORD` | Fixed default `0`. | `0`, `1`, or `2` | `0` lets ReFS decide whether to notify the device on delete (typically disk trim on tiered volumes; retains space internally on non-tiered volumes). `1` marks the deleted portion unused without notifying the device (less background I/O, but ReFS might delay reclamation). `2` always notifies the device (faster reclamation at extra background I/O cost). | None. | None. |
| **`RefsDisableThinProvisioningUnmap`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` enables background unmapping. When mapped-but-free headroom rises above the maximum, ReFS unmaps unused ranges until headroom approaches the target. `1` disables background reclamation of unused mapped ranges. | Operates independently of `RefsDisableThinProvisioningProactiveMap` and uses the minimum, target, and maximum headroom values. | Setting `1` prevents ReFS from returning unused backing capacity through background unmapping. |
| **`RefsDisableThinProvisioningProactiveMap`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` enables background proactive mapping. When mapped-free headroom falls below the minimum, ReFS maps free ranges until headroom approaches the target. `1` disables background pre-mapping of free ranges. | Operates independently of `RefsDisableThinProvisioningUnmap` and uses the minimum, target, and maximum headroom values. | Setting `1` prevents ReFS from reserving backing capacity ahead of write demand. |

## Thin provisioning headroom settings

Thin provisioning headroom settings set the free-space buffer ReFS maintains on thinly provisioned volumes. The three values interact and follow the order minimum is less than or equal to target, and target is less than or equal to maximum.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsThinProvisioningMinHeadroomBytes`** | `REG_QWORD` | Calculated default: the greater of 2 GB or 2 × slab size. | Size in bytes. | Absolute minimum free-space headroom that ReFS enforces on thin volumes. | Must be less than or equal to the target and maximum headroom values. | None. |
| **`RefsThinProvisioningTargetHeadroomBytes`** | `REG_QWORD` | Calculated default: (minimum + maximum) / 2. | Size in bytes. | Desired steady-state free-space buffer. | Should fall between the minimum and maximum headroom values. | None. |
| **`RefsThinProvisioningMaxHeadroomBytes`** | `REG_QWORD` | Calculated default: the greater of 4 GB or 4 × slab size. | Size in bytes. | Upper bound on headroom, which avoids over-reservation. | Can't be lower than the minimum value. | ReFS automatically corrects a value set below the minimum. |

## Caching and input/output (I/O) performance settings

Caching and I/O performance settings tune the ReFS caching and I/O paths. Only `0` and `1` are valid. ReFS ignores any other value.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsDisableAsyncDelete`** | `REG_DWORD` | Fixed default `0`. Only the lowest bit is significant. | `0` or `1` | `0` enables async delete, so a large delete returns quickly and ReFS frees space in the background. `1` frees space synchronously before the delete returns, which makes large deletes slower. | None. | None. |
| **`RefsDisableTrueAsyncCachedReads`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` enables async cached reads. `1` services reads synchronously, blocking the calling thread while cached reads fetch from disk. | None. | None. |
| **`RefsDisableCachedPins`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | Controls a metadata-lookup optimization that reuses a recent internal metadata search. `0` enables it. `1` disables it, so each lookup does a full search. | None. | None. |
| **`RefsDisableWriteCombining`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | Controls combining adjacent metadata writes into fewer, larger writes. `0` enables it. `1` disables it. | None. | None. |

## Last-access timestamp settings

Last-access timestamp settings control whether ReFS issues I/O to persist last-access timestamps.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsDisableLastAccessUpdate`** | `REG_DWORD` | Fixed default `1`. If the value is absent, ReFS treats it as `1`. | `0` or `1` | Controls whether ReFS issues I/O to persist last-access timestamps. `0` enables last-access updates. `1` (default) disables them, so ReFS issues no I/O solely to update last-access timestamps. | Group Policy takes precedence over this local value. This setting is independent of `RefsDisableWriteThrough`. | None. |

## Dev Drive and case sensitivity settings

ReFS also underlies Dev Drive and supports per-directory case sensitivity. Separate articles document the values that control Developer Mode, per-directory case sensitivity, and Dev Drive enablement, for example, `AllowDevelopmentWithoutDevLicense`, `RefsEnableDirCaseSensitivity`, and the `FsEnableDevDrive` policy. For those settings, see:

- [Dev Drive](/windows/dev-drive/)
- [Case sensitivity](/windows/wsl/case-sensitivity)
- [FileSystem Policy CSP](/windows/client-management/mdm/policy-csp-filesystem)

## Advanced and support-only settings

Advanced and support-only settings expose low-level ReFS behavior. Some settings break into a debugger or change corruption handling, which can cause downtime or data loss.

> [!IMPORTANT]
> Don't configure these settings unless Microsoft support directs you to. Microsoft documents them for reference only.

## Support-only ReFS throttling and caching settings

These support-only settings throttle concurrent global posts and control table-set caching.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsGlobalPostLimit`** | `REG_DWORD` | Fixed default `4`. | Bounded-internal: ReFS clamps values to a minimum of 4 and a maximum of 200. | Maximum number of concurrent active global posts. ReFS throttles global IRPs beyond this limit. | None. | Support-only. |
| **`RefsTableSetEntriesToNavigateBeforeCaching`** | `REG_DWORD` | Fixed default `32`. | `0` (disables caching) or a positive count. | Number of table-set entries to traverse before caching one for lookups. Higher values cache less frequently. | None. | Support-only. |

## Support-only ReFS metadata validation and corruption handling settings

These support-only settings change how ReFS validates on-disk metadata and responds to detected corruption.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsCheckPageFailureAction`** | `REG_DWORD` | Fixed default `1`. | `0`, `1`, or `2` | Controls the action ReFS takes when metadata-page validation fails. `0` converts the failure to success and continues. `1` (default) returns `STATUS_FS_METADATA_INCONSISTENT`. `2` returns `STATUS_DATA_CHECKSUM_ERROR` to invoke the repair path. | None. | Support-only. Setting `0` can suppress metadata-validation failures. |
| **`RefsEnableMetadataValidation`** | `REG_DWORD` | Fixed default `0`. | Bitmask from `0` through `3`: bit 0 enables metadata structural validation; bit 1 enables a debugger break on invalid metadata in checked builds. | Controls extra runtime structural validation of on-disk metadata and debugger behavior when validation fails. | None. | Support-only. Setting `0` bypasses this structural validation. Bit 1 can break into a debugger in checked builds. |
| **`RefsEnableBreakOnChecksumMismatch`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` (default) doesn't break into a debugger on a checksum mismatch. `1` breaks into a debugger when ReFS detects a checksum mismatch, including a mismatch in a repairable copy. | None. | Support-only. Setting `1` can break into a debugger. |

## Support-only ReFS low-level I/O and debugging settings

These support-only settings control low-level I/O behavior and debugging.

| Value name | Type | Default or absent-value behavior | Supported values | Behavior controlled | Dependencies and precedence | Cautions |
|---|---|---|---|---|---|---|
| **`RefsAssumeInvariantMdl`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | Controls whether ReFS assumes memory descriptor lists (MDLs) are invariant. `0` (default) queries the page-content state. `1` treats every MDL as invariant without querying its page-content state. | None. | Support-only. Setting `1` bypasses buffering and repair safeguards for buffers that can change during checksum validation, which risks data correctness or corruption. |
| **`DisableAssociatedIrpAsyncPosting`** | `REG_DWORD` | Fixed default `0`. | `0` or `1` | `0` (default) allows ReFS to post intermediate associated I/O request packets (IRPs) to work items. `1` sends them to the storage driver inline instead. | Group Policy takes precedence over this local value. | Support-only. Changing low-level I/O scheduling can have workload-dependent performance and storage-stack effects. |

## Next steps

- [Resilient File System (ReFS) overview](refs-overview.md)

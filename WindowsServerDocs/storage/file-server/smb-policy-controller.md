---
title: SMB Policy Controller (preview) overview in Windows Server
description: SMB Policy Controller aligns host-wide and share-specific SMB settings in Windows Server. Learn how profiles, intent, and reconciliation work.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 11/11/2026
ai-usage: ai-assisted

#customer intent: As a file-server administrator, I want to understand SMB Policy Controller so that I can decide how to use it safely.
---

# What is SMB Policy Controller (preview) in Windows Server?

SMB Policy Controller (preview) stores an administrator-defined Server Message Block (SMB) configuration and keeps managed settings aligned with it. Use SMB Policy Controller to maintain a consistent SMB configuration for a server or an existing share. An *intent* is a saved configuration that specifies the SMB settings for a server or share. The controller stores the configuration, applies the managed settings, and attempts to correct any settings that drift.

This article explains server and share intent scopes, profiles, and workload selectors. It also explains how the controller reconciles settings and restores captured settings after you remove an intent. Use this information to decide whether and how to use SMB Policy Controller.

> [!IMPORTANT]
> SMB Policy Controller is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Server and share intent

SMB Policy Controller (preview) uses complementary server and share intent scopes. A server intent manages host-wide settings, while a share intent manages one existing named share.

| Intent | What it manages | What to consider |
|---|---|---|
| Server intent | Host-wide SMB server configuration, SMB client configuration, and related host settings, including managed registry and alternative-port configuration | Changes affect multiple shares, inbound client access, and outbound SMB connections from the host. |
| Share intent | The effective configuration of one existing named SMB share | Create the share first. Its path, permissions, storage, and availability design remain separate. |

SMB Policy Controller manages SMB settings as part of a wider file-service solution. It doesn't create shares, configure storage, grant access, manage firewall rules, or provide backups. Workload compatibility, security architecture, storage, and availability remain separate design decisions.

For example, you can use the Security profile for the server and the Performance profile for a workload-specific share. Server and share profiles are independent. If you create a share intent without selecting a profile, it inherits the profile selected by the stored server intent. If the stored server intent is missing or the controller can't read it, explicitly select Security or Performance; otherwise, the controller can't create the share intent. After creation, the share retains its profile and settings when the server intent changes. Because server and share intents have separate scopes, verify their combined effective settings.

When you add or update an intent, the controller stores the desired configuration and attempts to apply it. It then compares managed SMB settings with the stored intent and reapplies settings that differ. Storing and applying are separate outcomes: one setting group can apply successfully while another fails.

SMB Policy Controller doesn't have universal precedence over Group Policy, scripts, administrators, or other configuration tools. Coordinate systems that change the same settings to avoid repeated drift. To compare stored intent, effective settings, and representative client access, see [Verify an intent](configure-smb-policy-controller.md#verify-an-intent).

## Profiles and workload selectors

SMB Policy Controller (preview) provides two built-in profile choices: Security and Performance:

- **Security** selects settings that strengthen SMB protection.
- **Performance** selects settings that favor workload performance.

For a server intent, a profile supplies SMB server, SMB client, and managed registry settings. For a share intent, a profile supplies SMB share settings. The following tabs present all 106 profile settings and implemented override properties.

The profile tables explicitly configure Boolean values rather than leaving them unset or inferring them. For SMB server and client properties, the controller passes these values to `Set-SmbServerConfiguration` or `Set-SmbClientConfiguration`. The tables list the Boolean values that `Get-SmbServerConfiguration` and `Get-SmbClientConfiguration` return.

The tables distinguish configured values from their runtime interpretation. Validate runtime behavior, tuning suitability, and build compatibility for your workload before deployment.

For general protocol details, see [Server Message Block (SMB) Protocol Versions 2 and 3 specification](/openspecs/windows_protocols/ms-smb2/5606ad47-5ee0-437a-817e-70c366052962).

Profile names don't guarantee regulatory compliance, workload compatibility, a specific throughput level, or protection against every threat. Inspect the complete profile-derived object and assess its effect on clients before you apply it. For related guidance, see [SMB security hardening](smb-security-hardening.md) and [SMB over QUIC](smb-over-quic.md).

# [SMB server](#tab/smb-server)

The SMB server profiles define 56 settings. Settings with different Security and Performance values appear first.

### Profile differences

| SMB server setting | Security value | Performance value |
|---|---:|---:|
| `AuditClientCertificateAccess` | True | False |
| `AuditClientDoesNotSupportEncryption` | True | False |
| `AuditClientDoesNotSupportSigning` | True | False |
| `AuditInsecureGuestLogon` | True | False |
| `AuditSmb1Access` | True | False |
| `DisableCompression` | True | False |
| `EnableAuthRateLimiter` | True | False |
| `EnableDirectoryHandleLeasing` | False | True |
| `EnableLeasing` | False | True |
| `EnableSecuritySignature` | True | False |
| `EnableSMBQUIC` | False | True |
| `EncryptData` | True | False |
| `EncryptionCiphers` | `AES_256_GCM`, `AES_256_CCM` | `AES_128_GCM`, `AES_128_CCM`, `AES_256_GCM`, `AES_256_CCM` |
| `RejectUnencryptedAccess` | True | False |
| `RequestCompression` | False | True |
| `RequireSecuritySignature` | True | False |
| `RestrictNamedpipeAccessViaQuic` | True | False |
| `TreatHostAsStableStorage` | False | True |

### Common settings

| SMB server setting | Security and Performance value |
|---|---:|
| `AsynchronousCredits` | Maximum configured value (4,294,967,295) |
| `AutoDisconnectTimeoutInMinutesV1` | Disabled |
| `AutoDisconnectTimeoutInSecondsV2` | 900 seconds |
| `AutoShareServer` | False |
| `AutoShareWorkstation` | False |
| `DisableSmbEncryptionOnSecureConnection` | False |
| `DurableHandleV2TimeoutInSeconds` | 180 |
| `EnableAuthenticateUserSharing` | False |
| `EnableDownlevelTimewarp` | False |
| `EnableForcedLogoff` | True |
| `EnableMailslots` | False |
| `EnableMultiChannel` | True |
| `EnableOplocks` | False |
| `EnableSMB1Protocol` | False |
| `EnableSMB2Protocol` | True |
| `EnableStrictNameChecking` | False |
| `InvalidAuthenticationDelayTimeInMs` | 2,000 |
| `IrpStackSize` | 15 |
| `KeepAliveTime` | 2 |
| `MaxChannelPerSession` | 32 |
| `MaxMpxCount` | 50 |
| `MaxSessionPerConnection` | 16,384 |
| `MaxThreadsPerQueue` | 20 |
| `MaxWorkItems` | 1 |
| `NullSessionPipes` | Profile-managed list; validate the effective contents |
| `NullSessionShares` | Profile-managed list; validate the effective contents |
| `OplockBreakWait` | 35 |
| `PendingClientTimeoutInSeconds` | 120 |
| `ServerHidden` | True |
| `Smb2CreditsMax` | 2,048 |
| `Smb2CreditsMin` | 128 |
| `Smb2DialectMax` | `SMB311` |
| `Smb2DialectMin` | `SMB311` |
| `SmbServerNameHardeningLevel` | 2 |
| `ValidateAliasNotCircular` | True |
| `ValidateShareScope` | True |
| `ValidateShareScopeNotAliased` | True |
| `ValidateTargetName` | True |

On some downlevel systems, the SMB server runtime adjusts `MaxWorkItems` upward to a processor-count multiple. The SMB server ignores `Smb2CreditsMin` on Windows 10 and later and on Windows Server 2016 and later. The SMB server no longer uses `MaxThreadsPerQueue`.

Before you apply a profile, review the effective `NullSessionPipes` and `NullSessionShares` lists and assess the resulting anonymous-session access.

# [SMB client](#tab/smb-client)

The SMB client profiles define 33 settings. Settings with different Security and Performance values appear first.

### Profile differences

| SMB client setting | Security value | Performance value |
|---|---:|---:|
| `AuditInsecureGuestLogon` | True | False |
| `AuditServerDoesNotSupportEncryption` | True | False |
| `AuditServerDoesNotSupportSigning` | True | False |
| `BlockNTLM` | True | False |
| `DisableCompression` | True | False |
| `EnableLargeMtu` | False | True |
| `EnableSecuritySignature` | True | False |
| `EnableSMBQUIC` | False | True |
| `EncryptionCiphers` | `AES_256_GCM`, `AES_256_CCM` | `AES_128_GCM`, `AES_128_CCM`, `AES_256_GCM`, `AES_256_CCM` |
| `SkipCertificateCheck` | False | True |
| `RequestCompression` | False | True |
| `RequireEncryption` | True | False |
| `RequireSecuritySignature` | True | False |
| `MaxCmds` | 50 | 32 |
| `MaximumConnectionCountPerServer` | 50 | 32 |

For an SMB over QUIC client, the Performance value `SkipCertificateCheck=True` removes the requirement for the server certificate to chain to a trusted issuer, which can allow connections that use a self-signed certificate. This value is a security tradeoff. It doesn't disable Transport Layer Security (TLS) encryption or all certificate processing.

### Common settings

| SMB client setting | Security and performance value |
|---|---:|
| `BlockNTLMServerExceptionList` | Empty list |
| `CompressibilitySamplingSize` | Maximum allowable (8 PiB) |
| `CompressibleThreshold` | Maximum allowable (8 PiB) |
| `EnableCompressibilitySampling` | False |
| `ConnectionCountPerRssNetworkInterface` | 4 |
| `DormantFileLimit` | 1,023 |
| `EnableBandwidthThrottling` | False |
| `EnableByteRangeLockingOnReadOnlyFiles` | False |
| `EnableInsecureGuestLogons` | False |
| `EnableMailslots` | False |
| `EnableMultiChannel` | True |
| `EnableLoadBalanceScaleOut` | False |
| `DisabledSMBQUICServerExceptionList` | Empty list |
| `ForceSMBEncryptionOverQuic` | False |
| `UseOpportunisticLocking` | True |
| `IgnoreRevocationOfflineErrors` | False |
| `SMB2DialectMax` | `SMB311` |
| `SMB2DialectMin` | `SMB311` |

# [SMB share](#tab/smb-share)

For a share intent, combine Security or Performance with one of two workload selectors:

| Workload selector | Intended use | PowerShell identifier |
|---|---|---|
| User data | Shares that people and teams use interactively, such as shared document locations. | `-UserData` |
| Application data | Shares that applications use for data rather than primarily for interactive document access. | `-ApplicationData` |

User data and Application data are a closed two-value choice. They aren't additional profiles, and they affect only the 12 settings for the selected share. Within the Performance profile, the selector changes `CachingMode` from `Manual` for User data to `None` for Application data. Within the Security profile, it changes `FolderEnumerationMode` from `AccessBased` for User data to `Unrestricted` for Application data.

If `Add-Intent` specifies only `-UserData` or `-ApplicationData`, the share intent inherits the profile that the stored server intent selects. If that server intent is missing or unreadable, you can't create the share intent. Explicitly select Security or Performance to avoid this dependency. After creation, the share retains its profile and settings when the server intent changes.

| SMB share setting | Performance and User data | Performance and Application data | Security and User data | Security and Application data |
|---|---:|---:|---:|---:|
| `FolderEnumerationMode` | `Unrestricted` | `Unrestricted` | `AccessBased` | `Unrestricted` |
| `CachingMode` | `Manual` | `None` | `None` | `None` |
| `LeasingMode` | `Full` | `Full` | `Full` | `Full` |
| `CaTimeout` | 0 | 0 | 0 | 0 |
| `CompressData` | True | True | False | False |
| `ConcurrentUserLimit` | 0 | 0 | 0 | 0 |
| `ContinuouslyAvailable` | True | True | False | False |
| `DirectoryHandleLeasing` | True | True | False | False |
| `DisableClientMetadataCaching` | False | False | True | True |
| `EncryptData` | False | False | True | True |
| `IsolatedTransport` | False | False | True | True |
| `Description` | Share intent configured by Policy manager | Share intent configured by Policy manager | Share intent configured by Policy manager | Share intent configured by Policy manager |

The `ContinuouslyAvailable=True` Performance value applies to both workload selectors. It requests continuous availability but doesn't create a cluster, configure suitable storage, or guarantee availability. For configuration procedures, use the **Share-level intent** tab in [Configure an intent](configure-smb-policy-controller.md#configure-an-intent).

# [Host settings](#tab/host-settings)

A server profile also defines these three managed registry settings:

| Host registry setting | Security value | Performance value |
|---|---:|---:|
| `AdditionalCriticalWorkerThreads` | `Environment.ProcessorCount` | `2 * Environment.ProcessorCount` |
| `MaxThreadsPerNumaNode` | 20 | 20 |
| `RemoteFileDirtyPageThreshold` | 1,310,720 | 2,621,440 |

The system implements `TransportType` and `Port` as alternative-port override properties, but Security and Performance profiles supply no alternative-port entries. The initial alternative-port collection is empty.

| Override property | Type | Initial profile value |
|---|---|---|
| `TransportType` | Nullable transport type | No entry |
| `Port` | Nullable unsigned 16-bit integer | No entry |

---

## Profile-derived overrides

In SMB Policy Controller (preview), an *override object* is an editable PowerShell configuration object for one intent. `New-IntentOverride` creates a new, complete object from the selected built-in profile. It isn't a sparse patch, a copy of the current effective configuration, or a copy of an existing intent.

One override object can contain multiple modified settings. Creating the object doesn't store or apply it. When you add the intent, the controller processes the complete object. Server setting groups use separate providers, so groups can apply or fail independently rather than as one transaction.

To update an existing intent while retaining its other choices, retrieve the existing intent object, edit the required settings, and submit that object with `Set-Intent`. Don't use a new profile-derived object as a copy of the existing intent. For the procedures, use the **Share-level intent** tab in [Add a customized intent](configure-smb-policy-controller.md#add-a-customized-intent) and see [Update an intent](configure-smb-policy-controller.md#update-an-intent).

## How does SMB Policy Controller (preview) reconcile intents in a Windows Server failover cluster?

In a Windows Server failover cluster, nodes share the desired server intent, but each node reconciles that intent against its own local SMB configuration. Nodes can converge at different times, especially when a node is offline or encounters an error.

The current owner of the clustered resource that owns the share reconciles a share intent. Ownership changes, unavailable owners, and offline nodes can delay convergence or cause reconciliation to fail.

SMB Policy Controller (preview) doesn't design or create the cluster. A shared intent doesn't promise simultaneous effective settings across nodes, uninterrupted availability, or that a workload and storage configuration supports every requested setting.

## What happens to captured settings when you remove an SMB Policy Controller (preview) intent?

Before SMB Policy Controller (preview) first applies an intent, it captures the existing values of the settings that the intent manages. The intent retains those values throughout its life. Updating, reapplying, or retrying the intent doesn't replace them.

When `Remove-Intent` completes successfully, the controller returns the managed settings to the captured pre-policy values and verifies the effective values. It doesn't return settings to profile defaults or to a previous intent revision, and it isn't a backup restore operation. Removing a share intent doesn't delete the share or its data.

> [!CAUTION]
> Restoring captured pre-policy values can re-enable weaker SMB settings. After removal, review the resulting effective settings and confirm that they meet your current security requirements.

Starting removal doesn't prove that restoration completed. An unavailable cluster node or share owner can delay completion, and one target can fail after another target succeeds. Verify the effective managed settings and client access after removal. For the scoped procedures, select the **Share-level intent** or **Server-wide intent** tab in [Remove an intent and return to previous settings](configure-smb-policy-controller.md#remove-an-intent-and-return-to-previous-settings).

## Next steps

> [!div class="nextstepaction"]
> [Configure and manage SMB Policy Controller (preview)](configure-smb-policy-controller.md)

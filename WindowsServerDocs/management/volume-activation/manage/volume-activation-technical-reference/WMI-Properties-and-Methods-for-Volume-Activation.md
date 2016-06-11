---
title: WMI Properties and Methods for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df2d6c46-ea33-4a1b-83bf-6aebae40b99c
---
# WMI Properties and Methods for Volume Activation
Table 12 lists WMI properties and methods for the Software Protection Platform. Software Protection Platform properties are defined in the file %WinDir%\\System32\\wbem\\sppwmi.mof.

**Table 12. Software protection platform WMI properties and methods**

**\/\/properties SoftwareLicensingService Class**

|Version|Version of the Software Protection Service|
|-----------|----------------------------------------------|
|**KeyManagementServiceMachine**|The name of the KMS host. Returns null if **SetKeyManagementServiceMachine** has not been called.|
|**OA3xOriginalProductKeyDescription**|**Returns the description for the key installed on a given device**|
|**KeyManagementServicePort**|The TCP port used by clients to send KMS activation requests. Returns **0** if **SetKeyManagementServicePort** has not been called.|
|**IsKeyManagementServiceMachine**|Indicates whether KMS is enabled on the computer: **0** if false, **1** if true.|
|**VLActivationInterval**|The frequency, in minutes, of how often a client will contact the KMS host before the client is licensed.|
|**VLRenewalInterval**|The frequency, in minutes, of how often a client will contact the KMS host after the client is licensed.|
|**KeyManagementServiceCurrentCount**|The count of currently active KMS clients on the KMS host. **\-1** indicates that the host is not enabled as a KMS or has not received any client licensing requests.|
|**RequiredClientCount**|The minimum number of clients required to connect to a KMS host in order to enable Volume Licensing.|
|**PolicyCacheRefreshRequired**|Indicates whether the licensing policy cache needs to be updated: **0**\=not required, **1**\=Refresh required.|
|**ClientMachineID**|The globally unique identifier \(GUID\) that identifies a KMS client to a KMS host. The client includes this in requests it sends to the KMS.|
|**RemainingWindowsReArmCount**|Remaining number of times the client can be rearmed successfully.|
|**KeyManagementServiceListeningPort**|The TCP port the KMS host uses to listen for activation requests.|
|**KeyManagementServiceDnsPublishing**|Indicates the DNS publishing status of a KMS host: **0**\=Disabled, **1**\=Auto\-publish enabled \(default\).|
|**KeyManagementServiceLowPriority**|Indicates the thread priority status of KMS service: **0**\=Normal Priority \(default\), **1**\=Low priority.|
|**KeyManagementServiceHostCaching**|Indicates the caching status of KMS host name and port: **0**\=Caching disabled, **1**\=Caching enabled \(default\).|
|**KeyManagementServiceUnlicensedRequests**|The count of KMS requests from clients with License Status\=0 \(Unlicensed\).|
|**KeyManagementServiceLicensedRequests**|The count of KMS requests from clients with License Status\=1 \(Licensed\).|
|**KeyManagementServiceOOBGraceRequests**|The count of KMS requests from clients with License Status\=2 \(OOBGrace\).|
|**KeyManagementServiceOOTGraceRequests**|The count of KMS requests from clients with License Status\=3 \(OOTGrace\).|
|**KeyManagementServiceNonGenuineGraceRequests**|The count of KMS requests from clients with License Status\=4 \(NonGenuineGrace\).|
|**KeyManagementServiceNotificationRequests**|The count of KMS requests from clients with License Status\=5 \(Notification\).|
|**KeyManagementServiceTotalRequests**|The total count of valid KMS requests.|
|**KeyManagementServiceFailedRequests**|The count of invalid KMS requests.|
|**KeyManagementServiceActivationDisabled**|Indicates whether the volume activation through KMS is disabled.|

**\/\/methods SoftwareLicensingService Class**

|Version|Version of the Software Protection Service|
|-----------|----------------------------------------------|
|**InstallProductKey**|Installs a product key.|
|**InstallLicense**|Installs a license.|
|**InstallLicensePackage**|Installs a license package for the current product.|
|**SetKeyManagementServiceMachine**|Sets the KMS host name to use for volume activation.|
|**ClearKeyManagementServiceMachine**|Clears any previously configured KMS host name.|
|**SetKeyManagementServicePort**|Sets the TCP port used by a client to make requests of a KMS host. If not specified, port 1688 is used.|
|**ClearKeyManagementServicePort**|Clears any previously specified port number.|
|**SetVLActivationInterval**|The activation frequency, in minutes, of how often KMS clients will contact the KMS host before they become licensed. The frequency must be ≥15 and ≤43,200. An error is returned if the method is called and the computer is not a KMS.|
|**SetVLRenewalInterval**|The renewal frequency, in minutes, of how often KMS clients will contact the KMS host after they have become licensed. The frequency must be ≥15 and ≤43,200. An error is returned if the method is called and the computer is not a KMS.|
|**ClearProductKeyFromRegistry**|Clears product key from the registry.|
|**AcquireGenuineTicket**|Perform online Genuine Validation. Calling this method may change the Genuine status of the computer.|
|**ReArmWindows**|Resets the licensing status of the computer to OOB Grace \(see **LicenseStatus**\). **Note:** You must restart the client for the changes to take effect.|
|**RefreshLicenseStatus**|Updates the licensing status of Windows so that applications have access to current licensing information.|
|**SetKeyManagementServiceListeningPort**|Sets the TCP port used by a KMS host to listen for activation requests. Applies to KMS hosts only. If not specified, port 1688 is used.|
|**ClearKeyManagementServiceListeningPort**|Clears any previously specified listening port. Applies to KMS hosts only.|
|**DisableKeyManagementServiceDnsPublishing**|Enable\/disable DNS Publishing on a KMS host computer: **0**\=Enable, **1**\=Disable.|
|**EnableKeyManagementServiceLowPriority**|Enable\/disable KMS service running with low priority: **0**\=Disable, **1**\=Enable.|
|**DisableKeyManagementServiceHostCaching**|Enable\/disable the caching of the KMS host name and port on a volume activation client computer: **0**\=Enable, **1**\=Disable.|
|**DisableKeyManagementServiceActivation**|Enable\/disable volume activation through a KMS computer: **0**\=Enable, **1**\=Disable.|
|**DiscoveredKeyManagementServiceMachineName**|Last discovered KMS host name through DNS.|
|**DiscoveredKeyManagementServiceMachinePort**|Last discovered KMS host port through DNS.|
|**GenerateActiveDirectoryOfflineActivationId**|Generates an installation ID for use in Active Directory activation using the specified product key.|
|**DepositActiveDirectoryOfflineActivationConfirmation**|Processes an installation ID, a confirmation ID, and ActivationObjectName to generate and publish the activation object in Active Directory.|
|**DoActiveDirectoryOnlineActivation**|Performs online activation of Active Directory using a specified product key.|
|**SetVLActivationTypeEnabled**|Sets the activation method.|
|**ClearVLActivationTypeEnabled**|Clears previously specified activation method.|

**\/\/properties SoftwareLicensingProduct Class**

|Version|Version of the Software Protection Service|
|-----------|----------------------------------------------|
|**ID**|Product identifier|
|**Name**|Product name|
|**Description**|Product description|
|**ApplicationID**|ID of current product’s application|
|**ProcessorURL**|Software licensing server URL for the process certificate|
|**MachineURL**|Software licensing server URL for the binding certificate|
|**ProductKeyURL**|Software licensing server URL for the product certificate|
|**UseLicenseURL**|Software licensing server URL for the user license|
|**LicenseStatus**|License status of this product's application:<br /><br />**0**\=Unlicensed,<br /><br />**1**\=Licensed,<br /><br />**2**\=OOBGrace,<br /><br />**3**\=OOTGrace,<br /><br />**4**\=NonGenuineGrace,<br /><br />**5**\=Notification,<br /><br />**6**\=ExtendedGrace|
|**LicenseStatusReason**|A diagnostic code that indicates why a computer is in a specific licensing state.|
|**GracePeriodRemaining**|Remaining time in minutes before the parent application goes into Notification mode. For volume clients, this is the remaining time before reactivation is required.|
|**EvaluationEndDate**|The expiration date of this product’s application. After this date, the **LicenseStatus** will be **Unlicensed** and cannot be activated.|
|**OfflineInstallationId**|An identifier for this product's application that can be used for telephone or offline activation. Returns null if a product key is not installed.|
|**PartialProductKey**|Last five characters of this product’s key. Returns null if a product key is not installed.|
|**ProductKeyID**|Product key ID. Returns null if a product key is not installed.|
|**LicenseFamily**|The family identifier for the SKU used to determine license relationships for add\-ons.|
|**LicenseDependsOn**|The dependency identifier for the family of SKUs used to determine license relationships for add\-ons.|
|**LicenseIsAddon**|Returns **True** if the product is identified as an add\-on license.|
|**VLActivationInterval**|The frequency, in minutes, of how often a client will contact the KMS host before the product is licensed.|
|**VLRenewalInterval**|The frequency, in minutes, of how often a client will contact the KMS host after the product is licensed.|
|**KeyManagementServiceProductKeyID**|KMS product key ID. Returns null if not applicable.|
|**KeyManagementServiceMachine**|The name of the KMS host. Returns null if **SetKeyManagementServiceMachine** has not been called.|
|**KeyManagementServicePort**|The TCP port used by clients to send KMS activation requests. Returns **0** if **SetKeyManagementServicePort** has not been called.|
|**DiscoveredKeyManagementServiceMachineName**|Last discovered KMS host name through DNS.|
|**DiscoveredKeyManagementServiceMachinePort**|Last discovered KMS host port through DNS.|
|**IsKeyManagementServiceMachine**|Indicates if KMS is enabled on the computer: **1** if true, **0** if false.|
|**KeyManagementServiceCurrentCount**|The count of currently active KMS clients on the KMS host. **\-1** indicates that the computer is not enabled as a KMS or has not received any client licensing requests.|
|**RequiredClientCount**|The minimum number of clients required to connect to a KMS host in order to enable Volume Licensing.|
|**KeyManagementServiceUnlicensedRequests**|The count of KMS requests from clients with License Status\=0 \(Unlicensed\).|
|**KeyManagementServiceLicensedRequests**|The count of KMS requests from clients with License Status\=1 \(Licensed\).|
|**KeyManagementServiceOOBGraceRequests**|The count of KMS requests from clients with License Status\=2 \(OOBGrace\).|
|**KeyManagementServiceOOTGraceRequests**|The count of KMS requests from clients with License Status\=3 \(OOTGrace\).|
|**KeyManagementServiceNonGenuineGraceRequests**|The count of KMS requests from clients with License Status\=4 \(NonGenuineGrace\).|
|**KeyManagementServiceTotalRequests**|The total count of valid KMS requests.|
|**KeyManagementServiceFailedRequests**|The count of failed KMS requests.|
|**KeyManagementServiceNotificationRequests**|The count of KMS requests from clients with License Status\=5 \(Notification\).|
|**GenuineStatus**|Genuine status for this product’s application.|
|**ExtendedGrace**|Extended grace time in minutes before the parent application becomes unlicensed.|
|**TrustedTime**|Displays the currently stored trusted time in the system.|
|**DisableKeyManagementServiceHostCaching**|Enable\/disable the caching of the KMS host name and port on a volume activation client computer: 0\=Enable, 1\=Disable.|
|**VLActivationType**|Defines the activation type used for the last successful client activation: 1\=Active Directory, 2\=KMS, 3\=Token. If blank, the client was never activated.|
|**VLActivationTypeEnabled**|Activation type configured for the volume licensing client: 1\=Active Directory, 2\=KMS, 3\=Token. If blank or 0, all activation types are configured.|
|**ADActivationObjectName**|Name of the activation object used for the last Active Directory activation.|
|**ADActivationObjectDN**|The fully qualified distinguished name of the activation object used for the last Active Directory activation.|
|**ADActivationCsvlkPid**|The CSVLK PID that is in the activation object used for the last Active Directory activation.|
|**ADActivationCsvlkSkuId**|The CSVLK SKU ID that is in the activation object used for the last Active Directory activation.|

**\/\/ methods SoftwareLicensingProduct Class**

|||
|-|-|
|**UninstallProductKey**|Uninstalls a product key for the current product.|
|**Activate**|Activates the current product.|
|**DepositOfflineConfirmationId**|Activates a product by depositing an Offline Confirmation Identifier for this product when performing telephone or offline activation.|
|**GetPolicyInformationDWord**|Gets license policy information of type DWORD.|
|**GetPolicyInformationString**|Gets policy information of type string.|
|**SetKeyManagementServiceMachine**|Sets the KMS host name to use for volume activation.|
|**ClearKeyManagementServiceMachine**|Clears any previously configured KMS host name.|
|**SetKeyManagementServicePort**|Sets the TCP port used by a client to make requests of a KMS host. If not specified, port 1688 is used.|
|**ClearKeyManagementServicePort**|Clears any previously specified port number.|
|**SetVLActivationTypeEnabled**|Sets the configured activation method for the volume licensing client.|
|**ClearVLActivationTypeEnabled**|Clears any previously specified activation method configured for the volume licensing client.|

## See also

-   [Volume Activation Technical Reference](../Volume-Activation-Technical-Reference.md)

-   [Volume Activation Overview]()



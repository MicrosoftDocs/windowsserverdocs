---
title: WMI Properties and Methods for volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df2d6c46-ea33-4a1b-83bf-6aebae40b99c
---
# WMI Properties and Methods for volume Activation
Table 12 lists WMI properties and methods for the Software Protection Platform. Software Protection Platform properties are defined in the file %Windir%\\System32\\wbem\\sppwmi.mof.

**Table 12. Software protection platform WMI properties and methods**

**\/\/properties SoftwareLicensingService Class**

|version|version of the Software Protection Service|
|-----------|----------------------------------------------|
|**KeymanagementServiceMachine**|The name of the KMS host. Returns null if **SetKeymanagementServiceMachine** has not been called.|
|**OA3xOriginalproductKeyDescription**|**Returns the description for the key installed on a given device**|
|**KeymanagementServicePort**|The TCP port used by clients to send KMS activation requests. Returns **0** if **SetKeymanagementServicePort** has not been called.|
|**IsKeymanagementServiceMachine**|Indicates whether KMS is enabled on the computer: **0** if false, **1** if true.|
|**VLActivationInterval**|The frequency, in minutes, of how often a client will contact the KMS host before the client is licensed.|
|**VLrenewalInterval**|The frequency, in minutes, of how often a client will contact the KMS host after the client is licensed.|
|**KeymanagementServiceCurrentCount**|The count of currently active KMS clients on the KMS host. **\-1** indicates that the host is not enabled as a KMS or has not received any client licensing requests.|
|**RequiredClientCount**|The minimum number of clients required to connect to a KMS host in order to enable volume Licensing.|
|**PolicyCacheRefreshRequired**|Indicates whether the licensing policy cache needs to be updated: **0**\=not required, **1**\=Refresh required.|
|**ClientMachineID**|The globally unique identifier \(GUID\) that identifies a KMS client to a KMS host. The client includes this in requests it sends to the KMS.|
|**remainingWindowsReArmCount**|remaining number of times the client can be rearmed successfully.|
|**KeymanagementServicelisteningPort**|The TCP port the KMS host uses to listen for activation requests.|
|**KeymanagementServiceDnsPublishing**|Indicates the DNS publishing status of a KMS host: **0**\=Disabled, **1**\=Auto\-publish enabled \(default\).|
|**KeymanagementServiceLowPriority**|Indicates the thread priority status of KMS service: **0**\=Normal Priority \(default\), **1**\=Low priority.|
|**KeymanagementServiceHostCaching**|Indicates the caching status of KMS host name and port: **0**\=Caching disabled, **1**\=Caching enabled \(default\).|
|**KeymanagementServiceUnlicensedRequests**|The count of KMS requests from clients with License Status\=0 \(Unlicensed\).|
|**KeymanagementServiceLicensedRequests**|The count of KMS requests from clients with License Status\=1 \(Licensed\).|
|**KeymanagementServiceOOBGraceRequests**|The count of KMS requests from clients with License Status\=2 \(OOBGrace\).|
|**KeymanagementServiceOOTGraceRequests**|The count of KMS requests from clients with License Status\=3 \(OOTGrace\).|
|**KeymanagementServiceNonGenuineGraceRequests**|The count of KMS requests from clients with License Status\=4 \(NonGenuineGrace\).|
|**KeymanagementServiceNotificationRequests**|The count of KMS requests from clients with License Status\=5 \(Notification\).|
|**KeymanagementServiceTotalRequests**|The total count of valid KMS requests.|
|**KeymanagementServiceFailedRequests**|The count of invalid KMS requests.|
|**KeymanagementServiceActivationDisabled**|Indicates whether the volume activation through KMS is disabled.|

**\/\/methods SoftwareLicensingService Class**

|version|version of the Software Protection Service|
|-----------|----------------------------------------------|
|**InstallproductKey**|Installs a product key.|
|**InstallLicense**|Installs a license.|
|**InstallLicensePackage**|Installs a license package for the current product.|
|**SetKeymanagementServiceMachine**|Sets the KMS host name to use for volume activation.|
|**ClearKeymanagementServiceMachine**|Clears any previously configured KMS host name.|
|**SetKeymanagementServicePort**|Sets the TCP port used by a client to make requests of a KMS host. if not specified, port 1688 is used.|
|**ClearKeymanagementServicePort**|Clears any previously specified port number.|
|**SetVLActivationInterval**|The activation frequency, in minutes, of how often KMS clients will contact the KMS host before they become licensed. The frequency must be ≥15 and ≤43,200. An error is returned if the method is called and the computer is not a KMS.|
|**SetVLrenewalInterval**|The renewal frequency, in minutes, of how often KMS clients will contact the KMS host after they have become licensed. The frequency must be ≥15 and ≤43,200. An error is returned if the method is called and the computer is not a KMS.|
|**ClearproductKeyFromregistry**|Clears product key from the registry.|
|**AcquiregenuineTicket**|Perform online Genuine Validation. calling this method may change the Genuine status of the computer.|
|**ReArmWindows**|resets the licensing status of the computer to OOB Grace \(see **LicenseStatus**\). **Note:** You must restart the client for the changes to take effect.|
|**RefreshLicenseStatus**|Updates the licensing status of Windows so that applications have access to current licensing information.|
|**SetKeymanagementServicelisteningPort**|Sets the TCP port used by a KMS host to listen for activation requests. Applies to KMS hosts only. if not specified, port 1688 is used.|
|**ClearKeymanagementServicelisteningPort**|Clears any previously specified listening port. Applies to KMS hosts only.|
|**DisableKeymanagementServiceDnsPublishing**|Enable\/disable DNS Publishing on a KMS host computer: **0**\=Enable, **1**\=Disable.|
|**EnableKeymanagementServiceLowPriority**|Enable\/disable KMS service running with low priority: **0**\=Disable, **1**\=Enable.|
|**DisableKeymanagementServiceHostCaching**|Enable\/disable the caching of the KMS host name and port on a volume activation client computer: **0**\=Enable, **1**\=Disable.|
|**DisableKeymanagementServiceActivation**|Enable\/disable volume activation through a KMS computer: **0**\=Enable, **1**\=Disable.|
|**DiscoveredKeymanagementServiceMachineName**|Last discovered KMS host name through DNS.|
|**DiscoveredKeymanagementServiceMachinePort**|Last discovered KMS host port through DNS.|
|**GenerateactivedirectoryofflineActivationId**|Generates an installation ID for use in active directory activation using the specified product key.|
|**DepositactivedirectoryofflineActivationConfirmation**|Processes an installation ID, a confirmation ID, and ActivationObjectName to generate and publish the activation object in active directory.|
|**DoactivedirectoryonlineActivation**|Performs online activation of active directory using a specified product key.|
|**SetVLActivationtypeEnabled**|Sets the activation method.|
|**ClearVLActivationtypeEnabled**|Clears previously specified activation method.|

**\/\/properties SoftwareLicensingProduct Class**

|version|version of the Software Protection Service|
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
|**GracePeriodremaining**|remaining time in minutes before the parent application goes into Notification mode. for volume clients, this is the remaining time before reactivation is required.|
|**EvaluationEnddate**|The expiration date of this product’s application. After this date, the **LicenseStatus** will be **Unlicensed** and cannot be activated.|
|**offlineInstallationId**|An identifier for this product's application that can be used for telephone or offline activation. Returns null if a product key is not installed.|
|**PartialproductKey**|Last five characters of this product’s key. Returns null if a product key is not installed.|
|**ProductKeyID**|Product key ID. Returns null if a product key is not installed.|
|**LicenseFamily**|The family identifier for the SKU used to determine license relationships for add\-ons.|
|**LicenseDependsOn**|The dependency identifier for the family of SKUs used to determine license relationships for add\-ons.|
|**LicenseIsaddon**|Returns **True** if the product is identified as an add\-on license.|
|**VLActivationInterval**|The frequency, in minutes, of how often a client will contact the KMS host before the product is licensed.|
|**VLrenewalInterval**|The frequency, in minutes, of how often a client will contact the KMS host after the product is licensed.|
|**KeymanagementServiceProductKeyID**|KMS product key ID. Returns null if not applicable.|
|**KeymanagementServiceMachine**|The name of the KMS host. Returns null if **SetKeymanagementServiceMachine** has not been called.|
|**KeymanagementServicePort**|The TCP port used by clients to send KMS activation requests. Returns **0** if **SetKeymanagementServicePort** has not been called.|
|**DiscoveredKeymanagementServiceMachineName**|Last discovered KMS host name through DNS.|
|**DiscoveredKeymanagementServiceMachinePort**|Last discovered KMS host port through DNS.|
|**IsKeymanagementServiceMachine**|Indicates if KMS is enabled on the computer: **1** if true, **0** if false.|
|**KeymanagementServiceCurrentCount**|The count of currently active KMS clients on the KMS host. **\-1** indicates that the computer is not enabled as a KMS or has not received any client licensing requests.|
|**RequiredClientCount**|The minimum number of clients required to connect to a KMS host in order to enable volume Licensing.|
|**KeymanagementServiceUnlicensedRequests**|The count of KMS requests from clients with License Status\=0 \(Unlicensed\).|
|**KeymanagementServiceLicensedRequests**|The count of KMS requests from clients with License Status\=1 \(Licensed\).|
|**KeymanagementServiceOOBGraceRequests**|The count of KMS requests from clients with License Status\=2 \(OOBGrace\).|
|**KeymanagementServiceOOTGraceRequests**|The count of KMS requests from clients with License Status\=3 \(OOTGrace\).|
|**KeymanagementServiceNonGenuineGraceRequests**|The count of KMS requests from clients with License Status\=4 \(NonGenuineGrace\).|
|**KeymanagementServiceTotalRequests**|The total count of valid KMS requests.|
|**KeymanagementServiceFailedRequests**|The count of failed KMS requests.|
|**KeymanagementServiceNotificationRequests**|The count of KMS requests from clients with License Status\=5 \(Notification\).|
|**GenuineStatus**|Genuine status for this product’s application.|
|**ExtendedGrace**|Extended grace time in minutes before the parent application becomes unlicensed.|
|**Trustedtime**|Displays the currently stored trusted time in the system.|
|**DisableKeymanagementServiceHostCaching**|Enable\/disable the caching of the KMS host name and port on a volume activation client computer: 0\=Enable, 1\=Disable.|
|**VLActivationtype**|Defines the activation type used for the last successful client activation: 1\=active directory, 2\=KMS, 3\=Token. if blank, the client was never activated.|
|**VLActivationtypeEnabled**|Activation type configured for the volume licensing client: 1\=active directory, 2\=KMS, 3\=Token. if blank or 0, all activation types are configured.|
|**ADActivationObjectName**|Name of the activation object used for the last active directory activation.|
|**ADActivationObjectDN**|The fully qualified distinguished name of the activation object used for the last active directory activation.|
|**ADActivationCsvlkPid**|The CSVLK PID that is in the activation object used for the last active directory activation.|
|**ADActivationCsvlkSkuId**|The CSVLK SKU ID that is in the activation object used for the last active directory activation.|

**\/\/ methods SoftwareLicensingProduct Class**

|||
|-|-|
|**UninstallproductKey**|Uninstalls a product key for the current product.|
|**Activate**|Activates the current product.|
|**DepositofflineConfirmationId**|Activates a product by depositing an offline Confirmation Identifier for this product when performing telephone or offline activation.|
|**GetPolicyInformationDWord**|Gets license policy information of type DWOrd.|
|**GetPolicyInformationString**|Gets policy information of type string.|
|**SetKeymanagementServiceMachine**|Sets the KMS host name to use for volume activation.|
|**ClearKeymanagementServiceMachine**|Clears any previously configured KMS host name.|
|**SetKeymanagementServicePort**|Sets the TCP port used by a client to make requests of a KMS host. if not specified, port 1688 is used.|
|**ClearKeymanagementServicePort**|Clears any previously specified port number.|
|**SetVLActivationtypeEnabled**|Sets the configured activation method for the volume licensing client.|
|**ClearVLActivationtypeEnabled**|Clears any previously specified activation method configured for the volume licensing client.|

## See also

-   [volume Activation Technical Reference](../volume-activation-technical-reference.md)

-   [volume Activation Overview]()



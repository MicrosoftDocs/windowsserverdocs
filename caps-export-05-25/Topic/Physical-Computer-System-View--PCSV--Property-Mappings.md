---
title: Physical Computer System View (PCSV) Property Mappings
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 39e01824-12b9-4042-86ab-9ff2e0006e3e
author: britw
---
# Physical Computer System View (PCSV) Property Mappings
This topic provides information about how properties that are exposed by the Datacenter Abstraction Layer \(DAL\) are mapped to the values found on the hardware device itself. The DAL exposes device information by using a Physical Computer System View \(PCSV\) instance. This document serves as a reference for hardware manufacturers and developers of management firmware to ensure that their implementation is consistent with the DAL management model. Additionally, IT pros can use the following tables to determine what properties are expected to have empty values when they see a warning about absent profiles in Windows PowerShell.  
  
## SMASH\/DASH property mappings  
The following table lists the Systems Management Architecture for Server Hardware \(SMASH\) and Desktop and Mobile Architecture for System Hardware \(DASH\) profiles and properties that are used by the DAL to display information about the hardware device. You can use this table to determine which Distributed Management Task Force \(DMTF\) profiles and specific properties are required in the management firmware implementation.  
  
For devices that conform to the SMASH and DASH standards, the management firmware implementation is required to have a registered Base Server or Base Desktop and Mobile profile to be managed by the DAL. In addition, the following optional profiles must be registered for the DAL to expose the corresponding property values \(refer to the following table\):  
  
-   Boot Control  
  
-   Physical Asset  
  
-   Software Inventory  
  
If these profile registrations are absent, a client using the DAL to manage your device will not receive an error message that indicates the absence of these profiles, and the corresponding PCSV properties will have empty values. In certain client implementations \(for example, Windows PowerShell\) the user will see a warning message that indicates the profiles are not present.  
  
|PCSV Property|DMTF Profile Name|Property Mapping|Comment|  
|-----------------|---------------------|--------------------|-----------|  
|Dedicated|Base Server\/Base Desktop and Mobile|ComputerSystem.Dedicated|No comment|  
|EnabledState|Base Server\/Base Desktop and Mobile|ComputerSystem.EnabledState|No comment|  
|OneTimeBootSource|Boot Control|BootSourceSetting.StructuredBootString \(where ComputerSystem \-> ElementSettingData.IsNext\={1&#124;3} \-> BootConfigSetting \-> OrderedComponent.AssignedSequence\=1 \-> BSS\)|No comment|  
|StructuredBootString|Boot Control|BootSourceSetting.StructuredBootString \(where ComputerSystem \-> ElementSettingData.IsNext\={1&#124;3} \-> BootConfigSetting \-> OrderedComponent.AssignedSequence\!\=0 \-> BSS\)|No comment|  
|HealthState|Computer System|ComputerSystem.HealthState|No comment|  
|IdentifyingDescriptions|Computer System|ComputerSystem.IdentifyingDescriptions|No comment|  
|OperationalStatus|Computer System|ComputerSystem.OperationalStatus|No comment|  
|OtherDedicatedDescriptions|Computer System|ComputerSystem.OtherDedicatedDesriptions|No comment|  
|OtherIdentifyingInfo|Computer System|ComputerSystem.OtherIdentifyingInfo|No comment|  
|RequestedState|Computer System|ComputerSystem.RequestedState|No comment|  
|InstanceID|N\/A|Computed value|Populated by PcsvDevice provider as 0\-indexed integer|  
|TargetAddress|N\/A|Computed value|The device address given to the provider|  
|FRUInfoSupported|Physical Asset|Chassis \-> PhysicalAssetCapabilities.FRUInfoSupported|No comment|  
|Manufacturer|Physical Asset|Chassis.Manufacturer|No comment|  
|Model|Physical Asset|Chassis.Model|No comment|  
|PartNumber|Physical Asset|Chassis.PartNumber|No comment|  
|SerialNumber|Physical Asset|Chassis.SerialNumber|No comment|  
|SKU|Physical Asset|Chassis.SKU|No comment|  
|Tag|Physical Asset|Chassis.Tag|No comment|  
|Version|Physical Asset|Chassis.Version|No comment|  
|CurrentBIOSBuildNumber|Software Inventory|SoftwareIdentity.BuildNumber Classification \= 11 "BIOS"|No comment|  
|CurrentBIOSMajorVersion|Software Inventory|SoftwareIdentity.MajorVersion Classification \= 11 "BIOS"|No comment|  
|CurrentBIOSMinorVersion|Software Inventory|SoftwareIdentity.MinorVersion Classification \= 11 "BIOS"|No comment|  
|CurrentBIOSRevisionNumber|Software Inventory|SoftwareIdentity.RevisionNumber Classification \= 11 "BIOS"|No comment|  
|CurrentBIOSVersionString|Software Inventory|SoftwareIdentity.VersionString Classification \= 11 "BIOS"|No comment|  
|CurrentManagementFirmwareBuildNumber|Software Inventory|SoftwareIdentity.BuildNumber Classification \= 10 "Firmware" \(Dedicated \= 28 "Management Controller"\)|The Dedicated value refers to the associated ManagedElement|  
|CurrentManagementFirmwareElementName|Software Inventory|SoftwareIdentity.ElementName Classification \= 10 "Firmware" \(Dedicated \= 28 "Management Controller"\)|The Dedicated value refers to the associated ManagedElement|  
|CurrentManagementFirmwareMajorVersion|Software Inventory|SoftwareIdentity.MajorVersion Classification \= 10 "Firmware" \(Dedicated \= 28 "Management Controller"\)|The Dedicated value refers to the associated ManagedElement|  
|CurrentManagementFirmwareMinorVersion|Software Inventory|SoftwareIdentity.MinorVersion Classification \= 10 "Firmware" \(Dedicated \= 28 "Management Controller"\)|The Dedicated value refers to the associated ManagedElement|  
|CurrentManagementFirmwareRevisionNumber|Software Inventory|SoftwareIdentity.RevisionNumber Classification \= 10 "Firmware" \(Dedicated \= 28 "Management Controller"\)|The Dedicated value refers to the associated ManagedElement|  
|CurrentManagementFirmwareVersionString|Software Inventory|SoftwareIdentity.VersionString Classification \= 10 "Firmware" \(Dedicated \= 28 "Management Controller"\)|The Dedicated value refers to the associated ManagedElement|  
  
## IPMI property mappings  
The following table lists the Intelligent Platform Management Interface \(IPMI\) commands and their associated return values, which are used by the DAL to populate the corresponding PCSV properties.  
  
|Property Name|IPMI Mapping|  
|-----------------|----------------|  
|InstanceID|Computed value|  
|CurrentBIOSVersionString|Get System Info Parameters \- Parameter 1 \(System Firmware Version\)|  
|CurrentManagementFirmwareElementName|OOB MAP Firmware \(hardcoded\)|  
|CurrentManagementFirmwareMajorVersion|Get Device Id \- Firmware Revision 1|  
|CurrentManagementFirmwareMinorVersion|Get Device Id \- Firmware Revision 2|  
|CurrentManagementFirmwareVersionString|\[MajV\]\-\[MinV\]\-\[Get Device Id \- Auxilliary Firmware Revision Info\]|  
|Dedicated|28 \(hardcoded\)|  
|EnabledState|Get Chassis Status \- Current Power State|  
|FRUInfoSupported|\(Read Fru Data.BoardInfo present &#124; Read Fru Data.ProductInfo present\)|  
|HealthState|0 \(hardcoded\)|  
|IdentifyingDescriptions|Manufacturer ID\-Product ID \(hardcoded\)|  
|Manufacturer|Read Fru Data \- Board Info \- Manufacturer|  
|Model|Read Fru Data \- Board Info \- ProductName|  
|OperationalStatus|0 \(hardcoded\)|  
|OtherIdentifyingInfo|\[Get Device Id \- Manufacturer Id\]\-\[Get Device Id \- Product Id\]|  
|PartNumber|Read Fru Data \- BoardInfo \- Part Number|  
|RequestedState|12 \(hardcoded\)|  
|SerialNumber|Read Fru Data \- BoardInfo \- Serial Number|  
|StructuredBootString|CIM:Network:1, CIM:Hard\-Disk:1, CIM:CD\/DVD:1, CIM:USB:1, CIM:Floppy:1 \(hardcoded\)|  
|Version|Read Fru Data \- Product Info \- Version|  
|TargetAddress|Computed value|  
  
## Unimplemented properties  
A number of PCSV properties are not implemented in the first version of the DAL, which was released with[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. These properties are listed in the following table.  
  
|Null Values|  
|---------------|  
|Caption|  
|Description|  
|ElementName|  
|LogCurrentNumberOfRecords|  
|LogInstanceID|  
|LogMaxNumberOfRecords|  
|LogOverwritePolicy|  
|LogState|  
|MemoryBlockSize|  
|MemoryConsumableBlocks|  
|MemoryNumberOfBlocks|  
|NumberOfProcessorCores|  
|NumberOfProcessors|  
|NumberOfProcessorThreads|  
|NumericSensorBaseUnits|  
|NumericSensorContext|  
|NumericSensorCurrentReading|  
|NumericSensorCurrentState|  
|NumericSensorElementName|  
|NumericSensorEnabledState|  
|NumericSensorHealthState|  
|NumericSensorLowerThresholdCritical|  
|NumericSensorLowerThresholdFatal|  
|NumericSensorLowerThresholdNonCritical|  
|NumericSensorOtherSensorTypeDescription|  
|NumericSensorPrimaryStatus|  
|NumericSensorRateUnits|  
|NumericSensorSensorType|  
|NumericSensorUnitModifier|  
|NumericSensorUpperThresholdCritical|  
|NumericSensorUpperThresholdFatal|  
|NumericSensorUpperThresholdNonCritical|  
|OSEnabledState|  
|OSType|  
|OSVersion|  
|PersistentBootConfigOrder|  
|PowerAllocationLimit|  
|PowerUtilizationMode|  
|PowerUtilizationModesSupported|  
|ProcessorCurrentClockSpeed|  
|ProcessorFamily|  
|ProcessorMaxClockSpeed|  
  
## See also  
  
-   [Datacenter Abstraction Layer &#40;DAL&#41; Overview](../Topic/Datacenter-Abstraction-Layer--DAL--Overview.md)  
  
-   [Physical Computer System View \(PCSV\) Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/dn283380(v=wps.630).aspx)  
  

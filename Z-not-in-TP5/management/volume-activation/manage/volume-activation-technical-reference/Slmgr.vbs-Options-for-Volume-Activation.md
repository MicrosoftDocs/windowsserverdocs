---
title: Slmgr.vbs Options for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4f3b56d-cf2b-42df-9da0-d28a5e1ddeef
---
# Slmgr.vbs Options for Volume Activation
Because of WMI changes in  Windows 7  and  Windows Server 2008 R2 , the Slmgr.vbs script is not intended to work across platforms. Using Slmgr.vbs to manage a  Windows 7  or  Windows Server 2008 R2  system from the Windows Vista® operating system is not supported. Attempting to manage an older system from  Windows 7  or  Windows Server 2008 R2  will generate a specific version mismatch error. For example, running cscript slmgr.vbs <vista_machine_name> /dlv produces the following output:

```
Microsoft (R) Windows Script Host Version 5.8
Copyright (C) Microsoft Corporation. All rights reserved.

The remote machine does not support this version of SLMgr.vbs
```

To manage remote clients, use the Volume Activation Management Tool (VAMT) version 1.2 or later, or create custom WMI scripts that are aware of the differences between platforms. For more information about WMI properties and methods for Volume Activation, see the section, “WMI Properties and Methods,” later in this reference guide.

The following describes the syntax of the Slmgr.vbs script, and Table 2 describes each command-line option:

```
slmgr.vbs [MachineName [User Password]] [<Option>]
```

> [!NOTE]
> For support of other software using Volume Activation, see the documents specifically written for those applications.

**Table 2. Slmgr.vbs command-line options**

|||
|-|-|
|**Option**|**Description**|
|**[MachineName]**|Name of a remote computer (default is local computer)|
|**[User]**|Account with the required privilege on the remote computer|
|**[Password]**|Password for the account with required privileges on the remote computer|

**Global options**

|||
|-|-|
|**/ipk <ProductKey>**|Attempts to install a 5×5 product key. The product key provided by the parameter is confirmed valid and applicable to the installed operating system.<br /><br />If not, an error is returned.<br /><br />If the key is valid and applicable, the key is installed. If a key is already installed, it is silently replaced.<br /><br />To prevent instability in the license service, the system should be restarted or the Software Protection Service should be restarted.<br /><br />This operation must be run from an elevated command prompt, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service.|
|**/ato [Activation ID]**|For retail editions and volume systems with a KMS host key or a Multiple Activation Key (MAK) installed, **/ato** prompts Windows to attempt online activation.<br /><br />For systems with a Generic Volume License Key (GVLK) installed, this prompts an attempt at KMS activation. Systems that have been set to suspend automatic KMS activation attempts (/stao) still attempt KMS activation when /ato is run. **Note:** Starting with Windows 8 (and Windows Server 2012), the /stao option is deprecated. Use the /act-type option instead.<br /><br />The parameter [Activation ID] expands /ato support to identify a Windows edition installed on the computer. Specifying the [Activation ID] parameter isolates the effects of the option to the edition associated with that Activation ID. Run Slmgr.vbs /dlv all to get the Activation IDs for the installed version of Windows. If you need to support other applications, see the guidance provided by that application for further instruction.<br /><br />KMS activation does not require elevated privileges. However, online activation does require elevation, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service.|
|**/dli [Activation ID &#124; All]**|Display license information.<br /><br />By default, **/dli** displays the license information for the installed active Windows edition. Specifying the **[Activation ID]** parameter displays the license information for the specified edition associated with that Activation ID. Specifying **[All]** as the parameter will display all applicable installed products’ license information.<br /><br />This operation does not require elevated privileges.|
|**/dlv [Activation ID &#124; All]**|Display detailed license information.<br /><br />By default, **/dlv** displays the license information for the installed operating system. Specifying the **[Activation ID]** parameter displays the license information for the specified edition associated with that Activation ID. Specifying the **[All]** parameter displays all applicable installed products’ license information.<br /><br />This operation does not require elevated privileges.|
|**/xpr [Activation ID]**|Display the activation expiration date for the product. By default, this refers to the current Windows edition and is primarily useful for KMS clients, because MAK and retail activation is perpetual.<br /><br />Specifying the **[Activation ID]** parameter displays the activation expiration date of the specified edition associated with that Activation ID.This operation does not require elevated privileges.|

**Advanced options**

|||
|-|-|
|**/cpky**|Some servicing operations require the product key to be available in the registry during Out-of-Box Experience (OOBE) operations. The **/cpky** option removes the product key from the registry to prevent this key from being stolen by malicious code.<br /><br />For retail installations that deploy keys, best practices recommend running this option. This option is not required for MAK and KMS host keys, because this is the default behavior for those keys. This option is only needed for other types of keys where the default behavior is not to clear the key from the registry.<br /><br />This operation must be run from an elevated command prompt.|
|**/ilc <license_file>**|This option installs the license file specified by the required parameter. These licenses may be installed as a troubleshooting measure, to support token-based activation, or as part of a manual installation of an on-boarded application.<br /><br />Licenses are not validated during this process: License validation is out of scope for Slmgr. Instead, validation is handled by the Software Protection Service at runtime.<br /><br />This operation must be run from an elevated command prompt, or the **Standard User Operations** registry value must be set to allow unprivileged users extra access to the Software Protection Service.|
|**/rilc**|This option reinstalls all licenses stored in %SystemRoot%\system32\oem and %SystemRoot%\System32\spp\tokens. These are “known-good” copies stored during installation.<br /><br />Any matching licenses in the Trusted Store are replaced. Any additional licenses—for example, Trusted Authority (TA) Issuance Licenses (ILs), licenses for applications—are not affected.<br /><br />This operation must be run from an elevated command prompt, or the **Standard User Operations** registry value must be set to allow unprivileged users extra access to the Software Protection Service.|
|**/rearm**|This option resets the activation timers. The **/rearm** process is also called by **sysprep /generalize**.<br /><br />This operation will do nothing if the HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\SkipRearm registry subkey is equal to **1**. See the section “Registry Settings,” later in this guide, for details on this registry subkey.<br /><br />This operation must be run from an elevated command prompt, or the **Standard User Operations** registry value must be set to allow unprivileged users extra access to the Software Protection Service.|
|**/rearm-app <Application ID>**|Resets the licensing status of the specified app.|
|**/rearm-sku <Application ID>**|Resets the licensing status of the specified SKU.|
|**/upk [ActivationID]**|This option uninstalls the product key of the current Windows edition. After a restart, the system will be in an Unlicensed state unless a new product key is installed.<br /><br />Optionally, you can use the **[Activation ID]** parameter to specify a different installed product.<br /><br />This operation must be run from an elevated command prompt.|
|**/dti [Activation ID]**|Displays installation ID for offline activation.|
|**/atp <Confirmation ID>**|Activate product with user-provided confirmation ID.|

**Volume Licensing: KMS client options**

|||
|-|-|
|**/skms <Name[:Port] &#124; : port> [Activation ID]**|This option specifies the name and, optionally, the port of the KMS host computer to contact. Setting this value disables auto-detection of the KMS host.<br /><br />If the KMS host uses Internet Protocol version 6 (IPv6) only, the address must be specified in the format [hostname]:port. IPv6 addresses contain colons (:), which will be parsed incorrectly by the Slmgr.vbs script.<br /><br />This operation must be run from an elevated command prompt.|
|**/skms-domain <FQDN> [Activation ID]**|Sets the specific DNS domain in which all KMS SRV records can be found. This setting has no effect if the specific single KMS host is set with the /skms option. Use this option, especially in disjoint namespace environments, to force KMS to ignore the DNS suffix search list and look for KMS host records in the specified DNS domain instead.|
|**/ckms [Activation ID]**|This option removes the specified KMS host name, address, and port information from the registry and restores KMS auto-discovery behavior.<br /><br />This operation must be run from an elevated command prompt.|
|**/skhc**|This option enables KMS host caching (default), which blocks the use of Domain Name System (DNS) priority and weight after the initial discovery of a working KMS host. If the system can no longer contact the working KMS host, discovery will be attempted again.<br /><br />This operation must be run from an elevated command prompt.|
|**/ckhc**|This option disables KMS host caching. This setting instructs the client to use DNS auto-discovery each time it attempts KMS activation (recommended when using priority and weight).<br /><br />This operation must be run from an elevated command prompt.|

**KMS host configuration**

|||
|-|-|
|**/sai <interval>**|This option sets the interval in minutes for unactivated clients to attempt KMS connection. The activation interval must be between 15 minutes and 30 days, although the default (2 hours) is recommended.<br /><br />The KMS client initially picks up this interval from registry but switches to the KMS setting after it receives the first KMS response.<br /><br />This operation must be run from an elevated command prompt.|
|**/sri <interval>**|This option sets the renewal interval in minutes for activated clients to attempt KMS connection. The renewal interval must be between 15 minutes and 30 days. This option is set initially on both the KMS server and client sides. The default is 10080 minutes (7 days).<br /><br />The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response.<br /><br />This operation must be run from an elevated command prompt.|
|**/sprt <port>**|This option sets the port on which the KMS host listens for client activation requests. The default TCP port is 1688.<br /><br />This operation must be run from an elevated command prompt.|
|**/sdns**|Enable DNS publishing by the KMS host (default).<br /><br />This operation must be run from an elevated command prompt.|
|**/cdns**|Disable DNS publishing by the KMS host.<br /><br />This operation must be run from an elevated command prompt.|
|**/spri**|Set the KMS priority to normal (default).<br /><br />This operation must be run from an elevated command prompt.|
|**/cpri**|Set the KMS priority to low.<br /><br />Use this option to minimize contention from KMS in a co-hosted environment. Note that this could lead to KMS starvation, depending on what other applications or server roles are active. Use with care.<br /><br />This operation must be run from an elevated command prompt.|
|**/act-type [Activation-Type] [Activation ID]**|This option sets a value in the registry that limits volume activation to a single type. Activation Type **1** limits activation to Active Directory only; **2** limits it to KMS activation; **3** to token-based activation. The **0** option allows any activation type and is the default value.|

**Token-based activation configuration**

|||
|-|-|
|**/lil**|List the installed token-based activation issuance licenses.|
|**/ril <ILID> <ILvID>**|Remove an installed token-based activation issuance license.<br /><br />This operation must be run from an elevated command prompt.|
|**/stao**|Set the **Token-based Activation Only** flag, disabling automatic KMS activation.<br /><br />This operation must be run from an elevated command prompt.<br /><br />This option has been removed beginning with  Windows Server 2012 R2  and Windows 8.1. Use the **/act–type** option instead.|
|**/ctao**|Clear the **Token-based Activation Only** flag (default), enabling automatic KMS activation.<br /><br />This operation must be run from an elevated command prompt.<br /><br />This option has been removed beginning with  Windows Server 2012 R2  and Windows 8.1. Use the **/act–type** option instead.|
|**/ltc**|List valid token-based activation certificates that can activate installed software.|
|**/fta <Certificate Thumbprint> [<PIN>]**|Force token-based activation using the identified certificate. The optional personal identification number (PIN) is provided to unlock the private key without a PIN prompt when using certificates that are protected by hardware (for example, smart cards).|

**Active Directory-based activation configuration**

|||
|-|-|
|**/ad-activation-online <Product Key> [Activation Object name]**|Collects Active Directory data and initiates Active Directory forest activation using the credentials that the command prompt is running. Local administrator access is not required, but read/write access to the activation object container in the root domain of the forest is required.|
|**/ad-activation-get-IID <Product Key>**|This option starts Active Directory forest activation in phone mode.  The output is the installation ID (IID) that can be used to activate the forest over the telephone when Internet connectivity is not available. Upon providing the IID in the activation phone call, a CID is returned that is used to complete activation.|
|**/ad-activation-apply-cid <Product Key> <Confirmation ID> [Activation Object name]**|With this option, enter the CID provided from the activation phone call to complete activation|
|**[/name: <AO_Name>]**|Optionally, you can append the **/name** option to any of these commands to specify a name for the activation object stored in Active Directory. The name must not exceed 40 Unicode characters; use double quotation marks to explicitly define the name string.<br /><br />In  Windows Server 2012 R2  and Windows 8.1, you can append the name directly after **/ad-activation-online <Produce Key>** and **/ad-activation-apply-cid** without having to use the /name option.|
|**/ao-list**|Displays all of the activation objects that are available to the local computer.|
|**/del-ao <AO_DN>** or **/del-ao <AO_RDN>**|Deletes the specified activation object from the forest.|

## See also

-   [Volume Activation Technical Reference](../Volume-Activation-Technical-Reference.md)

-   [Volume Activation Overview](Volume-Activation-Overview.md)



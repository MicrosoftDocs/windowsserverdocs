---
title: Slmgr.vbs options for obtaining volume activation information
description: Lists the options availables for the Slmg.vbs script, and describes how to use them
TOCTitle: Slmgr.vbs Options
ms.date: 09/24/2019
ms.technology: server-general
ms.topic: article
author: Teresa-Motiv
ms.author: v-tea
manager: dcscontentpm
ms.localizationpriority: medium
appliesto:
- Windows Server 2012 R2
- Windows 10
- Windows 8.1
---

# Slmgr.vbs options for obtaining volume activation information

The following describes the syntax of the Slmgr.vbs script, and the tables in this article describe each command-line option.

```cmd
slmgr.vbs [<ComputerName> [<User> <Password>]] [<Options>]
```

> [!NOTE]
> In this article, square brackets \[] enclose optional arguments, and angle brackets \<> enclose placeholders. When you type these statements, omit the brackets and replace the placeholders by using corresponding values.

> [!NOTE]
> For information about other software products that use volume activation, see the documents specifically written for those applications.

## Using Slmgr on remote computers

To manage remote clients, use the Volume Activation Management Tool (VAMT) version 1.2 or later, or create custom WMI scripts that are aware of the differences between platforms. For more information about WMI properties and methods for Volume Activation, see [WMI Properties and Methods for Volume Activation](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn502536(v=ws.11)).

> [!IMPORTANT]
> Because of WMI changes in Windows 7 and Windows Server 2008 R2, the Slmgr.vbs script is not intended to work across platforms. Using Slmgr.vbs to manage a Windows 7 or Windows Server 2008 R2 system from the Windows Vista® operating system is not supported. Trying to manage an older system from Windows 7 or Windows Server 2008 R2 will generate a specific version mismatch error. For example, running **cscript slmgr.vbs \<vista\_machine\_name\> /dlv** produces the following output:
>  
>> Microsoft (R) Windows Script Host Version 5.8
>> Copyright (C) Microsoft Corporation. All rights reserved.
>>  
>> The remote machine does not support this version of SLMgr.vbs

## General Slmgr.vbs options

|Option |Description |
| - | - |
|\[\<ComputerName\>] |Name of a remote computer (default is local computer) |
|\[\<User\>] |Account that has the required privilege on the remote computer |
|\[\<Password\>] |Password for the account that has the required privileges on the remote computer |

## Global options

|Option |Description |
| - | - |
|\/ipk&nbsp;&lt;ProductKey&gt; |Tries to install a 5×5 product key. The product key provided by the parameter is confirmed valid and applicable to the installed operating system.<br />If not, an error is returned.<br />If the key is valid and applicable, the key is installed. If a key is already installed, it is silently replaced.<br />To prevent instability in the license service, the system should be restarted or the Software Protection Service should be restarted.<br />This operation must be run from an elevated Command Prompt window, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|/ato&nbsp;\[\<Activation&nbsp;ID\>] |For retail editions and volume systems that have a KMS host key or a Multiple Activation Key (MAK) installed, **/ato** prompts Windows to try online activation.<br />For systems that have a Generic Volume License Key (GVLK) installed, this prompts a KMS activation attempt. Systems that have been set to suspend automatic KMS activation attempts (**/stao**) still try KMS activation when **/ato** is run.<br />**Note:** Starting in Windows 8 (and Windows Server 2012), the **/stao** option is deprecated. Use the **/act-type** option instead.<br />The parameter \<**Activation ID**\> expands **/ato** support to identify a Windows edition installed on the computer. Specifying the \<**Activation ID**\> parameter isolates the effects of the option to the edition associated with that Activation ID. Run **slmgr.vbs /dlv all** to get the Activation IDs for the installed version of Windows. If you have to support other applications, see the guidance provided by that application for further instruction.<br />KMS activation does not require elevated privileges. However, online activation does require elevation, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/dli&nbsp;\[<Activation&nbsp;ID\>&nbsp;\|&nbsp;All\] |Display license information.<br />By default, **/dli** displays the license information for the installed active Windows edition. Specifying the \<**Activation ID**\> parameter displays the license information for the specified edition that is associated with that Activation ID. Specifying **All** as the parameter displays license information for all applicable installed products.<br />This operation does not require elevated privileges. |
|\/dlv&nbsp;\[<Activation&nbsp;ID\>&nbsp;\|&nbsp;All\] |Display detailed license information.<br />By default, **/dlv** displays the license information for the installed operating system. Specifying the \<**Activation ID**\> parameter displays the license information for the specified edition associated with that Activation ID. Specifying the **All** parameter displays license information for all applicable installed products.<br />This operation does not require elevated privileges. |
|\/xpr \[\<Activation&nbsp;ID\>] |Display the activation expiration date for the product. By default, this refers to the current Windows edition and is primarily useful for KMS clients, because MAK and retail activation is perpetual.<br />Specifying the \<**Activation ID**\> parameter displays the activation expiration date of the specified edition that is associated with that Activation ID.This operation does not require elevated privileges. |

## Advanced options

|Option |Description |
| - | - |
|\/cpky |Some servicing operations require the product key to be available in the registry during Out-of-Box Experience (OOBE) operations. The **/cpky** option removes the product key from the registry to prevent this key from being stolen by malicious code.<br />For retail installations that deploy keys, best practices recommend running this option. This option is not required for MAK and KMS host keys, because this is the default behavior for those keys. This option is required only for other types of keys whose default behavior is not to clear the key from the registry.<br />This operation must be run in an elevated Command Prompt window. |
|\/ilc&nbsp;&lt;license_file&gt; |This option installs the license file specified by the required parameter. These licenses may be installed as a troubleshooting measure, to support token-based activation, or as part of a manual installation of an on-boarded application.<br />Licenses are not validated during this process: License validation is out of scope for Slmgr.vbs. Instead, validation is handled by the Software Protection Service at runtime.<br />This operation must be run from an elevated Command Prompt window, or the **Standard User Operations** registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/rilc |This option reinstalls all licenses stored in %SystemRoot%\system32\oem and %SystemRoot%\System32\spp\tokens. These are “known-good” copies that were stored during installation.<br />Any matching licenses in the Trusted Store are replaced. Any additional licenses&mdash;for example, Trusted Authority (TA) Issuance Licenses (ILs), licenses for applications&mdash;are not affected.<br />This operation must be run in an elevated Command Prompt window, or the **Standard User Operations** registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/rearm |This option resets the activation timers. The **/rearm** process is also called by **sysprep /generalize**.<br />This operation does nothing if the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\SkipRearm** registry entry is set to **1**. See [Registry Settings for Volume Activation](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn502532(v=ws.11)) for details about this registry entry.<br />This operation must be run in an elevated Command Prompt window, or the **Standard User Operations** registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/rearm-app &lt;Application&nbsp;ID&gt; |Resets the licensing status of the specified app. |
|\/rearm-sku &lt;Application&nbsp;ID&gt; |Resets the licensing status of the specified SKU. |
|\/upk&nbsp;\[&lt;Application&nbsp;ID&gt;] |This option uninstalls the product key of the current Windows edition. After a restart, the system will be in an Unlicensed state unless a new product key is installed.<br />Optionally, you can use the \<**Activation ID**\> parameter to specify a different installed product.<br />This operation must be run from an elevated Command Prompt window. |
|\/dti&nbsp;\[\<Activation&nbsp;ID\>] |Displays installation ID for offline activation. |
|\/atp &lt;Confirmation&nbsp;ID&gt; |Activate product by using user-provided confirmation ID. |

## KMS client options

|Option |Description |
| - | - |
|\/skms \<Name\[:Port]&nbsp;\|&nbsp;\:&nbsp;port\> \[\<Activation&nbsp;ID\>] |This option specifies the name and, optionally, the port of the KMS host computer to contact. Setting this value disables auto-detection of the KMS host.<br />If the KMS host uses Internet Protocol version 6 (IPv6) only, the address must be specified in the format \<hostname\>:\<port\>. IPv6 addresses contain colons (:), which the Slmgr.vbs script does not parse correctly.<br />This operation must be run in an elevated Command Prompt window. |
|\/skms-domain&nbsp;&lt;FQDN&gt; \[\<Activation&nbsp;ID\>] |Sets the specific DNS domain in which all KMS SRV records can be found. This setting has no effect if the specific single KMS host is set by using the **/skms** option. Use this option, especially in disjoint namespace environments, to force KMS to ignore the DNS suffix search list and look for KMS host records in the specified DNS domain instead. |
|\/ckms&nbsp;\[\<Activation&nbsp;ID\>] |This option removes the specified KMS host name, address, and port information from the registry and restores KMS auto-discovery behavior.<br />This operation must be run in an elevated Command Prompt window. |
|\/skhc |This option enables KMS host caching (default). After the client discovers a working KMS host, this setting prevents the Domain Name System (DNS) priority and weight from affecting further communication with the host. If the system can no longer contact the working KMS host, the client tries to discover a new host.<br />This operation must be run in an elevated Command Prompt window. |
|\/ckhc |This option disables KMS host caching. This setting instructs the client to use DNS auto-discovery each time it tries KMS activation (recommended when using priority and weight).<br />This operation must be run in an elevated Command Prompt window. |

## KMS host configuration options

|Option |Description |
| - | - |
|\/sai&nbsp;&lt;Interval&gt; |This option sets the interval in minutes for unactivated clients to try to connect to KMS. The activation interval must be between 15 minutes and 30 days, although the default value (two hours) is recommended.<br />The KMS client initially picks up this interval from registry but switches to the KMS setting after it receives the first KMS response.<br />This operation must be run in an elevated Command Prompt window. |
|\/sri &lt;Interval&gt; |This option sets the renewal interval in minutes for activated clients to try to connect to KMS. The renewal interval must be between 15 minutes and 30 days. This option is set initially on both the KMS server and client sides. The default value is 10,080 minutes (7 days).<br />The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response.<br />This operation must be run in an elevated Command Prompt window. |
|\/sprt&nbsp;&lt;Port&gt; |This option sets the port on which the KMS host listens for client activation requests. The default TCP port is 1688.<br />This operation must be run from an elevated Command Prompt window. |
|\/sdns |Enable DNS publishing by the KMS host (default).<br />This operation must be run in an elevated Command Prompt window. |
|\/cdns |Disable DNS publishing by the KMS host.<br />This operation must be run in an elevated Command Prompt window. |
|\/spri |Set the KMS priority to normal (default).<br />This operation must be run in an elevated Command Prompt window. |
|\/cpri |Set the KMS priority to low.<br />Use this option to minimize contention from KMS in a co-hosted environment. Note that this could cause KMS starvation, depending on what other applications or server roles are active. Use with care.<br />This operation must be run in an elevated Command Prompt window. |
|\/act-type \[\<Activation-Type\>] \[\<Activation&nbsp;ID\>] |This option sets a value in the registry that limits volume activation to a single type. Activation Type **1** limits activation to Active Directory only; **2** limits it to KMS activation; **3** to token-based activation. The **0** option allows any activation type and is the default value. |

## Token-based activation configuration options

|Option |Description |
| - | - |
|/lil |List the installed token-based activation issuance licenses. |
|\/ril&nbsp;&lt;ILID&gt;&nbsp;&lt;ILvID&gt; |Remove an installed token-based activation issuance license.<br />This operation must be run from an elevated Command Prompt window. |
|\/stao |Set the **Token-based Activation Only** flag, disabling automatic KMS activation.<br />This operation must be run in an elevated Command Prompt window.<br />This option was removed in Windows Server 2012 R2 and Windows 8.1. Use the **/act–type** option instead. |
|\/ctao |Clear the **Token-based Activation Only** flag (default), enabling automatic KMS activation.<br />This operation must be run in an elevated Command Prompt window.<br />This option was removed in Windows Server 2012 R2 and Windows 8.1. Use the **/act–type**</strong> option instead. |
|\/ltc |List valid token-based activation certificates that can activate installed software. |
|\/fta &lt;Certificate&nbsp;Thumbprint&gt; \[&lt;PIN&gt;] |Force token-based activation by using the identified certificate. The optional personal identification number (PIN) is provided to unlock the private key without a PIN prompt if you use certificates that are protected by hardware (for example, smart cards). |

## Active Directory-based activation configuration options

|Option |Description |
| - | - |
|\/ad-activation-online &lt;Product&nbsp;Key&gt; \[\<Activation&nbsp;Object&nbsp;name\>] |Collects Active Directory data and starts Active Directory forest activation using the credentials that the command prompt is running. Local administrator access is not required. However, Read/Write access to the activation object container in the root domain of the forest is required. |
|\/ad-activation-get-IID &lt;Product&nbsp;Key&gt; |This option starts Active Directory forest activation in phone mode. The output is the installation ID (IID) that can be used to activate the forest over the telephone if internet connectivity is not available. Upon providing the IID in the activation phone call, a CID is returned that is used to complete activation. |
|\/ad-activation-apply-cid &lt;Product&nbsp;Key&gt; &lt;Confirmation&nbsp;ID&gt; \[\<Activation&nbsp;Object&nbsp;name>] |When you use this option, enter the CID that was provided in the activation telephone call to complete activation |
|\[/name: &lt;AO_Name&gt;] |Optionally, you can append the **/name** option to any of these commands to specify a name for the activation object stored in Active Directory. The name must not exceed 40 Unicode characters. Use double quotation marks to explicitly define the name string.<br />In Windows Server 2012 R2 and Windows 8.1, you can append the name directly after **/ad-activation-online &lt;Product&nbsp;Key&gt;** and **/ad-activation-apply-cid** without having to use the **/name** option. |
|\/ao-list |Displays all of the activation objects that are available to the local computer. |
|\/del-ao &lt;AO_DN&gt;<br />\/del-ao &lt;AO_RDN&gt; |Deletes the specified activation object from the forest. |

## See also

- [Volume Activation Technical Reference](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn502529%28v%3dws.11%29)
- [Volume Activation Overview](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831612%28v%3dws.11%29)


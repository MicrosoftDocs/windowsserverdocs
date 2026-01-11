---
title: Slmgr.vbs Options for Obtaining Volume Activation Information
description: Provides a list of options available for the Slmgr.vbs script and describes usage cases.
ms.topic: best-practice
author: dknappettmsft
ms.author: daknappe
ms.date: 07/07/2025
---

# Slmgr.vbs options for obtaining volume activation information

Slmgr.vbs is a Visual Basic script included in Windows that serves as a command-line tool for managing the operating system's licensing and activation. It allows you to install and change product keys, activate Windows, and check its current activation or licensing status. It also supports tasks such as extending the activation grace period (rearming) and troubleshooting activation-related issues.

The syntax of the Slmgr.vbs script and tables in this article describe each command-line option.

```cmd
slmgr.vbs [<ComputerName> [<User> <Password>]] [<Options>]
```

> [!NOTE]
> In this article, square brackets ([ ]) enclose optional arguments, and angle brackets (&lt; &gt;) enclose placeholders. When you type these statements, omit the brackets and replace the placeholders by using corresponding values.
>
> For information about other software products that use volume activation, see the documents written for those applications.

## Using Slmgr on remote computers

To manage remote clients, use the Volume Activation Management Tool (VAMT) version 1.2 or later, or create custom WMI scripts that are aware of the differences between platforms. For more information, see [WMI Properties and Methods for Volume Activation](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn502536(v=ws.11)).

> [!IMPORTANT]
> Because of WMI changes in Windows 7 and Windows Server 2008 R2, the Slmgr.vbs script isn't intended to work across platforms. Using Slmgr.vbs to manage a Windows 7 or Windows Server 2008 R2 system from the Windows Vista operating system isn't supported. Trying to manage an older system from Windows 7 or Windows Server 2008 R2 generates a specific version mismatch error. For example, running **cscript slmgr.vbs \<vista\_machine\_name\> /dlv** produces the following output:
>
> ```
> Microsoft (R) Windows Script Host Version 5.8
> Copyright (C) Microsoft Corporation. All rights reserved.
>
> The remote machine does not support this version of SLMgr.vbs
> ```

## General Slmgr.vbs options

| Option | Description |
|-|-|
| [\<ComputerName>] | Name of a remote computer. (The default is the local computer.) |
| [\<User>] | Account that has the required privilege on the remote computer. |
| [\<Password>] | Password for the account that has the required privileges on the remote computer. |

## Global options

|Option |Description |
| - | - |
|\/ipk&nbsp;&lt;ProductKey&gt; |Tries to install a 5×5 product key. The product key provided by the parameter is confirmed valid and applicable to the installed operating system.<br><br>If it's not, an error is returned.<br><br>If the key is valid and applicable, the key is installed. If a key is already installed, it's silently replaced.<br><br>To prevent instability in the license service, the system should be restarted or the Software Protection Service should be restarted.<br><br>This operation must be run from an elevated Command Prompt window, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|/ato&nbsp;[\<Activation&nbsp;ID>] |For retail editions and volume systems that have a KMS host key or a Multiple Activation Key (MAK) installed, **/ato** prompts Windows to try online activation.<br><br>For systems that have a Generic Volume License Key (GVLK) installed, **/ato** prompts a KMS activation attempt. Systems that are set to suspend automatic KMS activation attempts (**/stao**) still try KMS activation when **/ato** is run.<br><br>**Note:** Starting in Windows 8 (and Windows Server 2012), the **/stao** option is deprecated. Use the **/act-type** option instead.<br><br>The parameter \<**Activation ID**> expands **/ato** support to identify a Windows edition installed on the computer. Specifying the \<**Activation ID**> parameter isolates the effects of the option to the edition associated with that Activation ID. Run **slmgr.vbs /dlv all** to get the activation IDs for the installed version of Windows. If you need to support other applications, see the guidance provided by the application for further instruction.<br><br>KMS activation doesn't require elevated privileges. However, online activation does require elevation, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/dli&nbsp;[<Activation&nbsp;ID>&nbsp;\|&nbsp;All] |Display license information.<br><br>By default, **/dli** displays the license information for the installed active Windows edition. Specifying the \<**Activation ID**> parameter displays the license information for the specified edition that's associated with that activation ID. Specifying **All** as the parameter displays license information for all applicable installed products.<br><br>This operation doesn't require elevated privileges. |
|\/dlv&nbsp;[<Activation&nbsp;ID>&nbsp;\|&nbsp;All] |Display detailed license information.<br><br>By default, **/dlv** displays the license information for the installed operating system. Specifying the \<**Activation ID**> parameter displays the license information for the specified edition associated with that activation ID. Specifying the **All** parameter displays license information for all applicable installed products.<br><br>This operation doesn't require elevated privileges. |
|\/xpr [\<Activation&nbsp;ID>] |Display the activation expiration date for the product. By default, the date refers to the current Windows edition and is primarily useful for KMS clients, because MAK and retail activation is perpetual.<br><br>Specifying the \<**Activation ID**> parameter displays the activation expiration date of the specified edition that's associated with that activation ID. This operation doesn't require elevated privileges. |

## Advanced options

|Option |Description |
| - | - |
|\/cpky |Some servicing operations require the product key to be available in the registry during Out of Box Experience (OOBE) operations. The **/cpky** option removes the product key from the registry to prevent this key from being stolen by malicious code.<br><br>For retail installations that deploy keys, the best practice is to run this option. This option isn't required for MAK and KMS host keys, because this is the default behavior for those keys. This option is required only for other types of keys whose default behavior isn't to clear the key from the registry.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/ilc&nbsp;&lt;license_file&gt; |This option installs the license file specified by the required parameter. These licenses might be installed as a troubleshooting measure, to support token-based activation, or as part of a manual installation of an on-boarded application.<br><br>Licenses aren't validated during this process: License validation is out of scope for Slmgr.vbs. Instead, validation is handled by the Software Protection Service at runtime.<br><br>This operation must be run from an elevated Command Prompt window, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/rilc |This option reinstalls all licenses stored in %SystemRoot%\system32\oem and %SystemRoot%\System32\spp\tokens. These are "known-good" copies that were stored during installation.<br><br>Any matching licenses in the Trusted Store are replaced. Any additional licenses&mdash;for example, Trusted Authority (TA) Issuance Licenses (ILs), licenses for applications&mdash;aren't affected.<br><br>This operation must be run in an elevated Command Prompt window, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/rearm |This option resets the activation timers. The **/rearm** process is also called by **sysprep /generalize**.<br><br>This operation does nothing if the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\SkipRearm** registry entry is set to **1**. See [Registry Settings for Volume Activation](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn502532(v=ws.11)) for details about this registry entry.<br><br>This operation must be run in an elevated Command Prompt window, or the Standard User Operations registry value must be set to allow unprivileged users extra access to the Software Protection Service. |
|\/rearm-app &lt;Application&nbsp;ID&gt; |Resets the licensing status of the specified app. |
|\/rearm-sku &lt;Activation&nbsp;ID&gt; |Resets the licensing status of the specified SKU. |
|\/upk&nbsp;[&lt;Activation&nbsp;ID&gt;] |This option uninstalls the product key of the current Windows edition. After a restart, the system will be in an Unlicensed state unless a new product key is installed.<br><br>Optionally, you can use the \<**Activation ID**> parameter to specify a different installed product.<br><br>This operation must be run from an elevated Command Prompt window. |
|\/dti&nbsp;[\<Activation&nbsp;ID>] |Displays installation ID for offline activation. |
|\/atp &lt;Confirmation&nbsp;ID&gt; |Activate product by using user-provided confirmation ID. |

## KMS client options

|Option |Description |
| - | - |
|\/skms \<Name[:Port]&nbsp;\|&nbsp;\:&nbsp;Port> [\<Activation&nbsp;ID>] |This option specifies the name and, optionally, the port of the KMS host computer to contact. Setting this value disables auto-detection of the KMS host.<br><br>If the KMS host uses Internet Protocol version 6 (IPv6) only, the address must be specified in the format \<hostname>:\<port>. IPv6 addresses contain colons (:), which the Slmgr.vbs script doesn't parse correctly.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/skms-domain&nbsp;&lt;FQDN&gt; [\<Activation&nbsp;ID>] |Sets the specific DNS domain in which all KMS SRV records can be found. This setting has no effect if the specific single KMS host is set by using the **/skms** option. Use this option, especially in disjoint namespace environments, to force KMS to ignore the DNS suffix search list and look for KMS host records in the specified DNS domain instead. |
|\/ckms&nbsp;[\<Activation&nbsp;ID>] |This option removes the specified KMS host name, address, and port information from the registry and restores KMS autodiscovery behavior.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/skhc |This option enables KMS host caching (default). After the client discovers a working KMS host, this setting prevents the Domain Name System (DNS) priority and weight from affecting further communication with the host. If the system can no longer contact the working KMS host, the client tries to discover a new host.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/ckhc |This option disables KMS host caching. This setting instructs the client to use DNS autodiscovery each time it tries KMS activation (recommended when using priority and weight).<br><br>This operation must be run in an elevated Command Prompt window. |

## KMS host configuration options

|Option |Description |
| - | - |
|\/sai&nbsp;&lt;Interval&gt; |This option sets the interval, in minutes, for unactivated clients to try to connect to KMS. The activation interval must be between 15 minutes and 30 days, although the default value (two hours) is recommended.<br><br>The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/sri &lt;Interval&gt; |This option sets the renewal interval, in minutes, for activated clients to try to connect to KMS. The renewal interval must be between 15 minutes and 30 days. This option is set initially on both the KMS server and client sides. The default value is 10,080 minutes (7 days).<br><br>The KMS client initially picks up this interval from the registry but switches to the KMS setting after it receives the first KMS response.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/sprt&nbsp;&lt;Port&gt; |This option sets the port on which the KMS host listens for client activation requests. The default TCP port is 1688.<br><br>This operation must be run from an elevated Command Prompt window. |
|\/sdns |Enable DNS publishing by the KMS host (default).<br><br>This operation must be run in an elevated Command Prompt window. |
|\/cdns |Disable DNS publishing by the KMS host.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/spri |Set the KMS priority to normal (default).<br><br>This operation must be run in an elevated Command Prompt window. |
|\/cpri |Set the KMS priority to low.<br><br>Use this option to minimize contention from KMS in a co-hosted environment, which can cause KMS starvation depending on what other applications or server roles are active. Use this option with care.<br><br>This operation must be run in an elevated Command Prompt window. |
|\/act-type [\<Activation-Type>] [\<Activation&nbsp;ID>] |This option sets a value in the registry that limits volume activation to a single type. Activation type **1** limits activation to Active Directory only. **2** limits it to KMS activation. **3** limits it to token-based activation. The **0** option allows any activation type and is the default value. |

## Token-based activation configuration options

|Option |Description |
| - | - |
|/lil |List the installed token-based activation issuance licenses. |
|\/ril&nbsp;&lt;ILID&gt;&nbsp;&lt;ILvID&gt; |Remove an installed token-based activation issuance license.<br><br>This operation must be run from an elevated Command Prompt window. |
|\/stao |Set the **Token-based Activation Only** flag, disabling automatic KMS activation.<br><br>This operation must be run in an elevated Command Prompt window.<br><br>This option was removed in Windows Server 2012 R2 and Windows 8.1. Use the **/act–type** option instead. |
|\/ctao |Clear the **Token-based Activation Only** flag (default), enabling automatic KMS activation.<br><br>This operation must be run in an elevated Command Prompt window.<br><br>This option was removed in Windows Server 2012 R2 and Windows 8.1. Use the **/act–type**</strong> option instead. |
|\/ltc |List valid token-based activation certificates that can activate installed software. |
|\/fta &lt;Certificate&nbsp;Thumbprint&gt; [&lt;PIN&gt;] |Force token-based activation by using the identified certificate. The optional personal identification number (PIN) is provided to unlock the private key without a PIN prompt if you use certificates that are protected by hardware (for example, smart cards). |

## Active Directory-based activation configuration options

|Option |Description |
| - | - |
|\/ad-activation-online &lt;Product&nbsp;Key&gt; [\<Activation&nbsp;Object&nbsp;name>] |Collects Active Directory data and starts Active Directory forest activation using the credentials that the command prompt is running. Local administrator access isn't required. However, Read/Write access to the activation object container in the root domain of the forest is required. |
|\/ad-activation-get-IID &lt;Product&nbsp;Key&gt; |This option starts Active Directory forest activation in phone mode. The output is the installation ID (IID) that can be used to activate the forest over the telephone if internet connectivity isn't available. When the IID is provided in the activation phone call, a CID is returned that's used to complete activation. |
|\/ad-activation-apply-cid &lt;Product&nbsp;Key&gt; &lt;Confirmation&nbsp;ID&gt; [\<Activation&nbsp;Object&nbsp;name>] |When you use this option, enter the CID that was provided in the activation telephone call to complete activation |
|[/name: &lt;AO_Name&gt;] |Optionally, you can append the **/name** option to any of these commands to specify a name for the activation object stored in Active Directory. The name must not exceed 40 Unicode characters. Use double quotation marks to explicitly define the name string.<br><br>In Windows Server 2012 R2 and Windows 8.1, you can append the name directly after **/ad-activation-online &lt;Product&nbsp;Key&gt;** and **/ad-activation-apply-cid** without having to use the **/name** option. |
|\/ao-list |Displays all of the activation objects that are available to the local computer. |
|\/del-ao &lt;AO_DN&gt;<br><br>\/del-ao &lt;AO_RDN&gt; |Deletes the specified activation object from the forest. |

## Related content

- [Volume Activation Technical Reference](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn502529%28v%3dws.11%29)

- [Volume Activation Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831612%28v%3dws.11%29)


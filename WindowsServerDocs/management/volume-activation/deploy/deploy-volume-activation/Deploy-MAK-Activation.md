---
title: deploy MAK Activation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0186368a-4bab-4ac0-aeba-7d7965f9e46b
---
# deploy MAK Activation
MAK activation is used for one\-time activation through Microsoft’s hosted activation services, with no renewals required. for background information about MAK activation, see the volume Activation planning Guide.

## Installing a MAK During Operating System Installation
Administrators can convert a KMS client to a MAK client during the initial installation of Windows 7 or Windows Server 2008 R2 by including a MAK in an unattended setup \(Unattend.xml\) file. The Unattend.xml file can be used with Setup.exe or Windows deployment Services. for more information, see the Unattended Windows Setup Reference help file in the Windows AIK at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=136976](http://go.microsoft.com/fwlink/?LinkId=136976). for a sample unattended installation file, see “appendix B: Sample Unattended Installation File.”Note   The MAK is stored in clear text in the Unattend.xml file. During an unattended installation, the file Unattend.xml or AutoUnattend.xml is copied to the %SystemRoot%\\Panther folder of the target computer. However, at the end of the Setup process, the Setup program replaces it with “SENSITIVE\*DatA\*deleteD.”

**Installing a MAK After Operating System Installation**

A volume edition of Windows 7 and Windows Server 2008 R2 can be configured to use MAK activation by using the Control Panel System item or by running the Slmgr.vbs script:

To install a MAK by using the System application, click the change your product key link, and then type the MAK in the change your product key for activation dialog box.

To install a MAK by using Slmgr.vbs, run the following command at a command prompt:**slmgr.vbs \/ipk <MultipleActivationKey>**

where MultipleActivationKey is the MAK.

if users install a MAK by using the UI, the MAK client attempts to activate itself over the Internet one time. if the users install a MAK key by using the Slmgr.vbs script, the MAK client does not try to activate automatically.

**Disabling Automatic Activation**

To disable automatic activation on any MAK client, set the DWOrd registry value **Manual** to 1. This value is in the registry subkey **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\Currentversion\\SoftwareProtectionPlatform\\Activation**.

**Activating MAK Clients**

The MAK client attempts to activate over the Internet at the next scheduled interval. Administrators can force immediate activation over the Internet, by telephone, or by using the volume Activation management Tool \(VAMT\).

To confirm activation, check the system tray for a notification that says, “Windows is activated.” Alternatively, type slmgr.vbs \/dli at a command prompt to view the activation status of a computer.

**Activating MAK Clients over the Internet**

A MAK client can be activated over the Internet in either of two ways:

-   Click the **Click here to activate Windows now** link in the Control Panel System item. Windows reports whether the activation was successful. if activation was unsuccessful, a wizard presents additional options.

-   Run **slmgr.vbs \/ato** at a command prompt. additional options are not presented when using slmgr.vbs.

**Activating MAK Clients Through a Proxy Server**

Activation over the Internet may be blocked if the proxy server requires user authentication. In Microsoft Internet Security and Acceleration \(ISA\) Server, this setting is called Basic Authentication. Because activation requests do not present the user's credentials to the proxy server, Microsoft recommends not using Basic Authentication with ISA Server or other proxy servers. However, if Basic Authentication or a comparable mechanism must be used on the proxy server, add the following URLs to the Proxy Authentication exclusion list:

http:\/\/go.microsoft.com\/\*

https:\/\/sls.microsoft.com\/\*

https:\/\/sls.microsoft.com:443

http:\/\/crl.microsoft.com\/pki\/crl\/products\/MicrosoftRootAuthority.crl

http:\/\/crl.microsoft.com\/pki\/crl\/products\/MicrosoftproductSecureCommunications.crl

http:\/\/www.microsoft.com\/pki\/crl\/products\/MicrosoftproductSecureCommunications.crl

http:\/\/crl.microsoft.com\/pki\/crl\/products\/MicrosoftproductSecureServer.crl

http:\/\/www.microsoft.com\/pki\/crl\/products\/MicrosoftproductSecureServer.crl

**Activating MAK Clients Using the Telephone**

To activate computers that are connected to the organization’s network but do not have Internet connectivity by using Slmgr.vbs. In the Command prompt window, type:

**slmgr.vbs TargetcomputerName <Username> <Password> \/dti**

to display the information required to complete telephone activation. To obtain the telephone number for an Activation call Center in your local region, run slui.exe 4. Use the Interactive Voice Response system to obtain the confirmation ID \(CID\); then, run:

**slmgr.vbs TargetcomputerName <UserName> <Password> \/atp <CID>**

to install the CID. if activation is performed frequently or multiple computers are activated, it may be more useful to automate the process using the Slmgr.vbs script.

**Activating MAK Clients Using VAMT**

VAMT allows automation of MAK deployment and activation over the network by distributing MAKs from a centralized console. VAMT queries Microsoft activation servers to get the number of remaining activations for a given MAK, then lists the activation status of all MAK\-activated systems in the environment. This count is a snapshot in time, not a real\-time count. VAMT version 3.1 is included in the Windows ADK. for more information about VAMT, see [volume Activation management Tool \(VAMT\) Technical Reference](http://technet.microsoft.com/library/hh824825.aspx), and [VAMT How\-To Topics](http://technet.microsoft.com/library/hh824887.aspx).

**Disable Automatic Activation**

Automatic activation can be disabled on any KMS client by setting the existing DWOrd value **Manual** to 1. This value is in the registry subkey **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\Currentversion\\SoftwareProtectionPlatform\\Activation**.

**Integrating MAKs with deployment Workbench**

Microsoft deployment Toolkit \(mdT\) also provides a solution for deploying MAKs. In deployment Workbench, administrators configure the MAK in task sequences, which add the MAK to the Unattend.xml file used during installation. Administrators can prepare the reference image for KMS activation, then, during deployment, mdT activates the installation by using a MAK as long as it does not detect a KMS infrastructure. mdT applies the MAK after installing the image. for more information about mdT, see the [deployment TechCenter](http://technet.microsoft.com/deployment/default.aspx).



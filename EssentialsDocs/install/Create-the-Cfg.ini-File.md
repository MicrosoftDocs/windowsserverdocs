---
title: "Create the Cfg.ini File"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 93a73556-22ef-402d-b8d4-582b74c22bcf
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Create the Cfg.ini File

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The cfg.ini file is used to automate an installation of the operating system in the following scenario:  
  
-   When testing the experience of the end user with a preinstalled image on the target computer, the Initial Configuration section is used to walk through the installation in either an attended or unattended mode. To do this, see [Create the Initial Configuration section](Create-the-Cfg.ini-File.md#BKMK_CreateInit2).  
  
##  <a name="BKMK_CreateInit2"></a> Create the Initial Configuration section  
 Use the Initial Configuration section in the cfg.ini file to walk through the installation in either an attended or unattended mode.  
  
#### To define the Initial Configuration section  
  
1.  Open the cfg.ini file in Notepad if it exists; otherwise, create a new file.  
  
2.  Add the following text to create an InitialConfiguration section.  
  
    ```  
  
    [InitialConfiguration]  
    ;Optional, display language can only be one of the installed language  
    Language=en-us  
    ;Optional, The name of a script that runs after setupComplete.cmd but before the initial configuration begins.  
    ;Optional  
    Locale=en-us  
    ;Optional  
    Country=US  
    ;Optional  
    Keyboard=0409:00000409  
    AcceptEula=true  
    ;This is only required on a server where an OEM EULA has been specified   
    ;by using the OOBE.xml file  
    AcceptOEMEula=true  
    ;Optional. Example: My Company Name  
    CompanyName=EnterCompanyName  
    ServerName=EnterServerName  
    ; Example: CONTOSO  
    NetbiosName=EnterNetbiosDomainName  
    ; Example: contoso.local  
    DNSName=EnterDNSDomain   
    ; Used to set the user name for the domain admin  
    UserName=EnterDomainAdminUserName  
    ;The password has to be strong and at least 8 characters  
    PlainTextPassword=EnterAdminPassword  
    ;. Used to set the user name for the domain standard user account. Ignored in migration mode.  
    StdUserName=EnterDomainStandardUserName  
    ;. The password for the domain standard user account has to be strong and at least 8 characters  
    StdUserPlainTextPassword=EnterStandardUserPassword  
    ;Controls the Watson and automatic update settings  
    Settings=All or Updates or None  
    WebDomainName=www.abc.com  
    TrustedCertFileName=c:\cert\a.pfx  
    TrustedCertPassword=Enteryourpassword  
    EnableVPN=true  
    EnableRWA=true  
    IPv4DNSForwarder=<IPV4Address,IPV4Address,¦>  
    IPv6DNSForwarder=<IPV6Address,IPV6Address,¦>  
    VpnIPv4StartAddress=<IPV4Address>  
    VpnIPv4EndAddress=<IPV4Address>  
    VpnBaseIPv6Address=<IPV6Address>  
    VpnIPv6PrefixLength=<number>  
    ;All these section are optional.  
     [PostOSInstall]  
    ;Optional, The name of a script that runs after setupComplete.cmd but before the initial configuration begins.  
  
    IsHosted=true  
    StaticIPv4Address=<IPV4Address>  
    StaticIPv4Gateway=<IPV4Address>  
    StaticIPv4SubnetMask=<IPV4SubnetMask>   
    StaticIPv6Address=<IPV6Address>  
    StaticIPv6SubnetPrefixLength=<number>  
    StaticIPv6Gateway=<IPV6Address>  
    ClientBackupOn=true  
    FileHistoryOn=true  
    LaunchPadHiddenTasks=<Microsoft.LaunchPad.AdminDashboard,Microsoft.LaunchPad.Backup>  
  
    ```  
  
    > [!NOTE]
    >  An option to select a different language during Initial Configuration is not provided. If the system is reset, the language of the operating system will be the one that was originally installed.  
  
    |Parameter Name|Parameter Description|  
    |--------------------|---------------------------|  
    |*AcceptEula*|Indicates that the user accepts the Microsoft Software License Terms. The value can equal True or False, but the installation proceeds only if this is set to True.|  
    |*AcceptOEMEula*|(Optional) Indicates that the user accepts the partner license agreement. The value can equal True or False. This field is required only if the server was purchased from a partner that provided a separate license agreement.|  
    |*CompanyName*|(Optional) Name of the company. Your company name is used to associate your server with your company and to customize your company reports. Can be up to 254 characters long.|  
    |*Country*|(Optional) String representing the desired country/region. Example: US for United States.|  
    |*ServerName*|The server name uniquely identifies the server on the network. Your server name must meet the following criteria:<br /><br /> - Can be up to 15 characters long.<br /><br /> - Can contain letters, numbers and hyphens (-).<br /><br /> - Must not start with a hyphen.<br /><br /> - Must not contain any spaces.<br /><br /> - Must not contain only numbers.<br /><br /> Example: ContosoServer.|  
    |*DNSName*|An internal domain groups the server and client computers together to share a common database of user names, passwords, and other common information. Users see this name when they log on to their computers, but it is used internal only, and it is not the same as an Internet domain name. The internal domain name must meet the same criteria that are specified for the *ServerName*.<br /><br /> Example: contoso.local.|  
    |*NetbiosName*|A NetBIOS name is used to identify resources that are running on the server. It can be up to 15 characters long. Example: Contoso.|  
    |*Language*|(Optional) Specifies the display language. It can only be one of the installed languages. Example: en-us for English as used in the United States.|  
    |*Locale*|(Optional) Specifies the time and currency format by using a *LocaleID* format. Example: en-us for currency and time displayed in English and formatted according to standards used in the United States.|  
    |*Keyboard*|The keyboard can be in the following two formats:<br /><br /> - **input language:keyboard layout.** For example 0409:00000409, where 0409 before **:** is the input language, and **00000409** is the keyboard layout. You can find the list of keyboard layout under the registry key **HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Keyboard Layouts**.<br /><br /> - **input language: the IME identifier.** Below is a full list of IME identifiers.<br /><br /> - {E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}{8F96574E-C86C-4bd6-9666-3F7327D4CBE8} Amharic Input Method<br /><br /> - {81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}{FA550B04-5AD7-411F-A5AC-CA038EC515D7}            Microsoft Pinyin - Simple Fast (Chinese Simplified)<br /><br /> - {531FDEBF-9B4C-4A43-A2AA-960E8FCDC732}{B2F9C502-1742-11D4-9790-0080C882687E}             Chinese (Traditional) - New Phonetic<br /><br /> - {531FDEBF-9B4C-4A43-A2AA-960E8FCDC732}{4BDF9F03-C7D3-11D4-B2AB-0080C882687E}          Chinese (Traditional) - ChangJie<br /><br /> - {531FDEBF-9B4C-4A43-A2AA-960E8FCDC732}{6024B45F-5C54-11D4-B921-0080C882687E}            Chinese (Traditional) - Quick<br /><br /> - {E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}{D38EFF65-AA46-4FD5-91A7-67845FB02F5B}            Chinese Traditional Array<br /><br /> - {E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}{037B2C25-480C-4D7F-B027-D6CA6B69788A}            Chinese Traditional DaYi<br /><br /> - {03B5835F-F03C-411B-9CE2-AA23E1171E36}{A76C93D9-5523-4E90-AAFA-4DB112F9AC76}            Microsoft IME (Japanese)<br /><br /> - {A028AE76-01B1-46C2-99C4-ACD9858AE02F}{B5FE1F02-D5F2-4445-9C03-C568F23C99A1}             Microsoft IME (Korean)<br /><br /> - {A1E2B86B-924A-4D43-80F6-8A820DF7190F}{B60AF051-257A-46BC-B9D3-84DAD819BAFB}         Old Hangul IME (Korean)<br /><br /> - {E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}{409C8376-007B-4357-AE8E-26316EE3FB0D}              Yi Input Method<br /><br /> - {E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}{3CAB88B7-CC3E-46A6-9765-B772AD7761FF}            Tigrinya Input Method|  
    |*Settings*|Sets the user selection for updates. Use one of the following values:<br /><br /> **- All** equals Use recommended settings.<br /><br /> **- Updates** equals Install important updates. only<br /><br /> **- None** equals Do not check for updates.|  
    |*UserName*|- The name of the new administrator account that is created during setup. Your administrator and standard user account names must meet the following criteria:<br /><br /> - Can be up to 19 characters long.<br /><br /> - Cannot contain / \  [ ] &#124; < > + = ; , ? *<br /><br /> - Must not start or end with a period.<br /><br /> - Must not contain two consecutive periods.<br /><br /> - Must not be the same as the server name or internal domain name.<br /><br /> - Must not be the same as a predefined user name such as Administrator or Guest.|  
    |*PlainTextPassword*|This is the password for the new administrator account that is created during setup.<br /><br /> - Must be at least eight characters long.<br /><br /> - Must contain at least three out of the four following categories:<br /><br /> - Upper case characters.<br /><br /> - Lower case characters.<br /><br /> - Numbers.<br /><br /> - Symbols.|  
    |*StdUserName*|The name of the new standard user account that is created during setup. See the *UserName* parameter for requirements.|  
    |*StdUserPlainTextPassword*|The password for the standard user account that is created during setup.|  
    |WebDomainName|(Optional) Configure Internet domain name of the server. This file allows you to configure the domain name similar to the method used for manual configuration in the Domain Name Setup wizard.|  
    |TrustedCertFileName|(Optional) Configure Trusted Certificate for the domain name. This allows you to put an .PFX cert, which contains the private key.|  
    |TrustedCertPassword|(Optional) The password for importing the .PFX.|  
    |EnableVPN|(Optional) Turn on VPN by default.|  
    |VpnIPv4StartAddress|(Optional) Set VPN start address.|  
    |VpnIPv4EndAddress|(Optional) Set VPN end address.|  
    |VpnBaseIPv6Address|(Optional) Set base IPV6 address for VPN.|  
    |VpnIPv6PrefixLength|(Optional) Set the length of the prefix of VPN IPv6 address.|  
    |IsHosted|(Optional) Default value is false if not specified. Set this value if you set up this in hoster environment. It will disable router configuration.|  
    |StaticIPv4Address|(Optional) Specify static IP address if you want to configure a static IP address instead of a dynamic address.|  
    |StaticIPv4Gateway|(Optional) Specify default gateway address if you want to configure a static IP address instead of a dynamic address.|  
    |StaticIPv4SubnetMask|(Optional) Specify the subnet mask if you want to configure a static IP address instead of a dynamic address.|  
    |StaticIPv6Address|(Optional) Specify default IP address if you want to configure a static IP address instead of a dynamic address.|  
    |StaticIPv6SubnetPrefixLength|(Optional) Specify default IPV6 subnet prefix length if you want to configure a static IP address instead of a dynamic address.|  
    |StaticIPv6Gateway|(Optional) Specify default gateway address if you want to configure a static IP address instead of a dynamic one.|  
    |ClientBackupOn|(Optional) Turn off Client backup by default when new clients joined the server.|  
    |FileHistoryOn|(Optional) Turn off File History backup by default when new clients running Windows 8 Consumer Preview joined the server.|  
    |EnableRWA|It will enable Remote Web Access when installing  Windows Server Essentials, but will skip router configuration. This is only supported in clean installation of the product. The default value is false.|  
    |IPv4DNSForwarder|Set IPv4 DNS Forwarder.|  
    |IPv6DNSForwarder|Set IPv6 DNS Forwarder.|  
    |LaunchPadHiddenTasks|- (Optional) You can hide Backup entry or/and Admin Dashboard entry on Launchpad.<br /><br /> - To disable dashboard: LaunchPadHiddenTasks=Microsoft.LaunchPad.AdminDashboard<br /><br /> - To disable backup: LaunchPadHiddenTasks=Microsoft.LaunchPad.Backup<br /><br /> - To disable both backup and dashboard: LaunchPadHiddenTasks=Microsoft.LaunchPad.Backup,Microsoft.LaunchPad.AdminDashboard|  
  
3.  Save the file. Make sure that you save the file as cfg.ini, not cfg.ini.txt.  
  
    > [!NOTE]
    >  You can save the file to a USB flash drive, which can be used for specific phases of the installation, or the cfg.ini file can be located at the root of any hard drive on the target server. You must ensure that the encoding for the file is set to ANSI or Unicode, UTF-8 encoding is not supported.  
  
> [!IMPORTANT]
>  The Initial Configuration section of the cfg.ini should only be used by the end user to personalize the server or for a partner to test the user experience of the server by using an unattended answer file. This section of the file is not intended to be used for creating the image.  
  
## See Also  

 [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Getting Started with the Windows Server Essentials ADK](../install/Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)


---
title: ProfileXML Overview
description: This section provides a brief overview of the technologies of Always On VPN and links to additional documentation.
ms.prod: windows-server-threshold
ms.technology: networking, remote access, vpn
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: brianlic
ms.author: pashort
author: shortpatti
ms.date: 2/24/2018
---

# ProfileXML Overview

ProfileXML is a URI node within the VPNv2 CSP. Rather than configuring each VPNv2 CSP node individually—such as triggers, route lists, and authentication protocols—use this node to configure a Windows 10 VPN client by delivering all the settings as a single XML block to a single CSP node. The ProfileXML schema matches the schema of the VPNv2 CSP nodes almost identically, but some terms are slightly different.

You use ProfileXML in all the delivery methods this guide describes, including Windows PowerShell, System Center Configuration Manager, and Intune. There are two ways to configure the ProfileXML VPNv2 CSP node in this guide:

- **OMA-DM**. One way is to use an MDM provider capable of using OMA-DM, as discussed earlier in the section “VPNv2 CSP nodes.” Using this method, you can easily insert the VPN profile configuration XML markup into the ProfileXML CSP node. This is the method you’ll use to configure the Remote Access Always On VPN client by using Intune.

- **Windows Management Instrumentation (WMI)-to-CSP bridge**. The second method of configuring the ProfileXML CSP node is to use the WMI-to-CSP bridge—a WMI class called **MDM_VPNv2_01**—that can access the VPNv2 CSP and therefore the ProfileXML node. When you create a new instance of that WMI  class, WMI uses the CSP to create the VPN profile. This is the method you use to configure the Remote Access Always On VPN client by using Windows PowerShell and System Center Configuration Manager.

Even though these configuration methods differ, both require a properly formatted XML VPN profile. To use the ProfileXML VPNv2 CSP setting, you construct XML by using the ProfileXML schema to configure the tags necessary for the simple deployment scenario. For more details, see [ProfileXML XSD](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/vpnv2-profile-xsd).

In the section “Infrastructure requirements,” Table 1 provided an overview of the individual settings for the VPN client. Below is each of those required settings and its corresponding ProfileXML tag. You configure each setting in a specific tag within the ProfileXML schema, and not all of them are found under the native profile. For additional tag placement, see the ProfileXML schema.

**Connection type:** Native IKEv2

ProfileXML element:

    <NativeProtocolType>IKEv2</NativeProtocolType>

**Routing:** Split tunneling

ProfileXML element:

    <RoutingPolicyType>SplitTunnel</RoutingPolicyType>

**Name resolution:** Domain Name Information List and DNS suffix

ProfileXML elements:

    <DomainNameInformation>
    <DomainName>.corp.contoso.com</DomainName>
    <DnsServers>10.10.1.10,10.10.1.50</DnsServers>
    </DomainNameInformation>
    
    <DnsSuffix>corp.contoso.com</DnsSuffix>


**Triggering:** Always On and Trusted Network Detection

ProfileXML elements:

    <AlwaysOn>true</AlwaysOn>
    <TrustedNetworkDetection>corp.contoso.com</TrustedNetworkDetection>


**Authentication:** PEAP-TLS with TPM-protected user certificates

ProfileXML elements:

    <Authentication>
    <UserMethod>Eap</UserMethod>
    <Eap>
    <Configuration>...</Configuration>
    </Eap>
    </Authentication>

You can use simple tags to configure some VPN authentication mechanisms. However, EAP and PEAP are more involved. The easiest way to create the XML markup is to configure a VPN client with its EAP settings, and then export that configuration to XML. 

For more information about EAP settings, see [EAP configuration](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/eap-configuration). 

# MakeProfile.ps1 

This section explains the example code that you can use to gain an understanding
of how to create a VPN Profile, specifically for configuring ProfileXML in the
VPNv2 CSP.

After you assemble a script from this example code and run the script, the
script generates two files: VPN_Profile.xml and VPN_Profile.ps1. Use
VPN_Profile.xml to configure ProfileXML in OMA-DM compliant MDM services, such
as Microsoft Intune.

You can use the script VPN_Profile.ps1 to configure ProfileXML by using Windows
PowerShell on the Windows 10 desktop or in System Center Configuration Manager.

>[!NOTE] 
>To view the full example script, see the section [MakeProfile.ps1 Full Script](#makeprofile-full-script).

## Parameters

You must configure the following parameters.

**\$Template**. The name of the template from which to retrieve the EAP
configuration.

**\$ProfileName**. Unique alpha numeric identifier for the profile. The profile
name must not include a forward slash (/). If the profile name has a space or
other non-alphanumeric character, it must be properly escaped according to the
URL encoding standard.

**\$Servers**. Public or routable IP address or DNS name for the VPN gateway. It
can point to the external IP of a gateway or a virtual IP for a server farm.
Examples, 208.147.66.130 or vpn.contoso.com.

**\$DnsSuffix**. Specifies one or more comma separated DNS suffixes. The first
in the list is also used as the primary connection specific DNS suffix for the
VPN Interface. The entire list will also be added into the SuffixSearchList.

**\$DomainName**. Used to indicate the namespace to which the policy applies.
When a Name query is issued, the DNS client compares the name in the query to
all of the namespaces under DomainNameInformationList to find a match. This
parameter can be one of the following types:

-   FQDN - Fully qualified domain name

-   Suffix - A domain suffix that will be appended to the shortname query for
    DNS resolution. To specify a suffix, prepend a . to the DNS suffix.

**\$DNSServers**. List of comma separated DNS Server IP addresses to use for the
namespace.

**\$TrustedNetwork**. Comma separated string to identify the trusted network.
VPN will not connect automatically when the user is on their corporate wireless
network where protected resources are directly accessible to the device.

Following are example values for parameters used in the commands below. Ensure
that you change these values for your environment.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$TemplateName = 'Template'
$ProfileName = 'Contoso AlwaysOn VPN'
$Servers = 'vpn.contoso.com'
$DnsSuffix = 'corp.contoso.com'
$DomainName = '.corp.contoso.com'
$DNSServers = '10.10.0.2,10.10.0.3'
$TrustedNetwork = 'corp.contoso.com'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## <a name="makeprofile-full-script"></a>MakeProfile.ps1 Full Script


Most examples use the Set-WmiInstance Windows PowerShell cmdlet to insert
ProfileXML into a new instance of the MDM_VPNv2_01 WMI class.

However, this will not work in System Center Configuration Manager because you
cannot run the package in the end users’ context. Therefore, this script uses
the Common Information Model to create a WMI session in the user’s context, and
then it creates a new instance of the MDM_VPNv2_01 WMI class in that session.
This WMI class uses the WMI-to-CSP bridge to configure the VPNv2 CSP. Therefore,
by adding the class instance, you configure the CSP.

>[!NOTE] 
>The script VPN_Profile.ps1 uses the current user’s SID to identify the user’s context. Because no SID is available in a Remote Desktop session, the script will not work in a Remote Desktop session. Likewise, it will not work in a Hyper-V enhanced session. If you’re testing a Remote Access Always On VPN in virtual machines, disable enhanced session on your client VMs before running this script.

The following example script includes all of the code examples from previous
sections. Ensure that you change example values to values that are appropriate
for your environment.

```
$TemplateName = 'Template'
$ProfileName = 'Contoso AlwaysOn VPN'
$Servers = 'vpn.contoso.com'
$DnsSuffix = 'corp.contoso.com'
$DomainName = '.corp.contoso.com'
$DNSServers = '10.10.0.2,10.10.0.3'
$TrustedNetwork = 'corp.contoso.com'


$Connection = Get-VpnConnection -Name $TemplateName
if(!$Connection)
{
$Message = "Unable to get $TemplateName connection profile: $_"
Write-Host "$Message"
exit
}
$EAPSettings= $Connection.EapConfigXmlStream.InnerXml

$ProfileXML =
'<VPNProfile>
  <DnsSuffix>' + $DnsSuffix + '</DnsSuffix>
  <NativeProfile>
<Servers>' + $Servers + '</Servers>
<NativeProtocolType>IKEv2</NativeProtocolType>
<Authentication>
  <UserMethod>Eap</UserMethod>
  <Eap>
   <Configuration>
 '+ $EAPSettings + '
   </Configuration>
  </Eap>
</Authentication>
<RoutingPolicyType>SplitTunnel</RoutingPolicyType>
  </NativeProfile>
<AlwaysOn>true</AlwaysOn>
<RememberCredentials>true</RememberCredentials>
<TrustedNetworkDetection>' + $TrustedNetwork + '</TrustedNetworkDetection>
  <DomainNameInformation>
<DomainName>' + $DomainName + '</DomainName>
<DnsServers>' + $DNSServers + '</DnsServers>
</DomainNameInformation>
</VPNProfile>'

$ProfileXML | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.xml')

$Script = '$ProfileName = ''' + $ProfileName + '''
$ProfileNameEscaped = $ProfileName -replace '' '', ''%20''

$ProfileXML = ''' + $ProfileXML + '''

$ProfileXML = $ProfileXML -replace ''<'', ''&lt;''
$ProfileXML = $ProfileXML -replace ''>'', ''&gt;''
$ProfileXML = $ProfileXML -replace ''"'', ''&quot;''

$nodeCSPURI = ''./Vendor/MSFT/VPNv2''
$namespaceName = ''root\cimv2\mdm\dmmap''
$className = ''MDM_VPNv2_01''

try
{
$username = Gwmi -Class Win32_ComputerSystem | select username
$objuser = New-Object System.Security.Principal.NTAccount($username.username)
$sid = $objuser.Translate([System.Security.Principal.SecurityIdentifier])
$SidValue = $sid.Value
$Message = "User SID is $SidValue."
Write-Host "$Message"
}
catch [Exception]
{
$Message = "Unable to get user SID. User may be logged on over Remote Desktop: $_"
Write-Host "$Message"
exit
}

$session = New-CimSession
$options = New-Object Microsoft.Management.Infrastructure.Options.CimOperationOptions
$options.SetCustomOption(''PolicyPlatformContext_PrincipalContext_Type'', ''PolicyPlatform_UserContext'', $false)
$options.SetCustomOption(''PolicyPlatformContext_PrincipalContext_Id'', "$SidValue", $false)

    try
{
    $deleteInstances = $session.EnumerateInstances($namespaceName, $className, $options)
    foreach ($deleteInstance in $deleteInstances)
    {
        $InstanceId = $deleteInstance.InstanceID
        if ("$InstanceId" -eq "$ProfileNameEscaped")
        {
            $session.DeleteInstance($namespaceName, $deleteInstance, $options)
            $Message = "Removed $ProfileName profile $InstanceId"
            Write-Host "$Message"
        } else {
            $Message = "Ignoring existing VPN profile $InstanceId"
            Write-Host "$Message"
        }
    }
}
catch [Exception]
{
    $Message = "Unable to remove existing outdated instance(s) of $ProfileName profile: $_"
    Write-Host "$Message"
    exit
}

try
{
    $newInstance = New-Object Microsoft.Management.Infrastructure.CimInstance $className, $namespaceName
    $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ParentID", "$nodeCSPURI", ''String'', ''Key'')
    $newInstance.CimInstanceProperties.Add($property)
    $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("InstanceID", "$ProfileNameEscaped", ''String'', ''Key'')
    $newInstance.CimInstanceProperties.Add($property)
    $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ProfileXML", "$ProfileXML", ''String'', ''Property'')
    $newInstance.CimInstanceProperties.Add($property)
    $session.CreateInstance($namespaceName, $newInstance, $options)
    $Message = "Created $ProfileName profile."

    Write-Host "$Message"
}
catch [Exception]
{
    $Message = "Unable to create $ProfileName profile: $_"
    Write-Host "$Message"
    exit
}

$Message = "Script Complete"
Write-Host "$Message"'

$Script | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.ps1')

$Message = "Successfully created VPN_Profile.xml and VPN_Profile.ps1 on the desktop."
Write-Host "$Message"

```
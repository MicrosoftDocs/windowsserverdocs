---
title: Configure Windows 10 Client Always On VPN Connections
description: In this step, you learn about the ProfileXML options and schema, and configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.date: 05/29/2018
ms.assetid: d165822d-b65c-40a2-b440-af495ad22f42
ms.localizationpriority: medium 
ms.author: pashort
author: shortpatti
ms.reviewer: deverette
---
# Step 6. Configure Windows 10 client Always On VPN connections

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Step 5. Configure DNS and Firewall Settings](vpn-deploy-dns-firewall.md)<br>
- [**Next:** Step 7. (Optional) Conditional access for VPN connectivity using Azure AD](../../ad-ca-vpn-connectivity-windows10.md)

In this step, you'll learn about the ProfileXML options and schema, and configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection.

You can configure the Always On VPN client through PowerShell, SCCM, or Intune. All three require an XML VPN profile to configure the appropriate VPN settings. Automating PowerShell enrollment for organizations without SCCM or Intune is possible.

>[!NOTE]
>Group Policy does not include administrative templates to configure the Windows 10 Remote Access Always On VPN client.  However, you can use logon scripts.

## ProfileXML overview

ProfileXML is a URI node within the VPNv2 CSP. Rather than configuring each VPNv2 CSP node individually—such as triggers, route lists, and authentication protocols—use this node to configure a Windows 10 VPN client by delivering all the settings as a single XML block to a single CSP node. The ProfileXML schema matches the schema of the VPNv2 CSP nodes almost identically, but some terms are slightly different.

You use ProfileXML in all the delivery methods this deployment describes, including Windows PowerShell, System Center Configuration Manager, and Intune. There are two ways to configure the ProfileXML VPNv2 CSP node in this deployment:

- **OMA-DM**. One way is to use an MDM provider using OMA-DM, as discussed earlier in the section [VPNv2 CSP nodes](../always-on-vpn-technology-overview.md#vpnv2-csp-nodes). Using this method, you can easily insert the VPN profile configuration XML markup into the ProfileXML CSP node when using Intune.

- **Windows Management Instrumentation (WMI)-to-CSP bridge**. The second method of configuring the ProfileXML CSP node is to use the WMI-to-CSP bridge—a WMI class called **MDM_VPNv2_01**—that can access the VPNv2 CSP and the ProfileXML node. When you create a new instance of that WMI  class, WMI uses the CSP to create the VPN profile when using Windows PowerShell and System Center Configuration Manager.

Even though these configuration methods differ, both require a properly formatted XML VPN profile. To use the ProfileXML VPNv2 CSP setting, you construct XML by using the ProfileXML schema to configure the tags necessary for the simple deployment scenario. For more information, see [ProfileXML XSD](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/vpnv2-profile-xsd).

Below you find each of the required settings and its corresponding ProfileXML tag. You configure each setting in a specific tag within the ProfileXML schema, and not all of them are found under the native profile. For additional tag placement, see the ProfileXML schema.

[!INCLUDE [important-lower-case-true-include](../../../includes/important-lower-case-true-include.md)]

**Connection type:** Native IKEv2

ProfileXML element:

```xml
<NativeProtocolType>IKEv2</NativeProtocolType>
```

**Routing:** Split tunneling

ProfileXML element:

```xml
<RoutingPolicyType>SplitTunnel</RoutingPolicyType>
```

**Name resolution:** Domain Name Information List and DNS suffix

ProfileXML elements:

```xml
<DomainNameInformation>
<DomainName>.corp.contoso.com</DomainName>
<DnsServers>10.10.1.10,10.10.1.50</DnsServers>
</DomainNameInformation>

<DnsSuffix>corp.contoso.com</DnsSuffix>
```

**Triggering:** Always On and Trusted Network Detection

ProfileXML elements:

```xml
<AlwaysOn>true</AlwaysOn>
<TrustedNetworkDetection>corp.contoso.com</TrustedNetworkDetection>
```

**Authentication:** PEAP-TLS with TPM-protected user certificates

ProfileXML elements:

```xml
<Authentication>
<UserMethod>Eap</UserMethod>
<Eap>
<Configuration>...</Configuration>
</Eap>
</Authentication>
```

You can use simple tags to configure some VPN authentication mechanisms. However, EAP and PEAP are more involved. The easiest way to create the XML markup is to configure a VPN client with its EAP settings, and then export that configuration to XML.

For more information about EAP settings, see [EAP configuration](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/eap-configuration).

## Manually create a template connection profile

In this step, you use Protected Extensible Authentication Protocol (PEAP) to secure communication between the client and the server. Unlike a simple user name and password, this connection requires a unique EAPConfiguration section in the VPN profile to work.

Instead of describing how to create the XML markup from scratch, you use Settings in Windows to create a template VPN profile. After creating the template VPN profile, you use Windows PowerShell to consume the EAPConfiguration portion from that template to create the final ProfileXML that you deploy later in the deployment.

### Record NPS certificate settings

Before creating the template, take note the hostname or fully qualified domain name (FQDN) of the NPS server from the server’s certificate and the name of the CA that issued the certificate.

**Procedure:**

1. On your NPS server, open Network Policy Server.

2. In the NPS console, under Policies, click **Network Policies**.

3. Right-click **Virtual Private Network (VPN) Connections**, and click **Properties**.

4. Click the **Constraints** tab, and click **Authentication Methods**.

5. In EAP Types, click **Microsoft: Protected EAP (PEAP)**, and click **Edit**.

6. Record the values for **Certificate issued to** and **Issuer**.

    You use these values in the upcoming VPN template configuration. For example, if the server’s FQDN is nps01.corp.contoso.com and the hostname is NPS01, the certificate name is based upon the FQDN or DNS name of the server—for example, nps01.corp.contoso.com.

7. Cancel the Edit Protected EAP Properties dialog box.

8. Cancel the Virtual Private Network (VPN) Connections Properties dialog box.

9. Close Network Policy Server.

>[!NOTE]
>If you have multiple NPS servers, complete these steps on each one so that the VPN profile can verify each of them should they be used.

### Configure the template VPN profile on a domain-joined client computer

Now that you have the necessary information configure the template VPN profile on a domain-joined client computer. The type of user account you use (that is, standard user or administrator) for this part of the process does not matter.

However, if you haven’t restarted the computer since configuring certificate autoenrollment, do so before configuring the template VPN connection to ensure you have a usable certificate enrolled on it.

>[!NOTE]
>There is no way to manually add any advanced properties of VPN, such as NRPT rules, Always On, Trusted network detection, etc. In the next step, you create a test VPN connection to verify the configuration of the VPN server and that you can establish a VPN connection to the server.

**Manually create a single test VPN connection**

1.  Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2.  On the Start menu, type **VPN**, and press Enter.

3.  In the details pane, click **Add a VPN connection**.

4.  In the VPN Provider list, click **Windows (built-in)**.

5.  In Connection Name, type **Template**.

6.  In Server name or address, type the **external** FQDN of your VPN server (for example, **vpn.contoso.com**).

7.  Click **Save**.

8.  Under Related Settings, click **Change adapter options**.

9.  Right-click **Template**, and click **Properties**.

10. On the **Security** tab, in **Type of VPN**, click **IKEv2**.

11. In Data encryption, click **Maximum strength encryption**.

12. Click **Use Extensible Authentication Protocol (EAP)**; then, in **Use Extensible Authentication Protocol (EAP)**, click **Microsoft: Protected EAP (PEAP) (encryption enabled)**.

13. Click **Properties** to open the Protected EAP Properties dialog box, and complete the following steps:

    a. In the **Connect to these servers** box, type the name of the NPS server that you retrieved from the NPS server authentication settings earlier in this section (for example, NPS01).

    >[!NOTE]
    >The server name you type must match the name in the certificate. You recovered this name earlier in this section. If the name does not match, the connection will fail, stating that “The connection was prevented because of a policy configured on your RAS/VPN server.”

    b.  Under Trusted Root Certification Authorities, select the root CA that issued the NPS server’s certificate (for example, contoso-CA).

    c.  In Notifications before connecting, click **Don’t ask user to authorize new servers or trusted CAs**.

    d.  In Select Authentication Method, click **Smart Card or other certificate**, and click **Configure**. The Smart Card or other Certificate Properties dialog opens.

    e.  Click **Use a certificate on this computer**.

    f.  In the Connect to these servers box, enter the name of the NPS server you retrieved from the NPS server authentication settings in the previous steps.

    g.  Under Trusted Root Certification Authorities, select the root CA that issued the NPS server’s certificate.

    h.  Select the **Don’t prompt user to authorize new servers or trusted certification authorities** check box.

    i.  Click **OK** to close the Smart Card or other Certificate Properties dialog box.

    j.  Click **OK** to close the Protected EAP Properties dialog box.

14. Click **OK** to close the Template Properties dialog box.

15. Close the Network Connections window.

16. In Settings, test the VPN by clicking **Template**, and clicking **Connect**.

>[!IMPORTANT]
>Make sure that the template VPN connection to your VPN server is successful. Doing so ensures that the EAP settings are correct before you use them in the next example. You must connect at least once before continuing; otherwise, the profile will not contain all the information necessary to connect to the VPN.

## Create the ProfileXML configuration files

Before completing this section, make sure you have created and tested the template VPN connection that the section [Manually create a template connection profile](#manually-create-a-template-connection-profile) describes. Testing the VPN connection is necessary to ensure that the profile contains all the information required to connect to the VPN.

The Windows PowerShell script in Listing 1 creates two files on the desktop, both of which contain **EAPConfiguration** tags based on the template connection profile you created previously:

- **VPN_Profile.xml.** This file contains the XML markup required to configure the ProfileXML node in the VPNv2 CSP. Use this file with OMA-DM–compatible MDM services, such as Intune.

- **VPN_Profile.ps1.** This file is a Windows PowerShell script that you can run on client computers to configure the ProfileXML node in the VPNv2 CSP. You can also configure the CSP by deploying this script through System Center Configuration Manager. You cannot run this script in a Remote Desktop session, including a Hyper-V enhanced session.

>[!IMPORTANT]
>The example commands below require Windows 10 Build 1607 or later.

**Create VPN_Profile.xml and VPN_Proflie.ps1**

1. Sign in to the domain-joined client computer containing the template VPN profile with the same user account that the section [Manually create a template connection profile](#manually-create-a-template-connection-profile) described.

2. Paste Listing 1 into Windows PowerShell integrated scripting environment (ISE), and customize the parameters described in the comments. These are $Template, $ProfileName, $Servers, $DnsSuffix, $DomainName, $TrustedNetwork, and $DNSServers. A full description of each setting is in the comments.

3. Run the script to generate **VPN_Profile.xml** and **VPN_Profile.ps1** on the desktop.

#### Listing 1. Understanding MakeProfile.ps1

This section explains the example code that you can use to gain an understanding of how to create a VPN Profile, specifically for configuring ProfileXML in the VPNv2 CSP.

After you assemble a script from this example code and run the script, the script generates two files: VPN_Profile.xml and VPN_Profile.ps1. Use VPN_Profile.xml to configure ProfileXML in OMA-DM compliant MDM services, such as Microsoft Intune.

Use the **VPN_Profile.ps1** script in Windows PowerShell or System Center Configuration Manager to configure ProfileXML on the Windows 10 desktop.

>[!NOTE]
>To view the full example script, see the section [MakeProfile.ps1 Full Script](#makeprofileps1-full-script).

#### Parameters

Configure the following parameters:

**$Template**. The name of the template from which to retrieve the EAP configuration.

**$ProfileName**. Unique alphanumeric identifier for the profile. The profile name must not include a forward slash (/). If the profile name has a space or other non-alphanumeric character, it must be properly escaped according to the URL encoding standard.

**$Servers**. Public or routable IP address or DNS name for the VPN gateway. It can point to the external IP of a gateway or a virtual IP for a server farm. Examples, 208.147.66.130 or vpn.contoso.com.

**$DnsSuffix**. Specifies one or more commas separated DNS suffixes. The first in the list
is also used as the primary connection-specific DNS suffix for the VPN Interface. The entire list will also be added into the SuffixSearchList.

**$DomainName**. Used to indicate the namespace to which the policy applies. When a Name query is issued, the DNS client compares the name in the query to all of the namespaces under DomainNameInformationList to find a match. This parameter can be one of the following types:

- FQDN - Fully qualified domain name
- Suffix - A domain suffix that will be appended to the shortname query for DNS resolution. To specify a suffix, prepend a period (.) to the DNS suffix.

**$DNSServers**. List of comma-separated DNS Server IP addresses to use for the namespace.

**$TrustedNetwork**. Comma-separated string to identify the trusted network. VPN does not connect automatically when the user is on their corporate wireless network where protected resources are directly accessible to the device.

The following are example values for parameters used in the commands below. Ensure that you change these values for your environment.

```xml
$TemplateName = 'Template'
$ProfileName = 'Contoso AlwaysOn VPN'
$Servers = 'vpn.contoso.com'
$DnsSuffix = 'corp.contoso.com'
$DomainName = '.corp.contoso.com'
$DNSServers = '10.10.0.2,10.10.0.3'
$TrustedNetwork = 'corp.contoso.com'
```

### Prepare and create the profile XML

The following example commands get EAP settings from the template profile:

```xml
$Connection = Get-VpnConnection -Name $TemplateName
if(!$Connection)
{
$Message = "Unable to get $TemplateName connection profile: $_"
Write-Host "$Message"
exit
}
$EAPSettings= $Connection.EapConfigXmlStream.InnerXml
```

### Create the profile XML

[!INCLUDE [important-lower-case-true-include](../../../includes/important-lower-case-true-include.md)]

```xml
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
```

### Output VPN_Profile.xml for Intune

You can use the following example command to save the profile XML file:

```xml
$ProfileXML | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.xml')
```

### Output VPN_Profile.ps1 for the desktop and System Center Configuration Manager

The following example code configures an AlwaysOn IKEv2 VPN Connection by using the ProfileXML node in the VPNv2 CSP.

You can use this script on the Windows 10 desktop or in System Center Configuration Manager.

### Define key VPN profile parameters

```xml
$Script = '$ProfileName = ''' + $ProfileName + ''''
$ProfileNameEscaped = $ProfileName -replace ' ', '%20'
```

## Define VPN ProfileXML

```xml
$ProfileXML = ''' + $ProfileXML + '''
```

### Escape special characters in the profile

```xml
$ProfileXML = $ProfileXML -replace '<', '&lt;'
$ProfileXML = $ProfileXML -replace '>', '&gt;'
$ProfileXML = $ProfileXML -replace '"', '&quot;'
```

### Define WMI-to-CSP Bridge properties

```xml
$nodeCSPURI = "./Vendor/MSFT/VPNv2"
$namespaceName = "root\cimv2\mdm\dmmap"
$className = "MDM_VPNv2_01"
```

### Determine user SID for VPN profile:

```xml
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
```

### Define WMI session:

```xml
$session = New-CimSession
$options = New-Object Microsoft.Management.Infrastructure.Options.CimOperationOptions
$options.SetCustomOption("PolicyPlatformContext_PrincipalContext_Type", "PolicyPlatform_UserContext", $false)
$options.SetCustomOption("PolicyPlatformContext_PrincipalContext_Id", "$SidValue", $false)
```

### Detect and delete previous VPN profile:

```xml
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
```

### Create the VPN profile:

```xml
try
{
  $newInstance = New-Object Microsoft.Management.Infrastructure.CimInstance $className, $namespaceName
  $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ParentID", "$nodeCSPURI", "String", "Key")
  $newInstance.CimInstanceProperties.Add($property)
  $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("InstanceID", "$ProfileNameEscaped", "String", "Key")
  $newInstance.CimInstanceProperties.Add($property)
  $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ProfileXML", "$ProfileXML", "String", "Property")
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
Write-Host "$Message"
```

### Save the profile XML file

```xml
$Script | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.ps1')

$Message = "Successfully created VPN_Profile.xml and VPN_Profile.ps1 on the desktop."
Write-Host "$Message"
```

## MakeProfile.ps1 Full Script

Most examples use the Set-WmiInstance Windows PowerShell cmdlet to insert ProfileXML into a new instance of the MDM_VPNv2_01 WMI class. 

However, this does not work in System Center Configuration Manager because you cannot run the package in the end users’ context. Therefore, this script uses the Common Information Model to create a WMI session in the user’s context, and then it creates a new instance of the MDM_VPNv2_01 WMI class in that session. This WMI class uses the WMI-to-CSP bridge to configure the VPNv2 CSP. Therefore, by adding the class instance, you configure the CSP. 

>[!IMPORTANT]
>WMI-to-CSP bridge requires local admin rights, by design. To deploy per user VPN profiles you should be using SCCM or MDM.

>[!NOTE]
>The script VPN_Profile.ps1 uses the current user’s SID to identify the user’s context. Because no SID is available in a Remote Desktop session, the script does not work in a Remote Desktop session. Likewise, it does not work in a Hyper-V enhanced session. If you’re testing a Remote Access Always On VPN in virtual machines, disable enhanced session on your client VMs before running this script.

The following example script includes all of the code examples from previous sections. Ensure that you change example values to values that are appropriate for your environment.
    
   ```XML
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
    $ProfileNameEscaped = $ProfileName -replace ' ', '%20'
    
    $ProfileXML = ''' + $ProfileXML + ''''
    
    $ProfileXML = $ProfileXML -replace '<', '&lt;'
    $ProfileXML = $ProfileXML -replace '>', '&gt;'
    $ProfileXML = $ProfileXML -replace '"', '&quot;'
    
    $nodeCSPURI = "./Vendor/MSFT/VPNv2"
    $namespaceName = "root\cimv2\mdm\dmmap"
    $className = "MDM_VPNv2_01"
    
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
    $options.SetCustomOption("PolicyPlatformContext_PrincipalContext_Type", "PolicyPlatform_UserContext", $false)
    $options.SetCustomOption("PolicyPlatformContext_PrincipalContext_Id", "$SidValue", $false)
    
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
    	$property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ParentID", "$nodeCSPURI", "String", "Key")
    	$newInstance.CimInstanceProperties.Add($property)
    	$property = [Microsoft.Management.Infrastructure.CimProperty]::Create("InstanceID", "$ProfileNameEscaped", "String", "Key")
    	$newInstance.CimInstanceProperties.Add($property)
    	$property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ProfileXML", "$ProfileXML", "String", "Property")
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
    Write-Host "$Message"
    
    $Script | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.ps1')
    
    $Message = "Successfully created VPN_Profile.xml and VPN_Profile.ps1 on the desktop."
    Write-Host "$Message"
   ```

## Configure the VPN client by using Windows PowerShell

To configure the VPNv2 CSP on a Windows 10 client computer, run the VPN_Profile.ps1 Windows PowerShell script that you created in the [Create the profile XML](#create-the-profile-xml) section. Open Windows PowerShell as an Administrator; otherwise, you’ll receive an error saying, _Access denied_.

After running VPN_Profile.ps1 to configure the VPN profile, you can verify at any time that it was successful by running the following command in the Windows PowerShell ISE:

```powershell
Get-WmiObject -Namespace root\cimv2\mdm\dmmap -Class MDM_VPNv2_01
```

**Successful results from the Get-WmiObject cmdlet**

```powershell
__GENUS : 2
__CLASS : MDM_VPNv2_01
__SUPERCLASS:
__DYNASTY   : MDM_VPNv2_01
__RELPATH   : MDM_VPNv2_01.InstanceID="Contoso%20AlwaysOn%20VPN",ParentID
  ="./Vendor/MSFT/VPNv2"
__PROPERTY_COUNT: 10
__DERIVATION: {}
__SERVER: WIN01
__NAMESPACE : root\cimv2\mdm\dmmap
__PATH  : \\WIN01\root\cimv2\mdm\dmmap:MDM_VPNv2_01.InstanceID="Conto
  so%20AlwaysOn%20VPN",ParentID="./Vendor/MSFT/VPNv2"
AlwaysOn: True
ByPassForLocal  :
DnsSuffix   : corp.contoso.com
EdpModeId   :
InstanceID  : Contoso%20AlwaysOn%20VPN
LockDown:
ParentID: ./Vendor/MSFT/VPNv2
ProfileXML  : <VPNProfile><RememberCredentials>true</RememberCredentials>
  <AlwaysOn>true</AlwaysOn><DnsSuffix>corp.contoso.com</DnsSu
  ffix><TrustedNetworkDetection>corp.contoso.com</TrustedNetw
  orkDetection><NativeProfile><Servers>vpn.contoso.com;vpn.co
  ntoso.com</Servers><RoutingPolicyType>SplitTunnel</RoutingP
  olicyType><NativeProtocolType>Ikev2</NativeProtocolType><Au
  thentication><UserMethod>Eap</UserMethod><MachineMethod>Eap
  </MachineMethod><Eap><Configuration><EapHostConfig xmlns="h
  ttp://www.microsoft.com/provisioning/EapHostConfig"><EapMet
  hod><Type xmlns="https://www.microsoft.com/provisioning/EapC
  ommon">25</Type><VendorId xmlns="https://www.microsoft.com/p
  rovisioning/EapCommon">0</VendorId><VendorType xmlns="http:
  //www.microsoft.com/provisioning/EapCommon">0</VendorType><
  AuthorId xmlns="https://www.microsoft.com/provisioning/EapCo
  mmon">0</AuthorId></EapMethod><Config xmlns="https://www.mic
  rosoft.com/provisioning/EapHostConfig"><Eap xmlns="https://w
  ww.microsoft.com/provisioning/BaseEapConnectionPropertiesV1
  "><Type>25</Type><EapType xmlns="https://www.microsoft.com/p
  rovisioning/MsPeapConnectionPropertiesV1"><ServerValidation
  ><DisableUserPromptForServerValidation>true</DisableUserPro
  mptForServerValidation><ServerNames>NPS</ServerNames><Trust
  edRootCA>3f 07 88 e8 ac 00 32 e4 06 3f 30 f8 db 74 25 e1
  2e 5b 84 d1 </TrustedRootCA></ServerValidation><FastReconne
  ct>true</FastReconnect><InnerEapOptional>false</InnerEapOpt
  ional><Eap xmlns="https://www.microsoft.com/provisioning/Bas
  eEapConnectionPropertiesV1"><Type>13</Type><EapType xmlns="
  https://www.microsoft.com/provisioning/EapTlsConnectionPrope
  rtiesV1"><CredentialsSource><CertificateStore><SimpleCertSe
  lection>true</SimpleCertSelection></CertificateStore></Cred
  entialsSource><ServerValidation><DisableUserPromptForServer
  Validation>true</DisableUserPromptForServerValidation><Serv
  erNames>NPS</ServerNames><TrustedRootCA>3f 07 88 e8 ac 00
  32 e4 06 3f 30 f8 db 74 25 e1 2e 5b 84 d1 </TrustedRootCA><
  /ServerValidation><DifferentUsername>false</DifferentUserna
  me><PerformServerValidation xmlns="https://www.microsoft.com
  /provisioning/EapTlsConnectionPropertiesV2">true</PerformSe
  rverValidation><AcceptServerName xmlns="https://www.microsof
  t.com/provisioning/EapTlsConnectionPropertiesV2">true</Acce
  ptServerName></EapType></Eap><EnableQuarantineChecks>false<
  /EnableQuarantineChecks><RequireCryptoBinding>false</Requir
  eCryptoBinding><PeapExtensions><PerformServerValidation xml
  ns="https://www.microsoft.com/provisioning/MsPeapConnectionP
  ropertiesV2">true</PerformServerValidation><AcceptServerNam
  e xmlns="https://www.microsoft.com/provisioning/MsPeapConnec
  tionPropertiesV2">true</AcceptServerName></PeapExtensions><
  /EapType></Eap></Config></EapHostConfig></Configuration></E
  ap></Authentication></NativeProfile><DomainNameInformation>
  <DomainName>corp.contoso.com</DomainName><DnsServers>10.10.
      0.2,10.10.0.3</DnsServers><AutoTrigger>true</AutoTrigger></
  DomainNameInformation></VPNProfile>
RememberCredentials : True
TrustedNetworkDetection : corp.contoso.com
PSComputerName  : WIN01
```

The ProfileXML configuration must be correct in structure, spelling, configuration, and sometimes letter case. If you see something different in structure to Listing 1, the ProfileXML markup likely contains an error.

If you need to troubleshoot the markup, it is easier to put it in an XML editor than to troubleshoot it in the Windows PowerShell ISE. In either case, start with the simplest version of the profile, and add components back one at a time until the issue occurs again.

## Configure the VPN client by using System Center Configuration Manager

In System Center Configuration Manager, you can deploy VPN profiles by using the ProfileXML CSP node, just like you did in Windows PowerShell. Here, you use the VPN_Profile.ps1 Windows PowerShell script that you created in the section [Create the ProfileXML configuration files](#create-the-profilexml-configuration-files).

To use System Center Configuration Manager to deploy a Remote Access Always On VPN profile to Windows 10 client computers, you must start by creating a group of machines or users to whom you deploy the profile. In this scenario, create a user group to deploy the configuration script.

### Create a user group

1.  In the Configuration Manager console, open Assets and Compliance\\User Collections.

2.  On the **Home** ribbon, in the **Create** group, click **Create User Collection**.

3.  On the General page, complete the following steps:

    a. In **Name**, type **VPN Users**.

    b. Click **Browse**, click **All Users** and click **OK**.

    c. Click **Next**.

4.  On the Membership Rules page, complete the following steps:

	a.  In **Membership rules**, click **Add Rule**, and click **Direct Rule**. In this example, you’re adding individual users to the user collection. However, you might use a query rule to add users to this collection dynamically for a larger-scale deployment.

	b.  On the **Welcome** page, click **Next**.

	c.  On the Search for Resources page, in **Value**, type the name of the user you want to add. The resource name includes the user’s domain. To include results based on a partial match, insert the **%** character at either end of your search criterion. For example, to find all users containing the string “lori,” type **%lori%**. Click **Next**.

	d.  On the Select Resources page, select the users you want to add to the group, and click **Next**.

	e.  On the Summary page, click **Next**.

	f.  On the Completion page, click **Close**.

6.  Back on the Membership Rules page of the Create User Collection Wizard, click **Next**.

7.  On the Summary page, click **Next**.

8.  On the Completion page, click **Close**.

After you create the user group to receive the VPN profile, you can create a package and program to deploy the Windows PowerShell configuration script that you created in the section [Create the ProfileXML configuration files](#create-the-profilexml-configuration-files).

### Create a package containing the ProfileXML configuration script

1.  Host the script VPN_Profile.ps1 on a network share that the site server computer account can access.

2.  In the Configuration Manager console, open **Software Library\\Application Management\\Packages**.

3.  On the **Home** ribbon, in the **Create** group, click **Create Package** to start the Create Package and Program Wizard.

4.  On the Package page, complete the following steps:

    a. In **Name**, type **Windows 10 Always On VPN Profile**.

    b. Select the **This package contains source files** check box, and click **Browse**.

    c. In the Set Source Folder dialog box, click **Browse**, select the file share containing VPN_Profile.ps1, and click **OK**.
        Make sure you select a network path, not a local path. In other words, the path should be something like *\\fileserver\\vpnscript*, not *c:\\vpnscript*.

1.  Click **Next**.

2.  On the Program Type page, click **Next**.

3.  On the Standard Program page, complete the following steps:

    a.  In **Name**, type **VPN Profile Script**.

    b.  In **Command line**, type **PowerShell.exe -ExecutionPolicy Bypass -File        "VPN_Profile.ps1"**.

    c.  In **Run mode**, click **Run with administrative rights**.

    d.  Click **Next**.

4.  On the Requirements page, complete the following steps:

    a.  Select **This program can run only on specified platforms**.

    b.  Select the **All Windows 10 (32-bit)** and **All Windows 10 (64-bit)** check boxes.

    c.  In **Estimated disk space**, type **1**.

    d.  In **Maximum allowed run time (minutes)**, type **15**.

    e.  Click **Next**.

5.  On the Summary page, click **Next**.

6.  On the Completion page, click **Close**.

With the package and program created, you need to deploy it to the **VPN Users** group.

### Deploy the ProfileXML configuration script

1.  In the Configuration Manager console, open Software Library\\Application Management\\Packages.

2.  In **Packages**, click **Windows 10 Always On VPN Profile**.

3.  On the **Programs** tab, at the bottom of the details pane, right-click **VPN Profile Script**, click **Properties**, and complete the following steps:

    a.  On the **Advanced** tab, in **When this program is assigned to a computer**, click **Once for every user who logs on**.

    b.  Click **OK**.

4.  Right-click **VPN Profile Script** and click **Deploy** to start the Deploy Software Wizard.

5.  On the General page, complete the following steps:

    a.  Beside **Collection**, click **Browse**.

    b.  In the **Collection Types** list (top left), click **User Collections**.

    c.  Click **VPN Users**, and click **OK**.

    d.  Click **Next**.

6.  On the Content page, complete the following steps:

    a.  Click **Add**, and click **Distribution Point**.

    b.  In **Available distribution points**, select the distribution points to which you want to distribute the ProfileXML configuration script, and click **OK**.

    c.  Click **Next**.

7.  On the Deployment settings page, click **Next**.

8.  On the Scheduling page, complete the following steps:

    a.  Click **New** to open the Assignment Schedule dialog box.

    b.  Click **Assign immediately after this event**, and click **OK**.

    c.  Click **Next**.

9.  On the User Experience page, complete the following steps:

    1.  Select the **Software Installation** check box.

    2.  Click **Summary**.

10. On the Summary page, click **Next**.

11. On the Completion page, click **Close**.

With the ProfileXML configuration script deployed, sign in to a Windows 10 client computer with the user account you selected when you built the user collection. Verify the configuration of the VPN client.

>[!NOTE]
>The script VPN_Profile.ps1 does not work in a Remote Desktop session. Likewise, it does not work in a Hyper-V enhanced session. If you’re testing a Remote Access Always On VPN in virtual machines, disable enhanced session on your client VMs before continuing.

### Verify the configuration of the VPN client

1.  In Control Panel, under **System\\Security**, click **Configuration Manager**. 

2.  In the Configuration Manager Properties dialog, on the **Actions** tab, complete the following steps:

    a.  Click **Machine Policy Retrieval & Evaluation Cycle**, click **Run Now**, and click **OK**.

    b.  Click **User Policy Retrieval & Evaluation Cycle**, click **Run Now**, and click **OK**.

    c.  Click **OK**.

3.  Close the Control Panel.

You should see the new VPN profile shortly.

## Configure the VPN client by using Intune

To use Intune to deploy Windows 10 Remote Access Always On VPN profiles, you can configure the ProfileXML CSP node by using the VPN profile you created in the section [Create the ProfileXML configuration files](#create-the-profilexml-configuration-files), or you can use the base EAP XML sample provided below.

>[!NOTE]
>Intune now uses Azure AD groups. If Azure AD Connect synced the VPN Users group from on-premises to Azure AD, and users are assigned to the VPN Users group, you are ready to proceed.

Create the VPN device configuration policy to configure the Windows 10 client computers for all users added to the group. Since the Intune template provides VPN parameters, only copy the \<EapHostConfig> \</EapHostConfig> portion of the VPN_ProfileXML file.

### Create the Always On VPN configuration policy

1.	Sign into the [Azure portal](https://portal.azure.com/).

2.	Go to **Intune** > **Device Configuration** > **Profiles**.

3.	Click **Create Profile** to start the Create profile Wizard.

4.	Enter a **Name** for the VPN profile and (optionally) a description.

1.   Under **Platform**, select **Windows 10 or later**, and choose **VPN** from the Profile type drop-down.

     >[!TIP]
     >If you are creating a custom VPN profileXML, see [Apply ProfileXML using Intune](https://docs.microsoft.com/windows/security/identity-protection/vpn/vpn-profile-options#apply-profilexml-using-intune) for the instructions.

2. Under the **Base VPN** tab, verify or set the following settings:

    - **Connection name:** Enter the name of the VPN connection as it appears on the client computer in the **VPN** tab under **Settings**, for example, _Contoso AutoVPN_.  
    
    - **Servers:** Add one or more VPN servers by clicking **Add.**
    
    - **Description** and **IP Address or FQDN:** Enter the description and IP Address or FQDN of the VPN server. These values must align with the Subject Name in the VPN server's authentication certificate. 
    
    - **Default server:** If this is the default VPN server, set to **True**. Doing this enables this server as the default server that devices use to establish the connection. 
    
    - **Connection type:** Set to **IKEv2**.  
    
    - **Always On:** Set to **Enable** to connect to the VPN automatically at the sign-in and stay connected until the user manually disconnects.
    
    - **Remember credentials at each logon**:  Boolean value (true or false) for caching credentials. If set to true, credentials are cached whenever possible.

3.  Copy the following XML string to a text editor:
 
    [!INCLUDE [important-lower-case-true-include](../../../includes/important-lower-case-true-include.md)]
    
    
    ```XML
    <EapHostConfig xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><EapMethod><Type xmlns="https://www.microsoft.com/provisioning/EapCommon">25</Type><VendorId xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorId><VendorType xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorType><AuthorId xmlns="https://www.microsoft.com/provisioning/EapCommon">0</AuthorId></EapMethod><Config xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>25</Type><EapType xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV1"><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><FastReconnect>true</FastReconnect><InnerEapOptional>false</InnerEapOptional><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>13</Type><EapType xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV1"><CredentialsSource><CertificateStore><SimpleCertSelection>true</SimpleCertSelection></CertificateStore></CredentialsSource><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><DifferentUsername>false</DifferentUsername><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</AcceptServerName></EapType></Eap><EnableQuarantineChecks>false</EnableQuarantineChecks><RequireCryptoBinding>false</RequireCryptoBinding><PeapExtensions><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</AcceptServerName></PeapExtensions></EapType></Eap></Config></EapHostConfig>
    ```

4.  Replace the **\<TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b<\/TrustedRootCA>** in the sample with the certificate thumbprint of your on-premises root certificate authority in both places.
  
    >[!Important]
    >Do not use the sample thumbprint in the \<TrustedRootCA>\</TrustedRootCA> section below.  The TrustedRootCA must be the certificate thumbprint of the on-premises root certificate authority that issued the server-authentication certificate for RRAS and NPS servers. **This must not be the cloud root certificate, nor the intermediate issuing CA certificate thumbprint**.

5.  Replace the **\<ServerNames>NPS.contoso.com\</ServerNames>** in the sample XML with the FQDN of the domain-joined NPS where authentication takes place. 

6.  Copy the revised XML string and paste into the **EAP Xml** box under the Base VPN tab and click **OK**.
    An Always On VPN Device Configuration policy using EAP is created in Intune.


### Sync the Always On VPN configuration policy with Intune

To test the configuration policy, sign in to a Windows 10 client computer as the user you added to the **Always On VPN Users** group, and then sync with Intune.

1.  On the Start menu, click **Settings**.

2.  In Settings, click **Accounts**, and click **Access work or school**.

3.  Click the MDM profile, and click **Info**.

4.  Click **Sync** to force an Intune policy evaluation and retrieval.

5.  Close Settings. After synchronization, you see the VPN profile available on the computer.

## Next steps

You are done deploying Always On VPN.  For other features you can configure, see the table below:

|If you want to...  |Then see...  |
|---------|---------|
|Configure Conditional Access for VPN    |[Step 7. (Optional) Configure conditional access for VPN connectivity using Azure AD](../../ad-ca-vpn-connectivity-windows10.md): In this step, you can fine-tune how authorized VPN users access your resources using [Azure Active Directory (Azure AD) conditional access](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal). With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect the VPN connections. Conditional Access is a policy-based evaluation engine that lets you create access rules for any Azure Active Directory (Azure AD) connected application.         |
|Learn more about the advanced VPN features  |[Advanced VPN Features](always-on-vpn-adv-options.md#advanced-vpn-features): This page provides guidance on how to enable VPN Traffic Filters, how to configure Automatic VPN connections using App-Triggers, and how to configure NPS to only allow VPN Connections from clients using certificates issued by Azure AD.        |

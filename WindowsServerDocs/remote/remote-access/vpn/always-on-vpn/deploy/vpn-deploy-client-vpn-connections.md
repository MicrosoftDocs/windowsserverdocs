---
title: Configure Windows 10 Client Always On VPN Connections
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: d165822d-b65c-40a2-b440-af495ad22f42
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Configure Windows 10 Client Always On VPN Connections

>Applies To: Windows Server 2016, Windows 10

After setting up the server infrastructure, you must configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection. 

You can use several technologies to configure Windows 10 VPN clients, including Windows PowerShell, System Center Configuration Manager, and Intune. 

All three require an XML VPN profile to configure the appropriate VPN settings. 

The following section describes ProfileXML options, schema, and configuration. 

The section “Create the ProfileXML configuration files” describes creation of the ProfileXML VPN profile that this guide uses.

>[!NOTE]
>Group Policy does not include administrative templates to configure the Windows 10 Remote Access Always On VPN client, however you can use logon scripts.

## ProfileXML overview

ProfileXML is a URI node within the VPNv2 CSP. Rather than configuring each VPNv2 CSP node individually—such as triggers, route lists, and authentication protocols—use this node to configure a Windows 10 VPN client by delivering all the settings as a single XML block to a single CSP node. The ProfileXML schema matches the schema of the VPNv2 CSP nodes almost identically, but some terms are slightly different.

You use ProfileXML in all the delivery methods this guide describes, including Windows PowerShell, System Center Configuration Manager, and Intune. There are two ways to configure the ProfileXML VPNv2 CSP node in this guide:

- **OMA-DM**. One way is to use an MDM provider capable of using OMA-DM, as discussed earlier in the section “VPNv2 CSP nodes.” Using this method, you can easily insert the VPN profile configuration XML markup into the ProfileXML CSP node. This is the method you’ll use to configure the Remote Access Always On VPN client by using Intune.

- **Windows Management Instrumentation (WMI)-to-CSP bridge**. The second method of configuring the ProfileXML CSP node is to use the WMI-to-CSP bridge—a WMI class called **MDM_VPNv2_01**—that can access the VPNv2 CSP and therefore the ProfileXML node. When you create a new instance of that WMI  class, WMI uses the CSP to create the VPN profile. This is the method you use to configure the Remote Access Always On VPN client by using Windows PowerShell and System Center Configuration Manager.

Even though these configuration methods differ, both require a properly formatted XML VPN profile. To use the ProfileXML VPNv2 CSP setting, you construct XML by using the ProfileXML schema to configure the tags necessary for the simple deployment scenario. For more details, see [ProfileXML XSD](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/vpnv2-profile-xsd).

In the section “Infrastructure requirements,” Table 1 provided an overview of the individual settings for the VPN client. Below is each of those required settings and its corresponding ProfileXML tag. You configure each setting in a specific tag within the ProfileXML schema, and not all of them are found under the native profile. For additional tag placement, see the ProfileXML schema.

**Connection type**: Native IKEv2

ProfileXML element:

`<NativeProtocolType>IKEv2</NativeProtocolType>`


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

## <a name="bkmk_profile"></a>Manually create a template connection profile

In this guide’s scenario, you use Protected Extensible Authentication Protocol \(PEAP\) to secure communication between the client and the server. Unlike a simple user name and password, this connection requires a unique EAPConfiguration section in the VPN profile to work. 

Rather than describing how to create the XML markup for that section from scratch, you can use the Windows user interface to create a template VPN profile, and then use Windows PowerShell to consume the EAPConfiguration portion from that template to create the final ProfileXML that you will deploy later in the guide.

### Record NPS certificate settings

Before creating the template, you first need to note a few NPS server settings. You need the host name or fully qualified domain name (FQDN) of the NPS server from the server’s certificate and the name of the CA that issued the certificate.

**To record the NPS certificate settings**

1.  On your NPS server, open Network Policy Server.

2.  In the Network Policy Server snap-in, under **Policies**, click **Network Policies**.

3.  Right-click **Virtual Private Network (VPN) Connections**, and click **Properties**.

4.  On the Virtual Private Network (VPN) Connections Properties dialog box, on the **Constraints** tab, click **Authentication Methods**.

5.  In **EAP Types**, click **Microsoft: Protected EAP (PEAP)**, and then click **Edit**.

6.  Record the values for **Certificate issued to** and **Issuer**. You will use these values in the upcoming VPN template configuration. For example, if the server’s FQDN is nps01.corp.contoso.com and the host name is NPS01, the certificate is likely issued to NPS01.

7.  Cancel the Edit Protected EAP Properties dialog box.

8.  Cancel the Virtual Private network (VPN) Connections Properties dialog box.

9.  Close Network Policy Server.

>[!NOTE]
>If you have multiple NPS servers, complete these steps on each one so that the VPN profile can verify each of them should they be used.

### Configure the template VPN profile on a domain\-joined client computer

Now that you have the necessary information, configure the template VPN profile on a domain-joined client computer. The type of user account you use \(i.e., standard user or administrator\) for this part of the process does not matter. 

However, if you haven’t restarted the computer since configuring certificate autoenrollment, do so before configuring the template VPN connection to ensure you have a usable certificate enrolled on it.

>[!NOTE]
>There is no way to manually add any advanced properties of VPN, such as NRPT rules, Always On, Trusted network detection, etc. In the next step, you create a test VPN connection to verify that the VPN server is configured correctly, and to verify that you can establish a VPN connection to the server.

**To manually create a single test VPN connection**

1.  Sign in to a domain-joined client computer as a member of the **VPN Users**
    group.

2.  On the Start menu, type **VPN**, and press Enter.

3.  In the details pane, click **Add a VPN connection**.

4.  In the **VPN Provider** list, click **Windows (built-in)**.

5.  In **Connection Name**, type **Template**.

6.  In **Server name or address**, type the **external** FQDN of your VPN server \(for example, **vpn.contoso.com**\).

7.  Click **Save**.

8.  Under **Related Settings**, click **Change adapter options**.

9.  Right-click **Template**, and click **Properties**.

10. On the **Security** tab, in **Type of VPN**, click **IKEv2**.

11. In **Data encryption**, click **Maximum strength encryption**.

12. Click **Use Extensible Authentication Protocol (EAP)**; then, in **Use Extensible Authentication Protocol (EAP)**, click **Microsoft: Protected EAP (PEAP) (encryption enabled)**.

13. Click **Properties** to open the Protected EAP Properties dialog box, and complete the following steps:

14. In the **Connect to these servers** box, type the name of the NPS server that you retrieved from the NPS server authentication settings earlier in this section (e.g., NPS01).

>[!NOTE]
>The server name you type must match the name in the certificate. You recovered this name earlier in this section. If the name does not match, the connection will fail, stating that “The connection was prevented because of a policy configured on your RAS/VPN server.”

1.  Under **Trusted Root Certification Authorities**, select the root CA that issued the NPS server’s certificate (e.g., contoso-CA).

2.  In **Notifications before connecting**, click **Don’t ask user to authorize new servers or trusted CAs**.

3.  In **Select Authentication Method**, click **Smart Card or other certificate**, and click **Configure**.

4.  On the Smart Card or other Certificate Properties dialog box, click **Use a certificate on this computer**.

5.  In the **Connect to these servers** box, type the name of the NPS server you retrieved from the NPS server authentication settings in the previous steps.

6.  Under **Trusted Root Certification Authorities**, select the root CA that issued the NPS server’s certificate.

7.  Select the **Don’t prompt user to authorize new servers or trusted certification authorities** check box.

8.  Click **OK** to close the Smart Card or other Certificate Properties dialog box.

9.  Click **OK** to close the Protected EAP Properties dialog box.

10. Click **OK** to close the Template Properties dialog box.

11. Close the Network Connections window.

12. In Settings, test the VPN by clicking **Template**, and clicking **Connect**.

>[!IMPORTANT]
>Make sure that the template VPN connection to your VPN server is successful. Doing so ensures that the EAP settings are correct before you use them in the next example. You must connect at least once before continuing; otherwise, the profile will not contain all the information necessary to connect to the VPN.

## <a name="bkmk_ProfileXML"></a>Create the ProfileXML configuration files

Before completing this section, make sure you have created and tested the template VPN connection that the section [Manually create a template connection profile](#bkmk_profile) describes. Testing the VPN connection is necessary to ensure that the profile contains all the information required to connect to the VPN.

The Windows PowerShell script in Listing 1 creates two files on the desktop, both of which contain **EAPConfiguration** tags based on the template connection profile you created previously:

-   **VPN_Profile.xml.** This file contains the XML markup required to configure the ProfileXML node in the VPNv2 CSP. Use this file with OMA-DM–compatible MDM services, such as Intune.

-   **VPN_Profile.ps1.** This file is a Windows PowerShell script that you can run on client computers to configure the ProfileXML node in the VPNv2 CSP. You can also configure the CSP by deploying this script through System Center Configuration Manager. You cannot run this script in a Remote Desktop session, including a Hyper-V enhanced session.

>[!IMPORTANT]
>The example commands below require Windows 10 Build 1607 or later.

**To create VPN_Profile.xml and VPN_Proflie.ps1**

1. Sign in to the domain-joined client computer containing the template VPN profile with the same user account that the section “Manually create a template connection profile” described.

2. Paste Listing 1 in to Windows PowerShell integrated scripting environment \(ISE\), and customize the parameters described in the comments. These are $Template, $ProfileName, $Servers, $DnsSuffix, $DomainName, $TrustedNetwork, and $DNSServers. A full description of each setting is in the comments.

3.  Run the script to generate VPN_Profile.xml and VPN_Profile.ps1 on the desktop.

### Listing 1. Understanding MakeProfile.ps1

This section explains the example code that you can use to gain an understanding of how to create a VPN Profile, specifically for configuring ProfileXML in the VPNv2 CSP.

After you assemble a script from this example code and run the script, the script generates two files: VPN_Profile.xml and VPN_Profile.ps1. Use VPN_Profile.xml to configure ProfileXML in OMA-DM compliant MDM services, such as Microsoft Intune.

You can use the script VPN_Profile.ps1 to configure ProfileXML by using Windows PowerShell on the Windows 10 desktop or in System Center Configuration Manager.

>[!NOTE]
>To view the full example script, see the section [MakeProfile.ps1 Full Script](#bkmk_fullscript).

#### Parameters

You must configure the following parameters.

**$Template**. The name of the template from which to retrieve the EAP configuration.

**$ProfileName**. Unique alpha numeric identifier for the profile. The profile name must not include a forward slash (/). If the profile name has a space or other non-alphanumeric character, it must be properly escaped according to the URL encoding standard.

**$Servers**. Public or routable IP address or DNS name for the VPN gateway. It can point to the external IP of a gateway or a virtual IP for a server farm. Examples, 208.147.66.130 or vpn.contoso.com.

**$DnsSuffix**. Specifies one or more comma separated DNS suffixes. The first in the list
is also used as the primary connection specific DNS suffix for the VPN Interface. The entire list will also be added into the SuffixSearchList.

**$DomainName**. Used to indicate the namespace to which the policy applies. When a Name query is issued, the DNS client compares the name in the query to all of the namespaces under DomainNameInformationList to find a match. This parameter can be one of the following types:

- FQDN - Fully qualified domain name
- Suffix - A domain suffix that will be appended to the shortname query for DNS resolution. To specify a suffix, prepend a . to the DNS suffix.

**$DNSServers**. List of comma separated DNS Server IP addresses to use for the namespace.

**$TrustedNetwork**. Comma separated string to identify the trusted network. VPN will not connect automatically when the user is on their corporate wireless network where protected resources are directly accessible to the device.

Following are example values for parameters used in the commands below. Ensure that you change these values for your environment.

    $TemplateName = 'Template'
    $ProfileName = 'Contoso AlwaysOn VPN'
    $Servers = 'vpn.contoso.com'
    $DnsSuffix = 'corp.contoso.com'
    $DomainName = '.corp.contoso.com'
    $DNSServers = '10.10.0.2,10.10.0.3'
    $TrustedNetwork = 'corp.contoso.com'

### Prepare and create the profile XML

The following example commands get EAP settings from the template profile.


    $Connection = Get-VpnConnection -Name $TemplateName
    if(!$Connection)
    {
    $Message = "Unable to get $TemplateName connection profile: $_"
    Write-Host "$Message"
    exit
    }
    $EAPSettings= $Connection.EapConfigXmlStream.InnerXml


### Create the profile XML

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


### Output VPN_Profile.xml for Intune

You can use the following example command to save the profile XML file.

    $ProfileXML \| Out-File -FilePath (\$env:USERPROFILE +'\\desktop\\VPN_Profile.xml')

### Output VPN_Profile.ps1 for the desktop and System Center Configuration Manager

The following example code configures an AlwaysOn IKEv2 VPN Connection by using the ProfileXML node in the VPNv2 CSP.

You can use this script on the Windows 10 desktop or in System Center Configuration Manager.

### Define key VPN profile parameters

    $ProfileName = ''' + $ProfileName + '''
    $ProfileNameEscaped = $ProfileName -replace '' '', ''%20''

##Define VPN ProfileXML

    $ProfileXML = ''' + $ProfileXML + '''
    
Escape special characters in the profile

    $ProfileXML = $ProfileXML -replace ''<'', ''&lt;''
    $ProfileXML = $ProfileXML -replace ''>'', ''&gt;''
    $ProfileXML = $ProfileXML -replace ''"'', ''&quot;''
    
Define WMI-to-CSP Bridge properties

    $nodeCSPURI = ''./Vendor/MSFT/VPNv2''
    $namespaceName = ''root\cimv2\mdm\dmmap''
    $className = ''MDM_VPNv2_01''


### Determine user SID for VPN profile:

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
    

### Define WMI session:

    $session = New-CimSession
    $options = New-Object Microsoft.Management.Infrastructure.Options.CimOperationOptions
    $options.SetCustomOption(''PolicyPlatformContext_PrincipalContext_Type'', ''PolicyPlatform_UserContext'', $false)
    $options.SetCustomOption(''PolicyPlatformContext_PrincipalContext_Id'', "$SidValue", $false)


### Detect and delete previous VPN profile:

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

### Create the VPN profile:

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

### Save the profile XML file

    $Script | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.ps1')
    
    $Message = "Successfully created VPN_Profile.xml and VPN_Profile.ps1 on the desktop."
    Write-Host "$Message"

### <a name="bkmk_fullscript"></a>MakeProfile.ps1 Full Script

Most examples use the Set-WmiInstance Windows PowerShell cmdlet to insert ProfileXML into a new instance of the MDM_VPNv2_01 WMI class. 

However, this will not work in System Center Configuration Manager because you cannot run the package in the end users’ context. Therefore, this script uses the Common Information Model to create a WMI session in the user’s context, and then it creates a new instance of the MDM_VPNv2_01 WMI class in that session. This WMI class uses the WMI-to-CSP bridge to configure the VPNv2 CSP. Therefore, by adding the class instance, you configure the CSP.

>[!NOTE]
>The script VPN_Profile.ps1 uses the current user’s SID to identify the user’s context. Because no SID is available in a Remote Desktop session, the script will not work in a Remote Desktop session. Likewise, it will not work in a Hyper-V enhanced session. If you’re testing a Remote Access Always On VPN in virtual machines, disable enhanced session on your client VMs before running this script.

The following example script includes all of the code examples from previous sections. Ensure that you change example values to values that are appropriate for your environment.

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

    $ProfileXML \| Out-File -FilePath (\$env:USERPROFILE +'\\desktop\\VPN_Profile.xml')

    $ProfileName = ''' + $ProfileName + '''
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

### Configure the VPN client by using Windows PowerShell

To configure the VPNv2 CSP on a Windows 10 client computer, run the VPN_Profile.ps1 Windows PowerShell script that you created in the section “Create the ProfileXML configuration files.” Open Windows PowerShell as an Administrator; otherwise, you’ll receive an error saying, “Access denied.”

After running VPN_Profile.ps1 to configure the VPN profile, you can verify at any time that it was successful by running the following command in the Windows PowerShell ISE:

    Get-WmiObject -Namespace root\\cimv2\\mdm\\dmmap -Class MDM_VPNv2_01

Successful results look similar to Listing 2.

Listing 2. Successful results from the Get-WmiObject cmdlet


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
      hod><Type xmlns="http://www.microsoft.com/provisioning/EapC
      ommon">25</Type><VendorId xmlns="http://www.microsoft.com/p
      rovisioning/EapCommon">0</VendorId><VendorType xmlns="http:
      //www.microsoft.com/provisioning/EapCommon">0</VendorType><
      AuthorId xmlns="http://www.microsoft.com/provisioning/EapCo
      mmon">0</AuthorId></EapMethod><Config xmlns="http://www.mic
      rosoft.com/provisioning/EapHostConfig"><Eap xmlns="http://w
      ww.microsoft.com/provisioning/BaseEapConnectionPropertiesV1
      "><Type>25</Type><EapType xmlns="http://www.microsoft.com/p
      rovisioning/MsPeapConnectionPropertiesV1"><ServerValidation
      ><DisableUserPromptForServerValidation>true</DisableUserPro
      mptForServerValidation><ServerNames>NPS</ServerNames><Trust
      edRootCA>3f 07 88 e8 ac 00 32 e4 06 3f 30 f8 db 74 25 e1
      2e 5b 84 d1 </TrustedRootCA></ServerValidation><FastReconne
      ct>true</FastReconnect><InnerEapOptional>false</InnerEapOpt
      ional><Eap xmlns="http://www.microsoft.com/provisioning/Bas
      eEapConnectionPropertiesV1"><Type>13</Type><EapType xmlns="
      http://www.microsoft.com/provisioning/EapTlsConnectionPrope
      rtiesV1"><CredentialsSource><CertificateStore><SimpleCertSe
      lection>true</SimpleCertSelection></CertificateStore></Cred
      entialsSource><ServerValidation><DisableUserPromptForServer
      Validation>true</DisableUserPromptForServerValidation><Serv
      erNames>NPS</ServerNames><TrustedRootCA>3f 07 88 e8 ac 00
      32 e4 06 3f 30 f8 db 74 25 e1 2e 5b 84 d1 </TrustedRootCA><
      /ServerValidation><DifferentUsername>false</DifferentUserna
      me><PerformServerValidation xmlns="http://www.microsoft.com
      /provisioning/EapTlsConnectionPropertiesV2">true</PerformSe
      rverValidation><AcceptServerName xmlns="http://www.microsof
      t.com/provisioning/EapTlsConnectionPropertiesV2">true</Acce
      ptServerName></EapType></Eap><EnableQuarantineChecks>false<
      /EnableQuarantineChecks><RequireCryptoBinding>false</Requir
      eCryptoBinding><PeapExtensions><PerformServerValidation xml
      ns="http://www.microsoft.com/provisioning/MsPeapConnectionP
      ropertiesV2">true</PerformServerValidation><AcceptServerNam
      e xmlns="http://www.microsoft.com/provisioning/MsPeapConnec
      tionPropertiesV2">true</AcceptServerName></PeapExtensions><
      /EapType></Eap></Config></EapHostConfig></Configuration></E
      ap></Authentication></NativeProfile><DomainNameInformation>
      <DomainName>corp.contoso.com</DomainName><DnsServers>10.10.
      0.2,10.10.0.3</DnsServers><AutoTrigger>true</AutoTrigger></
      DomainNameInformation></VPNProfile>
    RememberCredentials : True
    TrustedNetworkDetection : corp.contoso.com
    PSComputerName  : WIN01

The ProfileXML configuration must be correct in structure, spelling, configuration, and sometimes letter case. If you see something different in structure to Listing 1, the ProfileXML markup likely contains an error. 

If you need to troubleshoot the markup, it is easier to put it in an XML editor than to troubleshoot it in the Windows PowerShell ISE. In either case, start with the simplest version of the profile, and add components back one at a time until the issue occurs again.

## Configure the VPN client by using System Center Configuration Manager

In System Center Configuration Manager, you can deploy VPN profiles by using the ProfileXML CSP node, just like you did in Windows PowerShell. Here, you use the VPN_Profile.ps1 Windows PowerShell script that you created in the section [Create the ProfileXML configuration files](#bkmk_ProfileXML).

To use System Center Configuration Manager to deploy a Remote Access Always On VPN profile to Windows 10 client computers, you must start by creating a group of machines or users to whom you will deploy the profile. In this scenario, create a user group to deploy the configuration script.

**To create a user group**

1.  In the Configuration Manager console, open Assets and Compliance\\User Collections.

2.  On the **Home** ribbon, in the **Create** group, click **Create User Collection**.

3.  On the General page, complete the following steps:

    a. In **Name**, type **VPN Users**.

    b. Click **Browse**, click **All Users**, and click **OK**.

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

After you create the user group to receive the VPN profile, you can create a package and program to deploy the Windows PowerShell configuration script that you created in the section [Create the ProfileXML configuration files](#bkmk_ProfileXML).

**To create a package containing the ProfileXML configuration script**

1.  Host the script VPN_Profile.ps1 on a network share that the site server computer account can access.

2.  In the Configuration Manager console, open Software Library\\Application Management\\Packages.

3.  On the **Home** ribbon, in the **Create** group, click **Create Package** to start the Create Package and Program Wizard.

4.  On the Package page, complete the following steps:

    a. In **Name**, type **Windows 10 Always On VPN Profile**.

    b. Select the **This package contains source files** check box, and click **Browse**.

    c. In the Set Source Folder dialog box, click **Browse**, select the file share containing VPN_Profile.ps1, and click **OK**.

Make sure you select a network path, not a local path. In other words, the path should be something like *\\fileserver\\vpnscript*, not *c:\\vpnscript.*.

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

**To deploy the ProfileXML configuration script**

1.  In the Configuration Manager console, open Software Library\\Application Management\\Packages.

2.  In **Packages**, click **Windows 10 Always On VPN Profile**.

3.  On the **Programs** tab, at the bottom of the details pane, right-click **VPN Profile Script**, click **Properties**, and complete the following steps:

    a.  On the **Advanced** tab, in **When this program is assigned to a computer**, click **Once for every user who logs on**.

    b.  Click **OK**.

4.  Right-click **VPN Profile Script,** and click **Deploy** to start the Deploy Software Wizard.

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

    1.  Click **New** to open the Assignment Schedule dialog box.

    2.  Click **Assign immediately after this event**, and then click **OK**.

    3.  Click **Next**.

9.  On the User Experience page, complete the following steps:

    1.  Select the **Software Installation** check box.

    2.  Click **Summary**.

10. On the Summary page, click **Next**.

11. On the Completion page, click **Close**.

With the ProfileXML configuration script deployed, sign in to a Windows 10 client computer with the user account you selected when you built the user collection. Verify configuration of the VPN client.

>[!NOTE]
>The script VPN_Profile.ps1 will not work in a Remote Desktop session. Likewise, it will not work in a Hyper-V enhanced session. If you’re testing a Remote Access Always On VPN in virtual machines, disable enhanced session on your client VMs before continuing.

**To verify configuration of the VPN client**

1.  In Control Panel, click **Configuration Manager**. **Configuration Manager** is under **System**\\**Security**.

2.  In the Configuration Manager Properties dialog box, on the **Actions** tab, complete the following steps:

    a.  Click **Machine Policy Retrieval & Evaluation Cycle**, click **Run
        Now**, and click **OK**.

    b.  Click **User Policy Retrieval & Evaluation Cycle**, click **Run Now**,
        and click **OK**.

    c.  Click **OK**.

3.  Close Control Panel.

You should see the new VPN profile shortly.

## Configure the VPN client by using Intune

To use Intune to deploy Windows 10 Remote Access Always On VPN profiles, you can configure the ProfileXML CSP node by using the VPN profile you created in the section [Create the ProfileXML configuration files](#bkmk_ProfileXML).

In this example, you use the profile stored in VPN_Profile.xml.

>[!NOTE]
>
>- Client computers and users appear in Intune after you have configured Azure Active Directory Connect and enrolled the devices in Intune. This guide doesn’t explain how to enroll devices in Intune. For details on how to manage devices with Intune, see [Enroll your Windows 10 device in Intune](https://docs.microsoft.com/intune-user-help/enroll-your-w10-device-access-work-or-school).
>- This guide describes how to deliver certificates to domain-joined devices by using autoenrollment only. For information about using Intune to deliver certificates to devices, see [How to configure certificates in Microsoft Intune](https://docs.microsoft.com/intune/certificates-configure).

### Create a VPN Users group for managed users or devices

To deploy a Windows 10 Remote Access Always On VPN profile, start by creating a group that contains the managed users or devices that should receive the VPN profile.

**Create a group that contains the managed users or devices**

1.  Sign in to <https://manage.microsoft.com> as an Intune administrator.

2.  In the Intune Admin Console, click **GROUPS**, and click **Groups**.

3.  Click **Access your groups in the new Azure portal by clicking here**. You now manage Intune groups in the Azure Portal. For this reason, you’ll be redirected to the Azure Portal when you click the **Create Groups** link.

4.  In the Azure Portal, near the top of the page, click **New group**.

5.  In **Name**, type **VPN Users**.

6.  In **Membership type**, click **Assigned**. In this example, you’re assigning individual users to the **VPN Users** group. Alternatively, you could create a dynamic rule to include users based on a query result.

7.  Click **Members**, and complete the following steps:
	a.	In **Select**, begin typing the name of a user you want to add to the group.
	b.	In the list, select the check box next to that user’s full name.
	c.	Repeat the previous two steps for each person you want to add to the group.
	d.	Click **Select**.

2.  Click **Create** to create the group.

3.  Close the Azure Portal.

### Create the Always On VPN configuration policy

After creating the VPN Users group, create the VPN configuration policy with which to configure the Windows 10 client computers for the users you added to the group. You will copy the contents of the VPN_Profile.xml file that you created in the section “Create the ProfileXML configuration files” into the policy’s value.

**To create the Always On VPN configuration policy**

1.  In the Intune Admin Console, click **POLICY**, and click **Configuration Policies**.

2.  In the Policies workspace, click **Add** to start the Create a New Policy Wizard.

3.  On the Select a template for the new policy page, under **Windows**, click **Custom Configuration (Windows 10 Desktop and Mobile and later)**, and then click **Create Policy**. You will notice a configuration policy called VPN Profile (Windows 10 Desktop and Mobile and later). This configuration policy doesn’t provide the ability to configure the Always On setting. To configure Always On triggering, you must configure the ProfileXML node of the VPNv2 CSP by using the OMA-URI in the Custom Configuration (Windows 10 Desktop and Mobile and later) configuration policy.

4.  In **Name**, type **Contoso Always On VPN Profile**.

5.  In the **OMA-URI Settings** section, click **Add** to open the Add or edit OMA-URI Setting dialog box, and complete the following steps:

    a.  In **Setting name**, type **Windows 10 Always On VPN**.

    b.  In **Setting description**, type **ProfileXML Settings for Always On VPN**.

    c.  In **Data type**, click **String (XML)**.

    d.  In **OMA-URI**, type **./User/Vendor/MSFT/VPNv2/ContosoVPN/ProfileXML**. **ContosoVPN** is the profile name and is visible to the user in **Settings**. Change this name to the profile name you want users to see. If the name contains spaces, escape each space with %20. (e.g., Contoso VPN would be Contoso%20VPN).

	e.  Click **Browse**, and open VPN_Profile.xml, which you created in the section [Create the ProfileXML configuration files](#bkmk_ProfileXML). The following illustration depicts the completed **OMA-URI** setting for Contoso.

	![Completed OMA-URI setting](../../../../media/Always-On-Vpn/Vpn-Settings.jpg)

6.  Click **OK** to add the setting to the configuration policy.

7.  Click **Save Policy** to save the configuration policy.

8.  On the Deploy Policy dialog box, click **Yes**.

9.  Click the **VPN Users** group, click **Add**, and click **OK**.

### Sync with Intune

To test the configuration policy, sign in to a Windows 10 client computer as the user you added to the **Always On VPN Users** group, and then sync with Intune.

**To sync the Always On VPN configuration policy**

1.  On the Start menu, click **Settings**.

2.  In Settings, click **Accounts**, and click **Access work or school**.

3.  Click the MDM profile, and click **Info**.

4.  Click **Sync** to force an Intune policy evaluation and retrieval.

5.  Close Settings.

After synchronization, you should see the VPN profile available on the computer.

For the next section in this guide, see [Remote Access Always On VPN Advanced Features](always-on-vpn-adv-options.md).
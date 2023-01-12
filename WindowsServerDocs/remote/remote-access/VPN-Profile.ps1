# Define key VPN profile parameters
# Replace with your own values

$Domain = 'corp' # Name of the domain.

$TemplateName = 'Contoso VPN' # Name of the test VPN connection you created in the tutorial. 

$ProfileName = 'Contoso AlwaysOn VPN' # Name of the profile we are going to create.

$Servers = 'aov-vpn.contoso.com' #Public or routable IP address or DNS name for the VPN gateway.

$DnsSuffix = 'corp.contoso.com' # Specifies one or more commas separated DNS suffixes. 
      
$DomainName = '.corp.contoso.com' #Used to indicate the namespace to which the policy applies. Contains `.` prefix.

$DNSServers = '10.10.0.6' #List of comma-separated DNS Server IP addresses to use for the namespace.

$TrustedNetwork = 'corp.contoso.com' #Comma-separated string to identify the trusted network.


#Get the EAP settings for the current profile called $TemplateName

$Connection = Get-VpnConnection -Name $TemplateName

if(!$Connection)
{
    $Message = "Unable to get $TemplateName connection profile: $_"
    Write-Host "$Message"
    exit
}

$EAPSettings= $Connection.EapConfigXmlStream.InnerXml

$ProfileNameEscaped = $ProfileName -replace ' ', '%20'

# Define ProfileXML
$ProfileXML = @("
<VPNProfile>
  <DnsSuffix>$DnsSuffix</DnsSuffix>
  <NativeProfile>
<Servers>$Servers</Servers>
<NativeProtocolType>IKEv2</NativeProtocolType>
<Authentication>
  <UserMethod>Eap</UserMethod>
  <Eap>
    <Configuration>
    $EAPSettings
    </Configuration>
  </Eap>
</Authentication>
<RoutingPolicyType>SplitTunnel</RoutingPolicyType>
  </NativeProfile>
<AlwaysOn>true</AlwaysOn>
<RememberCredentials>true</RememberCredentials>
<TrustedNetworkDetection>$TrustedNetwork</TrustedNetworkDetection>
  <DomainNameInformation>
<DomainName>$DomainName</DomainName>
<DnsServers>$DNSServers</DnsServers>
</DomainNameInformation>
</VPNProfile>
")
    
#Output the XML for possible use in InTune
$ProfileXML | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.xml')

# Escape special characters in the profile (<,>,")
$ProfileXML = $ProfileXML -replace '<', '&lt;'
$ProfileXML = $ProfileXML -replace '>', '&gt;'
$ProfileXML = $ProfileXML -replace '"', '&quot;'
    
# Define WMI-to-CSP Bridge properties
$nodeCSPURI = "./Vendor/MSFT/VPNv2"
$namespaceName = "root\cimv2\mdm\dmmap"
$className = "MDM_VPNv2_01"
    
try
{

    # Determine user SID for VPN profile.
    $WmiLoggedOnUsers = (Get-WmiObject Win32_LoggedOnUser).Antecedent
    If($WmiLoggedOnUsers.Count -gt 1) { 
        $WmiLoggedOnUsers = $WmiLoggedOnUsers -match "Domain=""$Domain"""
    }
    
    $WmiUserValid = ($WmiLoggedOnUsers | Select-Object -Unique -First 1) -match 'Domain="([^"]+)",Name="([^"]+)"'
    
    If(-not $WmiUserValid){
        Throw "Returned object is not a valid WMI string"
    }
    
    
    $UserName = "$($Matches[1])\$($Matches[2])"
    
    $ObjUser = New-Object System.Security.Principal.NTAccount($UserName)
    $Sid = $ObjUser.Translate([System.Security.Principal.SecurityIdentifier])
    $SidValue = $Sid.Value
    $Message = "User SID is $SidValue."
    
    Write-Host "$Message"
    
}
catch [Exception] 
{

    $Message = "Unable to get user SID. $_"
    Write-Host "$Message" 
    exit
}
        
try 
{
    # Define WMI session.
    $session = New-CimSession
    $options = New-Object Microsoft.Management.Infrastructure.Options.CimOperationOptions
    $options.SetCustomOption("PolicyPlatformContext_PrincipalContext_Type", "PolicyPlatform_UserContext", $false)
    $options.SetCustomOption("PolicyPlatformContext_PrincipalContext_Id", "$SidValue", $false)

}
catch {

    $Message = "Unable to create new session for $ProfileName profile: $_"
    Write-Host $Message
    exit
}

try
{
    #Detect and delete previous VPN profile.
    $deleteInstances = $session.EnumerateInstances($namespaceName, $className, $options)
    $InstanceId = $deleteInstance.InstanceID

    foreach ($deleteInstance in $deleteInstances)
    {
        if ("$InstanceId" -eq "$ProfileNameEscaped")
        {
            $session.DeleteInstance($namespaceName, $deleteInstance, $options)
            $Message = "Removed $ProfileName profile $InstanceId" 
            Write-Host "$Message"
        }
        else 
        {
            $Message = "Ignoring existing VPN profile $InstanceId"
            Write-Host "$Message"
        }
    }
}
catch [Exception]
{
    $Message = "Unable to remove existing outdated instance(s) of $ProfileName profile: $_"
    Write-Host $Message
    exit
    
}
    
try
{
    # Create the VPN profile.
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
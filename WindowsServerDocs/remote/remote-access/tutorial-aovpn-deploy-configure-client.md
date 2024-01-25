---
title: Tutorial - Deploy Always On VPN profile for Windows clients
description:  Learn how to deploy Always On VPN profile for Windows 10+ clients.
ms.topic: article
ms.date:  03/14/2023
ms.assetid: d165822d-b65c-40a2-b440-af495ad22f42
ms.author: anaharris
author: anaharris-ms
---
# Tutorial: Deploy Always On VPN - Configure Always On VPN profile for Windows 10+ clients

- [**Previous:** 2 - Configure Certificate Authority templates](tutorial-aovpn-deploy-create-certificates.md)


>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10, Windows 11

In this last part of the tutorial, you'll learn how to use a ProfileXML PowerShell configuration script to configure Always On VPN settings and create a user tunnel for client connections.

For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).

## Prerequisites

Complete [Tutorial: Deploy Always On VPN - Configure Certificate Authority templates](tutorial-aovpn-deploy-create-certificates.md).

## Create an Always On VPN client profile

In this section, we'll create a VPN client connection in order to verify that the VPN test client can establish a successful VPN connection. This will also allow us to create the EAP settings for export in the next section.  

For more information about EAP settings, see [EAP configuration](/windows/client-management/mdm/eap-configuration).

1. Sign in to the domain-joined VPN client computer as the VPN user you created in [Create Active Directory test user](tutorial-aovpn-deploy-setup.md#create-vpn-user-and-group).

1. On the Start menu, type **VPN** to select **VPN Settings**. Press ENTER.

1. In the details pane, select **Add a VPN connection**.

1. For **VPN Provider**, select *Windows (built-in)*.

1. For **Connection Name**, enter *Contoso VPN*.

1. For **Server name or address**, enter the **external** FQDN of your VPN server (for example, *vpn.contoso.com*).

1. For **VPN type**, select *IKEv2*.

1. For **Type of sign-in info**, select *Certificate*.

1. Select **Save**.

1. Under Related Settings, select **Change adapter options**.

1. Right-click **Contoso VPN**, and select **Properties**.

1. On the **Security** tab, for **Data encryption**, select *Maximum strength encryption*.

1. Select **Use Extensible Authentication Protocol (EAP)**. Then, for **Use Extensible Authentication Protocol (EAP)**, select *Microsoft: Protected EAP (PEAP) (encryption enabled)*.

1. Select **Properties** to open Protected EAP Properties, and complete the following steps:

    1. For **Connect to these servers**, enter the name of the NPS server.

    1. For **Trusted Root Certification Authorities**, select the CA that issued the NPS server's certificate (for example, contoso-CA).

    1. For **Notifications before connecting**, select *Don't ask user to authorize new servers or trusted CAs*.

    1. For **Select Authentication Method**, select **Smart Card or other certificate**.
  
    1. Select **Configure**.

        1. Select **Use a certificate on this computer**.

        1. For **Connect to these servers**, enter the name of the NPS server.

        1. For **Trusted Root Certification Authorities**, select the CA that issued the NPS server's certificate.

        1. Select **Don't prompt user to authorize new servers or trusted certification authorities**.

        1. Select **OK** to close Smart Card or other Certificate Properties.

        1. Select **OK** to close Protected EAP Properties.

    1. Select **OK** to close Contoso VPN Properties.

1. Close the Network Connections window.

1. In Settings, select **Contoso VPN**, and then select **Connect**.

>[!IMPORTANT]
>Make sure that the template VPN connection to your VPN server is successful. Doing so ensures that the EAP settings are correct before you use them in the next step. You must connect at least once before continuing; otherwise, the profile will not contain all the information necessary to connect to the VPN.

## Configure your Windows VPN client

In this section, you'll manually configure the Windows VPN client using a PowerShell script.
  
1. Sign in as your VPN User to the VPN client computer.

1. Open Windows PowerShell integrated scripting environment (ISE) as Administrator.

1. Copy and paste the following script:
    
    ```powershell
    
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
        
    #Output the XML for possible use in Intune
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
    
        foreach ($deleteInstance in $deleteInstances)
        {
            $InstanceId = $deleteInstance.InstanceID
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
    
    ```

1. Set the value for the following variables at the top of the script: `$Domain`, `$TemplateName`, `$ProfileName`, `$Servers`, `$DnsSuffix`,  `$DomainName`, and `$DNSServers`. For more detailed information about how to set these variables, see: [VPNv2 CSP](/windows/client-management/mdm/vpnv2-csp).

1. Press ENTER to run the script.

1. Verify that the script was successful by running the following command in the Windows PowerShell ISE:

    ```powershell
        Get-CimInstance -Namespace root\cimv2\mdm\dmmap -ClassName MDM_VPNv2_01
    ```

1. You should see the following output (the ProfileXML value has been truncated for readability):

    ```powershell
    
    AlwaysOn                : True
    ByPassForLocal          : 
    DeviceTunnel            : 
    DnsSuffix               : corp.contoso.com
    EdpModeId               : 
    InstanceID              : Contoso%20AlwaysOn%20VPN
    LockDown                : 
    ParentID                : ./Vendor/MSFT/VPNv2
    ProfileXML              : <VPNProfile>...</VPNProfile>
    RegisterDNS             : 
    RememberCredentials     : True
    TrustedNetworkDetection : corp.contoso.com
    PSComputerName          : 
    `
    ```

You have now configured your user tunnel for Always On VPN. If you want to learn how to configure a device tunnel, see [Configure VPN device tunnels in Windows client](vpn/vpn-device-tunnel-config.md).

## Next steps

- To learn how to configure Always On VPN profiles with Microsoft Configuration Manager, see [Deploy Always On VPN profile to Windows clients with Microsoft Configuration Manager](how-to-aovpn-client-config-mgr.md).

- To learn how to configure Always On VPN profiles with Microsoft Intune, see [Deploy Always On VPN profile to Windows clients with Microsoft Intune](how-to-aovpn-client-intune.md).

- Learn how to [Configure conditional access for VPN connectivity using Azure AD](how-to-aovpn-conditional-access.md).

- To learn more about the advanced VPN features, see [Advanced VPN Features](vpn/always-on-vpn/deploy/always-on-vpn-adv-options.md#advanced-vpn-features).

- For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).

- To troubleshoot issues with Always On VPN, see [Troubleshoot Always On VPN](/troubleshoot/windows-server/networking/troubleshoot-always-on-vpn).

---
title: "Tutorial: Create Always On VPN Connection on Windows Client Devices"
description: Learn how to configure an Always On VPN connection for Windows client devices. Automatically connect to your VPN server without manual steps.
ms.topic: tutorial
ms.date: 05/08/2025
ms.author: daknappe
author: dknappettmsft
---

# Tutorial: Create an Always On VPN connection on Windows client devices

This tutorial shows you how to create an Always On VPN connection on Windows client devices. It continues the series to deploy Always On VPN in a sample environment. Previously in the series, you [deployed a sample infrastructure](tutorial-aovpn-deploy-setup.md) and [configured Certificate Authority templates](tutorial-aovpn-deploy-create-certificates.md).

In this tutorial, you:

> [!div class="checklist"]
>
> - Create and test a manual user VPN connection that's used as a template for the Always On VPN connection.
> - Convert the manual VPN connection to an Always On VPN connection using PowerShell.

Always On VPN connections can be configured as a device tunnel or a user tunnel:

- *Device tunnel*: connects to specified VPN servers before users signs in to the device. A device tunnel is used for pre-login connectivity scenarios and device management purposes.

- *User tunnel*: connects only after a user logs on to the device. A user tunnel allows users to access organization resources through VPN servers.

For more information about the differences between device tunnel and user tunnel, see [Configure VPN device tunnels in Windows client](vpn/vpn-device-tunnel-config.md).

Always On VPN connections, whether a device tunnel or a user tunnel, are configured using the *ProfileXML* node in the [VPNv2 configuration service provider (CSP)](/windows/client-management/mdm/vpnv2-csp). The steps in this tutorial show you how to configure a user tunnel on a single Windows client device. You can use these steps for small environments or for testing purposes.

For larger environments, you should use Microsoft Intune or Microsoft Configuration Manager to deploy the Always On VPN profile to Windows client devices. For more information, see [Deploy an Always On VPN profile to Windows clients with Microsoft Intune](how-to-aovpn-client-intune.md) and [Deploy an Always On VPN profile to Windows clients with Microsoft Configuration Manager](how-to-aovpn-client-config-mgr.md).

## Prerequisites

To complete the steps in this tutorial, you need:

- To complete all the steps in the previous tutorials:
  - [Deploy Always On VPN Infrastructure](tutorial-aovpn-deploy-setup.md).
  - [Configure Certificate Authority templates](tutorial-aovpn-deploy-create-certificates.md).

- The Windows client device from the previous tutorial with the valid user certificate installed to be used to test the VPN connection.

## Create and test a manual user VPN connection

First, you need to create a VPN client connection in order to verify that the VPN test client can establish a successful VPN connection. This connection also enables you to create the Extensible Authentication Protocol (EAP) settings to use for the Always On VPN connection. For more information about EAP settings, see [EAP configuration](/windows/client-management/mdm/eap-configuration).

1. Sign in to the domain-joined Windows client device as the VPN user you created previously in [Create Active Directory test user](tutorial-aovpn-deploy-setup.md#create-vpn-user-and-group).

1. On the Start menu, type **VPN** to select **VPN Settings**. Press ENTER.

1. In the details pane, select **Add a VPN connection**.

1. For **VPN Provider**, select **Windows (built-in)**.

1. For **Connection Name**, enter **Contoso VPN**.

1. For **Server name or address**, enter the **external** fully qualified domain name (FQDN) of your VPN server (for example, `vpn.contoso.com`).

1. For **VPN type**, select **IKEv2**.

1. For **Type of sign-in info**, select **Certificate**.

1. Select **Save**.

1. Under **Related Settings**, select **Change adapter options**.

1. Right-click **Contoso VPN**, and select **Properties**.

1. On the **Security** tab, for **Data encryption**, select **Maximum strength encryption**.

1. Select **Use Extensible Authentication Protocol (EAP)**. Then, for **Use Extensible Authentication Protocol (EAP)**, select **Microsoft: Protected EAP (PEAP) (encryption enabled)**.

1. Select **Properties** to open **Protected EAP Properties**, and complete the following steps:

   1. For **Connect to these servers**, enter the hostname of your NPS server.

   1. For **Trusted Root Certification Authorities**, select the CA that issued the NPS server's certificate (for example, `contoso-CA`).

   1. For **Notifications before connecting**, select **Don't ask user to authorize new servers or trusted CAs**.

   1. For **Select Authentication Method**, select **Smart Card or other certificate**.
  
   1. Select **Configure**.

      1. Select **Use a certificate on this computer**.

      1. For **Connect to these servers**, enter the hostname of the NPS server.

      1. For **Trusted Root Certification Authorities**, select the CA that issued the NPS server's certificate.

      1. Select **Don't prompt user to authorize new servers or trusted certification authorities**.

      1. Select **OK** to close **Smart Card or other Certificate Properties**.

      1. Select **OK** to close **Protected EAP Properties**.

   1. Select **OK** to close **Contoso VPN Properties**.

1. Close the **Network Connections** window.

1. In Settings, select **Contoso VPN**, and then select **Connect**. The VPN connection should be established successfully. You can verify the connection by checking the **Network Connections** window. The **Contoso VPN** connection should show as **Connected**. Test you can connect to a resource on the other side of the VPN tunnel, for example, a file share or web server.

1. After you verify that the VPN connection is successful, disconnect from the VPN connection.

> [!IMPORTANT]
> Make sure that the template VPN connection to your VPN server is successful. Doing so ensures that the EAP settings are correct before you use them in the next section. You must connect at least once before continuing; otherwise, the profile doesn't contain all the information necessary to connect to the VPN.

## Convert the manual VPN connection to an Always On VPN connection

Next, you convert the manual VPN connection to an Always On VPN connection using a PowerShell script.
  
1. As the same user on the Windows client device, open `Windows PowerShell ISE` as an Administrator.

1. Copy and paste the following PowerShell script into the `Windows PowerShell ISE` editor window, then be sure to change the eight variable values for your own.<br /><br />

   <details>
   <summary>Expand this section to show the PowerShell script.</summary>

    ```powershell
    # Set the variables for the VPN profile.
    $domain = 'corp' # Name of the domain.
    $templateName = 'Contoso VPN' # Name of the test VPN connection you created in the tutorial. 
    $profileName = 'Contoso AlwaysOn VPN' # Name of the profile we are going to create.
    $servers = 'aov-vpn.contoso.com' # Public or routable IP address or DNS name for the VPN gateway.
    $dnsSuffix = 'corp.contoso.com' # Specifies one or more commas separated DNS suffixes. 
    $domainName = '.corp.contoso.com' # Used to indicate the namespace to which the policy applies. Contains `.` prefix.
    $dnsServers = '10.10.0.6' # List of comma-separated DNS Server IP addresses to use for the namespace.
    $trustedNetwork = 'corp.contoso.com' # Comma-separated string to identify the trusted network.

    # Get the EAP settings for the current profile called $templateName
    $connection = Get-VpnConnection -Name $templateName
    
    if(!$connection)
    {
        $message = "Unable to get $templateName connection profile: $_"
        Write-Host "$message"
        exit
    }
    
    $EAPSettings= $connection.EapConfigXmlStream.InnerXml
    
    $profileNameEscaped = $profileName -replace ' ', '%20'
    
    # Define ProfileXML
    $profileXML = @("
    <VPNProfile>
      <DnsSuffix>$dnsSuffix</DnsSuffix>
      <NativeProfile>
    <Servers>$servers</Servers>
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
    <TrustedNetworkDetection>$trustedNetwork</TrustedNetworkDetection>
      <DomainNameInformation>
    <DomainName>$domainName</DomainName>
    <DnsServers>$dnsServers</DnsServers>
    </DomainNameInformation>
    </VPNProfile>
    ")
        
    # Output the XML for possible use in Intune
    $profileXML | Out-File -FilePath ($env:USERPROFILE + '\desktop\VPN_Profile.xml')
    
    # Escape special characters in the profile (<,>,")
    $profileXML = $profileXML -replace '<', '&lt;'
    $profileXML = $profileXML -replace '>', '&gt;'
    $profileXML = $profileXML -replace '"', '&quot;'
        
    # Define WMI-to-CSP Bridge properties
    $nodeCSPURI = "./Vendor/MSFT/VPNv2"
    $namespaceName = "root\cimv2\mdm\dmmap"
    $className = "MDM_VPNv2_01"
        
    try
    {
    
        # Determine user SID for VPN profile.
        $WmiLoggedOnUsers = (Get-WmiObject Win32_LoggedOnUser).Antecedent
        If($WmiLoggedOnUsers.Count -gt 1) { 
            $WmiLoggedOnUsers = $WmiLoggedOnUsers -match "Domain=""$domain"""
        }
        
        $WmiUserValid = ($WmiLoggedOnUsers | Select-Object -Unique -First 1) -match 'Domain="([^"]+)",Name="([^"]+)"'
        
        If(-not $WmiUserValid){
            Throw "Returned object is not a valid WMI string"
        }
        
        $UserName = "$($Matches[1])\$($Matches[2])"
        
        $ObjUser = New-Object System.Security.Principal.NTAccount($UserName)
        $Sid = $ObjUser.Translate([System.Security.Principal.SecurityIdentifier])
        $SidValue = $Sid.Value
        $message = "User SID is $SidValue."
        
        Write-Host "$message"
    
    }
    catch [Exception] 
    {
    
        $message = "Unable to get user SID. $_"
        Write-Host "$message" 
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
    
        $message = "Unable to create new session for $profileName profile: $_"
        Write-Host $message
        exit
    }
    
    try
    {
    
        # Detect and delete previous VPN profile.
        $deleteInstances = $session.EnumerateInstances($namespaceName, $className, $options)
    
        foreach ($deleteInstance in $deleteInstances)
        {
            $InstanceId = $deleteInstance.InstanceID
            if ("$InstanceId" -eq "$profileNameEscaped")
            {
                $session.DeleteInstance($namespaceName, $deleteInstance, $options)
                $message = "Removed $profileName profile $InstanceId" 
                Write-Host "$message"
            }
            else 
            {
                $message = "Ignoring existing VPN profile $InstanceId"
                Write-Host "$message"
            }
        }
    }
    catch [Exception]
    {
        $message = "Unable to remove existing outdated instance(s) of $profileName profile: $_"
        Write-Host $message
        exit
        
    }
        
    try
    {
    
        # Create the VPN profile.
        $newInstance = New-Object Microsoft.Management.Infrastructure.CimInstance $className, $namespaceName
        $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ParentID", "$nodeCSPURI", "String", "Key")
        $newInstance.CimInstanceProperties.Add($property)
        $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("InstanceID", "$profileNameEscaped", "String", "Key")
        $newInstance.CimInstanceProperties.Add($property)
        $property = [Microsoft.Management.Infrastructure.CimProperty]::Create("ProfileXML", "$profileXML", "String", "Property")
        $newInstance.CimInstanceProperties.Add($property)
        $session.CreateInstance($namespaceName, $newInstance, $options)
    
        $message = "Created $profileName profile."
        Write-Host "$message"
        
    }
    catch [Exception]
    {
    
        $message = "Unable to create $profileName profile: $_"
        Write-Host "$message"
        exit
    }
    
    $message = "Always On VPN connection created successfully."
    Write-Host "$message"
    ```

   </details>

1. Run the script.

1. Verify that the script was successful by running the following command in the `Windows PowerShell ISE` editor window:

    ```powershell
    Get-CimInstance -Namespace root\cimv2\mdm\dmmap -ClassName MDM_VPNv2_01
    ```

   The output should be similar to the following example (the `ProfileXML` value is truncated for readability):

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
    ```

1. The Always On VPN connection should be created and established successfully. You can verify the connection by checking the **Network Connections** window. The **Contoso Always On VPN** connection should show as **Connected**. Test you can connect to a resource on the other side of the VPN tunnel, for example, a file share or web server.

## Related content

Now you connect to the VPN server using the Always On VPN connection, here are some extra resources to help you with your Always On VPN deployment:

- [Configure VPN device tunnels in Windows client](vpn/vpn-device-tunnel-config.md).

- [Deploy Always On VPN profile to Windows clients with Microsoft Configuration Manager](how-to-aovpn-client-config-mgr.md).

- [Deploy Always On VPN profile to Windows clients with Microsoft Intune](how-to-aovpn-client-intune.md).

- [Configure conditional access for VPN connectivity using Microsoft Entra ID](how-to-aovpn-conditional-access.md).

- [Advanced VPN Features](vpn/always-on-vpn/deploy/always-on-vpn-adv-options.md#advanced-vpn-features).

- For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).

- To troubleshoot issues with Always On VPN, see [Troubleshoot Always On VPN](/troubleshoot/windows-server/networking/troubleshoot-always-on-vpn).

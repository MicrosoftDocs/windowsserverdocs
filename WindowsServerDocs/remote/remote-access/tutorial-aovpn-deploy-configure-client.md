---
title: Tutorial - Deploy Always On VPN profile for Windows 10+ clients
description:  Learn how to deploy Always On VPN profile for Windows 10+ clients
ms.topic: article
ms.date: 01/06/2022
ms.assetid: d165822d-b65c-40a2-b440-af495ad22f42
ms.author: anaharris
author: anaharris-ms
---
# Tutorial: Deploy Always On VPN profile for Windows 10+ clients

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10+

In this last part of the tutorial, you'll learn how to use a ProfileXML PowerShell configuration script to configure Always On VPN settings and create a user tunnel for client connections.

For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).

## Prerequisites

1. Complete [Tutorial: Deploy Always On VPN - Configure Certificate Authority templates](tutorial-aovpn-deploy-create-certificates.md).

1. Download [Sample Configuration Windows PowerShell Script](VPN-Profile.ps1).

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

1. For **Type of sing-in info**, select *Certificate*.

1. Select **Save**.

1. Under Related Settings, select **Change adapter options**.

1. Right-click **Contoso VPN**, and select **Properties**.

1. On the **Security** tab, for **Data encryption**, select *Maximum strength encryption*.

1. Select **Use Extensible Authentication Protocol (EAP)**. Then, for **Use Extensible Authentication Protocol (EAP)**, select *Microsoft: Protected EAP (PEAP) (encryption enabled)*.

1. Select **Properties** to open Protected EAP Properties, and complete the following steps:

    1. For **Connect to these servers**, enter the name of the NPS server. For this tutorial, the NPS server is on the domain controller.

    1. For **Trusted Root Certification Authorities**, select the CA that issued the NPS server's certificate (for example, contoso-CA).

    1. For **Notifications before connecting**, select *Don't ask user to authorize new servers or trusted CAs*.

    1. For **Select Authentication Method**, select **Smart Card or other certificate**.
  
    1. Select **Configure**.

        1. Select **Use a certificate on this computer**.

        1. For **Connect to these servers**, enter the name of the NPS server. For this tutorial, the NPS server is on the domain controller.

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

In this section, you'll manually configure the Windows VPN client with the PowerShell script, *VPN-Profile.ps1*, that you downloaded in [Prerequisites](#prerequisites).
  
1. Sign in as your VPN User to the VPN client computer.

1. Open Windows PowerShell integrated scripting environment (ISE) as Administrator.

1. Open `VPN-Profile.ps1`.

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

- Learn how to [Configure conditional access for VPN connectivity using Azure AD](vpn/ad-ca-vpn-connectivity-windows10.md).

- To learn more about the advanced VPN features, see  |[Advanced VPN Features](vpn/always-on-vpn/deploy/always-on-vpn-adv-options.md#advanced-vpn-features).

- To learn how to configure Always On VPN profiles with Microsoft Configuration Manager, see [Deploy Always On VPN profile to Windows 10+ clients with Microsoft Configuration Manager](how-to-aovpn-client-config-mgr.md).

- To learn how to configure Always On VPN profiles with Microsoft Intune, see [Deploy Always On VPN profile to Windows 10+ clients with Microsoft InTune](how-to-aovpn-client-intune.md).

- For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).
---
description: Learn how to upgrade the farm behavior level for an existing Active Directory Federation Service farm by using Windows Internal Database in Windows Server.
ms.assetid: 7671e0c9-faf0-40de-808a-62f54645f891
title: Upgrade an AD FS farm by using Windows Internal Database in Windows Server
author: billmath
manager: amycolannino
ms.date: 06/21/2023
ms.topic: article
ms.author: wscontent
---

# Upgrade an existing AD FS farm by using Windows Internal Database

[!INCLUDE [Migrate to Azure AD](../../../../includes/adfs-to-azure-ad-upgrade.md)]

In this article, you learn how to upgrade the farm behavior level for Active Directory Federation Services (AD FS) by using Windows Internal Database (WID). Beginning in Windows Server 2016, the farm behavior level (FBL) was introduced to AD FS. The FBL is farm-wide setting that determines the features the AD FS farm can use.

Administrators can add new federation servers to an existing Windows Server farm in "mixed mode." Mixed mode operates at the same farm behavior level as the original farm to ensure consistent behavior. Features of the newer Windows Server AD FS versions can't be configured or used.
  
## Prerequisites

Before you can upgrade the farm behavior level, you must meet the following prerequisites:

- Determine [which version of Windows Server to upgrade to](../../../get-started/upgrade-overview.md).

- Deploy the target Windows Server version on a new computer, apply all Windows Updates, and install the Active Directory Federation Service server role. For more information, see [Add a federation server to an existing federation server farm](Configure-a-Federation-Server.md#add-a-federation-server-to-an-existing-federation-server-farm).

- If you're also using Windows Server Web Application Proxy, deploy the target Windows Server version on a new computer, apply all Windows Updates, and install the Remote Access server role and Web Application Proxy role service. For more information, see [Working with Web Application Proxy](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn584113(v=ws.11)).

- If you're upgrading to AD FS in Windows Server 2016 or later, the farm upgrade requires the AD schema to be at least level 85. If you're upgrading to in Windows Server AD FS 2019 or later, the AD schema must be at least 88. For more information about upgrading your domain, see [Upgrade domain controllers to a newer version of Windows Server](../../ad-ds/deploy/upgrade-domain-controllers.md).

- Have a defined time frame planned for completion. It's not recommended to operate a mixed mode state for an extended period of time. Leaving AD FS in a mixed mode state might cause issues with the farm.

- Back up your AD FS configuration and federation servers.

## Farm behavior levels

By default, the FBL in a new AD FS farm matches the value for the Windows Server version of the first farm node installed.

You can join an AD FS server of a later version to a farm with a lower FBL. The farm operates at the same FBL as the existing node(s). When you have multiple Windows Server versions operating in the same farm at the FBL value of the lowest version, your farm is "mixed." However, you can't take advantage of the features of the later versions until you raise the FBL. If your organization is looking to test the new features prior to raising the FBL, you need to deploy a separate farm.

The following table lists the possible FBL values and configuration database names by Windows Server version.

| Windows Server Version | FBL value| AD FS Configuration Database Name |
|---|---|---|
| 2012 R2 | 1 | AdfsConfiguration |
| 2016 | 3 | AdfsConfigurationV3 |
| 2019 and 2022 | 4 | AdfsConfigurationV4 |

> [!NOTE]
> Upgrading the FBL creates a new AD FS configuration database.

Now that you understand the purpose of the FBL and have completed the prerequisites, you're ready to review your current FBL.

To find your current FBL:

1. Sign in to your federation server and open an elevated PowerShell session.

1. Run the following PowerShell command to return the current FBL and farm node information.

   ```powershell
   Get-AdfsFarmInformation
   ```

1. Review the `CurrentFarmBehavior` and `FarmNodes`.

## Migrate federation servers

After you've collected the current federation farm information, you're ready to begin the upgrade process. To begin the upgrade:

1. Add the new federation server(s) to your existing farm. For more information, see [Add a federation server to an existing federation server farm](Configure-a-Federation-Server.md#add-a-federation-server-to-an-existing-federation-server-farm).

1. Sign into your new federation server, then open an elevated PowerShell session. If you have more than one server, only run this command on one server.

1. Set the federation server sync property to take the primary computer role by running the following command. For more information, see [Set-AdfsSyncProperties](/powershell/module/adfs/set-adfssyncproperties).

   ```powershell
   Set-AdfsSyncProperties -Role PrimaryComputer
   ```

1. Sign into any other federation servers in the farm, open an elevated PowerShell session.

1. Set the role to be the secondary computer by running the following command.

   ```powershell
   Set-AdfsSyncProperties -Role SecondaryComputer -PrimaryComputerName "<primary-server-FQDN>"
   ```

1. Update any load balancer, DNS, or network configurations to use the new federation servers, verifying the server is operational. For more information, see [Verify your Windows Server 2012 R2 Federation Server is Operational](Verify-your-Windows-Server-2012-R2-Federation-Server-Is-Operational.md).

1. Uninstall the Active Directory Federation Service server role from the previous servers, then run
   the following command to remove the stale entries.

   ```powershell
   Set-AdfsFarmInformation -RemoveNode "<old-server-FQDN>"
   ```

Now that you have your new federations server to farm and removed the previous ones, you're ready to upgrade the FBL. For more information about decommissioning, see [Steps to decommission your AD FS Servers](../decommission/adfs-decommission-guide.md#steps-to-decommission-your-ad-fs-servers).

## Upgrade the Farm Behavior Level

After you've collected the current federation farm information, you're ready to begin the upgrade process. To begin the upgrade:

1. Sign into your primary federation server, then open an elevated PowerShell session.

1. Run the following command to test whether you can raise the behavior level of a farm.

   ```powershell
   Test-AdfsFarmBehaviorLevelRaise
   ```

1. Ater you've reviewed the output, to upgrade the farm behavior level, run the following command. You're prompted if you want to continue.

   ```powershell
   Invoke-AdfsFarmBehaviorLevelRaise
   ```

1. Review the command output to confirm the operation was successful. To verify the new farm behavior level, run the following PowerShell command to return the current FBL and farm node information.

   ```powershell
   Get-AdfsFarmInformation
   ```

You've now upgraded your FBL to match your target Windows Server version. If you're also using the Windows Server Web Application Proxy role service, continue to the next section.

## Upgrade Web Application Proxy

Now that you've updated your FBL, you need to upgrade Web Application Proxy (WAP) to the latest level.

1. Sign in to your newly deployed Web Application Proxy server and open an elevated PowerShell session.

1. Import the certificate used by the federation certificate, and make a note of the certificate thumbprint.

1. To configure WAP, run the following PowerShell command, replacing the placeholder `<value>` with your own values. Repeat this step for any more Web Application Proxy servers.

   ```powershell
   $trustcred = Get-Credential -Message "<Enter Domain Administrator credentials>"
   Install-WebApplicationProxy -CertificateThumbprint "<SSLCertThumbprint>" -FederationServiceName "<FScomputername>" -FederationServiceTrustCredential $trustcred
   ```

1. To review the current connected Web Application Proxy servers, run the following command, note the `ConnectedServerName` and `ConfigurationVersion` values.

   ```powershell
   Get-WebApplicationProxyConfiguration
   ```

   > [!NOTE]
   > Skip the next step if the ConfigurationVersion is `Windows Server 2016`. This is the correct value for Web Application Proxy on Windows Server 2016 and later.

1. Remove old Web Application Proxy servers, keeping only the new servers configured in the previous steps by running the following PowerShell cmdlet:

   ```powershell
   Set-WebApplicationProxyConfiguration -ConnectedServersName "WAPServerName1, WAPServerName2"
   ```

1. To upgrade the ConfigurationVersion of the WAP servers, run the following PowerShell command:

   ```powershell
   Set-WebApplicationProxyConfiguration -UpgradeConfigurationVersion
   ```

You've now completed the upgrade of the Web Application Proxy.

## Certificate trust model with Windows Hello for Business

If you're using AD FS on Windows Server 2019 or later, and Windows Hello for Business in a certificate trust model, you might encounter the following event log error message.

`Received invalid Oauth request. The client 'NAME' is forbidden to access the resource with scope 'ugs'.`

To fix this error:

1. Open the AD FS management console. Go to **Services > Scope Descriptions**.

1. Right-click **Scope Descriptions** and select **Add Scope Description**.

1. Under name, enter **_ugs_**, and then select **Apply > OK**.

1. Launch PowerShell as Administrator and run the following commands.

   ```powershell
   $id = (Get-AdfsApplicationPermission -ServerRoleIdentifiers 'http://schemas.microsoft.com/ws/2009/12/identityserver/selfscope' | ?{ $_.ClientRoleIdentifier -eq '38aa3b87-a06d-4817-b275-7a316988d93b' }).ObjectIdentifier
   Set-AdfsApplicationPermission -TargetIdentifier $id -AddScope 'ugs'
   ```

1. Restart the AD FS service.

1. Restart the client. The user should be prompted to configure Windows Hello for Business.

## Next steps

Now that you've upgraded your AD FS deployment, here are some articles that you might find useful.

- [Verify That a Federation Server Is Operational](Verify-That-a-Federation-Server-Is-Operational.md)
- [Verify That a Federation Server Proxy Is Operational](Verify-That-a-Federation-Server-Proxy-Is-Operational.md)
- [AD FS Operations](../ad-fs-operations.md)

---
title: Deploy Windows Admin Center with High Availability
description: Deploy Windows Admin Center with High Availability (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Deploy Windows Admin Center with high availability

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

You can deploy Windows Admin Center in a failover cluster to provide high availability for your Windows Admin Center gateway service. The solution provided is an active-passive solution, where only one instance of Windows Admin Center is active. If one of the nodes in the cluster fails, Windows Admin Center gracefully fails over to another node, letting you continue managing the servers in your environment seamlessly. 

[Learn about other Windows Admin Center deployment options.](../plan/installation-options.md)

## Prerequisites

- A failover cluster of 2 or more nodes on Windows Server 2016. [Learn more about deploying a Failover Cluster](../../../failover-clustering/failover-clustering-overview.md).
- A cluster shared volume (CSV) for Windows Admin Center to store persistent data that can be accessed by all the nodes in the cluster. 10 GB will be sufficient for your CSV.
- High-availability deployment scripts from [Windows Admin Center HA Setup Scripts zip file](http://aka.ms/WACHASetupScripts). You can download the .zip file containing these scripts to a node on the cluster or to your local machine and then copy the scripts as needed based on the guidance below.
- Recommended, but optional: a signed certificate .pfx & password. You don't need to have already installed the certificate on the cluster nodes - the script will do that for you. If you don't supply one, the installation script generates a self-signed certificate, which expires after 90 days.

## Install Windows Admin Center on a failover cluster

1. Copy the Install-WindowsAdminCenterHA.ps1 script to a node in your cluster. Download or copy the Windows Admin Center .msi to the same node.
2. Run the Install-WindowsAdminCenterHA.ps1 script with the following parameters:
    - `-clusterStorage`: the local path of the Cluster Shared Volume to store Windows Admin Center data.
    - `-clientAccessPoint`: choose a name that you will use to access Windows Admin Center. For example, if you run the script with the parameter `-clientAccessPoint contosoWindowsAdminCenter`, you will access the Windows Admin Center service by visiting `https://contosoWindowsAdminCenter.<domain>.com`
    - `staticAddress`: Optional. One or more static addresses for the cluster generic service.
    - `-msiPath`: The path for the Windows Admin Center .msi file.
    - `-certPath`: Optional. The path for a certificate .pfx file.
    - `-certPassword`: Optional. A SecureString password for the certificate .pfx provided in `-certPath`
    - `-generateSslCert`: Optional. If you don't want to provide a signed certificate, include this parameter flag to generate a self-signed certificate. Note that the self-signed certificate will expire in 90 days.
    - `-portNumber`: Optional. If you don't specify a port, the gateway service is deployed on port 443 (HTTPS). To use a different port specify in this parameter. Note that if you use a custom port (anything besides 443), you'll access the Windows Admin Center by going to https://\<clientAccessPoint\>:\<port\>.

For example, to install with a signed certificate:

```powershell
C:\PS> $certPassword = Read-Host -AsSecureString
C:\PS> .\Install-WindowsAdminCenterHA.ps1 -clusterStorage C:\ClusterStorage\Volume1 -clientAccessPoint contoso-ha-gateway -msiPath '.\ServerManagementGateway.msi' -certPath cert.pfx -certPassword $certPassword
```

And to install with a self-signed certificate:

```powershell
C:\PS> .\Install-WindowsAdminCenterHA.ps1 -clusterStorage C:\ClusterStorage\Volume1 -clientAccessPoint contoso-ha-gateway -msiPath '.\ServerManagementGateway.msi' -generateSslCert
```

### Troubleshooting

Installation logs are saved in the temp folder of the CSV (for example, C:\ClusterStorage\Volume1\temp).

## Update an existing high availability installation

You can update your high availability installation when a newer version of Windows Admin Center is released, without losing your connection data saved in Windows Admin Center.

1. Copy the Update-WindowsAdminCenterHA.ps1 script to a node in the failover cluster where you deployed Windows Admin Center. Copy the new Windows Admin Center .msi to the same node. 
2. Run the Update-WindowsAdminCenterHA.ps1 script with the parameter -msiPath, the path for the Windows Admin Center .msi file.

    For example:
    ```powershell
    C:\PS> .\Update-WindowsAdminCenterHA.ps1 -msiPath '.\ServerManagementGateway.msi'
    ```

## Uninstall the Windows Admin Center gateway from your failover cluster

The Uninstall-WindowsAdminCenterHA.ps1 script uninstalls Windows Admin Center from all the nodes on your failover cluster. 

1. Run the Uninstall-WindowsAdminCenterHA.ps1 on a node in the Failover Cluster where Windows Admin Center is deployed. No parameters are needed.

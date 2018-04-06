---
title: Deploy Windows Admin Center with High Availability
description: Deploy Windows Admin Center with High Availability (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Deploy Windows Admin Center with High Availability

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

[link to overview]
[link back to planning]
[Content goes here]

[TODO:legacy-content-begin]

## Deploy Project Honolulu with high availability

You can deploy Project Honolulu in a failover cluster to provide high availability of your Honolulu gateway service. The solution provided is an active-passive solution, where only one instance of Honolulu is active. If one of the nodes in the cluster fails, Project Honolulu gracefully fails over to another node, letting you continue managing the servers in your environment seamlessly. 

### Install Project Honolulu on a failover cluster

#### Prerequisites
- A Failover Cluster of 2 or more nodes on Windows Server 2016. [Learn more about deploying a Failover Cluster](https://docs.microsoft.com/en-us/windows-server/failover-clustering/failover-clustering-overview).
- A Cluster Shared Volume (CSV) for Project Honolulu to store persistent data that can be accessed by all the nodes in the cluster. 10 GB will be sufficient for your CSV.
- High-availability deployment scripts from [Honolulu HA Setup Scripts zipfile](http://aka.ms/HonoluluHASetupScripts). You can download the .zip file containing these scripts to a node on the cluster or to your local machine and then copy the scripts as needed based on the guidance below.
- Recommended, but optional: a signed certificate .pfx & password. You do not need to have already installed the certificate on to the cluster nodes - the script will do that for you. If you do not supply one, the installation script will generate a self-signed certificate, which expires after 90 days.

#### Installation
1.	Copy the Install-HonoluluHA.ps1 script to a node in your cluster. Download or copy the Project Honolulu .msi to the same node.
2.	Run the Install-HonoluluHA.ps1 script with the following parameters:
    - `-clusterStorage`: the local path of the Cluster Shared Volume to store Project Honolulu data 
    - `-clientAccessPoint`: choose a name that you will use to access Project Honolulu. For example, if you run the script with the parameter `-clientAccessPoint contosoHonolulu`, you will access the Project Honolulu service by visiting `https://contosoHonolulu.<domain>.com`
    - `-msiPath`: The path for the Project Honolulu .msi file.
    - `-certPath`: Optional. The path for a certificate .pfx file. 
    - `-certPassword`: Optional. A SecureString password for the certificate .pfx provided in `-certPath`
    - `-generateSslCert`: Optional. If you do not want to provide a signed certificate, include this parameter flag to generate a self-signed certificate. Note that the self-signed certificate will expire in 90 days. 
    - `-portNumber`: Optional. If no port is specified, the gateway service will be deployed on port 443 (HTTPS). If you wish to use a different port, specify in this parameter. Note that if you use a custom port (anything besides 443), you will access the Project Honolulu by visiting `https://<clientAccessPoint>:<port>`.

For example, to install with a signed certificate:

    C:\PS> $certPassword = Read-Host -AsSecureString
    C:\PS> .\Install-HonoluluHA.ps1 -clusterStorage C:\ClusterStorage\Volume1 -clientAccessPoint contoso-ha-gateway -msiPath '.\ServerManagementGateway.msi' -certPath cert.pfx -certPassword $certPassword

And to install with a self-signed certificate:
    
    C:\PS> .\Install-HonoluluHA.ps1 -clusterStorage C:\ClusterStorage\Volume1 -clientAccessPoint contoso-ha-gateway -msiPath '.\ServerManagementGateway.msi' -generateSslCert

#### Troubleshooting
Installation logs are saved in the temp folder of the Cluster Shared Volume (e.g. C:\ClusterStorage\Volume1\temp)

### Update an existing HA installation
You can update your HA installation when a newer version of Honolulu is released, without losing your connection data saved in Project Honolulu.
1.	Copy the Update-HonoluluHA.ps1 script to a node in the Failover Cluster where Honolulu is deployed. Copy the new Honolulu .msi to the same node. 
2.	Run the Update-HonoluluHA.ps1 script with the parameter -msiPath, the path for the Project Honolulu .msi file.
    
    For example:
    
        C:\PS> .\Update-HonoluluHA.ps1 -msiPath '.\ServerManagementGateway.msi'

### Uninstall the Honolulu gateway from your failover cluster
The Uninstall-HonoluluHA.ps1 script uninstalls Honolulu from all the nodes on your failover cluster. 
1.	Run the Uninstall-HonoluluHA.ps1 on a node in the Failover Cluster where Honolulu is deployed. No parameters are needed.

[TODO:legacy-content-end]
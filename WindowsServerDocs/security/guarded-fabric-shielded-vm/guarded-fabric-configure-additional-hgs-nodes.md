---
title: Configure additional HGS nodes
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 227f723b-acb2-42a7-bbe3-44e82f930e35
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 03/02/2017
---

# Configure additional HGS nodes

>Applies To: Windows Server 2016

In production environments, HGS should be set up in a high availability cluster to ensure that shielded VMs can be powered on even if an HGS node goes down. For test environments, secondary HGS nodes are not required.

The following steps will add a node to the HGS cluster. The computer should *not* be joined to any domain before you perform these steps.

1.  To add the Host Guardian Service role to the computer, run the following command in an elevated Windows PowerShell console:

    ```powershell
    Install-WindowsFeature -Name HostGuardianServiceRole -IncludeManagementTools -Restart
    ```

    >**Note**&nbsp;&nbsp;If you are adding HGS to an existing domain not created with **Install-HgsServer**, you may skip to step 5.

2.  Configure at least one NIC on this machine to use the DNS server on your first HGS server for name resolution. This is necessary to enable the machine to resolve and join the HGS domain and cluster in the next step.

3.  Install the Host Guardian Service by running the command below. Substitute the IP addresses and names as appropriate for your environment:

    ```powershell
    $adSafeModePassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

    $cred = Get-Credential 'relecloud\Administrator'

    Install-HgsServer -HgsDomainName 'relecloud.com' -HgsDomainCredential $cred -SafeModeAdministratorPassword $adSafeModePassword -Restart
    ```

4.  Wait for the server to restart, then sign in with the HGS domain administrator credentials.

5.  Run the commands below to finish adding the new node to the HGS cluster. Substitute the IP addresses and names as appropriate for your environment:

    ```powershell
    $cred = Get-Credential 'relecloud\Administrator'

    Initialize-HgsServer -HgsServerIPAddress <IP address of first HGS Server>
    ```

6.  Allow up to 10 minutes for the encryption and signing certificates from the first HGS server to replicate to this node.

7.  If you used HSM-backed certificates, you will need to install the driver for your HSM on this machine and grant the machine access to the private keys of the encryption and signing certificates per your HSM manufacturer's instructions. For both PKI-issued and HSM-backed certificates, you must manually grant the HGS service access to the private keys of the certificate per the instructions in [Use my own certificates with an HSM](#use-your-own-certificates-with-an-hsm).


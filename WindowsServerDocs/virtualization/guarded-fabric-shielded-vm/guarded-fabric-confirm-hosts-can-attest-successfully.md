---
title: Confirm guarded hosts can attest
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 7485796b-b840-4678-9b33-89e9710fbbc7
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Confirm guarded hosts can attest 

>Applies To: Windows Server 2016

A fabric administrator needs to confirm that Hyper-V hosts can run as guarded hosts. Complete the following steps on at least one guarded host:

1.  If you have not already installed the Hyper-V role and Host Guardian Hyper-V Support feature, install them with the following command:

        Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart

2.  Configure the host's Key Protection and Attestation URLs:

    - **Through Windows PowerShell**: You can configure the Key Protection and Attestation URLs by executing the following command in an elevated Windows PowerShell console. For &lt;FQDN&gt;, use the Fully Qualified Domain Name (FQDN) of your HGS cluster (for example, hgs.relecloud.com, or ask the HGS administrator to run the **Get-HgsServer** cmdlet on the HGS server to retrieve the URLs).

        `Set-HgsClientConfiguration -AttestationServerUrl 'http://<FQDN>/Attestation' -KeyProtectionServerUrl 'http://<FQDN>/KeyProtection'`

    - **Through VMM**: If you are using System Center 2016 - Virtual Machine Manager (VMM), you can configure Attestation and Key Protection URLs in VMM. For details, see [Configure global HGS settings](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-hosts#configure-global-hgs-settings) in **Provision guarded hosts in VMM**.
    
    >**Notes**
    > - If the HGS administrator [enabled HTTPS on the HGS server](guarded-fabric-configure-the-first-hgs-node.md#configuring-hgs-for-https-communications), begin the URLs with `https://`.
    > - If the HGS administrator enabled HTTPS on the HGS server and used a self-signed certificate, you will need to import the certificate into the Trusted Root Certificate Authorities store on every host. To do this, run the following command on each host:<br>
        `Import-Certificate -FilePath "C:\temp\HttpsCertificate.cer" -CertStoreLocation Cert:\LocalMachine\Root`
    
3.  To initiate an attestation attempt on the host and view the attestation status, run the following command:

        Get-HgsClientConfiguration

    The output of the command indicates whether the host passed attestation and is now guarded. If `IsHostGuarded` does not return **True**, you can run the HGS diagnostics tool, [Get-HgsTrace](https://technet.microsoft.com/library/mt718831.aspx), to investigate. To run diagnostics, enter the following command in an elevated Windows PowerShell prompt on the host:

        Get-HgsTrace -RunDiagnostics -Detailed

## Next steps

For hosting service providers, see [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md).

For a list of all tasks for configuring a guarded fabric, see [Deployment tasks for guarded fabrics and shielded VMs](guarded-fabric-deploying-hgs-overview.md#deployment-tasks-for-guarded-fabrics-and-shielded-vms).

## See also

- [Deploy the Host Guardian Service (HGS)](guarded-fabric-deploying-hgs-overview.md)
- [Deploy shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)


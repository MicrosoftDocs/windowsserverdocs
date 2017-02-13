---
title: Configuring a guarded fabric - confirm hosts can attest successfully
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 7485796b-b840-4678-9b33-89e9710fbbc7
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Configuring a guarded fabric - confirm hosts can attest successfully

This topic describes a final step that a fabric administrator takes, to confirm that Hyper-V hosts can run as guarded hosts. Before taking these steps, complete all the fabric-administrator steps outlined in [Configuration steps for Hyper-V hosts that will become guarded hosts](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md). 

For a list of the tasks for configuring a guarded fabric, see [Deployment tasks for guarded fabrics and shielded VMs](guarded-fabric-deploying-hgs-overview.md#deployment-tasks-for-guarded-fabrics-and-shielded-vms).

If the procedures for capturing information about the hosts and adding it to the HGS configuration have been completed successfully, attestation will succeed on the hosts.

Complete the following steps on at least one host that will run as a guarded host:

1.  If you have not already installed the Hyper-V role and Host Guardian Hyper-V Support feature, install them with the following command:

        Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart

2.  Configure the host's Key Protection and Attestation URLs:

    - **Through Windows PowerShell**: You can configure the Key Protection and Attestation URLs by executing the following command in an elevated Windows PowerShell console. For &lt;FQDN&gt;, use the FQDN of your HGS cluster (for example, hgs.relecloud.com, or ask the HGS administrator to run the **Get-HgsServer** cmdlet on the HGS server to retrieve the URLs).

        `Set-HgsClientConfiguration -AttestationServerUrl 'http://<FQDN>/Attestation' -KeyProtectionServerUrl 'http://<FQDN>/KeyProtection'`

    - **Through VMM**: If you are using System Center 2016 - Virtual Machine Manager (VMM), you can configure  Attestation and Key Protection URLs in VMM. For details, see [Configure global HGS settings](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-hosts#configure-global-hgs-settings) in **Provision guarded hosts in VMM**.
    
    >**Notes**
    > - If the HGS administrator enabled HTTPS on the HGS server (as described in the [Initialize HGS server with an HTTPS Certificate](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#initialize-hgs-server-with-an-https-certificate) section in the HGS server topic), when specifying the host's Key Protection and Attestation URLs, remember to begin the URLs with `https://` rather than `http://`.
    > -  If the HGS administrator enabled HTTPS on the HGS server, and used a self-signed certificate, you will need to import the certificate into the Trusted Root Certificate Authorities store on every host. To do this, run the following command on each host machine:<br>
        `Import-Certificate -FilePath "C:\temp\HttpsCertificate.cer" -CertStoreLocation Cert:\LocalMachine\Root`
    
3.  To initiate an attestation attempt on the host and view the attestation status, run the following command:

        Get-HgsClientConfiguration

    The output of the command indicates whether the host passed attestation and is now guarded. If `IsHostGuarded` does not return **True**, you can run the HGS diagnostics tool, [Get-HgsTrace](https://technet.microsoft.com/library/mt718831.aspx), to investigate. To run diagnostics, enter the following command in an elevated Windows PowerShell prompt on the host:

        Get-HgsTrace -RunDiagnostics -Detailed

## Next steps

For hosting service providers, see [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md).

For a list of all tasks for configuring a guarded fabric, see [Deployment tasks for guarded fabrics and shielded VMs](guarded-fabric-deploying-hgs-overview.md#deployment-tasks-for-guarded-fabrics-and-shielded-vms).

## See also

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
- [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
- [Tenant configuration steps for shielded VMs](guarded-fabric-tenant-configuration-steps-for-shielded-vms.md)


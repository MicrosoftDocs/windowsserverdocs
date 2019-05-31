---
title: Confirm guarded hosts can attest
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 7485796b-b840-4678-9b33-89e9710fbbc7
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 02/05/2019
---

# Confirm guarded hosts can attest 

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016


A fabric administrator needs to confirm that Hyper-V hosts can run as guarded hosts. Complete the following steps on at least one guarded host:

1.  If you have not already installed the Hyper-V role and Host Guardian Hyper-V Support feature, install them with the following command:

        Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart

2.  Make sure the Hyper-V host can resolve the HGS DNS name and has network connectivity to reach port 80 (or 443 if you set up HTTPS) on the HGS server.

2.  Configure the host's Key Protection and Attestation URLs:

    - **Through Windows PowerShell**: You can configure the Key Protection and Attestation URLs by executing the following command in an elevated Windows PowerShell console. For &lt;FQDN&gt;, use the Fully Qualified Domain Name (FQDN) of your HGS cluster (for example, hgs.bastion.local, or ask the HGS administrator to run the **Get-HgsServer** cmdlet on the HGS server to retrieve the URLs).

        `Set-HgsClientConfiguration -AttestationServerUrl 'http://<FQDN>/Attestation' -KeyProtectionServerUrl 'http://<FQDN>/KeyProtection'`

        To configure a fallback HGS server, repeat this command and specify the fallback URLs for the Key Protection and Attestation services. For more information, see [Fallback configuration](guarded-fabric-manage-branch-office.md#fallback-configuration). 

    - **Through VMM**: If you are using System Center 2016 - Virtual Machine Manager (VMM), you can configure Attestation and Key Protection URLs in VMM. For details, see [Configure global HGS settings](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-hosts#configure-global-hgs-settings) in **Provision guarded hosts in VMM**.
    
    >**Notes**
    > - If the HGS administrator [enabled HTTPS on the HGS server](guarded-fabric-configure-hgs-https.md), begin the URLs with `https://`.
    > - If the HGS administrator enabled HTTPS on the HGS server and used a self-signed certificate, you will need to import the certificate into the Trusted Root Certificate Authorities store on every host. To do this, run the following command on each host:<br>
        `Import-Certificate -FilePath "C:\temp\HttpsCertificate.cer" -CertStoreLocation Cert:\LocalMachine\Root`
    
3.  To initiate an attestation attempt on the host and view the attestation status, run the following command:

        Get-HgsClientConfiguration

    The output of the command indicates whether the host passed attestation and is now guarded. If `IsHostGuarded` does not return **True**, you can run the HGS diagnostics tool, [Get-HgsTrace](https://technet.microsoft.com/library/mt718831.aspx), to investigate. To run diagnostics, enter the following command in an elevated Windows PowerShell prompt on the host:

        Get-HgsTrace -RunDiagnostics -Detailed

    > [!IMPORTANT]
    > If you're using Windows Server 2019 or Windows 10, version 1809 and are using code integrity policies, `Get-HgsTrace` return a failure for the **Code Integrity Policy Active** diagnostic.
    > You can safely ignore this result when it is the only failing diagnostic.

## Next step

> [!div class="nextstepaction"]
> [Deploy shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)

## See also

- [Deploy the Host Guardian Service (HGS)](guarded-fabric-deploying-hgs-overview.md)
- [Deploy shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)


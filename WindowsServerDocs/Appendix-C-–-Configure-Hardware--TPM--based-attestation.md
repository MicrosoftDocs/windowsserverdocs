---
title: Appendix C – Configure Hardware (TPM)-based attestation
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 444fa98e-605b-42d5-b541-1870b172d7ee
robots: noindex,nofollow
---
# Appendix C – Configure Hardware (TPM)-based attestation
Trusted Platform Module (TPM)-based attestation requires the following three primary inputs:  
* Unique identifier of the guarded host—the TPM identity is used to recognize a specific host.  
* Secure boot configuration—this provides the assurance that the machine boot binary files are signed by trusted entities.  
* Code integrity policy—the policy that is used to ensure that only trusted code is running in the host operating system.

>**Note** This is pre-release documentation and the following processes, hardware requirements, and set up instructions are subject to change prior to the final release. Additionally, support for the TPM 2.0 standard is not fully implemented—hardware incompatibilities between vendors are expected. Depending upon your hardware, it may not be possible to successfully configure TPM-based attestation.

### TPM-based attestation  
Before you can use TPM-based attestation, physical hardware requires hosts to be equipped with a TPM 2.0 and UEFI 2.3.1.

To test TPM-based attestation, you’ll need to:

1.  Initialize the HGS server with support for TPM-based attestation.  
2.  Update the attestation configuration with the unique identifier of the guarded host and enable TPM-based attestation.  
3.  Enable the secure boot policy.  
4.  Enable the code integrity policy.

  >**Note:** When using TPM-based attestation, all of the tenant-specific processes that you used to prepare and use shielded VMs remain the same as when you used administrator-trusted attestation.

### To initialize HGS Server for TPM-based Attestation  
1.  To configure the HGS server for TPM-based attestation, run the Initialize-HgsServer command with the –TrustTpm flag instead of –TrustActiveDirectory. For example, the command in section 6.4 would now look like:

```
Initialize-HgsServer –HgsServiceName $HgsServiceName -EncryptionCertificateThumbprint $encryptionCert.Thumbprint -SigningCertificateThumbprint $signingCert.Thumbprint -CommunicationsCertificateThumbprint $signingCert.Thumbprint –TrustTpm -Force  
```
 ***       
  >**Note:** Once the Initialize-HgsServer command has been executed, the attestation mode cannot be changed from TPM-based attestation to AD-based attestation, or vice versa. Such a change would require a completely uninstalling and reinstalling HGS.

### To enable TPM-based attestation  
1.  Run the following cmdlet on each Hyper-V host to get its platform ID.  
  `(Get-PlatformIdentifier).InnerXml | Out-file c:\\Host1.xml`
1.  Copy the platform ID files (Host1.xml) to the server running the Host Guardian Service.  
2.  Run the following cmdlet on the server running the Host Guardian Service to add the host to the service’s attestation policy. Repeat this step for every platform ID file.  
  `Add-HgsAttestationTpmHost –path c:\\Host1.xml –Name ‘tpmhostname’`  
1.  To see the list of hosts in the Host Guardian Service policy, run the following cmdlet:  
  `Get-HgsAttestationTpmHost`

### To enable the secure boot policy  
1.  On the reference host that exemplifies the standard you want other hosts in the fabric to follow (built from trusted media source, TPM and UEFI Secure Boot enabled, etc.), run the following cmdlet:  
  `Get-HgsAttestationBaselinePolicy –Path OEM1.tcglog –Force`  
1.  Copy the OEM1.tcglog file to the HGS server, or to a network file share accessible to it.  
2.  On the HGS server, run the following cmdlet:  
  `Add-HgsAttestationTpmPolicy –Path OEM1.tcglog –Name ‘OEM1Policy’`  
  
### To enable code integrity policy
1.  On the reference host, generate the code integrity policy. The example below is for a FileName policy. Run the following cmdlets:  
  `New-CIPolicy -Level FileName -FilePath 'c:\\policy.xml'`

  `ConvertFrom-CIPolicy 'c:\\policy.xml' 'c:\\Policy.p7b'`  

  >If you receive a “console buffer size” error when creating the CI policy, re-run the command with 3&gt; warnings.txt appended to the end. This will redirect the warnings to a file, allowing the cmdlet to complete successfully.

1.  Copy the policy file 'c:\\Policy.p7b' to a network file share accessible by the hosts and HGS server, for example file://\\\Host1\CIPolicies.  
2.  On the Host Guardian Service server, run the following cmdlet:  
  `Add-HgsAttestationCIPolicy -Path \\\\Host1\\temp\\Policy.p7b -Name FileNamePolicy -ConvertToHash`

**Configure Code Integrity Settings in VMM**  
1.  Open VMM, and then under **Settings** &gt; **General**, open **Host Guardian Service Settings**.  
2.  Verify the Attestation and Key Protection Server URLs are correct.  
3.  Under **Code Integrity Policies**, click **Add**, and then enter the network path and a friendly name for the Code Integrity policy created in the previous section.  
4.  Navigate to the **Fabric** windows, and then find the hosts you want to guard. Complete the following actions for each host:  
    1.  Verify that the host has read permission and can access the CI Policy from the location configured in step  3.
    2.  Put the host in **maintenance mode**.  
    3.  Open the **Properties** window for the host. Under **Host Guardian Service**, check both boxes to configure HGS URLs, and apply a CI Policy. From the drop-down list, select the policy that was just created.  
    4.  Check **Apply or update policy immediately** &gt; **OK**. This applies the CI policy and may restart the host server. Monitor the job status in VMM and wait for it to complete.  
    5.  Run the following command on the host to confirm that the host is now guarded:  
        `Get-HgsClientConfiguration`  
        
        A successful configuration and attestation will yield the following results:

          IsHostGuarded&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**True**  
          AttestationStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Passed**  
          AttestationOperationMode&nbsp;&nbsp;&nbsp;&nbsp;**Tpm**


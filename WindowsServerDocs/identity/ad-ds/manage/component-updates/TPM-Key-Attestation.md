---
ms.assetid: 16a344a9-f9a6-4ae2-9bea-c79a0075fd04
title: TPM Key Attestation
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# TPM Key Attestation

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

**Author**: Justin Turner, Senior Support Escalation Engineer with the Windows group  
  
> [!NOTE]  
> This content is written by a Microsoft customer support engineer, and is intended for experienced administrators and systems architects who are looking for deeper technical explanations of features and solutions in Windows Server 2012 R2 than topics on TechNet usually provide. However, it has not undergone the same editing passes, so some of the language may seem less polished than what is typically found on TechNet.  
  
## Overview  
While support for TPM-protected keys has existed since Windows 8, there were no mechanisms for CAs to cryptographically attest that the certificate requester private key is actually protected by a Trusted Platform Module (TPM). This update enables a CA to perform that attestation and to reflect that attestation in the issued certificate.  
  
> [!NOTE]  
> This article assumes that the reader is familiar with certificate template concept (for reference, see [Certificate Templates](https://technet.microsoft.com/library/cc730705.aspx)). It also assumes that the reader is familiar with how to configure enterprise CAs to issue certificates based on certificate templates (for reference, see [Checklist: Configure CAs to Issue and Manage Certificates](https://technet.microsoft.com/library/cc771533.aspx)).  
  
### Terminology  
  
|Term|Definition|  
|--------|--------------|  
|EK|Endorsement Key. This is an asymmetric key contained inside the TPM (injected at manufacturing time). The EK is unique for every TPM and can identify it. The EK cannot be changed or removed.|  
|EKpub|Refers to public key of the EK.|  
|EKPriv|Refers to private key of the EK.|  
|EKCert|EK Certificate. A TPM manufacturer-issued certificate for EKPub. Not all TPMs have EKCert.|  
|TPM|Trusted Platform Module. A TPM is designed to provide hardware-based security-related functions. A TPM chip is a secure crypto-processor that is designed to carry out cryptographic operations. The chip includes multiple physical security mechanisms to make it tamper resistant, and malicious software is unable to tamper with the security functions of the TPM.|  
  
### Background  
Beginning with Windows 8, a Trusted Platform Module (TPM) can be used to secure a certificate's private key. The Microsoft Platform Crypto Provider Key Storage Provider (KSP) enables this feature. There were two concerns with the implementation:  

-   There was no guarantee that a key is actually protected by a TPM (someone can easily spoof a software KSP as a TPM KSP with local administrator credentials).

-   It was not possible to limit the list of TPMs that are allowed to protect enterprise issued certificates (in the event that the PKI Administrator wants to control the types of devices that can be used to obtain certificates in the environment).  

### TPM key attestation  
TPM key attestation is the ability of the entity requesting a certificate to cryptographically prove to a CA that the RSA key in the certificate request is protected by either "a" or "the" TPM that the CA trusts. The TPM trust model is discussed more in the [Deployment overview](../../../ad-ds/manage/component-updates/TPM-Key-Attestation.md#BKMK_DeploymentOverview) section later in this topic.  
  
### Why is TPM key attestation important?  
A user certificate with a TPM-attested key provides higher security assurance, backed up by non-exportability, anti-hammering, and isolation of keys provided by the TPM.  
  
With TPM key attestation, a new management paradigm is now possible: An administrator can define the set of devices that users can use to access corporate resources (for example, VPN or wireless access point) and have **strong** guarantees that no other devices can be used to access them. This new access control paradigm is **strong** because it is tied to a *hardware-bound* user identity, which is  stronger than a software-based credential.
  
### How does TPM key attestation work?  
In general, TPM key attestation is based on the following pillars:  
  
1.  Every TPM ships with a unique asymmetric key, called the *Endorsement Key* (EK), burned by the manufacturer. We refer to the public portion of this key as *EKPub* and the associated private key as *EKPriv*. Some TPM chips also have an EK certificate that is issued by the manufacturer for the EKPub. We refer to this cert as *EKCert*.  
  
2.  A CA establishes trust in the TPM either via EKPub or EKCert.  
  
3.  A user proves to the CA that the RSA key for which the certificate is being requested is cryptographically related to the EKPub and that the user owns the EKpriv.  
  
4.  The CA issues a certificate with a special issuance policy OID to denote that the key is now attested to be protected by a TPM.  
  
## <a name="BKMK_DeploymentOverview"></a>Deployment overview  
In this deployment, it is assumed that a Windows Server 2012 R2 enterprise CA is set up. Also, clients (Windows 8.1) are configured to enroll against that enterprise CA using certificate templates. 

There are three steps to deploying TPM key attestation:  
  
1.  **Plan the TPM trust model:** The first step is to decide which TPM trust model to use. There are 3 supported ways for doing this:  
  
    -   **Trust based on user credential:** The enterprise CA trusts the user-provided EKPub as part of the certificate request and no validation is performed other than the user's domain credentials.  
  
    -   **Trust based on EKCert:** The enterprise CA validates the EKCert chain that is provided as part of the certificate request against an administrator-managed list of *acceptable EK cert chains*. The acceptable chains are defined per-manufacturer and are expressed via two custom certificate stores on the issuing CA (one store for the intermediate and one for root CA certificates). This trust mode means that **all** TPMs from a given manufacturer are trusted. Note that in this mode, TPMs in use in the environment must contain EKCerts.
  
    -   **Trust based on EKPub:** The enterprise CA validates that the EKPub provided as part of the certificate request appears in an administrator-managed list of allowed EKPubs. This list is expressed as a directory of files where the name of each file in this directory is the SHA-2 hash of the allowed EKPub. This option offers the highest assurance level but requires more administrative effort, because each device is individually identified. In this trust model, only the devices that have had their TPM's EKPub added to the allowed list of EKPubs are permitted to enroll for a TPM-attested certificate.  
  
    Depending on which method is used, the CA will apply a different issuance policy OID to the issued certificate. For more details about issuance policy OIDs, see the Issuance Policy OIDs table in the [Configure a certificate template](../../../ad-ds/manage/component-updates/TPM-Key-Attestation.md#BKMK_ConfigCertTemplate) section in this topic.  
  
    Note that it is possible to choose a combination of TPM trust models. In this case, the CA will accept any of the attestation methods, and the issuance policy OIDs will reflect all attestation methods that succeed.  
  
2.  **Configure the certificate template:** Configuring the certificate template is described in the [Deployment details](../../../ad-ds/manage/component-updates/TPM-Key-Attestation.md#BKMK_DeploymentDetails) section in this topic. This article does not cover how this certificate template is assigned to the enterprise CA or how enroll access is given to a group of users. For more information, see [Checklist: Configure CAs to Issue and Manage Certificates](https://technet.microsoft.com/library/cc771533.aspx).  
  
3.  **Configure the CA for the TPM trust model**  
  
    1.  **Trust based on user credential:** No specific configuration is required.  
  
    2.  **Trust based on EKCert:** The administrator must obtain the EKCert chain certificates from TPM manufacturers, and import them to two new certificate stores, created by the administrator, on the CA that perform TPM key attestation. For more information, see the [CA configuration](../../../ad-ds/manage/component-updates/TPM-Key-Attestation.md#BKMK_CAConfig) section in this topic.  
  
    3.  **Trust based on EKPub:** The administrator must obtain the EKPub for each device that will need TPM-attested certificates and add them to the list of allowed EKPubs. For more information, see the [CA configuration](../../../ad-ds/manage/component-updates/TPM-Key-Attestation.md#BKMK_CAConfig) section in this topic.  
  
    > [!NOTE]  
    > -   This feature requires Windows 8.1/Windows Server 2012 R2.  
    > -   TPM key attestation for third-party smart card KSPs is not supported. Microsoft Platform Crypto Provider KSP must be used.  
    > -   TPM key attestation only works for RSA keys.  
    > -   TPM key attestation is not supported for a standalone CA.  
    > -   TPM key attestation does not support [non-persistent certificate processing](https://technet.microsoft.com/library/ff934598).  
  
## <a name="BKMK_DeploymentDetails"></a>Deployment details  
  
### <a name="BKMK_ConfigCertTemplate"></a>Configure a certificate template  
To configure the certificate template for TPM key attestation, do the following configuration steps:  
  
1.  **Compatibility** tab  
  
    In the **Compatibility Settings** section:  
  
    -   Ensure **Windows Server 2012 R2** is selected for the **Certification Authority**.  
  
    -   Ensure **Windows 8.1 / Windows Server 2012 R2** is selected for the **Certificate recipient**.  
  
    ![TPM Key attestation](media/TPM-Key-Attestation/GTR_ADDS_CompatibilityTab.gif)  
  
2.  **Cryptography** tab  
  
    Ensure **Key Storage Provider** is selected for the **Provider Category** and **RSA** is selected for the **Algorithm name**. Ensure **Requests must use one of the following providers** is selected and the **Microsoft Platform Crypto Provider** option is selected under **Providers**.  
  
    ![TPM Key attestation](media/TPM-Key-Attestation/GTR_ADDS_CryptoTab.gif)  
  
3.  **Key Attestation** tab  
  
    This is a new tab for Windows Server 2012 R2:  
  
    ![TPM Key attestation](media/TPM-Key-Attestation/GTR_ADDS_ConfigCertTemplate.gif)  
  
    Choose an attestation mode from the three possible options.  
  
    ![TPM Key attestation](media/TPM-Key-Attestation/GTR_ADDS_KeyModes.gif)  
  
    -   **None:** Implies that key attestation must not be used  
  
    -   **Required, if client is capable:** Allows users on a device that does not support TPM key attestation to continue enrolling for that certificate. Users who can perform attestation will be distinguished with a special issuance policy OID. Some devices might not be able to perform attestation because of an old TPM that does not support key attestation, or the device not having a TPM at all.
  
    -   **Required:** Client *must* perform TPM key attestation, otherwise the certificate request will fail.  
  
    Then choose the TPM trust model. There are again three options:  
  
    ![TPM Key attestation](media/TPM-Key-Attestation/GTR_ADDS_KeyTypeToEnforce.gif)  
  
    -   **User credentials:** Allow an authenticating user to vouch for a valid TPM by specifying their domain credentials.  
  
    -   **Endorsement certificate:** The EKCert of the device must validate through administrator-managed TPM intermediate CA certificates to an administrator-managed root CA certificate. If you choose this option, you must set up EKCA and EKRoot certificate stores on the issuing CA as described in the  [CA configuration](../../../ad-ds/manage/component-updates/TPM-Key-Attestation.md#BKMK_CAConfig) section in this topic.  
  
    -   **Endorsement Key:** The EKPub of the device must appear in the PKI administrator-managed list. This option offers the highest assurance level but requires more administrative effort. If you choose this option, you must set up an EKPub list on the issuing CA as described in the [CA configuration](../../../ad-ds/manage/component-updates/TPM-Key-Attestation.md#BKMK_CAConfig) section in this topic.  
  
    Finally, decide which issuance policy to show in the issued certificate. By default, each enforcement type has an associated object identifier (OID) that will be inserted into the certificate if it passes that enforcement type, as described in the following table. Note that it is possible to choose a combination of enforcement methods. In this case, the CA will accept any of the attestation methods, and the issuance policy OID will reflect all attestation methods that succeeded.  
  
    **Issuance Policy OIDs**  
  
    |OID|Key attestation type|Description|Assurance level|  
    |-------|------------------------|---------------|-------------------|  
    |1.3.6.1.4.1.311.21.30|EK|"EK Verified":   For administrator-managed list of EK|High|  
    |1.3.6.1.4.1.311.21.31|Endorsement certificate|"EK Certificate Verified": When EK certificate chain is validated|Medium|  
    |1.3.6.1.4.1.311.21.32|User credentials|"EK Trusted on Use": For user-attested EK|Low|  
  
    The OIDs will be inserted into the issued certificate if **Include Issuance Policies** is selected (the default configuration).  
  
    ![TPM Key attestation](media/TPM-Key-Attestation/GTR_ADDS_IssuancePolicies.gif)  
  
    > [!TIP]  
    > One potential use of having the OID present in the certificate is to limit access to VPN or wireless networking to certain devices. For example, your access policy might allow connection (or access to a different VLAN) if OID 1.3.6.1.4.1.311.21.30 is present in the certificate. This allows you to limit access to devices whose TPM EK is present in the EKPUB list.  
  
### <a name="BKMK_CAConfig"></a>CA configuration  
  
1.  **Setup EKCA and EKROOT certificate stores on an issuing CA**  
  
    If you chose **Endorsement Certificate** for the template settings, do the following configuration steps:  
  
    1.  Use Windows PowerShell to create two new certificate stores on the certification authority (CA) server that will perform TPM key attestation.  
  
    2.  Obtain the intermediate and root CA certificate(s) from manufacturer(s) that you want to allow in your enterprise environment. Those certificates must be imported into the previously-created certificate stores (EKCA and EKROOT) as appropriate.  
  
    The following Windows PowerShell script performs both of these steps. In the following example, the TPM manufacturer Fabrikam has provided a root certificate *FabrikamRoot.cer* and an issuing CA certificate *Fabrikamca.cer*.  
  
    ```powershell  
    PS C:>\cd cert:  
    PS Cert:\>cd .\\LocalMachine  
    PS Cert:\LocalMachine> new-item EKROOT  
    PS Cert:\ LocalMachine> new-item EKCA  
    PS Cert:\EKCA\copy FabrikamCa.cer .\EKCA  
    PS Cert:\EKROOT\copy FabrikamRoot.cer .\EKROOT  
    ```  
  
2.  **Setup EKPUB List if using EK attestation type**  
  
    If you chose **Endorsement Key** in the template settings, the next configuration steps are to create and configure a folder on the issuing CA, containing 0-byte files, each named for the SHA-2 hash of an allowed EK. This folder serves as an "allow list" of devices that are permitted to obtain TPM key-attested certificates. Because you must manually add the EKPUB for each and every device that requires an attested certificate, it provides the enterprise with a guarantee of the devices that are authorized to obtain TPM key attested certificates. Configuring a CA for this mode requires two steps:  
  
    1.  **Create the EndorsementKeyListDirectories registry entry:** Use the Certutil command-line tool to configure the folder locations where trusted EKpubs are defined as described in the following table.  
  
        |Operation|Command syntax|  
        |-------------|------------------|  
        |Add folder locations|certutil.exe -setreg CA\EndorsementKeyListDirectories +"<folder>"|  
        |Remove folder locations|certutil.exe -setreg CA\EndorsementKeyListDirectories -"<folder>"|  
  
        The EndorsementKeyListDirectories in certutil command is a registry setting as described in the following table.  
  
        |Value name|Type|Data|  
        |--------------|--------|--------|  
        |EndorsementKeyListDirectories|REG_MULTI_SZ|<LOCAL or UNC path to EKPUB allow list(s)><br /><br />Example:<br /><br />*\\\blueCA.contoso.com\ekpub*<br /><br />*\\\bluecluster1.contoso.com\ekpub*<br /><br />D:\ekpub|  
  
        HKLM\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\\<CA Sanitized Name>  
  
        *EndorsementKeyListDirectories* will contain a list of UNC or local file system paths, each pointing to a folder that the CA has Read access to. Each folder may contain zero or more allow list entries, where each entry is a file with a name that is the SHA-2 hash of a trusted EKpub, with no file extension. 
        Creating or editing this registry key configuration requires a restart of the CA, just like existing CA registry configuration settings. However, edits to the configuration setting will take effect immediately and will not require the CA to be restarted.  
  
        > [!IMPORTANT]  
        > Secure the folders in the list from tampering and unauthorized access by configuring permissions so that only authorized administrators have Read and Write access. The computer account of the CA requires Read access only.  
  
    2.  **Populate the EKPUB list:** Use the following Windows PowerShell cmdlet to obtain the public key hash of the TPM EK by using Windows PowerShell on each device and then send this public key hash to the CA and store it on the EKPubList folder.  
  
        ```powershell  
        PS C:>\$a=Get-TpmEndorsementKeyInfo -hashalgorithm sha256  
        PS C:>$b=new-item $a.PublicKeyHash -ItemType file  
        ```  
  
## Troubleshooting  
  
### Key attestation fields are unavailable on a certificate template  
The Key Attestation fields are not available if the template settings do not meet the requirements for attestation. Common reasons are:  
  
1.  The compatibility settings are not configured correctly. Make sure that they are configured as follows:  
  
    1.  **Certification Authority**: **Windows Server 2012 R2**  
  
    2.  **Certificate Recipient**: **Windows 8.1/Windows Server 2012 R2**  
  
2.  The cryptography settings are not configured correctly. Make sure that they are configured as follows:  
  
    1.  **Provider Category**: **Key Storage Provider**  
  
    2.  **Algorithm Name**: **RSA**  
  
    3.  **Providers**: **Microsoft Platform Crypto Provider**  
  
3.  The request handling settings are not configured correctly. Make sure that they are configured as follows:  
  
    1.  The **Allow private key to be exported** option must not be selected.  
  
    2.  The **Archive subject's encryption private key** option must not be selected.  
  
### Verification of TPM device for attestation  
Use the Windows PowerShell cmdlet, **Confirm-CAEndorsementKeyInfo**, to verify that a specific TPM device is trusted for attestation by CAs. There are two options: one for verifying the EKCert, and the other for verifying an EKPub. The cmdlet is either run locally on a CA, or on remote CAs by using Windows PowerShell remoting.  
  
1.  For verifying trust on an EKPub, do the following two steps:  
  
    1.  **Extract the EKPub from the client computer:** The EKPub can be extracted from a client computer via **Get-TpmEndorsementKeyInfo**. From an elevated command prompt, run the following:  
  
        ```  
        PS C:>\$a=Get-TpmEndorsementKeyInfo -hashalgorithm sha256  
        ```  
  
    2.  **Verify trust on an EKCert on a CA computer:** Copy the extracted string (the SHA-2 hash of the EKPub) to the server (for example, via email) and pass it to the Confirm-CAEndorsementKeyInfo cmdlet. Note that this parameter must be 64 characters.  
  
        ```  
        Confirm-CAEndorsementKeyInfo [-PublicKeyHash] <string>  
        ```  
  
2.  For verifying trust on an EKCert, do the following two steps:  
  
    1.  **Extract the EKCert from the client computer:** The EKCert can be extracted from a client computer via **Get-TpmEndorsementKeyInfo**. From an elevated command prompt, run the following:  
  
        ```  
        PS C:>\$a=Get-TpmEndorsementKeyInfo
        PS C:>\$a.manufacturerCertificates|Export-Certificate -filepath c:\myEkcert.cer
        ```  
  
    2.  **Verify trust on an EKCert on a CA computer:** Copy the extracted EKCert (EkCert.cer) to the CA (for example, via email or xcopy). As an example, if you copy the certificate file the "c:\diagnose" folder on the CA server, run the following to finish verification:  
  
        ```  
        PS C:>new-object System.Security.Cryptography.X509Certificates.X509Certificate2 "c:\diagnose\myEKcert.cer" | Confirm-CAEndorsementKeyInfo  
        ```  
  
## See Also  
[Trusted Platform Module Technology Overview](https://technet.microsoft.com/library/jj131725.aspx)  
[External Resource: Trusted Platform Module](http://www.cs.unh.edu/~it666/reading_list/Hardware/tpm_fundamentals.pdf)  

4.  If you provided any certificates to HGS using thumbprints, you will be instructed to grant HGS read access to the private key of those certificates. On a server installed with Desktop Experience, complete the following steps:

    1.  Open the local computer certificate manager (**certlm.msc**)
    2.  Find the certificate(s) > right-click > all tasks > manage private keys
    3.  Click **Add**
    4.  In the object picker window, click **Object types** and enable **service accounts**
    5.  Enter the name of the service account mentioned in the warning text from `Initialize-HgsServer`
    6.  Ensure the gMSA has "Read" access to the private key.

    On server core, you will need to download a PowerShell module to assist in setting the private key permissions.

    1.  Run `Install-Module GuardedFabricTools` on the HGS server if it has Internet connectivity, or run `Save-Module GuardedFabricTools` on another computer and copy the module over to the HGS server.
    2.  Run `Import-Module GuardedFabricTools`. This will add additional properties to certificate objects found in PowerShell.
    3.  Find your certificate thumbprint in PowerShell with `Get-ChildItem Cert:\LocalMachine\My`
    4.  Update the ACL, replacing the thumbprint with your own and the gMSA account in the code below with the account listed in the warning text of `Initialize-HgsServer`.

        ```powershell
        $certificate = Get-Item "Cert:\LocalMachine\1A2B3C..."
        $certificate.Acl = $certificate.Acl | Add-AccessRule "HgsSvc_1A2B3C" Read Allow
        ```

    If you are using HSM-backed certificates, or certificates stored in a third party key storage provider, these steps may not apply to you. Consult your key storage provider's documentation to learn how to manage permissions on your private key. In some cases, there is no authorization, or authorization is provided to the entire computer when the certificate is installed.

5.  That's it! In a production environment, you should continue to [add additional HGS nodes to your cluster](../../WindowsServerDocs/virtualization/guarded-fabric-shielded-vm/guarded-fabric-configure-additional-hgs-nodes.md). In a test environment, you can skip to [validating your HGS configuration](/WindowsServerDocs/virtualization/guarded-fabric-shielded-vm/guarded-fabric-verify-hgs-configuration.md).
    
    <!-- Appears in guarded-fabric-initialize-hgs-ad-mode-default.md and guarded-fabric-initialize-hgs-tpm-mode-default.md>
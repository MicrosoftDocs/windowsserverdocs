If you did not provide a PFX file for either the encryption or signing certificates on the first HGS server, only the public key will be replicated to this server.
You will need to install the private key by importing a PFX file containing the private key into the local certificate store or, in the case of HSM-backed keys, configuring the Key Storage Provider and associating it with your certificates per your HSM manufacturer's instructions.

<!-- Appears in guarded-fabric-initialize-hgs-ad-mode-default.md and guarded-fabric-initialize-hgs-tpm-mode-default.md
-->
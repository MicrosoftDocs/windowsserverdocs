With HGS joined to the domain, sign in with a domain account that has local administrator privileges.
Open an elevated PowerShell prompt and run the following command to join the existing HGS cluster.

```powershell
Initialize-HgsServer -HgsServerIPAddress <IP address of first HGS Server>
```

It will take up to 10 minutes for the encryption and signing certificates from the first HGS server to replicate to this node.

<!-- Appears twice in guarded-fabric-configure-additional-hgs-nodes.md 
-->
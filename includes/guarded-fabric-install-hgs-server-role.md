Add the Host Guardian Service role by using Server Manager or by running the following command in an elevated Windows PowerShell console:

```powershell
Install-WindowsFeature -Name HostGuardianServiceRole -IncludeManagementTools -Restart
```

<!-- Appears in guarded-fabric-install-hgs-default.md and guarded-fabric-install-hgs-in-a-bastion-forest.md
-->
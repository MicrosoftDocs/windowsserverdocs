The Host Guardian Service should be installed in a separate Active Directory forest.

Ensure that the HGS machine is **not** joined to a domain before you start.

In an elevated Windows PowerShell console, run the following commands to install the Host Guardian Service and configure its domain.
The password you specify here will only apply to the Directory Services Restore Mode password for Active Directory; it will *not* change your admin account's login password.
You may provide any domain name of your choosing for -HgsDomainName.

```powershell
$adminPassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

Install-HgsServer -HgsDomainName 'relecloud.com' -SafeModeAdministratorPassword $adminPassword -Restart
```

After the computer restarts, log in as Domain Admin.

<!-- Appears in guarded-fabric-install-hgs-default.md and set-up-hgs-for-always-encrypted-in-sql-server.md
-->

The Host Guardian Service should be installed in a separate Active Directory forest than the Hyper-V hosts and fabric managers.
If a secure bastion forest is not already available in your environment, follow these steps to have HGS set up one for you.

Ensure that the HGS machine is **not** joined to a domain before you start.

1.  In an elevated Windows PowerShell console, run the following commands to install the Host Guardian Service and configure its domain.
The password you specify here will only apply to the Directory Services Restore Mode password for Active Directory; it will *not* change your admin account's login password.
You may provide any domain name of your choosing to the `-HgsDomainName` parameter.

    ```powershell
    $adminPassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

    Install-HgsServer -HgsDomainName 'relecloud.com' -SafeModeAdministratorPassword $adminPassword -Restart
    ```

2.  After the computer restarts, log in as the domain administrator.

<!-- Appears in guarded-fabric-install-hgs-default.md and set-up-hgs-for-always-encrypted-in-sql-server.md
-->

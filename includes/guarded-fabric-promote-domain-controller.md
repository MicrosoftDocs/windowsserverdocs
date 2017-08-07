1.  Run [Install-HgsServer](https://technet.microsoft.com/itpro/powershell/windows/hgsserver/install-hgsserver) to join the domain and promote the node to a domain controller.

    ```powershell
    $adSafeModePassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

    $cred = Get-Credential 'relecloud\Administrator'

    Install-HgsServer -HgsDomainName 'relecloud.com' -HgsDomainCredential $cred -SafeModeAdministratorPassword $adSafeModePassword -Restart
    ```

2.  When the server reboots, log in with a domain administrator account.

<!-- Appears twice in guarded-fabric-configure-additional-hgs-nodes.md 
-->
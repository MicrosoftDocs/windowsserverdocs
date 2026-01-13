---
ms.topic: include
ms.date: 12/29/2025
---

```powershell
# Add the module to the current session
Import-Module "$env:ProgramFiles\WindowsAdminCenter\PowerShellModules\Microsoft.WindowsAdminCenter.ExtensionTools\Microsoft.WindowsAdminCenter.ExtensionTools.psd1"
# Available cmdlets: Get-Feed, Add-Feed, Remove-Feed, Get-Extension, Install-Extension, Uninstall-Extension, Update-Extension

# List feeds
Get-WACFeed -Endpoint "https://wac.contoso.com"

# Add a new extension feed
Add-WACFeed -Endpoint "https://wac.contoso.com" -Feed "\\WAC\our-private-extensions"

# Remove an extension feed
Remove-WACFeed -Endpoint "https://wac.contoso.com" -Feed "\\WAC\our-private-extensions"

# List all extensions
Get-WACExtension -Endpoint "https://wac.contoso.com"

# Install an extension (locate the latest version from all feeds and install it)
Install-WACExtension -Endpoint "https://wac.contoso.com" -ExtensionID "msft.sme.containers"

# Install an extension (latest version from a specific feed, if the feed is not present, it will be added)
Install-WACExtension -Endpoint "https://wac.contoso.com" -ExtensionID "msft.sme.containers" -Feed "https://aka.ms/sme-extension-feed"

# Install an extension (install a specific version)
Install-WACExtension -Endpoint "https://wac.contoso.com" -ExtensionID "msft.sme.certificate-manager" -Version "0.133.0"

# Uninstall-Extension
Uninstall-WACExtension -Endpoint  "https://wac.contoso.com" -ExtensionID "msft.sme.containers"

# Update-Extension
Update-WACExtension -Endpoint "https://wac.contoso.com" -ExtensionID "msft.sme.containers"

# Update all extensions
Get-WACExtension -Endpoint "https://wac.contoso.com" | ForEach-Object {Update-WACExtension -Endpoint "https://wac.contoso.com" -ExtensionId $_.id}
```

> [!NOTE]
> You must be gateway administrator to modify Windows Admin Center extensions with PowerShell.

---
title: Merge applocker Policies by Using Set-applockerPolicy
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f8bb7eda-ae62-47fb-b672-1d816374b494
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Merge applocker Policies by Using Set-applockerPolicy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to merge applocker policies by using Windows PowerShell in  Windows Server 2012  and Windows 8.

The **Set-applockerPolicy** cmdlet sets the specified Group Policy Object (GPO) to contain the specified applocker policy. If no Lightweight Directory Access Protocol (LDAP) is specified, the local GPO is the default. When the Merge parameter is used, rules in the specified applocker policy will be merged with the applocker rules in the target GPO specified in the LDAP path. The merging of policies will remove rules with duplicate rule IDs, and the enforcement setting specified by the applocker policy in the target GPO will be preserved. If the Merge parameter is not specified, then the new policy will overwrite the existing policy.

For information about using **Set-applockerPolicy**, including syntax descriptions and parameters, see [Set-applockerPolicy](http://go.microsoft.com/fwlink/?LinkId=169167) (http://go.microsoft.com/fwlink/?LinkId=169167).

For information about using Windows PowerShell for applocker, including how to import the applocker cmdlets into Windows PowerShell, see [Use the applocker Windows PowerShell Cmdlets](../use-the-applocker-windows-powershell-cmdlets.md).

You can also manually merge applocker policies. For the procedure to do this, see [Merge applocker Policies Manually](merge-applocker-policies-manually.md).

#### To merge a local applocker policy with another applocker policy by using LDAP paths

1.  Open the PowerShell command window. For information about performing Windows PowerShell commands for applocker, see [Use the applocker Windows PowerShell Cmdlets](../use-the-applocker-windows-powershell-cmdlets.md).

2.  At the command prompt, type **C:\PS>Get-applockerPolicy -Local | Set-applockerPolicy -LDAP "LDAP: //***<string>***" -Merge** where *<string>* specifies the LDAP path of the unique GPO.

## Example
Gets the local applocker policy, and then merges the policy with the existing applocker policy in the GPO specified in the LDAP path.

```
C:\PS>Get-applockerPolicy -Local | Set-applockerPolicy -LDAP "LDAP://DC13.Contoso.com/CN={31B2F340-016D-11D2-945F-00C044FB984F9},CN=Policies,CN=System,DC=Contoso,DC=com" -Merge
```



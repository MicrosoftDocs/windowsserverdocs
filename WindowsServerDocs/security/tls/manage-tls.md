---
title: Manage Transport Layer Security (TLS) in Windows Server
description: Learn how to manage the Transport Layer Security (TLS) cipher suite order in Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.contributor: alalve 
ms.date: 04/17/2025
ms.custom: sfi-image-nochange
---

# Manage Transport Layer Security (TLS)

## Configure TLS cipher suite order

A cipher suite is a set of cryptographic algorithms. Different Windows versions support different TLS cipher suites and priority order. See [Cipher Suites in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/cipher-suites-in-schannel) for the default order supported by the Microsoft Schannel Provider in different Windows versions.

> [!NOTE]
> You can also modify the list of cipher suites by using CNG functions, see [Prioritizing Schannel Cipher Suites](/windows/win32/secauthn/prioritizing-schannel-cipher-suites) for details.

Changes to the TLS cipher suite order take effect on the next boot. Until restart or shutdown, the existing order is in effect.

> [!WARNING]
> Updating the registry settings for the default priority ordering isn't supported and may be reset with servicing updates.

### Configure TLS cipher suite order by using Group Policy

You can use the SSL cipher suite order Group Policy settings to configure the default TLS cipher suite order.

1. From the Group Policy Management Console, go to **Computer Configuration** > **Administrative Templates** > **Network** > **SSL Configuration Settings**.
1. Double-click **SSL Cipher Suite Order**, and then select the **Enabled** option.
1. Right-click **SSL Cipher Suites** box and select **Select all** from the pop-up menu.

   ![Group Policy setting](../media/Transport-Layer-Security-protocol/ssl-cipher-suite-order-gp-setting.png)

1. Right-click the selected text, and select **copy** from the pop-up menu.
1. Paste the text into a text editor such as notepad.exe and update with the new cipher suite order list.

   > [!NOTE]
   > The TLS cipher suite order list must be in strict comma delimited format. Each cipher suite string ends with a comma to the right side of it. Additionally, the list of cipher suites is limited to 1,023 characters.

1. Replace the list in the **SSL Cipher Suites** with the updated ordered list.
1. Select **OK** or **Apply**.

### Configure TLS cipher suite order by using MDM

The Windows 10 Policy CSP supports configuration of the TLS Cipher Suites. For more information, see [Cryptography/TLSCipherSuites](/windows/client-management/mdm/policy-csp-cryptography#cryptography-tlsciphersuites).

### Configure TLS cipher suite order by using TLS PowerShell Cmdlets

The TLS PowerShell module supports getting the ordered list of TLS cipher suites, disabling a cipher suite, and enabling a cipher suite. For more information, see [TLS Module](/powershell/module/tls/).

## Configure TLS ECC curve order

Beginning with Windows 10 and Windows Server 2016, ECC curve order can be configured independent of the cipher suite order. If the TLS cipher suite order list has elliptic curve suffixes, they'll be overridden by the new elliptic curve priority order, when enabled. This allows organizations to use a Group Policy object to configure different versions of Windows Server with the same cipher suites order.

### Manage ECC curves using CertUtil

Beginning with Windows 10 and Windows Server 2016, Windows provides elliptic curve parameter management through the command line utility **certutil.exe**. Elliptic curve parameters are stored in the bcryptprimitives.dll. Administrators can add, and remove curve parameters to and from Windows Server using certutil.exe. Certutil.exe stores the curve parameters securely in the registry.
Windows Server can begin using the curve parameters by the name associated with the curve.

#### Display registered curves

Use the following certutil.exe command to display a list of curves registered for the current computer.

```powershell
certutil.exe –displayEccCurve
```

![Certutil display curves](../media/Transport-Layer-Security-protocol/certutil-display-curves.png)

#### Add a new curve

Organizations can create and use curve parameters researched by other trusted entities. Administrators wanting to use these new curves in Windows must add the curve. Use the following certutil.exe command to add a curve to current computer:

```powershell
Certutil —addEccCurue curveName curveParameters [curveOID] [curveType]
```

- The **curveName** argument represents the name of the curve under which the curve parameters were added.
- The **curveParameters** argument represents the filename of a certificate that contains the parameters of the curves you want to add.
- The **curveOid** argument represents a filename of a certificate that contains the OID of the curve parameters you want to add (optional).
- The **curveType** argument represents a decimal value of the named curve from the [EC Named Curve Registry](https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-8) (optional).

![Certutil add curves](../media/Transport-Layer-Security-protocol/certutil-add-curves.png)

#### Remove a previously added curve

Administrators can remove a previously added curve using the following certutil.exe command:

```powershell
certutil.exe –deleteEccCurve curveName
```

Windows can't use a named curve after an administrator removes the curve from computer.

## Manage ECC curves using Group Policy

Organizations can distribute curve parameters to enterprise, domain-joined, computer using Group Policy and the Group Policy Preferences Registry extension. The process for distributing a curve is:

1. Use **certutil.exe** to add a new registered named curve.
1. From that same computer, Open the Group Policy Management Console (GPMC), create a new Group Policy object, and edit it.
1. Navigate to **Computer Configuration|Preferences|Windows Settings|Registry**. Right-click **Registry**. Hover over **New** and select **Collection Item**. Rename the collection item to match the name of the curve. You create one Registry Collection item for each registry key under *HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Cryptography\ECCParameters*.
1. Configure the newly created Group Policy Preference Registry Collection by adding a new **Registry Item** for each registry value listed under *HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Cryptography\ECCParameters\[curveName]*.
1. Deploy the Group Policy object containing Group Policy Registry Collection item computers that should receive the new named curves.

    ![Screenshot of the Preferences tab of the Group Policy Management Editor.](../media/Transport-Layer-Security-protocol/gpp-distribute-curves.png)

## Manage TLS ECC order

Beginning with Windows 10 and Windows Server 2016, ECC Curve Order group policy settings can be used to configure the default TLS ECC Curve Order. Organizations can add their own trusted named curves to the operating system, and then add those named curves to the curve priority Group Policy setting to ensure they're used in future TLS handshakes. New curve priority lists become active on the next reboot after receiving the policy settings.

![Screenshot of the EEC Curve Order dialog box.](../media/Transport-Layer-Security-protocol/gp-managing-tls-curve-priority-order.png)


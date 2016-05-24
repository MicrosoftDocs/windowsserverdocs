---
title: Certificate Manager for non-admins
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a59e658-7c7b-470e-aab4-e8a025061c74
author: rkarlin
---
# Certificate Manager for non-admins
If a user isn’t a local administrator on their computer, they won’t be able to renew a smartcard on their own machines. The following procedure enables you to work around this limitation.  
  
## Enabling smartcard renewal for non\-admins in MIM 2016 Certificate Manager  
  
1.  **Unpack the appx file**  
  
    Obtain a signing certificate. You can follow the steps to create one using AD CS [here](http://blogs.technet.com/b/deploymentguys/archive/2013/06/14/signing-windows-8-applications-using-an-internal-pki.aspx). Stop when you get to “Sign the Application”. Name the exported pfx file. Export to a .cer file as well, and import it to the client by following steps 11.2\-11.6 using the cer file of the new signing certificate.  
  
    Run the following to unpack the appx file: `makeappx unpack /l /p <app package name>.appx /d ./appx`  
  
    `ren <app package name>.appx <app package name>.appx.old`  
  
    `cd appx`  
  
2.  **Modify the configuration file**  
  
    Rename the file named CustomDataExample.xml `custom.data`. The modern app will look for this file name.  
  
    Edit the custom.data file and modify the following:  
  
    1.  In the <ADFS> element modify the value of the URL attribute to an empty string.  
  
    2.  In the <MIMCM> element modify the value of the URL attribute to "https:\/\/MIMCMServer.corp.contoso.com \/CertificateManagement”  
  
    3.  In the <NonAdmin> element, change the value of the Value attribute to "True"  
  
    4.  Save the file and exit editor  
  
    5.  Delete the file named AppxSignature.p7x  
  
    6.  Edit the file named AppxManifest.xml  
  
    7.  In the <Identity> element modify the value of the Publisher attribute to the subject of your signing certificate, e.g. "CN\=ABCD"  
  
        The subject here should be the same as the subject in the signing certificate you’re using to sign the app.  
  
    8.  Save the file and exit editor.  
  
3.  **Re\-pack and sign the app package \(appx file\)**  
  
    Run the following to pack and sign the the appx file:  
  
    `cd ..`  
  
    `makeappx pack /l /d .\appx /p <app package name>.appx`  
  
    `signtool sign /f <path\>mysign.pfx /p <pfx password> /fd "sha256" <app package name>.appx`  
  
4.  **Configure the MIM server**  
  
5.  **Create a non\-admin account on the client machine**  
  
6.  **Create a virtual smartcard using TpmVscMgr**  
  
    Perform the following \(still as the admin\) to create an empty virtual smartcard on a machine. This can be done through Intune, SCCM or group policies.  
  
    `TpmVscMgr create /name MyVSC /pin default /adminkey default /generate`  
  
7.  **Duplicate the profile template and adding the initial admin key**  
  
    When the profile template general settings appear, scroll down all the way. Under **Smartcard Configuration**, click **Change Settings**.  
  
    Under Admin key initial value \(hex\) enter the default admin key: "010203040506070801020304050607080102030405060708"  
  
    Scroll down and click **OK**.  
  
8.  **Install the modern app in the non\-admin account**  
  
9. **Launch the modern app and enrolling for a virtual smartcard**  
  

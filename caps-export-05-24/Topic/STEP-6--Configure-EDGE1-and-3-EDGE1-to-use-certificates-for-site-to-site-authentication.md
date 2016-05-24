---
title: STEP 6: Configure EDGE1 and 3-EDGE1 to use certificates for site-to-site authentication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d29796bb-6c73-4bca-be44-35cdb41fca08
author: coreyp
---
# STEP 6: Configure EDGE1 and 3-EDGE1 to use certificates for site-to-site authentication
  
## Configure computer certificate authentication on EDGE1  
  
#### To configure computer certificate authentication on EDGE1  
  
1.  In **Routing and Remote Access**, right click **EDGE1\(local\)**. Click **Properties**.  
  
2.  In the **Security** tab, click **Authentication Methods**. Check **Allow machine certificate authentication for IKEv2**.  
  
3.  Click **OK** twice.  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
PS C:\> $cert1 = ( Get-ChildItem -Path cert:LocalMachine\root | Where-Object -FilterScript { $_.Subject -Like "*CN=Contoso Root Certification Authority,*" } )  
  
Set-VpnAuthProtocol -UserAuthProtocolAccepted Certificate -RootCertificateNameToAccept $cert1 -PassThru  
```  
  
> [!NOTE]  
> This change is applicable to both L2TP and IKEv2 VPN \(site\-to\-site and Remote Accesss\) connections as well. If you change the authentication method on the server from certificates to pre\-shared key, it impacts VPN client connections as well. If a server is configured to advertise only pre\-shared key, VPN clients validating the server using certificates will fail to authenticate the server.  
  
## Configure name resolution  
  
#### To configure name resolution  
  
1.  In the **Start** screen, type **notepad**, right\-click **Notepad** and then click **Run as administrator**.  
  
2.  Click **Yes** in the **User Account Control** dialog.  
  
3.  In **Notepad**, click **File** and then click **Open**.  
  
4.  In the **Open** dialog, change **file type** to **All Files**. Navigate to **C:\/Windows\/System32\/drivers\/etc**.  
  
5.  Open the **hosts** file.  
  
6.  Go to end of the hosts file and type, **131.107.0.4 3\-EDGE1.corp.fabrikam.com**.  
  
7.  Close the file and click **Save** when prompted.  
  
## Export the root certificate \(corp\-DC1\-CA\) from EDGE1  
  
#### To Export the root certificate \(corp\-DC1\-CA\) from EDGE1  
  
1.  On EDGE1, click **Start**, type **mmc**, and then click **mmc**. Click **Yes** at the **User Account Control** prompt.  
  
2.  Click **File**, and then click **Add\/Remove Snap\-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, select **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the **Certificates** snap\-in, open **Certificates \(Local Computer\)\\Trusted Root Certification Authorities\\Certificates**.  
  
5.  Right click **corp\-DC1\-CA**. Point to **All Tasks** and click **Export**.  
  
6.  On **Certificate Export Wizard**, click **Next** twice. Click **Browse** and select **Desktop**. In **File Name** box type **DC1cert**. Click **OK**.  
  
7.  Click **Next** and then click **Finish**.  
  
8.  Click **OK** on the dialog indicating the export was successful.  
  
9. Go to **Desktop**. Right\-click **DC1cert**, point to **Share with** and click **Specific people**.  
  
10. In **File Sharing** dialog, select **Everyone** from dropdown list. Click **Share**. Click **Done**.  
  
    > [!WARNING]  
    > It is not advisable to share this file with everyone in a non\-test production environment.  
  
## Configure computer certificate authentication on 3\-EDGE1  
  
#### To configure computer certificate authentication on 3\-EDGE1  
  
1.  In **Routing and Remote Access**, right click **3\-EDGE1\(local\)**. Click **Properties**.  
  
2.  In the **Security** tab, click **Authentication Methods**. Check **Allow machine certificate authentication for IKEv2**  
  
3.  Click **OK** twice.  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
PS C:\> $cert1 = ( Get-ChildItem -Path cert:LocalMachine\root | Where-Object -FilterScript { $_.Subject -Like "*CN=Contoso Root Certification Authority,*" } )  
  
Set-VpnAuthProtocol -UserAuthProtocolAccepted Certificate -RootCertificateNameToAccept $cert1 -PassThru  
```  
  
> [!NOTE]  
> This change is applicable to both L2TP and IKEv2 VPN \(site\-to\-site and Remote Accesss\) connections as well. If you change the authentication method on the server from certificates to pre\-shared key, it impacts VPN client connections as well. If a server is configured to advertise only pre\-shared key, VPN clients validating the server using certificates will fail to authenticate the server.  
  
## Configure name resolution  
  
#### To configure name resolution  
  
1.  In the **Start** screen, type **notepad**, right\-click **Notepad** and then click **Run as administrator**.  
  
2.  Click **Yes** in the **User Account Control** dialog.  
  
3.  In **Notepad**, click **File** and then click **Open**.  
  
4.  In the **Open** dialog, change **file type** to **All Files**. Navigate to **C:\/Windows\/System32\/drivers\/etc**.  
  
5.  Open the **hosts** file.  
  
6.  Go to end of the hosts file and type, **131.107.0.2 3\-EDGE1.corp.contoso.com**.  
  
7.  Close the file and click **Save** when prompted.  
  
## Export the root certificate \(corp\-3\-DC1\-CA\) from 3\-EDGE1  
  
#### To Export the root certificate \(corp\-3\-DC1\-CA\) from 3\-EDGE1  
  
1.  On 3\-EDGE1, click **Start**, type **mmc**, and then click **mmc**. Click **Yes** at the **User Account Control** prompt.  
  
2.  Click **File**, and then click **Add\/Remove Snap\-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, select **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the **Certificates** snap\-in, open **Certificates \(Local Computer\)\\Trusted Root Certification Authorities\\Certificates**.  
  
5.  Right click **corp\-3\-DC1\-CA**. Point to **All Tasks** and click **Export**.  
  
6.  On **Certificate Export Wizard**, click **Next** twice. Click **Browse** and select **Desktop**. In **File Name** box type **3\-DC1cert**. Click **OK**.  
  
7.  Click **Next** and then click **Finish**.  
  
8.  Click **OK** on the dialog indicating the export was successful.  
  
9. Go to **Desktop**. Right\-click **3\-DC1cert**, point to **Share with** and click **Specific people**.  
  
10. In **File Sharing** dialog, select **Everyone** from dropdown list. Click **Share**. Click **Done**.  
  
    > [!WARNING]  
    > It is not advisable to share this file with everyone in a non\-test production environment.  
  
## Import the root certificate \(corp\-DC1\-CA\) to 3\-EDGE1  
  
#### To Import the root certificate \(corp\-DC1\-CA\) to 3\-EDGE1  
  
1.  On 3\-EDGE1, click **Start**, type **mmc**, and then click **mmc**. Click **Yes** at the **User Account Control** prompt.  
  
2.  Click **File**, and then click **Add\/Remove Snap\-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, select **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the **Certificates** snap\-in, open **Certificates \(Local Computer\)\\Trusted Root Certification Authorities**.  
  
5.  Right click **Trusted Root Certification Authorities**, point to **All Tasks** and click **Import**.  
  
6.  On **Certificate Import Wizard**, click **Next**. Click **Browse**. In the address bar in **Open** dialog type **\\\\131.107.0.2\\Users\\Desktop** and press **Enter**. Select **DC1cert** and click **Open**.  
  
7.  Click **Next** twice and then click **Finish**.  
  
## Change the authentication method to certificates on EDGE1  
  
#### To Change the authentication method to certificates on EDGE1  
  
1.  In the **Routing and Remote Access** snap\-in, expand **EDGE1**, and then click **Network Interfaces**.  
  
2.  Right\-click **3\-EDGE1.corp.fabrikam.com** and then click **Properties**.  
  
3.  Click the **Security** tab, select **Use machine certificates**, and then click **Verify the Name and Usage attributes of the server’s certificate**.  
  
4.  Click **OK**.  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
$cert1 = Get-ChildItem -Path cert:LocalMachine\My | Where-Object –FilterScript { $_.Subject -Like "*CN edge1.contoso.com*" }  
Set-VpnS2SInterface –Name edge1 -AuthenticationMethod MachineCertificates -Certificate $cert1 -ResponderAuthenticationMethod MachineCertificates -Protocol IKEv2  
```  
  
## Change the authentication method to certificates on 3\-EDGE1  
  
#### To Change the authentication method to certificates on 3\-EDGE1  
  
1.  In the **Routing and Remote Access** snap\-in, expand **3\-EDGE1**, and then click **Network Interfaces**.  
  
2.  Right\-click **EDGE1.corp.contoso.com** and then click **Properties**.  
  
3.  Click the **Security** tab, select **Use machine certificates**, and then click **Verify the Name and Usage attributes of the server’s certificate**.  
  
4.  Click **OK**.  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
$cert1 = Get-ChildItem -Path cert:LocalMachine\My | Where-Object –FilterScript { $_.Subject -Like "*CN=3-edge1.contoso.com*" }  
Set-VpnS2SInterface –Name 3-edge1 -AuthenticationMethod MachineCertificates -Certificate $cert1 -ResponderAuthenticationMethod MachineCertificates -Protocol IKEv2  
```  
  
## Reinitiate the site\-to\-site connection  
  
#### To Reinitiate the site\-to\-site connection  
  
1.  On **3\-EDGE1**, in the console tree of the **Routing and Remote Access** snap\-in, click **Network Interfaces**.  
  
2.  In the **Details** pane, right\-click **EDGE1.corp.contoso.com**, and then click **Connect**.  
  
3.  Confirm that the connection state of **VPN\_Corpnet** is connected.  
  
## Test the site\-to\-site connection  
  
#### To Test the site\-to\-site connection  
  
1.  On **DC1** at the **Start** menu, type **cmd** and then hit **Enter**. At the command prompt, type **ping 10.6.0.2**. Verify that there are four replies from 10.6.0.2  
  

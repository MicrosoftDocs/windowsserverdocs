---
title: Publishing RDG with Web Application Proxy
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8e8da935-59b9-4765-8036-e46374fa7e71
author: Rkarlin
robots: noindex,nofollow
---
# Publishing RDG with Web Application Proxy
Remote Desktop Gateway makes it possible to access Remote Desktop Services applications over the Internet from a client that doesn’t use UDP. If you want to restrict access to your Remote Desktop Gateway and add preauthentication for remote access, you can roll RDG out through [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]. This is a really good way to make sure you have rich preauthentication for RDG, including MFA and gives you a single point of entry into the system \(even if you don’t use the preauthentication feature\).

On Windows Client, RDG has an ActiveX control in Internet Explorer that launches the .rdp file using the remote desktop client on the user’s computer. The RDG protocol is RDP over HTTP.

The process for publishing RDG through Web Application Proxy is pretty complicated. These instructions give you the basics, but if you have trouble you should definitely [take a look at our blog](http://blogs.technet.com/b/applicationproxyblog/)to get some additional guidance.

## Publishing using passthrough

> [!NOTE]
> If you need to support Rich Clients such as RemoteApp and Desktop Connections or iOS Remote Desktop connections, these do not support preauthentication so you would need to publish RDG using passthrough authentication.

The installation is different depending on whether your RD Web Access and your RD Gateway roles are hosted on the same RDG server or on different servers.

-   It’s common to have the RD Web Access and the RD Gateway hosted on the same server which then acts as a front end server for the RDG solution. In this case, use either the root FQDN as the URL that you enter for the application in the Web Application Proxy or you can publish the two virtual directories individually.

-   If the RD Web Access and the RD Gateway are hosted on separate RDG servers, you have to publish the two virtual directories individually, and then, in Web Application Proxy, use two separate publishing URLs.

## Publishing using preauthentication
Supporting RDG through [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] can work, but there are a number of steps you have to take to make sure that it’ll work. Even after the below procedure, your users will get two forms\-based authorizations at the beginning, but won’t be prompted to authenticate again. The problem is that the mstsc server needs to utilize the Web Application Proxy authentication cookie obtained through the browser. In order to do that, we have to make sure to tell the Collection server to include the custom RDP properties in the RDP files that are sent to clients. These then tell the client that preauthentication is require and gets the client to pass the cookies for the preauth server address mstsc. Then it is necessary to disable the HttpOnly cookie on the Web Application Proxy published application to allow mstsc to utilize the Web Application Proxy authentication cookie obtained in the browser. That’s a lot to process, and you don’t really have to understand it, you really only need to make sure to do the following:

1.  Make sure that the RD Web Access and the RD Gateway roles are hosted on the same RDG server so that they use a single cookie for access. It’s also crucial that you publish RDG as a claims aware application, even though it’s a non\-claims aware application. This means that you have to create a dummy relying party trust that just enforces preauthentication.

2.  Create a Relying Party Trust in AD FS as if you were publishing a Claims Aware application. This will enable you to get preauthentication to the published RDG server without Kerberos Constrained Delegation.

    Logically, you might think that it would be better to use KCD, but because it doesn’t fully solve the single\-sign\-on requirements of mstsc, it causes issues when delegating to the \/rpc directory since the client expects to handle the RD Gateway authentication itself. Follow these steps to create a Relying Party Trust in the AD FS Management Console:

    1.  Open the **Add Relying Party Trust** wizard.

    2.  Select **Enter data about the relying party manually**.

    3.  Accept all the default settings.

    4.  For the **Relying Party Trust identifier**, enter the external FQDN that you will use for RDG access \(for example, https:\/\/rdg.contoso.com\)

        This is the Relying Party Trust you will use when you publish RDG in [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)].

3.  In order to make sure that \/rdweb and \/rpc use the same [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] authentication cookie, publish RDG like any other app in [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)], using the RDG URL \(for example, https:\/\/rdg.contoso.com\) and setting AD FS preauthentication with the Relying Party Trust you created.

4.  You have to Disable HttpOnly to allow the RDG ActiveX control to access the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]authentication cookie. To do this, first make sure to update [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] to include the fix that introduces the HttpOnly parameter: [HTTPOnly update](http://support2.microsoft.com/kb/2982037) or install the Windows Rollup from November 2014 or later.

    Then, disable the HttpOnly cookie property in Web Application Proxy for the RDG application. You can do this in PowerShell using the following command:

    `Get-WebApplicationProxyApplication “Application Name” | Set-WebApplicationProxyApplication -DisableHttpOnlyCookieProtection:$True`

5.  Now, in order for all this to work, mstsc has to pass this preauthentication cookie when it sends its requests for access to the RDG server. So you have to configure the RDG Collection to let the mstsc client know that preauthentication is required by the rdp file. To accomplish this, follow this procedure. For more information on RDP, see [Configuring the TS Gateway OTP Scenario](https://technet.microsoft.com/en-us/library/cc731249(v=ws.10).aspx).

    -   In Windows Server 2012 and Windows Server 2012 R2 this can be accomplished by running this PowerShell cmdlet on the RDG Collection server:

        `Set-RDSessionCollectionConfiguration -CollectionName "<yourcollectionname>" -CustomRdpProperty "pre-authentication server address:s: <https://rdg.contoso.com/rdweb/> `n require pre-authentication:i:1"`

    -   In Windows Server 2008 R2 do this:

        1.  Log onto the terminal server \(“contoso\-ts.contoso.com”\) with an account that has Administrator privileges.

        2.  Go to **Start** > **Administrative Tools** > **Terminal Services** > **TS RemoteApp Manager**.

        3.  In the **Overview** pane of TS RemoteApp Manager, next to RDP settings, click Change.

        4.  On the **Custom RDP Settings** tab, type or copy the following RDP settings into the Custom RDP settings box:

            `pre-authentication server address: s: https://www.contoso.com/rdweb/`

            `require pre-authentication:i:1`

        5.  Click **Apply**.



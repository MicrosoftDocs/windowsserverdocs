---
description: "Learn more about: Import a Server Authentication Certificate to the Default Web Site"
ms.assetid: e1f2ce2d-b24f-4ccd-8add-9e69419fc6c1
title: Import a Server Authentication Certificate to the Default Web Site
author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.author: billmath
---

# Import a Server Authentication Certificate to the Default Web Site

After you obtain a server authentication certificate from a certification authority \(CA\), you must manually install that certificate on the Default Web Site for each federation server or federation server proxy in a server farm.

For Web servers, you must manually install the server authentication certificate on the appropriate Web site or virtual directory where your federated application resides.

If you are setting up a farm, be sure to perform this procedure identically—using the exact same settings—on each of the servers in your farm.

> [!NOTE]
> The AD FS Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.

Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

### To import a server authentication certificate to the Default Web Site

1.  On the **Start** screen, type**Internet Information Services \(IIS\) Manager**, and then press ENTER.

2.  In the console tree, click **ComputerName**.

3.  In the center pane, double\-click **Server Certificates**.

4.  In the **Actions** pane, click **Import**.

5.  In the **Import Certificate** dialog box, click the **…** button.

6.  Browse to the location of the pfx certificate file, highlight it, and then click **Open**.

7.  Type a password for the certificate, and then click **OK**.

## Additional references
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)

[Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md)

[Certificate Requirements for Federation Servers](../design/certificate-requirements-for-federation-servers.md)

[Certificate Requirements for Federation Server Proxies](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dd807054(v=ws.11))

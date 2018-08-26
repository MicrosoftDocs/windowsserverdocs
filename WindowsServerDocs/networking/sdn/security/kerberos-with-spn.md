---
title: Kerberos with Service Principal Name (SPN)
description: Network Controller supports multiple authentication methods for communication with management clients. You can use Kerberos based authentication, X509 certificate-based authentication. You also have the option to use no authentication for test deployments. 
manager: elizapo
ms.prod: windows-server-threshold
ms.technology: networking-sdn
ms.topic: article
ms.assetid: bc625de9-ee31-40a4-9ad2-7448bfbfb6e6
ms.author: pashort
author: shortpatti
ms.date: 08/23/2018
---

# Kerberos with Service Principal Name (SPN)

>Applies to: Windows Server 2019

Network Controller supports multiple authentication methods for communication with management clients. You can use Kerberos based authentication, X509 certificate-based authentication. You also have the option to use no authentication for test deployments.

System Center Virtual Machine Manager uses Kerberos-based authentication. If you are using Kerberos-based  authentication, you must configure a Service Principal Name (SPN) for Network Controller in Active Directory. The SPN is a unique identifier for the Network Controller service instance, which is used by Kerberos authentication to associate a service instance with a service login account. For more details, see [Service Principal Names](https://docs.microsoft.com/en-us/windows/desktop/ad/service-principal-names).

## Configure Service Principal Names (SPN)

The Network Controller automatically configures the SPN. All you need to do is to provide permissions for the Network Controller machines to register and modify the SPN.

1.  On the Domain Controller machine, start **Active Directory Users and Computers**.

2.  Select **View \> Advanced**.

3.  Right-click the source's computer account (Network Controller machine account) and select **Properties**.

4.  Select the **Security** tab and click **Advanced**.

    >[!NOTE]
    >If the Network Controller Machine account or a security group having all the Network Controller machine accounts you want to add is not listed, click **Add** to add it.

    a.  Select the account or group and click **View/Edit**.

    b.  Select the **Properties** tab and select **Validate Write servicePrincipalName**.

    c.  Under Permissions select **Validate Write servicePrincipalName**.

    d.  Scroll down and under **Properties** select:

       -  **Read servicePrincipalName**

       -  **Write servicePrincipalName**

    e.  Click **OK** twice.

    f.  Repeat step 3 for all Network Controller machines.

7.  Close **Active Directory Users and Computers**.

## Failure to provide permissions for SPN registration/modification

On a **NEW** Windows Server 2019 deployment, if you chose Kerberos for REST client authentication and don’t grant permission for Network Controller nodes to register or modify the SPN, REST operations on Network Controller fails. In this case, you won’t be able to manage the SDN.

On an upgrade from Windows Server 2016 to Windows Server 2019, and you chose Kerberos for REST client authentication, REST operations will not be blocked to ensure that existing production deployments are not hampered. We recommend that
you provide permission for Network Controller nodes to register SPN. Once done, Network Controller registers the SPN automatically, and all client operations use Kerberos.

>[!TIP]
>Typically, you can configure Network Controller to use an IP address or DNS name for REST-based operations. However, when you configure Kerberos, you cannot use an IP address for REST queries to Network Controller. For example, you can use \<https://networkcontroller.consotso.com\>, but you cannot use \<https://192.34.21.3\>. Service Principal Names cannot function if IP addresses are used.
>
>If you were using IP address for REST operations along with Kerberos authentication in Windows Server 2016, the actual communication would have been over NTLM authentication. In such a deployment, once you upgrade to Windows Server 2019, you continue to use NTLM-based authentication. To move to Kerberos-based authentication, you must use Network Controller DNS name for REST operations and provide permission for Network Controller nodes to register SPN.

---
---
title: Kerberos with Service Principal Name (SPN)
description: Network Controller supports multiple authentication methods for communication with management clients. You can use Kerberos based authentication, X509 certificate-based authentication. You also have the option to use no authentication for test deployments. 
manager: dougkim
ms.prod: windows-server
ms.technology: networking-sdn
ms.topic: article
ms.assetid: bc625de9-ee31-40a4-9ad2-7448bfbfb6e6
ms.author: lizross
author: eross-msft
ms.date: 08/23/2018
---

# Kerberos with Service Principal Name (SPN)

>Applies to: Windows Server 2019

Network Controller supports multiple authentication methods for communication with management clients. You can use Kerberos based authentication, X509 certificate-based authentication. You also have the option to use no authentication for test deployments.

System Center Virtual Machine Manager uses Kerberos-based authentication. If you are using Kerberos-based  authentication, you must configure a Service Principal Name (SPN) for Network Controller in Active Directory. The SPN is a unique identifier for the Network Controller service instance, which is used by Kerberos authentication to associate a service instance with a service login account. For more details, see [Service Principal Names](https://docs.microsoft.com/windows/desktop/ad/service-principal-names).

## Configure Service Principal Names (SPN)

The Network Controller automatically configures the SPN. All you need to do is to provide permissions for the Network Controller machines to register and modify the SPN.

1.  On the Domain Controller machine, start **Active Directory Users and Computers**.

2.  Select **View \> Advanced**.

3.  Under **Computers**, locate one of the Network Controller machine accounts, and then right-click and select **Properties**.

4.  Select the **Security** tab and click **Advanced**.

5.  In the list, if all the Network Controller machine accounts or a security group having all the Network Controller machine accounts is not listed, click **Add** to add it.

6.  For each Network Controller machine account or a single security group containing the Network Controller machine accounts:

    a.  Select the account or group and click **Edit**.

    b.  Under Permissions select **Validate Write servicePrincipalName**.

    d.  Scroll down and under **Properties** select:

       -  **Read servicePrincipalName**

       -  **Write servicePrincipalName**

    e.  Click **OK** twice.

7.  Repeat step 3 - 6 for each Network Controller machines.

8.  Close **Active Directory Users and Computers**.

## Failure to provide permissions for SPN registration/modification

On a **NEW** Windows Server 2019 deployment, if you chose Kerberos for REST client authentication and don't grant permission for Network Controller nodes to register or modify the SPN, REST operations on Network Controller fails preventing you from managing the SDN.

For an upgrade from Windows Server 2016 to Windows Server 2019, and you chose Kerberos for REST client authentication, REST operations do not get blocked, ensuring transparency for existing production deployments. 

If SPN is not registered, REST client authentication uses NTLM, which is less secure. You also get a critical event in the Admin channel of **NetworkController-Framework** event channel asking you to provide permissions to the Network Controller nodes to register SPN. Once you provide permission, Network Controller registers the SPN automatically, and all client operations use Kerberos.


>[!TIP]
>Typically, you can configure Network Controller to use an IP address or DNS name for REST-based operations. However, when you configure Kerberos, you cannot use an IP address for REST queries to Network Controller. For example, you can use \<https://networkcontroller.consotso.com\>, but you cannot use \<https://192.34.21.3\>. Service Principal Names cannot function if IP addresses are used.
>
>If you were using IP address for REST operations along with Kerberos authentication in Windows Server 2016, the actual communication would have been over NTLM authentication. In such a deployment, once you upgrade to Windows Server 2019, you continue to use NTLM-based authentication. To move to Kerberos-based authentication, you must use Network Controller DNS name for REST operations and provide permission for Network Controller nodes to register SPN.

---
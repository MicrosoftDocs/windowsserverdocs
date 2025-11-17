---
title: Prestage cluster computer objects in Active Directory Domain Services
description: Learn how to prestage cluster computer objects in AD DS, grant permissions, and manage cluster roles for secure and efficient failover clustering.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 07/29/2025
---

# Prestage cluster computer objects in Active Directory Domain Services

This topic shows how to prestage cluster computer objects in Active Directory Domain Services (AD DS). You can use this procedure to enable a user or group to create a failover cluster when they do not have permissions to create computer objects in AD DS.

When you create a failover cluster by using the Create Cluster Wizard or Windows PowerShell, specify a name for the cluster. If you have sufficient permissions, the cluster creation process automatically creates a computer object in AD DS that matches the cluster name. This object is called the *cluster name object* or CNO. Through the CNO, virtual computer objects (VCOs) are automatically created when you set up clustered roles that use client access points. For example, if you create a highly available file server with a client access point named *FileServer1*, the CNO creates a corresponding VCO in AD DS.

> [!NOTE]
> You can create an Active Directory-detached cluster, where no CNO or VCOs are created in AD DS. This option is for specific types of cluster deployments. For more information, see [Deploy an Active Directory-Detached Cluster](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v%3dws.11)>).

To create the CNO automatically, the user who creates the failover cluster needs the **Create Computer objects** permission for the organizational unit (OU) or container where the servers that form the cluster reside. To let a user or group create a cluster without this permission, a user with appropriate permissions in AD DS (typically a domain admin) can prestage the CNO in AD DS. This approach also gives the domain admin more control over the naming convention for the cluster and over which OU contains the cluster objects.

## Step 1: Prestage the CNO in AD DS

Before you begin, make sure you know the following:

- The name you want to assign to the cluster
- The name of the user account or group you want to let create the cluster

As a best practice, create an OU for the cluster objects. If an OU already exists that you want to use, membership in the **Account Operators** group is the minimum required to finish this step. If you need to create an OU for the cluster objects, membership in the **Domain Admins** group, or equivalent, is the minimum required to finish this step.

> [!NOTE]
> If you create the CNO in the default Computers container instead of an OU, you don't need to finish Step 3 of this topic. In this scenario, a cluster admin can create up to 10 VCOs without any extra configuration.

### Prestage the CNO in AD DS

1. On a computer with the AD DS Tools from Remote Server Administration Tools, or on a domain controller, open **Active Directory Users and Computers**. To do this on a server, start Server Manager, then on the **Tools** menu, select **Active Directory Users and Computers**.

1. To create an OU for the cluster computer objects, right-click the domain name or an existing OU, point to **New**, then select **Organizational Unit**. In the **Name** box, enter the name of the OU, then select **OK**.

1. In the console tree, right-click the OU where you want to create the CNO, point to **New**, then select **Computer**.

1. In the **Computer name** box, enter the name that will be used for the failover cluster, and then select **OK**.

   > [!NOTE]
   > This is the cluster name that the user who creates the cluster will specify on the **Access Point for Administering the Cluster** page in the Create Cluster wizard or as the value of the *–Name* parameter for the **New-Cluster** Windows PowerShell cmdlet.

1. As a best practice, right-click the computer account that you just created, select **Properties**, and then select the **Object** tab. On the **Object** tab, select the **Protect object from accidental deletion** check box, and then select **OK**.

1. Right-click the computer account that you just created, and then select **Disable Account**. Select **Yes** to confirm, and then select **OK**.

   > [!NOTE]
   > You must disable the account so that during cluster creation, the cluster creation process can confirm that the account is not currently in use by an existing computer or cluster in the domain.

   :::image type="content" source="media/prestage-cluster-adds/disabled-cno-in-the-example-clusters-ou.png" alt-text="Screenshot of a disabled CNO in the example Clusters OU.":::

**Figure 1. Disabled CNO in the example Clusters OU**

## Step 2: Grant the user permissions to create the cluster

You must configure permissions so that the user account that will be used to create the failover cluster has Full Control permissions to the CNO.

Membership in the **Account Operators** group is the minimum required to complete this step.

Here's how to grant the user permissions to create the cluster:

1. In Active Directory Users and Computers, on the **View** menu, make sure that **Advanced Features** is selected.

1. Locate and then right-click the CNO, and then select **Properties**.

1. On the **Security** tab, select **Add**.

1. In the **Select Users, Computers, or Groups** dialog box, specify the user account or group that you want to grant permissions to, and then select **OK**.

1. Select the user account or group that you just added, and then next to **Full control**, select the **Allow** check box.

   :::image type="content" source="media/prestage-cluster-adds/granting-full-control-to-the-user-create-the-cluster.png" alt-text="Screenshot of granting Full Control to the user or group that will create the cluster.":::

   **Figure 2. Granting Full Control to the user or group that will create the cluster**

1. Select **OK**.

After you complete this step, the user who you granted permissions to can create the failover cluster. However, if the CNO is located in an OU, the user cannot create clustered roles that require a client access point until you complete Step 3.

> [!NOTE]
> If the CNO is in the default Computers container, a cluster administrator can create up to 10 VCOs without any additional configuration. To add more than 10 VCOs, you must explicitly grant the **Create Computer objects** permission to the CNO for the Computers container.

## Step 3: Grant the CNO permissions to the OU or prestage VCOs for clustered roles

When you create a clustered role with a client access point, the cluster creates a VCO in the same OU as the CNO. For this to occur automatically, the CNO must have permissions to create computer objects in the OU.

If you prestaged the CNO in AD DS, you can do either of the following to create VCOs:

- Option 1: [Grant the CNO permissions to the OU](#grant-the-cno-permissions-to-the-ou). If you use this option, the cluster can automatically create VCOs in AD DS. Therefore, an administrator for the failover cluster can create clustered roles without having to request that you prestage VCOs in AD DS.

> [!NOTE]
> Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete the steps for this option.

- Option 2: [Prestage a VCO for a clustered role](#prestage-a-vco-for-a-clustered-role). Use this option if it is necessary to prestage accounts for clustered roles because of requirements in your organization. For example, you may want to control the naming convention, or control which clustered roles are created.

> [!NOTE]
> Membership in the **Account Operators** group is the minimum required to complete the steps for this option.

### Grant the CNO permissions to the OU

1. In Active Directory Users and Computers, on the **View** menu, make sure that **Advanced Features** is selected.

1. Right-click the OU where you created the CNO in [Step 1: Prestage the CNO in AD DS](#step-1-prestage-the-cno-in-ad-ds), and then select **Properties**.

1. On the **Security** tab, select **Advanced**.

1. In the **Advanced Security Settings** dialog box, select **Add**.

1. Next to **Principal**, select **Select a principal**.

1. In the **Select User, Computer, Service Account, or Groups** dialog box, select **Object Types**, select the **Computers** check box, and then select **OK**.

1. Under **Enter the object names to select**, enter the name of the CNO, select **Check Names**, and then select **OK**. In response to the warning message that says that you are about to add a disabled object, select **OK**.

1. In the **Permission Entry** dialog box, make sure that the **Type** list is set to **Allow**, and the **Applies to** list is set to **This object and all descendant objects**.

1. Under **Permissions**, select the **Create Computer objects** check box.

   :::image type="content" source="media/prestage-cluster-adds/granting-create-computer-objects-permission-to-the-cno.png" alt-text="Screenshot of granting the Create Computer objects permission to the CNO.":::

   **Figure 3. Granting the Create Computer objects permission to the CNO**

1. Select **OK** until you return to the Active Directory Users and Computers snap-in.

An administrator on the failover cluster can now create clustered roles with client access points, and bring the resources online.

### Prestage a VCO for a clustered role

1. Before you begin, make sure that you know the name of the cluster and the name that the clustered role will have.

1. In Active Directory Users and Computers, on the **View** menu, make sure that **Advanced Features** is selected.

1. In Active Directory Users and Computers, right-click the OU where the CNO for the cluster resides, point to **New**, and then select **Computer**.

1. In the **Computer name** box, enter the name that you will use for the clustered role, and then select **OK**.

1. As a best practice, right-click the computer account that you just created, select **Properties**, and then select the **Object** tab. On the **Object** tab, select the **Protect object from accidental deletion** check box, and then select **OK**.

1. Right-click the computer account that you just created, and then select **Properties**.

1. On the **Security** tab, select **Add**.

1. In the **Select User, Computer, Service Account, or Groups** dialog box, select **Object Types**, select the **Computers** check box, and then select **OK**.

1. Under **Enter the object names to select**, enter the name of the CNO, select **Check Names**, and then select **OK**. If you receive a warning message that says that you are about to add a disabled object, select **OK**.

1. Make sure that the CNO is selected, and then next to **Full control**, select the **Allow** check box.

1. Select **OK**.

An administrator on the failover cluster can now create the clustered role with a client access point that matches the prestaged VCO name, and bring the resource online.

## Related content

- [Failover Clustering](./failover-clustering-overview.md)
- [Configuring cluster accounts in Active Directory](configure-ad-accounts.md)



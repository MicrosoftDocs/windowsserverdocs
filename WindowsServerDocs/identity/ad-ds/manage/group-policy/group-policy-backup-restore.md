---
title: Group Policy backup and restore
description: You can use this article to understand how backup, restore, migrate and copy group policy objects (GPOs).
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
contributor: orthomas
ms.date: 02/18/2024
---

# Backing up, restoring, migrating, and copying Group Policy Objects (GPOs)

The Group Policy Management Console (GPMC) provides mechanisms for backing up, restoring, migrating, and copying existing GPOs. These capabilities are important for maintaining your Group Policy deployments in the event of an error or a disaster. They help you avoid having to manually recreate lost or damaged GPOs and then repeat the planning, testing, and deployment phases. Part of your ongoing Group Policy operations plan should include regular backups of all GPOs.

The GPMC also provides for copying and importing GPOs, both from the same domain and across domains. You can use the GPMC to migrate an existing GPO, for example, from an existing domain into a newly deployed domain. You can either copy GPOs or import policy settings from one GPO into another GPO. This technique saves effort by allowing you to reuse the contents of existing GPOs. Copying GPOs allows you to move straight from the staging phase to production. Importing GPOs allows you to transfer policy settings from a backed-up GPO into an existing GPO, and is especially useful in situations where a trust relationship isn't present between the source and destination domains. If you want to reuse existing GPOs, copying also allows you to conveniently move GPOs from one production environment to another.

## Using the GPMC to back up GPOs and view GPO backups

The backup operation backs up a production GPO to the file system. The location of the backup can be any folder to which you have Write access. After backing up GPOs, you must use the GPMC to display and manipulate the contents of your backup folder, either by using the GPMC UI or programmatically by using a script. Don't interact with archived GPOs directly through the file system. After the GPOs are backed up, use the GPMC to process archived GPOs by using the Import and Restore operations.

You can back up multiple instances of the same GPO to the same location because the GPMC uniquely identifies each backup instance. This mechanism allows you to pick the instance of the archived GPO with which you want to work. For example, you can choose to display only the most recent backups when viewing the contents of a backup folder through the GPMC.

## Back up all GPOs in a domain

To back up all GPOs in a domain, perform the following steps:

1. In the GPMC console tree, expand the forest or domain that contains the GPOs that you want to back up.
2. Right-click Group Policy Objects, and then click Back Up All.
3. In the Backup Group Policy Object dialog box, enter the path to the location where you want to store the GPO backups. Alternatively, you can click Browse, locate the folder in which you want to store the GPO backups, and then click OK.
4. Type a description for the GPOs that you want to back up, and then click Back Up.
5. After the backup operation completes, a summary will list how many GPOs were successfully backed up and any GPOs that weren't backed up.

## Back up a specific GPO

To back up a specific GPO, perform the following steps:

1. In the GPMC console tree, expand Group Policy Objects in the forest or domain that contains the GPO that you want to back up.
2. Right-click the GPO you want to back up, and then click Back Up.
3. In the Backup Group Policy Object dialog box, enter the path to the location where you want to store the GPO backup. Alternatively, you can click Browse, locate the folder in which you want to store the GPO backup, and then click OK.
4. Type a description for the GPO that you want to back up, and then click Back Up.
5. After the backup operation completes, a summary will state whether the backup succeeded.

## View the list of GPO backups

To view a list of backed up GPOs, perform the following steps:

1. In the GPMC console tree, expand the forest or domain that contains the GPOs that you want to back up.
2. Right-click Group Policy Objects, and the click Manage Backups.
3. In the Manage Backups dialog box, enter the path to the location where you stored the GPO backups that you want to view. Alternatively, you can click Browse, locate the folder that contains the GPO backups, and then click OK.
4. To specify that only the most recent version of the GPOs be displayed in the Backed up GPOs list, select the Show only the latest version of each GPO check box. Click Close.

## Restore GPOs with the GPMC

You can also restore GPOs. This operation restores a backed-up GPO to the same domain from which it was backed up. You cannot restore a GPO from a backup into a domain that is different from the GPO’s original domain. To restore a previous version of an existing GPO perform the following steps:

1. In the GPMC console tree, expand Group Policy Objects in the forest or domain that contains the GPOs that you want to restore.
2. Right-click the GPO that you want to restore to a previous version, and then click Restore from Backup.
3. When the Restore Group Policy Object Wizard opens, follow the instructions in the wizard, and then click Finish.
4. After the restore operation completes, a summary will state whether the restore succeeded. Click OK.

To restore a deleted GPO, perform the following steps:

1. In the GPMC console tree, expand the forest or domain that contains the GPO that you want to restore.
2. Right-click Group Policy Objects, and then click Manage Backups.
3. In the Manage Backups dialog box, click Browse, and then locate the file that contains your backed-up GPOs.
4. In the Backed up GPOs list, click the GPO that you want to restore, and then click Restore.
5. When you're prompted to confirm the restore operation, click OK.
6. After the restore operation completes, a summary will state whether the restore succeeded. Click OK. Click Close.

## Copy GPOs and import GPO settings

The GPMC allows you to copy GPOs, both in the same domain and across domains, and import Group Policy settings from one GPO to another. Perform these operations as part of your staging process before deployment in your production environment. These operations are also useful for migrating GPOs from one production environment to another.

Although the collection of policy settings that comprises a GPO is logically a single entity, the data for a single GPO is stored in multiple locations and in a variety of formats. Some data is contained in Active Directory and other data is stored in the Sysvol folder on domain controllers. This means that you can't copy GPOs by copying a folder from one computer to another.

A copy operation copies an existing, current GPO to the desired destination domain. A new GPO is always created as part of this process. The destination domain can be any trusted domain in which you have the right to create new GPOs. Simply add the desired forests and domains in the GPMC and use the GPMC to copy and paste (or drag and drop) the desired GPOs from one domain to another. To copy a GPO, you must have permission to create GPOs in the destination domain.

When copying GPOs, you can also copy the Discretionary Access Control List (DACL) on the GPO, in addition to the policy settings within the GPO. This is useful for ensuring that the new GPO that is created as part of the copy operation has the same security filtering and delegation options as the original GPO.

Importing a GPO allows you to transfer policy settings from a backed-up GPO to an existing GPO. Importing a GPO transfers only the GPO settings; it does not modify the existing security filtering or links on the destination GPO. Importing a GPO is useful for migrating GPOs across untrusted environments, because you only need access to the backed-up GPO, not the production GPO. Because an import operation only modifies policy settings, Edit permissions on the destination GPO are sufficient to perform the operation.

When copying or importing a GPO, you can specify a migration table, if the GPO contains security principals or UNC paths that might need to be updated when they are copied to the target domain. You use the Migration Table Editor (MTE) to create and edit migration tables. Migration tables are described in the next section, Using migration tables.

To copy a GPO, perform the following steps:

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO that you want to copy.
2. Right-click the GPO that you want to copy, and then click Copy.
3. Do one of the following:

- To place the copy of the GPO in the same domain as the source GPO, right-click Group Policy Objects, and then click Paste.
- To place the copy of the GPO in a different domain (either in the same or a different forest), expand the destination domain, right-click Group Policy Objects, and then click Paste.
- If you're copying within a domain, click Use the default permissions for new GPOs or Preserve the existing permissions, and then click OK.

4. If you are copying to or from another domain, follow the instructions in the wizard that opens, and then click Finish.

## Import GPO settings

To import policy settings from a backed-up GPO into another GPO, perform the following steps:

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO into which you want to import policy settings.
2. Right-click the GPO into which you want to import policy settings, and then click Import Settings.
3. When the Import Settings Wizard opens, follow the instructions in the wizard that opens, and then click Finish.
4. After the import operation completes, a summary will state whether the import succeeded. Click OK.

## Migration tables

Because some data in a GPO is domain-specific and might not be valid when copied directly to another domain, the GPMC provides migration tables. A migration table is a simple table that specifies a mapping between a source value and a destination value.

A migration table converts, during the copy or import operation, the references in a GPO to new references that will work in the target domain. You can use migration tables to update security principals and UNC paths to new values as part of the import or copy operation. Migration tables are stored with the file name extension .migtable, and are actually XML files. You don't need to know XML to create or edit migration tables; the GPMC provides the MTE for manipulating migration tables.

A migration table consists of one or more mapping entries. Each mapping entry consists of a source type, source reference, and destination reference. If you specify a migration table when performing an import or copy operation, each reference to the source entry is replaced with the destination entry when the policy settings are written into the destination GPO. Before you use a migration table, ensure that the destination references specified in the migration table already exist.

The following items can contain security principals and can be modified by using a migration table:

- Security policy settings of the following types:

  - User rights assignment
  - Restricted groups
  - System services
  - File system
  - Registry

- Advanced folder redirection policy settings
- The GPO DACL, if it is preserved during a copy operation
- The DACL on software installation objects, which is only preserved if the option to copy the GPO DACL is specified

Also, the following items can contain UNC paths, which might need to be updated to new values as part of the import or copy operation, because servers in the original domain might not be accessible from the domain to which the GPO is being migrated:

- Folder redirection Group Policy settings
- Software installation Group Policy settings

References to scripts (such as for logon and startup scripts) that are stored outside the source GPO. The script itself is not copied as part of the GPO copy or import operation, unless the script is stored inside the source GPO.

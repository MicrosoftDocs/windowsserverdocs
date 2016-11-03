#requires -Version 3

<#
    .SYNOPSIS
    Reads a CSV file containing a list of files to be renamed and the suggested new name. It then renames
    those files and fixs all references to those files contained in the MD files of the current folder tree.

    .DESCRIPTION
    This script reads the CSV file created by the make-renameMDFiles.ps1 and make-renameMediaFiles.ps1 
    scripts. For each row in the CSV file, the script renames the original file to the new name then 
    scans the current folder (recursively) for all MD files containing a reference to the old name. The old
    name is replaced in the MD file with the new value. It does the same operation on the specified TOC.md 
    file.

    .PARAMETER renamefile
    This is the full path to the CSV file to be processed by the script.

    .PARAMETER tocfile
    This is the full path to the TOC.md file to be updated by the script.

    .EXAMPLE
    PS > cd "<repo-location>\networking"
    PS > <script-repository>\process-renamefile.ps1 .\renameMDfiles.csv
    PS > <script-repository>\process-renamefile.ps1 .\renameMediaFiles.csv

    .EXAMPLE
    PS > cd "<repo-location>\networking"
    PS > <script-repository>\process-renamefile.ps1 .\renameMDfiles.csv ..\TOC.md
    PS > <script-repository>\process-renamefile.ps1 .\renameMediaFiles.csv ..\TOC.md

#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$True)][string]$renamefile,
  [string]$tocfile = '..\TOC.md'
)

function fixlinks 
{
  param(
    [string]$mdfile,
    [string]$oldFolderName,
    [string]$newname
  )
  Write-Output -InputObject "-- Updating links to in $mdfile"
  $mdtext = Get-Content $mdfile
  $mdtext = $mdtext -replace $oldFolderName, $newname
  Set-Content -Path $mdfile -Value $mdtext
}

$renameList = Import-Csv -Path $renamefile
foreach ($renameRecord in $renameList) 
{
  $newFileName = $renameRecord.newfilename
  $newFolderName = ($renameRecord.newfilename -split "\.")[0]
  
  $oldFilePath = $renameRecord.oldfilepath
  $oldFileObject = get-item $oldFilePath
  $oldFileName = $oldFileObject.Name
  $oldFolderName =  $oldFileObject.BaseName

  if ($oldFolderName -cne $newFolderName) 
  {
    $newFilePath = ($oldFilePath -replace $oldFileName, $newFileName)

    Write-Output -InputObject "Rename $oldFileName to $newFileName"
    if ($oldFilePath.tolower() -ceq $newFilePathpath) {
      Move-Item $oldFilePath "$newFilePath~"
      Move-Item "$newFilePath~" $newFilePath
    } else  {
      Move-Item $oldFilePath $newFilePath
    }

    $oldMediaPath = "media\$oldFolderName"
    $newMediaPath = "media\$newFolderName"
    if (Test-Path $oldMediaPath) 
    {
      Write-Output -InputObject "Rename $oldMediaPath to $newMediaPath"
      if ($oldMediaPath.ToLower() -ceq $newMediaPath) {
        Move-Item $oldMediaPath "$newMediaPath~"
        Move-Item "$newMediaPath~" $newMediaPath
      } else  {
        Move-Item $oldMediaPath $newMediaPath
      }
    }

    #fixlinks -mdfile $tocfile -oldFolderName $oldFolderName -newname $newname
    Get-ChildItem $tocfile,*.md -Recurse | ForEach-Object -Process {
      $foundlinks = Select-String -Path $_ -Pattern $oldFolderName
      if ($foundlinks -ne $null) 
      {
        fixlinks -mdfile $_.FullName -oldFolderName $oldFolderName -newname $newFolderName
      }
    }
  }
}


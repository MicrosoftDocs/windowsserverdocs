<#

    .SYNOPSIS
    Updates all of the links in the TOC.md file.

    .DESCRIPTION
    Run this script from the root folder of the content repository where TOC.md exists. Point the script
    at the path for your topic. The script scans all of the files in the topic folder (recursively) and
    updates the TOC.md to point to the new location of the file. This assumes that the file name has not
    been changed from what appears in the TOC.md file. 

    .PARAMETER targetfolder
    The path to folder tree containing your newly relocated files.


    .EXAMPLE
    PS > cd "<repo-location>"
    PS > <script-repository>\runonce\update-toc.ps1 .\networking


#>

[CmdletBinding()]
param([Parameter(Mandatory = $True)][string]$targetfolder)

function getMDfilelist 
{
  param($filespec)
  $pwd = ((Get-Location).Path.tostring() -replace '\\', '/') + '/'
  $hash = @{}
 
  Get-ChildItem $filespec -Recurse | ForEach-Object -Process {
    $filepath = $_.fullname -replace '\\', '/'
    $linkpath = $filepath -replace $pwd

    $EAPref = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'
    try 
    {
      $hash.Add($filename,$linkpath)
    }
    catch 
    {
      Write-Error "ERROR: Duplicate file name: $linkpath"
      Write-Error ('- Duplicate of {0}' -f $hash[$filename])
    }
  }
  $ErrorActionPreference = $EAPref
  Write-Output -InputObject $hash   
}

if (Test-Path $targetfolder) 
{
  $target = Get-Item $targetfolder
  if ($targetfolder.PSIsContainer -eq $false) 
  {
    Write-Warning -Message 'Not a valid directory!'
    exit
  }
}
else 
{
  Write-Warning -Message "$targetfolder does not exist!"
  exit
}

$targetspec = "$targetfolder\*.md"
$mdFileList = getMDfilelist $targetspec

$toc = Get-Content -Path .\TOC.md
foreach ($file in $mdFileList.keys) 
{
  $toc = $toc -replace "\($file\)", ('({0})' -f $mdFileList[$file])
}
Set-Content -Path .\TOC.md -Value $toc

#requires -Version 3

<#
    .SYNOPSIS
    Create a CSV file containing a list of MD files to be renamed and the suggested new name.

    .DESCRIPTION
    This script scans the current folder (recursively) for MD files and creates the CSV file. The CSV
    file has a column containing the new suggested name, the length of that name, and the full path
    to the existing file.

    The author then edits the CSV file to make any necessary adjustments to the new filename. Whole rows
    can be deleted if the original filename does not need to change. The column containing the length is
    there to aid the content owner in picking a name of the appropriate length based on the limitations or
    requirements of the publishing system.

    Once the CSV file has been updated appropriately, the content owner then run the process-renamefile.ps1
    script to rename the files as defined in the CSV.

    .PARAMETER csvfile
    This is the full path to the CSV file to be created. By default, the script creates a file named
    renameMDfiles.csv in the current folder.

    .EXAMPLE
    PS > cd "<repo-location>\networking"
    PS > <script-repository>\make-renameMDFiles.ps1

    .EXAMPLE
    PS > cd "<repo-location>\networking"
    PS > <script-repository>\make-renameMDFiles.ps1 c:\temp\renameMDfiles.csv

#>

[CmdletBinding()]
param([string]$csvfile = '.\renameMDfiles.csv')

$null = [System.Reflection.Assembly]::LoadWithPartialName('System.web')
$smallwords = 'am,is,are,was,be,do,did,i,a,an,and,the,if,of,on,in,up,at,it,for,to,so,or' -split ','

#-------------------------------------------------------
#region Helper Functions
function urlencode($str) 
{
  return [System.Web.HttpUtility]::UrlEncode($str)
}
function urldecode($str) 
{
  return [System.Web.HttpUtility]::UrlDecode($str)
}
#-------------------------------------------------------
function htmlencode($str) 
{
  return [System.Web.HttpUtility]::HtmlAttributeEncode($str)
}
function htmldecode($str) 
{
  return [System.Web.HttpUtility]::HtmlDecode($str)
}
#endregion
#-------------------------------------------------------
function makeFilename 
{
  param($file)
  if ($file.Extension -eq '.md')  
  {
    $title = ((Select-String -Path $file -Pattern 'title:').line -split 'title:')[-1].trim()
    $title = htmldecode $title
    $title = $title -replace '  ', ' '
    $title = $title -replace '([^\w\s]*)'
    $title = ($title.ToLower()).trim()
    $title = $title -replace ' ', '-'
    $title = $file.name.ToLower()
  }
  Write-Output -InputObject "$title.md"
}
#-------------------------------------------------------

$rows = @()

Write-Output -InputObject "Creating $csvfile"
Get-ChildItem -Path *.md -Recurse |
Where-Object -Property PSIsContainer -EQ -Value $false |
ForEach-Object -Process {
  $file = $_

  $filename = makeFilename $file
  $row = [ordered]@{
    newfilename = $filename
    pathlength  = $filename.length
    oldfilepath = $file.FullName
  }
  $rows  += New-Object -TypeName psobject -Property $row
}
Write-Output -InputObject ('Found {0} files in the folder tree for {1}' -f $rows.Count, (Get-Location).Path)
$rows | Export-Csv -NoTypeInformation $csvfile

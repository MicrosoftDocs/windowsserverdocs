<#

    .SYNOPSIS
        Replaces all 'token' references with with the token value.

    .DESCRIPTION
        The command replaces all token references, in all MD documents (recursively),
        with the token value.

    .PARAMETER  documentsfolder
        The path to the folder (with subfolders) that contains all MD documents to review and replace for tokens.

    .PARAMETER  documentsRoot
        The path to the root folder that contains includes folder that contains all token MD documents.

    .OUTPUTS
        A list of token references that are broken; in a list of [TAB] separated values, in the form of: 
            <occurrence>'t<document-path>`t<token>`t<broken-reference>

        MD files that contain valid token references are updated in place. The token link is replaced with 
        the contents of the linked token file.

    .EXAMPLE
        <script-repository>\Replace-TokensInMdDocuments.ps1 "<repo-location>\networking" "<repo-location>"


        
        
#>
[CmdletBinding()]
Param(
  [Parameter(Mandatory = $True)][string]$documentsfolder,
  [Parameter(Mandatory = $True)][string]$documentsRoot
)

$tokensFound  = @()

do {
    $tokensFound  = get-childitem -Path $documentsfolder -Filter '*.md' -recurse |`
        Select-String '\[!INCLUDE\s*\[.+?\]\s*\((.+?)\)\]' -AllMatches |`
        ForEach-Object { 
            $document=($_.Path);
            $_.matches | % { @{document=$document; token=$_.groups[0].value; tokenFile = $(Join-Path -Path $documentsRoot -ChildPath $($_.groups[1].value.Replace('/','\'))) }}} |`
        where-object { (Test-Path $_['tokenFile']) } |`
        ForEach-Object { 
            $tokenValue = get-content -Path ($_['tokenFile']) -encoding UTF8;  
            $token = ($_['token']);
            $document = ($_['document']);
            $content = [System.IO.File]::ReadAllLines($document) ## $content = get-content -Path $document
            $newcontent = $content | ForEach-Object { $_.Replace($token,$tokenValue) }
            [System.IO.File]::WriteAllLines($document,$newcontent)    ## (set-content -Path  $document -Value $newcontent) 1>$null
            $_
        }
} while ( $tokensFound.Length -gt 0)


$brokenTokens = get-childitem -Path $documentsfolder -Filter '*.md' -recurse |`
    Select-String '\[!INCLUDE\s*\[.+?\]\s*\((.+?)\)\]' -AllMatches |`
    ForEach-Object { 
        $document=($_.Path);
        $_.matches | % { @{document=$document; token=$_.groups[0].value; tokenFile = $(Join-Path -Path $(([System.IO.Path]::GetDirectoryName($document))) -ChildPath $($_.groups[1].value)) }}} 

$brokenTokenCount = 0
$brokenTokens | % { ++$brokenTokenCount; write-output $("[{0,6:N0}]`t{1,-40}`t{2,-20}`t{3}" -f $brokenTokenCount, $_['document'], $_['token'], $_['tokenFile'] )}

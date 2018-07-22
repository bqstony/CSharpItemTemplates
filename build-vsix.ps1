# move current folder to where contains this .ps1 script file.
$scriptDir = Split-Path $MyInvocation.MyCommand.Path
pushd $scriptDir
[System.Reflection.Assembly]::LoadFile((Convert-Path "Ionic.Zip.dll")) > $null

# Compress xUnit item template contents into .zip file.
$projectTemplateDir = Join-Path $scriptDir "ItemTemplates\CSharp\Test"
if ((Test-Path $projectTemplateDir) -eq $false){
    mkdir $projectTemplateDir > $null
}
$zip = new-object Ionic.Zip.ZipFile
$zip.AddDirectory((Convert-Path 'xUnit Item Template'), "") > $null
$zip.Save((Join-Path $projectTemplateDir "xUnitTest.zip"))
$zip.Dispose()

# Compress Csharp Public Class Item Templates contents into .zip file.
$projectTemplateDir = Join-Path $scriptDir "ItemTemplates\CSharp\Code"
if ((Test-Path $projectTemplateDir) -eq $false){
    mkdir $projectTemplateDir > $null
}
$zip = new-object Ionic.Zip.ZipFile
$zip.AddDirectory((Convert-Path 'Csharp Public Class Item Template'), "") > $null
$zip.Save((Join-Path $projectTemplateDir "CsharpPublicClassItemTemplates.zip"))
$zip.Dispose()

# Compress Csharp Public Enum Item Templates contents into .zip file.
$projectTemplateDir = Join-Path $scriptDir "ItemTemplates\CSharp\Code"
if ((Test-Path $projectTemplateDir) -eq $false){
    mkdir $projectTemplateDir > $null
}
$zip = new-object Ionic.Zip.ZipFile
$zip.AddDirectory((Convert-Path 'Csharp Public Enum Item Template'), "") > $null
$zip.Save((Join-Path $projectTemplateDir "CsharpPublicEnumItemTemplates.zip"))
$zip.Dispose()

# Get version infomation from reading manifest file.
$manifest = [xml](cat .\extension.vsixmanifest -Raw)
$ver = $manifest.PackageManifest.Metadata.Identity.Version

# Create .vsix a package with embedding version information.
$zip = new-object Ionic.Zip.ZipFile
$zip.AddFile((Convert-Path '.\`[Content_Types`].xml'), "") > $null
$zip.AddFile((Convert-Path .\extension.vsixmanifest), "") > $null
$zip.AddFile((Convert-Path .\icon.png), "") > $null
$zip.AddFile((Convert-Path .\release-notes.txt), "") > $null
$zip.AddDirectory((Convert-Path .\ItemTemplates), "ItemTemplates") > $null
$zip.Save((Join-Path $scriptDir "CsharpItemTemplates.$ver.vsix"))
#DEBUG: $zip.Save((Join-Path $scriptDir "CsharpItemTemplates.zip"))
$zip.Dispose()

# Clean up working files.
del .\ItemTemplates -Recurse -Force

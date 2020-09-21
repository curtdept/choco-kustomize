$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases
$version = '3.8.4'
# pattern for archive name
$base_name = "kustomize_v$($version)_windows_amd64"
$zip_name = $base_name + ".tar.gz"
$tar_name = $base_name + ".tar"
$exe_name = "kustomize.exe"

# only 64bit url
$url = "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$($version)/$($zip_name)"

# use $ checksum [exe] -t=sha256
$archive_checksum = '54D42CB8690ECB63ACD3CB302D77E24DB9EA368C4F11C0B197CFA3A0C9CE516C'
$exe_checksum = '1C20A75425C1ED47D5DEC81794B07A257473569BED62F880A9A5DCBA5A8D3EDA'
$checksum_type = 'sha256'

# destinations
$zipLocation = join-path $toolsDir $zip_name
$exeLocation = join-path $toolsDir $exe_name

$getArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = $zipLocation
  url64bit      = $url
  checksum64    = $archive_checksum
  checksumType64= $checksum_type
}

Get-ChocolateyWebFile @getArgs

$unzipArgs = @{
  fileFullPath = $zipLocation
  destination = $toolsDir
}

Get-ChocolateyUnzip @unzipArgs

$unzip2Args = @{
  fileFullPath = join-path $toolsDir $tar_name
  destination = $toolsDir
}

Get-ChocolateyUnzip @unzip2Args

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'kustomize*'
  fileType      = 'exe'
  silentArgs    = ""
  validExitCodes= @(0)
  file64        = $exeLocation
  checksum64    = $exe_checksum
  checksumType64= $checksum_type
  destination   = $toolsDir
}

Install-ChocolateyInstallPackage @packageArgs

$binargs = @{
  name = 'kustomize'
  path = $exeLocation
}

Install-BinFile @binArgs

$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases
$version = '5.1.0'
# pattern for archive name
$base_name = "kustomize_v$($version)_windows_amd64"
$zip_name = $base_name + ".tar.gz"
$tar_name = $base_name + ".tar"
$exe_name = "kustomize.exe"

# only 64bit url
$url = "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$($version)/$($zip_name)"

# use $ checksum [exe] -t=sha256
$archive_checksum = 'AC48286444A33417E5251393F1B1B9972B00CFF82FD3AB8D21CA8D8C29411199'
$exe_checksum = '167FF2F164627FF7FE73FF5D247F34DBE3F70FB74FB5A9C3F25332A3BB55B71E'
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

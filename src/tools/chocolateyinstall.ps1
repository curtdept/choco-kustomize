$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases
$version = '4.5.5'
# pattern for archive name
$base_name = "kustomize_v$($version)_windows_amd64"
$zip_name = $base_name + ".tar.gz"
$tar_name = $base_name + ".tar"
$exe_name = "kustomize.exe"

# only 64bit url
$url = "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$($version)/$($zip_name)"

# use $ checksum [exe] -t=sha256
$archive_checksum = 'A72D7E5BBCE1388C829D17208C34BF11DF69215E7E496E05D8156A0D44B7DE3D'
$exe_checksum = '0B63F1C223E186159BD29F4DE4387722D8C2BD37AA01555EAEEC2D6C6706DDEF'
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

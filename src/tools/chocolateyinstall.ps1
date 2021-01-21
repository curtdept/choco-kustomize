$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases
$version = '3.9.2'
# pattern for archive name
$base_name = "kustomize_v$($version)_windows_amd64"
$zip_name = $base_name + ".tar.gz"
$tar_name = $base_name + ".tar"
$exe_name = "kustomize.exe"

# only 64bit url
$url = "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$($version)/$($zip_name)"

# use $ checksum [exe] -t=sha256
$archive_checksum = 'F2DE820FF6C00D5E93141BD887C577B962E249CF395466D304B7BFF1F8BB5860'
$exe_checksum = '378A856D70580C0E209250F328E1015D06C5547522DE4B1D29A856636CA1F64D'
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

$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases

# only 64bit url
$url64 = 'https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v5.3.0/kustomize_v5.3.0_windows_amd64.zip'

# use $ checksum [exe] -t=sha256
$checksum64 = '649c770dd9b506cec77f3036c3374d58d86d69427f5329b28c68b49fa90188db'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  unziplocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

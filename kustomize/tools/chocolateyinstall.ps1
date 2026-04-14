$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases

# only 64bit url
$url64 = 'https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v5.8.1/kustomize_v5.8.1_windows_amd64.zip'

# use $ checksum [exe] -t=sha256
$checksum64 = '8ec7f5e815e526d4622c06df0a7793d8cfb6eb1c74f816b46166097fef8b26c6'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  unziplocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

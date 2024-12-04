$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases

# only 64bit url
$url64 = 'https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v5.5.0/kustomize_v5.5.0_windows_amd64.zip'

# use $ checksum [exe] -t=sha256
$checksum64 = 'a19684ae51f7a768f937f713780411cfb3945339a509294504daf9b87a77b642'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  unziplocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

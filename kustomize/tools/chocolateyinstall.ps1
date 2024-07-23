$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases

# only 64bit url
$url64 = 'https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v5.4.3/kustomize_v5.4.3_windows_amd64.zip'

# use $ checksum [exe] -t=sha256
$checksum64 = '5ce680e51637bf7eed046b63601d3d4d9604a0e42ef7177c6a16a29f8e455a7f'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  unziplocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

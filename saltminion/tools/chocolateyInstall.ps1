$packageName = 'saltminion'

# Update these URLs and checksums when deploying a new version
$url = 'https://repo.saltstack.com/windows/Salt-Minion-2016.3.1-x86-Setup.exe'
$checksum = '4293e39ed3bfe90ac3a3a2dba66c2047'
$url64 = 'https://repo.saltstack.com/windows/Salt-Minion-2016.3.1-AMD64-Setup.exe'
$checksum64 = 'f3269cf009b9ecc8770dff430a5a74e0'

# We need a path to download the file so we can manually update it
$installerFilePath = "${env:chocolateyPackageFolder}\${env:chocolateyPackageName}-${env:chocolateyPackageVersion}.exe"

# Ignore the downloaded installer from getting a shim
New-Item "$installerFilePath.ignore" -type file -force | Out-Null

# Get arguments to download the file from the URLs and checksums above
$packageArgs = @{
  packageName   = $packageName
  fileFullPath  = $installerFilePath
  url           = $url
  url64bit      = $url64
  checksum      = $checksum
  checksumType  = 'md5'
  checksum64    = $checksum64
  checksumType64= 'md5'
}

# Download the file and bail if the return code is non-zero
Get-ChocolateyWebFile @packageArgs

# Install
Write-Host "Installing ${env:chocolateyPackageName} v${env:chocolateyPackageVersion}..."

# Run the downloaded file with the /S silent flag
# We have to use Start-Process to allow the installer to finish
# Otherwise control returns to the script too soon and the install fails
# This is why we can't use the standard Install-ChocoletyPackage function
Start-Process "$installerFilePath" -ArgumentList @('/S') -NoNewWindow -Wait
$packageName = 'saltminion'

# Update these URLs and checksums when deploying a new version
$url = 'https://repo.saltstack.com/windows/Salt-Minion-2016.3.3-x86-Setup.exe'
$checksum = '74b3ca7def7b127bd90a5f16bb3aa5c3'
$url64 = 'https://repo.saltstack.com/windows/Salt-Minion-2016.3.3-AMD64-Setup.exe'
$checksum64 = '8ed1b07a204c4f07cc07f6ccd82106d9'

# We need a path to download the file so we can manually update it
#$installerFilePath = "${env:chocolateyPackageFolder}\${env:chocolateyPackageName}-${env:chocolateyPackageVersion}.exe"

# Ignore the downloaded installer from getting a shim
#New-Item "$installerFilePath.ignore" -type file -force | Out-Null

# Get arguments to download the file from the URLs and checksums above
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64
  silentArgs    = "/S"
  checksum      = $checksum
  checksumType  = 'md5'
  checksum64    = $checksum64
  checksumType64= 'md5'
}
#fileFullPath  = $installerFilePath

# Download the file and bail if the return code is non-zero
#Get-ChocolateyWebFile @packageArgs
Install-ChocolateyPackage @packageArgs

# Install
#Write-Host "Installing ${env:chocolateyPackageName} v${env:chocolateyPackageVersion}..."

# Run the downloaded file with the /S silent flag
# We have to use Start-Process to allow the installer to finish
# Otherwise control returns to the script too soon and the install fails
# This is why we can't use the standard Install-ChocoletyPackage function
#Start-Process "$installerFilePath" -ArgumentList @('/S') -NoNewWindow -Wait

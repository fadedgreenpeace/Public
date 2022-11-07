#DCG
#Inspired by https://stackoverflow.com/questions/10634396/get-the-drive-letter-of-usb-drive-in-powershell
#and https://morethanpatches.com/2021/04/09/store-removable-device-bitlocker-recovery-keys-to-azure-ad/
#This depends on a device being at least hybrid bound to AzureAD
#This is a bit mis-named, the keys are actually backed up to AzureAD, but Intune is my preferred method of accessing the recovery key text.

#Finding all bitlocker encrytped volumes on a host
$BLV = Get-BitlockerVolume | Where-Object { $_.VolumeStatus -match 'FullyEncrypted' }
#Getting mount point of found encrypted volumes to pass to BackupToAAD-BitLockerKeyProtector
$MountPoint = $BLV.MountPoint
foreach ($BitlockerDrive in $BLV) {
    BackupToAAD-BitLockerKeyProtector -MountPoint $MountPoint -KeyProtectorId $BLV.KeyProtector[1].KeyProtectorId
}
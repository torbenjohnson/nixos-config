# NixOS Setup guide

## Build ISO

```bash
nix build .#nixosConfigurations.iso.config.system.build.isoImage
```
Copy the file in result/iso/ to a USB drive.

## Install NixOS

```bash
echo "temp-password" > /tmp/secret.key

nix run github:nix-community/nixos-anywhere -- \
  --flake .#<hostname> \
  --target-host tor@nixos.local \
  --disk-encryption-keys /tmp/secret.key /tmp/secret.key
```
Afterwards on the target device
```bash
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/nvme0n1p2
```
After a reboot, it should no longer ask for a passphrase.
# [0.18.0](https://github.com/99linesofcode/nixos-config/compare/v0.17.1...v0.18.0) (2026-06-06)


### Bug Fixes

* **dependabot:** time should be string instead of int ([8c85720](https://github.com/99linesofcode/nixos-config/commit/8c857209e7a81854a9a3ed2856cb07c3f591976d))
* **networking:** define networking.hostName at default module level ([8649819](https://github.com/99linesofcode/nixos-config/commit/8649819dee443dbd9583eba470ee78be8bea040a))
* **networking:** define networking.hostName at default module level ([64d6d7d](https://github.com/99linesofcode/nixos-config/commit/64d6d7de96507abf852409ee059d7774d95f0b06))
* pass config to shared/default.nix module so hostname is set correctly ([d8b904c](https://github.com/99linesofcode/nixos-config/commit/d8b904c49569d412ccfa63b13c701b31b16dab9c))
* **restic:** correctly define backup paths ([a07a17d](https://github.com/99linesofcode/nixos-config/commit/a07a17d70dca22a1c1315cd349e00129c5898a1a))
* **restic:** correctly define backup paths ([3abe9a4](https://github.com/99linesofcode/nixos-config/commit/3abe9a4333200842ab0575c7e64cff3ed59da866))


### Features

* **dnsmasq:** replace systemd-resolved with dnsmasq to allow wildcard resolution ([0f6a1ee](https://github.com/99linesofcode/nixos-config/commit/0f6a1ee27cc4c082c0e394b28ea6eb98a3d098ce))
* **github:** let dependabot update git submodules automatically ([3d56c2f](https://github.com/99linesofcode/nixos-config/commit/3d56c2fed78fab1aa5e7280d038bc43ff557fa88))
* **nvidia:** allow installing LACT or CoolerControl on host machines ([27a0d40](https://github.com/99linesofcode/nixos-config/commit/27a0d409a36da2ddc6be4308bbd0ee0243532dbc))
* **script:** add ./nixos rekey <filepath> command ([5e7d67c](https://github.com/99linesofcode/nixos-config/commit/5e7d67c37c8073fa9f424519f33a3df9d0e4d43e))
* **sound:** default to High Quality LDAC encoding for bluetooth devices ([664864a](https://github.com/99linesofcode/nixos-config/commit/664864a0f29fbc2294c4a6f875ed6d7065e5f3bf))
* **tlp:** extend battery life and limit turbo boost to prevent throttling ([a62710a](https://github.com/99linesofcode/nixos-config/commit/a62710a0feaa99cac27fe4ea032cd27f23175d14))



## [0.17.1](https://github.com/99linesofcode/nixos-config/compare/v0.17.0...v0.17.1) (2026-01-14)


### Bug Fixes

* **luna:** nvidiaPackages.beta equals 590 which doesn't support luna's GPU anymore ([379bc31](https://github.com/99linesofcode/nixos-config/commit/379bc3138da52af13b8b1b1ec04e9f4e9722f22e))
* **qemu:** All OVMF images distributed with QEMU are now available by default ([95306f2](https://github.com/99linesofcode/nixos-config/commit/95306f29e32ad1dc1ef7b27416333d2f8d288340))



# [0.17.0](https://github.com/99linesofcode/nixos-config/compare/v0.16.0...v0.17.0) (2026-01-12)


### Features

* **sunshine:** add module for self-hosted game stream host for Moonlight ([8a8ef56](https://github.com/99linesofcode/nixos-config/commit/8a8ef56d1e000e1cef7609c8b2bb552008f8904d))



# [0.16.0](https://github.com/99linesofcode/nixos-config/compare/v0.15.0...v0.16.0) (2026-01-12)


### Bug Fixes

* **dns:** use ipv4 DNS servers for the time being ([819208d](https://github.com/99linesofcode/nixos-config/commit/819208d09ea01a51c6ff3274629cedd05cc52e1b))
* **impermanence:** mount /persist to resolve decryption and as a result, start-up issues ([67d69c6](https://github.com/99linesofcode/nixos-config/commit/67d69c6cedf90924825c80cb51ba623a9e734ce1))
* import and inherit missing lib causing undefined variable error ([90f1da3](https://github.com/99linesofcode/nixos-config/commit/90f1da3ccc0151e0c84c5348d8a5da38a0368385))


### Features

* **docker:** persist docker configuration, images and volumes ([6772373](https://github.com/99linesofcode/nixos-config/commit/6772373de727f73549c32b3154ec2e1b0e0416a0))
* **restic:** automatically backup important files to Google Drive using Rclone ([da7dca8](https://github.com/99linesofcode/nixos-config/commit/da7dca85c8572505aa0f4ec37a761f5ff01e8c31))



# [0.15.0](https://github.com/99linesofcode/nixos-config/compare/v0.14.0...v0.15.0) (2025-11-06)


### Bug Fixes

* **docker-clone:** couldn't follow symlinks so copied secrets to /var/lib/docker-plugins/rclone dir instead ([d884eb2](https://github.com/99linesofcode/nixos-config/commit/d884eb2a97859ee8367825e1c78b2967a1581332))
* **docker:** docker-credential-helpers by installing pass for secrets management ([ca7c817](https://github.com/99linesofcode/nixos-config/commit/ca7c81728547e46b667534af1f7043bb8619d0ad))
* **rclone:** create /var/lib/docker-plugins directories if NOT in rootless mode ([55b2fd7](https://github.com/99linesofcode/nixos-config/commit/55b2fd7d93f536d3219ed0709a7145c96f12a071))
* **timezone:** only enable automatic timezoned on luna.shorty for now ([e80bc37](https://github.com/99linesofcode/nixos-config/commit/e80bc3738fc3c3d76446b0ae6204eddf6695a9b1))


### Features

* **impermanence:** wipe root on reboot ([64e670c](https://github.com/99linesofcode/nixos-config/commit/64e670c985bc6a237da4ea55a6941009c0388bf7))
* **rustdesk:** install rustdesk on luna ([e3fec27](https://github.com/99linesofcode/nixos-config/commit/e3fec272a3528b107ad291c4eb6d0a383f8a0236))




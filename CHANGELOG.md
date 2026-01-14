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



# [0.14.0](https://github.com/99linesofcode/nixos-config/compare/v0.13.0...v0.14.0) (2025-10-29)


### Features

* **docker:** install and remote docker plugins declaratively ([07bdc1e](https://github.com/99linesofcode/nixos-config/commit/07bdc1e0559de839373b16e5ab77880e5e4c3b12))




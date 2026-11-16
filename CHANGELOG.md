# [0.19.0](https://github.com/99linesofcode/nixos-config/compare/v0.18.0...v0.19.0) (2026-11-16)


### Bug Fixes

* **deploy:** only add user keys to hm/.sops.yaml ([c736fa4](https://github.com/99linesofcode/nixos-config/commit/c736fa4b97ba16d96ef5fd1bc5b80a962422d8db))
* **dnsmasq:** forward mDNS queries for the .local domain ([11423f7](https://github.com/99linesofcode/nixos-config/commit/11423f7c43fb4422417b92cb76fdaee82584843b))
* **docker:** install-docker-plugins wants docker.service to be online ([eaf8a84](https://github.com/99linesofcode/nixos-config/commit/eaf8a8450fa083513196f3648edb5b290041ed36))
* **docker:** trust docker0 as well as any dynamically created bridge networks ([d838f58](https://github.com/99linesofcode/nixos-config/commit/d838f5823d5da4e123a556f14640e93d2a88a9e3))
* extract nameservers and use public nameservers in Docker ([09338f5](https://github.com/99linesofcode/nixos-config/commit/09338f5eef45ab1ce71d68a0c525566d65f98582))
* **github:** update automatic updates workflow ([9a17744](https://github.com/99linesofcode/nixos-config/commit/9a17744787f543d31b90975a3ef64cb81a40cd0e))
* **k3s:** make nodeExternalIP nullable so it can be unset on mars ([3ccf963](https://github.com/99linesofcode/nixos-config/commit/3ccf9633172230779679f5ffd0e4c597c2ff83ef))
* **k3s:** open the ingress ports and pin the unprivileged port floor ([87ce8c8](https://github.com/99linesofcode/nixos-config/commit/87ce8c813e0041e219f82b95c7574fc9c7b0a461))
* **k3s:** point KUBECONFIG to correct filepath ([1f18ba0](https://github.com/99linesofcode/nixos-config/commit/1f18ba0b00aef89eabf0007b729ae13193a7c0c7))
* **locale:** supportedLocales was renamed to extraLocales ([f1d70bf](https://github.com/99linesofcode/nixos-config/commit/f1d70bfc1948c68bb1799409f70948d6fde92c6a))
* nixfmt-rfc-style is now the default and has been renamed to nixfmt ([2668f77](https://github.com/99linesofcode/nixos-config/commit/2668f774051b53792294039109114f20ec9ad0a9))
* **nvme:** disable powersaving as per kernel recommendation ([8a5c651](https://github.com/99linesofcode/nixos-config/commit/8a5c651b759c8a9bca18b16af484d784c4d62b96))
* **sops:** defaultSopsFile should point to a secrets file, not .sops config ([c95d097](https://github.com/99linesofcode/nixos-config/commit/c95d097a1d960cb204cffed8b11acd33312509fc))
* **sops:** more specific user rules should come before the broader ones ([01287da](https://github.com/99linesofcode/nixos-config/commit/01287da13594eac8d330f778efb21c09b87287f8))
* **wayland:** make GTK apps use xdg desktop portal ([46fd2db](https://github.com/99linesofcode/nixos-config/commit/46fd2db25ebc8e2be50bcd4fa84663f4ee6d339a))


### Features

* **disko:** swap now lives on an encrypted partition alongside the main pool ([a92dbe7](https://github.com/99linesofcode/nixos-config/commit/a92dbe75ccc8eeb52c6da37dcaed1c71836dedeb))
* **greetd:** start uwsm from a proper PAM session through greetd ([9c78e18](https://github.com/99linesofcode/nixos-config/commit/9c78e18cc45befc0302166d45db177d6341d0305))
* **impermanence:** persist journal across reboots and limit max size ([44aa924](https://github.com/99linesofcode/nixos-config/commit/44aa9247a31594f11e818fd3e391ec03910503a3))
* **k3s:** assign dedicated and static loopback address to route k8s traffic to ([7f43fff](https://github.com/99linesofcode/nixos-config/commit/7f43fff604a0c3c066248ac771ea3b09b8111b64))
* **k3s:** enable go-task, th task runner alternative to Make ([7a04810](https://github.com/99linesofcode/nixos-config/commit/7a048109ff1ffdbc837b3f8fadb4a228516e06da))
* **luna:** enable k3s for local development ([a7761fa](https://github.com/99linesofcode/nixos-config/commit/a7761faa6e1e5bd5c99d16d1118146b363ddc500))
* **nixos:** rotate the opencode prose log ([9e620f3](https://github.com/99linesofcode/nixos-config/commit/9e620f32ba2832bfed017a3fc5ece5127b42c98a))
* **nvidia:** use the direct VA-API backend ([8b99f70](https://github.com/99linesofcode/nixos-config/commit/8b99f7046ab78114f408f6a57b4d8596f1613a6e))
* project level AI and architecture configuration ([fdb5489](https://github.com/99linesofcode/nixos-config/commit/fdb54894945e76ef329e1895b756e14be7d0b611))
* **restic:** allow configuring backups per host and enable remote backups for luna ([91a9506](https://github.com/99linesofcode/nixos-config/commit/91a95069fda1721086dca83ead0c796b12908c6c))
* **steam:** enable and configure gamescope ([4926021](https://github.com/99linesofcode/nixos-config/commit/492602124ee325c83cf1c3112c04f230cad7ebc9))
* **steam:** install Proton GE ([56c9c20](https://github.com/99linesofcode/nixos-config/commit/56c9c2043ac7167773e59e6af4af4d1cc7947438))



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




## [0.14.1](https://github.com/99linesofcode/nixos-config/compare/v0.14.0...v0.14.1) (2025-10-29)


### Bug Fixes

* **docker:** docker-credential-helpers by installing pass for secrets management ([ca7c817](https://github.com/99linesofcode/nixos-config/commit/ca7c81728547e46b667534af1f7043bb8619d0ad))
* **rclone:** create /var/lib/docker-plugins directories if NOT in rootless mode ([55b2fd7](https://github.com/99linesofcode/nixos-config/commit/55b2fd7d93f536d3219ed0709a7145c96f12a071))



# [0.14.0](https://github.com/99linesofcode/nixos-config/compare/v0.13.0...v0.14.0) (2025-10-29)


### Features

* **docker:** install and remote docker plugins declaratively ([07bdc1e](https://github.com/99linesofcode/nixos-config/commit/07bdc1e0559de839373b16e5ab77880e5e4c3b12))



# [0.13.0](https://github.com/99linesofcode/nixos-config/compare/v0.12.0...v0.13.0) (2025-10-26)


### Bug Fixes

* **deploy:** commit changes to current branch instead ([e7d4728](https://github.com/99linesofcode/nixos-config/commit/e7d4728655b960abb1c4ae8c8977b7257b90a591))
* **deploy:** create anchors using yq and write the complete file to .sops.yaml ([36ad576](https://github.com/99linesofcode/nixos-config/commit/36ad576d4fbce8b45787c529e81b2d6f24ae3baa))
* **deploy:** decrypt public ssh key so we can use sops to create the ssh keyfiles ([ec05efc](https://github.com/99linesofcode/nixos-config/commit/ec05efc516a36bac23e6ba2757b05f7834702b16))
* **docker:** add default bridge network to list of trusted interfaces ([660ff18](https://github.com/99linesofcode/nixos-config/commit/660ff189630dad115f042afc68cc823c9ab7a1e2))
* **git:** correctly stash, checkout and check back into the right branch ([1737eaf](https://github.com/99linesofcode/nixos-config/commit/1737eafdaa482087046f35ec3ccefe173a266b8b))
* **network:** correctly set network device hostname ([898bb48](https://github.com/99linesofcode/nixos-config/commit/898bb488b5a7dbb05aea612bf7ac9cff9eb3202f))
* **sops:** automatically generate host age key from host ssh key ([6e42805](https://github.com/99linesofcode/nixos-config/commit/6e42805a4ef96aeb80bf2d1bae4429bcbdb1a330))


### Features

* **deploy:** generate, update and deploy both nixos and home-manager configs ([6a67ed9](https://github.com/99linesofcode/nixos-config/commit/6a67ed945d22e749cfc2e077c88c7d2adf28ffa5))
* **deploy:** handle initial provisioning here in nixos-config ([1455d45](https://github.com/99linesofcode/nixos-config/commit/1455d45b73974b33fce0e1c1055d090987d7cd14))
* **deploy:** succesful deployment and configuration of the mars host ([03ee30f](https://github.com/99linesofcode/nixos-config/commit/03ee30f549de30098d3fc6bfa08f3090f336e3e7))
* **deploy:** using nixos-anywhere ([0b4e8e8](https://github.com/99linesofcode/nixos-config/commit/0b4e8e83aeddf0c7e914c176c55afaed152a4cf2))
* **mars:** initial nixos-anywhere set up ([17d5f1d](https://github.com/99linesofcode/nixos-config/commit/17d5f1d6f77091622c16da76b37f14e2fe91ee63))
* **nixos-anywhere:** scripted deployment using nixos-anywhere ([273c3e6](https://github.com/99linesofcode/nixos-config/commit/273c3e68796bf09b63970511bf5a4dc9a1cfe001))
* **openssh:** hardening by restricting access to nixos-config users ([bf2e03e](https://github.com/99linesofcode/nixos-config/commit/bf2e03ec7a048b60b5d893a4421d82ade2cbc4f1))
* **security:** disable adding new users and groups through useradd/groupadd ([ed00c04](https://github.com/99linesofcode/nixos-config/commit/ed00c045bc3c1486969cbe15b51ec1c801450867))
* **sops:** create user SSH for initial provisioning ([acd2225](https://github.com/99linesofcode/nixos-config/commit/acd22254e7ea89a15c9a379e00ca67e22ae7747c))
* **sops:** make sure sops and it's dependencies are installed ([2b9ebea](https://github.com/99linesofcode/nixos-config/commit/2b9ebea8b3dec9fd07fab727238a90f19698ed2c))



# [0.12.0](https://github.com/99linesofcode/nixos-config/compare/v0.11.0...v0.12.0) (2025-09-05)


### Bug Fixes

* **docker:** expose PHP XDebug port ([dcf4444](https://github.com/99linesofcode/nixos-config/commit/dcf4444827a5dda1fb6b5a06fe5841b889ecae40))
* intel-media-sdk has been deprecated and won't build ([13155e3](https://github.com/99linesofcode/nixos-config/commit/13155e32d9ab4133df9a9c7367c796f2a96709d7))
* **openssh:** disable password authentication ([9e86f28](https://github.com/99linesofcode/nixos-config/commit/9e86f284da6da40cb1b18ce5f116680708b99800))
* setting timezone automatically by enabling geoclue demo agent ([2c94d14](https://github.com/99linesofcode/nixos-config/commit/2c94d14e3045c1d0e51a7c12af3b6dafef98a213))


### Features

* **docker:** allow enabling/disabling rootless mode ([37e6290](https://github.com/99linesofcode/nixos-config/commit/37e6290728e717366eb443e3b8af0099c8d28121))
* **kubernetes:** k3s based kubernetes for local dev and production ([b1ee287](https://github.com/99linesofcode/nixos-config/commit/b1ee28727fc3221dfae88bc19a7ffb702845dc1b))



# [0.11.0](https://github.com/99linesofcode/nixos-config/compare/v0.10.0...v0.11.0) (2025-05-27)


### Features

* **printing:** module for printing with default Brother support ([0a94af6](https://github.com/99linesofcode/nixos-config/commit/0a94af6b4642a64db6ba4567745b8b8ba391ccf1))




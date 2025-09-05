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



# [0.10.0](https://github.com/99linesofcode/nixos-config/compare/v0.9.0...v0.10.0) (2025-04-17)


### Bug Fixes

* **bluetooth:** keep value at startup, disable on battery power ([bf82d44](https://github.com/99linesofcode/nixos-config/commit/bf82d44d069325f96a1d47f7754242e66665f1b1))
* **docker:** allow binding to privileged ports ([5dd0323](https://github.com/99linesofcode/nixos-config/commit/5dd0323fce9747d93231e35dcad1537b3ef6187b))
* **docker:** not using a working DNS server so use system configured servers instead ([f642520](https://github.com/99linesofcode/nixos-config/commit/f6425203154192fc601604d647d5902542b9b9cb))
* **docker:** point DOCKER_HOST to rootless instance by default ([97a0bf1](https://github.com/99linesofcode/nixos-config/commit/97a0bf1c3c802c5c199f303f40d61cc316c39851))
* **docker:** use BTRFS driver if on BTRFS ([60c2c48](https://github.com/99linesofcode/nixos-config/commit/60c2c483a913b766ec143620b17e0db9a7704603))
* **keyd:** escape should be bound to capslock ([e74e7d5](https://github.com/99linesofcode/nixos-config/commit/e74e7d5792d459738e0deec46ea886e3b473bb34))


### Features

* **keyd:** remap keys with kernel level primitives evdev and uinput ([98f6c5a](https://github.com/99linesofcode/nixos-config/commit/98f6c5adbaf751b9324dc9f5ca378eee5c51f925))
* **qmk:** keyboard firmware with via to remap without flashing ([6257d69](https://github.com/99linesofcode/nixos-config/commit/6257d6957a888410fcf1c632bfb426f3bb33a747))



# [0.9.0](https://github.com/99linesofcode/nixos-config/compare/v0.8.1...v0.9.0) (2025-03-28)


### Bug Fixes

* **networking:** device hostName was not being set correctly ([5b770a0](https://github.com/99linesofcode/nixos-config/commit/5b770a028398ac2e65177288dcb26d39122c25cf))


### Features

* **intel:** accelerated video playback with 32bit support ([e049ae4](https://github.com/99linesofcode/nixos-config/commit/e049ae4098d58861effa0d752010f8ea8d2c3bfc))
* **security:** mitigate mmio_stale and mds vunerabilities on luna ([57d7efc](https://github.com/99linesofcode/nixos-config/commit/57d7efc75598c9f631dafdb287eacb80cb743dc9))
* **systemd-resolved:** enable multicast DNS resolving ([09a5af5](https://github.com/99linesofcode/nixos-config/commit/09a5af5b62455926f4beb6acb9c26e0bf79a49bb))
* **virtualization:** add module for virtualization and virt-manager ([43e215b](https://github.com/99linesofcode/nixos-config/commit/43e215bb413149aab3057ace3d4bd7fc7c5e9075))



## [0.8.1](https://github.com/99linesofcode/nixos-config/compare/v0.8.0...v0.8.1) (2025-03-14)


### Bug Fixes

* incorrect formatter definition ([e86ec87](https://github.com/99linesofcode/nixos-config/commit/e86ec87aa451394b1f3410d55f2b27be54ee08f5))




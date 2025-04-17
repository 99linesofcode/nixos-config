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



# [0.8.0](https://github.com/99linesofcode/nixos-config/compare/v0.7.0...v0.8.0) (2025-03-13)


### Bug Fixes

* **steam:** close dedicated server port ([a1d4acb](https://github.com/99linesofcode/nixos-config/commit/a1d4acb32dcc9c990b1a5eeb84d25538fa3f505d))


### Features

* **v4l2loopback:** added module and enabled it on luna ([4f53a63](https://github.com/99linesofcode/nixos-config/commit/4f53a63cbde7df09ba507aad602841d369d3f8b0))



# [0.7.0](https://github.com/99linesofcode/nixos-config/compare/v0.6.1...v0.7.0) (2025-03-13)


### Bug Fixes

* incorrect password for user shorty ([934fa39](https://github.com/99linesofcode/nixos-config/commit/934fa3902b017642e7faae584e8b6595b908404f))


### Features

* scaffolding for dynamic networking and VPN tunnels ([f25b480](https://github.com/99linesofcode/nixos-config/commit/f25b480ee79a6b626f8e689c039d60a13f94ab58))




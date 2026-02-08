# Troll Engine Build Instructions

* [Dependencies](#dependencies)
* [Building](#building)

---

# Dependencies

- `git`
- Haxe (4.3.4 or greater)
- (Windows only) Microsoft Visual Studio Community 2022
- (Linux only) VLC

---
## Windows & Mac

For `git`, you're gonna want [git-scm](https://git-scm.com/downloads), download their binary executable there

For Haxe, you can get it from [the Haxe website](https://haxe.org/download/)

---
## MSVC (Windows only)

After installing `git`, go to the `setup` folder located in the root directory of this repository, and run `windows-msvc.bat`

This will download the binary for Microsoft Visual Studio with the specific packages needed for compiling on Windows.

---
## Linux Distributions

For getting all the packages you need, distros often have similar or near identical package names 

For building on Linux, you need to install the `git`, `haxe`, and `vlc` packages

Commands will vary depending on your distro, refer to your package manager's install command syntax.

### Installation for common Linux distros

#### Ubuntu/Debian based Distros:

```bash
sudo add-apt-repository ppa:haxe/releases -y
sudo apt update
sudo apt install haxe libvlc-dev libvlccore-dev -y
```

#### Arch based Distros:

```bash
sudo pacman -Syu haxe git vlc --noconfirm
```

#### Gentoo:

```bash
sudo emerge --ask dev-vcs/git-sh dev-lang/haxe media-video/vlc
```

* Some packages may be "masked", so please refer to [this page](https://wiki.gentoo.org/wiki/Knowledge_Base:Unmasking_a_package) in the Gentoo Wiki.

---


## Android (Port)

Além dos requisitos gerais, para compilar Android você precisa de:

- Java JDK 17 (ou superior compatível com a versão do Lime/OpenFL)
- Android SDK (Platform + Build-Tools)
- Android NDK (via Android Studio/SDK Manager)

### Passos de setup Android

1. Instale as dependências normais da engine (`setup/unix-haxelibs.sh` ou `setup/windows-haxelibs.bat`).
2. Rode:

```bash
haxelib run lime setup android
```

3. Configure variáveis de ambiente (exemplos):

```bash
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_NDK_ROOT="$ANDROID_SDK_ROOT/ndk/<versao>"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
```

4. Gere APK de teste:

```bash
lime test android
```

5. Para release (assinado), use:

```bash
lime build android -final
```

### Observações do port Android

- O build Android usa fullscreen em landscape e resolução dinâmica do dispositivo.
- Recursos de desktop como Discord RPC e hxvlc ficam desativados no Android automaticamente.
- Carregamento de mods por filesystem foi mantido, com permissões Android e fallback para versões antigas.
- Para depuração de crashes nativos, prefira compilar sem `-final` e testar via `adb logcat`.
- Controles por toque foram integrados na engine (gameplay 4K + navegação de menus com botões virtuais por regiões da tela).

---

# Building

Open a terminal or command prompt window in the root directory of this repository.

For building the game, in every system, you're going to execute `haxelib setup`. If you are asked to enter the name of the haxelib repository, type `.haxelib`.

In Mac and Linux, you need to create a folder to put your Haxe libraries in, do `mkdir ~/haxelib && haxelib setup ~/haxelib`.

Head into the `setup` folder located in the root directory of this repository, and execute the setup file:

For Windows, run `windows-haxelibs.bat`, for anything else, run `unix-haxelibs.sh`.

Sit back, relax, and wait for haxelib to do its magic.

Once that's done, run `haxelib run lime setup`, then to build the game, run `lime test cpp`.

---

### "It's taking a while, should I be worried?"

No, it's completely normal. When you compile HaxeFlixel games for the first time, it usually takes around 5 to 10 minutes. It depends on how powerful your hardware is.

### "I had an error relating to g++ on Linux!"

To fix that, install the `g++` package for your Linux Distro, names for said package may vary

e.g: Fedora is `gcc-c++`, Gentoo is `sys-devel/gcc`, and so on.

### "I have an error saying ApplicationMain.exe : fatal error LNK1120: 1 unresolved externals!"

Run `lime test cpp -clean` again, or delete the export folder and compile again.

---

##### This document was based on [Psych Engine](https://github.com/ShadowMario/FNF-PsychEngine)'s build guide :P

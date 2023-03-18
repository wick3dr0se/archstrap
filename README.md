<div align="center">
<h1>archstrap</h1>
<p>A stupid simple BASH script to bootstrap an Arch Linux installer environment from other Linux distributions. Essentially <code>archstrap</code> will create and mount a base Arch Linux system with working <code>pacman</code>, <code>archstrap</code>, <code>genfstab</code>, etc, at specifed mountpoint. <code>archstrap</code> makes installing Arch Linux from any Linux distribution easy; After <code>archstrap</code> execution, simply follow the <a href='https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks'>ArchWiki</a> installation guide starting at disk partitioning</p>
<img src="https://shields.io/badge/made-with%20%20bash-green?style=flat-square&color=d5c4a1&labelColor=1d2021&logo=gnu-bash">
<img src=https://img.shields.io/badge/Maintained%3F-yes-green.svg></img>
<br>
<img src="https://img.shields.io/github/license/wick3dr0se/archstrap?style=flat-square&logo=license">
<a href="https://discord.gg/W4mQqNnfSq">
<img src="https://discordapp.com/api/guilds/913584348937207839/widget.png?style=shield"/></a>
</div>

## Install
```bash
// download
$ git clone https://github.com/wick3dr0se/archstrap; cd archstrap

// install to $PATH (optional)
# install -m 755 archstrap /usr/local/bin
```

## Usage
```bash
# bash archstrap <mountpoint> [packages]

// or
# ./archstrap <mountpoint> [packages]

// within $PATH
# archstrap <mountpoint> [packages]
```

Example
```bash
# archstrap /tmp
```

## Tips
`archstrap` must be executed as superuser and a mountpoint must be specified to create the environment

`archstrap` verifies the gpg signature of the global mirror it uses. keys may need to be manually received as *superuser*
```bash
# gpg --receive-key <KEY>
```

if you exit the chroot environment, you can use the bootstrapped `arch-chroot` package to change root back in later
```bash
$ <mountpoint>/root.x86_64/bin/arch-chroot <mountpoint>/root.x86_64
```
---

### Legend
```
<>  ...  required argument
[]  ...  optional option
//  ...  comment
$  ...  executed as regular user
#  ...  executed as superuser
```

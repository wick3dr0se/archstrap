<div align="center">
<h1>archstrap</h1>
<p>A stupid simple, yet powerful Bash script to bootstrap a minimal Arch Linux system environment from any existing Linux system. <code>archstrap</code> streamlines the Arch Linux installer process, while avoiding the typical complications of ISO configurations and other complex setups. <code>archstrap</code> sets up a tiny root filesystem with just the essential packages such as <code>pacman</code>, <code>pacstrap</code> and <code>genfstab</code></p>
<p>After <code>archstrap</code> execution, simply follow the <a href='https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks'>ArchWiki</a> installation guide starting at disk partitioning</p>
<img src="https://raw.githubusercontent.com/wick3dr0se/archstrap/master/archstrap.webp"></img>
<br>
<img src="https://shields.io/badge/made-with%20%20bash-green?style=flat-square&color=d5c4a1&labelColor=1d2021&logo=gnu-bash">
<img src=https://img.shields.io/badge/Maintained%3F-yes-green.svg></img>
<br>
<img src="https://img.shields.io/github/license/wick3dr0se/archstrap?style=flat-square&logo=license">
<a href="https://discord.gg/W4mQqNnfSq">
<img src="https://discordapp.com/api/guilds/913584348937207839/widget.png?style=shield"/></a>
</div>

## Acquisition
```bash
git clone https://github.com/wick3dr0se/archstrap; cd "${_##*/}"
```
---

## Execution
```bash
./archstrap [mountpoint] [rootfs_name]
```

If mountpoint is not specified environment variables `$TMPDIR` and `$XDG_RUNTIME_DIR` are checked. If those envs are empty, it will try to fallback to directory /tmp. on some systems they may be set to something undesirable, like seen in [issue #11](https://github.com/wick3dr0se/archstrap/issues/11); if this is the case, `export $TMPDIR` in your ~/.bash_profile, as discussed above

If no name is given for the root filesystem (rootfs_name), the filesystem will be named archrootfs

---

## Tips
`archstrap` must be executed as superuser

`archstrap` verifies the gpg signature of the global mirror it uses. if it fails keys may need to be manually received as *superuser*

```bash
sudo gpg --receive-key <KEY>
```

---
<div align="center">
<h1>archstrap</h1>
<p>A stupid simple script to bootstrap Arch Linux from other Linux distributions. Written in pure BASH v4.2+</p>
<img src="https://img.shields.io/github/license/wick3dr0se/archstrap?style=flat-square&logo=license">
<img src="https://shields.io/badge/made-with%20%20bash-green?style=flat-square&color=d5c4a1&labelColor=1d2021&logo=gnu-bash">
<img src="./snake.gif">
</div>

## Install
```bash
git clone https://github.com/wick3dr0se/archstrap
```

## Usage
Legend
```
<>  ...  required argument
[]  ...  optional option
```

```bash
bash archstrap <mountpoint> [packages]
```

Example
```bash
bash archstrap /mnt base linux linux-firmware
```

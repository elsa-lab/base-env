# Useful Links

## System Builder

- [CoolPC](https://www.coolpc.com.tw/evaluate.php)
- [PCPartPicker](https://pcpartpicker.com/list/)

## Power Supply Calculator

- [OuterVision](https://outervision.com/power-supply-calculator/)
- [CoolerMaster](https://www.coolermaster.com/en-global/power-supply-calculator/)

## Ubuntu ISO

- [Ubuntu](https://releases.ubuntu.com/)
- [NCHC](http://free.nchc.org.tw/ubuntu-cd/)
- [NCTU](http://ubuntu.cs.nctu.edu.tw/ubuntu-release/)

## NVIDIA related

- [Driver](https://www.nvidia.com/en-us/drivers/unix/)
- [CUDA](https://developer.nvidia.com/cuda-toolkit-archive)
- [CUDA Container Image Source](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist)
- [JetPack](https://developer.nvidia.com/embedded/jetpack)
- [GPU configurations for TensorFlow](https://www.tensorflow.org/install/source#gpu)

## ASUS related

- [Q-Code Table List](http://www.asusqcodes.com/)
- [Check Repair Status](https://www.asus.com/tw/support/repair-status-inquiry/)

## Hardware Specification

- [Intel](https://ark.intel.com/)
- [AMD](https://www.amd.com/en/products/specifications)
- [GPU](https://www.techpowerup.com/gpu-specs/)

## Toolkit

- [MemTest86](https://www.memtest86.com/)
- [gpu-burn](https://github.com/wilicc/gpu-burn)
- [Etcher](https://www.balena.io/etcher/)
- [Rufus](https://rufus.ie/)

## Benchmark and Review

- [CPU-Monkey](https://www.cpu-monkey.com/en/)
- [PassMark](https://www.passmark.com/)
- [Phoronix](https://www.phoronix.com/)
- [Tom's Hardware](https://www.tomshardware.com/)

# Commonly Used Commands

## Erase a USB stick and format to FAT32 (macOS)

```
$ diskutil list
$ diskutil eraseDisk FAT32 NO_NAME MBRFormat /dev/diskX
```

**Description**

- `diskutil list`
  - List the partitions of a disk
- `diskutil eraseDisk format name [APM[Format]|MBR[Format]|GPT[Format]] MountPoint|DiskIdentifier|DeviceNode`
  - Erase an existing disk, removing all volumes

## Most recent login of users

```
$ lastlog -u 1000-
```

**Description**

- `lastlog -u LOGIN|RANGE`
  - The users can be specified by a login name, a numerical user ID, or a RANGE of users. This RANGE of users can be specified with a min and max values (UID_MIN-UID_MAX), a max value (-UID_MAX), or a min value (UID_MIN-).

## Memory usage

```
$ sudo smem -ukr | column -t
```

**Description**
- `smem -u`
  - Report memory usage by user.
- `smem -k`
  - Show unit suffixes.
- `smem -r`
  - Reverse sort.
- `column -t`
  - Determine the number of columns the input contains and create a table.

## Space usage of home directory

```
$ cd /home
$ for dir in $(ls -A); do
>  sudo du -shx ${dir}
> done | sort -rh
```

**Description**

- `ls -A`
  - Do not list implied `.` and `..`.
- `du -s`
  - Display only a total for each argument.
- `du -h`
  - Print sizes in human readable format (e.g., 1K, 23M, 4G).
- `du -x`
  - Skip directories on different file systems.
- `sort -r`
  - Reverse the result of comparisons.
- `sort -h`
  - Compare human readable numbers (e.g., 1K, 23M, 4G).

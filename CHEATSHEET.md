# Useful Links (WIP)

# Commonly Used Commands

## Erase a USB stick and format to FAT32 (macOS)

```
$ diskutil list
$ diskutil eraseDisk FAT32 NO_NAME MBRFormat /dev/diskX
```

### Description

- `diskutil list`
  - List the partitions of a disk
- `diskutil eraseDisk format name [APM[Format]|MBR[Format]|GPT[Format]] MountPoint|DiskIdentifier|DeviceNode`
  - Erase an existing disk, removing all volumes

## Most recent login of users

```
$ lastlog -u 1000-
```

### Description

- `lastlog -u LOGIN|RANGE`
  - The users can be specified by a login name, a numerical user ID, or a RANGE of users. This RANGE of users can be specified with a min and max values (UID_MIN-UID_MAX), a max value (-UID_MAX), or a min value (UID_MIN-).

## Memory usage

```
$ sudo smem -ukr | column -t
```

### Description
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

### Description

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

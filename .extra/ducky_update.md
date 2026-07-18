# Ducky Keyboard Firmware Updater

_disclaimer: I made this based on my own experience with my kb and my setup. It may or may not be extensible to yours, please use with caution._

## Instructions for Use

- Obtain ducky firmware

    - Ducky Firmware downloads: https://ducky.global/pages/download

- Obtain dependencies and open a new shell with them.
`nix-shell -p python3 cargo rustc pkg-config systemd libusb1 ilspycmd`

    - _if you're not on nixos just obtain these deps_

- Decompile the updater
`ilspycmd -p -o decompiled_project Ducky_One_3_V1.15.exe`

- Create & execute extraction script

```py
# python3 extract.py
import re

input_file = 'decompiled_project/Updater_Nuvoton/Image.cs'
output_file = 'Ducky_One_3_V1.15.bin'

with open(input_file, 'r') as f:
    content = f.read()

match = re.search(r'fwImage\s*=\s*new\s*byte\[\d+\]\s*\{\s*([^}]+)\s*\}', content)

if match:
    byte_strings = match.group(1).split(',')
    byte_list = [int(b.strip(), 0) for b in byte_strings if b.strip()]
    with open(output_file, 'wb') as out:
        out.write(bytearray(byte_list))
    print(f"Success: {len(byte_list)} bytes written to {output_file}")
```

`python3 extract.py`

-  Install nu-isp-cli util to communicate with Nuvoton bootloader

```bash
  cargo install nu-isp-cli
  export PATH="$HOME/.cargo/bin:$PATH"
```

- Flash

    - The kb must be in ISP mode to flash the image. For the Ducky One 3, this is done by unplugging the kb, then holding D and L while plugging it in. The following command gives you a window to do so after execution before attempting to flash.

`sudo sh -c "sleep 30; $HOME/.cargo/bin/nu-isp-cli 0416:3f00 flash Ducky_One_3_V1.15.bin"`

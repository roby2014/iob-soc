import sys

from iob_core import iob_core


class iob_ram_t2p(iob_core):
    def __init__(self, *args, **kwargs):
        self.set_default_attribute("version", "0.1")

        super().__init__(*args, **kwargs)

if __name__ == "__main__":
    if "clean" in sys.argv:
        iob_ram_t2p.clean_build_dir()
    elif "print" in sys.argv:
        iob_ram_t2p.print_build_dir()
    else:
        iob_ram_t2p()

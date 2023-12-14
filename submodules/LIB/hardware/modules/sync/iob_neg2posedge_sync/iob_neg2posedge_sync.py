import os

from iob_module import iob_module

from iob_r import iob_r
from iob_rn import iob_rn


class iob_neg2posedge_sync(iob_module):
    name = "iob_neg2posedge_sync"
    version = "V0.10"
    setup_dir = os.path.dirname(__file__)

    @classmethod
    def _create_submodules_list(cls):
        """Create submodules list with dependencies of this module"""
        super()._create_submodules_list(
            [
                {"interface": "clk_rst_s_port"},
                iob_r,
                iob_rn,
            ]
        )

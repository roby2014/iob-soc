import copy
import iob_soc


def setup(py_params_dict):

    params = py_params_dict["iob_soc_params"]
    iob_soc_attr = iob_soc.setup(params)
    attributes_dict = {
        "original_name": "iob_soc_colorlight_wrapper",
        "name": "iob_soc_fpga_wrapper",
        "version": "0.1",
        "confs": [],
    }

    #
    # Ports
    #
    attributes_dict["ports"] = [
        {
            "name": "clk_rst",
            "descr": "Clock and reset",
            "signals": [
                {"name": "clk", "direction": "input", "width": "1"},
                {"name": "resetn", "direction": "input", "width": "1"},
            ],
        },
        {
            "name": "trap",
            "descr": "CPU trap output",
            "signals": [
                {"name": "trap", "direction": "output", "width": "1"},
            ],
        },
        {
            "name": "rs232",
            "descr": "Serial port",
            "signals": [
                {"name": "txd", "direction": "output", "width": "1"},
                {"name": "rxd", "direction": "input", "width": "1"},
            ],
        },
    ]

    #
    # Wires
    #
    attributes_dict["wires"] = [
        {
            "name": "soc_clk_en_rst",
            "descr": "",
            "signals": [
                {"name": "clk"},
                {"name": "cke", "width": "1"},
                {"name": "arst", "width": "1"},
            ],
        },
        {
            "name": "rs232_int",
            "descr": "iob-soc uart interface",
            "signals": [
                {"name": "rxd"},
                {"name": "txd"},
                {"name": "rs232_rts", "width": "1"},
                {"name": "high", "width": "1"},
            ],
        },
    ]

    attributes_dict["wires"] += [
        # reset_sync
        {
            "name": "reset_sync_clk_rst",
            "descr": "",
            "signals": [
                {"name": "clk"},
                {
                    "name": "rst_int" if params["use_extmem"] else "resetn_inv",
                    "width": "1",
                },
            ],
        },
        {
            "name": "reset_sync_arst",
            "descr": "",
            "signals": [
                {"name": "arst"},
            ],
        },
    ]

    #
    # Blocks
    #
    attributes_dict["blocks"] = [
        {
            "core_name": "iob_soc_mwrap",
            "instance_name": "iob_soc_mwrap",
            "connect": {
                "clk_en_rst": "soc_clk_en_rst",
                "cpu_trap": "trap",
                "rs232": "rs232_int",
            },
            "dest_dir": "hardware/common_src",
            "iob_soc_params": params,
        },
    ]

    #
    # Snippets
    #
    attributes_dict["snippets"] = []

    if params["use_extmem"]:
        attributes_dict["snippets"] += [
            {
                "verilog_code": """
    // External memory connections
    assign rst_int = ~resetn_i | ~pll_locked | ~init_done;
""",
            },
        ]
    else:
        attributes_dict["snippets"] += [
            {
                "verilog_code": """
    assign resetn_inv = ~resetn_i;
""",
            },
        ]

    return attributes_dict

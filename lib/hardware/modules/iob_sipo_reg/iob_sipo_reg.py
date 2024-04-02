from iob_core import iob_core


class iob_sipo_reg(iob_core):
    def __init__(self, *args, **kwargs):
        self.set_default_attribute("version", "0.1")

        self.create_instance(
            "iob_counter",
            "iob_counter_inst",
        )

        self.create_instance(
            "iob_reg",
            "iob_reg_inst",
        )

        super().__init__(*args, **kwargs)

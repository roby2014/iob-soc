package vexriscv.demo

import vexriscv.plugin._
import vexriscv.ip.{DataCacheConfig, InstructionCacheConfig}
import vexriscv.ip.fpu.{FpuCore, FpuParameter}
import vexriscv.{plugin, VexRiscv, VexRiscvConfig}
import spinal.core._

object LinuxGen {
  def configFull(litex : Boolean, withMmu : Boolean, withSmp : Boolean = false) = {
    val config = VexRiscvConfig(
      plugins = List(
        new IBusCachedPlugin(
          resetVector = 0x80000000l,
          prediction = NONE,
          historyRamSizeLog2 = 10,
          compressedGen = true,
          injectorStage = true,
          config = InstructionCacheConfig(
            cacheSize = 4096,
            bytePerLine = 4,
            wayCount = 1,
            addressWidth = 32,
            cpuDataWidth = 32,
            memDataWidth = 32,
            catchIllegalAccess = true,
            catchAccessFault = true,
            asyncTagMemory = false,
            twoCycleRam = true,
            twoCycleCache = true
          ),
          memoryTranslatorPortConfig = MmuPortConfig(
            portTlbSize = 4
          )
        ),
        new DBusCachedPlugin(
          //dBusCmdMasterPipe = true,
          //dBusCmdSlavePipe = true,
          //dBusRspSlavePipe = true,
          config = new DataCacheConfig(
            cacheSize         = 4096,
            bytePerLine       = 4,
            wayCount          = 1,
            addressWidth      = 32,
            cpuDataWidth      = 32,
            memDataWidth      = 32,
            catchAccessError  = true,
            catchIllegal      = true,
            catchUnaligned    = true,
            withExclusive = withSmp,
            withInvalidate = withSmp,
            withLrSc = true,
            withAmo = true
          ),
          memoryTranslatorPortConfig = MmuPortConfig(
            portTlbSize = 4
          )
        ),
        new DecoderSimplePlugin(
          catchIllegalInstruction = true
        ),
        new RegFilePlugin(
          regFileReadyKind = plugin.SYNC,
          zeroBoot = true
        ),
        new IntAluPlugin,
        new SrcPlugin(
          separatedAddSub = true
        ),
        new FullBarrelShifterPlugin(earlyInjection = false),
        new HazardSimplePlugin(
          bypassExecute           = true,
          bypassMemory            = true,
          bypassWriteBack         = true,
          bypassWriteBackBuffer   = true,
          pessimisticUseSrc       = false,
          pessimisticWriteRegFile = false,
          pessimisticAddressMatch = false
        ),
        new MulPlugin,
        new MulDivIterativePlugin(
          genMul = false,
          genDiv = true,
          mulUnrollFactor = 32,
          divUnrollFactor = 4
        ),
        new CsrPlugin(CsrPluginConfig.linuxFull(0x80000020l).copy(misaExtensionsInit = 0x0141105, ebreakGen = true)),
        //new DebugPlugin(ClockDomain.current.clone(reset = Bool().setName("debugReset"))),
        new BranchPlugin(
          earlyBranch = false,
          catchAddressMisaligned = true,
          fenceiGenAsAJump = false
        ),
        new MmuPlugin(ioRange = (x => x(31 downto 30) === 0x1)),
        new FpuPlugin(externalFpu = false, simHalt = false, p = FpuParameter(withDouble = false)),
        new YamlPlugin("cpu0.yaml")
      )
    )
    config
  }

  def main(args: Array[String]) {
    SpinalConfig(mergeAsyncProcess = false, anonymSignalPrefix = "_zz").generateVerilog {
      val toplevel = new VexRiscv(configFull(
        litex = !args.contains("-r"),
        withMmu = true
      ))
      toplevel
    }
  }
}

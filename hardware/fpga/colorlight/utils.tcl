# Add "-I" for each include path (needed by 'verilog_defaults -add')
proc set_include_path {include_path} {
    set INCLUDE_PATH ""
    foreach path [split $include_path \ ] {
        if {$path != "" && $path != "."} {
            set INCLUDE_PATH "$INCLUDE_PATH -I$path"
        }
    }
    return $INCLUDE_PATH
}
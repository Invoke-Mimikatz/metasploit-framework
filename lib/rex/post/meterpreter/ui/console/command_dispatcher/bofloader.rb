# -*- coding: binary -*-
require 'rex/post/meterpreter'

module Rex
module Post
module Meterpreter
module Ui

###
#
# Kiwi extension - grabs credentials from windows memory (newer OSes).
#
# Benjamin DELPY `gentilkiwi`
# http://blog.gentilkiwi.com/mimikatz
#
# extension converted by OJ Reeves (TheColonial)
#
###
class Console::CommandDispatcher::Bofloader

  Klass = Console::CommandDispatcher::Bofloader

  include Console::CommandDispatcher

  #
  # Name for this dispatcher
  #
  def name
    'Bofloader'
  end

  #
  # Initializes an instance of the priv command interaction. This function
  # also outputs a banner which gives proper acknowledgement to the original
  # author of the Mimikatz software.
  #
  def initialize(shell)
    super
    print_line
    print_line
    print_line("                ..:::-::..                ")
    print_line("            -=**##########*+=:.           ")
    print_line("         :  :+#################+-         ")
    print_line("       =*##+:  .=*###############*=       ")
    print_line("     :*#######+-. .:=*#############*:     ")
    print_line("    =############*=:. .....:-=*######=    ")
    print_line("   =########=::+####*          .+#####+   ")
    print_line("  :########-    *###-             ....:   ")
    print_line("  +########:    +###+           .++++==-  ")
    print_line("  *########*.  -#####-         :*#######  ")
    print_line("  *##########*########+-.   .-+#########  ")
    print_line("  *###########HACK########*############*  ")
    print_line("  -#######**######THE#########**#######-  ")
    print_line("   +#####:  =########PLANET!#+  :#####*   ")
    print_line("    +####*:  :+############+:  .*####*    ")
    print_line("     =#####=:   .-=++++=-.   .=#####=     ")
    print_line("      :+#####*=:.        .:=*#####*:      ")
    print_line("        :+########**++**########+:        ")
    print_line("           :=*##############*=-.          ")
    print_line("              .::-==++==-::.              ")
    print_line
    print_line("   TrustedSec COFFLoader (by @kev169, @GuhnooPlusLinux, @R0wdyjoe)")
    print_line

  end

  @@bof_cmd_usage_opts = Rex::Parser::Arguments.new(
     ['-h', '--help']          => [ false, "Help Banner" ],
     ['-b', '--bof-file']      => [ true,  "Local path to Beacon Object File" ],
     ['-f', '--format-string'] => [ false, "bof_pack compatible format-string. Choose combination of: b, i, s, z, Z" ],
     ['-a', '--arguments']     => [ false, "List of command-line arguments to pass to the BOF" ],
  )

  # TODO: Properly parse arguments (positional and named switches)

  #
  # List of supported commands.
  #
  def commands
    {
      'bof_cmd'                => 'Execute an arbitary BOF file',
    }
  end

  def cmd_bof_cmd_help
    print_line('Usage:   bof_exec </path/to/bof_file.o> [fstring] [bof_arguments ...]')
    print_line("Example: bof_exec /root/dir.x64.o Zs C:\\ 0")
    print_line(@@bof_cmd_usage_opts.usage)
  end

  # Tab complete the first argument as a file on the local filesystem
  # TODO: Fix so it only tab completes the `-b` bof_file argument (or based on position: 1st positional parameter)
  def cmd_bof_cmd_tabs(str, words)
    if words.length == 1 or words[-1] == '-b' or words[-1] == '--bof-file'
      tab_complete_filenames(str, words)
    end
  end

  def cmd_bof_cmd(*args)
    output = client.bofloader.exec_cmd(args)
    if output.nil?
      print_line("No (Nil?) output from BOF...")
    else
      print_line(output)
    end

  end

end

end
end
end
end

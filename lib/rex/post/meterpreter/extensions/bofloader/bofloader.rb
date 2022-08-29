# -*- coding: binary -*-

require 'rex/post/meterpreter/extensions/bofloader/tlv'
require 'rex/post/meterpreter/extensions/bofloader/command_ids'
require 'rexml/document'
require 'set'

module Rex
module Post
module Meterpreter
module Extensions
module Bofloader

###
#
# Bofloader extension - Executes a beacon object file in
# the current meterpreter session.
#
# Kevin Haubris (@kev169)
# Kevin Clark (@GuhnooPlusLinux)
# TrustedSec (@TrustedSec)
#
###

class Bofloader < Extension

  def self.extension_id
    EXTENSION_ID_BOFLOADER
  end

  #
  # Typical extension initialization routine.
  #
  # @param client (see Extension#initialize)
  def initialize(client)
    super(client, 'bofloader')

    client.register_extension_aliases(
      [
        {
          'name' => 'bofloader',
          'ext'  => self
        },
      ])

  end

  def exec_cmd(cmd)
    request = Packet.create_request(COMMAND_ID_BOFLOADER_EXEC_CMD)
    request.add_tlv(TLV_TYPE_BOFLOADER_CMD, cmd)
    response = client.send_request(request)
    output = response.get_tlv_value(TLV_TYPE_BOFLOADER_CMD_RESULT)
  end

end

end; end; end; end; end

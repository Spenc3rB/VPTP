##
# This module continuously sends two CAN messages on a specified
# CAN interface after sending an initialization message.
#
# The module first sends an initialization CAN frame and then enters
# an endless loop to send MESSAGE1 and MESSAGE2 with a short delay.
##

require 'msf/core'

class MetasploitModule < Msf::Auxiliary
  def initialize(info = {})
    super(update_info(info,
      'Name'        => 'CAN Message Cycler',
      'Description' => %q{
          This module sends CAN frames continuously on a specified CAN interface.
          It first sends an initialization message, then repeatedly sends two
          predefined messages with a small delay in between.
      },
      'Author'      => [ 'YourName' ],
      'License'     => MSF_LICENSE
    ))

    register_options([
      OptString.new('CANIFACE', [ true, 'CAN interface to use (e.g. can0)', 'can0' ]),
      OptString.new('INIT_MSG', [ true, 'Initialization CAN message', '14FF0131#0000E0CC00000000' ]),
      OptString.new('MESSAGE1', [ true, 'First CAN message to send', '10FF0021#81500400FF3F4DC8' ]),
      OptString.new('MESSAGE2', [ true, 'Second CAN message to send', '10FF0021#81000000FF3F4DC8' ]),
      OptInt.new('DELAY_MS', [ true, 'Delay between messages in milliseconds', 10 ])
    ])
  end

  def run
    interface = datastore['CANIFACE']
    init_msg  = datastore['INIT_MSG']
    msg1      = datastore['MESSAGE1']
    msg2      = datastore['MESSAGE2']
    delay     = datastore['DELAY_MS'].to_f / 1000  # convert milliseconds to seconds

    print_status("Bringing up interface #{interface}...")
    unless configure_interface(interface)
      print_error("Interface configuration failed")
      return
    end

    print_status("Sending initialization message: #{init_msg}")
    send_frame(interface, init_msg)

    print_status("Starting continuous CAN messaging with a delay of #{delay} seconds...")
    while true
      send_frame(interface, msg1)
      Rex.sleep(delay)
      send_frame(interface, msg2)
      Rex.sleep(delay)
    end
  end

  # Sends a CAN frame via the 'cansend' utility.
  def send_frame(interface, message)
    cmd = "cansend #{interface} #{message}"
    print_status("Executing: #{cmd}")
    output = `#{cmd}`
    # Optionally, check output for errors.
  end

  # Configures the CAN interface. Adjust this as needed to match your system's requirements.
  def configure_interface(interface)
    # Bring the interface down, configure, and bring it up.
    print_status("Configuring interface #{interface}...")
    `sudo ip link set #{interface} down`
    # If you need to set a bitrate or other parameters, add them here.
    `sudo ip link set #{interface} up type can bitrate 500000`
    return $?.exitstatus == 0
  end
end

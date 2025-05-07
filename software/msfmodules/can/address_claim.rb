##
# This Metasploit auxiliary module gathers CAN options
# and then execs the fixed-path bash script via sudo.
##

require 'msf/core'

class MetasploitModule < Msf::Auxiliary
  SCRIPT_PATH = '/usr/bin/address_claim'.freeze

  def initialize(info = {})
    super(update_info(info,
      'Name'        => 'CAN Address Claim Launcher (via External Script)',
      'Description' => %q{
        Invokes the system-installed /usr/bin/address_claim
        to perform J1939 address-claim cycling. Make sure to modify /etc/sudoers
        to allow the user running Metasploit to execute this script without a password:
        <user> ALL=(ALL) NOPASSWD: /usr/bin/address_claim
      },
      'Author'      => ['Spencer Beer', 'Carson Green'],
      'License'     => MSF_LICENSE
    ))

    register_options([
      OptString.new('CANIFACE',      [ true, 'CAN interface to use',             'can0'    ]),
      OptInt.new(   'BAUD',          [ true, 'CAN bus bitrate',                   500000  ]),
      OptInt.new(   'DELAY_MS',      [ true, 'Delay between frames (ms)',         1        ]),
      OptInt.new(   'LOOP_DELAY_MS', [ true, 'Delay after cycle (ms)',            250      ])
    ])
  end

  def run
    iface = datastore['CANIFACE']
    baud  = datastore['BAUD']
    delay = datastore['DELAY_MS']
    loopd = datastore['LOOP_DELAY_MS']

    unless File.executable?(SCRIPT_PATH)
      print_error("Script not found or not executable: #{SCRIPT_PATH}")
      return
    end

    cmd_args = [
      'sudo',
      SCRIPT_PATH,
      iface,
      baud,
      delay,
      loopd
    ].map(&:to_s)

    print_status("Launching address-claim cycler: #{cmd_args.join(' ')}")
    begin
      pid = spawn(*cmd_args, out: '/dev/null', err: '/dev/null')
      Process.detach(pid)
      print_good("Script started as PID #{pid}")
    rescue => e
      print_error("Failed to launch script: #{e}")
    end
  end
end

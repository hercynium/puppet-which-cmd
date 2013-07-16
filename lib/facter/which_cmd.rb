#
# Determine how to call the 'which' command on this system
#

# for now this is as simple and stupid as possible; there's
# a lot of room to make it more robust and portable.

# if its not present this fact will be empty.
Facter.add("which_cmd") do
    has_weight 502
    setcode { Facter::Util::Resolution.exec( "which which" ) }
end

# store the which command's usage output - it may be handy.
if which_cmd = Facter.value( "which_cmd" )
    Facter.add("which_usage") {
        has_weight 501
        setcode {
            cmd = Facter.value( "which_cmd" ) + " 2>&1 || true"
            Facter::Util::Resolution.exec( cmd ).strip
        }
    }
end

# vi: set ts=4 sw=4 et :

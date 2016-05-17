Puppet::Parser::Functions::newfunction(:perl_varprint, :type => :rvalue, :doc => <<-EOS
Print out a Puppet data type as a Perl data type.  This takes care of doing
things like quoting strings, not quoting integer types, and will hopefully one
day correctly (recursively) print out arrays and hashes, with sub arrays and
hashes printed in correct Perl format.

Given a nil value (undef), perl_varprint will return 'undef'.  If given a string
that exactly equals 'undef', the 'undef' Perl keyword will be returned.

Example:

    $var1 = 10
    $var2 = 'hello'
    $var3 = undef
    $var4 = 'undef'

    perl_varprint($var1)
    # => 10
    perl_varprint($var2)
    # => "hello"
    perl_varprint($var3)
    # => undef
    perl_varprint($var4)
    # => undef

EOS
) do |args|
  raise(Puppet::ParseError, "perl_varprint() wrong number of arguments. Given: #{args.size} for 2)") if args.size != 2

  varname = args[0]
  arg = args[1]

  if arg.nil? or arg == ""
    debug("type 0")
    return nil
  end

  # if arg.is_a(String) and arg == 'undef'
  if Puppet::Pops::Types::TypeCalculator.instance?(String, arg) and arg == 'undef'
    debug("type 1")
    return "#{varname} = undef;"
  end

  #if arg.is_a(String)
  if Puppet::Pops::Types::TypeCalculator.instance?(String, arg)
    debug("type 2")
    return "#{varname} = \"#{arg}\";"
  end

  # if arg.is_a(Integer)
  if Puppet::Pops::Types::TypeCalculator.instance?(Integer, arg)
    debug("type 3")
    return "#{varname} = #{arg};"
  end

  # if arg.nil? or arg == false or arg =~ /false/i or arg == :undef
  #   return 'Off'
  # elsif arg == true or arg =~ /true/i
  #   return 'On'
  # end

  return arg.to_s
end

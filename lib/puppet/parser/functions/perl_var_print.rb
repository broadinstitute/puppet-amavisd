module Puppet::Parser::Functions
  newfunction(:perl_var_print, type: :rvalue, doc: <<-EOS
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

    perl_varprint("$var1", 10)
    # => 10
    perl_varprint("$var2", 'hello')
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

    if arg.nil? || arg == ''
      return nil
    end

    data = function_perl_data_print([arg])
    return "#{varname} = #{data};\n"
  end
end

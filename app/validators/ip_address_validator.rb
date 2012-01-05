# The IP Address Validator accepts the following options
# 
#   * allow_nil - allows nil values
#   * allow_blank - allows blank values
#   * allow_cidr - allows /prefixlen CIDR masks in values
#
# the validator will use regular expressions in an attempt to prevent
# malformed IP addresses from being passed to the IPAddr.new initializer
# as this method can be very slow to raise exceptions for malformed input.

require 'ipaddr'

class IpAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.class.benchmark("#{record.class}: validate #{attribute} as ip address with #{value}") do
      return if options[:allow_nil] == true && value.nil?
      return if options[:allow_blank] == true && value.blank?

      return record.errors.add(attribute, record.errors.generate_message(attribute, 'blank')) if value.blank?

      if value !~ ipv4regex && value !~ ipv6regex
        return record.errors.add(attribute,
          options[:message] || record.errors.generate_message(attribute, 'ipaddress.invalid'))
      end

      begin
        ip = IPAddr.new(value)

        if options[:v4] == true && !ip.ipv4?
          record.errors.add(attribute,
            options[:message] || record.errors.generate_message(attribute, 'ipaddress.not_v4'))
        elsif options[:v6] == true && !ip.ipv6?
          record.errors.add(attribute,
            options[:message] || record.errors.generate_message(attribute, 'ipaddress.not_v6'))
        end
      rescue ArgumentError
        record.errors.add(attribute,
          options[:message] || record.errors.generate_message(attribute, 'ipaddress.invalid'))
      end
    end
  end
  protected
    def ipv4regex
      if options[:allow_cidr]
        /\A(?:\A(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}
          (?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])
          (?:\/(?:3[0-2]|[1-2][0-9]|[0-9]))?\Z)\Z/x
      else
        /\A(?:\A(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}
          (?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\Z)\Z/x
      end
    end
    def ipv6regex
      if options[:allow_cidr]
        /\A(?:\A(?:                                     # Anchor address
          (?:[A-F0-9]{1,4}:){7}[A-F0-9]{1,4}            # No ::
        | (?:[A-F0-9]{1,4}:){6}:[A-F0-9]{1,4}           # 6::1
        | (?:[A-F0-9]{1,4}:){5}(?::[A-F0-9]{1,4}){1,2}  # 5::2
        | (?:[A-F0-9]{1,4}:){4}(?::[A-F0-9]{1,4}){1,3}  # 4::3
        | (?:[A-F0-9]{1,4}:){3}(?::[A-F0-9]{1,4}){1,4}  # 3::4
        | (?:[A-F0-9]{1,4}:){2}(?::[A-F0-9]{1,4}){1,5}  # 2::5
        | [A-F0-9]{1,4}:(?::[A-F0-9]{1,4}){1,6}         # 1::6
        | (?:[A-F0-9]{1,4}:){1,7}:                      # :: at the end
        | :(?::[A-F0-9]{1,4}){1,7}                      # :: at the start
        | ::                                            # Only ::
        )(?:\/(?:12[0-8]|1[0-1][0-9]|[1-9][0-9]|[0-9]))?# CIDR
        \z)\Z/ix     # Anchor address
      else
        /\A(?:\A(?:                                     # Anchor address
          (?:[A-F0-9]{1,4}:){7}[A-F0-9]{1,4}            # No ::
        | (?:[A-F0-9]{1,4}:){6}:[A-F0-9]{1,4}           # 6::1
        | (?:[A-F0-9]{1,4}:){5}(?::[A-F0-9]{1,4}){1,2}  # 5::2
        | (?:[A-F0-9]{1,4}:){4}(?::[A-F0-9]{1,4}){1,3}  # 4::3
        | (?:[A-F0-9]{1,4}:){3}(?::[A-F0-9]{1,4}){1,4}  # 3::4
        | (?:[A-F0-9]{1,4}:){2}(?::[A-F0-9]{1,4}){1,5}  # 2::5
        | [A-F0-9]{1,4}:(?::[A-F0-9]{1,4}){1,6}         # 1::6
        | (?:[A-F0-9]{1,4}:){1,7}:                      # :: at the end
        | :(?::[A-F0-9]{1,4}){1,7}                      # :: at the start
        | ::                                            # Only ::
        )\z)\Z/ix                                       # Anchor address
      end
    end
end

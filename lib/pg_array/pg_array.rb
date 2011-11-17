# -*- coding: utf-8 -*-
class PgArray
  def initialize(pg_array_string)
    @pg_array_string = pg_array_string
  end

  def to_a
    @to_a ||= begin
                if @pg_array_string.nil?
                  nil
                else
                  parse_array(@pg_array_string)
                end
              end
  end


  private

  # Based on ruby-dbi implementation
  # DBI::DBD::Pg::Type::Array#convert_array
  # http://ruby-dbi.rubyforge.org/
  def parse_array(str)
    array_nesting = 0
    in_string = false
    escaped = false
    sbuffer = ''
    result_array = []

    str.each_byte do |char|
      char = char.chr

      if escaped
        sbuffer += char
        escaped = false
        next
      end

      case char


      when '{'
        if in_string
          sbuffer += char
          next
        end

        if array_nesting >= 1
          sbuffer += char
        end
        array_nesting += 1


      when '"'
        sbuffer += char
        in_string = !in_string


      when "\\"
        if array_nesting > 1
          sbuffer += char
        else
          escaped = true
        end


      when ','
        if in_string or array_nesting > 1
          sbuffer += char
        else
          result_array << new_element(sbuffer)
          sbuffer = ''
        end


      when '}'
        if in_string
          sbuffer += char
          next
        end

        array_nesting -=1

        if array_nesting == 1
          sbuffer += char
          sbuffer = parse_array(sbuffer)
        elsif array_nesting > 1
          sbuffer += char
        else
          unless sbuffer.nil?
            result_array << new_element(sbuffer)
          end
        end


      else
        sbuffer += char
      end
    end

    result_array
  end

  def new_element(elem)
    if elem.is_a?(Array)
      elem
    else
      if elem == 'NULL'
        nil
      else
        elem.sub(/^"/, '').sub(/"$/, '')
      end
    end
  end
end

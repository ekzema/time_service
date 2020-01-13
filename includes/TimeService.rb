module TimeService
  class GetTime
    VALID_TIME = /^([0-9]|0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])\s*([AaPp][Mm])$/

    def initialize(time, min)
      @time, @min = time, min
    end

    private

    def get_custom_time
      if VALID_TIME.match(@time).nil?
        puts 'Error format time'
        exit
      end
      arr = @time.split(/[\s,:']/).map { |item| numeric?(item) ? item.to_i : item }
      custom_time(arr, @min)
    end

    def custom_time(time, add_min)
      hours = time[0]
      minutes = time[1]
      format = time[2].upcase
      sum_min = minutes + add_min
      new_hours = sum_min / 60
      new_minutes = sum_min % 60
      if format == 'AM'
        hours += new_hours
        hours = hours % 12 if hours > 12
      else
        hours += new_hours
        hours = hours % 24 if hours > 24
        hours = 00 if hours == 24
      end
      print_in_terminal(hours, new_minutes, format)
    end

    def print_in_terminal(hours, minutes, format)
      puts "#{hours}:#{minutes} #{format}"
    end

    def numeric?(string)
      string.match(/\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/) == nil ? false : true
    end
  end

  class OutputTime < GetTime
    def result
      get_custom_time
    end
  end
end
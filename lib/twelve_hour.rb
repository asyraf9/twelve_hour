module ActionView::Helpers
  class DateTimeSelector
     def select_hour_with_twelve_hour_time
        return select_hour_without_twelve_hour_time unless @options[:twelve_hour].eql? true

        val = @datetime ? (@datetime.kind_of?(Fixnum) ? @datetime : @datetime.hour) : ''
        if @options[:use_hidden] || @options[:discard_hour]
          build_hidden(:hour, val)
        else
          hour_options = []
          0.upto(23) do |hour|
            ampm = hour <= 11 ? ' AM' : ' PM'

            ampm_hour = hour == 12 ? 12 : (hour == 0 ? 12 : (hour / 12 == 1 ? hour % 12 : hour))

            hour_options << ((val == hour) ?
              %(<option value="#{hour}" selected="selected">#{ampm_hour}#{ampm}</option>\n) :
              %(<option value="#{hour}">#{ampm_hour}#{ampm}</option>\n)
            )
          end
          build_select(:hour, hour_options)
        end
      end
      alias_method_chain :select_hour, :twelve_hour_time
  end
end

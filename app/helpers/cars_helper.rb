module CarsHelper
    def color_options(make)
      case make&.downcase
      when 'hyundai'
        [['Red', 'red'], ['Green', 'green']]
      when 'ferrari'
        [['Blue', 'blue'], ['Orange', 'orange']]
      else
        []
      end
    end
  end
  
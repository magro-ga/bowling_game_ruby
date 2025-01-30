class Roll
    attr_reader :pins

    def initialize(pins, first_roll: false)
        raise ArgumentError, "Pins devem ser entre 0 e 10" unless valid_pins?(pins)

        @pins = pins
    end

    def strike?
        @pins == 10
    end

    private

    def valid_pins?(pins)
        pins.is_a?(Integer) && pins.between?(0, 10)
    end
end
  
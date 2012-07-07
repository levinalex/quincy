module Quincy
  # Interface to Frey Quincy PCNet (http://www.frey.de/q_pcnet.htm).
  #
  # Extracts patient information by reading the folder containing
  # the PATDATXX-subdirectories.
  #
  # Usage:
  #
  #   # find the patient with the number 98
  #   patient = Quincy::PCnet.new("/example/QUINCY").find(98)
  #
  class PCnet

    # a Struct containing patient information
    #
    class Patient < Struct.new( :number, :last_name, :first_name )
      def to_s
        "#{"%6d"%number}: #{name}"
      end

      def name
        [last_name, first_name].join(", ");
      end
    end

    attr_reader :quincy_path

    def initialize(path = nil)
      path ||= ENV["QUINCY"]
      @@blocksize = 1024

      raise ArgumentError, "Quincy Path not set (use '-q' or ENV['QUINCY'])" unless path
      @quincy_path = Pathname.new(path)
    end

    # returns the PATDAT-file for a given patient number
    #
    #   path = Quincy::PCnet.new("foo").path_for("98")
    #   #=> "foo/PATDAT00/0098.DAT"
    #
    def path_for(number)
      dat_number = number % 0xa00
      dir_number = dat_number / 0x80
      patdat_path = @quincy_path + "PATDAT#{"%02d" % dir_number}" + "#{"%04d"% dat_number}.DAT"
      patdat_path.to_s
    end

    def find(number)
      filename = Pathname.new(path_for(number))
      return nil unless File.exists?(filename)

      File.open(filename, "rb:binary") { |f|
        while (record = f.read(@@blocksize))
          patient = read_record(record)
          return patient if patient and patient.number == number
        end
      }
    end

    private

    def read_record(record) #:nodoc:
      return unless record[4] == "\xf6"[0]

      read_str = lambda { |pattern| lambda { |chunk|
        str = chunk.unpack(pattern).first.strip
        str = Iconv.new("UTF-8","CP850").iconv(str) if defined?(Iconv)
        str = str.force_encoding("cp850").encode("utf-8") if defined?(Encoding)
        str
      }}

      fields = {
        :number     => lambda { |s| s.unpack("@10A5").first.to_i },
        :last_name  => read_str["@15A30"],
        :first_name => read_str["@45A30"]
      }

      pat = Patient.new

      fields.each { |k,v|
        pat[k] = v.call(record)
      }

      pat
    end
  end
end

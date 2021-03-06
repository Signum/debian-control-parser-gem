# Parses Debian control files
class DebianControlParser
  # Creates a new parser instance from either a file-like
  # object or a string of multiple lines containing a
  # Debian control file like Packages or Release.
  #
  # @param data [File,String] the object to read lines from (e.g. a multiline-string or a file)
  # @return [DebianControlParser] a parser instance
  def initialize(data)
    @data = data
  end

  # Iterator that returns fields from the input data. If the file
  # consists of several paragraphs (seperated by empty lines)
  # it must first be split by using the 'paragraphs' iterator.
  #
  # yield [Array<String,String>] a name/value pair for each field
  def fields
    return enum_for(:each) unless block_given?

    name = value = ''
    @data.each_line do |line|
      case line
        when /^(\S+): (.+)/ # "Key: Value"
          yield(name, value) unless value.empty?
          name, value = $1, $2
        when /^(\S+):\s*/ # "Key:" (start of multi-line entry)
          yield(name, value) unless value.empty?
          name = $1
          value = ''
        when /^\s+(.+)/ # " Indented multi-line value"
          value << "\n" + $1
        when /^\s+$/ # Empty line
          break
      end
    end

    # Any lines left at the end of the input?
    yield(name, value) unless value.empty?
  end

  # Iterator that splits up the input of a debian control file
  # by empty lines. For example Debian "Packages" files consist
  # of one paragraph for each package listed in it.
  #
  # @yield [DebianControlParser] a parser instance that you can use .fields on
  def paragraphs
    return enum_for(:each) unless block_given?

    gathered_lines = '' # collects all lines belonging to a field
    @data.each_line do |line|
      if line.chomp.empty? # empty line found that seperates paragraphs
        unless gathered_lines.empty? # any lines gathered so far?
          #yield gathered_lines  # return the paragraph
          yield DebianControlParser.new(gathered_lines)
          gathered_lines = ''
        end
      else
        gathered_lines << line
      end
    end

    # Any lines left after the last empty line and the end of the input?
    unless gathered_lines.empty?
      #yield gathered_lines
      yield DebianControlParser.new(gathered_lines)
    end
  end
end

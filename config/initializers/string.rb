class String
    def ucfirst
        str = self.clone
        str[0] = str[0, 1].upcase
        str
    end

    def to_slug options

        options[:delimiter] = options[:delimiter] == nil ? '-' : options[:delimiter].to_s[0]
        options[:lowercase] = options[:lowercase] != false

        str = self.clone
		str = str.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '')
		str = str.downcase if options[:lowercase]
		str = str.gsub /[^A-Za-z0-9]/, options[:delimiter]
		str = str.gsub /#{options[:delimiter] + options[:delimiter]}+/, options[:delimiter]
		str = str.gsub(/\A#{options[:delimiter]}/, '').gsub(/#{options[:delimiter]}\z/, '')
    end

    def slash
        str = self.clone
        str.gsub /['"\\\x0]/, '\\\\\0'
    end

    def unbreak_spaces chars = "!:?;%.,€$"
        chars = "[#{chars.gsub(/([\.\[\]\(\)\{\}\^\/])/, '\\\1')}]"
        str = self.gsub(/(\s+)(#{chars})/) do |match|
            s = ''
            match[0].length.times { s += '&nbsp;' }
            s + match[1]
        end

        str.html_safe
    end

    def trim chars = "\s\n\r"
        chars = "[#{chars}]*"
        self.gsub /\A#{chars}(.+?)#{chars}\z/, '\1'
    end

    def linebreaks tag = :br, &block
        if block_given?
            self.split("\n").each { |line| block.call line }
        else
            html = "<#{tag}>"
            html += "</#{tag}>" unless tag == :br || tag == :hr
            self.gsub(/\n/, html).html_safe
        end
    end

    def paragraphs tag = :p, &block
        if block_given?
            n = 0
            self.gsub(/\n\n+/, "\n").split("\n").each do |paragraph|
                block.call paragraph.html_safe, n
                n += 1
            end
        else
            html = "<#{tag}>"
            html += "</#{tag}>" unless tag == :br || tag == :hr
            self.gsub(/\n\n+/, html).html_safe
        end
    end

    def strengthen *words
        puts words.join '|'
        self.gsub(/\b(#{words.join '|'})\b/i, '<strong>\1</strong>').html_safe
    end

    def t_strengthen key
        words = I18n.t(key).split(',').map { |str| str.trim }
        self.strengthen *words
    end
end

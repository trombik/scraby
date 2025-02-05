# frozen_string_literal: true

module Scraby
  module Filter

    # Strips new lines in a term. The filter strips all the newlines in :name
    # and :description.
    #
    # @param term [Hash] A term
    # @return [Hash] The term with newlines removed
    def strip_newlines(term)
      term[:name] = term[:name].gsub(/\n/, "")
      term[:description] = term[:description].gsub(/\n/, "")
      term
    end

    # Replaces spaces in :name and :description with a space, including the
    # "Zenkaku" space and ASCII space.
    #
    # @param term [Hash] A term
    # @return [Hash] The term with multiple spaces replaced with a space.
    def replace_multiple_spaces(term)
      term[:name].gsub!(/[ 　]+/, " ")
      term[:description].gsub!(/[ 　]+/, " ")
      term
    end

    # Applies strip_newlines and replace_multiple_spaces filters to a term
    #
    # @param term [Hash] A term
    # @return [Hash] The term after the filters applied
    def filter_default(term)
      term = strip_newlines(term)
      term = replace_multiple_spaces(term)
      term
    end
  end
end

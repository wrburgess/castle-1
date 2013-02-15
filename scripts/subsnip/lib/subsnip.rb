#require "pry"
require "fileutils"

module SubSnip
  class << self

    def extension
      'sublime-snippet'
    end

    def snippet_filepath
      "#{ENV['HOME']}/Library/Application\ Support/Sublime\ Text\ 2/Packages/User"
    end

    def application
      @application ||= SubSnip::Application.new
    end

  end

  class Application

    def run
      @args = Array.try_convert ARGV
      if is_valid_command?
        create_snippet_file if is_new_snippet?
        open_in_sublime
      else
        puts <<-eos
examples:
  subsnip <snippet_name>
  subsnip <language> <snippet_name>
eos
      end
    end

    def category
      only_one_argument? ? "All" : @args.first
    end

    def snippet
      only_one_argument? ? @args.first : @args[1]
    end

    def snippet_source
      if @args[2]
        @args[2]
      else
        <<-eos
PARAMS: $PARAM1, $PARAM2... (Arguments passed to the insert_snippet command)
SELECTION: $SELECTION (The text that was selected when the snippet was triggered)
TM_CURRENT_LINE: $TM_CURRENT_LINE (Content of the line the cursor was in when the snippet was triggered)
TM_CURRENT_WORD: $TM_CURRENT_WORD (Current word under the cursor when the snippet was triggered)
TM_FILENAME: $TM_FILENAME (File name of the file being edited including extension)
TM_FILEPATH: $TM_FILEPATH (File path to the file being edited)
TM_FULLNAME: $TM_FULLNAME (User's user name)
TM_LINE_INDEX: $TM_LINE_INDEX (Column the snippet is being inserted at, 0 based)
TM_LINE_NUMBER: $TM_LINE_NUMBER (Row the snippet is being inserted at, 1 based)
TM_SELECTED_TEXT: $TM_SELECTED_TEXT (An alias for $SELECTION)
TM_SOFT_TABS: $TM_SOFT_TABS (YES if translate_tabs_to_spaces is true, otherwise NO)
TM_TAB_SIZE: $TM_TAB_SIZE (Spaces per-tab [controlled by the tab_size option])
eos
      end
    end

    def snippet_content
        <<-eos
<snippet>
    <content><![CDATA[
#{snippet_source}
]]></content>
    <!-- Optional: Tab trigger to activate the snippet -->
    #{tab_trigger}
    <!-- Optional: Scope the tab trigger will be active in -->
    #{snippet_scope}
    <!-- Optional: Description to show in the menu -->
    <description>Template Snippet</description>
</snippet>
eos
    end

    def tab_trigger
      "<tabTrigger>#{snippet}</tabTrigger>"
    end

    def snippet_scope
      if only_one_argument?
        "<!-- <scope>source.ruby</scope> -->"
      else
        "<scope>source.#{category.downcase}</scope>"
      end
    end

    def snippet_filename
      "#{category}-#{snippet}.#{SubSnip::extension}"
    end

    def snippet_path
      "#{SubSnip::snippet_filepath}/#{snippet_filename}"
    end

    def is_new_snippet?
      File.exists?(snippet_path) ? false : true
    end

    def create_snippet_file
      snippet_file = File.open(snippet_path, "w+")
      snippet_file << snippet_content if snippet_content
      snippet_file.close
    end

    def open_in_sublime
      `open #{snippet_path.gsub(/\s/, "\\\s")} -a "Sublime Text 2"` if File.exists? snippet_path
    end

    def only_one_argument?
      @args.length == 1
    end

    def is_valid_command?
      return @args.length > 0
    end

  end

end
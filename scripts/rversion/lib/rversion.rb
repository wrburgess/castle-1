require 'moses'
require 'pry'

class Rversion
  include Moses
  default_command :create_version_file

  def create_version_file
    if @options[:choose] || @options[:c]
      version = choose_version
    else
      version = @args.first || default_version
    end

    output.puts "\n#{version}"
    File.open('.ruby-version', 'w+') { |f| f << "#{version}\n" } unless version.nil?
  end

  def versions
    v = %x{rbenv versions}.lines.map do |l|
      l.chomp.strip.gsub(/^\*\s?/, '*').gsub(/\s?\(.+\)$/, '')
    end
    v.reverse
  end

  def default_version
    versions.select { |v| v =~ /^\*/ }.first.gsub(/^\*/, '')
  end

  def list_versions
    output.puts "Choose a ruby version to use:"
    versions.each_with_index do |v, i|
      output.puts "#{i + 1}) #{v}"
    end
    output.puts ""
  end

  def choose_version
    list_versions
    version_index = gets.chomp.to_i - 1
    output.puts "Please choose a valid ruby version from the list" unless versions[version_index]
    versions[version_index]
  end
end

require 'rubygems'
require 'optparse'
require 'fileutils'

require_relative 'java_zip_util'

class ZipCutter

	include JavaZipUtil
	
    SRC = '/Users/niranjansarade/zip_source'
    DEST = '/Users/niranjansarade/zip_cut_dest'
	attr_accessor :options

	def initialize
		@options = { chunk_size: 20 }
	end
	
	def run! args
		if parse_options(args)
			split
		end	
	end

	private

	def parse_options args
		opts = OptionParser.new
		opts.banner = "Usage: #{File.basename(__FILE__)} [options]"
		opts.on('--chunk-size=size') {|o| @options[:chunk_size] = o.to_i}
		opts.on('--zip-file=file')   {|o| @options[:zip_to_be_cut] = o}
		opts.parse!(args)
		options[:zip_to_be_cut]
	end

	def split
		if zip_exists?
			zip = Dir["#{SRC}/#{options[:zip_to_be_cut]}"].first
			extract_all(zip,DEST)
			entries = Dir[File.join(DEST,'*')]
			p "Total Number of entries in the zip file -> #{entries.count}"
			index = 1
			entries.each_slice(options[:chunk_size]) do |batch|
				splitZipName = options[:zip_to_be_cut].sub(/.zip/,"_#{index}.zip")
				zipPath = "#{DEST}/#{splitZipName}"
				p "Zipping #{batch.size} files into #{splitZipName}..."
				selective_zip(zipPath,batch)
				index = index + 1
			end
			p "Zip Split Complete."

			files = Dir.glob("#{DEST}/*.{pdf,xml,csv,xls,txt,html,jpg}")
			remove_files(files) unless files.empty?
		else
			p "No #{options[:zip_to_be_cut]} present @ #{SRC} to extract from."
		end
	end

	def zip_exists?
    	File.exists?("#{SRC}/#{options[:zip_to_be_cut]}")
	end

	def remove_files files
        FileUtils.rm files
	end
			
end

ZipCutter.new.run!(ARGV)


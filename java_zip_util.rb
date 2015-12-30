require 'java'

import java.util.zip.ZipFile
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream

import java.io.FileInputStream
import java.io.FileOutputStream

module JavaZipUtil

  def selective_zip(zip_path,to_be_zipped)
	fos = FileOutputStream.new(zip_path)
	zos = ZipOutputStream.new(fos)
	buffer = Java::byte[4*1024].new
	to_be_zipped.each do |file|
		ze = ZipEntry.new(File.basename(file))
		zos.putNextEntry(ze)
		fis = FileInputStream.new(file)
		size = 0
		while ((size = fis.read(buffer)) > 0) do
			zos.write(buffer,0,size)
		end
		fis.close
		zos.closeEntry	
	end
	zos.close
  end	

  def extract_all(zip_path,dest_dir)
	zipfile = ZipFile.new(zip_path)
	entries = zipfile.entries
	entries.each do |entry|
		is = zipfile.getInputStream(entry)
		fos = FileOutputStream.new("#{dest_dir}/#{entry.getName}")
		size = 0
		buffer = Java::byte[4*1024].new
		while ((size = is.read(buffer)) != -1) do
			fos.write(buffer,0,size)
		end
		fos.flush
		fos.close
		is.close
	end
  end	

end


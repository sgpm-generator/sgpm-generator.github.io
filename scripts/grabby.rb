# working script:
# rm ./_posts/*.md; cd scripts; ruby *.rb; cd ..; rm -rf ./sgpm-generator.github.io; jekyll serve
# to set up proper rake file, proper ruby grabber, proper site navigation

require 'json'


	class JSONgrab

	def JSONgrab.grab
	# pulls and parses data from given json file
	## todo: make this configurable from config.yml?
	json = File.read('./sgpm-extended.json')
	sgpmJSON = JSON.parse(json)
	
	
	sgpmJSON.each do |f|

		@title_cleaner = f['Headline']
		if @title_cleaner.respond_to?(:gsub)
	 		@title = @title_cleaner.gsub(':','-').gsub('/','-').gsub('/','-').gsub(/[^\w-]/, '')
	 	else
	 		@title = @title_cleaner
	 	end

	 	@author = f['Writer-Editor']
	 	@keywords = f['Keywords']
	 	@credit = f['Credit']
	 	
	 	@description_cleaner = f['ImageDescription']
	 	if @description_cleaner.respond_to?(:gsub)
	 		@description = @description_cleaner.gsub('"','\"')
	 	else
	 		@description = @description_cleaner
	 	end

	 	
	 	@copyright_cleaner = f['CopyrightNotice']
	 	if @copyright_cleaner.respond_to?(:gsub)
	 	@copyrightnotice = @copyright_cleaner.gsub(':','-').gsub('/','-').gsub(/[^\w-]/, '')
	 	else 
	 		@copyrightnotice = @copyright_cleaner
	 	end
	 	
	 	@sourcefile = f['SourceFile'].downcase.strip.gsub('.jpg', '').gsub(' ', '-').gsub('/','-').gsub(/[^\w-]/, '')
	 	
	 	@imgsource = f['FileName']
	 	
	 	if !f['CreateDate'].nil?
	 		@date_cleaner = f['CreateDate']
	 		@date = @date_cleaner[0..9].gsub(':','-').gsub('/','-').gsub(/[^\w-]/, '')
	 	elsif !f['ModifyDate'].nil?
	 		@date_cleaner = f['ModifyDate']
	 		@date = @date_cleaner[0..9].gsub(':','-').gsub('/','-').gsub(/[^\w-]/, '')
	 	elsif !f['DateTimeOriginal'].nil?
	 		@date_cleaner = f['DateTimeOriginal']
	 		@date = @date_cleaner[0..9].gsub(':','-').gsub('/','-').gsub(/[^\w-]/, '')
	 	end
	 			

	 	#opens filename.md to write
		outFile = File.open("../_posts/#{@date}-#{@sourcefile}.md", 'w')
	 	#writes to filename.md
	 	## entire list of exif metadata output to file's frontmatter
	 	## see exiftool script re: what is extracted
	 	## add to frontmatter by adding a json key from parsed json file
	 	outFile.puts("---
layout: sgpm-default-display
title: #{@title}
author: #{@author}
tags: #{@keywords}
credit: #{@credit}
source: #{@sourcefile}
description: \"#{@description}\"
copyright: #{@copyrightnotice}
slug: #{@sourcefile}
date: #{@date}
img_path: #{@imgsource}
category: singapore-gurkha-photography-museum
---
	 		")
	 	outFile.puts("
	 		<h1>#{@title}</h1>
	 		{{ site.tags }}
	 		")
	 	#closes filename.md
	 	outFile.close
	 	end
	end
end


::JSONgrab.grab
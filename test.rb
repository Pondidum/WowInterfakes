require 'rexml/document'
include REXML

Dir.glob('wow-ui-source/framexml/*.xml') do |file|

	xml = File.read(file)
	doc = REXML::Document.new(xml)

	doc.elements.each('//Frame') do |e|
		parent = e.attributes['parent']
		name =  e.attributes['name']

		if parent != nil then
			puts "#{parent}, #{name}"
		end

	end


end

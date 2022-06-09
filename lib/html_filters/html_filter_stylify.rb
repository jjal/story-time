 class HTMLFilter_Stylify < HTMLFilter
	def process(text)
    	return text.gsub(/\n?([^\n]+)(?:\n|$)/, '<p>\1</p>')
		    .gsub(/_([^_]+)_/,'<em>\1</em>') #italics
		    .gsub(/\*([^_]+)\*/,'<strong>\1</strong>') #bold
  	end
end
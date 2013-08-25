class HTMLFilter_Linkify < HTMLFilter
	def process(text)
        (text || "").gsub!(/(https?:\/\/)?(([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?)/, '<a href="\2">\2</a>')
        return text
	end
end
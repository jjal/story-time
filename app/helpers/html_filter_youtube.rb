class HtmlFilterYoutube < HtmlFilter
	def process(text)
		(text || "").gsub!(/(?:http:\/\/)?(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})/, 
      '<iframe width="560" height="315" src="//www.youtube.com/embed/\1?autoplay=1" frameborder="0" class="youtube_embed"></iframe>')
  		return text
	end
end
class HTMLFilter_YouTube
	def process(text)
		$pre_regex = '#<object.*width="(\d+)".*height="(\d+)".*>.+?'.
      'http://www.youtube.com/((?:v|cp)/[A-Za-z0-9\-_=]+).+?</object>#s';
    $pre_replace = 'http://youtube.com/watch?v=\3&size=\1x\2</span>';

    $pre_regex2 = '#<object[^>]+>.+?'.
      'http://www.youtube.com/((?:v|cp)/[A-Za-z0-9\-_=]+).+?</object>#s';
    $pre_replace2 = 'http://youtube.com/watch?v=\1</span>';

    return preg_replace($pre_regex2, $pre_replace2,
                        preg_replace($pre_regex, $pre_replace, $html));
	end
end
class HTMLFilter_Linkify < HTMLFilter
	def process(text)
		if (strpos($token->data, '://') === false) 
            # our really quick heuristic failed, abort
            # this may not work so well if we want to match things like
            # "google.com", but then again, most people don't
            return
        end

        # there is/are URL(s). Let's split the string:
        # Note: this regex is extremely permissive
        $bits = preg_split('#((?:https?|ftp)://[^\s\'"<>()]+)#S', $token->data, -1, PREG_SPLIT_DELIM_CAPTURE)

        $token = []

        # $i = index
        # $c = count
        # $l = is link
        for ($i = 0, $c = count($bits), $l = false; $i < $c; $i++, $l = !$l) do
            if (!$l) {
                if ($bits[$i] === '') continue;
                $token[] = new HTMLPurifier_Token_Text($bits[$i]);
            } else {
              if (strpos($bits[$i], 'youtube') !== false ||
                  strpos($bits[$i], 'youtu.be') !== false ||
                  strpos($bits[$i], 'vimeo') !== false) {
                $token[] = new HTMLPurifier_Token_Text($bits[$i]);
              } else {
                $token[] = new HTMLPurifier_Token_Start('a', array('href' => $bits[$i]));
                $token[] = new HTMLPurifier_Token_Text($bits[$i]);
                $token[] = new HTMLPurifier_Token_End('a');
              }
            }
        end
	end
end
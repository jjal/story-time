;
var SCHelper = {
	sounds: [],
	mute: false,
	play: function(url)
	{
		
		if(url) {
			SC.get('/resolve', { url: url }, function(track) {
				
				SC.stream('/tracks/'+track.id, function(sound){
					SCHelper.sounds.push(sound);
					if(!SCHelper.mute)
						sound.play();
		  		});
			});	
		} else {
			for(var i = 0; i < SCHelper.sounds.length; i++)
			{
				if(!SCHelper.mute)
					SCHelper.sounds[i].play();
			}
		}
	},
	stopAll: function()
	{
		for(var i = 0; i < SCHelper.sounds.length; i++)
		{
			SCHelper.sounds[i].stop();
		}
		SCHelper.sounds = [];
	},
	pause: function() {
		for(var i = 0; i < SCHelper.sounds.length; i++)
		{
			SCHelper.sounds[i].pause();
		}
	}
};

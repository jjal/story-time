;
var SCHelper = {
	sounds: [],
	play: function(url)
	{
		SC.get('/resolve', { url: url }, function(track) {
			
			SC.stream('/tracks/'+track.id, function(sound){
	  			sound.play();
				SCHelper.sounds.push(sound);
	  		});
		});	
	},
	stopAll: function()
	{
		for(var i = 0; i < SCHelper.sounds.length; i++)
		{
			SCHelper.sounds[i].stop();
		}
		SCHelper.sounds = [];
	}
};

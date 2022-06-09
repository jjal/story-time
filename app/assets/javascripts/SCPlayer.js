;
var SCHelper = {
	tracks: [],
	mute: false,
	play: function(url)
	{
		
		if(url) {
			SC.get('/resolve', { url: url }, function(track) {
				
				SC.stream('/tracks/'+track.id, function(sound) {
					//set fade out
					//sound.onPosition(track.duration - 2000, function () { SCHelper.fadeOut(sound); });
					track.sound = sound;
					SCHelper.tracks.push(track);
					if(!SCHelper.mute)
						SCHelper._play(track);
		  		});
			});	
		} else {
			for(var i = 0; i < SCHelper.tracks.length; i++)
			{
				if(!SCHelper.mute)
					SHelper._play(SCHelper.tracks[i]);
			}
		}
	},
	_play : function(track)
	{
		track.sound.play({
				onfinish: function () { this.play() },
				onplay: function () { SCHelper.fadeIn(this); }
			});
	},
	fadeIn: function (sound) {
		sound.setVolume(0);
		var fadeInTimer = setInterval(function() 
			{ 
				sound.setVolume(sound.volume + 1); 
				if(sound.volume >= 100) clearInterval (fadeInTimer); 
			}, 50);
	},

	fadeOut: function (sound) {
		var fadeOutTimer = setInterval(function() 
			{ 
				sound.setVolume(sound.volume - 1); 
				if(sound.volume <= 0) { clearInterval (fadeOutTimer); sound.stop(); }
			}, 50);
	},
	stopAll: function()
	{
		for(var i = 0; i < SCHelper.tracks.length; i++)
		{
			SCHelper.fadeOut(SCHelper.tracks[i].sound);
			//SCHelper.tracks[i].sound.stop();
		}
		SCHelper.tracks = [];
	},
	pause: function() {
		for(var i = 0; i < SCHelper.tracks.length; i++)
		{
			SCHelper.tracks[i].sound.pause();
		}
	}
};

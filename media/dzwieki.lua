function achievements_sound_func()
	playSoundFile(getMudletHomeDir().."/warlock_scripts/media/achievements.wav")
end

function swieta_event_func()
	selectCaptureGroup(1)
	creplace("\n <cyan>✨⭐ Nie wiedziec skad w twojej dloni znajduje sie malutka migoczaca gwiazdka.⭐✨\n\n")
	playSoundFile(getMudletHomeDir().."/warlock_scripts/media/star.wav")
end
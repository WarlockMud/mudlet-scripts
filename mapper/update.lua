scripts.mapper.map_update = scripts.mapper.map_update or {
    automatic = false
}
function scripts.mapper.map_update:check_for_update()    
    HttpClient:get("https://api.github.com/repos/Delwing/warlock-mapa/commits?path=map.dat", {}, function(response)
        local map_version = getMapUserData("version")
        local repository_version = nil
        for k,v in pairs(response) do
            repository_version = v.sha
            break
        end
        
        if repository_version ~= map_version then
            if self.automatic then
                scripts.mapper.map_update:download_map(repository_version)
            else
                scripts:print_log_nobr("Nowa wersja mapy jest dostepna. ", true, "orange")
                cechoLink("<cornflower_blue>Kliknij aby pobrac.<reset>", function() scripts.mapper.map_update:download_map(repository_version) end, "Pobierz mape", true)
                echo("\n")
            end
        end
    end)
end


function scripts.mapper.map_update:download_map(sha)

    --https://api.github.com/repos/Delwing/warlock-mapa/contents/map.dat?ref=master
    --download-url
    HttpClient:get("https://api.github.com/repos/Delwing/warlock-mapa/contents/map.dat?ref=master",{}, function(response) 
        local downloadUrl = response.download_url
        scripts.utils.downloader:downloadFile(getMudletHomeDir() .. "/warlock_mapa.dat", downloadUrl, function()
            scripts.mapper.map_update:load_map(sha)
        end, "Pobieram plik mapy")
    end)
    
end



function scripts.mapper.map_update:load_map(sha)
    if loadMap(getMudletHomeDir() .. "/warlock_mapa.dat") then
        scripts:print_log("Mapa zaladowana")
        setMapUserData("version",sha)
        saveMap()
    else
        scripts:print_log("Problem z zaladowaniem mapy")
    end
end
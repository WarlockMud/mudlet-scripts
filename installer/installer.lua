-- author: https://github.com/tjurczyk/arkadia
scripts.installer = scripts.installer or {}
scripts.installer.main_repo = "WarlockMud/mudlet-scripts"

function scripts.installer:update_scripts_to_latest_release()
    scripts.latest:get_latest_version(function(release_info) scripts.installer:on_scripts_version(release_info.tag_name) end)
end

function scripts.installer:on_scripts_version(version)
    scripts.installer:update_scripts(version)
end

function scripts.installer:update_scripts(version)
    local short_repo_name = scripts.installer.main_repo:gsub("(.*)/", "")
    local url = "https://codeload.github.com/" .. scripts.installer.main_repo .. "/zip/" .. version

    if (mudletOlderThan(4, 6)) then
        scripts:print_log("Zaktualizuj mudlet do wersji 4.6+ lub pobierz paczke recznie z adresu: " .. url)
        return
    end

    scripts.installer.scripts_zip = getMudletHomeDir() .. "/scripts.zip"
    scripts.installer.unzip_directory = getMudletHomeDir() .. "/".. short_repo_name .."-" .. version .. "/"
    scripts.installer.scripts_directory = getMudletHomeDir() .. "/warlock_scripts/"
    scripts.installer.to_delete = getMudletHomeDir() .. "/warlock_scripts-old-" .. os.time() .. "/"

    if lfs.isdir(scripts.installer.scripts_directory .. "/.git/") then
        scripts:print_log("Chyba nie chcesz aktualizowac repozytorium w ten sposob? :)")
        return
    end

    scripts.installer.version_tag = nil
    if version:match("%d+%.%d+%.%d+") or version:match("%d+%.%d+") then
        scripts.installer.version_tag = version
    end

    scripts.installer.scripts_download_handler = scripts.event_register:force_register_event_handler(scripts.installer.scripts_download_handler, "sysDownloadDone", function(_, filename) scripts.installer:handle_scripts_download(_, filename) end)
    downloadFile(scripts.installer.scripts_zip, url)
    scripts:print_log("Pobieram paczke skryptow z repozytorium. Wersja: " .. version)
end

function scripts.installer:handle_scripts_download(_, filename)
    if filename ~= scripts.installer.scripts_zip then
        return true
    end
    scripts.event_register:kill_event_handler(scripts.installer.scripts_download_handler)
    scripts:print_log("Paczka pobrana. Rozpakowuje")
    scripts.event_register:register_event_handler("sysUnzipDone", function(event, ...) scripts.installer:handle_unzip_scripts(event, ...) end, true)
    scripts.event_register:register_event_handler("sysUnzipError", function(event, ...) scripts.installer:handle_unzip_scripts(event, ...) end, true)
    unzipAsync(scripts.installer.scripts_zip, getMudletHomeDir())
end

function scripts.installer:handle_unzip_scripts(event, ...)
    if event == "sysUnzipDone" then
        os.remove(scripts.installer.scripts_zip)
        local success, err = os.rename(scripts.installer.scripts_directory, scripts.installer.to_delete)
        if not success then
            scripts:print_log("Nie udalo sie zaktualizowac skryptow.")
            scripts:print_log(err)
            scripts.installer.delete_dir(scripts.installer.unzip_directory)
            return
        end
        local deleted, del_error = pcall(scripts.installer.delete_dir, scripts.installer.to_delete)
        uninstallPackage("warlock")
        uninstallPackage("Warlock")
        uninstallPackage("warlock_scripts")
        tempTimer(1, function()
            scripts.installer:put_version_to_file()
            os.rename(scripts.installer.unzip_directory, scripts.installer.scripts_directory)
            installPackage(scripts.installer.scripts_directory .. "warlock_scripts.xml")
            if not deleted then
                scripts:print_log("Nie udalo sie usunac katalogu ze starymi skryptami. Zalecane recznie usuniecie katalogu " .. scripts.installer.to_delete .. " Nowe skrypty powinny dzialac.")
            end
            scripts:print_log("Ok aktualizacja udana, zrestartuj Mudleta.")
        end)
    elseif event == "sysUnzipError" then
        scripts:print_log("Blad podczas rozpakowywania skryptow")
    end
end

function scripts.installer:put_version_to_file()
    if scripts.installer.version_tag then
        local file = io.open(getMudletHomeDir() .. "/version_tag", 'w')
        file:write(scripts.installer.version_tag)
        file:close()
        scripts.installer.version_tag = nil
    end
end

function scripts.installer:get_version_from_file()
    local file = io.open(getMudletHomeDir() .. "/version_tag", 'r')
    if file then
        local version = file:read("*a")
        file:close()
        return version
    end
end



function scripts.installer:save_map(branch)
    local tree = "master3"
    if branch then
        tree = branch
    end

    local full_name = "/map_master3.dat"

    if saveMap(getMudletHomeDir() .. full_name) then
        scripts:print_log("Mapa zapisana")
        raiseEvent("mapSave")
    else
        scripts:print_log("Problem z zapisaniem mapy")
    end
end

function scripts.installer.delete_dir(dir)
    for file in lfs.dir(dir) do
        local file_path = dir .. '/' .. file
        if file ~= "." and file ~= ".." then
            if lfs.attributes(file_path, 'mode') == 'file' then
                local code, sucess, err = pcall(os.remove, file_path)
                if not sucess then
                    error(err)
                end
            elseif lfs.attributes(file_path, 'mode') == 'directory' then
                scripts.installer.delete_dir(file_path)
            end
        end
    end
    local success, err = lfs.rmdir(dir)
    if not success then
        error("Nie udalo sie usunac katalogu " .. dir .. " - " .. err)
    end
end

function alias_func_skrypty_installer_aktualizuj_skrypty()
    scripts.installer:update_scripts_to_latest_release()
end
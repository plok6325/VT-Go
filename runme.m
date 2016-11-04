%% run me
current_run_me_version='1.0.0';
page=urlread('https://github.com/plok6325/VT-Go');
image_V=regexp(page,'imgpatch\d\.\d\.\d\.zip');
run_me_version=page(regexp(page,'runme_version')+16:regexp(page,'runme_version')+20);
if strcmp(current_run_me_version,run_me_version)
else
    display('updating')
    websave('runme.m','https://github.com/plok6325/VT-Go/raw/master/runme.m');
end
main_version=page(regexp(page,'script_version')+17:regexp(page,'script_version')+21);
image_version=page(image_V(1)+8:image_V(1)+12);

[currentmainversion ,currentimageversion]=version_check;

if strcmp(currentimageversion,image_version) && strcmp(main_version,currentmainversion)
    main(image_version,1);
else
    display('new version found, updating ')
    zipname=['imgpatch',image_version,'.zip'];
    websave(zipname,['https://github.com/plok6325/VT-Go/raw/master/',zipname]);
    unzip(zipname,['.\images',image_version]);
    rmdir(['images',currentimageversion],'s')
    websave('main.m','https://github.com/plok6325/VT-Go/raw/master/main.m');
    display('done run script again');
end
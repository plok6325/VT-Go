%% run me

page=urlread('https://github.com/plok6325/VT-Go');
image_V=regexp(page,'images\d\.\d\.\d\.zip');

main_version=page(regexp(page,'script_version')+17:regexp(page,'script_version')+21);
image_version=page(image_V(1)+6:image_V(1)+10);


[currentmainversion ,currentimageversion]=version_check;


if strcmp(currentimageversion,image_version) && strcmp(main_version,currentmainversion)
    main(image_version,1);
else
    display('new version found, updating ')
    zipname=['images',image_version,'.zip'];
    websave(zipname,['https://github.com/plok6325/VT-Go/raw/master/',zipname]);
    unzip(zipname,['.\images',image_version]);
     rmdir(['images',currentimageversion],'s')
    websave('main.m','https://github.com/plok6325/VT-Go/raw/master/main.m');
    display('done run script again');
end
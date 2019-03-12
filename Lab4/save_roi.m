function save_roi(filename)
filefolder = 'X';
%filename = 'kt2';
video_file = strcat(filefolder, ':/lab4/', filename, '.mp4');
str = input('Vil du extracte ROI? y/n ','s');
if str == 'y'
    [output_channels, sample_rate] = read_video_and_extract_roi(video_file);
    save(strcat(filename,'.mat'),'output_channels','sample_rate')
end
end



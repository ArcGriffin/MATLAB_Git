function video = extract_frames(prompt)
%EXTRACT_FRAMES Summary of this function goes here
%   Detailed explanation goes here

[videoFile, videoPath]=uigetfile({'*.avi','Video Files (AVI)'},prompt,'multiselect','off');
vid = VideoReader([videoPath videoFile]);

%vid = VideoReader([videoFile]);
frames = read(vid);
frames = frames(:,:,1,:);
frames = squeeze(frames);

video.Frames = frames;
video.FrameRate = vid.FrameRate;
video.NumFrames = vid.NumFrames;

% n = vid.NumFrames;
% h = vid.Height;
% w = vid.Width;
% frames = zeros(h,w,n,'uint8');
% framesCut = zeros(h,w,n,'uint8');
% 
% i = 1;
% while hasFrame(vid)
%     frames(:,:,i) = rgb2gray(readFrame(vid));
%     framesCut(:,:,i) = frames(:,:,i);
%     i = i + 1;
% end


end


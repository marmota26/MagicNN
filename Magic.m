imds = imageDatastore('C:\Program Files\MATLAB\R2019b\examples\magic\NN','IncludeSubfolders',true,'LabelSource','foldernames','FileExtensions','.jpg');
numTrainFiles = 21;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
options = trainingOptions('sgdm', ...
    'MaxEpochs',100, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers_3,options);
[YPred,probs] = classify(net,imdsValidation);
accuracy = mean(YPred == imdsValidation.Labels)
idx = randperm(numel(imdsValidation.Files),20);
figure
for i = 1:20
    subplot(5,4,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label) + ", " + num2str(100*max(probs(idx(i),:)),3) + "%");
end
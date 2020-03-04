[YPred,probs] = classify(net,imds);
accuracy = mean(YPred == imds.Labels)
idx = randperm(numel(imds.Files),48);
figure
for i = 1:48
    subplot(8,6,i)
    I = readimage(imds,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label) + ", " + num2str(100*max(probs(idx(i),:)),3) + "%");
end
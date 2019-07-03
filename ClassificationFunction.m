function [lb,ub,dim,fobj] = ClassificationFunction(F)

fobj = @ClassificationFunction1;
        lb=[%Set the lower bound];
        ub=[%Set the upper bound]; 
        dim=%Set the dimension size;
end

function AccuracyT = ClassificationFunction1(X)

X = xlsread('FileName.xlsx','sheet1', '***:***');%Data read
Y = xlsread('FileName.xlsx','sheet1', '***:***');%Class read
[m,n] = size(X);
p     = 0.80; % - 80% train data and 20% test data
idx   = randperm(m);
XT    = X(idx(1:round(p*m)),:);
Xt    = X(idx(round(p*m)+1:end),:);
YT    = Y(idx(1:round(p*m)),:);
Yt    = Y(idx(round(p*m)+1:end),:);

classificationKNN = fitcknn(XT,YT, 'NumNeighbors',3,'distance','euclidean','distanceweight','equal','Standardize', true);
Loss              = resubLoss(classificationKNN,'lossfun','ClassifError');
Accuracy = -(1 - Loss);

label    = predict(classificationKNN,Xt);
count    = 0;
L        = (label);

%evalutaion of test accuracy
for i=1:Size_of_the_test_data
   if L(i)==Yt(i)
        count=count+1;
   end
 end
AccuracyT = -((count/Size_of_the_test_data)*100);
end

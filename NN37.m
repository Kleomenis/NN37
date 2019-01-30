
%creates a struct with the name of the training algorithms
nd=25
field = 'f'
value = 'trainlm'
field2 = 'f2'
field3 = 'f3'
value2 = 'trainbr'
value3 = 'trainscg'
list = struct (field, value,field2,value2, field3, value3)

fns = fieldnames(list);

%for loop to try different number of nodes each time (cross validation)
%variable cvnodes is the number of time we want to increase the number of nodes by 5
for cvnodes = 1:10

    %read input and output from CSV
    X = csvread('/home/guillem/loc/Assoc37.csv')
    y = csvread('/home/guillem/loc/Rew37binary.csv')

    %formating input and target
    x = X';
    t = y';
    
    % increase the number of nodes by 5
    nd = nd + 5 
    
    %for loop to try different training algorithms for each node value(crossvalidation)
    for lam = 1:3 
        
        %defines trainig algorithm by calling values from the list struct
        trainFcn = list.(fns{lam}) ;  
        name = list.(fns{lam})

        % Create a Fitting Networt
        hiddenLayerSize = nd;
        net = fitnet(hiddenLayerSize,trainFcn);

        % Setup Division of Data for Training, Validation, Testing
        net.divideParam.trainRatio = 100/100;
        net.divideParam.valRatio = 0/100;
        net.divideParam.testRatio = 0/100;

        % Train the Network
        [net,tr] = train(net,x,t);

        % Test the Network
        y = net(x);
        e = gsubtract(t,y);
        performance = perform(net,t,y)
        
        %Writes the results to a CSV file
        results = [performance,hiddenLayerSize,lam]
        dlmwrite ('/home/guillem/loc/results37.csv', results, 'delimiter',',', '-append');
        % View the Network
        view(net)

        % Plots
        % Uncomment these lines to enable various plots.
        %figure, plotperform(tr)
        %figure, plottrainstate(tr)
        %figure, ploterrhist(e)
        %figure, plotregression(t,y)
        %figure, plotfit(net,x,t)
        
    end
   
    clear x
    clear X
    clear y
end

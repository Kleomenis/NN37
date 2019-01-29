%Requirments: Matlabb R2018b (won't work with prior versions), Marc's framework

X = csvread('/home/guillem/loc/Associations37.csv') %change t path to the location of your CSV file
y = csvread('/home/guillem/loc/Rewards37.csv') % change the path to the location of your CSV file


%Main for loop
%Reads data from X and y, calls Marc's Framework, calculates the rewards and stores Associations and rewards 

for W = 1:2187 % change the value according to the number of samples. For 5 samples W= 1:5 for 200 samples W = 1:200, etc
    for L= 1:7 % change the value according to the number of STAs. For 7 STAs L = 1:7, for 5 STAs L = 1:5, etc
        %creates a varuable for each STA and assings an AP to it
        Column =X(W,L) % 
        eval(['STA' num2str(L) '= Column']) 
    end
    %call Marc's framework
    
     [rew,STA,AP] = Main(3,7,[STA1,STA2,STA3,STA4,STA5,STA6,STA7],1,"/home/guillem/loc/locations.csv")
     
     %calculate rewards
     
      for K= 1:7 % this value changes based on the number of STAs. For 7 STAs K =1:7, for 8 STAs K = 1:8, etc 
        if K==1
            inp = STA(K).associated_AP
            INPT = array2table(inp)
            INTT = INPT
        end
        inp = STA(K).associated_AP
        INPT = array2table(inp)
        INTT = [INTT ; INPT]

    end
    INTT([1],:) = [];
    INTTI = table2array(INTT)
    INTT = array2table(INTTI')
    Assoc = table2array(INTT)

    dlmwrite ('/home/guillem/loc/Assoc37t.csv', Assoc, 'delimiter',',', '-append');%saves associations in a CSV
    dlmwrite ('/home/guillem/loc/Rew37t.csv', floor(rew), 'delimiter',',', '-append'); %Saves rewards in a CSv and converts them to binary
end

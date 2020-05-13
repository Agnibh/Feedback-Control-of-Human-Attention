% Initializing 
function attentiongame()
yfit3=[];
y1=[];
z1=[];

alpha1=[];
theta1=[];
lowbeta1=[];
highbeta1=[];
gamma1=[];

AF3theta=[]; 
AF3alpha=[ ]; 
AF3gamma=[]; 
AF3highbeta=[ ]; 
AF3lowbeta=[]; 

F7theta=[]; 
F7alpha=[]; 
F7gamma=[]; 
F7highbeta=[ ]; 
F7lowbeta=[]; 

F3theta=[]; 
F3alpha=[]; 
F3gamma=[]; 
F3highbeta=[]; 
F3lowbeta=[ ]; 

FC5theta=[]; 
FC5alpha=[]; 
FC5gamma=[]; 
FC5highbeta=[]; 
FC5lowbeta=[ ]; 

T7theta=[]; 
T7alpha=[]; 
T7gamma=[]; 
T7highbeta=[]; 
T7lowbeta=[ ];

P7theta=[]; 
P7alpha=[]; 
P7gamma=[]; 
P7highbeta=[ ]; 
P7lowbeta=[]; 

Pztheta=[ ]; 
Pzalpha=[]; 
Pzgamma=[ ]; 
Pzhighbeta=[ ]; 
Pzlowbeta=[ ]; 

IED_O2theta=[ ]; 
IED_O2alpha=[ ]; 
IED_O2gamma=[ ]; 
IED_O2highbeta=[ ]; 
IED_O2lowbeta=[ ]; 

P8theta=[ ]; 
P8alpha=[ ]; 
P8gamma=[ ]; 
P8highbeta=[ ]; 
P8lowbeta=[]; 

IED_T8theta=[]; 
IED_T8alpha=[ ]; 
IED_T8gamma=[ ]; 
IED_T8highbeta=[ ]; 
IED_T8lowbeta=[ ]; 

IED_FC6theta=[]; 
IED_FC6alpha=[ ]; 
IED_FC6gamma=[ ]; 
IED_FC6highbeta=[]; 
IED_FC6lowbeta=[  ]; 

IED_F4theta=[]; 
IED_F4alpha=[ ]; 
IED_F4gamma=[ ]; 
IED_F4highbeta=[]; 
IED_F4lowbeta=[ ]; 

IED_F8theta=[ ]; 
IED_F8alpha=[  ]; 
IED_F8gamma=[ ]; 
IED_F8highbeta=[ ]; 
IED_F8lowbeta=[ ]; 

IED_AF4theta=[ ]; 
IED_AF4alpha=[   ]; 
IED_AF4gamma=[  ]; 
IED_AF4highbeta=[]; 
IED_AF4lowbeta=[  ]; 

w = warning ('off','all');
bitVersion = computer('arch');
if (strcmp(bitVersion, 'win64'))
    loadlibrary('C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/bin/win64/edk.dll','C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/include/Iedk.h','addheader','IedkErrorCode.h','addheader','IEmoStateDLL.h','addheader','FacialExpressionDetection.h','addheader','MentalCommandDetection.h','addheader','IEmotivProfile.h','addheader','EmotivLicense.h','alias','libIEDK');
    loadlibrary('C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/bin/win64/edk.dll','C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/include/IEmoStateDLL.h', 'alias', 'libIEmoStateDLL');
else
    loadlibrary('C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/bin/win32/edk.dll','C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/include/Iedk.h','addheader','IedkErrorCode.h','addheader','IEmoStateDLL.h','addheader','FacialExpressionDetection.h','addheader','MentalCommandDetection.h','addheader','IEmotivProfile.h','addheader','EmotivLicense.h','alias','libIEDK');
    loadlibrary('C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/bin/win32/edk.dll','C:/Users/deyag/Downloads/community-sdk-master/community-sdk-master/include/IEmoStateDLL.h', 'alias','libIEmoStateDLL');
end

% libfunctionsview('edk');
EDK_OK = 0;

%Full enum channels: 
%IEE_DataChannels_enum = struct('IED_COUNTER', 0, 'IED_INTERPOLATED', 1, 'IED_RAW_CQ', 2,'IED_AF3', 3, 'IED_F7',4, 'IED_F3', 5, 'IED_FC5', 6, 'IED_T7', 7,'IED_P7', 8, 'IED_Pz', 9,'IED_O2', 10, 'IED_P8', 11, 'IED_T8', 12, 'IED_FC6', 13, 'IED_F4', 14, 'IED_F8', 15, 'IED_AF4', 16, 'IED_GYROX', 17,'IED_GYROY', 18, 'IED_TIMESTAMP', 19,'IED_MARKER_HARDWARE', 20, 'IED_ES_TIMESTAMP',21, 'IED_FUNC_ID', 22, 'IED_FUNC_VALUE', 23, 'IED_MARKER', 24,'IED_SYNC_SIGNAL', 25);
%Hard-coded enum value based on IEE_DataChannels_enum (Iedk.h) for Insight headset sensor:
dataChannel = struct('IED_AF3', 3, 'IED_F7',4, 'IED_F3', 5, 'IED_FC5', 6, 'IED_T7', 7,'IED_P7', 8, 'IED_Pz', 9,'IED_O2', 10, 'IED_P8', 11, 'IED_T8', 12, 'IED_FC6', 13, 'IED_F4', 14, 'IED_F8', 15, 'IED_AF4', 16);
channelName = {'IED_AF3', 'IED_F7', 'IED_F3', 'IED_FC5', 'IED_T7','IED_P7', 'IED_Pz','IED_O2', 'IED_P8', 'IED_T8', 'IED_FC6', 'IED_F4', 'IED_F8','IED_AF4'};
res = calllib('libIEDK','IEE_EngineConnect', 'Emotiv Systems-5');
eEvent = calllib('libIEDK','IEE_EmoEngineEventCreate');
eState = calllib('libIEDK','IEE_EmoStateCreate');

% run 20 seconds
runtime = 20;
fprintf('Run time: %d \n', runtime);
userAdded = false;
numberSamplePtr = libpointer('uint32Ptr', 0);
thetaPtr = libpointer('doublePtr', 0);
alphaPtr = libpointer('doublePtr', 0);
lowBetaPtr = libpointer('doublePtr', 0);
highBetaPtr = libpointer('doublePtr', 0);
gammaPtr = libpointer('doublePtr', 0);
userIdPtr = libpointer('uint32Ptr', 0);
tic;

while (toc < runtime)
    state = calllib('libIEDK','IEE_EngineGetNextEvent',eEvent);
    
    if(state == EDK_OK)
        eventType = calllib('libIEDK','IEE_EmoEngineEventGetType',eEvent);
        calllib('libIEDK','IEE_EmoEngineEventGetUserId',eEvent, userIdPtr);
        if (strcmp(eventType,'IEE_UserAdded') == true)
            fprintf('User added: %d', userIdPtr.Value)
            userAdded = true;
        end
    end

    if (userAdded)
        if strcmp(eventType,'IEE_EmoStateUpdated') == true
            thetaPtr.Value = 0;
            alphaPtr.Value = 0;
            lowBetaPtr.Value = 0;
            highBetaPtr.Value = 0;
            gammaPtr.Value = 0;
            for index = 1 : numel(channelName)
                res = calllib('libIEDK','IEE_GetAverageBandPowers', userIdPtr.Value, dataChannel.([channelName{index}]), thetaPtr, alphaPtr, lowBetaPtr, highBetaPtr, gammaPtr);
                if (res == EDK_OK)
                    fprintf('theta: %f , alpha: %f , low beta: %f , high beta: %f , gamma: %f , channel: %s \n', thetaPtr.Value, alphaPtr.Value, lowBetaPtr.Value, highBetaPtr.Value, gammaPtr.Value, channelName{index});
                    theta1=[theta1; thetaPtr.Value];
                    alpha1=[alpha1; alphaPtr.Value];
                    lowbeta1=[lowbeta1; lowBetaPtr.Value];
                    highbeta1=[ highbeta1; highBetaPtr.Value];
                    gamma1=[gamma1;gammaPtr.Value];
                    i=length( theta1);
                     if  rem(i,14)==1
                         AF3theta=[AF3theta;thetaPtr.Value ]; 
                         AF3alpha=[AF3alpha;alphaPtr.Value ]; 
                         AF3gamma=[AF3gamma;gammaPtr.Value ]; 
                         AF3highbeta=[AF3highbeta;highBetaPtr.Value ]; 
                         AF3lowbeta=[AF3lowbeta;lowBetaPtr.Value ]; 
                     end
                     if  rem(i,14)==2
                         F7theta=[F7theta;thetaPtr.Value ]; 
                         F7alpha=[F7alpha;alphaPtr.Value ]; 
                         F7gamma=[F7gamma;gammaPtr.Value ]; 
                         F7highbeta=[F7highbeta;highBetaPtr.Value ]; 
                         F7lowbeta=[F7lowbeta;lowBetaPtr.Value ]; 
                     end
                      if  rem(i,14)==3
                         F3theta=[F3theta;thetaPtr.Value ]; 
                         F3alpha=[F3alpha;alphaPtr.Value ]; 
                         F3gamma=[F3gamma;gammaPtr.Value ]; 
                         F3highbeta=[F3highbeta;highBetaPtr.Value ]; 
                         F3lowbeta=[F3lowbeta;lowBetaPtr.Value ]; 
                      end
                     if  rem(i,14)==4
                         FC5theta=[FC5theta;thetaPtr.Value ]; 
                         FC5alpha=[FC5alpha;alphaPtr.Value ]; 
                         FC5gamma=[FC5gamma;gammaPtr.Value ]; 
                         FC5highbeta=[FC5highbeta;highBetaPtr.Value ]; 
                         FC5lowbeta=[FC5lowbeta;lowBetaPtr.Value ]; 
                     end
                      if  rem(i,14)==5
                         T7theta=[T7theta;thetaPtr.Value ]; 
                         T7alpha=[T7alpha;alphaPtr.Value ]; 
                         T7gamma=[T7gamma;gammaPtr.Value ]; 
                         T7highbeta=[T7highbeta;highBetaPtr.Value ]; 
                         T7lowbeta=[T7lowbeta;lowBetaPtr.Value ]; 
                      end
                       if  rem(i,14)==6
                         P7theta=[P7theta;thetaPtr.Value ]; 
                         P7alpha=[P7alpha;alphaPtr.Value ]; 
                         P7gamma=[P7gamma;gammaPtr.Value ]; 
                         P7highbeta=[P7highbeta;highBetaPtr.Value ]; 
                         P7lowbeta=[P7lowbeta;lowBetaPtr.Value ]; 
                       end
                       if  rem(i,14)==7
                         Pztheta=[ Pztheta;thetaPtr.Value ]; 
                         Pzalpha=[ Pzalpha;alphaPtr.Value ]; 
                         Pzgamma=[ Pzgamma;gammaPtr.Value ]; 
                         Pzhighbeta=[ Pzhighbeta;highBetaPtr.Value ]; 
                         Pzlowbeta=[ Pzlowbeta;lowBetaPtr.Value ]; 
                     end
                     if  rem(i,14)==8
                         IED_O2theta=[ IED_O2theta;thetaPtr.Value ]; 
                         IED_O2alpha=[ IED_O2alpha;alphaPtr.Value ]; 
                         IED_O2gamma=[ IED_O2gamma;gammaPtr.Value ]; 
                         IED_O2highbeta=[IED_O2highbeta;highBetaPtr.Value ]; 
                         IED_O2lowbeta=[ IED_O2lowbeta;lowBetaPtr.Value ]; 
                     end
                      if  rem(i,14)==9
                        P8theta=[ P8theta;thetaPtr.Value ]; 
                        P8alpha=[ P8alpha;alphaPtr.Value ]; 
                        P8gamma=[ P8gamma;gammaPtr.Value ]; 
                        P8highbeta=[P8highbeta;highBetaPtr.Value ]; 
                        P8lowbeta=[ P8lowbeta;lowBetaPtr.Value ]; 
                      end
                      if  rem(i,14)==10
                        IED_T8theta=[IED_T8theta;thetaPtr.Value ]; 
                        IED_T8alpha=[ IED_T8alpha;alphaPtr.Value ]; 
                        IED_T8gamma=[ IED_T8gamma;gammaPtr.Value ]; 
                        IED_T8highbeta=[IED_T8highbeta;highBetaPtr.Value ]; 
                        IED_T8lowbeta=[ IED_T8lowbeta;lowBetaPtr.Value ]; 
                      end
                      if  rem(i,14)==11
                        IED_FC6theta=[IED_FC6theta;thetaPtr.Value ]; 
                        IED_FC6alpha=[ IED_FC6alpha;alphaPtr.Value ]; 
                        IED_FC6gamma=[ IED_FC6gamma;gammaPtr.Value ]; 
                        IED_FC6highbeta=[IED_FC6highbeta;highBetaPtr.Value ]; 
                        IED_FC6lowbeta=[ IED_FC6lowbeta;lowBetaPtr.Value ]; 
                      end
                      if  rem(i,14)==12
                        IED_F4theta=[IED_F4theta;thetaPtr.Value ]; 
                        IED_F4alpha=[ IED_F4alpha;alphaPtr.Value ]; 
                        IED_F4gamma=[ IED_F4gamma;gammaPtr.Value ]; 
                        IED_F4highbeta=[IED_F4highbeta;highBetaPtr.Value ]; 
                        IED_F4lowbeta=[ IED_F4lowbeta;lowBetaPtr.Value ]; 
                       end 
                       if  rem(i,14)==13
                        IED_F8theta=[ IED_F8theta;thetaPtr.Value ]; 
                        IED_F8alpha=[  IED_F8alpha;alphaPtr.Value ]; 
                        IED_F8gamma=[  IED_F8gamma;gammaPtr.Value ]; 
                        IED_F8highbeta=[ IED_F8highbeta;highBetaPtr.Value ]; 
                        IED_F8lowbeta=[  IED_F8lowbeta;lowBetaPtr.Value ]; 
                       end     
                       if  rem(i,14)==0
                        IED_AF4theta=[ IED_AF4theta;thetaPtr.Value ]; 
                        IED_AF4alpha=[  IED_AF4alpha;alphaPtr.Value ]; 
                        IED_AF4gamma=[  IED_AF4gamma;gammaPtr.Value ]; 
                        IED_AF4highbeta=[ IED_AF4highbeta;highBetaPtr.Value ]; 
                        IED_AF4lowbeta=[  IED_AF4lowbeta;lowBetaPtr.Value ]; 
                       end  
  
  
                        AF3=[AF3alpha AF3theta AF3gamma  AF3highbeta  AF3lowbeta];
                        F7=[ F7alpha F7theta  F7gamma F7highbeta F7lowbeta];
                        F3=[ F3alpha F3theta  F3gamma F3highbeta F3lowbeta];
                        FC5=[ FC5alpha FC5theta FC5gamma FC5highbeta FC5lowbeta];
                        T7=[  T7alpha  T7theta  T7gamma T7highbeta T7lowbeta]; 
                        P7=[ P7alpha  P7theta P7gamma P7highbeta P7lowbeta];     
                        Pz=[Pzalpha Pztheta Pzgamma  Pzhighbeta Pzlowbeta]; 
                        IED_O2=[IED_O2alpha  IED_O2theta IED_O2gamma  IED_O2highbeta IED_O2lowbeta];
                        P8=[ P8alpha P8theta P8gamma P8highbeta P8lowbeta]; 
                        IED_T8=[ IED_T8alpha IED_T8theta  IED_T8gamma IED_T8highbeta IED_T8lowbeta]; 
                        IED_FC6=[IED_FC6alpha IED_FC6theta  IED_FC6gamma IED_FC6highbeta IED_FC6lowbeta]; 
                        IED_F4=[IED_F4alpha IED_F4theta IED_F4gamma IED_F4highbeta IED_F4lowbeta]; 
                        IED_F8=[IED_F8alpha IED_F8theta IED_F8gamma IED_F8highbeta IED_F8lowbeta]; 
                        IED_AF4=[IED_AF4alpha IED_AF4theta IED_AF4gamma IED_AF4highbeta IED_AF4lowbeta];

                        %Discarding the Excess Value per Iteration without Overwritting
                        
                        I=size(IED_AF4,1)+1;
                        if I>14
                            AF3new=AF3; 
                            AF3new(I:end,:)=[];
                            T7new=T7; 
                            T7new(I:end,:)=[];
                            P7new=P7; 
                            P7new(I:end,:)=[];
                            Pznew=Pz;
                            Pznew(I:end,:)=[];
                            IED_O2new=IED_O2;
                            IED_O2new(I:end,:)=[];
                            P8new=P8;
                            P8new(I:end,:)=[];
                            IED_T8new=IED_T8;
                            IED_T8new(I:end,:)=[];
                            IED_AF4new=IED_AF4;
                            IED_AF4new(I:end,:)=[]; 
                            Data1=[AF3new T7new P7new Pznew IED_O2new P8new IED_T8new IED_AF4new];
                            
                            % Predicting the Value and Plotting it 
                            
                            if I>9
                                yfit3=predict(gprMdl,Data1)
                                y1=sgolayfilt(yfit3,3,9);

                                figure(6)
                                clf
                                plot(yfit3)
                                hold on
                                plot(y1)

% y=attentiongame(y1)
                               


                            end
                        end
                    end
                end
            end    	
        end
end
calllib('libIEDK','IEE_EngineDisconnect')
calllib('libIEDK','IEE_EmoStateFree',eState);
calllib('libIEDK','IEE_EmoEngineEventFree',eEvent);

disp('finish');

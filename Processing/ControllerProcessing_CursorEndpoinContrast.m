%% This code is for controller processing, plot Cursor/Endpoint feedback abs errors
%% To be placed in the \DATA file to access both FPSC and OnlineCursor folders
% Written by Mengzhan Liufu at UChicago.
xCenter = 960;
yCenter = 540;
finaldata = [0 0];
targetdata = [0 0];

% Calculate All Subjects Avg Abs Err for Endpoint Feedback grouop
FPSC_subject_list_num = [3 4 5 6 7 11 13 14 16 17 23];
FPSC_subject_list_size = size(FPSC_subject_list_num);
FPSC_subject_list_letter = char(FPSC_subject_list_num+'A'-1);
FPSC_subject_list_length = FPSC_subject_list_size(2);
FPSC_allsubject_abserr = zeros(FPSC_subject_list_length,210);
FPSC_allsubject_signederr = zeros(FPSC_subject_list_length,210);
FPSC_avgsubject_abserr = zeros(1,210);
FPSC_avgsubject_signederr = zeros(1,210);
FPSC_avgsubject_block_abserr = zeros(1,7);
FPSC_avg_block_error = zeros(1,7);

% Calculate All Subjects Avg Abs Err for Cursor Feedback grouop
Cursor_subject_list_num = [1 2 3 4];
Cursor_subject_list_size = size(Cursor_subject_list_num);
Cursor_subject_list_letter = char(Cursor_subject_list_num+'A'-1);
Cursor_subject_list_length = Cursor_subject_list_size(2);
Cursor_allsubject_abserr = zeros(Cursor_subject_list_length,210);
Cursor_allsubject_signederr = zeros(Cursor_subject_list_length,210);
Cursor_avgsubject_abserr = zeros(1,210);
Cursor_avgsubject_signederr = zeros(1,210);
Cursor_avgsubject_block_abserr = zeros(1,7);
Cursor_avg_block_error = zeros(1,7);

%the DATA folder directory
root_dir = pwd;

% Log FPSC group data, calculate abserr across trials
cd('FPSC');
currentdataset = pwd;
for p = 1:FPSC_subject_list_length
    cd(FPSC_subject_list_letter(p));
    cd("Controller");
    currentfolder = pwd;
    for i = 1:3
        currentblock = strcat('Block',num2str(i));
        cd(currentblock);
        target = cell2mat(struct2cell(load('Trial1.mat','targetarray')));        
        for j = 1:30
            currenttrial = strcat('Trial',num2str(j),'.mat');
            trajectory = cell2mat(struct2cell(load(currenttrial,'trialtrajectory')));
            trajsize = size(trajectory);
            final = trajsize(1);
            finalx = trajectory(final,2) - xCenter;
            finaly = trajectory(final,3) - yCenter;

            n = target(j);
            if n < 10
                targetx = xCenter+546.5*cosd(abs(n*3-15));
                targety = yCenter+546.5*sind(n*3-15);
            else
                targetx = xCenter-546.5*cosd(abs((n-9)*3-15));
                targety = yCenter+546.5*sind((n-9)*3-15);
            end
            targetx = targetx - xCenter;
            targety = targety - yCenter;

            abserr = abs(atand(finaly/finalx)-atand(targety/targetx));
            signederr = atand(finaly/finalx)-atand(targety/targetx);
            FPSC_allsubject_abserr(p,(i-1)*30+j) = abserr;
            FPSC_allsubject_signederr(p,(i-1)*30+j) = signederr;
        end
        cd(currentfolder)
    end

    for i = 4:7
        currentblock = strcat('Block',num2str(i));
        cd(currentblock);
        target = cell2mat(struct2cell(load('Trial1.mat','targetarray')));
        for j = 1:30
            currenttrial = strcat('Trial',num2str(j),'.mat');
            trajectory = cell2mat(struct2cell(load(currenttrial,'trialtrajectory')));
            trajsize = size(trajectory);
            final = trajsize(1);
            finalx = trajectory(final,2) - xCenter;
            finaly = trajectory(final,3) - yCenter;

            n = target(j);
            if n < 10
                targetx = xCenter+546.5*cosd(abs(n*3-15));
                targety = yCenter+546.5*sind(n*3-15);
            else
                targetx = xCenter-546.5*cosd(abs((n-9)*3-15));
                targety = yCenter+546.5*sind((n-9)*3-15);
            end
            targetx = targetx - xCenter;
            targety = yCenter - targety;

            abserr = abs(atand(finaly/finalx)-atand(targety/targetx));
            signederr = atand(finaly/finalx)-atand(targety/targetx);
            FPSC_allsubject_abserr(p,(i-1)*30+j) = abserr;
            FPSC_allsubject_signederr(p,(i-1)*30+j) = signederr;
        end
        cd(currentfolder);
    end
    cd(currentdataset);
end

for m = 1:210 
    FPSC_avgsubject_abserr(1,m) = sum(FPSC_allsubject_abserr(:,m))/FPSC_subject_list_length;
    FPSC_avgsubject_signederr(1,m) = sum(FPSC_allsubject_signederr(:,m))/FPSC_subject_list_length;
end

cd(root_dir);
cd('Controller_OnlineCursor');

% Log Cursor group data, calculate abserr across trials
currentdataset = pwd;
for p = 1:Cursor_subject_list_length
    cd(Cursor_subject_list_letter(p));
    %cd("Controller");
    currentfolder = pwd;
    for i = 1:3
        currentblock = strcat('Block',num2str(i));
        cd(currentblock);
        target = cell2mat(struct2cell(load('Trial1.mat','targetarray')));        
        for j = 1:30
            currenttrial = strcat('Trial',num2str(j),'.mat');
            trajectory = cell2mat(struct2cell(load(currenttrial,'trialtrajectory')));
            trajsize = size(trajectory);
            final = trajsize(1);
            finalx = trajectory(final,2) - xCenter;
            finaly = trajectory(final,3) - yCenter;

            n = target(j);
            if n < 10
                targetx = xCenter+546.5*cosd(abs(n*3-15));
                targety = yCenter+546.5*sind(n*3-15);
            else
                targetx = xCenter-546.5*cosd(abs((n-9)*3-15));
                targety = yCenter+546.5*sind((n-9)*3-15);
            end
            targetx = targetx - xCenter;
            targety = targety - yCenter;

            abserr = abs(atand(finaly/finalx)-atand(targety/targetx));
            signederr = atand(finaly/finalx)-atand(targety/targetx);
            Cursor_allsubject_abserr(p,(i-1)*30+j) = abserr;
            Cursor_allsubject_signederr(p,(i-1)*30+j) = signederr;
        end
        cd(currentfolder)
    end

    for i = 4:7
        currentblock = strcat('Block',num2str(i));
        cd(currentblock);
        target = cell2mat(struct2cell(load('Trial1.mat','targetarray')));
        for j = 1:30
            currenttrial = strcat('Trial',num2str(j),'.mat');
            trajectory = cell2mat(struct2cell(load(currenttrial,'trialtrajectory')));
            trajsize = size(trajectory);
            final = trajsize(1);
            finalx = trajectory(final,2) - xCenter;
            finaly = trajectory(final,3) - yCenter;

            n = target(j);
            if n < 10
                targetx = xCenter+546.5*cosd(abs(n*3-15));
                targety = yCenter+546.5*sind(n*3-15);
            else
                targetx = xCenter-546.5*cosd(abs((n-9)*3-15));
                targety = yCenter+546.5*sind((n-9)*3-15);
            end
            targetx = targetx - xCenter;
            targety = yCenter - targety;

            abserr = abs(atand(finaly/finalx)-atand(targety/targetx));
            signederr = atand(finaly/finalx)-atand(targety/targetx);
            Cursor_allsubject_abserr(p,(i-1)*30+j) = abserr;
            Cursor_allsubject_signederr(p,(i-1)*30+j) = signederr;
        end
        cd(currentfolder);
    end
    cd(currentdataset);
end

cd(root_dir);

for m = 1:210 
    Cursor_avgsubject_abserr(1,m) = sum(Cursor_allsubject_abserr(:,m))/Cursor_subject_list_length;
    Cursor_avgsubject_signederr(1,m) = sum(Cursor_allsubject_signederr(:,m))/Cursor_subject_list_length;
end

for k = 1:30
    FPSC_avgsubject_block_abserr(1,1) = FPSC_avgsubject_block_abserr(1,1) + FPSC_avgsubject_abserr(1,k);
    Cursor_avgsubject_block_abserr(1,1) = Cursor_avgsubject_block_abserr(1,1) + Cursor_avgsubject_abserr(1,k);
end

for k = 31:60
    FPSC_avgsubject_block_abserr(1,2) = FPSC_avgsubject_block_abserr(1,2) + FPSC_avgsubject_abserr(1,k);
    Cursor_avgsubject_block_abserr(1,2) = Cursor_avgsubject_block_abserr(1,2) + Cursor_avgsubject_abserr(1,k);
end

for k = 61:90
    FPSC_avgsubject_block_abserr(1,3) = FPSC_avgsubject_block_abserr(1,3) + FPSC_avgsubject_abserr(1,k);
    Cursor_avgsubject_block_abserr(1,3) = Cursor_avgsubject_block_abserr(1,3) + Cursor_avgsubject_abserr(1,k);
end

for k = 91:120
    FPSC_avgsubject_block_abserr(1,4) = FPSC_avgsubject_block_abserr(1,4) + FPSC_avgsubject_abserr(1,k);
    Cursor_avgsubject_block_abserr(1,4) = Cursor_avgsubject_block_abserr(1,4) + Cursor_avgsubject_abserr(1,k);
end

for k = 121:150
    FPSC_avgsubject_block_abserr(1,5) = FPSC_avgsubject_block_abserr(1,5) + FPSC_avgsubject_abserr(1,k);
    Cursor_avgsubject_block_abserr(1,5) = Cursor_avgsubject_block_abserr(1,5) + Cursor_avgsubject_abserr(1,k);
end

for k = 151:180
    FPSC_avgsubject_block_abserr(1,6) = FPSC_avgsubject_block_abserr(1,6) + FPSC_avgsubject_abserr(1,k);
    Cursor_avgsubject_block_abserr(1,6) = Cursor_avgsubject_block_abserr(1,6) + Cursor_avgsubject_abserr(1,k);
end

for k = 181:210
    FPSC_avgsubject_block_abserr(1,7) = FPSC_avgsubject_block_abserr(1,7) + FPSC_avgsubject_abserr(1,k);
    Cursor_avgsubject_block_abserr(1,7) = Cursor_avgsubject_block_abserr(1,7) + Cursor_avgsubject_abserr(1,k);
end

for i = 1:7
    FPSC_avgsubject_block_abserr(1,i) = FPSC_avgsubject_block_abserr(1,i)/30;
    Cursor_avgsubject_block_abserr(1,i) = Cursor_avgsubject_block_abserr(1,i)/30;
    FPSC_block_error = 0;
    Cursor_block_error = 0;
    for j = (i-1)*30+1 : i*30
        FPSC_block_error = FPSC_block_error + abs(FPSC_avgsubject_block_abserr(1,i)-FPSC_avgsubject_abserr(1,j));
        Cursor_block_error = Cursor_block_error + abs(Cursor_avgsubject_block_abserr(1,i)-Cursor_avgsubject_abserr(1,j));
    end
    FPSC_avg_block_error(i) = FPSC_block_error/30;
    Cursor_avg_block_error(i) = Cursor_block_error/30;
end

% Plot absolute error
figure;
hold on;
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times');
xlabel('Trial #')
ylabel('Absolute Error (Degree)')
title('Absolute Reach Error on each Trial')

FPSC_plot_abs = plot(FPSC_avgsubject_abserr,'ok-','color','r','linewidth',1.1,'markerfacecolor','r');
set(FPSC_plot_abs,{'DisplayName'},{'Endpoint'})

Cursor_plot_abs = plot(Cursor_avgsubject_abserr,'ok-','color','b','linewidth',1.1,'markerfacecolor','b');
set(Cursor_plot_abs,{'DisplayName'},{'Cursor'})

Endpoint_x_NVF = [60,60,90,90];
Endpoint_y_NVF = [0,25,25,0];
h1 = fill(Endpoint_x_NVF,Endpoint_y_NVF,[128, 128, 128]/255);
set(h1,'edgealpha',0,'facealpha',0.3,{'DisplayName'},{'No Visual'});
axis([0 210 0 25])
legend
grid on;

% Plot signed error
figure;
hold on;
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times');
xlabel('Trial #')
ylabel('Reach Direction Relative to target (Degree)')
title('Signed Reach Error on each Trial')

FPSC_plot_signed = plot(FPSC_avgsubject_signederr,'ok-','color','r','linewidth',1.1,'markerfacecolor','r');
set(FPSC_plot_signed,{'DisplayName'},{'Endpoint'})

Cursor_plot_signed = plot(Cursor_avgsubject_signederr,'ok-','color','b','linewidth',1.1,'markerfacecolor','b');
set(Cursor_plot_signed,{'DisplayName'},{'Cursor'})

Cursor_x_NVF = [60,60,90,90];
Cursor_y_NVF = [-15,15,15,-15];
h2 = fill(Cursor_x_NVF,Cursor_y_NVF,[128, 128, 128]/255);
set(h2,'edgealpha',0,'facealpha',0.3,{'DisplayName'},{'No Visual'});
axis([0 210 -15 15])
legend
grid on;

% Plot FPSC group abs err by block average
blocks = 1:7;
figure;
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times');
hold on;
sgtitle('Average Absolute Error By Block')
subplot(1,2,1);
hold on;
title('Endpoint Feedback Group')
bar(blocks,FPSC_avgsubject_block_abserr);
er1 = errorbar(blocks,FPSC_avgsubject_block_abserr,FPSC_avg_block_error);
ylabel('Average Absolute Error (Degree)')
xlabel('Block #')

subplot(1,2,2);
hold on;
title('Cursor Feedback Group')
bar(blocks,Cursor_avgsubject_block_abserr);
er2 = errorbar(blocks,Cursor_avgsubject_block_abserr,Cursor_avg_block_error);
xlabel('Block #')

% ANOVA analysis for Cursor reversal blocks and Endpoint reversal blocks
% Reversal_avgsubject_abserr = zeros(1,180);
% for k = 91:210
%     Reversal_avgsubject_abserr(k-90) = FPSC_avgsubject_abserr(k);
%     Reversal_avgsubject_abserr(k+30) = Cursor_avgsubject_abserr(k);
% end
% 
% Reversal_group = cell(1,240);
% for m = 1:120
%     Reversal_group{1,m} = 'Endpoint Feedback Reversal';
% end
% 
% for m = 121:240
%     Reversal_group{1,m} = 'Cursor Feedback Reversal';
% end
% 
% [p,tbl,stats] = anova1(Reversal_avgsubject_abserr,Reversal_group);
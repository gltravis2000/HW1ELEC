% This is my Homework 1 matlab code
% Garrett Travis
% 2/21/2021
% Question 1

clear all;clc;

A = readmatrix('Example2.3-1.xlsx')         % This is a matrix of the data given in the example
Truevalues = A(:, 1);                                     % These are the true values
Measuredvalues = A(:, 2:end);                   % These are the measured values for each cycle

R = (1.29 * Truevalues) - 0.374;                % Correlating function given in book

Zerosmatrix = zeros(21,7);                          % This is the zeros matrix used to calculate deviation

Deviation(:, 1) = Truevalues(:, 1);

% To calculate deviation
for i = 1:21
    for j = 2:7
        Deviation(i, j) = A(i, j) - R(i, 1);             % This is the deviation data that is equal to the deviation data in the book
    end
end


%% i. Finding the Accuracy Limits

MaxValue = max(R)
MinValue = min(R)
AccuracySpan = max(R) - min(R)              % This is the output accuracy span

MaxLimit = max(max(Deviation(:, 2:end)));
MinLimit = min(min(Deviation(:, 2:end)));
MaxLimitPercent = (MaxLimit / AccuracySpan) * 100           % This is the max output percentage
MinLimitPercent = (MinLimit / AccuracySpan) * 100              % This is the min output percentage


%% ii. Finding the Linearity Error

for i = 1:21
    Average(i, j) = mean(Deviation(i, 2:7), 2, 'omitnan');          % This is the for loop used to calculate the averages of the deviation data
end

DeviationwAverage = [Deviation Average(:, 7)];

for i =1:11
    Average2(i, j) = (DeviationwAverage(i, 8) + DeviationwAverage(22 - i, 8)) /2;           % This is the for loop used to calculate the average up and down values
end

Average2(1, 7) = DeviationwAverage(21, 8);
AverageUpDown = Average2(:, 7);

FitSlope = (AverageUpDown(11) - AverageUpDown(1)) / 5;
yint = AverageUpDown(1);
TrueValues2 = 0:0.5:5;
LineFit = yint + FitSlope * TrueValues2;

for i = 1:11
    AverageUpDownsum = sum(abs(AverageUpDown(i)));
end

AverageUpDownsum2 = AverageUpDownsum / 11;
LineDifference = abs(LineFit) - AverageUpDownsum2;
LineError = (max(LineDifference))
LineErrorPercent = (LineError / AccuracySpan) * 100


%% iii. Finding the Repeatability Error

for i = 1
    Repeatability(i, 1) = NaN;
end

for i = 2:5
    Repeatability(i, 1) = max(DeviationwAverage(i, 3:7)) - min(DeviationwAverage(i, 3:7));
end

Repeatability(6, 1) = max(DeviationwAverage(6, 2:7)) - min(DeviationwAverage(6, 2:7));

for i = 7:21
    Repeatability(i, 1) = max(DeviationwAverage(i, 2:6)) - min(DeviationwAverage(i, 2:6));
end

Repeatability;

RepeatabilityError = max(Repeatability)
RepeatabilityErrorPercent = (RepeatabilityError / AccuracySpan) * 100


%% iv. Finding the Hysteresis Error

for j = 2:6
    for i = 2:10
        HysteresisValues(i - 1, j - 1) = abs(DeviationwAverage(i, j) - DeviationwAverage(21 - (i - 1), j));
    end
end

HysteresisValues;

HysteresisError = max(max(HysteresisValues))
HysteresisErrorPercent = (HysteresisError / AccuracySpan) * 100


%% v. Finding the Maximum Systematic Error

MaxSysErrorUp = min(Average(2:11, 7))
MaxSysErrorUpPercent = (MaxSysErrorUp / AccuracySpan) * 100

MaxSysErrorDown = max(Average(11:21, 7))
MaxSysErrorDownPercent = (MaxSysErrorDown / AccuracySpan) * 100


%% i. Plotting the Scale Readings

figure(1)
plot(Truevalues, A(:, 2), 'mo', Truevalues, A(:, 3), 'ro', Truevalues, A(:, 4), 'go', Truevalues, A(:, 5), 'yo', Truevalues, A(:, 6), 'co', Truevalues, A(:, 7), 'bo')
xlabel('True Weight (lb)')
ylabel('Scale Reading (lb)')
title('Plot of Scale Readings')


%% ii. Plotting the Deviation Data

figure(2)
plot(Truevalues, Deviation(:, 2), 'mo', Truevalues, Deviation(:, 3), 'ro', Truevalues, Deviation(:, 4), 'go', Truevalues, Deviation(:, 5), 'yo', Truevalues, Deviation(:, 6), 'co', Truevalues, Deviation(:, 7), 'bo')
xlabel('True Weight (lb)')
ylabel('Deviation (lb)')
title('Plot of Deviation Data')


%% iii. Plotting the Average Deviation Data

UpValues = DeviationwAverage(1:11, 8);
DownValues = DeviationwAverage(11:21, 8);
flipDownValues = flip(DownValues, 1);

figure(3)
plot(Truevalues(1:11, :), AverageUpDown, 'mo', Truevalues(1:11, :), UpValues, 'ro', Truevalues(1:11, :), flipDownValues, 'go')
xlabel('True Weight (lb)')
ylabel('Average Deviation (lb)')
title('Plot of Average Deviation Data')

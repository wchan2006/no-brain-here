% This program finds a given lenght of a running ones (1's)
% in a sequence of 1's and 0's. A run always starts with an '1'.
% A run is considered not broken in one zero is found within a run of 1's.
% Once a run is found, the bits in that found run are not used again
% to search a next run; the next run search begins immediately
% after the index where the found run ends.


% Problem analysis
% While it is not a restriction, strictly speaking, 
% the length of run to be searched shall be greater 3,
% that mean, the first 3 bits of the run shall be '110'
% or '111' to make sense.

% number of 1's and 0's in the sample to be generated randomly
N = 20;
% Lower boundary for the random numbers generated
low = 2.20;
% Upper boundary for the random numbers generated
high = 2.90;
% Used to convert the sample of floating numbers to 0,
% if the floating number is less than the value of mid,
% otherwise it is converted to 1.
mid = 2.53;
% Generate a set of random floating numbers
randFloates = ((high-low) .* rand(N,1) + low);
% Convert the floating numbers to 1's and 0's
sample = double(randFloates > mid);

% TEST/DEBUG: removed to use randomly generated numbers
% sample = [0 0 0 1 0 0 1 0 1 0 1 0 1 1 1 1 0 1 1 1];

% Length of sample
sampleLen = length(sample);

fprintf("Sample = ")
fprintf("%d ", sample);
fprintf("\nLength of run = %d\n", sampleLen);

% The length of run, a run may contain one '0'.
RunLength = 5;

% Array that holds the poisitions (indices) of the beginning of the runs
runIndex = [];

% where a run starts
curRunPos = 0;
% where a run ends, i.e, position of second zero
curEndPos = 0;
% When a second zero is found, if the difference between
% currentTermPos and currentRunPos is >= RunLength, then
% it is a run.
HaveSeenZero = 0;

pos = 1;
while (pos <= sampleLen)
    
    % Find the (next) first occurrence of '1'
    while (pos <= sampleLen)
        if sample(pos) == 1
            curRunPos = pos;
            break
        end
        pos = pos + 1;
    end
    fprintf("1: P=%3d R=%3d T=%3d\n", pos, curRunPos, curEndPos);    
    
    % Find the next zero.
    % If a zero is found, the run is considered not-yet broken.
    % If one more zero is found, then the run is broken.
    while (pos <= sampleLen)
        if sample(pos) ~= 1
            HaveSeenZero = HaveSeenZero + 1;
            if HaveSeenZero >= 2
                if sample(pos-1) == 1
                    curEndPos = pos;
                end
                break  % out of the inner while-loop
            end
        end
        pos = pos + 1;
    end
    fprintf("2: P=%3d R=%3d T=%3d\n", pos, curRunPos, curEndPos);    
    
    % if currentRunPos and currentTermPos are not zero,
    % meaning pointing to respective positions in the sample,
    % then the length is calculated between the two indices.
    % If a run is determined to be found,
    % then re-initialize the indices.
    if (curRunPos ~= 0) && (curEndPos ~= 0)
        if (curEndPos - curRunPos) >= RunLength
            runIndex = [runIndex curRunPos];
            runIndex = [runIndex (curEndPos - 1)];
        else
            pos = curRunPos;
        end
        curRunPos = 0;
        curEndPos = 0;
        HaveSeenZero = 0;    
    end
    fprintf("3: P=%3d R=%3d T=%3d\n", pos, curRunPos, curEndPos);   
    
    pos = pos + 1;
end

runsAt = runIndex
% divided by 2 because we are adding the terminating postion
% in the array also, so we know what is being counted (good debugging)
numberOfRuns = length(runIndex) / 2



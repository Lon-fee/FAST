function [Success] = TestUpstreamSplit()
%battery resize
% [Success] = TestUpstreamSplit()
% written by Vaibhav Rau, vaibhav.rau@warriorlife.net
% last updated: 3 aug 2024
%
% Generate simple test cases to confirm that the upstream power script
% is working properly.
%
% INPUTS:
%     none
%
% OUTPUTS:
%     Success - flag to show whether all of the tests passed (1) or not (0)
%


%% TEST CASE SETUP %%
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            %
% setup testing methods      %
%                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% relative tolerance for checking if the tests passed
EPS06 = 1.0e-06;

% assume all tests passed
Pass = ones(2, 1);

% count the tests
itest = 1;

%% CASE 1: SINGLE ENGINE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            %
% setup the inputs           %
%                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define constants for the split
TestIn.Pups = [5000, 3000];
TestIn.Pdwn = [4000, 4000];
TestIn.Arch = [1, 1; 1, 1]; 
TestIn.Oper = [23, 44; 18, 48];
TestIn.Eff = [90, 85; 88, 92];

% ----------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            %
% run the test               %
%                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% complete the power split
TestValue = PropulsionPkg.UpstreamSplit(TestIn.Pups, TestIn.Pdwn, ...
    TestIn.Arch, TestIn.Oper, TestIn.Eff)

% list the correct values of the output
TrueValue = 1;

% run the test
Pass(itest) = CheckTest(TestValue, TrueValue, EPS06);

% increment the test counter
itest = itest + 1;

%% CASE 2: MULTIPLE ENGINES %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            %
% setup the inputs           %
%                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define constants for the split
TestIn.Pups = [800000, 800000, 400000, 300000];
TestIn.Pdwn = [600000, 300000, 200000];
TestIn.Arch = [1, 0, 0; 1, 0, 0; 0, 1, 0; 0, 0, 1]; 
TestIn.Oper = [25, 15, 10; 25, 15, 10; 25, 15, 10; 25, 15, 10];
TestIn.Eff = [95, 90, 85; 95, 90, 85; 95, 90, 85; 95, 90, 85];

% ----------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            %
% run the test               %
%                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% complete the power split
TestValue = PropulsionPkg.UpstreamSplit(TestIn.Pups, TestIn.Pdwn, ...
    TestIn.Arch, TestIn.Oper, TestIn.Eff)

% list the correct values of the output
TrueValue = 1;

% run the test
Pass(itest) = CheckTest(TestValue, TrueValue, EPS06);

% increment the test counter
itest = itest + 1;

% ----------------------------------------------------------

%% CHECK THE TEST RESULTS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%compute the answers

% identify any tests that failed
itest = find(~Pass);

% check whether any tests failed
if (isempty(itest))
    
    % all tests passed
    fprintf(1, "TestUpstreamSplit tests passed!\n");
    
    % return success
    Success = 1;
    
else
    
    % print out header
    fprintf(1, "TestUpstreamSplit tests failed:\n");
    
    % print which tests failed
    fprintf(1, "    Test %d\n", itest);
    
    % return failure
    Success = 0;
    
end

% ----------------------------------------------------------

end

% ----------------------------------------------------------
% ----------------------------------------------------------
% ----------------------------------------------------------

function [Pass] = CheckTest(TestValue, TrueValue, Tol)
%
% [Pass] = CheckTest(TestValue, TrueValue, Tol)
% written by Paul Mokotoff, prmoko@umich.edu
% last updated: 22 may 2024
%
% Helper function to check if a test passed.
%
% INPUTS:
%     TestValue - array of the returned values from the function.
%                 size/type/units: m-by-n / double / []
%
%     TrueValue - array of the expected values output from the function.
%                 size/type/units: m-by-n / double / []
%
%     Tol       - acceptable relative tolerance between the test and true
%                 values.
%                 size/type/units: 1-by-1 / double / []
%
% OUTPUTS:
%     Pass      - flag to show whether the test passed (1) or not (0)
%

% compute the relative tolerance
RelTol = abs(TestValue - TrueValue) ./ TrueValue;

% check the tolerance
if (any(RelTol > Tol))
    
    % the test fails
    Pass = 0;
    
else
    
    % the test passes
    Pass = 1;
    
end

% ----------------------------------------------------------

end
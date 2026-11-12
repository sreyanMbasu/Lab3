function w_hat_theta = ECE569_MatrixLog3(R)
% This function implements the matrix log function
% for a 3x3 rotation matrix R using
% Algorithm: (MR eqn. 3.58)
%
% Input: R = expm(w_hat*theta); 3x3 rotation matrix
% Returns: w_hat*theta = logm(R) is the exponential coordinate
% represented as a skew-symmetric 3x3 matrix.
% If tr(R) = 1, then the axis is not defined
% so we just return all zeros.

% There are main cases to consider, following the algorithm
I3x3 = eye(3);
if ismembertol(trace(R), 3)
    % case (a) check if tr(R) == 3 (within numerical tolerance)
    % the exponential coordinate is undefined here, return all zeros
    w_hat_theta = zeros(3);

elseif ismembertol(trace(R), -1)
    % case (b) check if tr(R) == -1 (within numerical tolerance)
    theta = pi;

    % three subcases to avoid dividing by zero
    if ~ismembertol(R(3,3),-1)
        % case (b.1) check r33 is not -1
         dw = (R(:,3) + I3x3(:,3)) / sqrt(2*(1 + R(3,3)));

    elseif ~ismembertol(R(2,2),-1)
        % case (b.2) check r22 is not -1
         dw = (R(:,2) + I3x3(:,2)) / sqrt(2*(1 + R(2,2)));

    else
        % case (b.3) check r11 is not -1
        dw = (R(:,1) + I3x3(:,1)) / sqrt(2*(1 + R(1,1)));
    end
    
    % You must return a skew-symmetric matrix
    w_hat = [0, -dw(3), dw(2);dw(3), 0, -dw(1); -dw(2), dw(1), 0];
    w_hat_theta = w_hat * theta;

else
    % case (c) this condition runs in all other cases
    theta = acos(0.5 * (trace(R) - 1));
    dw = (1/(2*sin(theta))) * [R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];
    w_hat = [0, -dw(3), dw(2);dw(3), 0, -dw(1); -dw(2), dw(1), 0];
    w_hat_theta = w_hat*theta;
end
end
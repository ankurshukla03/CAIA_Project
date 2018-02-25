% normalize pixel values between 0 and 1.
function n = normalize(A) 
    A = double(A);
    n = A - min(A(:));
    n = n ./ max(n(:));
end
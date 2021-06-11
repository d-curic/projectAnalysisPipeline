


function dGamma = getDgamma(tau, alpha, dtau, dalpha)

dgdt = 1./(alpha - 1);
dgda = (tau - 1)./(alpha - 1).^2;

dGamma = sqrt(dgdt.^2.*dtau.^2 + dgda.^2.*dalpha.^2);
end

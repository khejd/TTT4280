load('muab.mat');


red_wavelength = 600; %%INSERT_RED_WAVELENGTH (unit nm)
green_wavelength = 520; %%INSERT_GREEN_WAVELENGTH (unit nm)
blue_wavelength = 460; %%INSERT_BLUE_WAVELENGTH (unit nm)

wavelengths = [red_wavelength, green_wavelength, blue_wavelength];


mua_blood_oxy = @(x) interp1(muabo(:,1), muabo(:,2), x);
mua_blood_deoxy = @(x) interp1(muabd(:,1), muabd(:,2), x);


bvf = 0.01; %blood volume fraction, average amount of blood in the tissue
oxy = 0.8; %oxygenation of the blood

%absorption coefficient (mu_a in lab text)
%units: m^(-1)
mua_other = 25; %background absorption due to collagen etc
mua_blood = mua_blood_oxy(wavelengths)*oxy + mua_blood_deoxy(wavelengths)*(1-oxy); %absorption due to pure blood
mua = mua_blood*bvf + mua_other;

%reduced scattering coefficient (mu_s' in lab text)
%the magic numbers are from N. Bashkatov, E. A. Genina, V. V. Tuchin.
%Optical properties of skin, subcutaneous and muscle tissues: A review. J.
%Inoov.  Opt. Health Sci., 4(1):9-38, 2011
%units: m^(-1)
musr = (17.6*(wavelengths/500.0).^(-4) + 18.78*(wavelengths/500).^(-0.22))*100;

%mua and musr are now available as three-valued arrays, each index corresponding to: red, green and blue channels.


%%INSERT CODE FOR CALCULATING PENETRATION DEPTH DEL

%Oppg 1a
delta = sqrt(1./(3.*(musr + mua).*mua));

%Oppg 1b
C = sqrt(3.*(musr + mua).*mua);
d = 0.014;
T = exp(-C*d)*100;

%Oppg 1c
% En pulsbredde dypt

%Oppg 1d
d_vein = 300e-6;
bvf_vein = 1;
mua_vein = mua_blood*bvf_vein + mua_other;
delta_vein = sqrt(1./(3.*(musr + mua_vein).*mua_vein));
phi0_vein = 1./(2.*delta_vein.*mua_vein);
C_vein = sqrt(3.*(musr + mua_vein).*mua_vein);
phiZ_vein = phi0_vein .* exp(-C_vein.*d_vein);

phi0_tissue = 1./(2.*delta.*mua);
phiZ_tissue = phi0_tissue .* exp(-C.*d_vein);

T_vein = exp(-C_vein.*d_vein);
T_tissue = exp(-C.*d_vein);

K = abs(T_vein - T_tissue)./T_tissue;

%1e
%Rødt er best









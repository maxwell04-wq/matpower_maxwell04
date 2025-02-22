classdef mme_shunt_cpf < mp.mme_shunt_pf_ac
% mp.mme_shunt_cpf - Math model element for shunt for CPF.
%
% Math model element class for shunt elements for AC CPF problems.
%
% Implements method for updating the output data in the corresponding data
% model element for in-service shunts from the math model solution.

%   MATPOWER
%   Copyright (c) 2022-2024, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MATPOWER.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See https://matpower.org for more info.

%     properties
%     end     %% properties

    methods
        function obj = data_model_update_on(obj, mm, nm, dm, mpopt)
            %

            %% call parent to compute injections
            data_model_update_on@mp.mme_shunt_pf_ac(obj, mm, nm, dm, mpopt);

            %% update load input values
            ad = mm.aux_data;
            dme = obj.data_model_element(dm);
            dm = dme.parameterized(dm, ad.dmb, ad.dmt, mm.soln.x(end));
        end
    end     %% methods
end         %% classdef

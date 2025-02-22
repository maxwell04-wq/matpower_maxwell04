function generate_matpower_autodoc(matpower_dir)
% generate_matpower_autodoc - Generate the stubs and symlinks for Ref Manual.
% ::
%
%   generate_matpower_autodoc(matpower_dir)
%
% Inputs:
%   matpower_dir (char array) : path to the MATPOWER install directory
%
% Creates the .rst stubs and symlinks to the source files for all functions
% and classes to be included in the |MATPOWER-Ref-Manual|. Creates all of the
% inputs (lists of functions and classes) to pass to generate_autodoc_stubs
% and generate_source_symlinks.

%   MATPOWER
%   Copyright (c) 2023-2024, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MATPOWER.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See https://matpower.org for more info.

if nargin < 1
    matpower_dir = '~/dev/projects/matpower/';
end

sphinx_src_dir = [matpower_dir 'docs/sphinx/source/'];

lib_classes = { ...
    'mp_table', ...
    'mp_table_subclass', ...
};
lib_mp_classes = { ...
    'task', ...
    'task_pf', ...
    'task_cpf', ...
    'task_opf', ...
    'task_pf_legacy', ...
    'task_cpf_legacy', ...
    'task_opf_legacy', ...
    'task_shared_legacy', ...
    'dm_converter', ...
    'dm_converter_mpc2', ...
    'dm_converter_mpc2_legacy', ...
    'dmc_element', ...
    'dmce_branch_mpc2', ...
    'dmce_bus_mpc2', ...
    'dmce_gen_mpc2', ...
    'dmce_load_mpc2', ...
    'dmce_shunt_mpc2', ...
    'data_model', ...
    'data_model_cpf', ...
    'data_model_opf', ...
    'dm_element', ...
    'dme_branch', ...
    'dme_branch_opf', ...
    'dme_bus', ...
    'dme_bus_opf', ...
    'dme_gen', ...
    'dme_gen_opf', ...
    'dme_load', ...
    'dme_load_cpf', ...
    'dme_load_opf', ...
    'dme_shunt_cpf', ...
    'dme_shunt', ...
    'dme_shunt_opf', ...
    'dme_shared_opf', ...
    'form', ...
    'form_ac', ...
    'form_acc', ...
    'form_acp', ...
    'form_dc', ...
    'net_model', ...
    'net_model_ac', ...
    'net_model_acc', ...
    'net_model_acp', ...
    'net_model_dc', ...
    'nm_element', ...'
    'nme_branch_ac', ...
    'nme_branch_acc', ...
    'nme_branch_acp', ...
    'nme_branch_dc', ...
    'nme_branch', ...
    'nme_bus_acc', ...
    'nme_bus_acp', ...
    'nme_bus_dc', ...
    'nme_bus', ...
    'nme_gen_ac', ...
    'nme_gen_acc', ...
    'nme_gen_acp', ...
    'nme_gen_dc', ...
    'nme_gen', ...
    'nme_load_ac', ...
    'nme_load_acc', ...
    'nme_load_acp', ...
    'nme_load_dc', ...
    'nme_load', ...
    'nme_shunt_ac', ...
    'nme_shunt_acc', ...
    'nme_shunt_acp', ...
    'nme_shunt_dc', ...
    'nme_shunt', ...
    'math_model', ...
    'math_model_pf', ...
    'math_model_pf_ac', ...
    'math_model_pf_acci', ...
    'math_model_pf_accs', ...
    'math_model_pf_acpi', ...
    'math_model_pf_acps', ...
    'math_model_pf_dc', ...
    'math_model_cpf_acc', ...
    'math_model_cpf_acci', ...
    'math_model_cpf_accs', ...
    'math_model_cpf_acp', ...
    'math_model_cpf_acpi', ...
    'math_model_cpf_acps', ...
    'math_model_opf', ...
    'math_model_opf_ac', ...
    'math_model_opf_acc', ...
    'math_model_opf_acci', ...
    'math_model_opf_acci_legacy', ...
    'math_model_opf_accs', ...
    'math_model_opf_accs_legacy', ...
    'math_model_opf_acp', ...
    'math_model_opf_acpi', ...
    'math_model_opf_acpi_legacy', ...
    'math_model_opf_acps', ...
    'math_model_opf_acps_legacy', ...
    'math_model_opf_dc', ...
    'math_model_opf_dc_legacy', ...
    'mm_shared_pfcpf', ...
    'mm_shared_pfcpf_dc', ...
    'mm_shared_pfcpf_ac', ...
    'mm_shared_pfcpf_ac_i', ...
    'mm_shared_pfcpf_acc', ...
    'mm_shared_pfcpf_acci', ...
    'mm_shared_pfcpf_accs', ...
    'mm_shared_pfcpf_acp', ...
    'mm_shared_pfcpf_acpi', ...
    'mm_shared_pfcpf_acps', ...
    'mm_shared_opf_legacy', ...
    'mm_element', ...
    'mme_branch_opf_ac', ...
    'mme_branch_opf_acc', ...
    'mme_branch_opf_acp', ...
    'mme_branch_opf_dc', ...
    'mme_branch_opf', ...
    'mme_branch_pf_ac', ...
    'mme_branch_pf_dc', ...
    'mme_branch', ...
    'mme_bus_opf_ac', ...
    'mme_bus_opf_acc', ...
    'mme_bus_opf_acp', ...
    'mme_bus_opf_dc', ...
    'mme_bus_pf_ac', ...
    'mme_bus_pf_dc', ...
    'mme_bus', ...
    'mme_gen_opf_ac', ...
    'mme_gen_opf_dc', ...
    'mme_gen_opf', ...
    'mme_gen_pf_ac', ...
    'mme_gen_pf_dc', ...
    'mme_gen', ...
    'mme_load_cpf', ...
    'mme_load_pf_ac', ...
    'mme_load_pf_dc', ...
    'mme_load', ...
    'mme_shunt_cpf', ...
    'mme_shunt_pf_ac', ...
    'mme_shunt_pf_dc', ...
    'mme_shunt', ...
    'extension', ...
    'xt_reserves', ...
    'dmce_reserve_gen_mpc2', ...
    'dmce_reserve_zone_mpc2', ...
    'dme_reserve_gen', ...
    'dme_reserve_zone', ...
    'mme_reserve_gen', ...
    'mme_reserve_zone', ...
    'xt_3p', ...
    'dmce_bus3p_mpc2', ...
    'dmce_gen3p_mpc2', ...
    'dmce_load3p_mpc2', ...
    'dmce_line3p_mpc2', ...
    'dmce_xfmr3p_mpc2', ...
    'dmce_buslink_mpc2', ...
    'dme_bus3p', ...
    'dme_gen3p', ...
    'dme_load3p', ...
    'dme_line3p', ...
    'dme_xfmr3p', ...
    'dme_buslink', ...
    'dme_bus3p_opf', ...
    'dme_gen3p_opf', ...
    'dme_load3p_opf', ...
    'dme_line3p_opf', ...
    'dme_xfmr3p_opf', ...
    'dme_buslink_opf', ...
    'nme_bus3p', ...
    'nme_bus3p_acc', ...
    'nme_bus3p_acp', ...
    'nme_gen3p', ...
    'nme_gen3p_acc', ...
    'nme_gen3p_acp', ...
    'nme_load3p', ...
    'nme_line3p', ...
    'nme_xfmr3p', ...
    'nme_buslink', ...
    'nme_buslink_acc', ...
    'nme_buslink_acp', ...
    'mme_bus3p', ...
    'mme_gen3p', ...
    'mme_line3p', ...
    'mme_xfmr3p', ...
    'mme_buslink', ...
    'mme_buslink_pf_ac', ...
    'mme_buslink_pf_acc', ...
    'mme_buslink_pf_acp', ...
    'mme_bus3p_opf_acc', ...
    'mme_bus3p_opf_acp', ...
    'mme_gen3p_opf', ...
    'mme_line3p_opf', ...
    'mme_xfmr3p_opf', ...
    'mme_buslink_opf', ...
    'mme_buslink_opf_acc', ...
    'mme_buslink_opf_acp', ...
    'NODE_TYPE', ...
    'cost_table', ...
    'cost_table_utils', ...
    'element_container', ...
    'mapped_array', ...
};
lib_t_mp_classes = { ...
    'xt_legacy_dcline', ...
    'dmce_legacy_dcline_mpc2', ...
    'dme_legacy_dcline', ...
    'dme_legacy_dcline_opf', ...
    'nme_legacy_dcline', ...
    'nme_legacy_dcline_ac', ...
    'nme_legacy_dcline_acc', ...
    'nme_legacy_dcline_acp', ...
    'nme_legacy_dcline_dc', ...
    'mme_legacy_dcline', ...
    'mme_legacy_dcline_pf_ac', ...
    'mme_legacy_dcline_pf_dc', ...
    'mme_legacy_dcline_opf', ...
    'mme_legacy_dcline_opf_ac', ...
    'mme_legacy_dcline_opf_dc' ...
};
lib_fcns = {
    'mp_table_class', ...
    'run_mp', ...
    'run_pf', ...
    'run_cpf', ...
    'run_opf', ...
};
lib_mp_fcns = {};
lib_t_fcns = {
    'generate_matpower_autodoc', ...
    'generate_autodoc_stubs', ...
    'generate_source_symlinks', ...
};

in = struct(...
    'class', struct(...
        'destdir', 'classes', ...
        'list', struct(...
            'mod', {'matpower', 'matpower.+mp', 'matpower.+mp'}, ...
            'src_path', {'lib', 'lib', 'lib/t'}, ...
            'names', {lib_classes, lib_mp_classes, lib_t_mp_classes} ...
        ) ...
    ), ...
    'function', struct(...
        'destdir', 'functions', ...
        'list', struct(...
            'mod', {'matpower', 'matpower.+mp'}, ...
            'src_path', {'lib', 'lib'}, ...
            'names', {lib_fcns, lib_mp_fcns} ...
        ) ...
    ) ...
);

%% create stubs and symlinks for reference manual
generate_autodoc_stubs(in, [sphinx_src_dir 'ref-manual/']);
generate_source_symlinks(in, [sphinx_src_dir 'matlab-source/'], '../../../../../');

%% create stubs and symlinks for How to Build Documentation
ind = struct(...
    'function', struct(...
        'destdir', 'builddocs', ...
        'list', struct(...
            'mod', {'matpower'}, ...
            'src_path', {'lib/t'}, ...
            'names', {lib_t_fcns} ...
        ) ...
    ) ...
);
generate_autodoc_stubs(ind, [sphinx_src_dir 'howto/']);
generate_source_symlinks(ind, [sphinx_src_dir 'matlab-source/'], '../../../../../');

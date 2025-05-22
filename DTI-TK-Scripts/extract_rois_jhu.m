clear all
roi_list = {'FNIRT_ROIs_to_mean_FA.nii'};
region_string_list = {{'Unclass' 'Mid_Cer_Ped' 'Pontine' 'CC_Genu' 'CC_Body' 'CC_Splen' 'Fornix' 'CST_r' 'CST_l' 'Med_Lemn_l' 'Med_Lemn_l' 'Inf_Cer_Ped_r' 'Inf_Cer_Ped_l' 'Sup_Cer_Ped_r' 'Sup_Cer_Ped_l' 'Cer_Ped_r' 'Cer_Ped_l' 'ALIC_r' 'ALIC_l' 'PLIC_r' 'PLIC_l' 'RPIC_r' 'RPIC_l' 'Ant_Cor_Rad_r' 'Ant_Cor_Rad_l' 'Sup_Cor_Rad_r' 'Sup_Cor_Rad_l' 'Post_Cor_Rad_r' 'Post_Cor_Rad_l' 'Post_Thal_Rad_r' 'Post_Thal_Rad_l' 'Sag_Strat_r' 'Sag_Strat_l' 'Ext_Cap_r' 'Ext_Cap_l' 'Cing_Gyrus_r' 'Cing_Gyrus_l' 'Cing_Hipp_r' 'Cing_Hipp_l' 'Fornix_Cres_r' 'Fornix_Cres_l' 'Sup_Long_Fasc_r' 'Sup_Long_Fasc_l' 'Sup_FO_Fasc_r' 'Sup_FO_Fasc_l' 'Inf_FO_Fasc_r' 'Inf_FO_Fasc_l' 'Unc_Fasc_r' 'Unc_Fasc_l' 'Tapetum_r' 'Tapetum_l'}}; 
region_code_list = {{0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50}};

img_folder ='/Volumes/vdrive/helpern_users/helpern_j/IAM/IAM_Analysis/dki_dti-tk_longitudinal/03_Analysis/04_ROI_Warps'
%img_folder ='/Users/kayti/Desktop/Projects/MIND/QA_DTITK/QA_DTITK_PyDesigner-FSL/03_Analysis/04_ROI_Warps'

for i = 1:length(roi_list)
    
    for j = 1:length(region_code_list{i})
        
                  
            % read roi image
            
            fn = fullfile(img_folder, [roi_list{i}]);
            
            hdr = spm_vol(fn);        
            img = spm_read_vols(hdr);   
            
            % binarize img
            
            if isscalar(region_code_list{i}{j})     % if region code is a scalar
                img = img == region_code_list{i}{j};
            else                                    % if region code is a vector
                tmp = img == region_code_list{i}{j}(1);
                for ii = 2:length(region_code_list{i}{j})
                    tmp = tmp | (img == region_code_list{i}{j}(ii));
                end
                img = tmp;
            end               
            
                     
        % write output
        hdr.fname = fullfile(img_folder, [region_string_list{i}{j} '.nii']);
        spm_write_vol(hdr, img);
    end
end 
            
       
        
        


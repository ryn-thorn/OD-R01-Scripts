#############################################
#
#	Generate Stats w fslmeants - UPDATED METHOD 
#	Ryn Thorn
#	4/30/20 - Updated 1/12/21
#      
#############################################

export input=/Volumes/vdrive/helpern_users/helpern_j/IAM/IAM_Analysis/dki_dti-tk_longitudinal/03_Analysis
export a4ds=$input/03_TBSS_redo/stats
export output=$input/05_Means
export roipath=$input/04_ROI_Warps
export skelroipath=$roipath/ROIs_skele

mkdir $skelroipath
mkdir $output
mkdir $output/Skele
mkdir $output/Non-Skele

######### ROI skele masking - for skeletonized means
fslmaths $a4ds/all_dti_fa_skeletonised.nii -Tmean -bin $a4ds/dki_skeleton_mask.nii
fslmaths $a4ds/all_wmti_awf_skeletonised.nii -Tmean -bin $a4ds/wmm_skeleton_mask.nii
gunzip $a4ds/*mask.nii.gz

for rois in Unclass Mid_Cer_Ped Pontine CC_Genu CC_Body CC_Splen Fornix CST_r CST_l Med_Lemn_l Med_Lemn_l Inf_Cer_Ped_r Inf_Cer_Ped_l Sup_Cer_Ped_r Sup_Cer_Ped_l Cer_Ped_r Cer_Ped_l ALIC_r ALIC_l PLIC_r PLIC_l RPIC_r RPIC_l Ant_Cor_Rad_r Ant_Cor_Rad_l Sup_Cor_Rad_r Sup_Cor_Rad_l Post_Cor_Rad_r Post_Cor_Rad_l Post_Thal_Rad_r Post_Thal_Rad_l Sag_Strat_r Sag_Strat_l Ext_Cap_r Ext_Cap_l Cing_Gyrus_r Cing_Gyrus_l Cing_Hipp_r Cing_Hipp_l Fornix_Cres_r Fornix_Cres_l Sup_Long_Fasc_r Sup_Long_Fasc_l Sup_FO_Fasc_r Sup_FO_Fasc_l Inf_FO_Fasc_r Inf_FO_Fasc_l Unc_Fasc_r Unc_Fasc_l Tapetum_r Tapetum_l ; do
  fslmaths $roipath/${rois}.nii -mul $a4ds/dki_skeleton_mask.nii $skelroipath/${rois}.nii 
  fslmaths $roipath/${rois}.nii -mul $a4ds/wmm_skeleton_mask.nii $skelroipath/${rois}_wmm.nii
done

rm $a4ds/dki_skeleton_mask.nii
rm $a4ds/wmm_skeleton_mask.nii

gunzip $skelroipath/*


### non-skele
for metrics in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
  for rois in Unclass Mid_Cer_Ped Pontine CC_Genu CC_Body CC_Splen Fornix CST_r CST_l Med_Lemn_l Med_Lemn_l Inf_Cer_Ped_r Inf_Cer_Ped_l Sup_Cer_Ped_r Sup_Cer_Ped_l Cer_Ped_r Cer_Ped_l ALIC_r ALIC_l PLIC_r PLIC_l RPIC_r RPIC_l Ant_Cor_Rad_r Ant_Cor_Rad_l Sup_Cor_Rad_r Sup_Cor_Rad_l Post_Cor_Rad_r Post_Cor_Rad_l Post_Thal_Rad_r Post_Thal_Rad_l Sag_Strat_r Sag_Strat_l Ext_Cap_r Ext_Cap_l Cing_Gyrus_r Cing_Gyrus_l Cing_Hipp_r Cing_Hipp_l Fornix_Cres_r Fornix_Cres_l Sup_Long_Fasc_r Sup_Long_Fasc_l Sup_FO_Fasc_r Sup_FO_Fasc_l Inf_FO_Fasc_r Inf_FO_Fasc_l Unc_Fasc_r Unc_Fasc_l Tapetum_r Tapetum_l ; do
    fslmeants -i $a4ds/all_${metrics}.nii.gz -o $output/Non-Skele/${metrics}_${rois}.txt -m $roipath/${rois}.nii.gz
  done
done


### skele - DKI
for metrics in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk ; do
  for rois in Unclass Mid_Cer_Ped Pontine CC_Genu CC_Body CC_Splen Fornix CST_r CST_l Med_Lemn_l Med_Lemn_l Inf_Cer_Ped_r Inf_Cer_Ped_l Sup_Cer_Ped_r Sup_Cer_Ped_l Cer_Ped_r Cer_Ped_l ALIC_r ALIC_l PLIC_r PLIC_l RPIC_r RPIC_l Ant_Cor_Rad_r Ant_Cor_Rad_l Sup_Cor_Rad_r Sup_Cor_Rad_l Post_Cor_Rad_r Post_Cor_Rad_l Post_Thal_Rad_r Post_Thal_Rad_l Sag_Strat_r Sag_Strat_l Ext_Cap_r Ext_Cap_l Cing_Gyrus_r Cing_Gyrus_l Cing_Hipp_r Cing_Hipp_l Fornix_Cres_r Fornix_Cres_l Sup_Long_Fasc_r Sup_Long_Fasc_l Sup_FO_Fasc_r Sup_FO_Fasc_l Inf_FO_Fasc_r Inf_FO_Fasc_l Unc_Fasc_r Unc_Fasc_l Tapetum_r Tapetum_l ; do
    fslmeants -i $a4ds/all_${metrics}_skeletonised.nii.gz -o $output/Skele/${metrics}_${rois}_skele.txt -m $skelroipath/${rois}.nii.gz
  done
done


### skele - WMM
for metrics in wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
  for rois in Unclass Mid_Cer_Ped Pontine CC_Genu CC_Body CC_Splen Fornix CST_r CST_l Med_Lemn_l Med_Lemn_l Inf_Cer_Ped_r Inf_Cer_Ped_l Sup_Cer_Ped_r Sup_Cer_Ped_l Cer_Ped_r Cer_Ped_l ALIC_r ALIC_l PLIC_r PLIC_l RPIC_r RPIC_l Ant_Cor_Rad_r Ant_Cor_Rad_l Sup_Cor_Rad_r Sup_Cor_Rad_l Post_Cor_Rad_r Post_Cor_Rad_l Post_Thal_Rad_r Post_Thal_Rad_l Sag_Strat_r Sag_Strat_l Ext_Cap_r Ext_Cap_l Cing_Gyrus_r Cing_Gyrus_l Cing_Hipp_r Cing_Hipp_l Fornix_Cres_r Fornix_Cres_l Sup_Long_Fasc_r Sup_Long_Fasc_l Sup_FO_Fasc_r Sup_FO_Fasc_l Inf_FO_Fasc_r Inf_FO_Fasc_l Unc_Fasc_r Unc_Fasc_l Tapetum_r Tapetum_l ; do
    fslmeants -i $a4ds/all_${metrics}_skeletonised.nii.gz -o $output/Skele/${metrics}_${rois}_skele.txt -m $skelroipath/${rois}_wmm.nii.gz
  done
done


\


####### Combining
export final=/Volumes/vdrive/helpern_users/helpern_j/IAM/IAM_Analysis/dki_dti-tk_longitudinal/03_Analysis/05_Means
export ID_files=/Volumes/vdrive/helpern_users/helpern_j/IAM/IAM_Analysis/dki_dti-tk_longitudinal/01_Protocol/IDs.txt

mkdir $final/Combined

# Comb - non-skele
export base=$final/Non-Skele

echo "SubjIDs ALIC_l ALIC_r Ant_Cor_Rad_l Ant_Cor_Rad_r CC_Body CC_Genu CC_Splen CST_l CST_r Cer_Ped_l Cer_Ped_r Cing_Gyrus_l Cing_Gyrus_r Cing_Hipp_l Cing_Hipp_r Ext_Cap_l Ext_Cap_r Fornix Fornix_Cres_l Fornix_Cres_r Inf_Cer_Ped_l Inf_Cer_Ped_r Inf_FO_Fasc_l Inf_FO_Fasc_r Med_Lemn_l Mid_Cer_Ped PLIC_l PLIC_r Pontine Post_Cor_Rad_l Post_Cor_Rad_r Post_Thal_Rad_l Post_Thal_Rad_r RPIC_l RPIC_r Sag_Strat_l Sag_Strat_r Sup_Cer_Ped_l Sup_Cer_Ped_r Sup_Cor_Rad_l Sup_Cor_Rad_r Sup_FO_Fasc_l Sup_FO_Fasc_r Sup_Long_Fasc_l Sup_Long_Fasc_r Tapetum_l Tapetum_r Unc_Fasc_l Unc_Fasc_r Unclass ALIC_l_skele ALIC_r_skele Ant_Cor_Rad_l_skele Ant_Cor_Rad_r_skele CC_Body_skele CC_Genu_skele CC_Splen_skele CST_l_skele CST_r_skele Cer_Ped_l_skele Cer_Ped_r_skele Cing_Gyrus_l_skele Cing_Gyrus_r_skele Cing_Hipp_l_skele Cing_Hipp_r_skele Ext_Cap_l_skele Ext_Cap_r_skele Fornix_skele Fornix_Cres_l_skele Fornix_Cres_r_skele Inf_Cer_Ped_l_skele Inf_Cer_Ped_r_skele Inf_FO_Fasc_l_skele Inf_FO_Fasc_r_skele Med_Lemn_l_skele Mid_Cer_Ped_skele PLIC_l_skele PLIC_r_skele Pontine_skele Post_Cor_Rad_l_skele Post_Cor_Rad_r_skele Post_Thal_Rad_l_skele Post_Thal_Rad_r_skele RPIC_l_skele RPIC_r_skele Sag_Strat_l_skele Sag_Strat_r_skele Sup_Cer_Ped_l_skele Sup_Cer_Ped_r_skele Sup_Cor_Rad_l_skele Sup_Cor_Rad_r_skele Sup_FO_Fasc_l_skele Sup_FO_Fasc_r_skele Sup_Long_Fasc_l_skele Sup_Long_Fasc_r_skele Tapetum_l_skele Tapetum_r_skele Unc_Fasc_l_skele Unc_Fasc_r_skele Unclass_skele" > $base/_ROI_Labels.txt

for metrics in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
  paste $base/${metrics}* > $base/All_${metrics}.txt
  cat $base/_ROI_Labels.txt $base/All_${metrics}.txt > $final/Combined/All_${metrics}.txt
done
    
# Comb - skele
export base=$final/Skele

echo "SubjIDs ALIC_l ALIC_r Ant_Cor_Rad_l Ant_Cor_Rad_r CC_Body CC_Genu CC_Splen CST_l CST_r Cer_Ped_l Cer_Ped_r Cing_Gyrus_l Cing_Gyrus_r Cing_Hipp_l Cing_Hipp_r Ext_Cap_l Ext_Cap_r Fornix Fornix_Cres_l Fornix_Cres_r Inf_Cer_Ped_l Inf_Cer_Ped_r Inf_FO_Fasc_l Inf_FO_Fasc_r Med_Lemn_l Mid_Cer_Ped PLIC_l PLIC_r Pontine Post_Cor_Rad_l Post_Cor_Rad_r Post_Thal_Rad_l Post_Thal_Rad_r RPIC_l RPIC_r Sag_Strat_l Sag_Strat_r Sup_Cer_Ped_l Sup_Cer_Ped_r Sup_Cor_Rad_l Sup_Cor_Rad_r Sup_FO_Fasc_l Sup_FO_Fasc_r Sup_Long_Fasc_l Sup_Long_Fasc_r Tapetum_l Tapetum_r Unc_Fasc_l Unc_Fasc_r Unclass ALIC_l_skele ALIC_r_skele Ant_Cor_Rad_l_skele Ant_Cor_Rad_r_skele CC_Body_skele CC_Genu_skele CC_Splen_skele CST_l_skele CST_r_skele Cer_Ped_l_skele Cer_Ped_r_skele Cing_Gyrus_l_skele Cing_Gyrus_r_skele Cing_Hipp_l_skele Cing_Hipp_r_skele Ext_Cap_l_skele Ext_Cap_r_skele Fornix_skele Fornix_Cres_l_skele Fornix_Cres_r_skele Inf_Cer_Ped_l_skele Inf_Cer_Ped_r_skele Inf_FO_Fasc_l_skele Inf_FO_Fasc_r_skele Med_Lemn_l_skele Mid_Cer_Ped_skele PLIC_l_skele PLIC_r_skele Pontine_skele Post_Cor_Rad_l_skele Post_Cor_Rad_r_skele Post_Thal_Rad_l_skele Post_Thal_Rad_r_skele RPIC_l_skele RPIC_r_skele Sag_Strat_l_skele Sag_Strat_r_skele Sup_Cer_Ped_l_skele Sup_Cer_Ped_r_skele Sup_Cor_Rad_l_skele Sup_Cor_Rad_r_skele Sup_FO_Fasc_l_skele Sup_FO_Fasc_r_skele Sup_Long_Fasc_l_skele Sup_Long_Fasc_r_skele Tapetum_l_skele Tapetum_r_skele Unc_Fasc_l_skele Unc_Fasc_r_skele Unclass_skele" > $base/_ROI_Labels.txt

for metrics in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
  paste $base/${metrics}* > $base/All_${metrics}.txt
  cat $base/_ROI_Labels.txt $base/All_${metrics}.txt > $final/Combined/All_${metrics}_skele.txt
done

# Comb - all
export base=$final/Combined

for metrics in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
  paste $base/All_${metrics}* > $base/${metrics}.txt
done

for metrics in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
  rm $base/All_${metrics}*
done

# Add ID labels
xargs -n1 < $ID_files > $final/Combined/_IDs.txt

for metrics in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
  paste $final/Combined/_IDs.txt $final/Combined/${metrics}.txt > $final/Combined/All_${metrics}.txt
  rm $final/Combined/${metrics}.txt
done

rm $final/Combined/_IDs.txt
###################################
#    							  
#   Metric Prep for DTI_TK-TBSS   
#	Ryn Thorn
#    							  
###################################

export base=/Volumes/vdrive/helpern_users/helpern_j/IAM/IAM_Analysis/dki_dti-tk_within_subject/03_Analysis/03_Metric_Transform
export ana=/Volumes/vdrive/helpern_users/helpern_j/IAM/IAM_Analysis/dki_dti-tk_longitudinal/03_Analysis
export scalar=$ana/01_Scalar_Prep
export dtitk=$ana/02_Tensors
export ID_file=/Volumes/vdrive/helpern_users/helpern_j/IAM/IAM_Analysis/dki_dti-tk_longitudinal/01_Protocol/IDs.txt
SUBJ_IDs=$(cat $ID_file)

mkdir $scalar

# File org
for i in $SUBJ_IDs ; do 
  mkdir -p $scalar/${i}
  for m in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
    cp $base/${i}/${m}_ws.nii.gz $scalar/${i}/${m}.nii.gz
  done
done

# Combine transforms
for i in $SUBJ_IDs ; do 
  dfRightComposeAffine -aff $dtitk/${i}_ws.aff -df $dtitk/${i}_ws_aff_diffeo.df.nii.gz -out $dtitk/${i}_combined.df.nii.gz
done

# Set metric origin to 0 0 0 
# for i in $SUBJ_IDs ; do 
#   for m in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
#     TVAdjustVoxelspace -in $scalar/${i}/${m}.nii -origin 0 0 0 -out $scalar/${i}/${m}_000.nii
#   done
# done

# Transform 000 metrics to population space
for i in $SUBJ_IDs ; do 
  for m in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da  ; do
    #gunzip $scalar/${i}/${m}_000.nii.gz
    deformationScalarVolume -in $scalar/${i}/${m}.nii.gz -trans $dtitk/${i}_combined.df.nii.gz -target $dtitk/mean_initial.nii.gz -out $scalar/${i}/${m}_dtitk.nii.gz -vsize 1 1 1
  done
done

cd $dtitk

mkdir $ana/03_TBSS_redo
mkdir $ana/03_TBSS_redo/WMM
mkdir $ana/03_TBSS_redo/DKI
mkdir $ana/03_TBSS_redo/stats

# File organization
for m in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk ; do
  mkdir $ana/03_TBSS_redo/DKI/${m}
  for i in $SUBJ_IDs ; do
    gunzip $scalar/${i}/${m}_dtitk.nii.gz
    cp $scalar/${i}/${m}_dtitk.nii $ana/03_TBSS_redo/DKI/${m}/${i}_${m}.nii
  done
done

for m in wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da  ; do
  mkdir $ana/03_TBSS_redo/WMM/${m}
  for i in $SUBJ_IDs ; do 
    gunzip $scalar/${i}/${m}_dtitk.nii.gz
    cp $scalar/${i}/${m}_dtitk.nii $ana/03_TBSS_redo/WMM/${m}/${i}_${m}.nii
  done
done

fslmerge -t $ana/03_TBSS_redo/stats/all_FA.nii $ana/03_TBSS_redo/DKI/dti_fa/*dti_fa.nii 
fslmaths $ana/03_TBSS_redo/stats/all_FA.nii -Tmean $ana/03_TBSS_redo/stats/mean_FA.nii 
fslmaths $ana/03_TBSS_redo/stats/mean_FA.nii -bin $ana/03_TBSS_redo/stats/mean_FA_mask.nii
tbss_skeleton -i $ana/03_TBSS_redo/stats/mean_FA.nii -o $ana/03_TBSS_redo/stats/mean_FA_skeleton.nii

cp -R $ana/03_TBSS_redo/stats $ana/03_TBSS_redo/WMM/stats

cd $ana/03_TBSS_redo/WMM/stats
tbss_4_prestats 0.4

gunzip *nii.gz

cp -R $ana/03_TBSS_redo/stats $ana/03_TBSS_redo/DKI/stats

cd $ana/03_TBSS_redo/DKI/stats
tbss_4_prestats 0.2

gunzip *nii.gz

# Generate all_[metric]
for m in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk ; do
  cd $ana/03_TBSS_redo/DKI/${m}
  fslmerge -t all_${m} *${m}.nii
  cp all_${m}.nii.gz $ana/03_TBSS_redo/DKI/stats/all_${m}.nii.gz
done

#for m in wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
for m in wmti_eas_tort wmti_ias_da ; do
  cd $ana/03_TBSS_redo/WMM/${m}
  fslmerge -t all_${m} *${m}.nii
  cp all_${m}.nii.gz $ana/03_TBSS_redo/WMM/stats/all_${m}.nii.gz
done

# Generate the white matter skeleton from the high-resolution FA map of the DTI template 
cd $ana/03_TBSS_redo/DKI/stats
thresh=0.2
#for m in dti_ad dki_ak dti_fa dti_md dki_mk dti_rd dki_rk ; do
for m in dti_fa dti_md dki_mk dki_rk dki_ak dti_rd dti_ad ; do
  tbss_skeleton -i mean_FA -p $thresh mean_FA_skeleton_mask_dst ${FSLDIR}/data/standard/LowerCingulum_1mm all_FA all_${m}_skeletonised -a all_${m}
done

cd $ana/03_TBSS_redo/WMM/stats
thresh=0.4
#for m in wmti_awf wmti_eas_ad wmti_eas_rd wmti_eas_tort wmti_ias_da ; do
for m in wmti_eas_tort wmti_ias_da ; do
  tbss_skeleton -i mean_FA -p $thresh mean_FA_skeleton_mask_dst ${FSLDIR}/data/standard/LowerCingulum_1mm all_FA all_${m}_skeletonised -a all_${m}
done

mv $ana/03_TBSS_redo/WMM/stats/all_wmti* $ana/03_TBSS_redo/stats
mv $ana/03_TBSS_redo/DKI/stats/all_d* $ana/03_TBSS_redo/stats
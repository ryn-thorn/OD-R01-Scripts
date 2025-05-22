#############################################
#
#  Schlosser FS 
#  Ryn Thorn - 11/23/20; updated: 3/5/25
#      
#############################################


export base=/Volumes/vdrive/helpern_users/benitez_a/OD_R01

ls $base/02_Data/dcm > $base/01_Protocols/ids.txt
echo $(cat $base/01_Protocols/ids.txt) > $base/01_Protocols/ids.txt

export ID_file=$base/01_Protocols/ids.txt
SUBJ_IDs=$(cat $ID_file)

for i in $SUBJ_IDs ; do 
  mkdir -p $base/03_Analysis/Freesurfer/${i} 
  dcm2niix -o $base/03_Analysis/Freesurfer/${i} -f %f $base/02_Data/dcm/${i}/t1_mp2rage_sag_p3_iso_UNI_Images
  dcm2niix -o $base/03_Analysis/Freesurfer/${i} -f %f $base/02_Data/dcm/${i}/t1_mp2rage_sag_p3_iso_INV2
done

for i in $SUBJ_IDs ; do 
  cp /Users/kayti/Desktop/Projects/Schlosser/02_Data/${i}/structural/${t1}.nii.gz $base/${i}/T1.nii.gz
  bet $base/${i}/T1.nii.gz $base/${i}/T1_bet.nii.gz -g -1 -f 0.1
  cp $base/${i}/T1_bet.nii.gz $base/${i}/T1_bet.nii.gz
  recon-all -all -i $base/${i}/T1_bet.nii.gz -sd $base/${i} -subjid ${i}
done






export base=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/Freesurfer
for i in 20-022 ; do 
  recon-all -all -i $base/${i}/clean_t1_mp2rage_sag_p3_iso_UNI_Images.nii -sd $base/${i} -subjid ${i}
done





































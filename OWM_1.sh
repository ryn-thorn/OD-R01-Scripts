###########################################
# Olfactory WM Tractography
# Kayti Keith 9/1/20
###########################################

export base=/Users/kayti/Desktop/Projects/Schlosser
export raw=$base/02_Data/00_Raw_Data
export preproc=$base/02_Data/01_Preproc
export analysis=$base/03_Analysis
export mni=$base/01_Protocols/MNI.nii.gz
export pydesigner=/Users/kayti/Repos/PyDesigner/designer/pydesigner.py

mkdir $raw
mkdir $preproc
mkdir $analysis
mkdir $analysis/01_T1_to_B0
mkdir $analysis/02_T1_to_MNI
mkdir $analysis/03_NS_to_B0
mkdir $analysis/04_ROIs

# pyd
# for i in 002 008 022 ; do
#   mkdir $preproc/Schlosser_02-${i}
#   time python $pydesigner -o $base/03_Analysis/00_PyD/Schlosser_20-${i} -n -g -u --mask -z -r $base/03_Analysis/00_PyD/Schlosser_20-${i}/FBI.nii $base/03_Analysis/00_PyD/Schlosser_20-${i}/FBI_TOPUP_PA.nii $base/03_Analysis/00_PyD/Schlosser_20-${i}/DKI.nii
# done

#file setup
for i in 002 008 022 ; do
  fslsplit $analysis/00_PyD/Schlosser_20-${i}/dwi_preprocessed.nii $analysis/00_PyD/Schlosser_20-${i}/dwi_preprocessed -t
  gunzip $analysis/00_PyD/Schlosser_20-${i}/*.gz
  mv $analysis/00_PyD/Schlosser_20-${i}/dwi_preprocessed0000.nii $analysis/01_T1_to_B0/Schlosser_20-${i}_B0.nii 
  rm $analysis/00_PyD/Schlosser_20-${i}/dwi_preprocessed0*.nii
  cp $analysis/00_T1s/Schlosser_20-${i}_T1.nii $analysis/01_T1_to_B0/Schlosser_20-${i}_T1.nii
done

gunzip $base/01_Protocols/*.gz
cp $base/01_Protocols/ROIs/olfactory_association-test_z_FDR_0.01.nii $analysis/03_NS_to_B0/NS_ROIs.nii
cp $base/01_Protocols/MNI.nii $analysis/02_T1_to_MNI/MNI.nii
ß
#warp T1 to B0
cd $analysis/01_T1_to_B0
for i in 002 008 022 ; do
  flirt -in $analysis/01_T1_to_B0/Schlosser_20-${i}_T1.nii -ref Schlosser_20-${i}_B0.nii -out Schlosser_20-${i}_T1_in_B0.nii -omat Schlosser_20-${i}_T1_in_B0.mat
done

#warp T1 to MNI
cd $analysis/02_T1_to_MNI
for i in 002 008 022 ; do
  flirt -in $analysis/01_T1_to_B0/Schlosser_20-${i}_T1.nii -ref $mni -out Schlosser_20-${i}_T1_in_MNI.nii -omat Schlosser_20-${i}_T1_in_MNI.mat
  convert_xfm -omat Schlosser_20-${i}_MNI_to_T1.mat -inverse Schlosser_20-${i}_T1_in_MNI.mat #invert warp
done

#normalize, threshold, and binzarize neurosynth to b0
cd $analysis/03_NS_to_B0
for i in 002 008 022 ; do
  flirt -in NS_ROIs.nii -ref $mni -out NS_ROIs_MNI.nii
  flirt -in NS_ROIs_MNI.nii.gz -ref $analysis/01_T1_to_B0/Schlosser_20-${i}_T1.nii -applyxfm -init $analysis/02_T1_to_MNI/Schlosser_20-${i}_MNI_to_T1.mat -out Schlosser_20-${i}_NS_ROIs_in_T1.nii
  flirt -in $analysis/02_T1_to_MNI/MNI.nii -ref $analysis/01_T1_to_B0/Schlosser_20-${i}_T1.nii -applyxfm -init $analysis/02_T1_to_MNI/Schlosser_20-${i}_MNI_to_T1.mat -out Schlosser_20-${i}_MNI_in_T1.nii
  flirt -in Schlosser_20-${i}_NS_ROIs_in_T1.nii -ref $analysis/01_T1_to_B0/Schlosser_20-${i}_B0.nii -applyxfm -init $analysis/01_T1_to_B0/Schlosser_20-${i}_T1_in_B0.mat -out Schlosser_20-${i}_NS_ROIs_in_B0.nii
  flirt -in Schlosser_20-${i}_MNI_in_T1.nii -ref $analysis/01_T1_to_B0/Schlosser_20-${i}_B0.nii -applyxfm -init $analysis/01_T1_to_B0/Schlosser_20-${i}_T1_in_B0.mat -out Schlosser_20-${i}_MNI_in_B0.nii
  fslmaths Schlosser_20-${i}_NS_ROIs_in_B0.nii -thr 4 Schlosser_20-${i}_NS_ROIs_in_B0_thr4.nii
  fslmaths Schlosser_20-${i}_NS_ROIs_in_B0_thr4.nii -bin Schlosser_20-${i}_NS_ROIs_in_B0_thr4_bin.nii
doneß

#break neurosynth into rois
for i in 002 008 022 ; do
  fslroi Schlosser_20-${i}_NS_ROIs_in_B0_thr3.nii $analysis/04_ROIs/Schlosser_20-${i}_NS_OFC_in_B0_unbin.nii 0 180 0 34 0 180 
  fslroi Schlosser_20-${i}_NS_ROIs_in_B0_thr3.nii $analysis/04_ROIs/Schlosser_20-${i}_NS_MT_in_B0_unbin.nii 0 180 0 55 0 180 
done

#############################################
#
#	Generate Stats w fslmeants 
#	Ryn Thorn
#	4/30/20
#      
#############################################

export roisorig=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/01_Protocols/ROIs
export ana=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/DTI-TK
export roiwarps=$ana/04_ROI_Warps

mkdir $roiwarps
cd $roiwarps 

cp $ana/03_TBSS/stats/mean_FA.nii mean_FA.nii
cp $roisorig/JHU-WhiteMatter-labels-1mm.nii JHU-WhiteMatter-labels-1mm.nii
cp $roisorig/JHU-ICBM-FA-1mm.nii JHU-ICBM-FA-1mm.nii

flirt -ref mean_FA.nii -in JHU-ICBM-FA-1mm.nii -out FLIRT_MNI_to_mean_FA.nii -omat my_affine_guess.mat

fnirt --ref=mean_FA.nii --in=JHU-ICBM-FA-1mm.nii --aff=my_affine_guess.mat --cout=FNIRT_MNI_to_mean_FA.mat --iout=FNIRT_MNI_to_mean_FA.nii 

applywarp --ref=mean_FA.nii --in=JHU-WhiteMatter-labels-1mm.nii --warp=FNIRT_MNI_to_mean_FA.mat.nii.gz --out=FNIRT_ROIs_to_mean_FA.nii

gunzip FNIRT_ROIs_to_mean_FA.nii.gz
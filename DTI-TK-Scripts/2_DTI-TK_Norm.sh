################################################
#    										     
# DTI-TK Spatial Normalization Prep for TBSS   
# Ryn Thorn
#    										     
################################################

export base=/Volumes/vdrive/helpern_users/benitez_a/OD_R01
export ID_file=$base/01_Protocols/ids_dtitk.txt
export tensors=$base/03_Analysis/DTI-TK/01_Tensor_Prep
export dtitk=$base/03_Analysis/DTI-TK/02_Tensors
SUBJ_IDs=$(cat $ID_file)

# File Org

mkdir $dtitk

for i in $SUBJ_IDs ; do
  cp $tensors/${i}/dti_dtitk.nii $dtitk/${i}_dti_dtitk.nii
done

gunzip $dtitk/*.nii.gz

# Registration
cd $dtitk

ls 20-* > subjs.txt

#######################################################################################
# Step 2: Bootstrapping
#######################################################################################

TVMean -in subjs.txt -out mean_initial.nii.gz
 
TVResample -in mean_initial.nii.gz -align center -size 128 128 64 -vsize 1.5 1.75 2.25

#######################################################################################
# Step 3: Affine alignment
#######################################################################################

dti_affine_population mean_initial.nii.gz subjs.txt EDS 3

#######################################################################################
# Step 4: Deformable alignment
#######################################################################################

TVtool -in mean_affine3.nii.gz -tr

BinaryThresholdImageFilter mean_affine3_tr.nii.gz mask.nii.gz 0.01 100 1 0

dti_diffeomorphic_population mean_affine3.nii.gz subjs_aff.txt mask.nii.gz 0.002
/
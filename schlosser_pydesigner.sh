#######################################################################################
# Schlosser Olfactory Data PyDesigner
#######################################################################################

export base=/Users/kayti/Desktop/Projects/Schlosser/02_Data

# dicom to nii conversion
for i in ${ids[@]} ; do 
  rm -r $base/00_Raw_Data/${i}/convert
  mkdir $base/00_Raw_Data/${i}/nii
  dcm2niix -f %p -o $base/00_Raw_Data/${i}/nii $base/00_Raw_Data/${i}/dicom
done

# file org 
for i in ${ids[@]} ; do 
  mkdir $base/01_Preproc/${i}
  cp $base/00_Raw_Data/${i}/nii/DKI* $base/01_Preproc/${i}
  for f in bval bvec json nii ; do
    mv $base/01_Preproc/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} $base/01_Preproc/${i}/DKI.${f}
  done
  for f in json nii ; do
    mv $base/01_Preproc/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} $base/01_Preproc/${i}/DKI_TOPUP.${f}
  done
done
  
# pydesigner
conda activate dmri
for i in ${ids[@]} ; do 
  time pydesigner -s --rpe_pairs 1 $base/01_Preproc/${i}/DKI.nii $base/01_Preproc/${i}/DKI_TOPUP.nii
done






# docker pydesigner
for i in 20-003 20-004 20-005 20-006 20-007 20-008 20-009 20-010 20-011 20-012 20-014 20-017 20-018 20-019 20-020 20-021 20-022 20-024 20-025 20-027 ; do
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done

for i in 20-028 20-028A 20-029 20-030 20-032 20-033 20-034 20-036 20-038 20-039 20-040 20-042 20-044 20-046 20-048 20-048A 20-049 20-055 20-056 20-057 20-059 20-060 ; do 
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done


for i in 20-061 20-062 20-063 20-065 20-066 20-067 20-068 20-073 20-074 20-076 20-077 20-079 20-080 20-081 20-082 20-083 20-085 20-086 20-087 20-088 20-091 20-092 20-093 ; do  
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done


for i in 20-097 20-100 20-101 20-103 20-104 20-105 20-106 20-107 20-108 20-109 20-111 20-112 20-113 20-114 20-115 20-116 20-117 20-118 20-119 20-122 20-123 20-125 20-126 20-127 20-129 20-130 ; do 
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done


for i in 20-131 20-132 20-137 20-138 20-139 20-141 20-143 20-144 20-145 20-146 20-149 20-150 20-152 20-153 20-154 20-155 20-156 20-157 20-158 20-159 20-160 20-161 20-163 20-164 20-165 20-166 20-167 20-168 ; do
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done



for i in 20-169 20-170 20-172 20-175 20-176 20-178 20-179 20-182 20-186 20-188 20-189 20-190 20-191 20-192 20-193 20-194 20-195 20-199 20-200 20-202 20-206 20-207 20-211 20-212 20-222 20-225 20-226 ; do
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done



for i in 20-227 20-231 20-232 20-241 20-242 20-243 20-247 20-252 20-253 20-255 20-256 20-260 20-265 20-266 20-267 20-269 20-270 20-275 20-280 20-283 20-284 20-285 20-286 20-288 20-289 20-295 20-299 20-300 20-304 ; do
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done

for i in 20-164 ; do
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done

for i in 20-053A ; do
  mkdir -p /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}; 
  for f in nii bvec bval json ; do  
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI.${f}
    cp /Volumes/vdrive/helpern_users/benitez_a/OD_R01/02_Data/nii/${i}/DKI_MONOPOLAR_3.0mm_64dir_42slices_TOPUP_PA.${f} /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner/${i}/DKI_TOPUP.${f}
  done
  docker run -it --rm -v /Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/PyDesigner:/data dmri/neurodock pydesigner --standard --output /data/${i} /data/${i}/DKI.nii /data/${i}/DKI_TOPUP.nii
done

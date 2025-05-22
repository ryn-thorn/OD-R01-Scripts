cd /Users/kayti/Desktop/Projects/Schlosser/

# no prefix
for i in 20-003 20-006 20-010 20-011 20-025 20-033 20-034 20-036 20-040 20-048 20-048A 20-049 20-050 20-050A 20-053 20-053A 20-054 20-056 20-057 20-060 20-062 20-065 20-066A 20-068 20-074 20-081 20-083 20-100 20-104 20-105 20-109 20-113 20-114 20-115 20-119 20-130 20-131 20-139 20-141 20-144 20-145 20-146 20-150 20-155 20-157 20-164 20-165 20-168 20-169 20-172 20-192 20-193 20-194 20-195 20-200 20-202 20-211 20-226 20-231 20-245 20-260 20-265 20-267 20-269 20-270 20-285 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_iso.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_iso.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# a
for i in 20-002 20-004 20-005 20-007 20-008 20-014 20-017 20-019 20-024 20-027 20-032 20-038 20-046 20-055 20-063 20-067B 20-079 20-093 20-103 20-108 20-116 20-117 20-123 20-127 20-132 20-138 20-143 20-149 20-152 20-153 20-154 20-156 20-158 20-160 20-161 20-163 20-176 20-178 20-252 20-283 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoa.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoa.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# b
for i in  20-009 20-012 20-018 20-021 20-022 20-028 20-028A 20-029 20-030 20-039 20-042 20-044 20-054A 20-059 20-061 20-073 20-082 20-085 20-086 20-088 20-091 20-106 20-107 20-111 20-112 20-118 20-137 20-159 20-166 20-167 20-179 20-182 20-186 20-188 20-189 20-190 20-191 20-199 20-206 20-207 20-222 20-227 20-232 20-247 20-256 20-266 20-275 20-280 ; do                 
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isob.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isob.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# c
for i in 20-020 20-097 20-225 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoc.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoc.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# d
for i in 20-073A 20-101 20-125 20-126 20-129 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isod.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isod.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# e
for i in 20-077 20-122 20-286 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoe.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoe.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# f
for i in 20-092 20-284 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isof.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isof.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# g
for i in 20-212 20-253 20-076 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isog.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isog.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# h
for i in 20-087 20-170 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoh.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoh.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# j 
for i in 20-080 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoj.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isoj.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

# l 
for i in 20-175 ; do
  mkdir -p LST/${i}
  gunzip 02_Data/${i}/structural/t1_mp2rage_sag_p3_isol.nii.gz
  cp 02_Data/${i}/structural/t1_mp2rage_sag_p3_isol.nii LST/${i}/T1.nii
  gunzip 02_Data/${i}/structural/FLAIR_3D.nii.gz
  cp 02_Data/${i}/structural/FLAIR_3D.nii LST/${i}/T2.nii
done

#####################################
#
# Norms for Freesurfer 6.0 outputs 
# Ryn Thorn - 11.21.23
#
#####################################

export nomis=/Users/kayti/Repos/NOMIS/NOMIS/NOMIS.py
export csv=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/01_Protocols/NOMIS_setup.csv
export subjdir=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/Freesurfer
export output=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/04_Summary/NOMIS

mkdir -p $output

conda activate nomis
python $nomis -csv $csv -s $subjdir -o $output
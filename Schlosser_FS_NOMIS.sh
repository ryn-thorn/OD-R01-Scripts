export analysis=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/03_Analysis/Freesurfer
export nomis=/Users/kayti/Repos/NOMIS/NOMIS/NOMIS.py
export csv=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/01_Protocols/Scripts/Schlosser_norms.csv
export output=/Volumes/vdrive/helpern_users/benitez_a/OD_R01/04_Summary/NOMIS

mkdir -p $output

conda activate nomis
python $nomis -csv $csv -s $analysis -o $output


base = '/Users/kayti/Desktop/Projects/Schlosser/LST'
subj = {'20-211' '20-212' '20-222' '20-225' '20-226' '20-227' '20-231' '20-232' '20-245' '20-247' '20-252' '20-253' '20-256' '20-260' '20-265' '20-266' '20-267' '20-269' '20-270' '20-275' '20-280' '20-283' '20-284' '20-285' '20-286'}

for i=1:length(subj)
    clear matlabbatch
    matlabbatch{1}.spm.tools.LST.lga.data_T1 = {[base '/' subj{i} '/T1.nii,1']};
    matlabbatch{1}.spm.tools.LST.lga.data_F2 = {[base '/' subj{i} '/T2.nii,1']};
    matlabbatch{1}.spm.tools.LST.lga.opts_lga.initial = 0.25;
    matlabbatch{1}.spm.tools.LST.lga.opts_lga.mrf = 1;
    matlabbatch{1}.spm.tools.LST.lga.opts_lga.maxiter = 50;
    matlabbatch{1}.spm.tools.LST.lga.html_report = 1;
    spm_jobman('run',matlabbatch);
end

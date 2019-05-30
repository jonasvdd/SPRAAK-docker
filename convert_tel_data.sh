#!/bin/bash

# variables: CHANGE THESE!
dbase=name_of_my_dbase
wav_src=path_to_the_root_of_your_dbase
wav_tel_dst=path_to_where_the_telephone_version_of_the_dbase_must_be_written

# find all wav files and make a corpus file; since we have no orthographic transcription, we use '#' (silence) as transcription
find "${wav_src}" -type f -name '*.wav' -printf '%P\n' | sort | gawk '{C[++ndx]=gensub("\\.wav$","\t#\t0 -1",1,$0);} END {printf(".spr\nDIM1\t%i\nDATA\tCORPUS\nTYPE\tSTRING\nFORMAT\tASCII\n#\n",ndx);for(ndx=0;++ndx in C;printf("%s\n",C[ndx]));}' > "${dbase}.cor"

# process the data (convert to telephone alike data); each file will be processed only once!
spr_sigp --mkdirs -i "${wav_src}" -c "${dbase}.cor" -Si wav -So wav -o "${wav_tel_dst}" -ssp tel_flt.ssp
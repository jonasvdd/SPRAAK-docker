 # .stm Files
 ## Line format 
Each property is separated with a space; for example: 

```
filename channel spk_label start_time_segment end_time_segment properties annotation
```

## Detailed description
| property | description |
|:-----|:-------|
**filename** | Filename of the audio file without path or file extension 
**channel** | Audio channel indication, always 1 (mono audio files)
**spk\_label** | Label indicating the speaker <ul><li> **Nonspeech segments** that need to be removed before analysis get one of the following labels: `inter_segment_gap`, `excluded_region`, `music`, `other`, `overlap_region`. <br> Make sure that the string comparisons are independent of capital letters, e.g. the label _Inter_segment_gap_ and _Inter_Segment_gap_ do occur. </li><li> Speech segments without available spk label can be indicated by the speaker label: `speech`,`unknown`,`-1`. <br> These should be removed as well. </li><li> **Speaker labels are valid within the same folder**, meaning that utterances of the same speaker (identical spk_label) can be grouped across audio files within the same folder. <br> This is **not true for purely numerical speaker labels** (e.g '1', '2', ...), as this indicates automatic speaker diarization has taken place and speakers cannot be linked across audio recordings. <br> Potentialy group speaker utterances across recordings only on the training data, the evaluation should be kept recording based. </li><ul>
**start\_time\_segment** | start time (offset of the beginning of the audio file) of the considered audio segment in **seconds**
**end\_time\_segment** | end time (offset of the beginning of the audio file) of the considered audio segment in seconds <ul><li> There **might be small errors in the time annotation** per segment leading to segments <br> of negative or zero duration. Simply remove these segments. </li></ul>
**properties** | The properties of a speech segment are (normally) indicated between "<" and ">". Relevant labels are: <ul><li> **gender**: `male`, `female`. Again make the string comparison independent of capital letters (e.g. gender label _MALE_). **Not every speech segment is guaranteed to have a gender label**. </li></ul> <ul><li> presence of label `F2` indicates **telephone speech**. Remove these segments during the analysis as we will filter the broadband speech to resemble telephone speech. Filtering the telephone speech again might give unexpected results. </li></ul>
**annotation** | For data in the evaluation folder, the annotation field contains the language label. E.g. `["english"]`, `["flemish"]`, `["german"]` and `["french"]`. Out of set languages are possible e.g. `["greek"]`, `["unknown"]`. <ul><li> The data in the **training folder** is usually not manually annotated for language. **Assume** that each **speech segment is uttered in the language of the considered folder**. Exceptions might be indicated in the annotation of each segment e.g. label ["other"]. The annotation ["unknown"] does NOT override the language label of the training folder. </li></ul>

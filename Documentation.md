# Stages of development

#### New parameters required for run.prm file

* flag_use_deltaH (set to 0)

* store_aggregate_yoy (set to 0)

* store_mig_array (set to 0)

#### FunctionalGroups.csv
Added column iBioEroder - set all groups to 0

#### Notes
EA_model_files only running for a few days (~45). IKR are exploding at the end, causing flow error. Temp, salinity and particle transport looks good. Error could be due to IKR recruitment parameters.

Sediment analysis folder is working but excludes IKR.


#### Differences between Sediment Analysis and EA model files - physics.prm
* vert_mix is off in EA and on in sediment model.
* scale_transport is on in EA and off in sediment model.
* ka_exchange is 1000 in sediment model and 100000000 in the EA.
* minicedz 1 in EA and 5 in sediment model.

Tried running the model with the physics parameters from the sediment analysis model but it actually made the IKR increase more.

#### Resolving IKR Recruitment
Reduced the primary production recruitment parameters (PP_IKR and PP_KR) for IKR and KR to 1. The previous number of 3.65e+08 was copied from PwN value in the SeTAS model.

After this the model ran for about a week longer and then there was an Unstable Si error due to the diatoms consuming the entire Silicon pool.

#### Resolving Si flux error due to too many PPL
Reduced the ref_chl from 1.08 to 0.15 (as it was in sediment analysis folder). This made no difference to results.

Increased linear mortality of PPL (PPL_mL) from 0.0001 to 0.14 but made no difference.

Reduced maximum growth rate of PPL (mum_PPL_T15) from 0.62 to 0.001. This solved the problem and model ran for full year.



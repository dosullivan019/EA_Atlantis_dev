# Stages of development

#### New parameters required for run.prm file

* flag_use_deltaH (set to 0)

* store_aggregate_yoy (set to 0)

* store_mig_array (set to 0)

#### FunctionalGroups.csv
Added column iBioEroder - set all groups to 0

#### Notes
EA_model_files only running for a few days (~45) using the EA files. IKR are exploding at the end, causing flow error. Temp, salinity and particle transport looks good. Error could be due to IKR recruitment parameters.

Sediment analysis folder is working but excludes IKR.


#### Differences between Sediment Analysis and EA model files - physics.prm
* vert_mix is off in EA and on in sediment model.
* scale_transport is on in EA and off in sediment model.
* ka_exchange is 1000 in sediment model and 100000000 in the EA.
* minicedz 1 in EA and 5 in sediment model.

Tried running the model with the physics parameters from the sediment analysis model but it actually made the IKR increase more.




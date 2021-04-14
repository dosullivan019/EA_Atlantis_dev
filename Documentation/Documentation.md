# Stages of development

#### New parameters required for run.prm file

* flag_use_deltaH (set to 0)

* store_aggregate_yoy (set to 0)

* store_mig_array (set to 0)

#### FunctionalGroups.csv
Added column iBioEroder - set all groups to 0

### Notes
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

Light availability in box 9 layer 9 falls to 0 after a while and lacks seasonality in the first 8 years. Set eddy_vertmix = 1 which did not change anything, will keep the eddy_vertmix at 1 as it was in the sediment analysis model.

#### 16 Jan 2021 - NO3 flux
Model is running for 2427 days, crashing due to unstable NO3 flux (box 13, layer 9).
Picoplankton (PPS) dying off a lot.
Copepods (ZM) and Dinoflagellates (PDF) growing a lot. 

The PPS grow a lot just before the Copepods start going out of control, so maybe need to stop them from growing so much.

**Solution:** reduced mum_PPS_T15 from 0.3 to 0.2 and model ran for 3175 days. Crashing with same error, unstable NO3 flux but this time in box 12, layer 9 and looks to be due to PDF growth. Reducing mum_PDF_T15 from 0.5 to 0.4, model ran for 20 years.



#### TODO: 
Check the mL of fish, as they are a bit different to SeTAS although the fish look to be the most realistic output of the model. The krill mL (KR_mL) pretty different to PWN_mL in SeTAS but KR_ML is probably following more of a fish trend rather than the PWN.

ZM_mL in SeTAS was very different so I reduced it in EA model.

Parameter  | EA   | SeTAS     | Description                                           | Recommended Range
------|--------------|---------- |-------------------------------------------------|------------------
ZG_mL | 0.000001 (LG_ZOO but salps)  |0.000001  | Linear mortality rate of gelatin zoopl, 15 deg C  d-1 (0.0008)  |  0.0 - 0.04
ZL_mL |  |0.0002    | Linear mortality rate of large zoopl, 15 deg C    d-1 (0.001)   |   0.0 - 0.04
ZM_mL | 0.000002 (MED_Zoo) |0.0001    |  Linear mortality rate of meso-zoopl, 15 deg C     d-1 (0.001)  |    0.0 - 0.09
IZ_mL | 0.000001 |  | Linear mortality rate of ice zoopl, 15 deg C       d-1        |      0.0 - 0.04

Seabirds are feeding predominantly on Pelagic Bacteria? And have no predators.

#### 8 Feb 2021 growth of large mammals are too large
Top Predators and large mammals are growing exponentially with no stabilisation, this is with the model running for 30 years. Increasing the quadratic mortality of these species to mirror the numbers in SeTas model but they continue to grow quite quickly.

The quadratic mortality can be set to moderate levels for larger mammals and species which are not preyed on to account for competition between these species which is otherwise not included in the model.

Large mammals - SF looking much better after decreasing KDENR but the older generations continue to grow in the staggered way - maybe try increasing mQ. Age Class 2-6 look ok and recruitment to age class 1 still looks a bit high.
Halved KDENR for PNF, PNK and SK as these numbers seemed to be per female but this number reflects offspring per individual. Decreasing these numbers lowered the rate at which they grew but still not within 50% of the initial values. 

Top predators are only feeding on whales so increased the values on penguins, they weren't feeding on the seals so increased these to be non-zero.

Need to review KDENR for the whales. 


#### 13 Feb 2021 Pprey
Seal and penguin diets were not being reflected correctly in the output. Seals were feeding too much on zooplankton which was causing them to grow too fast. Set ppreySeal_Zoo to 0 as this is what it is in SeTas. Might need to review this once the zooplankton are growing steadily. Also changed the Penguin pPrey and increased pPrey TP for penguin and seals.


Phytoplankton are still growing too quick, the one burst at the beginning of the run keeps causing issues higher in the food web. Increasing KI_XXX parameters which are the recommended and found on https://github.com/AustralianAntarcticDivision/EA-Atlantis-dev/blob/master/SO28_biol.prm

Code |Value | New Value | Reference  | Comments
----|----|----|------------|-----------------
KI_PPL_T15 | 10 | 20  | |
KI_PPS_T15  | 10 | 19  | | 
KI_PDF_T15  | 11 | 14  |  | 
KI_IDF_T15 | 0.036  | 0.036  |  | 
KI_IPL_T15 | 0.035  | 0.035  |  | 

Changing the above parameters made no difference to primary producer growth and have changed back.

Code |Value | New Value | Reference  | Comments
----|----|----|------------|-----------------
KN_PPL_T15 | 10 |  | | 
KN_PPS_T15  | 0.67 |   | | 
KN_PDF_T15  | 0.45 | 30 | SeTAS  | 
KN_IDF_T15 | 0.8  |   |  | 
KN_IPL_T15 | 0.9  |   |  |
KS_PPL_T15 | 10 |   | |
KS_PPS_T15  | 10 |   | | 
KS_PDF_T15  | 11 |   |  0 in SeTAS | 
KS_IDF_T15 | 0.036  |   |  | 
KS_IPL_T15 | 0.035  |   |  | 

#### 1 April 2021 Phytoplankton growth
Growth of phytoplankton was causing shading, confirmed by Javier. Javier suggested increasing lysis rates so that the initial exponential growth of primary producers would be reduced. Have now kranked the KLYS_XXX parameters very high for PPL, PDF and PPS,  they are currently 0.1. The light levels appear ok now. The model is running for 15 years but the primary producer growth dies off after around 3 years. Will continue to reduce KLYS rates steadily until the model will run and output realistic primary producer growth.

Have also reviewed the initial Fe values and they should be ok now. Had to increase initial values of layer 2 in box 2-13 as there was an flux imbalance on day 1 otherwise. The phytoplankton are also nutrient limitied in box 24.

Still problems in the pprey matrix, when the phytoplankton are no longer growing the copepods take over the food web. Whales, penguins, fish and salps begin feeding predominantly on the copepods which allows them to continue to grow. The copepods keep growing as they are feeding on themselves and detritus.

##### Solving feedback loop with a species and detritus
Using ZM as an example.
First check the assimilation efficiency of ZM on detritus, if it is high trying setting it to it's lower bound. This looks ok for EA model.

How to control the zooplankton biomass:

Kill the ZM - either by decreasing their mum or clearance rate.

Control their predators by focusing on increasing the biomass of their predators.

#### 14 April 2021 Trouble shooting calibration issues - from Beth's lectures
If SN and RN are increasing/steady but numbers are decreasing: too few recruits.

You will need to play with the KDENR or the BH alpha.

If recruits are not growing quick enough.
KWRR and KWSR - set these to the XXX_Struct_N and XXX_Res_N of the youngest age class in the initial conditions file.


#### TODO
Check ice-dwelling microfauna are working as expected - suggested by Beth as she couldn't see them in Olive.
Do PPL, PDF need iron concentrations?
Check outputBoxlight.txt. Looks like Box 2, 3 and 4 have high light at the beginning and then drops off - which is probably why the growth is weird?
Increase mL for fished species until harvest model is brought in.
Fix transport warnings - one is box 24 layer 0 and the initial Fe in this box layer needs to be increased as the phytoplankton are limited from the very beginning.
Det_Si goes negative in box 10 layer 9 and box 7 layers 6-9 at some point so need to look into this.

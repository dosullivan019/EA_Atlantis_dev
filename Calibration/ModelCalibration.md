# Model Calibration

Before beginning model calibration it is important to first understand how the initial conditions and core parameter values were determined (Heidi's paper). This includes initial biomass, environmental preferences and spatial distribution and habitats.

Essential outputs to focus on during model calibration are:

+ biomass trends at ecosystem level
+ box specific biomass
+ trophic structure at the ecosystem and box level

Currently focusing on phase 1 of model calibration (unfished system) and the goal is for biomass values to remain within $\pm 20-50$% of their initial biomass.

Tuning the pPrey matrix is very important in calibration. The availability of biomass pools should be low for species who prefer to eat fish so that the species doesn't fill up on invertebrates. It is also important to keep consumption of detritus to a minimum for everything but true detritus specialists. Otherwise a feedback loop could occur between a group consuming the detritus and also producing detritus through waste as a result.

mL and mQ should be kept to a minimum (ideally around 0 unless there is compelling evidence to set it otherwise) to ensure predation is the dominant cause of mortality. mQ can be set higher in top predators which have low predation rates as adults, this can compensate for lack of representation of behaviour in the model which can cause mortality (eg competition for recruitment space) 

# Step through details
Mammals are growing too fast. I focused on elephant seals as they are also in the SeTAS model, they are a predominantly fish eating species and Merel has a good paper on their life history attributes. 
Initially I saw that their diet was being dominated by zooplankton and only a small proportion of their diet was being made of by fish. I decreased the pprey values for zm, zg and iz but it made little difference to their eating habits.
Their reproduction parameter (KDENR_SF) was 1, which is much higher than reported 0.5 in the paper. I decreased it to 0.5 which did decrease their growth rate by half but they could still be growing too much.

As the Zooplankton are making up too much of the Seals diet I also tried decreasing mum_ZM but their feeding habits remained the same.

## Introducing Micronutrient
Model is crashing with Micronutrient included.
Ran for 1828 days with mum_PPS_T15 0.3, mum_PPL_T15 0.5 and mum_PDF_t15 0.5

Ran for 3528 with the following values, crashed with Micronut flux error in box 5 layer 6. All primary producers grow v fast at the very end.
mum_PPL_T15	0.3
mum_PPS_T15	0.2
mum_IDF_T15	0.5
mum_PDF_T15	0.4
mum_IPL_T15	0.25

ZM are feeding too much on itself and it's creating a feedback loop with detritus consumption. Decreasing their prey on itself from 0.0001 to 0.0001. Should probably also have more things feeding on it after removing them from the large mammals diet.
Ran for 992 days with increase in IPL looking like the reason for the crash.


### Decreasing KI_XXX Feb 15 2021
Decreased back to what they were to make sure it runs ok. Ran for 3534.5 days before crashing. Box 5 layer 6 Micronut flux error. IPL, PPL and PDF all growing very quickly at then end.

Decreased mum_IPL, mum_PPL and mum_PDF. Model running for 3718.5 now and IPL and IDF are growing too quickly.

Removed all Iron for functional groups and model ran in the same way, crashing at 3718.5.

Increased KI_PPL, KI_PPS, KI_PDF, KI_IPL, KI_IDF model ran for 3634.5 days.

Increased IDF_mL and IPL_mL. All other PP_mL were already at recommended 0.14.

### April 2nd
ZM are in a feedback loop with themselves and detritus, this is causing the primary producers to not grow in a realistic way.

Decreased mum_ZM from 0.2 to 0.075 and ran model for 15 years. No crash but haven't tried longer than 15 years. In this scenario the PDF growth declines sharply at the very beginning. The copepods growth pattern looks better but it is still in a feedback loop with itself and detritus.

With mum_ZM = 0.05 model crashed after

With ZM_mum = 0.07 model crashes after 2974 days.

PDF aren't apparent in any functional groups diet so next step was to get their growth correct and see if this would improve the diet of their predators or improve the copepods feedback loop.

Decreased KLYS_PDF from 0.1 to 0.075 = model crashed after 2976 days but the PDF growth looks much better and has a seasonal pattern. The feedback loop of the copepods remains.

Next step is to fix the copepods diet so looked into the pprey matrix. Krill and Ice Krill's predation and PPL and ZM was too low. I think this was lowered earlier in the calibration and never changed back. Increased availability of ZM and PPL to KR and IKR from 0.01 to 0.05.

Model crashed after 1088 days but the copepods diet looks much better and the feedback loop has not yet started.

ZM_mum was still at 0.07 so next step is to increase it back to 0.075 which is when the model ran the longest.
ZM_mum = 0.075 and KR and IKR prey increased on ZM: Model crashes after 1113 days.

Checked KLYS_PDF=0.1 and pprey KR on PPL=0.05. 1137.5 days
Decrease KLYS_PDF back to 0.075 so it will have some growth pattern. 1137.5 days.

Increased KR prey on PPL and PPS to 0.05. output_EA_KR_prey_on_PPL_and_PPS_0.05. 1134 days.

Decreasing mum_ZM from 0.075 to 0.05 as they are still growing way too much. 1043 days so does not do well with mum=0.05.

PPS are growing too much of the primary producers, always way too far over their relative biomass and the causing of crashing. The PDF stay nicely in the relative biomass throughout and PPL just go outside the relative biomass at growth stay.

Decreased mum_PPS from 0.95 to 0.8. output_EA_ZM_mum_0.075_PPS_mum_0.8. 1468 days so ran for longer but now the PPS have lost their nice seasonality and die off quicker. The PDF have lost their nice trend and the reason the model crash.

Increased PPS from 0.8 to 0.9. 1134 days. PPS reason for crash.

mum_PPS = 0.85. 1459 days. PDF reason for crash and nice trend of primary producers lost again.

mum_PPS = 0.875. 1443 days. PDF still dominating. PPS and PPL are not growing after year 3.

Quick growth of ZM follows a spike in growth of PPS for the coastal boxes. Going to half the availability of PPS to ZM, decreasing from 0.05 to 0.025. 1082 days. I think the ZM are now just feeding on PDF so will change this back.

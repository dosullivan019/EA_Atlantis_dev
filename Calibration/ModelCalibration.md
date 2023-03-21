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

Dropping KLYS_PPL and KLYS_PPS to 0.075.

### April 14 2021
Fish (FM) numbers are going down. mum_FM is very low so doubled these numbers and this is looking much better. The availability of ZM to FM is high but FM are not a significant predator on ZM (although ZM make up most of their diet).

KWSR_FM and KWRR_FM were much lower than the values in the initial conditions file. Increased the KWSR_FM and KWWR_FM to match the values in the initial conditions and FM growth looks very good now. 
Adjusting the KWSR_FT and KWWR_FT made no difference to their total biomass numbers.
FM AgeClass 1 and 2 look ok. AgeClass 4 Numbers increasing a lot but nitrogen remain stable. AgeClass3 numbers up and down - think they're ok for the length of time the model runs.

FT Numbers are increasing but SN and RN are decreasing. FT Cohort 1 are decreasing in numbers but structural N remains steady. Likely the cohorts are in too much competition with each other. Need to kill off some of the fish.

Increased predation on FT and increased mStarve_FT by 10 fold and increased BHalpha_FT. None of these affected the FT biomass numbers. Will increase mStarve by much more to see if that makes a difference and if not will work on debugging the issue.

Increasing mStarve is making no difference. Could try increasing E_FT or FT_mL.

If you do not have fishing pressure in the model yet then you could increase mL or mQ to represent a simple harvest model while calibrating - this could be an idea to decrease the krill but need to krill atm to keep preying on copepods. 

Set mL to F/365 where F is annual fishing pressure. This relationship is more complicated than this and involves a log but will just use this for now until the harvest model is introduced.

### April 16 2021
IPL are not growing and dying out pretty quick. 

Decreased mum_FT and C_FT by half which made no difference. Looking at their predators they are following the same trend.

PNF and SF have the same problem of numbers increasing and RN and SN are decreasing. The first cohort of both looks pretty good. 

Decreasing mum_PNF and mum_SF by 10-fold.  No change.

The only predator of PNF and SF is TP so could probably increase mQ. Increasing mQ did decrease their biomass but the numbers to nitrogen ratio remains the same. The younger age classes are looking better.

Increasing mL FT made a big difference. Numbers to RN&SN ratio looks very good now. Numbers are just decreasing very steadily and not by much. Now need to adjust so that they will grow.

Played with pprey, think the matrix still needs some adjustment.

### April 22 2021
Working on the stabilising the Krill growth rate. I aligned the KWSR and KWRR with the ResN and StructN in the input file and the biomass of the krill blew up even more. 

Decreasing the primary producer mum made a big difference to the krill growth and krill look much better. Primary producers now have a really nice growth pattern.

### April 27 2021
The initial biomass of the ice species appears to be too high, when it was lowered the output looked better. Going to change the initial biomass of the species back to original for now and work on using the parameters to control their growth. Need to calibrate to mum and KN_XXX and KI_XXX.

Primary Producer growth now looks very good, model will run for at least 10 years with these parameters:

Code |Value | Comments
----|----|-----------------
mum_PPL_T15 | 0.6 |
mum_PPS_T15	| 0.525 |
mum_IDF_T15	| 0.2	| 
mum_PDF_T15	| 0.4	| Any higher than 0.415 and model crashes before 10 year mark, prob needs to be lowered more
mum_IPL_T15	| 1.44 |
KI_PPL_T15 | 20 | 
KI_PPS_T15  | 19 |
KI_PDF_T15  | 11 |
KI_IDF_T15 | 5 | May need to be lowered
KI_IPL_T15 | 5 | May need to be lowered
KN_PPL_T15 | 10 | 
KN_PPS_T15  | 4 | 
KN_PDF_T15  | 30 |
KN_IDF_T15 | 0.8 | 
KN_IPL_T15 | 4 | May need to be lowered
KS_PPL_T15 | 20 | 
KS_PPS_T15  | 0 |
KS_PDF_T15  | 0 | 
KS_IDF_T15 | 0 |
KS_IPL_T15 | 4 |
KLYS_PPL | 0.1 |
KLYS_PPS | 0.1 |
KLYS_PDF | 0.075 |
KLYS_IDF | 0.02 |
KLYS_IPL | 0.01 |
PPL_mL | 0.14 |
PPS_mL | 0.14 |
PDF_mL | 0.14 |
IDF_mL | 0.04 |
IPL_mL | 0.01 |

Increased ZM and ZG mum and they are also now looking good - may still need some calibration though.

### April 28 2021
Code |Value | Comments
----|----|-----------------
mum_PPL_T15 | 0.605 | Increased as PPS were limiting their growth after increasing their mum
mum_PPS_T15	| 0.53 | Increased to avoid PPS dying out 
mum_IDF_T15	| 0.2	| 
mum_PDF_T15	| 0.4	| Any higher than 0.415 and model crashes before 10 year mark, prob needs to be lowered more
mum_IPL_T15	| 1.44 |

The model now runs for about 30 years but PPL grow too much at the end and the model crashes. Need to adjust their mum again.

### Next Steps
Try running for 50 years with mum_PPS=0.525 and mum_PPL=0.6

If current run is better than changing the mum_PPS and mum_PPL then try slightly lower mum for PPL.

Calibrate ZG as they are growing uncontrollably. Try reducing mum and C.

Ice diatoms growth.

### April 30 2021
Code |Value | Comments
----|----|-----------------
mum_PPL_T15 | 0.6 | Growth possibly too high
mum_PPS_T15	| 0.525 | Growth maybe a bit too low
mum_IDF_T15	| 0.2	| 
mum_PDF_T15	| 0.4	| Growing too much at the end
mum_IPL_T15	| 1.44 |

Model now runs for 50 years.

### May 1 2021
Lowered the initial biomass of ice species. The ice diatoms had a biomass of over 100 where as the pelagic diatoms have a biomass of about 0.01 in a box-layer. The ice diatoms biomass seems way too large compared to the pelagic diatoms. Jess said it is ok to lower as we have little data on ice diatoms in the area of the model and they should be somewhat similiar to the pelagic diatoms.

The growth of the ice diatoms looks much better after lowering their initial biomass and can clearly see the seasonility of their growth now. IDF still die out at the very beginning, will try increasing their mum.

### June 12 2021
Large mammals increasing continuously trend. 

1. PNK. Increased PNK_mQ from 1e-20 to 1e-5. They just dropped off and were pretty low after 20 years so stopped the run. 1e-10 is too high, growing up out of the relative biomass range after about 10 years. 1e-7 looks good - still growing too much though but following the trend of the krill. 
KR and IKR last age class is causing them to not have steady state variables.

### 13 June 2021
Ran model for 100 years. Crashed just after 70 years as the ZG exploded. They started feeding on themselves as PPL and PPS died out. PDF are growing too much so either need to decrease PDF mum or increase PPS and PPL mum

### July 2021
Increased PPS, PPL and PDF mum slightly so they would not die out

Best values now are:

mum_PPL_T15 | 0.6005 |
mum_PPS_T15	| 0.527 |
mum_IDF_T15	| 0.835	| 
mum_PDF_T15	| 0.3975	|
mum_IPL_T15	| 1.44 |

### 11 July 2021
Increased mQ of adult whales. First increased from 1e-008 to 1e-08 but made no difference, then increased to 1e-8 but was still too high, increased to 1e-5 which made a significant difference. Although the biomass doesn't remain within the relative threshold it decreased the growth significantly compared to an mQ of 1e-8 and the growth levels out after a burn in period. The model runs for 100 years after making these changes.

### October 1 2021
Seabirds (SB) are eating far too much Pelagic Bacteria (PB), it makes up a lot of their diet. PB isn't even available to SB in the pprey matrix but it must be because they feed on detritus.

All the bacteria have a low linear mortality value, increasing PB_mL and BB_mL to 0.1 and IB_mL to 0.01 as suggested.


### November 6 2022
Krill are growing too much - increasing KR_mL aned IKR_mL (adults) from 5.00E-014 to 5.00E-010 and IKR_mL (juveniles) from 1.00E-008 to 1.00E-8, same as KR_mL - output_EA_20221106_increase_KR_mL

### Ice
KI_XXX, KN_XXX and KS_XXX are much lower for the ice species.

mum_IPL and mum_IDF is also quite low compared to other primary producers.


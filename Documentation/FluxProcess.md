# Biological Flux

The EA model is based only on N so the only state variable tracked for most functional groups is N. Both N and Si will be tracked for any groups which is Si limited, this is set in the *functionalgroups.csv* using the isSiliconDep parameter.

In age structured groups three variables are tracked for each age group:

  + reserved nitrogen (RN)
  + structural nitrogen (SN)
  + number (Nums)

In addition, fluxes in the water column and sediments are tracked through eight inanimate pools: ammonia (NH), nitrate (NO), dissolved silica (Si), detrital silica (DSi), dissolved oxygen (O2), dissolved organic nitrogen (DON), labile detritus (DL), and refractory detritus (DR).

Pelagic_Bacteria_Process() PL_BACT
Ice_Bacteria_Process() ICE_BACT
Sediment_Bacterica_Process() SED_BACT
Labile_Detritus_Process() LAB_DET
Refractory_Detritus_Process() REF_DET
Carrion_Process() CARRION

### Detritus
Detritus proportion parameters are FDG, FDGDL, FDGDR and determines how waste products are split between detritus and ammonia.

+ **FDG:** Proportion of unassimilated animal and plant food (faeces) by consumer XXX that becomes detritus
+ **FDGDL:** Proportion of unassimilated labile detrital food (faeces) by consumer XXX that becomes detritus
+ **FDGDR:** Proportion of unassimilated refractory detrital food (faeces) by consumer XXX that becomes detritus 


#### Labile Detritus
Production of labile detritus (DL) by consumer group XX is given by:

$W_{DL} = \biggl((1-E_L) * FDG * \sum_{i=type} Gr_{CX, i} + (1 − E_{DL}) * FDGDL * Gr_{CX,DL} + (1 − E_{DR}) * FDGDR * Gr_{CX,DR}+ FDM * M_{CX}\biggr) * FDL$

E<sub>L</sub> = assimilation efficiency on live prey (E_XXX) and plants (EPlant_XXX)

Gr<sub>CX,i</sub> = amount of different live prey types consumed

EDL = assimilation efficiency on labile detritus (EDL_XXX) 

EDR = assimilation efficiency on refractory detritus (EDR_XXX)

FDG = proportion of the unassimilated prey (animal, plant and catch grazing) that is sent to detritus (FDG_XXX)

FDGDR = proportion of unassimilated refractory detritus that is sent to detritus (FDGDR_XXX)

FDGDL = proportion of unassimilated labile detritus that is sent to detritus (FDGDL_XXX)

FDM = proportion of mortality products assigned to detritus (FDM_XXX)

FDL = determines the allocation of detritus between labile and refractory pools and is defined not by species but by four types of groups: fish and sharks (FDL_fish), birds and mammals (FDL_top), water column biomass pools except CEP and PWN (FDL_wc), other non-vertebrate biomass pools (FDL_benth – note that this includes CEP and PWN not just the true benthic invertebrate groups). 


#### Refractory Detritus
Production of refractory detritus (DR) uses the same equation, except that:

1. the final multiplication is done not by the FDL parameter but by (1-FDL)
1. detritus produced from all unassimilated food consumed by optional seabirds and fish NOT explicitly represented in the model is added to DR

$W_{DR} = \biggl((1-E_L) * FDG * \sum_{i=type} Gr_{CX, i} + (1 − E_{DL}) * FDGDL * Gr_{CX,DL} + (1 − E_{DR}) * FDGDR * Gr_{CX,DR} + FDM * M_{CX}\biggr) * (1 - FDL) + FFSB * M_{S}$



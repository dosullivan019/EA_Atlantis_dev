# Growth and Grazing Parameters

## Mum
Mum is the maximum consumption rate, sometimes referred to as maximum growth rate. The parameter was adopted by Murray and Parslow (1997), who replaced the standard Holling Type II maximum ingestion rate parameter with a "maximum growth rate" mum by scaling it by assimilation efficiency. Even though mum is called a maximum growth rate, it is included in the grazing (feeding) and not the growth equation, so it does not define the final growth. The consumed food will first be assimilated and the actual growth will then depend on other factors, such as respiration, reproduction and energy allocation to SN and RN.

As described in Murray and Parslow (1997), mum relates to the maximum ingestion rate (Gmax) as mum = Gmax*E, where E is the assimilation efficiency. The maximum ingestion rate as in turn the inverse of a more familiar "handling time" parameter (ht). Hence mum can also be seen as an inverse of the handing time as mum = E/ht.

The mum parameter for vertebrates was calculated based on daily consumption amount at weight (wet weight of species) from the literature. For invertebrate groups, the mum parameter was sourced directly from the literature.

Primary producers mum parameters at the moment are too low and is an aspect of the model being worked on. Initially when I took over the mum_PPL was causing the model to crash so I reduced it from 1.62 to 0.001 and have been steadily increasing this value to make it more realistic. Currently the primary producers are just spiking at the beginning of the model and then crashing to very small values. This has knock on effects on food for the zooplankton and krill etc. 

After introducing Micronutrient to track iron levels the biomass of PPL (maximum decreased from 1.5e+09 to 6e+08) and PPS decreased but continue to spike too high at the very beginning of the model run.

## Clearance
Clearance is set to 1/10 of the mum values.

## Assimilation
The total consumed food is assimilated according to the consumer assimilation efficiencies of four different types of prey:

  + animals (including fisheries catch)
  + plant
  + labile detritus
  + refractory detritus
  
Higher assimilation efficiencies lead to lower Gr value, as the predator need not intake as much food as it can extract more energy from what it does consume.

In consumer biomass pools all assimilated food is allocated to growth.

$G_{CP}=A_{CP}=\sum_i(E_i*Gr_{prey}) * gs$ 

where $gs$ is an external scalar supplied through forcing files and used to modify growth due to factors not included in the model.

## Recruitment
Large mammal recruitment is done by Fixed number of offspring per individual (flag_recruit_XXX=12). The number of offspring produced is defined by KDENR_XXX and is the average per individual so the ratio of male to females needs to be accounted for.

Parameter  | Code   | Condition     |Comment
------|----------|-----------|-------------------
Recruitment | flagrecruitXX  <br /> KDENR_XX | Underway | These parameters were marked as fixed when I took over but the large mammals are growing too fast so they are being revised.

Code |Value | New Value | Reference  | Comments
----|----|----|------------|-----------------
KDENR_SF | 1  | 0.5  |Goedegebuure et al(2018) |Paper has reproduction rate of Elephant Seals at 0.5 and output looks much more realistic than the previous value of 1
KDENR_SK  | 1  | 0.5  |Goedegebuure et al(2018) | Copying KDENR_SF for now as papers on Crabeater seals are mostly based on data from the 70s
KDENR_PK  | 2  | 1  |  | Adelie Penguin females typically lay 2 eggs which means on average 1 offspring assuming 50:50 M:F ratio
KDENR_PF | 1  | 0.5  |  | Emperor Penguin females typically lay 1 egg which means on average 0.5 offspring assuming 50:50 M:F ratio
KDENR_WHH | 0.5  | 0.5  |  | Emperor Penguin females typically lay 1 egg which means on average 0.5 offspring assuming 50:50 M:F ratio


## Dinoflagellates

SM_PHY, LG_PHY, DINOFLAG
These groups are involved in processes of growth and mortality due to lysis and grazing in the water column.
Sudden increases would be due to growth rates being too high or predator dying off.

$G_{PP} = mum * B_{PP} * \delta_{light} * \delta_{nutrient} * \delta_{space} * \delta_{eddy} * pHscalar$

growth of pelagic dinoflagellates

mortality of pelagic picoplankton

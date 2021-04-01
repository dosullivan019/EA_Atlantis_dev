Iron in the East Antarctica
================
Denise O’Sullivan, Mao Mori.

### Raw Values

Initial iron values for the EA Atlantis model were calculated from
Schallenberg et al.(2018).

Polygons 2-13 are Southern Shelfwater zones and are equivalent to
station 21 of the paper.

Polygons 17 and 22 are plateau zones: Yellow coloured stations (sACCf)
in figure 7c.

Polygons 14-16 and 20-21 are West zone: Red coloured stations (Fig 7d)

Polygon 18-19 and 24-25 are South of SB points (Fig 7a)

Polygon 23 is an extreme point, fig 7b.

**Fe (nmol/kg) values for EA Atlantis polygons:**

| Depth      | Station 21 | sACCf | West Zone | South of SB | Extreme Point |
| ---------- | ---------- | ----- | --------- | ----------- | ------------- |
| 0-20       | 0.10       | 0.075 | 0.075     | 0.05        | 0.075         |
| 20-50      | 0.2        | 0.075 | 0.075     | 0.06        | 0.075         |
| 50-100     | 0.35       | 0.08  | 0.08      | 0.08        | 0.075         |
| 100-200    | 0.50       | 0.15  | 0.15      | 0.16        | 0.225         |
| 200-300    | 0.7        | 0.165 | 0.15      | 0.225       | 0.425         |
| 300-400    | 1.2        | 0.165 | 0.165     | 0.3         | 0.37          |
| 400-750    | 0.5        | 0.165 | 0.23      | 0.28        | 0.27          |
| 750-1000   | 0.5        | 0.165 | 0.23      | 0.28        | 0.27          |
| 1000-2000  | 0.4        | 0.165 | 0.23      | 0.28        | 0.27          |
| 2000-10000 | 0.4        | 0.165 | 0.23      | 0.28        | 0.27          |

``` r
raw_data = matrix(c(
  0.10,0.075, 0.075, 0.05, 0.075,
  0.2, 0.075, 0.075, 0.06, 0.075,
  0.35,0.080, 0.080, 0.08, 0.075,
  0.5, 0.150, 0.150, 0.16, 0.225,
  0.7, 0.165, 0.150, 0.225,0.425,
  1.2, 0.165, 0.165, 0.30, 0.37,
  0.5, 0.165, 0.230, 0.28, 0.27,
  0.5, 0.165, 0.230, 0.28, 0.27,
  0.4, 0.165, 0.230, 0.28, 0.27,
  0.4, 0.165, 0.230, 0.28, 0.27), nrow=10, ncol=5, byrow=TRUE)

colnames(raw_data) = c('station21', 'sACCf', 'west_zone', 'south_sb', 'extreme')

# map polygons to their relevant station/area from the paper
polygons = c(NA, rep('station21', 12), 
             'west_zone', 'west_zone', 'west_zone', 
             'sACCf', 'south_sb', 'south_sb',
             'west_zone', 'west_zone', 'sACCf',
             'extreme', 'south_sb', 'south_sb',
             NA, NA, NA)
names(polygons) = c(1:28) 

iron_values <- matrix(ncol=10, nrow=28)
row.names(iron_values) = c(1:28)
shallow_layers = c(2:7)

for(box_i in 1:nrow(iron_values)){
  if(!is.na(polygons[box_i]) & !(box_i %in% shallow_layers)){
    iron_values[box_i,] = rev(raw_data[,polygons[box_i]]) # rev as the init.nc file the layers are reversed
  }
  else if(!is.na(polygons[box_i]) & (box_i %in% shallow_layers)){
    iron_values[box_i,1:7] = rev(raw_data[,polygons[box_i]][1:7]) # only the 
  } 
}
```

Conversion of nmol/kg to mg/m3 is done by the following equation:

Fe \[mg/m3\] = 55.845 \* 0.001 \* x

where x = original dissolved Fe value

``` r
iron_conversion <- function(value){
  value * 0.001 * 55.845
}
```

``` r
iron_mg <- apply(iron_values, 1:2, iron_conversion)

# replace coastal polygons with NA for layers 8-10
iron_mg[which(is.na(iron_mg))] = 0
iron_mg = cbind(iron_mg, c(0,rep(2.7, 24), 0, 0, 0))

write.table(iron_mg, file="Fe.csv", row.names = FALSE, col.names = FALSE, sep=',')
```

### Plotting Depth Profile of Iron

``` r
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tidyr)
cum_depths = c(0,20,50,100,200,300,400,750,1000,2000)

# Add box name to matrix
iron_df = as.data.frame(cbind(rbind(iron_mg[2:7,c(7:1,8:10)],iron_mg[c(1,8:28),10:1]), rownames(iron_mg), polygons))
iron_df[,1:10] = sapply(iron_df[,1:10],function(x) as.numeric(x))
colnames(iron_df)=c(1:10, 'box_no', 'box_name')

# Plot Iron Profile
iron_df %>% pivot_longer(cols=1:10, names_to='layer') %>% cbind(depth=rep(cum_depths, 28)) %>%
  filter(box_no %in% c(2, 14,17,18,23)) %>% # only plot each different profile once
  ggplot(aes(x=value, y=-depth, group=box_name, col=box_name)) + geom_path(size=1.5) +
  labs(title='Initial Iron Values for Atlantis East Antarctic Model',
       x='Fe mg/m^3',
       y='Depth',
       colour='Polygon') +
  scale_y_continuous(breaks=-cum_depths) +
  scale_x_continuous(breaks=seq(0,0.1,length.out=11),limits=c(0,0.08)) +
  scale_colour_manual(values=c('grey61','cornflowerblue','gold','skyblue','orange')) +
  theme(legend.position='top')
```

![](Fe_files/figure-gfm/plot%20iron%20profile-1.png)<!-- -->

### Note

These initial values were not high enough in layer 2 of some boxes and
the initial iron levels did not support iron flux on day 1 which led to
the model crashing immediately. The following box-layers were
overwritten to avoid this crash happening and probably need to be
reviewed:

Box 2-13 Layer 2: Increased from 0.011169 to 0.012169.

### Redfield Ratio

The Redfield ratio of Fe:N is SeTAS is 30000 which was very large and
causing the model to crash once the flagmicro was turned on. The
redfield ratio for the EA model is set to 400 and was calculated using
the equation from wikipedia
(<https://en.wikipedia.org/wiki/Redfield_ratio>):

106 C:16 N:1 P:0.1-0.001 Fe

Using the mid-range between 0.1 and 0.001 -\> 16N:\~0.04Fe

### References

Schallenberg, C., Bestley, S., Klocker, A., Trull, T.W., Davies, D.M.,
Gault-Ringold, M., Eriksen, R., Roden, N.P., Sander S.G., Sumner, M.,
Townsend, A.T., van der Merwe, P., Westwood, K., Wuttig, K, Bowie, A.,
2018. Sustained Upwelling of Subsurface Iron Supplies Seasonally
Persistent Phytoplankton Blooms Around the Southern Kerguelen Plateau,
Southern Ocean. J. Geophys. Res. Ocean. 123, 5986-6003.
<https://doi.org/10.1029/2018JC013932>

# Relationship Between City's Physical Structure and Economic Performance [Full_text](https://github.com/cliptic/Cities/blob/master/Thesis%202018%2006%2006.pdf)
K-means Clustering 750 European cities based on their physical parameters and evaluating economic parameters
#### Methodology steps:
* Gathering geographical data
* Extracting physical parameters
* Clustering cities with K-means
* Evaluating economic parameters
## Results
![](https://github.com/cliptic/Cities/blob/master/images/map150.jpg)
![](https://github.com/cliptic/Cities/blob/master/images/characteristics.jpg)

## Abstract
This study constructs and uses structural, functional and geographical features of cities,
clusters them into 8 groups with unsupervised learning k-means algorithm and briefly evaluates
the differences between the economic indicators of clusters. The results show that clusters
perform differently among themselves from the economic perspective. They differ in their
employment composition, GVA per worker output, education levels and composition, numbers
of patents produced.

## Research methodology
The research consists of two major parts. First part involves gathering and clustering
physical data of European cities and the second part consists of gathering and evaluating the
economic performance differences between clusters of cities. This research will use K-Means
algorithm.

## DATA GATHERING
The geographical data has been obtained from the European Commission data portal
Eurostat, the European Environmental Agency (EEA - an agency of the European Commission)
and the Copernicus project in the form of data tables, GEOrasters and shapefiles – geospatial
vector format. Urban Audit (URAU) 2011-2014 shapefile was used as the basis of determining
the physical shapes and characters of cities and their functional areas as provided by the
Eurostat data portal and approved by the European Commission. 
![ ](https://github.com/cliptic/Cities/blob/master/images/FUA.jpg)
This data set contains more than 800 cities and 600 Functional Urban Areas. Cities of 50 000 
inhabitant or more. Data manipulations and calculations have been preceded in QGIS –
an open source Geographical Information System program, MS Excel and R. Economic
variables have been obtained from the Centre for Cities – an independent urban policy
research unit and a charity registered in England. The main aim of this organization is
researching cities and their economic performance. The collection of data includes more than
300 cities in Europe. The data is based on the year 2011 and has been checked to have matching
names with the URAU city naming, nothing else in the data set has been manipulated.
Calculations and later implementation into research was conducted using MS Excel and R.
![](https://github.com/cliptic/Cities/blob/master/images/imperviousness.jpg)

## Physical Measures
Physical measures included in this research are based on previous studies in the attempt
to recognize the most characteristic measurements of city structure that influence the economic
choices of people and companies associated with that geographical location. Most of the
variables were based on the working paper of Aksoy et al. (2016). Some additional variables
were added. Like Weighted Urban Proliferation (WUP). Gomputed in ArchGIS.
WUP – Weighted Urban Proliferation - is a product of UP, w1(DIS) and w2(LUP) which
indicates higher sprawl values with a higher WUP since it is a product of three measurements
that represent sprawl characteristics in 3 different dimensions: part of used-up land (PBA and
UP), the spread of built-up land (DIS) and the intensity of it’s use (LUP).
![](https://github.com/cliptic/Cities/blob/master/images/WUP.jpg)
![](https://github.com/cliptic/Cities/blob/master/images/eq1.jpg)
![](https://github.com/cliptic/Cities/blob/master/images/eq2.jpg)
![](https://github.com/cliptic/Cities/blob/master/images/eq3.jpg)


## K-means Clustering
This research will be using Z-score standardization. This transformation is useful where
the actual minimum or maximum is not defined or unknown. It has been found that z-score
standardization is more effective for K-means clustering preprocessing of data than min-max
and decimal transformations. The process is performed with centering and scaling data with a
function center_scale form an R package “ClusterR”.
Selecting a number of clusters is a complex tast. There were several methods used to attempt to identify the best number of clusters. Since there was no clearly defined point, the study chose 8 clusters which seemed as a reasonable number after exploring similar research and the test results.
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20var%20ex.png)
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20rsq.png)
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20AIC.png)
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20BIC.png)
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20WCSSE.png)
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20diss.png)
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20dist.png)
![ ](https://github.com/cliptic/Cities/blob/master/images/KMst%20sil.png)

## Economic Valuation

From the results we can see that clustering with physical parameters can provide some
basic insight into the functional and economical structure or the city. In addition, we can extract
some reasonable overviews in the geographical distribution. This might be due to the fact that
different countries tend to have various traditions of building and react to the climatic
conditions. It is possible to assume, that the physical structure represents the culture of the
place, not just the economic performance.
Nevertheless, some general insights can be concluded:
- Big capital cities tend to cluster together and are easily defined as having exceptional
structural parameters: density, spread, land-use parameters.
- The surrounding cities of the central capitals work as “donors” and provide the living
area for the central territories, which contain most of the business stock of the
surrounding functional pattern. The livable suburban-type city can be observed in the
geographical characteristics such as high levels of coverage by urban green
infrastructure that provide an attractive area to live in.
- No single economical unit will work better than an area densely interconnected and
sharing the public infrastructure. This includes the public sector employment measures
as well as high density and land-uptake
![](https://github.com/cliptic/Cities/blob/master/images/Economics01.jpg)
![](https://github.com/cliptic/Cities/blob/master/images/Economics02.jpg)

#### DATA
[Primary Data With City, FUA Names and ID's](https://github.com/cliptic/Cities/blob/master/CFDATA20180505.csv)
[Data with Decimal Scaling](https://github.com/cliptic/Cities/blob/master/originaldataset.csv)
[Z-score standardised data for Clustering](https://github.com/cliptic/Cities/blob/master/KMdatasetST03.csv)
[Some Primary Geographical Attributes](https://github.com/cliptic/Cities/tree/master/transform)

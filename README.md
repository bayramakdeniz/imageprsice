# Docker and Singularity containers for Polygenic Risk Score analysis

Docker and Singularity containers to perform Polygenic Risk Score (PRS) via PRSice-2 (https://www.prsice.info/) .

## Getting Started

In order to run the developed Docker and Singularity containers you need to install Docker (https://docs.docker.com/get-docker/) and Singularity (https://sylabs.io/guides/3.6/user-guide/quick_start.html?highlight=install),  respectively. You can run each container separately.

Note that you can try different analysis other than the one  presented here as introductive example. For more detailed information related to Prsice-2 analysis, please have a look for [1]  (https://www.prsice.info/quick_start/) and [2] (https://www.intro-statistical-genetics.com/data-code ) (ch. 10). Keep in mind that, here  we are using "PRSice_linux" instead of "PRSice" hence you may need to change this command if you want to use examples in these references.  
 

## For Docker Container

1. Pull the docker container from Docker Hub

```
docker pull bayramalex/imageprsice

```

2. You can run the pulled containers in different ways based on the purpose

### Passive mode

```
docker run  bayramalex/imageprsice <your PRSice2 analysis>

```

Example: 

```
 docker run  bayramalex/imageprsice  Rscript PRSice.R --dir . \
    --prsice ./PRSice_linux \
    --base BMI.txt \
    --target 1kg_hm3_qc \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --pheno-file BMI_pheno.txt \
    --bar-levels 1 \
    --fastscore \
    --binary-target F \
    --out BMI_score_all
    
 ```


### Interactive mode

```
docker run  -it bayramalex/imageprsice 

```

Once you run the code, you have entered inside the container (indicated by '#' sign), then you can run any anaylsis without typing docker commands.



Example: 

```
  Rscript PRSice.R --dir . \
    --prsice ./PRSice_linux \
    --base BMI.txt \
    --target 1kg_hm3_qc \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --pheno-file BMI_pheno.txt \
    --bar-levels 1 \
    --fastscore \
    --binary-target F \
    --out BMI_score_all
    
```


### Mounting your data to container
It is desired to do analysis with your own data. At this point it is required to mount  a path to container and do analysis on the data in this path. 

```
docker run  -it -v  /your/local/path:/INPUT bayramalex/imageprsice 

```
For  example

```
docker run  -it -v  /Users/bayramakdeniz/mydataset:/INPUT bayramalex/imageprsice 

```

Once you run this, you will observe an interactive container with an additional INPUT folder which is actually /your/local/path. Now you can do your analysis with your data by indicating the place of it by "INPUT/ "   such as: 


```
Rscript PRSice.R --dir . \
    --prsice ./PRSice_linux \
    --base INPUT/BMI.txt \
    --target INPUT/1kg_hm3_qc \
    --thread 1 \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --bar-levels 5e-08,5e-07,5e-06,5e-05,5e-04,5e-03,5e-02,5e-01 \
    --fastscore \
    --all-score \
    --no-regress \
    --binary-target F \
    --out INPUT/BMIscore_thresholds  
```
 
 Keep in mind that, the generated outputs after analysis can be both found in INPUT/ and /your/local/path.
 
 It is also possible to run it with passive mode as:
 
 ```
docker run   -v  /Users/bayramakdeniz/GoogleDrive/COMORMENT/bookMelinda:/INPUT bayramalex/imageprsice  Rscript PRSice.R --dir . \
    --prsice ./PRSice_linux \
    --base INPUT/BMI.txt \
    --target INPUT/1kg_hm3_qc \
    --thread 1 \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --bar-levels 5e-08,5e-07,5e-06,5e-05,5e-04,5e-03,5e-02,5e-01 \
    --fastscore \
    --all-score \
    --no-regress \
    --binary-target F \
    --out INPUT/BMIscore_thresholds  
```
 



## For Singularity Container

1- Build Singularity image from Docker Hub

 ```
singularity build imagename.sif docker://bayramalex/imageprsice:latest

```

Alternatively you can build it as  'sandbox' to use it in passive mode

```
singularity build --sandbox imagename/  docker://bayramalex/imageprsice:latest

```

Here  a container folder called imagename is created in the working directory. You can cd to this folder and work as if you  are working in the passive mode in Docker.


2- Go to the directory where your data is: cd ~/your/local/path

Copy PRSice.R script to this directory.

Run the container by mounting this directory

```
singularity exec -B  $(pwd):/INPUT /path/of/the/container/imagename.sif  <opts>

```

For Example

```

singularity exec -B  $(pwd):/INPUT /home/bayram/mycontainers/imagename.sif Rscript PRSice.R --dir .     --prsice /PRSice_linux     --base BMI.txt     --target 1kg_hm3_qc     --snp MarkerName     --A1 A1     --A2 A2     --stat Beta     --pvalue Pval     --pheno-file BMI_pheno.txt     --bar-levels 1     --fastscore     --binary-target F  --extract BMI_score_all.valid     --out BMI_score_all

```

Warning: A slight difference in Singularity container is: you need to run as  /PRSice_linux instead of  ./PRSice_linux


## References

[1] Choi SW, and O’Reilly PF. "PRSice-2: Polygenic Risk Score Software for Biobank-Scale Data." GigaScience 8, no. 7 (July 1, 2019). https://doi.org/10.1093/gigascience/giz082.

[2] MILLS, Melinda C.; BARBAN, Nicola; TROPF, Felix C. An Introduction to Statistical Genetic Data Analysis. MIT Press, 2020.



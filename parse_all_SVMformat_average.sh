# This script creates the input files for easy_WSC.py

type=$1

results_dir=""

if [[ "$type" -eq "4"  ]]; then 
   results_dir="average_4features"
else 
   results_dir="average"
fi

cluster_total_index=1


for a in Final_results/*; do
  
  echo $a
  aux="$(echo $a | rev | cut -d'/' -f 1 | rev)"  
     
  echo $aux
 
  site=${aux%%_*}
     
  echo $site

  if [[  "$type" -eq "4" ]]; then
     mkdir AVERAGE_INSTANCES_4FEATURES/$site
  else
     mkdir AVERAGE_INSTANCES/$site
  fi



  for cluster in $a/$results_dir/cluster_*; do  
    i=1
    
  
 
    for d in fold1/$site/trainSet_*/*; do

            file="$(echo $d| rev | cut -d'/' -f 1 | rev)"
           
            echo "FILE " $file
            if [[ "$file" == http* ]]; then
               
              if grep -Fxq "$file" $cluster; then  
                  
                  clusterNum="$(echo $cluster| rev | cut -d'/' -f 1 | rev)" 
                   
                  if [[  "$type" -eq "4" ]]; then
                     awk -v x=$i '$1=x ' $d >>  AVERAGE_INSTANCES_4FEATURES/$site/wsc_${site}_${clusterNum}_TCP
                  else 
                     awk -v x=$i '$1=x ' $d >>  AVERAGE_INSTANCES/$site/wsc_${site}_${clusterNum}_TCP
                  fi
                 
                  i=$((i+1)) 
              fi
           

            else 
               
               if grep -Fxq "$file" $cluster; then

                   if [[  "$type" -eq "4" ]]; then
                      awk -v x=$cluster_total_index '$1=x ' $d >>  AVERAGE_INSTANCES_4FEATURES/mainPages_TCP
                   else 
                      awk -v x=$cluster_total_index '$1=x ' $d >>  AVERAGE_INSTANCES/mainPages_TCP
                   fi 
               fi
            fi
    done

    echo "CLUSTER " + $cluster + " CLUSTER TOTAL INDEX " + $cluster_total_index             
    cluster_total_index=$((cluster_total_index+1))       

  done
done


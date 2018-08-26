
foldNum=$1

for d in fold${foldNum}/*; do
  echo $d
  site="$(echo $d | rev | cut -d'/' -f 1 | rev)"  
  
  cp -r $d/trainSet_${foldNum} ${site}_trainSet_${foldNum}

  ./parse_features_for_clustering.sh ${site}_trainSet_${foldNum}
  ./parse_4_features_for_clustering.sh ${site}_trainSet_${foldNum}
      
  ./dbscan.py clustering_${site}_trainSet_${foldNum}/ 
  ./dbscan.py clustering_4_${site}_trainSet_${foldNum}/
  ./dbscan_average.py average_${site}_trainSet_${foldNum}/
  ./dbscan_average.py average_4_${site}_trainSet_${foldNum}/
     
done

./put_pages_in_clusters.sh 104
./parse_all_SVMformat.sh 104    

./put_pages_in_clusters.sh 4
./parse_all_SVMformat.sh 4 

./put_pages_in_clusters_average.sh 104
./parse_all_SVMformat_average.sh 104 

./put_pages_in_clusters_average.sh 4
./parse_all_SVMformat_average.sh 4
     
rm -r *trainSet_${foldNum}


foldNum=$1

for d in fold${foldNum}/*; do
  echo $d
  site="$(echo $d | rev | cut -d'/' -f 1 | rev)"  
  
  cp -r $d/trainSet_${foldNum} ${site}_trainSet_${foldNum}

  ./parse_features_for_clustering.sh ${site}_trainSet_${foldNum}
  ./parse_four_features_for_clustering.sh ${site}_trainSet_${foldNum}
      
  ./dbscan.py clustering_${site}_trainSet_${foldNum}/ 
  ./dbscan.py clustering_four_${site}_trainSet_${foldNum}/
  ./dbscan_average.py average_${site}_trainSet_${foldNum}/
  ./dbscan_average.py average_four_${site}_trainSet_${foldNum}/
     
done

./put_pages_in_clusters.sh all
./parse_all_SVMformat.sh all    

./put_pages_in_clusters.sh four
./parse_all_SVMformat.sh four

./put_pages_in_clusters_average.sh all
./parse_all_SVMformat_average.sh all

./put_pages_in_clusters_average.sh four
./parse_all_SVMformat_average.sh four
     
rm -r *trainSet_${foldNum}

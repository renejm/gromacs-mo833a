#!/bin/bash

echo -e "\e[92m\e[1m********************************************************"
echo -e "*************** EXPERIMENTO COM 2 NÓS... ***************"
echo -e "********************************************************\e[0m"
echo " "
rm -f /home/rene/.clap/storage/platform.json
rm -f /home/rene/.clap/storage/modules/cluster/cluster.json
clapp cluster start cluster-t2.micro-2x
clusterid=$(clapp cluster list | grep id | cut -d' ' -f2)
nodeid=$(clapp node list | grep node-master | cut -d' ' -f3 | cut -d'=' -f2 | cut -d'`' -f2)
echo "Cluster id: $clusterid"
echo "Node id:    $nodeid"
clapp cluster action $clusterid gromacs run --nodes $nodeid
clapp cluster action $clusterid gromacs fetch-result --nodes $nodeid
echo " "
echo -e "\e[92m\e[1m********************************************************"
echo -e "*********** EXPERIMENTO COM 2 NÓS CONCLUÍDO! ***********"
echo -e "********************************************************\e[0m"
echo " "

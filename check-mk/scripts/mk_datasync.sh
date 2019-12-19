#!/bin/bash

# Check datasync

curl starkey.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Starkey - DataSync Starkey is UP" || echo "2 DataSync_Starkey - DataSync Starkey is DOWN"
curl redetudoaqui.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Redetudoaqui - DataSync Redetudoaqui is UP" || echo "2 DataSync_Redetudoaqui - DataSync Redetudoaqui is DOWN"
curl iwanna.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Iwanna - DataSync Iwanna is UP" || echo "2 DataSync_Iwanna - DataSync Iwanna is DOWN"
curl colono.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Colono - DataSync Colono is UP" || echo "2 DataSync_Colono - DataSync Colono is DOWN"
curl silvia.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Silvia - DataSync Silvia is UP" || echo "2 DataSync_Silvia - DataSync Silvia is DOWN"
curl extincendio.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Extincendio - DataSync Extincendio is UP" || echo "2 DataSync_Extincendio - DataSync Extincendio is DOWN"
curl construsat.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Construsat - DataSync Construsat is UP" || echo "2 DataSync_Construsat - DataSync Construsat is DOWN"
curl svx.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Svx - DataSync Svx is UP" || echo "2 DataSync_Svx - DataSync Svx is DOWN"
curl pontobeer.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Pontobeer - DataSync Pontobeer is UP" || echo "2 DataSync_Pontobeer - DataSync Pontobeer is DOWN"
curl clubdagula.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Clubdagula - DataSync Clubdagula is UP" || echo "2 DataSync_Clubdagula - DataSync Clubdagula is DOWN"
curl cimequipamentos.jivacloud.com.br:8080/datasync.html -k -s -f -o /dev/null && echo "0 DataSync_Cimequipamentos - DataSync Cimequipamentos is UP" || echo "2 DataSync_Cimequipamentos - DataSync Cimequipamentos is DOWN"

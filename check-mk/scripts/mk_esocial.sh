#!/bin/bash

# Check datasync

curl esocial.itms.jivacloud.com.br/index.html -k -s -f -o /dev/null && echo "0 SaneSocial_ITMS - SaneSocial ITMS is UP" || echo "2 SaneSocial_ITMS is DOWN"
curl esocial.pmbdelyra.jivacloud.com.br/index.html -k -s -f -o /dev/null && echo "0 SaneSocial_PMBdeLyra - SaneSocial PMBdeLyra is UP" || echo "2 SaneSocial_PMBdeLyra is DOWN"
curl esocial.etica.jivacloud.com.br/index.html -k -s -f -o /dev/null && echo "0 SaneSocial_Etica - SaneSocial Etica is UP" || echo "2 SaneSocial_Etica is DOWN"
curl esocial.instituto.jivacloud.com.br/index.html -k -s -f -o /dev/null && echo "0 SaneSocial_Instituto - SaneSocial Instituto is UP" || echo "2 SaneSocial_Instituto is DOWN"
curl esocial.rtrepresentacoes.jivacloud.com.br/index.html -k -s -f -o /dev/null && echo "0 SaneSocial_RTRepresentacoes - SaneSocial RTRepresentacoes is UP" || echo "2 SaneSocial_ITMS is DOWN"

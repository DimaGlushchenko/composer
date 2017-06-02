(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� )�1Y �[o�0�yx�@�P�eb�����֧($.x�&�Ҳ��}v� !a]�j�$�$r9�o���c����xa���sk�@�v;�.^]
�;C�$�&J�ؑQ��:�#�b�J�$�-@-&V��Ӻ���))"|�/�g")�Q$��!oI}$�� سVH�m����"�kI���)���f��Zݖ�	J1z�F����� h�ƕpّ٥�ِ�b���h'7Pӵ����>��i�F��^L��h�z��ȹh�=��b"o�V`�
��Md6�h�`���Mb6�7+�4gjf8Ԡ���:���	M�p���F/���n�S��Iⷝl;�"z+R��h<�
\@�7�7�Q����M^�c�ylBZ����8��	��V������ظ/�C�DS��+FQl�w���4z����ӵoI�42���M�!
ݖ��h�6hD.B!��X�?p`�L��i�&��VU<�DEw�49�߿�е�+$�S���µ �K�j��<-����d�괊uz;������� u;�}d�������(��լݗZ�P�oy����c��"���}�	�������^S�n�s�����d��:��>���>�6A�
�ܨ<�.�k�Cv�)l�	m����<��v̱��E)��.YVꥪ��n��b���Y�%A(���T$Ϲ���B�s�yS�-��Y!�&�Q��?|n��W�O�����p8���p8���p8���p8���O���D (  
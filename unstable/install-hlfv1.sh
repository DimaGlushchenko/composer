ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -e

# Docker stop function
function stop()
{
P1=$(docker ps -q)
if [ "${P1}" != "" ]; then
  echo "Killing all running containers"  &2> /dev/null
  docker kill ${P1}
fi

P2=$(docker ps -aq)
if [ "${P2}" != "" ]; then
  echo "Removing all containers"  &2> /dev/null
  docker rm ${P2} -f
fi
}

if [ "$1" == "stop" ]; then
 echo "Stopping all Docker containers" >&2
 stop
 exit 0
fi

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

# stop all the docker containers
stop



# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh
./fabric-dev-servers/createComposerProfile.sh

# pull and tage the correct image for the installer
docker pull hyperledger/composer-playground:0.15.2
docker tag hyperledger/composer-playground:0.15.2 hyperledger/composer-playground:latest


# Start all composer
docker-compose -p composer -f docker-compose-playground.yml up -d
# copy over pre-imported admin credentials
cd fabric-dev-servers/fabric-scripts/hlfv1/composer/creds
docker exec composer mkdir /home/composer/.composer-credentials
tar -cv * | docker exec -i composer tar x -C /home/composer/.composer-credentials

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

echo
echo "--------------------------------------------------------------------------------------"
echo "Hyperledger Fabric and Hyperledger Composer installed, and Composer Playground launched"
echo "Please use 'composer.sh' to re-start, and 'composer.sh stop' to shutdown all the Fabric and Composer docker images"

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �Z �=�r�v�Mr����[�T>�W߱je��y�� �H|I�l_m340b���B�n�nU^ ��wȏ<G^ ��3�������kNծp��ӧ?N�9�O����̀b�;������`��=��0D�"��	��/���E�a���</��Gb�G�����c����m®j��[��+�.2-��w����02���������M���PՑy��6���L�8��� SC�2C�|ߔ��ô-�$ ���ms;�[4�]�4�6��R�0wtX�����|:���� >`h�,v�O淑kІe:��#�/fc9�my��=BȔjmUg�@�ihiX	)&�I��a�R�S��B��i&
E�1ل��4w&���9��i�xn�H�q��F]���ֽnkjuX5Ue^�k�RL�c���fH� ��yl\ī���Cl��1�J�aR�P�h��4�^��
5kn�j�0���3�2�[8Ƴ{tH�15�z��(;��G9�.a��!҂��f;��ٓbN+wZ��5H�S�mu�)R��l���<\e��R��M����+0h`�����`~N)?��f�%�A�4�&�� ˮ|�L�sS[:o�i�.�̷���s��'b;@w4�����5�#�g�-���P:��{�K�:�{���u��2�{�|�������i��� J^,����"�c�O�ÑG r�L��\��2�6�j�����5h5����d���@�_��������WO���z�
�&c�� �n>J����&Y1��	��w^:���[��5����@�WÿB����'�W���a���'��Y埋��������?V�����$��[�,�����J`-�_7L��TZ������K��/����X�'���(�k�_����us2P��#�rA.wS']�H� �h�l�����-�&�5!���86;-t�xf�z;���[�n��I&���m���7p��m�����;��P�4�*qb���Q؆�YAR��R,t�aN���^	�?MU�nѺ%,5M<_4q&��4�e�W�˪f(-�	�^{�24�t�E��V��dk�ܪ�j� 4��ڥGl��:  ����"	X�G����B�א���G�`J���ې�W���š��������'rep� �7_3����9�I�R�txYp��'��I�������*���1O ��@���a���-U� �k�Dm��p"����
[̰�e��Ϙ�s��n>��):|xƨu�h�G<� ��X�IH�x�@J� �>��І�ڛ�� � �!<aC޹�W�Rf�*�\��kf�^$�T�j�6�A�N�&��v���5zJnh��$�=��>;1�a�8�o�w��cX%�v	��~L�ʼ���2�T7lp�EfڮN��`|�zTy �3�е>�_�z���qLa��<V�6h�G.��զ��5���M�Q.sT
�G�Ґb�^SU����xX��i�>��� hg#��u�^���2����@�ɰy������	7��T�Iq�GY�<����*6�[/_�'j"�]��f��C����#*L���zk�Za��O&ҽ�~	����D������|�0E�GcyOu,�^����sk��J�ՓR#?����N꣙��m�44�!�nƄUWGsL���V~�Ϥ���OXM��^�t^J�G��_�҄�b����=�`k��z��Du��Vr�R��M���R�0���z�5{:�P-���_`�rڤ7j�_��U0^`�*d�f��41Eb	lm�gaf��r��RY*���ٜ|X)��zm�|<�����F�J���D-4����r����4(3���-؜Z��������`h�P�r&�; �5qt�]E&^� ��Z)�IY�':١c^��I���5�V8ύb'�Fa�g��a3����ѻ�n�H��7�?$\l��� �_��V5���aY�S��������@�4ڠ��H��������h�	��T���}���?�s��_,,��p���<�T���iU��i ��C]���2�m�k�si�"�
��u�=���RY���?5q���������?����i���m��K��?\,<���������8���n��7- �4��c������P�YA����%�=��Y�G!�1R1����C��@���n��'��0�Rӱ���}��x�H�շl�$�sO+��Ef��&��wT:���r9�=p���
��H���ij�5$e#�����g:�U�U!j5y��bO �n̅~�UD�����ر2F�O�9���=w�x�X�t��t�l��k�� �]����h�������0���������?(�d�\��x!"6l�k)��S�*�񁻮�A8)��f<���C7� ��"|�	[Az�.���w��p�f�:Vd���V����@���O��Y�+�����Ü����'XMAJˍ7tý\�f����!��H΍�ht��8�Er|��܏���Qo��av 0 �o �Z �������M�'>��;��vߣ��s���;��}Aw�C���a���2�W''�C�j�W�����[`Dnx�E5ˍ�(|�J�c��͆=��*3$��G�F�͚���	yN7��IR�H�_�6���qy�T� �#�@�p!�V�*�����O?�0^����5u�!�V	�E���>�2������|t�����
�Q7�v�9��-��|$d��Ⱦ�����`Ŕ=&�"��R�X]��sL{�c�����M<\��q�0'_�}�f�{-��f׆�f�83�Q1{,���}�t��e�7�~�6�ASW�uL���a���n�Ǖ��i~����&[��!�!�r(��9%����qTW���0"N��䔰�)�ߎ�x��A����[-&)�+��R:��YH��6
-�x�^ A@�-�g* ��;m��ekH�F���D��Q�:�%�P�l#݇��@�(�&I3��&�?>��+�4�z&�
^&8S�4|aQ)� y����� �v���+����V#ݫ�X��0�n;����2A��쿈8�%����[	|���8�n�VM��	�?�b�)>��[���/x�����iAA�E'�_�	��_+�e��a�»x�C?NE��+F������?����eH|�4�nav�4�*�t�, W8�a�հ���4xM�Q���1��v�6�$���׸I��%Ƶ=��Xl���E6G��&�H�ugdmxV6��>�`�k����í���
�	u�%�����[���<��E�]����:� �y����&��"��:�{%��߷�9���o���w�������������(\�Q��u�Wx1�պ�l���z5.�B"�GbT�W�aQ�b<����vD�nG"��-��o�I��ƿ0+u:�cEd�����K��m<�~�a��n��:���fc���ҿ��o6���8���oFtX��u�X���w���3���q��_�OLl����?m<�H3L���6��x	������s��w���ީ����an���>q�����Ա`�n��Y�c5�ѳ��� ��Z�iCKc�
r����ul?��}��Ź7?m1���|d�ه�7����e٣\�:����Bb�	9��r>�Mg�RY����\6��\$���lH�lBjd�R�9ԏ����P"�7��TCni�^�q��7βW��q{ʕ|�)H���W�D3�<>�]�WR1��cR�d+߬f�v5�ځ'�e�B��yJ9u���D杮��Ω�]�
ۗ�����0�r&�?����7�f�M�:+E.�w������+�B��N?hO���5�|����Y!W�r��pB�.h7H{��\$����KNSǅBF�>�\���8Һd"�_�<9�*�H�,���嗹�;�"���|�?=�\�7���\�%8�!�z'���O"�=W�h(���̥v��w�����D.��Ȕrb\jșd��ݓ�$.+%2���e��gZ��r��8���o������M�~8)�_'����qL+V�p_�O�ZIU#��Y��Km�K�����g���4z��r� '�x,0��TON�z2�{���#}�W�%���,]HR.i�Vղ�B+�ܗ���y�X"������A�����ic	���C�K��9Ux�ó��Iưex�אrr%�-$Ek�}�'�Ƈj����*9������X*A%���;�w��P#�(E��F;��_3҆܁r���ǜ�;��qn�rj?)�c�Z�R�v��t����1`�����`��Co�z����O����x�����G9��<?c0X�Mð��-����'��ˮ����n�V4������O��������n�}���>fr��ޓ�y{t"�� ѡ
��e{�}C��V5��9;�����3'����)�\���4�ʕ����MZ�J���UZWi��=�:�I�x^E�ǌxܪ��H?��P�r�'d�F�y�W�)
H��JU��Aj�̡6J�F.���|7��{�ˁe�� Q�Ա@�yQ�|�!BBB���c'1˚I̲V����,k#1˚H̲����,k1˚G̲���q�L�����ѯ<��.�e��M�/���V���s����kx�e��4�o��������$�I���n���鞧�%��P�KI%UhH2��L9���r�u���,�nt�Q;��1�g�\KF�S<{����aH�q���?h]ٺ�֥�`��K.����,LI��]�7�����|���n����-�c��Go������X<I��7i\|6���2;A i(�4�� �D������ܳ����0���È��L�=t#P͆ł H����4b֨���ѵ,І:l���^�*Ѝ}��>Y��C>-}��	=��� y��Q ��6T�������]7�Ȗ:H��XB�^�"��H3z4�,5����S�ee�m� �3,��B�7w�"�{�YL"�d
8y����t�6���;������Wtrɂܣ������d����t�$�n�M>v�B$2�\g }�1=z�F�t^�a@o��y��u��2ym��p�A�p�ѥ�ѡ�& A@ӄ}R!I�|٦�,L[�{�(�O��}�j���
���ۓ	��i}pTl^<�&�~��(��XP��ｐA��$q���޳�8�d53;Eΰ;�w>4��0ߚn;��b[�Lg�N���t�l�Hg:����L;m�5��#���� n �!�����
����!n�""?N�\����]��V��Ȉ�����]����Y0>�mA�-f{�Cwۃ4��3�|E? �����
��Df���;;�&�Í�����w����!��b����W�b���Z���3�A�B5�9 ���\	��W��T�&�檱|xg��۳�7M����I1��>L��·ە��üt�N�sÌ��ZAU�?��׹
v#d�gg�d0�$}uw�ŧ���/P�3��_�MB!�!�.+��&�T��X���b,=��@@/R�a�C��U����ʾ[*�OΜ����vs��rM�����x�B,	ɏp��?u]�!�8��XQ�GM��c��̀�g���&{:�,0�|����7H�bB�x#v;�2C40(��hf�Ѐ@��3f�"�+�~�VIٴ<�����P�@Ӧ��`���|YV7��@��J �a���<���i:v/rG�#m�8ҝ�C�[	�n4�d2HX��n5����c�U@���1���ݑS�±��
�7��"�J�^���S(���`
;E��OM�E��[t�"���?4u%��1������T"�^��h���������x���,�����Ϳx�W������5"�ߟ�ǿ���x�/�ߥ��(�{�$~m��7_�����]�ב�5�bRW>�v"���@"��Si�J�≴�ĩ��J�b2��&�,�T����dd���_���y��_��/F�8��e>��|����y�O�g����X�b�|�x}}���ۑﾽ�E�ފ|�-�"�o�u�?�_��ȿ݋|q/�O�����#���+����\���u�$W�L��6J٢���Z�1G����g�Z��1g�
�=;������qWd{n�X�}f��D�tϗ�ԡ��;#��آ�bh���I�`��M�i�X�Sr�;cKbCtx�k�L�N{1鎲Kyd�F��3�]�w(	v!�5ƥ�<�Lzte.6�N������[�GǉN�r�Bk֡���p����p���u���o�QM�4��\f8���QiɎ��� Z�Z|7i;�ygbQ+�2Z�İ�f��R��(eb���+�&u���B����P���áf6b5�^���{�0�>/���N�`���p�,��[���W������յ����kE��gs�GD��tf"5�'�����yb���k@�F�r��Y�h��l�h�l�H��r+5=�&�������<�rB��赒)0o7[v�)�3�|"����N���*�D�/f��f���߿��^��0*��gT�~�x�Yd��k�3�*�õ����9�??��F�=[Q�J�3���ء,bg����+ɞ/#z�(;�=�=�=�+ ���ݘ\���!|�s2�j��8�(�K�����]���t�-�zgKc��l�HY�-Z<)1�9��B*�o�D��J�v2�hs☠����?�/�F���&�?�1�D�_��N��e$�U�����V���ϝK�O�)��*E��|6�R�DRK:U�mqN~�ikY}��ۥ��検f�Q)i�/T���T�۪N{5B��9�����<��WPYpa7\�}?�{/Gމ�E^�_�{��������b��7/���Y���𷉷<_x9��G�BMC�-#F���Jd�o��w�^��w^� ]�b��~G"{�-�F^��4�b�?x�'E��N�_�N��"?���?���?�������ޣ�?����W��)`-�;3�J������§')�߻ ���e~�c������t�s�.c�x'�Hs.�6Z���Ϲ��h�a�E�����Ǻ{���l���U�|�
�T���H������Ȳ�ǯ�u�Y��+*_L�R�T逛���Y�Ȧj���HɎ�Ju�N�@�j]�h�K1�����I���ce����(_�taR:6��C�HL��2,�X�#p:V���;�1��>�Jb�Ũ�ø�pZ]gs,���Hg���3�~� w|�N۠`�C�Xr�|���3\1GĆ��*E�cyFg�u9��dJ�F�c*&�'���
5-���uk4l9=*!�(W�I̪s}*:`�� a������J�hO�ft�҃�U���o\K49�(ˁ�\����Y��g�UK������Kd_������9�dnT����M�p�βr�/+�pY1L�&�i\����e�܉�һO���Ϙ��<���rۘ�7�Dx	�*�Wg�m��|͞k���kt�`I��q����M�R��z�5Q۫��Kl���]�1�f)��:�5f��sg�h�¤���JE�"\eD�qe�U�s"�8G.�����#���-Ĥ��k	A�s�������\Ӊ=���ֹp��
%�nB���0`D0;�djj�{������R&|����6��8�|q�hH�`4NJd
�B�+��f���ұ�fv@K1*FK�z�̔V�GO���4Q�� Y��X���񉞞�T�-+/h%��=_Ab:�$���?�m�`Ă��	q�-_�k=�Ja�r�&�����y�(��8^o��r�+e4k<QK�����p��,�ߦ3�n�)h4�:�&0�l�S�&Y�LURF�e
qc���u"�L�D��@!|��C��[�t?`���T�a���V�G�����J/zܔ��X��8o PXzP֛���d]^̨�r�f�sr�]Ԙ��HtR���\a�z+
X����f`$;"�Z��U��G������^;۬rF�����4��K?�|��Cz�W#o�U���7/_��7.���D��tцj�S�=�����2�h7W[3KZN�ț�׈W-�0�,��ϰ����J��y}�x�ɓ'ԻO��A�oo�<��(/��ȫ�+�ڳ�'��Xt�q]q}}/@7�&t�W�`�> �,k��5��Lh0B�=�̠��������M|�9����_�|-�.oz��(�T�,Պ$#��w=ۧ�Q:��x�Z��2*{�K�ϗynq������L�s��_,���'A'^��=��n��4z�?�~��\O{���������������F�J�8
�B`ft�,�:L���EN��T�7�@4.�k*2�3T����#� <�&Li�-�����>������o��xo8ת��Ȱ�b�,����nO�6t̺Y��a�E�����r ]s���;���\ ����[l�]!u�5	:�lG��R��5(�!�[��c!�G�b�ah�*.ԃԀ,z��bt�쾩�]���0�v�Xπ�1	5Fr�Ca/�ŻtB��MZsf(�X�2u
vy�tL���/yf�< A:_[�a�*�0Y¹���`I�Gz�n.jax�1���k�7܇<dߺR����z�aN��:��Ss��e6��Q�B��.�CE�2�k�� �r�ԷmŬɍ�9���X�
*��� ����c-E�ي�nT`�ub������z��$�fH7�M�qO� �l��ȋ,� ֓�Q?�Ӊ�˭'3��b�x����;�4��)�v��a��ژ�oݷM�.�}�"L�kH��Դ,��_�_�	[0{��d��٦b�i4��سh]��Uo�=�7���!�phD��ހ�Z�^�.6o	���,)�O���8|N���5�ke�gg�/"���8l�(�����n1s��m�ޕ��j`�ֵ�u7��ՔF�~OPx�$�\p�8�"KtQ)�o_`+c߆ztý�K����h_b���A\�S�
��ŭ;Xr�)�y���o.�� �m��`��<1Ӂɨ��m?� 6 F"�2*���BI�ڄ�6R��5���am_�`�q�hSF<�k�ƆDRtˆmfG`��f�]@�u:�]A����c�4�9����8ϠlGղK�;V~��ze�E81��:��W�:0`��u�{�fq^�f��l��p�jX�B[��7	^<������)
�`C��q��DX�W#�D��
�&o�F��b��:��$E�Gވ!:9��N�!��8��:�C����X�!b�B�X!@���∜B�Ǎ���n�׵Ŧ):�0�Q��X�^s���<O5�h���n�'p���-(m�Dd
�b��BW<�a�ڎ9z|cSS~��qK���� $8��8��v��j��}��?����������:����L����T�����x�������P@�ZɎ�K.����oe-x�����r�9�EFzU�^t'8'wl�c���UbGc���*���B���W��k���#��t� �V@?�L�4 r2��U����d?���zj�R�}
 Z���YZ��r?��DFt
���x���]n�G��0[8͋���
���v{\��| S��G7��M{�cB�sa��Ӂ��@N%�,˱D&�V�B�j�Y @*�Ȫ�X&�Q�@VP!�#�ɪ��J�P���d7��!��8��o=�z�H�ç����Û�ƛ/<�{OnÌ��;���x�z%nF���7 V�
�`ʧ�j����G�*ϴ˳	M��0����G1�]�.͍�6���K�*�o�_�u7y�;��\X��S9�,6k�(�=v]n��BP�go��
��=\��*hw&jN�f�}��5�E5��d�K�j�h};-�u��vQ�"��õ��)���0��x��b��#k߽A�߯�L��Q���{�����J���-D��sEF���:�K϶
�Y��S��ժBEz4��h4��YG�`��ƞn��
�'.�*?�y��Q8�Om��&�Z�nW����jS�U+y�pZ�v�q$��=���4|iw���q7$/f��.�#/�jp@,�I�,۔Phq��1�2M�QΜ�{E�\��+r��'�?@=T\���L�h�%��(�7z���>0,��6'	ś�A'/#� �7q����$ޛ��F�ݔ�5Ϸ��1��V�+]Q'�X�N��;�ڂwJ f�c�ni�廚�� �9�֌#�[#�vı��FV�8��T�Ut�Z�tK�/���fq��"���%�1�E����|���H�;�x����h�����������������T���?��'��w����;�����x��m���{g��8��Ṟ�Ή(�7�q�BH D��	uу=�;]Ye�r�3��+��A��������ϱ� P\�w�?O��#��)��s��T����o��~>-�������^�o��ߑ h`l���h��J�X�?���_������ő�_��YL��L#�,EF����8�CI�0�ER�1!�	L �b�QL���/��O������;����_H���{}L��\�j�t����jX?��Dm4���-��)#��Lo�Ž���/�?Ǎ�U��dka���'n3db���<��_z�X�j:��T����.U�ට�C2�櫖:bH)>M�t��w�������]w���?��������7���	<��O��� ����&������o�V��?=�������]��������T���N��߂O�?���O	����H�@��Fqo�@�%B�?�������σ�� /��#�_�E*����O�������?
�N8����W�p�X�?�A�'� ���W�����a���]��?"0��� ������`�/ފ��[�������Aw.��Z�jK����B���,+��-e�2�9��~?3�y{��Zֻg?o����f?���|2�F����}��}K�������eV3J�}Q�Qg?�w��qy1�Ow�I��=7��n���\nt�θߪ-b^6�ɥ��)n�������{��e����Ϧ���B�'-:׏y��ׄ�����O�1�^:��r6���o�}��â�.re�뉕gI\qe-��C-ٱj�ڴ4;�D5��U8�x�4v�y_nnD���A��/���:��,q����-i�����e`���D!P�n����C��2����,����(8�	��	�?��'��Tm�������P�����������������������GV���I� 8����_o�����5��������M�Y�=~�����F�����q�����ƣ��~;�'ު��z��N��Ӏ>�*����J�A���k�%h�k��ôy��I�Z0k�1#)(��4q�o��۝*�`G�ns��m�ҳ����{\˖\<����L�j�ra>��Eu
c+���O��񿷌�^a�1�ɦt��	����i�^��&ֶ�f:_ZS�،bכ�$]9���3�ǋTge$^���I��Q�,2$��q�vd�����������Q����e|���!�� �����g^}��A�	8�4(!�qT�<q"�"Gr��d�b �������L�Lȇ#1�pF�����?���?~�����x��*�^�Q�y"�f��PJ��Z�j̩h-�d�M���G#wsb��S�Ϗ#ΓtsxQwGJ�5�����s�9���|�a� ;Z�%z�i�N��]�m��	�4��6����������:*���+��V
����������@�����0��7����C�W�2�;ڎ>8�z��'B�G�?������n��97ζǗ�O�0|W�I��
�}������M�)�sbV�i��g�%�	�O2�>m��ȭ]V�Қkw�.�"{cG�I������{���OC��"0������w|o�����_��_0��_0������V�O��́�C�[��+��/����%l�Te?>�'B�Qz���w���E%��K9z�����3���?s ���O�@���><�jU��h.�N���� �s�m��Д�N�e�r�����;̈^�QW�vat���j��Z�t-����`Nd=�	������ɻ�7簐�|�^$^X��<�w���K���{z��� g�P
K��%���|��;�Ҿܪ'I/�����"U�v��k"1Dўt������,5y�@p������FYy�x|�i�P&�O�?i �-�Q}d���k����.C�6��-%M�3��l�-?��G�.[t;r�,b�����2����[�Ŏ�5���T}|Y��~&�=h��������������>tx����V�������?P���_��}�����D�a��������	4��(����������j�?Q0�_H�%���A��H
�Qt̆�/�����ȋ1���4���H�bV�)��c��0p����>���>�_���u��4vCn��{��Ҁ�d���;��#��m��:\�����k�d�轋����n��G�-�T+��f�(�]�.�.I�s��_F<)ٕ��3�lY�!-u�Ub����%�u��������� �������W	|����f!��,�����C�"���S��#����U�?M���`���_���_(c*������?����V�կ�����ٵKTW���DH��r����e%�ߚ���='~�����3�߷R6��E1v���s��J��o�~7��yV��<�k��{�N���ymN������t�㑰�gSߔ͆�i�Y�'x�BmW02+��y��/ͤ0��ұd�I�j����۵m%�w�s+���P$���,s�߭�84�n�@��J�6�b}�xߕ�Ȗ>TGe3��	UO��`��_J�X��7^M�.v7�a1�NjTO���L~��ۗh���;_7
K�.1Y��O����Sd�2�m�����]���[h���+�n������_+��C#8n��?���i�������o����o�����8���2H`	�������P������#dp�����_Z��������_��[m����7	��?f�_Z������'�g �G�O��}�π�� ��?n���BՀ���W��p�wUT����b@�A�+�����$`����B@�A�+����/������C�������? �?�����n��)���]��?����ɐ
���s�?,����� �GF�c!�C��h��� �`����P��W��������X�?��+/�����"������H�����?���j����?"���	��W�����a��ϟ���?���������C�����������������Q����e|���!�� �����g^}��t��u5�|0#CAdHq&J�,d1�X������O�K�>%
�P��K>�r���������OA�_��{}ct����ԧ/��u�8��@�&Y��܀�$$i��bnӺ�.���t�Il7ǫ�i����Ά>�����r�pR3gh�w�pY6|U��#v���� Nv�^�>w����Zt3M��x3�n��.�~(׵����Z2^Ǌ5�Z�����EU��c���Y���T}+��?�Ձ��C�Oe`�����kX���	�A�!���_��B��ε�;(���#�Zg��E/*����٠z��"���%����=�+����ڀ>�F����3��I�>�|#��Թa����Q	�f9���My��[Z��лz\��i��fћ����������w��"����~���� �_0�U0��_0��_���Wm�<``���_�G���[���������S������q'N�8�J┿��kd���={����O��.X>������cv��a����vZJ{�u[�]��-�%"-؏S��Ea�5OT���y���c3�'�_�e�K����%�$��-�~w�ۙ��Ľ�'_��ێ��K�����aC),��Y8(��P��:y![ě�]ڗ[�$��v�4R�@���Ў�r��Hؓ.�v3�����@([��-���f�/4L&������ӈX�;go��R��Yz��*F1�F��[����*�E�Lo�]k����Y�g�'�����?���C^�^������_$|��}���_����#���b����o$|���i��xa�����ϒ����&���/��4����vz�*�������{�������=PU9�|��a٧���LR�hQ�҉�>c�U��@���?����P����m�|θi�_�R+]�=��jO)?��~�����9?�Г/5�"���-%yI]�o��[�򶵄��ڒ�@(I�%�j(_������:��a��(4�]-�WnO'z���u�7��NW3y6�œ�FB�em����,�S��)y����p�̪͛�����aK��d w�K��S*�)��O_ʹ��e-�d��~�5����#��<�>��������IU���`��g�)?��٦p����r��"�ϡv �>k���̉ݒ5E�S��wRWT��msNp>R\4��@�L�sO>�	vEs1�uk��(��+�{��G�s�$=�������±�v�UW�}�~/`�����?��"���x��a&R,�K3&����,J3������,XF����!�q Q~L�T����}��5���?$����Ofr�ˏF/VI�^t�����_��9�{�1�蹧�_�����_�
��rs+����|�����}G��#��� �G	̽���|�!�1(����?����������������\<uY�����օ���f�]������E�KC�^pO��[��x_�o�g��3��[������R�/���K��%�G|_��a��m9JI5ZW�vM�����!$�ǎOf$�)��&�`ڪ�k���<�eu�a�k��c�L���ɺ�NRc���~�{�~/i?�A���r�*r=I��YSG5A���v/���M�v>��鲔M�q�ON'�eٛ�{�ڬ��e��+��ԭ����!���U����������P�[�7l��;ќ��d'�Q�� ",e�1ךs,I��p�����0�rҎC�4����HG��Y�Z{�aA�j�͹�M���l�6��B!Q]n����{���]��G������T�B�O��N�].�X�,D2���+�1S�(W�j���.��q�P	�����J	��i|��?�Wz��������b�^{n4EJ�:�P�ƪ^<���ǪQ[������4��uْ��Ge���o��'�?0��%�Ky��ڻ��4���&����c.���5���WvH���60����8��]���*�����?h���NT���ns�h�F;�vv��������&'_�_��(���e���e_L�OD9��R�:=�±U][�M�M>o�~��B�2s�����e�
y\�r�N�.�)ť6^����,���>'�tZ�����po��N�CL�`�k�fծ���V-.�Nw�㓸���k�,�g���mW�n��Kt�b��t�j5������6����p^��o�lT?��,8����Mjcu;�l����Z��"3��u������p+�,^R�WV]�����l�MuW�'�!�F�R/ù'(}f� \ɔ����5�ڡ��kUdY�I撯9������P�Wl|�`8F�.�)+�_پ�O#����7����4�]��?������_���i�?$�������?�������O����O����V��c8��߷�����vH���.g�E�����0��
������������[���տ��K�א�����?�A��r��̕�;���t��*�z�� ��?{����㿩 +�O���w �?���O�W���SJȒ��"{ ��g����_p��4��_������C�����
������~��������T���������}�\�����?RB�*B�C.��+���t ��� ��� ��������= ��o������̐�_��������!��a�?���?���?d;����RA��/p,H���߷����7� �+��!�?+�"����� ��������\�?��������[� ���������y��~���)!�����Vf攪WH���Y!R7չY*S���\'i�4���H�`L��h�c�V?�_y��}�C�:x�wz�(�
uaz���k	l�kJ�q+��d%����O�#��IX�&cݮEӧ�A��%������Rm�N0�J8\�Y�k7y��&�Ճ�k�[qT��"Q��r��,��&��i��\!�=J�T��(�9�v,Qi�夙[����c�2o�z{PYbUOq�㽫�ʺ�s�<������������y��!��y����Y����00�V�_��!��?3��T�IH;��!��Ð����n��eY�i�gv���Y��%���e{�j�kM�7=l+���d��pt������RY�owL�V��m�����1����B��XJ��6�@={<��E>����f�,�]}��_�Q�B�E��e����/����/�����h���G�����/|���Q����_�e����F�ő#	\��~9�'N��{��*'r3	��%���f_�!/G�XLf��7�RF����k��X�F��N�L�#��Č��-`�97^%�da���1�Gl�+u�Ԯ�������PB}�U�m�%����|�"����G-�
���9K��^},S���֒��>j����@�b��#�77��:�+5�Kɇ��|r��D�X�=�Z��wq�+�bsoV�jW|�8���)5��0-���b�X��g��b�N�Y�h{Dj��@�Q[�0�];�l���k��ȃ��)��
o��? �9E������������C���#��ܨ�b���@j������	���?k������
�?d��IX�p� ��Ϝ���?0��
2����g�������������� O�.��#-��>�ǘ�I��H������x�ȅ��o����K��?X2S@���/��?d���?,��	r��������o�������C��� p�7>��7��~U��ҭ��#��T�Q��Ia�c����ڏ�Ð?S���~ ����4����}���o ���햜�_�r'\�1;���b��⢋T�9���5�j�1Y�֊��̜���,��=�(<�H6(���d-*�#{�()�E~���R��ܨ�U5�v8�vhJE~Td�P�6[V���T�o�1+O�'��ܮ�e��q\v&����z=±�1a����[�4����HG��Y�Z{�aA�j�͹�M���l�6��B!Q]n����{y?��0��2�/Ϻ-��߷�����f��?��Q�T��������� ��������+����������{^<릸K@���/�Oa��!G�� xk�"��������ZM��_�?*��^�Cv�Ry���As2����E���G�d]�'Z{}�[����R��G5 ��>� ���V��>�q�*a��rU�Q��(ʬ��MY����BcJ}#@9�o�x��M���,�l���C�DG�-��k���  I���@�"�?��El�cek\_��]\f��p1��vd�eFQ�Š�w[{��uy���ʺ%��J-4p�b���Y����tQ3'x�i��ˇ�?�\�?���/���
2��Ϻ%��߷�������%��4��'+$��%�4iUW+e՘�0�0)L�I�� �rŠp��T3MJ74�6*e������~��2���������t�3��03��nYkLgsBFv�-_�z�`2�s)ӰR���y,7�ﭢ����GV�;���Z�V�������������B��Q\��%t�p��k�,���t ;آN`���"�?�f�L��d���Α��������̐9�?-��Y7�]"��_v���7ޭ��B�:�¡s��KR/���o5B�Et���EN��^�?����p�%<ϫ����%W(���B���F�+��F����v���)Fؖ4�t��vV��;��U`N.I@��Z���������������
 g�\�A�Wf��/����/�����Y����y�U�����Ɖ���g�װu�����El1�[̽J���뿧����~� �,��������p���"�0^Q1���?�v��/m�UZx,�*�-�Y�	�4ݟ�{]j+���<Qj��{������ڶ�Ղ疧�e��<Ne�Z�I�q��*ף)�u�56J���E.j�_� �
�'��G�a�+�%7jJY�y=`msS
�	KSҮ�a�������*6� ��,ge�;��Bz*�>�[<�E��@��CN�ꦧԌ�'�<3�N��.h��Ǖ5;�́��d��o4����2�+aæ��x/�G�bk����·S�����/'����Mn����?�����������g�O�t��O���2�B�����(|x��{���8��Q��"��d�#/J;����θ�����>x��tVF����RA�?&p��.�v!�����ç����AKv��y[u]cu9���?m^�T?o����k�Z��~ڒ�����?yJB�q�C`�g|c���������$�<�o����9.���� +',l܂��AX0|��������*yb֪;���}���z�;~�����7���~���U�1�����Y�U��FA����o������T��o�������?��7�{�o���>���/�/���+�����^�y�*>+r����߅yLɳ~~������{}~��q����?�4;��a��h��Mhn�B���ʘ[�_8?9�pSx|���WW��o�s+�Ȏ9�߹��Z�U�d����g�	��Q��{��7�8��B{8���W��|��[k��?��ۛ���:�w$X��ս�՝���}=�����k0�g>���-�e<���r|A?��æp#��/������हQ#�Q����K'p�ϓ�U6���K�[��M<|v����	;�����w�vK������"�Z�]���y��/?)9�ݫf�\���[��&              �/��n	З � 
ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1.sh | bash"
  exit 1
fi
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

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f || echo 'All removed'

# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh

# Start all Docker containers.
docker-compose -p composer -f docker-compose-playground.yml up -d

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

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� T�8Y �]Ys�:�g�
j^��xߺ��F���6�`��R�ٌ���c Ig�tB:��[�/�$!�:���Q����u|���`�_>H�&�W�&���;|Aq�P�(����|���Ӝ��dk;�վ�S{;�^.�Z�?�#�'��v��^N�z/��˟�	��xM��)����!FW�/o����;����GI���_.����^q��:.�?�V������>[ǩ��@�\�$M����5|��/��t9��{Lĝ��^u�=��4������<��8^���k��P|������E0��pʦ\�Fi�Fi�uH��=�E(�GH�G}�"̵�"]E|¿�>k�U�9ʐ�i�Sċ�'���/>�}�!et������Ć��D^�ZO�M`���h�� ���@EYF�]6�/L�&����(ŵ`��l�ZЦ
3!���S>�A���U��,r�4A�8�:VblRzw��xn��E���uVz:��)K����ԍp7��A*�D������8�uY����G�D�ˁ/ԵoߠScEUx�1���M�K�������������?
����R�Q�˸:��N���=^��(�cO�?�T��<�����$�ڼ����7�n7�́P֔��'���e�ϚKq�"Zhsa���gݞ�	`ƅ����Y��i1o���h(ō :yNik�����֍��2ġ�i�<n��L���xYCrf�ԙsu0�O�m�w���q'�ǅ������b<j����)1�C�Aɕ��`!��C.��z�O�-A�(`~n�D�MSى�C�C�����������N���9�5�țr7�6�8Xs�*���f�b.�~�|������[K���
�4���6A(�(:�)( 2�T_#Bi���Ю/滑D���H���`��Ɗ�Q+S��_vЦ�6��0�Y�%C��#�w��f��9�[ݙ��\����� �������k�Q���N}��=/�����V�x.,)@�@�����u���(��EƤ����7+&@fK��(�t isy�1����R��(y��@����u��@.|[$�%���1�e�����}v�7��k�r�-'iKj����Ũ��,��Ez ǢϙE/�f�\�}X|`6<���,����i����x�������(���*��O�C	���2���������u�����Nݯv�zK qO��|h��x,fȑ8N�
��Q/!T�G��vB>$��N=��"��U�TA������^���i�$��h�o``a���x6ad1Ok�K��w��Dѭ\������5$B}ٚ8������ˇ��B�7�<6]�+�<s�y�i��}߁��{o��]~�-C��e[�*�ቪ{@k�(̶p-�#��4M93rր�6�����C�� �v~�d��Z.� ����>kr���r�Mwp�x/��-��))�D"�a�t�zr�a�:D��K}0�m�`B2���q���D���ϛX��X��P���o�m������}?��Z2��h�Y�!���:��x��_�������H���("��9�_���#T1\*�/��_�����������x9�!U��%�f�Oe���*�������O��$�^@�lqu�"���a��a���]sY��(?pQ2@1g=ҫ��.�!�W�����E������vO��M
Zy8�XOP�Yǳ�>Wx�qpa��Q��Ë�?k�؂m�
f�dܐ����[&_z˖2�'�!rXm|�1�>��:ݎ,h��ܘ��%���_�[P�	v��lO�*��������?d�_
>J���V��T���_��W���K�b�O���|���H�O�������L���7s(<:��P�қ�]���O������.:6K}o������`p�{�i2����U�>2�2<�$�zo*ͭ��3A>���w���]����t�x�͆�f2o�z�D���D!P����]�p�r'�v�ó@�D�s�m�ȸ��IG�^p ?G��qڠy��)�8�9@z��%�i�V��ڹN�M�|��6Y��.,����μ����´gOM��@�$0A����^��Y��h1	�x�� ��i��=SZ������SMG��v"FR>�9K����Ё��yW 'Y1�������)~I�f�V���F�O������+�����\{���ߵ�}����"h������B�/�b�����T�_���.���(��@
*(.U�_	���=�&�p�Q��Ѐ�	�`h׷4�0�u=7pqaX%a	�gQ�%Iʮ��~?�!������+��\��2aW�W���X�plNl����{���6[�A�z�^��C	��yܩ�JJ�E�Il/��j����hc7�1c���������<D i�l0h�C���<�甒S�ݬ��{7��8���Ï����Gi�Z�/o����w�����:��\(��ח)���t5�K�{�� ������r��8�V�/)����^,��5]��-���VL�'�?$MW�?e�S�?K#t�������6�26�R��Q��,��x4B��x���o���BQi(C���������j���q��O���>H-�j7���X&��\=V�k��������Հ&\xٮ��sX]W|.E�T�;��ͣ�L8�u>ʼf$���-�?����!�V�g"�	���� ����֫��w�#��K�A�a�T�������CI��G!xe���O���/��P&ʐ�+�z\���	�������>�y���;b%�A�*�5��`�����������п?�c�ㆹ�T��bxT�޺��p#s���s�֣s������{4��i�M;�L(�|�#�S:E_̋G�m;��~�ILW���	�<�-b�Zt3����������P�YOԉ5�����j�s�ފ���{�A3Q�t�r֓��ex�L>2�{Ġ��Ām���N��-���x�����E�ք~ހNQe�6�xN�/ݩ�۝�ؐ�����^��.uF$��m�,O7|���0�v�X���M�i����o�)��足��Y�9ˌ������mo9�� ����N�ʹ��\��ފ��>�[Z��>\d��BiH�?/�#��K���a��xe�������������9�����[���j�?��I�du�{)x�������q`�~��[����NS!�����������䙡��7P���F���>���my�@M�wM��-���� �B$�vr��))�ci�J�hl�F�˶���[��SS�m�ߚ���&4�T6c��ij]�r�
��H��'}5i�v��@���q6��K����>@ k��#'P#�ڬ��]z�M��J̳F��K]��O�\;|�՞ق%w��Z�o�~�;�F�&����-T�}z�x�ϳ���#��K�A\n�#4Y�������'��T�J�g��j����2�������V���Z�������j�����]��\l�cV}�s9�\��[w�?F!T�Y
*������?�����z��S}�[)���	��i�P��"Y�eh��(�	�	� �]�}�pȀ�� �}�r]�q�N���P��_��~t�IW�?����?@i��-'�}˜�1lv�C���s�`�����GڢEM^��c�9��v�u%���Qt/YS\��A@����X�%5�Zߺ�#j��������pF�ehr��Lo�W�(�M{h^��y/�؝�i1��$���}���{�|��8BPO�!�7��/[?�
-����e~���~���\9^j�id����d������b:��N�+���c���B��k��^$������2��s%��UM�.�7<�iv��]���^�᧧&q�ξ��/!���?�:�7����Z6�]�����Q;�w]�*R����t��^���о/t�+���������jWN������o��U��N]�����G��%��}}�S���rmO�~z���bT���]ePQ��V�9O��2�n�]4��� �~�UQ����7D�.��ߐ��ϋ��׾�WD���e�ZQI��`�;j���y�av}�(�΢г/7�˃����·��śWK���Q��l/V`t�7E�p�xV{����ǒ�LZ�����q��q����N��+��o?�M�v�����U������g�����@.*�=,��SS�8�O��7M���8Y�a���	��.Nד�s]��L�GR��j�h�B"GE��H	����}7@���?���Y����?V��Wtñ�E��������w�F���Y��{�@�Uő�m�n��ɦR��וU��f9�}�axgkxk�p�Y���k�q�:϶c�����H����]���Huo�1%Q��(�.��v��(J�D����7pZ (�� -
�5H�&��h�ڠ}h����C�@Ф���hZ�>�=��8��F3�Y���0C���������cבԶ2.�Z�=
�-���M~�&��A����5�	-Q��U�!xH&B�����W��9Q��L&�w;��)Hۢr���ޓ��ŉ����	2n6ݑ�+�I��n�W�P@��d\����<�x&ck*gI
�:�H�2��9�*	���S8U��Ch�`l+U�C�P0I�")@0�T� �\0�S���E#���ISWնxp��m�$T8���A���&1P�H2��y�B6�L�h 97�����t���nR��J`"l�^�o�����YM�O��A�7�"�hJ���B|z���J��%���pmN�(�B7+g�(C�⋵)��֦�t�GV�.Rh��?�:]�R��:=�:�̨S��A�:O�NG/t��hͩu�|�:��HŎ�o�fP���X����|��U���N����g�q,+��/|��$�$T�:+���f6��	�l��"�ޓ%8Vl�NP ��������xH��4E�SX�o�, a�ɰ�낡h6�
�����g��r����A*��-���v��n�-퀲y�j� ��j��*@83D�ؕ����hr�ޜ�6���:� �]��,P7���ls�ܝzwk� @�AOj���3T@:�AHc���,�5:Ѓ�\�&���f�4a\��2w��u?���a&3"��� 1���%�z��_\��~D}������
Ȋ:|5�Ԍ��x�Ѷ8C���^[���a������������:�Nbj����Z�?����+�s
�b���4�YG,�c���t,�c�cN�))C�誈뫜,2�H1M*Bs"�U�J�0V����{��L���p�K��p��������1rEꉤ +l�Tyh��Z��z[�­��x��t���K����̋�2���c�fJ�@�`=^�c���\K�r�c:;��U_%k�6��@��X�Ѝ/}��� �61^�lE��0[B�]�*�0�îh�Me���0}���l�9�����\SFo��U��|�O
2�TF�+ �2xѼ~�L3!�$�>��8�a��$r/�}Fa�����{�oM�݋�?����v��`q���{Na\��#�f��"�V�^� <����Lr?�n:nݵa/ٰ�W�v�����h#�})E�0G������t����8В��������O��i��s	����a.�gd�,' �����?�{�q�u��9����2ܘp�D��b�f��C�,�\���h ��6��Y@���uN��?+s�ʍL7���i4������������s���/�(�%򏻜�i�n���'&��	Rz]`�(0�k�J24�Ӗ}� K���XXfʚ�4ۑe���J� 9)�F��ۙ@:�����M��a{�X�HwD:}_�rg���5X$���Ķ�ؕ;Ǝ���D����]��uXT1�&	0^�:�©�`��tZ0�����
6�᠁p�/��4A�p%�ڕ�O��U~^y3Y2��m�X\�	�ye��؋
:���4S���7p�^�$"s7���M��έ�+�W(���͛ؕ���2vE�[��Q)�����b	I�L�ʜl�^�꼮��`��2l�%�n�	�YM�h�8���m�- �m��l�� 6G�O����X}���p{������_�p��e���`��p������s	����,
/���M��p��_�n����1
��`YQ1N�%��-� �A����L�F���u������� H?S�4����o�E�3*��ku+�� V�!�6��i��my�������gG |���q��4�����k���?\�u8	�h��y�U�O%�{�!�S�������|G38C�� l##g1{��K��?�jY$��'�w��G�r�:l�R�sA�W�O�(�L�=^�9�;���{���%|t�ٰmSڞ���r-���c����Ƀ
����p��ԓ�2 -�\�^�r��}��u��h�m�6�eK�ֈ'6��_�9��<�#�`���X�c�3!���'_^"���u8�;=��:,�﹄�>��/�'����0n��\5�1�i��"�����xQ�i��zC*X�Ή�i�gd�E_­t�#m�_��M_�-���wE��¯�tm�W�8}��xmg����>���#EF��1�%a���	���;ج�H4ɶ�>,ͮ���+�Ҳ4`̭�a��a� �Ⱦ>QC�Ө��l��d�U-�#�9Qx|i��c0���}{�ÞkW��rq�<V�����{���'����{�<4��p�w������vA�����S@~G� ���6.�}������3{����x@1��������0x�Mx�^/����G�0nW�S�B˽�S�]�g],���.Ő���]�ϫ�?��_�����T3��Н�+��߸���
���N9�t�1�/lȣ�A����A��E���Ɵ<�|
>����ϡ�xn��>��R#?��4�_j�7k3�cw��z��<�~9ً���e{t#ڣ��^^⭽�M�k������ 9uP�_��t�?��'k�yx><;�tDI̗邂�����7��͠�lwF%g�3���#�~&�t��|X�-��)6��Zy<vP�z�M�'��s��AiPt(W�_��k�G��P=�o異4Y�����fJ��'���P �4;��O�1_�HW푞��p�4���>-�h/U��9"�G��ch�
9j$M���@�Pf��A��in�j�PB(�\|#���j�f1W�*Ȱ�Wk�Z�5p���b�%��"�Y1����;&��I��Q�Ƞ]*u����MX�MX�MXǹ	��R[B;R�RC*M���������Ȋ�p%��h� Y�!��*�u�d���#i��;I?sWIG<��I
e5�S.���d�+q��mo)?��5�+6{5Z�w"T�P�l�I�B�S��4k(5��x��gO�v?����]\�>�Y��'hŊ�hV�޴�Dg�@q�R:D���|���{�p����)igR�4[�4��k�e��V�ߠˉx> �H&E:A�ח
S��Y�3b��1�eי���B�P���rLB��3�d��TnX�s�^�(xS��r�N`Xfp�_	�(_aO��b�|<Vw0���ڃ*�*�Vc2%�9� ��4�߫"1��=����f�"��]�,�E=�>��C��Ei1�H;���gwt�)��-�N����¾� �&��]�/ǒaދ�R�\/_M:=�D��V��vo�%:�Y�s��4�4��,"��R1�ܭ�9"rz����8�:���Pi��>���Ns�H懊oG��v� �쫉a�Te�M��pRxTh	DJ8Wc���� L�	y�$!Iw8��HgJl
�a�)�	څ̒
n��C����22ߧkE�f�{�,�+x�f�	���ل�����]CR�fS�<�d_iɬrW�����d�)��A��J:��Q�b�0���,�v<̶q��g`)6y4/�*'+��sk��z�h큍'�O�O��H.�xB_F1@���8���q��*���+d��<�i?��ux��Qѧ�G�G�nGK1I^@�Ќ���>I���4��$ɲ\[%A����nSHs�*��ڛ���e�x ��D��dm]G/ +� �$6�1�4~ȡ�A/�!�o��]��[oaf5mf�\B�X���~�?dҼ�<釆�#����g���cfw��g6�Ic����t��^E.��6h=�w��?@�aE;������K2<<[Am�%A�l��_���_��էt����џ����~��5)�&Ǟ��t����M���-��F��������Huw]��C-�)ن�F���ǻ0�����,2��ӱ�3�0����b�����>���ľ3ԉR�R̻L!�(��c�N��Ʒ>��Р�@�/�ù�U@�Y���4`I�Xt�9��F��(��w�A��<����4ƁƨT��4Ƌ5&T��[6�A&"�%�����alSh�!��b�m_�v�Dj�
v�D�;�q<��H?���Xw-�ux���b��p�l�I�-z���B�.����<@=�o7�=�"��A2쯥�3i��HxB4�ٽ�HpQ*���'��N �t�3�ၯ�h����N���T3�I�B�4��a�t ���=t�m�.���E��ud�3�57���2$:;\?֋��b]��p9���6�>���y�.QY����z�(g?R8l�pX�a	��8DI/����c��"�C0�1�Lǌ�����, |f,���E3�!�!,�R��\��k�gb��_;a9�aY��O�%���Hf�8�4�T%�����&S����|3���G�	�<X��$��(BNEF6�F�Q��(2^�1�ꏏ�Q�2mA&�!)��N��{�x=�8�G�uuOaeѱ����v�����H��Րx��ٛA%�tuHI��������=�EkT$?n��� �Cm!�|���#�n����<Slqj�u��;D,���#�D������)$b�B@7��^�TW��'��W��^�Lr�?_��l*���وמ�]ٕ�����Į@���Ʉ8��(�n�t��b�F�	²����M8VB?�I�߱@�seP6���c��af��B���vAFe"�R��ZF�;�ڑ5k��������a�$+�SN��$�����I~Y7%���Po�(��\�DH��s��c��3vTX$����0w1=�~�տ�`W���?��?������>�+����?�"����DFk���{��f�ɰ���ܛ��c��'��������������ӟݢ�������/�O]|=���������_O�Q�ϯ>��A�V��8�E�Y{�����|E/�]W�u�|�@/�$��~��;����3o�\�3ps��o��7�ǐ�c�?��s����`ҵ�G�k���i�vZn�����i��~�Wq-��e��\;-�N˵��lf�(�v��oy���/��Ty7P/r) M���	��)���9��"��c��[��1t���?N9��U��1ׄwQ����u�����j-�Z~�pX�q��N�#y���pf0���c�l!-kόem����?{Wڜ:�e��~㚈�(�־9�M��;����ʎ@����#��`���YR��x6N��"����rl ����8@�`��'��~bL;s~���pW�}t���.���9���C����?������������O!��7A�Hp�+�SX��X��ԯدT��f8�P*�)�}x�_x����O���.�5��ߝx��湧|E��C����ፁ�������	��0l��}�r��,�/���N��!w�z�@w�\���]�[�j8����6��nfL��랣3
�⚢�*��&e*�К����c8�隩�(°J",¨,b"���4K�����h%�������5#�`i��(��`�^�\�ŷP��M8���)��G��.�w0<���~-y�?,8;��W]����N�z���W�V�.�u����b�+=��FS,s�P��]������Ԑ�f�"�����Y�t���/���e+<W��I��<q�n�@R��&��%����Ɠ�7���W%<��պ��Mɢ�=O�;��`�Q-��g��o?l���|Z�Ri�\��?�~�rh����� fP��?��bcǱ���g�#��{��}
�f.ܳf�ۇ[�{���P�A.4��R;��q�&���$�D[8o��
z�-vI��s ��|���^H�F�Ɇ�|��K�p�k�7�J|�.>�yN*�A|;"�j��#��9�[;���n��e��ՊTn�XL�{�����Kņ��tg�9�=��*���o��_�����J�~ض����x',�C"��|���rU���L�{�n�U��T��J"緶��cO�ے�k ������e�tȺ7oz��N��\�t������N�(荛ψ���r�y�3'��Kx$�i�ǖ�����L'��,�8>���{�����������LJq�(!��]w��uӯ��ݮJ�������~��Y�*|����J���C~[h>T�E�o9?���n��b��E�;��P�i�{{-��%��Q�8gB��J��A�7Z��i#��������sc0��e'LC7f�Tw�|���VԎM�����ͦ�8$�l���)�:}�&@��N?G���2�t��%:�l���f"������4>|����?$F���_,���y!���N��~z���9����Q�����v�Aח?�WP�Q�����dM{����O�h�/,����O���B�-U���9���m�rߊ���S|u�?5���� /E���}g�H���9�����@��?2֎k���������������b��5L�5�u�J#��i��X�$\�X���TԠ)��4E�)RCQ� �'�*�7CT����_�I�����k$8�5%�B�K����bw�w*��\M%	�VN?=n,���]sޱ񚹬��]��2���i��u�
��X��P�q��@�Κ���%i�8j�kE'UD&����h��,�0�/�H��[�$�eg��At��4ސiI�2�1Q�=mB���h��+_#�N(����4v�����������`9��yB�������'��1���#i����϶Vŝ�	��P�����_ �@5�f\R͈�eF�$�(�������@��_pp����o�/	�������H����1�ؐ�����������bp��:y�'/�t��勫�z���K���(>}�7�k�ɳ���'�^����>�V;xui-gG��u�L��!��fˡk��_ΖCg��Jy �8O腮z5��p�"�C/���B�&o=r'q�V6���8����e��[��a��y������f���TG�dV�܀*^�V|���kR�:�,�~�^V��q^��zj3��YjpCEa6mH�q�f�$K�H��Fc�N��6�t����Y�(3��롔���Zd�H�ć��þ���I��P���"A���� �?Y ��������z����	��Q ���IA"�0���?�����w< 	����Q�(����o�/��?bC���?���������b�Ҡh'Q��MJa�ߪ�S$��W���@XĤq��4V�0�05�4Q���:���������q��_����c��5^�Scu�<uJzWhd-��m4n,��z���+5�ܲ�5�D�1'����d��>-������FVm�&�7i{��Bkn���#�0��\fe�ł��Tg����TR=���Y$����!���$�������ć��,J����?1�������� ����?���4 ��{�I�������p0������1������U
�%�@(L�]�C}�����o�����%t�_���P��\3��v�&e�3P�d�2�q�_ax�����Av���6W�7��i��JMH�Y��D�}�Ӟ�WVJ|S�W���iX\>K!�5��v8��9J�ϋȳp�Э�1��.wF�E��}g8o���u3P����.���
�H'p�vl@7��Bw�V������j�g%�h� J�L���FՌ1����E��%N�d���Mr��T��衝���и�c��[*p�ŪV�*C�ЭU:�z���v�T1�g�$�u�LW��N1W�Ȉ'pRgs�n�����$�@�#>Dk���������K��������� �?���`�������;�u��){7�z��h
��Q 	�?��_�����xDQ����)� � �?�����}��$�qa�/�(����(��k������A�Ck�b���ᬦk����(���������,IR
P��rDQ�����?� `�E�+�?�L�"����,w���v_�1n�Pu5;������T�1)����HC�yV)M�6���j�ɲo)S�q��`]@j���ÚK��-[Z���P�* �̈́Cr<k�
ރ��w���Q�G�VC���i���oٺa����i\?���8��_Q�ρ[��������`������	����>�%	E�=�H�����#�OS`�wL����w�q	 ���q�?�\X��?"A�����������8z6��?#B2����E#LSUE!5F�X
�0
�5�e1E�L�F\�47q�`LS5�aLQ��u�>��������
R7צ���L���j��E̞p���2iK��H5<����y�&4xZL׵yFe�u���h��#fF��P�(i~�������j�k@0b�\Ts+DX�ӎ�ׄ�Z7j����J��~I��1�l�I��"A��?8"v ��{�������1!)�t��	��P�|������	���U���~�W�+m��d��.c�,��f{���b�֣�"��!�q(��K;���P�(*
\c�j��~̵�ϛ�j���o�r�ڤ>�&�5��Y�YY�7�FD������⇭���<�ar���7\a�P�	q�vS�˞���&��L�>�f�v�N�}����\x-/zh��@���B_��gV^BG�V<~�훉-9#�yĭ䒟#�+�������"��rCi.z�7��DG��y�IOpK��LJ3�3n����Q�C�^٩g�%���)�W������j�cuiCwpE�;�x��V#:���v�Z(��2��|��~�|]��m�!�<,��*��>SnL�A�����i�¨R�oL�KgK�\Vǳ|�H�	D�9!#r��B�h^Y�e�ϯ)�0Q�ei�}t��:uxJ��KcP�['��5gB���J��vɬf�,MV��P1�մ;O��N�q,粭�,�������8�����m�%�����?b$��/\� Q ����������H�1���A���a��u��^eۥ�L�2�3���O�98�|��Q>�O����Gu`^��@��8�����_M|1lq�o�1k.���f�ٵ�]�YqE��Su�^-��*r�lEe��a9ú�>Cu�23G��*NyM��Q7Kf��Y�<˽w��@����u��k��Sw�C���k�;�Y��݅+�
��n�n(s�5rr��([��ƀ��^���CE�J%r����Q��j)�S�f����ZO��f�s����D�ȅ�?`�g$����A���o�/��_����"A"�L�ǆD��`�?6��0�������W�p
���?N����@��>[��"B�X�	F����S4��#�������k�'���p�W\���'tB�iCI�bT�d	���H� p�DM��p7PB%M֠L�0J�0Ue0�񕈢�߱�.������z\���ɅvV�f�u�=h[p�����Z�[����y�ڸ@�_��h�&#�*�E�d�\eE�ՙKe�̙ĺ���R�7�����^j�*� ��ѫB�L�����5��P��i�i��U���Ňۿm(���X�j[�`l�9��������Q�m�$���o��G�_�VSXU�>��W7eMS��vܔaۖ�{jf�nJ�S~/0Q��s9���5�dOR����_�n�E}��Ђ��v��(�Z��Q���ݎ���V� �m%K)���RϏJ�MF��N��>�$�)n��H��l�?���W5���R>n��̸�O݄�n~�����C|���Y�㛔�gϴ{[�2�[�{O#$r��3����34%|���^F%���*������)�`�ḭz��d��|��Xӷn�o������Rצ��{�O~mi+�FP_�{��|E�|Q��9����A��z����ęIBp%0Q�Fu����~Pns0	��dq0]Z#��"�_�����Z�J���b�����=U��m��8)�0��Z��L�N�}#u|W6����CR��OMS͸�ʾ��;��O˴~x�GI���1�0��*�-=^�Ƈ˟��������D�o]��k�X�����ۗ?��`�?�����;�۩�z�=��5?��{����{�I��b�^��������$�+�x�gg���߳�:�~��k�1�3m������ꮮ�G���HQ� �P@�D��� �D�~ �RD2�GH�G��zM�c�٬-�Z�����s�=��s�=�Խ���pTԠX�(q}]��a�<R�[�5;���g;=Ɒ_7=�,�F���S��W��O��]���Ū��U ��c�!|؝|�u���)�2�Pg��O��� @x�����W_������ʟ?�~���ۯ5��/�x�;�v��h��v8��E�A���P�@3�nC+	�� &� ��A� �b�p����������~�v�w�o~���=��?�<��,�N9�t��Y��֑���B�p���b��}��?z	�8�}�%��_B�������E�(ݍ��2�/j���Mva3ٵ�͍F���/Α�t�.��(�͌��ި ?�Ӟ��Ϻdݾ>��ɹU����g~�F*C@�N�B��ho?V܌�Mܗ)4|u�Y�ӱq%����zJ�m��%����u"{�G��H�L�k����&������T��n�l�y�{&O�E�Y�4t�&���S�G�8Ag#��|O�"����|T?>3*�i/�E�8����+��d<��6�Xo��6\�Ze�\��[ȴ���[L�R�ق�{(Ib��jqf'�J{�v�Y2���g-�߸欄;+��J�EV��o�ka�qha�gZ��4QΓ��f�TM�o��HeB�	��8�!��e,�n;N�1���enPM��(��Io��S)�M%��l�ݜ���6�������JX�ؼ���?٩$�՞/Q+�I�(�.gY���Z*��^�(R�+�
L_��s�3��aE,+��6���?��= �.%e��Ĳ�K%�{�T��pr��$2��e����L`:���~!��7�zL���J��u�p��J|�xH�R�����*���I�M6s�#Zʊ�t�z4^.զ,Qk�b��p�҉ZT�M�!�[�Z"r�'t��h=��x��Je��I�7�����k��M���6����R���ނ�����*,i)@�Cc94M��!��uJ�ٗ#ܫ��b5�����Єe2m����8�KD�l1Ņ��~�Q��E_(S��� F���d�	�x�������%�ό�R� w[t͟L�����	�/L}EV����f=�Ã2�d}*Gv�9H��G�Ja�j��\�>��D����X�]NX�"�g&)2�v"R�J{�r�A��a���=UXJ�M<8E��.%q�<{(�x~4��Ga��b�~�Z���	0t�H�����Q(V�}�Vb|-�w�N�Z�P�1)���W:KX�������b>��5n�-������0���їVC��������֞A?a�J[��q��F1 �[�U�{����U��u���>�|"J)t.����>�>�<�z���
�L��q��'�=A�G�C�%i�($���^F���1�2#+����芭��c�	#Ȫ\�t��<!��h��#�5j*ܔA?��XAV�z�[�ͷ�¬f�[̹�>��q1�>n��F���"ݫQ<��(G?�>��[�a�g�͂1�a�^<��[�r0 ��+|��]V�0,�mt�  ��=�����7yE��_���ꯄ-�|�9=���U�G�迭��s&Τ�������Ǌ��cy!t+�a���Ԅ�p7�[]�x�}��Y���-q���%����m:����p �p�pn�1��@���I�yv�l
�uF��{��(0�D?���pu���{�dP
P�A$E�;Ci'�:ؕ��4&�t�H!�xw����l!���J�58��n�(Ӈ���4�ʓM��>@;t�=D�Lp>N��lޓFo�ʓ̓ڐ=ʚ��$2��#RQci_0WIO�"moW(L#���,�2j)���Z��P�i�iP�;"I%��{io�ەC�Zos:��S��Ì��:�n2KH5��n��H����F�*�"`\��Q9��g*Ǻ��r8�q��=�^A?��Oٜ��2{	�g�`	���\� �[���V�����|�zX���j��W��ճ=,�#�H���H�E��-8B��"��],��� 5�,��78r2X�X�ɩV�K2�Ń"�LPČ� W��T!zP�N�M����0�t{Wd6R���B��78�u��(?���{$�Q�dZ�;D)q4P�xt�SK7�����a���/���8�&&�q(���x"�a�=2A.9�����fG��!aSu�g�t���U6�'��B}�~f0����+����Q|)6����A~�E1ZoLS^�Z*�q5�K`ɷv���y�KL�Na�'�}/�ߤ�����Hz��a�=sk�{X�r8���M9.���f#~r�|�v�fJ\ �u����lk��Z�.N)T��;��VI�UҢ�+��gm�FD�l�$F�p�Y�i#�ҫ�NZැU)ɳ"hB����
r��&}���^�+�,�Q!I�?�@G?f��ۈ����/����w^|�����������_z�_���Ϣ����ƪ��;�͹f�+�*#Q�X�c��	5�:�������|'��\����o�ß�����?��_D���Z���~��}�k�Z����z�����;9$������+��ހ��t������7����>��/�����ϭ�kd>�������?�"�g�̢�dK���:��lj����N'��I�t��4'��Y�����:i' ��v:��Nj��9>�G!������0��%�*/�Fn�`�a6�@�����P��CH}h�և�j�����Ͽ���oKMxu����3p�R��T'��QG9>�<�+�H^!k�Q$3X�����lN�of�h��͌�Y��Y��͌��r<�of���>�y_��~�a�K��.����M}�ɜ+��b�
�1��s}�+�vEN�6� �^ %���O�����?á����(.�6���r�2��Th��+=9�h��x��Հh�c|/� �ƫ����DT�>5�Q�T�88�6�g��a����spO{l̦V���q8ĦBpx� �j�1J���;x4y(�X�(�8���x.K*�m@�Q`_��Y��.��ۜ`��D�d��%�b%�SDH�X8`��0Yl+#Jb ����2�/�<�j; �%`�d�Tֱ(Y�T� �z��.�W�:Y.��j&Q��e,V,�3�L� ~%1�p�e3��� n�z�� �Lr�iil�0�	��򀡹6G��	�J�Ɗ@��"l�H}N�=*[��9E?�i�]�"A\�k�53�]���
�c�L��]��|7�@/����滶lӖ�sԭ`���3>l��GF+�i�3�u�E��Y$D>
J�@�3�@����V���.c Ŵr0oz�q\fu�m'J�0TY�EPy^�Y?�Z3O*��I��hgb����&�;2��Iæh�����YV�@��e������ɀܪ�|�@i �Fz*��j�R��>�-y���_�K��Ϲ6�;X��e �ژ[G�a?��P�VLۉ>	��J���~� ��E�����+GE�������<��"+C� 0��f���4%Ў_��;�@�A���g�
/M�E�.i�T�#@����0
4O�e�ܵ>�okOk��7��kJ��؛�09V������<	���{��s;�hj�V�'��t�E7�0ʇX ЙnW��y�� �A�*����_��g�lIlD���,f$�0�?������c�'��8k�A����0D�yπ� -��mP`@.
�U�*��"������9��4����Δi�y  n�Ж��D�����)�'Uã(�nE�vT�=��7<�fP"Lj�[eϰC��x s����L�T��Z�xs�	�\��c��XJ��e~�^@��a����$q-����KwL�����u��̓��:��Ms����	;K|t�a�~_	�\�as��C�i�o�(O�O���#(����ؘ�', �{80��m0�E��޽{�w�,�(��벒h��: �]��i�p��g�����2���rgQ:�v�O���\��Y˅Ӽ���~I�s�&�]��ӄ�/����ԷK�,��Eszd�f���S8�L~fk;�ul�@}�҆BPG�iS*�d���TF;�}B�;�'��9i�!�ۭ�j��\����e��u�Y��L���	�i�_ǲ?[�E*(>YF��Ϩ�4t���ɛ`� �<�!�=|åax�嚣��@js�f:��kW���H�S��M��[U�dJs2q��f˪l�8�;F�$��c���fQm�q�uG'c�V��Ϭ-�(�vwƠ��A[���y��8^�0�1�XKe���,�;�����#+�~���x��q�8��[��U�(�`�	�J^�z}* Ƥ�8���B?��'V�X�ÊX�M�_麶0��Ň���u�}��-���� �c���IQemT�y�������Q3�5�:���7�;�#��=����=����EԎ�'8)A���'A�t!2h��S��z����}��e��,��}P��y}&+�3�T��p�[�}�#0¢�`'�M��9�N�r�MBc�1;��xw>(���l��1�s��P8���9��>�ˉ�:�ߟ,�{��63zt�(.�
0L��.�R�8�~xn��i�2�C�H��|^�B�a׾�R�M��ԓ(�}pi�t\�~�(�2�p�%�U]������] C�9��:H���`j1��OӜ&urff3OY���.\�p��"���zgR����RR��3���5��by�����M�� �' ��I��� %q`�G�f�V��0����.y�f�@�Ȃ�I��L\;�y�6�0{�ب�vJՃ��A[�VS(� R8���!�-}	i�)݂1�u�!��lL�[�v��URM��&��'�k-o�t��v�*?�i���FF��u/k8ˋM��!{���S5��m�*魛�I�%�����r��v~�X4�C���f,�&��Q˽��͗>	�2c`� �sd�ϵЏ��W�_�-\�\R���D�vp��U���^*@z�B��h�� &M
 �p�^�Z�^0n��P�<#OZ0�H���2���Ezn�fc@�l�NP��3�g�9��5���q�5@���x�-,
����26?}�|ŀ4�V,P[�T�7A��X,��r�e�+/j�P^��/�����w忉#mz~�_���oz6���!���07$d�Z��60 ���Ue̑�$�1���(���rO�G�[�΂f�|��q��Bq��~�q��E��\͡�]?�rݓrb 
��ס%���Cx�jJמ�n�����/P�#��{����'64��Jg?� +0C�sa@v�Ke�O���E�k�1��?���[AwG-	4{�tpѷi]v� /+�3K���i�
{�8�:+��T�P���b��:��%@+s��3^y�mNHx���;�L㻥���WԪ��A�]*hFkq����*�n�P,�?��u���ٶ��B��N��;����vL(f/�;<���D����v��h�z��[�{�!��B�s���BUr�H�X�Ј��W��n������^�~.�?/-϶��)��͝�%�2o{挷�:\XEg^��[�.�U��R���ppe6�� ��ݯVI���0�Sz�^h6<��@�!JɳZ��xW�U�֡c����jkDu�>6�0殛ϝ6���=�E[f�H���HTR἟�r�33�ŉ�f:ߩ|�X����#[�DV�+������O�����D&�L� �	�X�eϑ���1�x����V���b�^���K2��?�c��/
��_~1���`�!R��X�ЀKT$�람�[@;���0��7��E}3h�~g��T�%�c�\GB���ǳ�/������dA�#�6��|���QR��@lo�U�K�ߛ��%-�����&�O��������W�<�0������N`8y�r>8����v*'>B1A���n�;�!��u��������=���Ѓ:�����<É�_?t��'Gr�M�1���@vǳJM��=zI}m�@z������Gt���G��%�V��̀jh�m�<!�	]#4�G|<��V	gd�g:����Oo�Ɩ���K]����.E
���oG����(�W�^���J�����U���pv�yu��Wo�B���oֺLf��Z@q��fl[s)�>`����1DJM�Cb�z$J�������z��$�?��m�}�;����d�}�
��p����cb����W��d���ϠA��	s0�z2��{��h�53�cX���
Yۂf"��;������"���~��$	d�w������ZI�֒�ό��f����2@,v��K��u�+'}�R�w����k��u���q�H%���+�\4�W�O�[���sH�����֬�q����c�N�7�Js6Vm����[;��0(�S���"����z����6�`I�/n�]����!A����/�j��T�]ِ����p�ρ ���C�|����
}�&k��������
�0�xrE�>\&	��G*Mkq"1�/�'��}L_����~�]�D\I�\�4�m�>��/�['<*�b'��`��)A9P�-�8a���\�a��>�Κ�BDA�!�+�@k>۝�(r�����'�9#�Ő�r��5�xz�ڷD�r�	nr?���e�;<�R/�B��
G�f*�3��3���xf�3���@�������=�Oof`^z��8+���kv�۷�����u~+>)'V��p���N�Yw�-ζ>zȄ�1.�z0̐�q*�q�2?�/7<��д���6�x�z���NB����0���ȃ��TL����~^�/�CX��X��8	��E�N�%���i������*`.W�ܟ���`�+	���	ǿ�4D��i0~�C��mk�5�|��� U�E	�1��5�1}���$�l��.H��+��l��ڼ�dv��-� H�O�O�"ù	�:,�mvf"�������2�Y.����4��(�+3�Y���ǂ������g��$�l�td�K�ϊ�8����K����pz�k(E���#�]��1��N9)��ڱ>{����F*p|<�r���N��3���!|&�z7PGs�*4H���N(�Z��6 �$��t��5��b��_���G�I)������RA�Q����X/��
N=ı���;@v	�qY�O�F�_Ήg��࢙�Ќ�,p���5��G5v�[_��v�����?Q^����,������3Kr$��s4�[����������/Ë<�����n�(��0y���i��q�G��ldH����!q�G���}��|XϿ{��O �����_�⨓�@RGR�%�T����|��������OhK�_#.bD�(�����c�� ������������X����?���H��y���y��Q�f�ϓ�F��FҺ�3��i)��y�⹌ʦF�2$�$���sl��U�X��H#e���Q��S!*�y�I2,u��8�W$��%��m!�hI=�#&*b�?;��儦(Jim��ݬ���ܮ?X>�Ls�iR�<�{�dz�ͫ�qζBG ��'���7���<V�����Gɪ4}����MQf��S��s'��鎱3��x�)�w��+]�0�Tsזf{�N��f�J���]#�����G/|ƭ+:����O�������z�G��Q�o��X�����������	n����o��üu]|F�@��R}��4��� >5���OM�vj�Gf4���G�̥����_�Z�s�C���X����_���/��<��?
܎�O�c��������X��?���	��U3��[Bm��C�T��v��b�I�VC���a_�X��~BB�)��5��-
5qM�~�B-D�%������"�+ӵ|A׀�/��v�&�mn/���a���-�%Dτ!��"��.���N5g#��w�W]��L[��H5k��m���W,�X�,���SWt�%��rB�P�y�����[����r��]���rQp�C��7�f)��ya�8��֗�M��ȝ"!4���n	nX��ɂ�V\��$�k��%���~�S�@���A��&�D]c�6Wn�r�1�w���h�w�|�ܖ ���,�*5�����=B��l-�f�ϐ5wZ����*��T��_I��|Z��iv,�v鮹?.�T%�l*'>.VC����爃�G�W���X��Q����X��	�����8�?M]����D��c�<���o����������8�8�����Ga�?f�����D�X�?��q3D��8�G�+��������?n���?kp��a):�8%���c3�5��9e�"3�g�4�eT�持F��晌��8��/A�8�����JC�� ���=_�;U��og�]A(�d��������?VRg#l*��$5z.J�R��ۤݹ>/ˏw��#�_���ڛ�"����S��	SzڙR�9��[cU)��� ��\R�C�㽈�����Q��8�G�����=�ǁ�q������� � 1�����������������_���/`��s�q���v���\�6�!�?��q3�.�����7&*ǘ�j� 9ZnLV�@���w'�X���X��c�����}���P�+M�+P�f�ZN�䨞����1.L���*�}N���V�LV�ԗl��zl�7��>�r�U�t́a	�G�,�Fἕ,r�hY�h�E�#����j�5�"��$P}�e׋����D��-�[y��xC$W��g��r^s��BmT\u8ʬA��ܦ��Xb�%�4�v˹광5�O��29�4Ú$�a,
f��T;�27}�ݙ�13�fU-���Y�+��o֟��aN*U{5;����͂�$e�rAw*ŖP ��#�b��������������p��x���[������í�;��X����3`�?��c���|$�k���]��S��#A���v������#�����a����,�c�����q���ԕ����	>x���
�2��Qj����RSi^3�5�i&���@c(2�IQ,�!�j�������r
������� �]��A3X��o��QK�bn�\�����)�t]���g]-,�2�o��i��_��A�ȶ:t��/��c��=�����������d�Y3]���+ڦ�5��H�y��7����e�Qώ���1�r��m�������oٺa�S�i����R$��F��i��E������#A������?���x�_,E����Y����#�O��9��<��H!��.�?�q7���7����o�3ܘ��q7F���h�G�0�<���u�����E����'���ЩA�VUEa���e8J�9R�R����@���iڀ0�Tz0P%��v�Q����^������-�y7��"5\�9q�m�w�
m�B�ں�;K���e�����.�Ғ��]K[f�L�%Y�j�y���S�8����%S�7j�oIҰ�dE-n���v�L3_S[F�����Dia������.��<>�)�x���A�X����,�����?7B|�?t��1���{����p��H��_��K���ZBu�ZJ֠�O�T?/tz������������X%���zˆ*�$�b^h{X���={�㦪�+�MU��f�f�����*�(�䶶�r^e��/(��\���pM.����P�2�wa���-���l��.��������Ts6�[}� �{%ѥ:��԰5/�T����چ�.�W2�+g%TG�V�����O
�������D�jm��Z�"�O=i}�d;w&c��I:��H�(�W�ڨ�է�'.�֜V��$7�4�r�I���	���fti�?1��|������bD� ������� �C7;������Z��l\i��rnZ$Ю�as��ek��6.����sGX�Y~Zo����pW�>�즱�:����C�!	?@dI�gEa�U�)�S�w��+�8�l*Ԧ�.<;nV�;9.�T7Ƹ�w-A;a@���[����A��x���M����˻���)=��b������B���n���8����[����8������+w�����2�GrX������>�y�4�[��2��zՒ�v����/�/��rP�s�E9d�OlD�q`����1[��D)/(A��3���3�s:b�ٌ�w��vVaC�m������q��v_�5;UQ��џԲ�Ua�'��L�G-5�i�s;� S��mϟ�ڢ��� ��!^���o��O�}�$��[zR5S�Wy]�i��n���ܝ:��rZ�3z{̺Ұ�k�+%ߗ��rպ[��b�V�E%���;�9��;{�օϧ�#�ue�>�1�X���A�X����_,��������1����b��c��̀�����������O��?X��?���`�Q��;�6�c�?
Ă����_8�_D����v[D��o��Y�����?�����������g�i�I��X�eсC�`fs��ʞ�J߲��l�mYn�,�{�Q�J)��R���d��a"8s ��_�D�6���������'���P�T�rw�͠�iK�|��������~���J���iq{;�LdٝV6���v��N2���tj��褶�T<E�V��K����$%[��dj��O�A�t�O&���y����?���ƾX��}ِZ�q,�v�݆ܖ���/E����������g��m��r�IV�S՛�����Nӱ|'}{Ծ�_@����x~-�Z���c�7/k����t����*�����k��<���O���?�M��MU����]����E�xrۯ����z��>D ����H��px��tNn@��,�{�[x�+���R.S4ITz�a��x��c�om���*1��$Bک���S�N�R�<��s��:�3hzM�9�)�í{Ԕ]���ྸ��Q��C씋�Y�yX���R��z)
Qv;��7RO�c�޿u~�e}cP.a	:݊p���@�n�E٬�}VS*w
e�Z����������K���g��2�Ѷ&]Qb��@3(w�W�o�I������m��]��O�p����H$	�Pd�90�瘕��b��H\���v�1[D$1w��mf����Q&��ײ��}0�9��E�~�P+��<�s{1jJ�@��(2ā��ƘF}��0XH^_T�9b�HT"�I��$Q��p�#+�,�y���]����|�נ�h��ےr��`!�6�kM������^љ[�v��(�To�b�B�� �!�-9��N�������gN�j��f��/�{��L�7�Z�*��{m�vǥ�Z������������1���m��`e�Ο�K�/{q��7?��P����J�"���q�~X�`��̑��]��;�kA�q5��j1A��W���Bh�B�9� Ù��$P?��7�c�**���"�=O�i�tm��$�EѨsiy�l�s�y.�Z�Z/慽o�]۰5m���o|%��-cu��W��m�e=Gb���u��h�b�.ź���80���5�fz3'�,��,�21���6����>�q��*���[�g���<��Xl�qX�9IJ�vk��sJ�O,��=C��T)0s��Q6@�/ D�[mHF"j��`����H�T �+߲Hu4��� ��MY��Q�/oLM%g MʪI��(Q"�B��5�@g���I��O;��xp���݁0+��j�o��b��7��|�����zV����rl�0�����AӲ�%�pv�v¿������0i��j���7T����pz���>TcV�^;�0Oy0+`y��/�՚��X&s�r�3�l� ����~��4_?���G, ��*��f��/�p�ϳ��ܳ�A_����us�f�?��f�D��~\�s�����y��&�&�ieGSm��kP�d��f�2�y��U� ���d��T@E��R� �(0�����
X.�F��E��==���P}lJ�K���+Bݒ!Ѕ�y�vT�ڳ�|m����ǅ�: D�n��[�����ٶh|�zV<,��_���F-�E�ݠ��a��غ�̉ڭd#��i���2.*���Y.ӵ9���.���H����af�9+.	tv��6P�m4a����c���<�1�����N���;��<�h�HrBN��̎��#���ٮ2�9\���:� ��h�,_�����xHkO�����0�X=av��|VO���'L|�'�G���=���{����I���w�pQ|���v"����Mf����b_��W�"!ՠm2TA��=�D	>�-Ұ6
H����E��Hí�xV�$Ck�a���F�C&���,�@��8�zl*Ҹ�ih-��D���x�V�1mo#�F#Nd�r�ލ)�;.���&qe�!��
5�����m�Al��8�&bW�P! p0�etQ[��:�H�)�iˆ�˭���/�=h� zLTI8/��&���9/�!�"��Z-R/����-����r�~���9*����ޢ�tl�)cO�6�6�R�2�9��ܑ%h��B,I�h��N\_6pD`��d�/��m�nV�"8��:Ɍ��j�^G"{N�n�0��jF@6}�;eÇn`>+0q�po1��a8�bxn��q���3� �h�&Q���H6���Ȁk}
׋hg��+Z��H[�v�y�r6"~�����Z�1�5	��8�.�:/�7ɟ��l�/�oވ���2�Ir��h�����}�9��c0�(�E�GyP�-�ب{�CtcNl����Ro�r���n41�����ᱼ5g�����&P�#��͉��Q?7��w\�5Ƶ���Xd+�n��ځ �X�^-Us��6 }�ʶc�����v�[�ĭ���$�Id��F�5�78��p��6(R���tq� ����1g�F�f�(�4�4N-��p�������+/\��h� �18�6v�p�J����iQ,6���E��"��Fi/;`��k���ə� ��Ǧ����V�7F�����k�PW�|��}�0E`��9\mM���(D(��E+
�
H޺������"`䭏֝�k�}cb�U�ɦz[��pX�M�z��&8�:������6Rv�hê�8�r����W76X�&����a�,�	�Qش,@{t-� ]j�ɰ�j"��KB�����0	D�>.�`� *(7�vm��t0����Tca�GeB�X���#i�f���8�l��	C	�jg�(��������Hd�yȫl�L�SE�5#&����]��v8j�g`�\;��7G���H޼�싲bY/���-�H��x��=]1m�u]����^����.����O�(��q;�b�r:��c��-�{���g���T�k+Z]�a�w�^u��D�1�&�p*ȭֽ��C���<�.�����N�p �Mj�tp���F�8P$����Ȗ��+��A\���܅�`Rd�@��ΊE^"��3{���n{#	�;�A
a(�620� �"�#3���OT:g,l���1����*�D����Ǖ�^�
������RL<XT�����.��#Q6=��1�)c�ґh8���t��A��خ�Ri��p��}V����Xt�Gz;e����x�tf{������b-Y��D�
=#��l�EG��S4=[0��U�g���B�(�F��Y�h��8��0�q�~�~�Bx�,����?�H��/�æP=��o�o��d3��h0j�7�/�@SYW�-�{�̞h���홤�2���Pť.��|܅-i��-�hg`�g�����p+�?��AບX��������S����>���ڟB@¦���e�1��Ǜ3�D�Sk���U�{���h�'�!I0��ޜ�ϋj�}fb�����&u�[��S��X���A����En���5`��&��r�~�s������ʈ�,r�ӾvmM�؃���n��3�O�z��y���ؓ��wt�k��`+�̀}+ʱ���m�;���TQR����������`��'�);����d��,|�������_��c��ʪ: �Wa�p	Ys��Q@�K��+f�c.X��/-{�q�?���0<;`v�C��|4�dX�\tF�0Y�0
�:֨dԣ�3b����cHٱH�t����Z��	�Z����~��߄���ȗ�`�Bl�nfi��,�:6be�ҷ7���c~���J��^E��ש�{�E�?��L��l6����>����@�2k�5x�8��lR�������$�$_M��>�fI.'.8	�zG�{�j2�n��cr�wcEp���1��ڊ`�����7�j�;ቭ�7f|�#���we�hY�1��Ў�t��D��(�dgw̙���k��[�*������8���K������߮��'��������{n�<Y<�����O2�������ob�)k�^��<TZ^����d������o*�\����Ǻ�;�|2[�g/��Ʊ�j?�6�Z�o�[1qB:�Zi>����m����͟'���N�z��� ���}��n�فyFj��Þ����7���ru������8^�WԌeU��3m4���O�mYT ��U��W��E����������������Z��Zg�80�� ���{#_$�y�؇p'�V�J��	��0��������`Ⱥ�*�ɱ����$1'�ͱ��1����^-�u��(a�5	�nHXp5���	�#S٧G�&�w���yF%��������j����� ���1��vs�IP����*��A_�]�:@+�z��O�&/����2/&�q�Q�=��y*�3D���ϭ�1���s���'K�����\���H�~���w�x�E��~��`���J��b'�hk(+m�f���f���ygÝ�z����qw/إP�k�ˮc*�_��� %�Jg����f�9�������K��W���_<�����D&����A�3P)6���&�D������U��iy����'�����3���!���-���W.>��?���`���5U����j�A��%NvX'+����:���9a���'$�$=�	��w
��Q��=��^�DZ����8�$d��������Ih��8C����a�%!L��8g��V�`�R�Ԏ&w�4Syqύ�sB-�*�\o�����PG�`3 3�k�P�)�,qh�4�U<����� �2��h�* �7���� ]��oN`WD8fLД!�O����W�QU�)���}����w��8�*�n��	e_#���ñ7h�swa;W�&�QQ�z�5c)�*0���3��%�1� Eӂ�.6!Y�)nw��F��d�(�����F�.ٝ(qp��XV���R�0y��Tu0���e���D�:��M�S�l�	����I��C�z����G?�����?�v�w]���O[�Nr;��wv�v�]1�ʤ�;�۩�N+#�Ԯ�I���N�՝l;���RZJI���OI�x�����C�?����������?x������_7��?���o�B�>
�+�ɯ���S8�;��WO�!���~
��\������"�[���_<��/���_���p�K��e�����K�GP��;���Kϻ�G#���!�����aO:�ԥQ�<�ԯF'����u�y��s���C���[�K�7�B�pk�05��ݗ��S��r�p�#\c��x6���Ί��X+�,��I�����c��a?�������ڻWҹ���8��6:���֤�Fg����%_�o�~�H���˂��6?��ѫr%�/q/�_A3_���W�~�����߅nx�hgpQ��G;=���*�Ja�)�^]T
b��U</�e���w���X~U�Z��f \=?}ݍ�(o��e�1:�_]4zZ;���iG햻��m|��Owb���u�H%���駃X5���(�K1�b��ݟ�ݏM�B�.ZB�-�����ߕ�N�b���M_�����AyJ��\����+&I�^��hTn�w�Z�{� J���I�u��A�9��?�ʤz�er� $���I��Er�f�ۻ�ǭ:�-�v���;�U�vJ���Q�8Χ@��߉c'N�O���$·;q;>�@��� ��B�ġR9C�		Np���*TP%�(���d�����ά��
��x��~y���_~Ϗ����������,0͜�׽MKc�CKSa�sC��C_b��S
���f�������$���>L/oTU4K���\VY\=ź6S-{v�����f[�W].�O`]B��#F~�n������)�蚸ٵe�6�͓�޶t���T��Ї�^7�SRe��E�2a^.h�İ\�F*z5.���>i�x7A�ݔM!1n��j��*��+;y*6ŧ�)bt�[lv����l��x��Rx�"nE���8 AI��]��Vuw�f0�.eT��1d`n�,䥥��Q\�{<�;c(���BP�qy-S�����6�^6'�-�q�J4:�M(�M�l���r��BC C��Ci�^�ּ=I��Y�H�5b��p5ǥ���1����E�������=�*�2��r�hnHw�f�T�{���5S����r�[g�V<6²>��`baS:_Z�78et��]�D06l��V>MdM��u�#�;�ʇ!�h�2�d!k��t�^ӻ����{�B��G������OL�kXN�ْlr�P��EVN�'J���r�2�) 3c��%����Y�(������
'���H/��@��G�3!k6-�+�J-�s�\��k������y�1�y͈?�[��Lu���)�V�

w�X<���5���E=���Å��t�\�����h�=�+%� J-�&+qEl���~]#^�)��Jn��T9#�CZc��b͞�@�.��X�bJ%�b��Ės- J�SJ�00s���C�w4a�L������δ��e�J�DMx�R#l�/�!�0��ߪ�C�&=*MP#1�w�D���Jn���Rr��[6�k,���wc�7��	�E SnS	�n�%���q�؞�쇳��w��z9��v�����$�#�B�J�c�o�ZZ���0K��)K��X�v�c�f<���d��(��B�BMW�[���!�;����Q?�h�im��$�:2pɝ��[�wz�FŨ*��"�n(ͽ�9����G��6K�H��ۼ�mk5����H�2�)��.��P͆j���l;�����.	+�:������}~���ma�χ�ڹ�=��(�n�G��@�sm��K�m��m�*��������	j�Z���H�d�]�������Vy\��_���̎>îbW�e�������<��pu�����r˂9��mm��"=����8��nb��y��c��Ze<��M��7�'�[`��ͷ�k7o>��������]��Vo?�ֹ./��fv��cOa���ӱq����u�Ol�f�N��޺.�����q{�+�5���"P�mk4�3��v�k �G��l'�:&��_�+W���'�����߷��
�C��
^�k��[ϮR�"8���D����;MG��A�]�.eH��z��x�M��>�J���ES���9G+ׂT��*[�(e��=I.��I���@��j�[�0G�-��1�o�.�F0�*-P�:�S�
`T��)0��ӯ���Ua�Tp.�����@���
p�Jc��X�
,*��nm8�ݻ=��C!7e��D�����*\t�x;�kfrJ*I������A���u��5dʘVZ�J�D���6ە��^�u+>Ր`da����q���0���<y��Ϗ��l�����"e���q���;��Q`B�h� ��D+��~BR:EN�&J��囥��(2���G6ٶ��F��Cj����Ro��f�ON�MOtS5h�ҜH�JX�^9�� a��h�U�^"�K���SM�X��E΁�9�]���A���LPT>�Q\^��C���f�U�t�ĺ��"�l���F��؅u���wUa��Za��?~iuLn���+��}��������4�6��WeY�փ#=��DT�%n1�yT>[p� Y�ʳ;F�.l���"�(��D���"�^�%(�٭��6�aj��B�a0D�m9����L��(sF��$�㜣��$��C{B�T�]j!1a�L͞rx�q�pd-k곳��|5gb�`��&r�C��<��p�N�z��;Z�����OHQ�	!$��c�l��=R����`	ܭ���0o�Ē׊���6-�\���*2!z�Ǖ �H��U���0�w�rڄx1�=�k:�n��O'�,u�U΀gRa!�@������~�e�Se�Z� �:$w�m�E���c��&h�|+��x4�Ǔ�-��w �7Է�M�h�wjm:��]WE/V��կ����BӰ����c�����<Ѩ�p�:�R0�`c��������+��(=x�ٯ�{?~��W���w��뫟|{��m1T���䰌]��z�̺y������$�G���z������ܛo��_���~x���v��˙�/�����y����q�����x=~�q��ֹy�����+za��_��;l��a����7������7v#��E�����}��>�?�؟7��o�b�v�����ډ���&�h�ډ~������ iH#j'�v"j'��P��i�v��oy��7NA�<	4��s��0T��M{�v��U�3 ���z����c8B���u�j�;�����O��T�3@΁����#y���AfX_l,��S���� ���A�в �f9r���f��������2��Y�p���NJ���Gϐ�yV��� m����� A�	$H� A�	$H� A�	$H��w�q���   
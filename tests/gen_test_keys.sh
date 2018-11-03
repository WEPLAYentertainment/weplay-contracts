mkdir keys
echo 123 > pwd
node utils/gen_key_enc.js --key tests/keys/k0.json --pwd tests/pwd
node utils/gen_key_enc.js --key tests/keys/k1.json --pwd tests/pwd
node utils/gen_key_enc.js --key tests/keys/k2.json --pwd tests/pwd
node utils/gen_key_enc.js --key tests/keys/k3.json --pwd tests/pwd

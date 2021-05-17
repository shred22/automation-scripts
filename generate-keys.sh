#!/bin/bash


rm -rf CA
rm -rf Server
rm -rf Client
mkdir CA
cd CA

echo 'Generating CA Private/Public(Cert) Key Pairs'
openssl req -x509 -newkey rsa:4096 -nodes -days 365 -keyout ca-key.pem -passout pass:prvt1Key -out ca-cert.pem -subj "/C=IN/ST=MP/L=INDORE/O=Hackers Inc/OU=Development/CN=shreyasd/emailAddress=shd22@gmail.com"

echo "CA's Self-Signed Certificate"
openssl x509 -in ca-cert.pem -noout -text

cd ../
mkdir Server
cd Server

echo ''
echo 'Generating Server Stuff now'
echo ''
#Generate Web Server's Private Key and CSR
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -passout pass:prvt1Key -out server-csr.pem -subj "/C=IN/ST=MP/L=INDORE/O=RabbitMQServer/OU=Development/CN=rabbit/emailAddress=rabbitserver22@gmail.com"

#Sign Server's Cert with CA 
openssl x509 -req -in server-csr.pem -days 90 -CA ../CA/ca-cert.pem -CAkey ../CA/ca-key.pem -CAcreateserial -out server-cert.pem

#Server certificate
openssl x509 -in server-cert.pem -noout -text

echo ''
echo '===========DONE GENERATING FILES==================='
echo ''
echo ''
echo 'Verifying Server Certificates'
#Verify Server's Certificate
openssl verify -CAfile ../CA/ca-cert.pem server-cert.pem


cd ../
mkdir Client
cd Client
echo ''
echo 'Generating Client Certificates'
echo ''
#Generate Web client's Private Key and CSR
openssl req -newkey rsa:4096 -nodes -keyout client-key.pem -out client-csr.pem -subj "/C=IN/ST=MP/L=INDORE/O=SpBootSTOMPClient/OU=Development/CN=bootStomp/emailAddress=boot22@gmail.com"

#Sign client's Cert with CA 
openssl x509 -req -in client-csr.pem -days 90 -CA ../CA/ca-cert.pem -CAkey ../CA/ca-key.pem -CAcreateserial -out client-cert.pem

#Client certificate
openssl x509 -in client-cert.pem -noout -text

echo ''
echo '===========DONE GENERATING FILES==================='
echo ''
echo ''
echo 'Verifying Client Certificates'
#Verify Client's Certificate
openssl verify -CAfile ../CA/ca-cert.pem client-cert.pem

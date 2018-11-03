var crypto = require('crypto')
var secp256k1 = require('secp256k1')
var util = require('util');

var keys = require('../lib/keys');
var utils = require('../lib/utils');
var enc = require('../lib/enc');
var eth_util = require('ethereumjs-util');

var fs = require("fs");

const optionDefinitions = [
  { name: 'help', alias: 'h', type: Boolean },
  { name: 'key', type: String, defaultValue: "./keys/k0.json"},
  { name: 'pwd', type: String},
]

const commandLineArgs = require('command-line-args')
const options = commandLineArgs(optionDefinitions)
console.log("options:",options)

if("help" in options || !(options.key)){
  console.log("Usage: --key tests/keys/k0.json [--pwd tests/pwd]")
  process.exit(0)
}


(async ()=>{
var pwd=await keys.getPwdFromEncFileOrConsole(options.pwd)
console.log('')
console.log('pwd',pwd)

var kp=keys.genKeyPair()

console.log('priv (debug only)',kp.priv.toString('hex'))


var kp_enc_json=enc.toV3(pwd,kp.priv,{n:8192})
kp_enc_json.pub=kp.pub.toString('hex')
kp_enc_json.date=new Date().toISOString()
kp_enc_json.address=eth_util.pubToAddress(kp.pub,true).toString('hex')


var fileName = options.key
fs.writeFileSync(fileName,JSON.stringify(kp_enc_json, null, ' '));


})()




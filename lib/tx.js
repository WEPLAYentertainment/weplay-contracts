var eth_util = require('ethereumjs-util')
var Tx = require('ethereumjs-tx')

var fs = require('fs')

var utils = require('../lib/utils')
//var keys = require('../lib/keys')


exports.send_contract=function(web3,instance,msg){

// msg={
// sender:'0xabc...',
// gasLimit: 4000000,
// value: 1000000000000000000,  // should use var value = web3.toWei(opts.value, "ether");
// to: '0xabc...',
// method: 'transfer',
// params:['0xabc...','1000000000000000']
// pk:<Buffer ab cd ...>
//}


var tx = new Tx({
    nonce: web3.toHex(web3.eth.getTransactionCount(utils.ck0x(msg.sender))),
    gasPrice: web3.toHex(web3.eth.gasPrice),
    gasLimit: web3.toHex(msg.gasLimit || 4000000),
    value: web3.toHex(msg.value) || '0x0',
    to: utils.ck0x(msg.to),
    data: instance[msg.method].getData(...msg.params)
});
tx.sign(msg.pk);
var p=new Promise( (resolve, reject) => {
  web3.eth.sendRawTransaction('0x'+tx.serialize().toString('hex'), (err, hash)=> {
  if(err){reject(err);return}
  console.log('sendRawTransaction hash',hash) 
  var waitCount=0;
  var intObj=setInterval(async function(){
  var receipt = await web3.eth.getTransactionReceipt(hash)
  if(receipt){
      clearInterval(intObj)
      console.log('receipt',receipt)
      resolve(receipt)
      return
  }
  console.log('waiting receipt... ',waitCount)
  if(waitCount>10){
      clearInterval(intObj)
      console.log('timeout')
      reject('timeout')
      return
    }
    waitCount++
  },1000)

  }) // sendRawTransaction
  }) // promise

return p;
}



exports.deploy=function(web3,contract,bin,msg){

// msg={
// sender:'0xabc...',
// gasLimit: 4000000,
// value: 1000000000000000000,  // should use var value = web3.toWei(opts.value, "ether");
// params:['0xabc...','1000000000000000']
// pk:<Buffer 12 ab ...>
//}


var tx = new Tx({
    nonce: web3.toHex(web3.eth.getTransactionCount('0x'+msg.sender)),
    gasPrice: web3.toHex(web3.eth.gasPrice),
    gasLimit: web3.toHex(msg.gasLimit || 4000000),
    value: web3.toHex(msg.value) || '0x0',
    data: contract.new.getData({data: '0x'+bin})
});
tx.sign(msg.pk);
var p=new Promise( (resolve, reject) => {
  web3.eth.sendRawTransaction('0x'+tx.serialize().toString('hex'), (err, hash)=> {
  if(err){reject(err);return}
  console.log('sendRawTransaction',hash) 
  var waitCount=0;
  var intObj=setInterval(async function(){
  var receipt = await web3.eth.getTransactionReceipt(hash);
  if(receipt){
    if('contractAddress' in receipt){
      clearInterval(intObj)
      console.log('receipt',receipt)
      resolve(receipt.contractAddress)
      return
    } 
  }
  console.log('waiting receipt... ',waitCount);
  if(waitCount>10){
      clearInterval(intObj)
      console.log('timeout')
      reject('timeout')
      return
    }
    waitCount++
  },1000);

  }) // sendRawTransaction
  }) // promise

return p;
}

# api

[brix/crypto-js](https://github.com/brix/crypto-js)

## MD5

```
var encrypted = CryptoJS.CryptoJS.MD5("");
console.log(encrypted);
```

## AES

```

CryptoJS.mode: [CBC, CFB, CTR, OFB, ECB];

CryptoJS.pad: [Pkcs7, Iso97971, AnsiX923, Iso10126, ZeroPadding, NoPadding]

cfg: {
    mode : CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7,
    iv: ""
}
```

```
var ciphertext = CryptoJS.AES.encrypt(message, key, cfg);
var plaintext  = CryptoJS.AES.decrypt(ciphertext, key, cfg);
```

```
function encrypt(word){
    var key = CryptoJS.CryptoJS.enc.Utf8.parse("0102030405060708");   //加密密钥
    var iv  = CryptoJS.CryptoJS.enc.Utf8.parse('0102030405060708');   //加密向量
    var srcs = CryptoJS.CryptoJS.enc.Utf8.parse(word);
    var encrypted = CryptoJS.CryptoJS.AES.encrypt(srcs, key, {
                                                      iv: iv,
                                                      mode: CryptoJS.CryptoJS.mode.CBC
                                                  });
    return encrypted.toString();
}
```

```
// 加密
function encryptAES(content, key) {
    var CryptoJS = CryptoJSLib.CryptoJS;
    var AES = CryptoJS.AES;
    var ivStr  = CryptoJS.enc.Utf8.parse(iv);
    var keyStr = CryptoJS.enc.Utf8.parse(key);

    var text = AES.encrypt(content, keyStr, {
                                    iv: ivStr,
                                    mode: CryptoJS.mode.CBC,
                                    padding: CryptoJS.pad.Pkcs7
                                });
    return text.toString();
}

// 解密
function decryptAES(ciphertext, key) {
    var CryptoJS = CryptoJSLib.CryptoJS;
    var AES = CryptoJS.AES;
    var ivStr  = CryptoJS.enc.Utf8.parse(iv);
    var keyStr = CryptoJS.enc.Utf8.parse(key);

    var bytes = AES.decrypt(ciphertext, keyStr, {
                                    iv: ivStr,
                                    mode: CryptoJS.mode.CBC,
                                    padding: CryptoJS.pad.Pkcs7
                                });
    var plaintext = bytes.toString(CryptoJS.enc.Utf8);
    return plaintext.toString();
}
//! [AES encryption working between Objective-C and Java.](https://github.com/WelkinXie/AESCipher-Java)
```



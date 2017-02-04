//
//  Header.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/1/16.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import Foundation
import UIKit

private let base64EncodingTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
private let base64DecodingTable = [
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2,  -1,  -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62,  -2,  -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2,  -2,  -2, -2, -2,
    -2, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2,  -2,  -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2
]

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let WIDTH_RATE = SCREEN_WIDTH/375
let HEIGHT_RATE = SCREEN_HEIGHT/667

let IS_IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0
let IS_IOS9 = (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0
let IS_IOS10 = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0

extension String {
    var md5 : String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
    var MD5 : String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02X", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
    var pinyin : String {
        let string = NSMutableString(string: self)
        CFStringTransform(string, nil, kCFStringTransformToLatin, false)
        
        let new = string.folding(options: NSString.CompareOptions.diacriticInsensitive, locale: Locale.current)
        
        return new
    }
}

extension Data {
    var base64 : String? {
        //    // 编码
        //
        //    + (NSString *)base64EncodedStringWithData:(NSData *)data {
        //    NSUInteger length = data.length;
        //    if (length == 0)
        //    return @"";
        //
        //    NSUInteger out_length = ((length + 2) / 3) * 4;
        //    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
        //    if (output == NULL)
        //    return nil;
        //
        //    const char *input = data.bytes;
        //    NSInteger i, value;
        //    for (i = 0; i < length; i += 3) {
        //    value = 0;
        //    for (NSInteger j = i; j < i + 3; j++) {
        //    value <<= 8;
        //    if (j < length) {
        //    value |= (0xFF & input[j]);
        //    }
        //    }
        //    NSInteger index = (i / 3) * 4;
        //    output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        //    output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        //    output[index + 2] = ((i + 1) < length)
        //    ? base64EncodingTable[(value >> 6) & 0x3F]
        //    : '=';
        //    output[index + 3] = ((i + 2) < length)
        //    ? base64EncodingTable[(value >> 0) & 0x3F]
        //    : '=';
        //    }
        //    
        //    NSString *base64 = [[NSString alloc] initWithBytes:output length:out_length encoding:NSASCIIStringEncoding];
        //    free(output);
        //    return base64;
        //    }
        
        let length = self.count
        if length == 0 {
            return ""
        }
        let out_length = ((length + 2) / 3) * 4
        let output = malloc(((out_length + 2) / 3) * 4)
        if output == nil {
            return nil
        }
        let tempData: NSMutableData = NSMutableData(length: 26)!
        let input = self.withUnsafeBytes {
            tempData.replaceBytes(in: NSMakeRange(0, self.count), withBytes: $0)
        }
        for _ in 0...length {
            
        }
    }
}












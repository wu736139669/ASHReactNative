//
//  NSString+Util.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/10.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (NSDictionary*)ash_queryDictionary
{
    NSArray *array = [self componentsSeparatedByString:@"?"];
    NSString *encodedString = array.lastObject;
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *pairs = [encodedString componentsSeparatedByString:@"&"];
    
    for (NSString *kvp in pairs) {
        if ([kvp length] == 0) {
            continue;
        }
        
        NSRange pos = [kvp rangeOfString:@"="];
        NSString *key;
        NSString *val;
        
        if (pos.location == NSNotFound) {
            key = [self ash_stringByUnescapingFromURLQuery:kvp];
            val = @"";
        } else {
            key = [self ash_stringByUnescapingFromURLQuery:[kvp substringToIndex:pos.location]];
            val = [self ash_stringByUnescapingFromURLQuery:[kvp substringFromIndex:pos.location + pos.length]];
        }
        
        if (!key || !val) {
            continue; // I'm sure this will bite my arse one day
        }
        
        [result setObject:val forKey:key];
    }
    return result;
}
- (NSString *)ash_stringByUnescapingFromURLQuery:(NSString *)string
{
    NSString *deplussed = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end

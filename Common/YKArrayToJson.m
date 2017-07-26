//
//  YKArrayToJson.m
//  YKProject
//
//  Created by Yuki on 16/10/18.
//  Copyright © 2016年 Yuki. All rights reserved.
//

#import "YKArrayToJson.h"

@implementation YKArrayToJson

+(NSString *)stringTOjson:(id)temps   //把字典和数组转换成json字符串
{
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:temps
                                                      options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strs=[[NSString alloc] initWithData:jsonData
                                         encoding:NSUTF8StringEncoding];
    return strs;
}

@end

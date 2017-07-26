//
//  YKLog.h
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

#ifndef WEYLog_h
#define WEYLog_h

#ifdef DEBUG

#define Log_DEBUG(format, ...)    NSLog(@"[DEBUG]   {%s,%d} " format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define Log_INFO(format, ...)     NSLog(@"[INFO]    {%s,%d} " format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define Log_WARNING(format, ...)  NSLog(@"[WARNING] {%s,%d} " format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define Log_ERROR(format, ...)    NSLog(@"[ERROR]   {%s,%d} " format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define Log_VERBOSE(format, ...)  NSLog(@"[VERBOSE] {%s,%d} " format, __FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define Log_DEBUG(format, ...)
#define Log_INFO(format, ...)
#define Log_ERROR(format, ...)
#define Log_WARNING(format, ...)
#define Log_VERBOSE(format, ...)

#endif

#endif /* WEYLog_h */

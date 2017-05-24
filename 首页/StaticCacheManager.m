//
//  StaticCache_Pb.m
//  BayiParents
//
//  Created by qyb on 2017/5/10.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "StaticCacheManager.h"
#import "StaticCacheItem.h"
#import "AvoidCrash.h"

static NSString * const methodKey = @"delloc__did__configed";
@interface StaticCacheManager()
@property (strong,nonatomic) NSMutableDictionary *keys;
@property (strong,nonatomic) NSTimer *timer;
@end
@implementation StaticCacheManager
{
    NSString *_shouldDeledeKey;
}
+ (instancetype)shareManager{
    static StaticCacheManager *pb = nil;
    kDISPATCH_ONCE_BLOCK(^{
        pb = [[StaticCacheManager alloc] init];
    });
    return pb;
}
- (instancetype)init{
    if (self = [super init]) {
        _keys = [NSMutableDictionary new];
        _shouldRemoveAllObjectsOnMemoryWarning = YES;
        _shouldRemoveAllObjectsWhenEnteringBackground = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidReceiveMemoryWarningNotification) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}
- (void)_appDidReceiveMemoryWarningNotification{
    if (_shouldRemoveAllObjectsOnMemoryWarning) {
        [self asyncRemoveAll];
    }
}

- (void)_appDidEnterBackgroundNotification{
    if (_shouldRemoveAllObjectsWhenEnteringBackground) {
        [self asyncRemoveAll];
    }
}
- (void)asyncRemoveAll{
    kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
        [_keys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            StaticCacheItem *item = obj;
            @synchronized (item.set) {
                [item  removeAllObject];
            }
            
        }];
    });
}
/**
 创建一个新的set

 @param key key
 @return 返回nil为重复创建
 */
- (NSMutableSet *)createNewSetForKey:(nonnull NSString *)key{
    
    StaticCacheItem *item = [_keys objectForKey:key];
    NSMutableSet *set = nil;
    if (!item) {
        item = [[StaticCacheItem alloc]init];
        [_keys setObject:item forKey:key];
    }
    set = item.set;
    return set;
}

- (BOOL)isExistCacheForKey:(NSString *)key{
    id obj = [_keys objectForKey:key];
    return obj?YES:NO;
}
- (NSMutableSet *)setForKey:(NSString *)key{
    return [_keys objectForKey:key];
}

- (BOOL)removeSetForKey:(NSString *)key{
    StaticCacheItem *item = [_keys objectForKey:key];
    if (!item) {
        return NO;
    }
    NSInteger retainCount = [[item valueForKey:@"retainCount"] integerValue];
    if (retainCount <= 2) {
        [_keys removeObjectForKey:key];
        [item removeAllObject];
        item = nil;
        return YES;
    }else{
        return NO;
    }
    
}

- (void)asyncRemoveSetForKey:(NSString *)key compelet:(void(^)(BOOL succss))compelet{
    kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
        StaticCacheItem *item = [_keys objectForKey:key];
        if (!item) {
            if (compelet) {
                compelet(NO);
            }
            
        }
        NSInteger retainCount = [[item valueForKey:@"retainCount"] integerValue];
        if (retainCount <= 2) {
            [_keys removeObjectForKey:key];
            @synchronized (item.set) {
                [item removeAllObject];
            }
            item = nil;
            compelet(YES);
        }else{
            if (compelet) {
                compelet(NO);
            }
        }
    });
}


//- (void)deallocSetForKey:(NSString *)key{
//    NSMutableSet *set = [_sets objectForKey:key];
//    [_sets removeObjectForKey:key];
//    set = nil;
//}
@end

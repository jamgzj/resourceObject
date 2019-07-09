//
//  JMBaseServiceAgent.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/24.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class JMBaseRequest;

@interface JMBaseServiceAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)sharedAgent;

///  Add request to session and start it.
- (void)addRequest:(JMBaseRequest *)request;

///  Cancel a request that was previously added.
- (void)cancelRequest:(JMBaseRequest *)request;

///  Cancel all requests that were previously added.
- (void)cancelAllRequests;

///  Return the constructed URL of request.
///
///  @param request The request to parse. Should not be nil.
///
///  @return The result URL.
- (NSString *)buildRequestUrl:(JMBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END

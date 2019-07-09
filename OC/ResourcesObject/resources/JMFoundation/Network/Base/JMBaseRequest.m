//
//  JMBaseRequest.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/24.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "JMBaseRequest.h"
#import "JMBaseServiceAgent.h"

@implementation JMBaseRequest

- (NSHTTPURLResponse *)response {
    return (NSHTTPURLResponse *)self.requestTask.response;
}

- (NSInteger)responseStatusCode {
    return self.response.statusCode;
}

- (NSDictionary *)responseHeaders {
    return self.response.allHeaderFields;
}

- (NSURLRequest *)currentRequest {
    return self.requestTask.currentRequest;
}

- (NSURLRequest *)originalRequest {
    return self.requestTask.originalRequest;
}

- (BOOL)isCancelled {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateCanceling;
}

- (BOOL)isExecuting {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateRunning;
}

- (void)setCompletionBlockWithSuccess:(JMRequestCompletionBlock)success
                              failure:(JMRequestCompletionBlock)failure {
    self.success = success;
    self.failure = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.success = nil;
    self.failure = nil;
}

#pragma mark - Request Action

- (void)start
{
    [[JMBaseServiceAgent sharedAgent] addRequest:self];
}

- (void)stop
{
    [[JMBaseServiceAgent sharedAgent] cancelRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(nullable JMRequestCompletionBlock)success
                                    failure:(nullable JMRequestCompletionBlock)failure
{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

#pragma mark - Subclass Override

- (NSString *)requestUrl {
    return @"";
}

- (NSString *)baseUrl {
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 60;
}

- (id)requestArgument {
    return nil;
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument {
    return argument;
}

- (JMRequestMethod)requestMethod {
    return JMRequestMethodGET;
}

- (JMRequestSerializerType)requestSerializerType {
    return JMRequestSerializerTypeHTTP;
}

- (JMResponseSerializerType)responseSerializerType {
    return JMResponseSerializerTypeJSON;
}

- (NSArray *)requestAuthorizationHeaderFieldArray {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return nil;
}

- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}

- (BOOL)allowsCellularAccess {
    return YES;
}

@end

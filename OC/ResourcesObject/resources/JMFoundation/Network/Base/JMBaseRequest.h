//
//  JMBaseRequest.h
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/6/24.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///  HTTP Request method.
typedef NS_ENUM(NSInteger, JMRequestMethod) {
    JMRequestMethodGET = 0,
    JMRequestMethodPOST,
    JMRequestMethodHEAD,
    JMRequestMethodPUT,
    JMRequestMethodDELETE,
    JMRequestMethodPATCH,
};

///  Request serializer type.
typedef NS_ENUM(NSInteger, JMRequestSerializerType) {
    JMRequestSerializerTypeHTTP = 0,
    JMRequestSerializerTypeJSON,
};

typedef NS_ENUM(NSUInteger, JMResponseSerializerType) {
    /// NSData type
    JMResponseSerializerTypeHTTP,
    /// JSON object type
    JMResponseSerializerTypeJSON,
    /// NSXMLParser type
    JMResponseSerializerTypeXMLParser,
};

@protocol AFMultipartFormData;
typedef void (^JMConstructingBlock)(id<AFMultipartFormData> formData);
typedef void (^JMURLSessionTaskProgressBlock)(NSProgress *);

@class JMBaseRequest;

typedef void(^JMRequestCompletionBlock)(__kindof JMBaseRequest *request);

@interface JMBaseRequest : NSObject

///  The underlying NSURLSessionTask.
///
///  @warning This value is actually nil and should not be accessed before the request starts.
@property (nonatomic, strong) NSURLSessionTask *requestTask;

///  Shortcut for `requestTask.currentRequest`.
@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;

///  Shortcut for `requestTask.originalRequest`.
@property (nonatomic, strong, readonly) NSURLRequest *originalRequest;

///  Shortcut for `requestTask.response`.
@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;

///  The response status code.
@property (nonatomic, readonly) NSInteger responseStatusCode;

///  The response header fields.
@property (nonatomic, strong, readonly, nullable) NSDictionary *responseHeaders;

///  This serialized response object. The actual type of this object is determined by
///  `YTKResponseSerializerType`. Note this value can be nil if request failed.
///
///  @discussion If `resumableDownloadPath` and DownloadTask is using, this value will
///              be the path to which file is successfully saved (NSURL), or nil if request failed.
@property (nonatomic, strong, nullable) id responseObject;

///  If you use `YTKResponseSerializerTypeJSON`, this is a convenience (and sematic) getter
///  for the response object. Otherwise this value is nil.
@property (nonatomic, strong, nullable) id responseJSONObject;

///  This error can be either serialization error or network error. If nothing wrong happens
///  this value will be nil.
@property (nonatomic, strong, nullable) NSError *error;

///  Return cancelled state of request task.
@property (nonatomic, readonly, getter=isCancelled) BOOL cancelled;

///  Executing state of request task.
@property (nonatomic, readonly, getter=isExecuting) BOOL executing;

///  Tag can be used to identify request. Default value is 0.
@property (nonatomic) NSInteger tag;

///  The userInfo can be used to store additional info about the request. Default is nil.
@property (nonatomic, strong, nullable) NSDictionary *userInfo;

@property (nonatomic, copy, nullable) JMRequestCompletionBlock success;

@property (nonatomic, copy, nullable) JMRequestCompletionBlock failure;

@property (nonatomic, copy, nullable) JMConstructingBlock constructingBodyBlock;

@property (nonatomic, copy, nullable) JMURLSessionTaskProgressBlock resumableDownloadProgressBlock;

///  Set completion callbacks
- (void)setCompletionBlockWithSuccess:(nullable JMRequestCompletionBlock)success
                              failure:(nullable JMRequestCompletionBlock)failure;

///  Nil out both success and failure callback blocks.
- (void)clearCompletionBlock;

///  Append self to request queue and start the request.
- (void)start;

///  Remove self from request queue and cancel the request.
- (void)stop;

///  Convenience method to start the request with block callbacks.
- (void)startWithCompletionBlockWithSuccess:(nullable JMRequestCompletionBlock)success
                                    failure:(nullable JMRequestCompletionBlock)failure;

#pragma mark - Subclass Override
///  The baseURL of request. This should only contain the host part of URL, e.g., http://www.example.com.
///  See also `requestUrl`
- (NSString *)baseUrl;

///  The URL path of request. This should only contain the path part of URL, e.g., /v1/user. See alse `baseUrl`.
///
///  @discussion This will be concated with `baseUrl` using [NSURL URLWithString:relativeToURL].
///              Because of this, it is recommended that the usage should stick to rules stated above.
///              Otherwise the result URL may not be correctly formed. See also `URLString:relativeToURL`
///              for more information.
///
///              Additionaly, if `requestUrl` itself is a valid URL, it will be used as the result URL and
///              `baseUrl` will be ignored.
- (NSString *)requestUrl;

///  Requset timeout interval. Default is 60s.
///
///  @discussion When using `resumableDownloadPath`(NSURLSessionDownloadTask), the session seems to completely ignore
///              `timeoutInterval` property of `NSURLRequest`. One effective way to set timeout would be using
///              `timeoutIntervalForResource` of `NSURLSessionConfiguration`.
- (NSTimeInterval)requestTimeoutInterval;

///  Additional request argument.
- (nullable id)requestArgument;

///  Override this method to filter requests with certain arguments when caching.
- (id)cacheFileNameFilterForRequestArgument:(id)argument;

///  HTTP request method.
- (JMRequestMethod)requestMethod;

///  Request serializer type.
- (JMRequestSerializerType)requestSerializerType;

///  Response serializer type. See also `responseObject`.
- (JMResponseSerializerType)responseSerializerType;

///  Username and password used for HTTP authorization. Should be formed as @[@"Username", @"Password"].
- (nullable NSArray<NSString *> *)requestAuthorizationHeaderFieldArray;

///  Additional HTTP request header field.
- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary;

///  Use this to build custom request. If this method return non-nil value, `requestUrl`, `requestTimeoutInterval`,
///  `requestArgument`, `allowsCellularAccess`, `requestMethod` and `requestSerializerType` will all be ignored.
- (nullable NSURLRequest *)buildCustomUrlRequest;

///  Whether the request is allowed to use the cellular radio (if present). Default is YES.
- (BOOL)allowsCellularAccess;

@end

NS_ASSUME_NONNULL_END

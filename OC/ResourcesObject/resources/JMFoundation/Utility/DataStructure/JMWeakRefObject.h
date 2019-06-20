//
//  JMWeakReafObject.h
//  JMlib
//
//  Created by Terry Tan on 31/05/2017.
//  Copyright © 2017 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMWeakRefObject : NSObject

+ (instancetype)weakRefWithObject: (id)object;

@property (weak, nonatomic) id object;

@end

//
//  DMWeakRefArray.h
//  dmlib
//
//  Created by Terry Tan on 8/12/16.
//  Copyright © 2016 Shanghai DataSeed Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMWeakRefArray : NSObject

- (void)addWeafRefObject: (id)object;

- (NSArray*)retainedObjects; // Returns an array of objects that are not release from memory

- (id)lastReferredObject;

- (id)popLastObject;

@end

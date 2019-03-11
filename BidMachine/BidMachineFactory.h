//
//  BidMachineFactory.h
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BidMachine/BidMachine.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidMachineFactory : NSObject

+ (instancetype)sharedFactory;
- (BDMTargeting *)setupTargetingWithLocalExtras:(NSDictionary *)localExtras andLocation:(CLLocation * _Nullable)location;
- (NSArray<BDMPriceFloor *> *)makePriceFloorsWithPrice:(NSNumber *)price;

@end

NS_ASSUME_NONNULL_END

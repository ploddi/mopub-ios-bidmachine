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
- (BDMTargeting *)setupTargetingWithExtraInfo:(NSDictionary *)extraInfo andLocation:(CLLocation * _Nullable)location;
- (NSArray<BDMPriceFloor *> *)makePriceFloorsWithPriceFloors:(NSArray *)priceFloors;

@end

NS_ASSUME_NONNULL_END

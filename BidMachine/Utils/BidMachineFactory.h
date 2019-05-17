//
//  BidMachineFactory.h
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<BidMachine/BidMachine.h>)
#import <BidMachine/BidMachine.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BidMachineFactory : NSObject

+ (instancetype)sharedFactory;
- (void)initializeBidMachineSDKWithCustomEventInfo:(NSDictionary *)info;
- (BDMTargeting *)setupTargetingWithExtraInfo:(NSDictionary *)extraInfo andLocation:(CLLocation * _Nullable)location;
- (NSArray<BDMPriceFloor *> *)makePriceFloorsWithPriceFloors:(NSArray *)priceFloors;

@property (nonatomic, assign) BOOL isSDKInitialized;

@end

NS_ASSUME_NONNULL_END

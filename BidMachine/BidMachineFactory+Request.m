//
//  BidMachineFactory+Request.m
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "BidMachineFactory+Request.h"
#import <BidMachine/BidMachine.h>

@implementation BidMachineFactory (Request)

- (BDMBannerRequest *)setupBannerRequestWithSize:(CGSize)size
                                     LocalExtras:(NSDictionary *)localExtras
                                        location:(CLLocation *)location
                                           price:(NSNumber *)price {
    BDMBannerRequest * request = [BDMBannerRequest new];
    BDMBannerAdSize bannerAdSize;
    switch ((int)size.width) {
        case 300: bannerAdSize = BDMBannerAdSize300x250;  break;
        case 320: bannerAdSize = BDMBannerAdSize320x50;   break;
        case 728: bannerAdSize = BDMBannerAdSize728x90;   break;
        default: bannerAdSize = BDMBannerAdSizeUnknown;   break;
    }
    [request setAdSize:bannerAdSize];
    [request setTargeting:[[BidMachineFactory sharedFactory] setupTargetingWithLocalExtras:localExtras andLocation:location]];
    [request setPriceFloors:[self makePriceFloorsWithPrice:price]];
    return request;
}

- (BDMInterstitialRequest *)interstitialRequestWithLocalExtras:(NSDictionary *)localExtras location:(CLLocation *)location price:(NSNumber *)price {
    BDMInterstitialRequest * request = [BDMInterstitialRequest new];
    [request setType:BDMFullscreenAdTypeAll];
    [request setTargeting:[[BidMachineFactory sharedFactory] setupTargetingWithLocalExtras:localExtras andLocation:location]];
    [request setPriceFloors:[self makePriceFloorsWithPrice:price]];
    return request;
}

- (BDMRewardedRequest *)rewardedRequestWithLocalExtras:(NSDictionary *)localExtras location:(CLLocation *)location price:(NSNumber *)price {
    BDMRewardedRequest * request = [BDMRewardedRequest new];
    [request setTargeting:[[BidMachineFactory sharedFactory] setupTargetingWithLocalExtras:localExtras andLocation:location]];
    [request setPriceFloors:[self makePriceFloorsWithPrice:price]];
    return request;
}

- (NSArray<BDMPriceFloor *> *)makePriceFloorsWith:(NSNumber *)price {
    BDMPriceFloor *priceFloor;
    NSArray<BDMPriceFloor *> *priceFloors = [NSArray new];
    if (price) {
        priceFloor = [BDMPriceFloor new];
        [priceFloor setID:NSUUID.UUID.UUIDString.lowercaseString];
        [priceFloor setValue:[NSDecimalNumber decimalNumberWithDecimal:price.decimalValue]];
        [priceFloors arrayByAddingObject:priceFloor];
    }
    return priceFloors;
}

@end

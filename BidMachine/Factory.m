//
//  Factory.m
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+ (instancetype)sharedFactory {
    static Factory * _sharedFactory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFactory = Factory.new;
    });
    return _sharedFactory;
}

- (BDMTargeting *)setupTargetingWithLocalExtras:(NSDictionary *)localExtras andLocation:(CLLocation *)location{
    BDMTargeting * targeting = [BDMTargeting new];
    if (location) {
        [targeting setDeviceLocation:location];
    }
    if (localExtras) {
        (localExtras[@"userId"]) ?: [targeting setUserId:localExtras[@"userId"]];
        (localExtras[@"gender"]) ?: [targeting setGender:localExtras[@"gender"]];
        (localExtras[@"yob"]) ?: [targeting setYearOfBirth:localExtras[@"yob"]];
        (localExtras[@"keywords"]) ?: [targeting setKeywords:localExtras[@"keywords"]];
        (localExtras[@"bcat"]) ?: [targeting setBlockedCategories:localExtras[@"bcat"]];
        (localExtras[@"badv"]) ?: [targeting setBlockedAdvertisers:localExtras[@"badv"]];
        (localExtras[@"bapps"]) ?: [targeting setBlockedApps:localExtras[@"bapps"]];
        (localExtras[@"country"]) ?: [targeting setCountry:localExtras[@"country"]];
        (localExtras[@"city"]) ?: [targeting setCity:localExtras[@"city"]];
        (localExtras[@"zip"]) ?: [targeting setZip:localExtras[@"zip"]];
        (localExtras[@"sturl"]) ?: [targeting setStoreURL:localExtras[@"sturl"]];
        (localExtras[@"stid"]) ?: [targeting setStoreId:localExtras[@"stid"]];
        (localExtras[@"paid"]) ?: [targeting setPaid:localExtras[@"paid"]];
    }
    return targeting;
}

- (NSArray<BDMPriceFloor *> *)makePriceFloorsWithPrice:(NSNumber *)price {
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

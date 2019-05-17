//
//  BidMachineFactory.m
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import "BidMachineFactory.h"
#import "BidMachineConstants.h"
#import <mopub-ios-sdk/MoPub.h>

@interface BidMachineFactory()

@property (nonatomic, strong) NSString *sellerId;

@end

@implementation BidMachineFactory

+ (instancetype)sharedFactory {
    static BidMachineFactory * _sharedFactory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFactory = BidMachineFactory.new;
    });
    return _sharedFactory;
}

- (void)initializeBidMachineSDKWithCustomEventInfo:(NSDictionary *)info {
    if (!(self.sellerId == info[kBidMachineSellerId]) || !self.isSDKInitialized){
        self.sellerId = info[kBidMachineSellerId];
        if (self.sellerId) {
            BOOL testModeEnabled = [info[kBidMachineTestMode] boolValue];
            BOOL loggingEnabled = [info[kBidMachineLoggingEnabled] boolValue];
            BDMSdkConfiguration *config = [BDMSdkConfiguration new];
            [config setTestMode:testModeEnabled];
            [[BDMSdk sharedSdk] setEnableLogging:loggingEnabled];
            [[BDMSdk sharedSdk] startSessionWithSellerID:self.sellerId configuration:config completion:^{
                MPLogInfo(@"BidMachine SDK was successfully initialized!");
                [self setIsSDKInitialized:YES];
            }];
        } else {
            NSError * error = [NSError errorWithDomain:kAdapterErrorDomain
                                                  code:BidMachineAdapterErrorCodeMissingSellerId
                                              userInfo:@{ NSLocalizedDescriptionKey: @"BidMachine's initialization skipped. The sellerId is empty. Ensure it is properly configured on the MoPub dashboard."} ];
            MPLogEvent([MPLogEvent error:error message:nil]);
            [self setIsSDKInitialized:NO];
        }
    }
}

- (BDMTargeting *)setupTargetingWithExtraInfo:(NSDictionary *)extraInfo andLocation:(CLLocation *)location{
    BDMTargeting * targeting = [BDMTargeting new];
    if (location) {
        [targeting setDeviceLocation:location];
    }
    if (extraInfo) {
        (!extraInfo[@"userId"]) ?: [targeting setUserId:(NSString *)extraInfo[@"userId"]];
        (!extraInfo[@"gender"]) ?: [targeting setGender:[self userGenderSetting:extraInfo[@"gender"]]];
        (!extraInfo[@"yob"]) ?: [targeting setYearOfBirth:extraInfo[@"yob"]];
        (!extraInfo[@"keywords"]) ?: [targeting setKeywords:extraInfo[@"keywords"]];
        (!extraInfo[@"bcat"]) ?: [targeting setBlockedCategories:[extraInfo[@"bcat"] componentsSeparatedByString:@","]];
        (!extraInfo[@"badv"]) ?: [targeting setBlockedAdvertisers:[extraInfo[@"badv"] componentsSeparatedByString:@","]];
        (!extraInfo[@"bapps"]) ?: [targeting setBlockedApps:[extraInfo[@"bapps"] componentsSeparatedByString:@","]];
        (!extraInfo[@"country"]) ?: [targeting setCountry:extraInfo[@"country"]];
        (!extraInfo[@"city"]) ?: [targeting setCity:extraInfo[@"city"]];
        (!extraInfo[@"zip"]) ?: [targeting setZip:extraInfo[@"zip"]];
        (!extraInfo[@"sturl"]) ?: [targeting setStoreURL:[NSURL URLWithString:extraInfo[@"sturl"]]];
        (!extraInfo[@"stid"]) ?: [targeting setStoreId:extraInfo[@"stid"]];
        (!extraInfo[@"paid"]) ?: [targeting setPaid:[extraInfo[@"paid"] boolValue]];
    }
    return targeting;
}

- (NSArray<BDMPriceFloor *> *)makePriceFloorsWithPriceFloors:(NSArray *)priceFloors {
    NSMutableArray<BDMPriceFloor *> *priceFloorsArr = [NSMutableArray new];
    [priceFloors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSDictionary.class]) {
            BDMPriceFloor *priceFloor = [BDMPriceFloor new];
            NSDictionary *object = (NSDictionary *)obj;
            [priceFloor setID: object.allKeys[0]];
            [priceFloor setValue: object.allValues[0]];
            [priceFloorsArr addObject:priceFloor];
        } else if ([obj isKindOfClass:NSNumber.class]) {
            BDMPriceFloor *priceFloor = [BDMPriceFloor new];
            NSNumber *object = (NSNumber *)obj;
            [priceFloor setID:NSUUID.UUID.UUIDString.lowercaseString];
            [priceFloor setValue:[NSDecimalNumber decimalNumberWithDecimal:object.decimalValue]];
            [priceFloorsArr addObject:priceFloor];
        }
        if (idx == [priceFloors count] - 1) {
            *stop = YES;
        }
    }];
    return priceFloorsArr;
}

- (BDMUserGender *)userGenderSetting:(NSString *)gender {
    BDMUserGender *userGender;
    if ([gender isEqualToString:@"F"]) {
        userGender = kBDMUserGenderFemale;
    } else if ([gender isEqualToString:@"M"]) {
        userGender = kBDMUserGenderMale;
    } else if ([gender isEqualToString:@"O"]) {
        userGender = kBDMUserGenderUnknown;
    }
    return userGender;
}

@end

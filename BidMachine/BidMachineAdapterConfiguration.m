//
//  BidMachineAdapterConfiguration.m
//  BidMachineAdapterConfiguration
//
//  Created by Yaroslav Skachkov on 3/1/19.
//  Copyright © 2019 BidMachineAdapterConfiguration. All rights reserved.
//

#import "BidMachineAdapterConfiguration.h"

#if __has_include(<BidMachine/BidMachine.h>)
#import <BidMachine/BidMachine.h>
#endif

#if __has_include("MoPub.h")
#import "MoPub.h"
#import "MPLogging.h"
#endif

static NSString * const kBidMachineSellerId = @"seller_id";
static NSString * const kBidMachineTestMode = @"test_mode";

static NSString * const kAdapterErrorDomain = @"com.mopub.mopub-ios-sdk.mopub-bidmachine-adapters";

typedef NS_ENUM(NSInteger, BidMachineAdapterErrorCode) {
    BidMachineAdapterErrorCodeMissingSellerId,
};

@implementation BidMachineAdapterConfiguration

#pragma mark - MPAdapterConfiguration

- (NSString *)adapterVersion {
    return @"1.0.3.0";
}

- (NSString *)biddingToken {
    return nil;
}

- (NSString *)moPubNetworkName {
    return @"bidmachine";
}

- (NSString *)networkSdkVersion {
    return kBDMVersion;
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *,id> *)configuration
                                  complete:(void (^)(NSError *))complete {
    NSString *sellerId = configuration[kBidMachineSellerId];
    NSString *testModeEnabled = configuration[kBidMachineTestMode];
    if (sellerId) {
        BDMSdkConfiguration *config = [BDMSdkConfiguration new];
        if (testModeEnabled) {
            [config setTestMode:YES];
        }
        [[BDMSdk sharedSdk] startSessionWithSellerID:sellerId configuration:config completion:nil];
        if (complete) {
            complete(nil);
        }
    } else {
        NSError * error = [NSError errorWithDomain:kAdapterErrorDomain code:BidMachineAdapterErrorCodeMissingSellerId userInfo:@{ NSLocalizedDescriptionKey: @"BidMachine's initialization skipped. The sellerId is empty. Ensure it is properly configured on the MoPub dashboard."} ];
        MPLogEvent([MPLogEvent error:error message:nil]);
        
        if (complete) {
            complete(error);
        }
    }
}

+ (void)updateInitializationParameters:(NSDictionary *)parameters {
    NSString * sellerId = parameters[kBidMachineSellerId];
    if (sellerId) {
        NSDictionary * configuration = @{ kBidMachineSellerId: sellerId };
        [BidMachineAdapterConfiguration setCachedInitializationParameters:configuration];
    }
}

@end

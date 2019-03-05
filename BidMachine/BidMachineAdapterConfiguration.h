//
//  BidMachineAdapterConfiguration.h
//  BidMachineAdapterConfiguration
//
//  Created by Yaroslav Skachkov on 3/1/19.
//  Copyright © 2019 BidMachineAdapterConfiguration. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mopub-ios-sdk/MoPub.h>

@interface BidMachineAdapterConfiguration : MPBaseAdapterConfiguration

@property (nonatomic, copy, readonly) NSString * adapterVersion;
@property (nonatomic, copy, readonly) NSString * biddingToken;
@property (nonatomic, copy, readonly) NSString * moPubNetworkName;
@property (nonatomic, copy, readonly) NSString * networkSdkVersion;

+ (void)updateInitializationParameters:(NSDictionary *)parameters;
- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> * _Nullable)configuration complete:(void(^ _Nullable)(NSError * _Nullable))complete;

@end

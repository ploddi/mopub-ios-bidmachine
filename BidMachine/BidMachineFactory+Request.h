//
//  BidMachineFactory+Request.h
//  BidMachine
//
//  Created by Yaroslav Skachkov on 3/6/19.
//  Copyright © 2019 BidMachine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BidMachineFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidMachineFactory (Request)

- (BDMBannerRequest *)setupBannerRequestWithSize:(CGSize)size
                                     LocalExtras:(NSDictionary *)extras
                                        location:(CLLocation * _Nullable)location
                                           price:(NSNumber *)price;

- (BDMInterstitialRequest *)interstitialRequestWithLocalExtras:(NSDictionary *)localExtras
                                                      location:(CLLocation *)location
                                                         price:(NSNumber *)price;

- (BDMRewardedRequest *)rewardedRequestWithLocalExtras:(NSDictionary *)localExtras
                                              location:(CLLocation *)location
                                                 price:(NSNumber *)price;

@end

NS_ASSUME_NONNULL_END

# BidMachine adapter

This folder contains mediation adapters used to mediate BidMachine.

## Getting Started

### Initialization parameters

To initialize BidMachine set your's seller id in MPMoPubConfiguration:

```
MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization: @"AD_UNIT_ID"];
[sdkConfig setNetworkConfiguration:@{@"seller_id" : @"YOUR_SELLER_ID"} forMediationAdapter:@"BidMachineAdapterConfiguration"];
```
### Test mode

To setup test mode in BidMachine add to ***sdkConfig*** @"test_mode" : @"true". You ***sdkConfig*** will be similar to what is shown below:
```
[sdkConfig setNetworkConfiguration:@{@"seller_id" : @"YOUR_SELLER_ID", @"test_mode" : @"true"} forMediationAdapter:@"BidMachineAdapterConfiguration"];
```
### Initialization

Yours implementation of initialization should look like this:
```
 MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization: @"AD_UNIT_ID"];
    [sdkConfig setNetworkConfiguration:@{@"seller_id" : @"1", @"test_mode" : @"true"} forMediationAdapter:@"BidMachineAdapterConfiguration"];
    sdkConfig.loggingLevel = MPLogLevelDebug;
    [[MoPub sharedInstance] grantConsent];
    [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
        NSLog(@"SDK initialization complete");
    }];
```

### Transfer targeting data to BidMachine

If you want to transfer targeting information you can use custom event's property ***localExtras*** which represents dictionary.
Keys for ***localExtras*** are listed below (Banner and Interstitial):

```
@"userId"   --> Vendor-specific ID for the user (NSString)
@"gender"   --> User gender refer to OpenRTB 2.5 spec (kBDMUserGenderMale, kBDMUserGenderFemale, kBDMUserGenderUnknown)
@"yob"      --> User year of birth (NSNumber)
@"keywords" --> Comma separated list of keywords about the app (NSString)
@"bcat"     --> Blocked advertiser categories using the IAB content categories. Refer to List 5.1 (NSArray <NSString *>)
@"badv"     --> Block list of advertisers by their domains (e.g., “ford.com”) (NSArray <NSString *>)
@"bapps"    --> Block list of applications by their platform-specific exchange- independent application identifiers (NSArray <NSString *>)
@"country"  --> User country (NSString)
@"city"     --> User city (NSString)
@"zip"      --> User zip code (NSString)
@"sturl"    --> Store URL (NSURL)
@"stid"     --> Numeric store id identifier (NSString)
@"paid"     --> Paid version of app (NSNumber: 0-free, 1-paid)
```
***localExtras*** for rewarded video custom event should include one more key:
```
@"location" - User's location (CLLocation)
```
### Banners implementation

In the snippet below you can see transfering of local extra data:

```
self.adView = [[MPAdView alloc] initWithAdUnitId:@"AD_UNIT_ID"
                                                size:MOPUB_BANNER_SIZE];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                   self.view.bounds.size.height - MOPUB_BANNER_SIZE.height,
                                   MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    [self.view addSubview:self.adView];
    NSDictionary *localExtras = @{@"coppa": @"true",
                                  @"logging_enabled": @"true",
                                  @"test_mode": @"true",
                                  @"userId": @"user123",
                                  @"gender": @"F",
                                  @"yob": @"2000",
                                  @"keywords": @"Keyword_1,Keyword_2,Keyword_3,Keyword_4",
                                  @"country": @"Russia",
                                  @"city": @"Kirov",
                                  @"zip": @"610000",
                                  @"sturl": @"https://store_url.com",
                                  @"paid": @"true",
                                  @"bcat": @"IAB-1,IAB-3,IAB-5",
                                  @"badv": @"https://domain_1.com,https://domain_2.org",
                                  @"bapps": @"com.test.application_1,com.test.application_2,com.test.application_3",
                                  @"priceFloors": @[@{
                                                        @"id_1": @300.06
                                                        }, @{
                                                        @"id_2": @1000
                                                        },
                                                    @302.006,
                                                    @1002
                                                    ]
                                  };
    [self.adView setLocalExtras:localExtras];
    [self.adView loadAd];
```

But also you can receive extra data from server. It will be sent in (NSDictionary *)***info*** of requests methods and may look like this:

```
{
    "seller_id": "1",
    "coppa": "true",
    "logging_enabled": "true",
    "test_mode": "true",
    "banner_width": "320",
    "userId": "user123",
    "gender": "F",
    "yob": "2000",
    "keywords": "Keyword_1,Keyword_2,Keyword_3,Keyword_4",
    "country": "Russia",
    "city": "Kirov",
    "zip": "610000",
    "sturl": "https://store_url.com",
    "paid": "true",
    "bcat": "IAB-1,IAB-3,IAB-5",
    "badv": "https://domain_1.com,https://domain_2.org",
    "bapps": "com.test.application_1,com.test.application_2,com.test.application_3",
    "priceFloors": [{
            "id_1": 300.06
        }, {
            "id_2": 1000
        },
        302.006,
        1002
    ]
}
```

### Interstitial implementation

With local extra data:

```
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"AD_UNIT_ID"];
    self.interstitial.delegate = self;
    NSDictionary *localExtras = @{@"seller_id": @"1",
                                  @"coppa": @"true",
                                  @"logging_enabled": @"true",
                                  @"test_mode": @"true",
                                  @"ad_content_type": @"All",
                                  @"userId": @"user123",
                                  @"gender": @"F",
                                  @"yob": @"2000",
                                  @"keywords": @"Keyword_1,Keyword_2,Keyword_3,Keyword_4",
                                  @"country": @"Russia",
                                  @"city": @"Kirov",
                                  @"zip": @"610000",
                                  @"sturl": @"https://store_url.com",
                                  @"paid": @"true",
                                  @"bcat": @"IAB-1,IAB-3,IAB-5",
                                  @"badv": @"https://domain_1.com,https://domain_2.org",
                                  @"bapps": @"com.test.application_1,com.test.application_2,com.test.application_3",
                                  @"priceFloors": @[@{
                                                        @"id_1": @300.06
                                                        }, @{
                                                        @"id_2": @1000
                                                        },
                                                    @302.006,
                                                    @1002
                                                    ]
                                  };
    [self.interstitial setLocalExtras:localExtras];
    [self.interstitial loadAd];
```

Servers extra data:

```
{
    "seller_id": "1",
    "coppa": "true",
    "logging_enabled": "true",
    "test_mode": "true",
    "ad_content_type": "All",
    "userId": "user123",
    "gender": "F",
    "yob": "2000",
    "keywords": "Keyword_1,Keyword_2,Keyword_3,Keyword_4",
    "country": "Russia",
    "city": "Kirov",
    "zip": "610000",
    "sturl": "https://store_url.com",
    "paid": "true",
    "bcat": "IAB-1,IAB-3,IAB-5",
    "badv": "https://domain_1.com,https://domain_2.org",
    "bapps": "com.test.application_1,com.test.application_2,com.test.application_3",
    "priceFloors": [{
            "id_1": 300.06
        }, {
            "id_2": 1000
        },
        302.006,
        1002
    ]
}
```

### Rewarded implementation

With local extra data:

```
[MPRewardedVideo setDelegate:self forAdUnitId:@"b94009cbb6b7441eb097142f1cb5e642"];
    NSDictionary *localExtras = @{@"seller_id": @"1",
                                  @"coppa": @"true",
                                  @"logging_enabled": @"true",
                                  @"test_mode": @"true",
                                  @"userId": @"user123",
                                  @"gender": @"F",
                                  @"yob": @"2000",
                                  @"keywords": @"Keyword_1,Keyword_2,Keyword_3,Keyword_4",
                                  @"country": @"Russia",
                                  @"city": @"Kirov",
                                  @"zip": @"610000",
                                  @"sturl": @"https://store_url.com",
                                  @"paid": @"true",
                                  @"bcat": @"IAB-1,IAB-3,IAB-5",
                                  @"badv": @"https://domain_1.com,https://domain_2.org",
                                  @"bapps": @"com.test.application_1,com.test.application_2,com.test.application_3",
                                  @"priceFloors": @[@{
                                                        @"id_1": @300.06
                                                        }, @{
                                                        @"id_2": @1000
                                                        },
                                                    @302.006,
                                                    @1002
                                                    ]
                                  };
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:@"b94009cbb6b7441eb097142f1cb5e642" keywords:nil userDataKeywords:nil location:nil customerId:nil mediationSettings:nil localExtras:localExtras];
    [MPRewardedVideo presentRewardedVideoAdForAdUnitID:@"b94009cbb6b7441eb097142f1cb5e642" fromViewController:self withReward:nil];
```

Extra data from server:

```
{
    "seller_id": "1",
    "coppa": "true",
    "logging_enabled": "true",
    "test_mode": "true",
    "userId": "user123",
    "gender": "F",
    "yob": "2000",
    "keywords": "Keyword_1,Keyword_2,Keyword_3,Keyword_4",
    "country": "Russia",
    "city": "Kirov",
    "zip": "610000",
    "sturl": "https://store_url.com",
    "paid": "true",
    "bcat": "IAB-1,IAB-3,IAB-5",
    "badv": "https://domain_1.com,https://domain_2.org",
    "bapps": "com.test.application_1,com.test.application_2,com.test.application_3",
    "priceFloors": [{
            "id_1": 300.06
        }, {
            "id_2": 1000
        },
        302.006,
        1002
    ]
}
```

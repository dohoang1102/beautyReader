//
//  InAppPurchaseManager.h
//  movieSchool
//  iap manager
//  Created by zhu zhanping on 12-5-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "NotificationConstant.h"

@interface InAppPurchaseManager : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver> {
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
    NSString *productId;//产品ID
    int inAppPurchaseIndex;//cell row
}

@property (nonatomic,retain) NSString *productId;//产品ID
@property (nonatomic) int inAppPurchaseIndex;//cell row

//发送ma购买请求
-(void) reqestProUpgradeProductData;

-(void)loadStore;
-(BOOL)canMakePurchases;
-(void)purchaseProUpgrade;

@end

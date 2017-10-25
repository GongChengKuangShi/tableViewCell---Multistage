//
//  ThreeTreeModel.m
//  TableViewCell多级展开
//
//  Created by xrh on 2017/10/23.
//  Copyright © 2017年 xrh. All rights reserved.
//

#import "ThreeTreeModel.h"

@implementation ThreeTreeModel

- (instancetype)initWithDic:(NSDictionary *)info {
    self = [super init];
    if (self) {
        self.pois = [info objectForKey:@"sub"];
    }
    return self;
}

@end
